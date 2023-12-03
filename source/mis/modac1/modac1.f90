!*==modac1.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE modac1(Casecc,Tol,Tol1,Casezz,Caseyy)
   USE c_modac3
   USE c_system
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Casecc
   INTEGER :: Tol
   INTEGER :: Tol1
   INTEGER :: Casezz
   INTEGER :: Caseyy
!
! Local variable declarations rewritten by SPAG
!
   REAL :: diff , diff1 , r , real
   INTEGER :: file , flag , i , ibuf1 , ibuf2 , ibuf3 , icc , ifrout , ifset , ilist , ilsym , ip1 , isetf , isetnf , ivec , ix ,   &
            & j , k , lw , m , n , nlist , nsetf , nzx
   INTEGER , DIMENSION(6) :: ibuf
   INTEGER , DIMENSION(2) :: ihd
   INTEGER , DIMENSION(7) :: mcb
   INTEGER , DIMENSION(2) , SAVE :: name
   REAL , DIMENSION(1) :: z
   EXTERNAL close , fname , fwdrec , gopen , mesage , open , rdtrl , read , write , wrttrl
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     MODAC1 REDUCES THE NUMBER OF ENTRIES ON TOL TO THE TIMES
!         SPECIFIED BY THE OFREQ SET IN CASECC
!
!     CORE IS        OUT AS FOLLOWS ON RETURN
!
!         CONTENTS            LENGTH  TYPE   POINTER
!         --------            ------  ----   -------
!         NEW TIMES           NFN      R     IFN
!         KEEP REMOVE         NFO      I     IKR
!
!
!
!
!
!
!
!
!
!
!
!
!
   !>>>>EQUIVALENCE (Z(1),Iz(1))
   DATA name/4HMODA , 4HC1  /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     BRING  IN  CASECC
!
         lw = 6
         IF ( id==4 ) lw = 7
         ibuf1 = nz - sysbuf + 1
         ibuf2 = ibuf1 - sysbuf
         ibuf3 = ibuf2 - sysbuf
         CALL gopen(Casecc,iz(ibuf1),0)
         file = Casecc
         CALL read(*140,*20,Casecc,iz,ibuf2-1,0,ivec)
         CALL mesage(-8,0,name)
 20      icc = 0
         CALL close(Casecc,1)
         ifrout = 145
         ilsym = 200
         ivec = ivec + 1
         ilist = ivec
         IF ( id==5 ) THEN
!
!     STATIC ANALYSIS
!
            r = 1.0
            nfo = nfo + ilist
            nlist = nfo - 2
            DO i = ilist , nfo , 2
               z(i) = r
               iz(i+1) = 0
               r = r + 1.
            ENDDO
!
!     COPY EDT
!
            CALL open(*60,Tol,iz(ibuf1),0)
            CALL open(*60,Tol1,iz(ibuf2),1)
            file = Tol
            CALL fname(Tol1,ihd)
            CALL write(Tol1,ihd,2,0)
            DO
               CALL read(*120,*180,Tol,iz(nfo+2),nz,0,flag)
               CALL write(Tol1,iz(nfo+2),flag,1)
            ENDDO
         ELSE
!
!     BRING IN OLD TIME/FREQ  LIST
!
            file = Tol
            CALL open(*140,Tol,iz(ibuf1),0)
            i = ilist
            m = 3
            ix = 2
            nfo = nfo + i
            IF ( id==2 .OR. id==4 ) THEN
               CALL fwdrec(*160,Tol)
               CALL fwdrec(*160,Tol)
               SPAG_Loop_1_1: DO
                  CALL read(*160,*40,Tol,ibuf,lw,0,flag)
                  iz(i) = ibuf(4)
!     REIG SHOULD BE ON CYCLES
                  IF ( id==4 ) iz(i) = ibuf(5)
                  iz(i+1) = 0
                  i = i + 2
                  IF ( i==nfo ) EXIT SPAG_Loop_1_1
               ENDDO SPAG_Loop_1_1
            ELSE
               DO
                  CALL read(*160,*40,Tol,ibuf,m,0,flag)
                  iz(i) = ibuf(m)
                  iz(i+1) = 0
                  i = i + ix
                  m = 1
               ENDDO
            ENDIF
         ENDIF
 40      CALL close(Tol,1)
         nlist = i - ix
