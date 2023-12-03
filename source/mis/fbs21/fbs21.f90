!*==fbs21.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE fbs21(Block,Y,Yn,Nwds)
   USE c_fbsx
   USE c_system
   USE c_xmssg
   USE c_zzzzzz
   USE iso_fortran_env
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER , DIMENSION(20) :: Block
   REAL , DIMENSION(1) :: Y
   REAL , DIMENSION(1) :: Yn
   INTEGER :: Nwds
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , SAVE :: begn , end
   INTEGER , DIMENSION(3) :: buf
   INTEGER :: ii , ij , ik , j , ji , jk , jstr , k , last , nbritm , nbrvec , nstr , nterms
   REAL(REAL64) :: ljj
   INTEGER , DIMENSION(2) , SAVE :: subnam
   REAL :: xlij , xljj , yjk
   EXTERNAL bckrec , conmsg , endget , endgtb , getstb , getstr , locfx , mesage
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
!
!     FBS2 EXECUTES THE FORWARD/BACKWARD PASS FOR FBS IN RSP
!                                                        ===
!
   DATA subnam , begn , end/4HFBS2 , 4H1    , 4HBEGN , 4HEND /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
         buf(1) = subnam(1)
         buf(2) = subnam(2)
         buf(3) = begn
         CALL conmsg(buf,3,0)
         nbritm = Nwds/2
         nbrvec = (locfx(Yn)-locfx(Y))/Nwds + 1
         last = 1 + (nbrvec-1)*nbritm
         DO j = 1 , n
            spag_nextblock_2 = 1
            SPAG_DispatchLoop_2: DO
               SELECT CASE (spag_nextblock_2)
               CASE (1)
!
!     MAKE 1ST STRING CALL FOR COLUMN AND SAVE DIAGONAL ELEMENT
!
                  Block(8) = -1
                  CALL getstr(*40,Block)
                  IF ( Block(4)/=j ) GOTO 40
                  jstr = Block(5)
                  ljj = l(jstr)
!WKBI
                  xljj = ljj
                  IF ( Block(6)==1 ) THEN
                     spag_nextblock_2 = 3
                     CYCLE SPAG_DispatchLoop_2
                  ENDIF
                  nstr = jstr + Block(6) - 1
                  jstr = jstr + 1
                  Block(4) = Block(4) + 1
                  spag_nextblock_2 = 2
               CASE (2)
!
!     PROCESS CURRENT STRING IN TRIANGULAR FACTOR AGAINST EACH
!     LOAD VECTOR IN CORE -- Y(I,K) = Y(I,K) + L(I,J)*Y(J,K)
!
                  DO k = 1 , last , nbritm
                     yjk = Y(j+k-1)
                     ik = Block(4) + k - 1
                     DO ij = jstr , nstr
!WKBI
                        xlij = l(ij)
!WKBR Y(IK) = Y(IK) + L(IJ)*YJK
                        Y(ik) = Y(ik) + xlij*yjk
                        ik = ik + 1
                     ENDDO
                  ENDDO
                  spag_nextblock_2 = 3
               CASE (3)
!
!     GET NEXT STRING IN TRIANGULAR FACTOR
!
                  CALL endget(Block)
                  CALL getstr(*2,Block)
                  jstr = Block(5)
                  nstr = jstr + Block(6) - 1
                  spag_nextblock_2 = 2
                  CYCLE SPAG_DispatchLoop_2
!
!     END-OF-COLUMN ON TRIANGULAR FACTOR -- DIVIDE BY DIAGONAL
!
 2                DO k = 1 , last , nbritm
!WKBR Y(J+K-1) = Y(J+K-1)/LJJ
                     Y(j+k-1) = Y(j+k-1)/xljj
                  ENDDO
                  EXIT SPAG_DispatchLoop_2
               END SELECT
            ENDDO SPAG_DispatchLoop_2
         ENDDO
!
!     INITIALIZE FOR BACKWARD PASS BY SKIPPING THE NTH COLUMN
!
         IF ( n==1 ) THEN
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         CALL bckrec(Block)
         j = n - 1
!
!     GET A STRING IN CURRENT COLUMN. IF STRING INCLUDES DIAGONAL,
!     ADJUST STRING TO SKIP IT.
!
         Block(8) = -1
         spag_nextblock_1 = 2
      CASE (2)
         DO
            CALL getstb(*20,Block)
            IF ( Block(4)-Block(6)+1==j ) Block(6) = Block(6) - 1
            IF ( Block(6)/=0 ) THEN
               nterms = Block(6)
!
!     PROCESS CURRENT STRING IN TRIANGULAR FACTOR AGAINST EACH
!     LOAD VECTOR IN CORE -- Y(J,K) = Y(J,K) + L(J,I)*Y(I,K)
!
               DO k = 1 , last , nbritm
                  ji = Block(5)
                  ik = Block(4) + k - 1
                  jk = j + k - 1
                  DO ii = 1 , nterms
                     Y(jk) = Y(jk) + l(ji)*Y(ik)
                     ji = ji - 1
                     ik = ik - 1
                  ENDDO
               ENDDO
            ENDIF
!
!     TERMINATE CURRENT STRING AND GET NEXT STRING
!
            CALL endgtb(Block)
         ENDDO
!
!     END-OF-COLUMN -- TEST FOR COMPLETION
!
 20      IF ( j/=1 ) THEN
!
            j = j - 1
            Block(8) = -1
            spag_nextblock_1 = 2
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         spag_nextblock_1 = 3
      CASE (3)
         buf(3) = end
         CALL conmsg(buf,3,0)
         RETURN
!
!     FATAL ERROR MESSAGE
!
 40      WRITE (nout,99001) sfm , subnam
99001    FORMAT (A25,' 2149, SUBROUTINE ',2A4,/5X,'FIRST ELEMENT OF A COL',                                                         &
                &'UMN OF LOWER TRIANGULAR MATRIX IS NOT THE DIAGONAL ELEMENT')
         CALL mesage(-61,0,0)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE fbs21