!
!     MATCH LIST OF  SELECTED VALUES WITH TIME LIST IN CORE
!
 60      ix = icc + ifrout
         ifset = iz(ix)
         IF ( ifset>0 ) THEN
            ix = icc + ilsym
            isetnf = ix + iz(ix) + 1
            SPAG_Loop_1_2: DO
               isetf = isetnf + 2
               nsetf = iz(isetnf+1) + isetf - 1
               IF ( iz(isetnf)==ifset ) THEN
                  DO i = isetf , nsetf
                     k = 0
                     diff = 1.E25
                     real = z(i)
                     DO j = ilist , nlist , 2
                        IF ( iz(j+1)==0 ) THEN
                           diff1 = abs(z(j)-real)
                           IF ( diff1<diff ) THEN
                              diff = diff1
                              k = j
                           ENDIF
                        ENDIF
                     ENDDO
                     IF ( k/=0 ) iz(k+1) = 1
                  ENDDO
                  spag_nextblock_1 = 2
                  CYCLE SPAG_DispatchLoop_1
               ELSE
                  isetnf = nsetf + 1
                  IF ( isetnf>=ivec ) THEN
                     ifset = -1
                     EXIT SPAG_Loop_1_2
                  ENDIF
               ENDIF
            ENDDO SPAG_Loop_1_2
         ENDIF
         DO j = ilist , nlist , 2
            iz(j+1) = 1
         ENDDO
         spag_nextblock_1 = 2
      CASE (2)
!
!     SELECTED FREQUENCIES MARKED FOR OUTPUT
!
         nfo = (nlist-ilist+2)/2
!
!     MOVE NEW FREQ  TO UPPER
!
         k = 1
         DO i = ilist , nlist , 2
            IF ( iz(i+1)/=0 ) THEN
               z(k) = z(i)
               k = k + 1
            ENDIF
         ENDDO
         nfn = k - 1
         DO i = ilist , nlist , 2
            iz(k) = iz(i+1)
            k = k + 1
         ENDDO
         IF ( id==5 ) RETURN
         file = Tol1
         CALL open(*80,Tol1,iz(ibuf1),1)
         CALL fname(Tol1,ihd)
         CALL write(Tol1,ihd,2,0)
         IF ( id==2 .OR. id==4 ) THEN
!
!     COPY OVER CLAMA STUFF
!
            CALL write(Tol1,0,0,1)
            k = nfn + nfo + 1
            nzx = ibuf3 - k
            file = Tol
            CALL gopen(Tol,iz(ibuf2),0)
            CALL read(*160,*180,Tol,iz(k),146,1,flag)
            CALL write(Tol1,iz(k),146,1)
            m = nfn + 1
            n = m + nfo - 1
            DO i = m , n
               CALL read(*160,*180,Tol,iz(k),lw,0,flag)
               IF ( iz(i)/=0 ) CALL write(Tol1,iz(k),lw,0)
            ENDDO
            CALL close(Tol,1)
            CALL write(Tol1,0,0,1)
         ELSE
            CALL write(Tol1,z,nfn,1)
         ENDIF
         CALL close(Tol1,1)
         mcb(1) = Tol1
         mcb(2) = nfn
         CALL wrttrl(mcb)
         IF ( id==2 ) THEN
!
!      COPY OVER CASECC
!
            CALL gopen(Casecc,iz(ibuf1),0)
            CALL gopen(Casezz,iz(ibuf2),1)
            m = nfn + 1
            n = m + nfo - 1
            DO i = m , n
               CALL read(*100,*65,Casecc,iz(k),nzx,0,flag)
 65            IF ( iz(i)/=0 ) CALL write(Casezz,iz(k),flag,1)
            ENDDO
            GOTO 100
         ENDIF
 80      RETURN
 100     CALL close(Casecc,1)
         CALL close(Casezz,1)
         mcb(1) = Casecc
         CALL rdtrl(mcb)
         mcb(1) = Casezz
         CALL wrttrl(mcb)
         RETURN
 120     CALL close(Tol,1)
         CALL close(Tol1,1)
         mcb(1) = Tol
         CALL rdtrl(mcb)
         mcb(1) = Tol1
         CALL wrttrl(mcb)
         GOTO 60
!
!     ERROR MESSAGES
!
 140     ip1 = -1
         spag_nextblock_1 = 3
      CASE (3)
         CALL mesage(ip1,file,name)
 160     ip1 = -2
         spag_nextblock_1 = 3
         CYCLE SPAG_DispatchLoop_1
 180     ip1 = -3
         spag_nextblock_1 = 3
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE modac1