
SUBROUTINE fbs4(Block,Y,Yn,Nwds)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Dbl , N , Nout
   DOUBLE PRECISION L(1)
   CHARACTER*25 Sfm , Uwm
   REAL Sysbuf
   CHARACTER*23 Ufm
   CHARACTER*29 Uim
   COMMON /fbsx  / Dbl , N
   COMMON /system/ Sysbuf , Nout
   COMMON /xmssg / Ufm , Uwm , Uim , Sfm
   COMMON /zzzzzz/ L
!
! Dummy argument declarations
!
   INTEGER Nwds
   INTEGER Block(8)
   DOUBLE PRECISION Y(1) , Yn(1)
!
! Local variable declarations
!
   INTEGER begn , buf(2) , end , ii , ij , ik , j , j1 , ji , jk , jstr , k , last , nbritm , nstr , nterms , subnam
   DOUBLE PRECISION ljji , ljjr , ssqr , sum1 , sum2 , yjki , yjkr , zero
   INTEGER locfx
!
! End of declarations
!
!
!     FBS4 EXECUTES THE FORWARD/BACKWARD PASS FOR FBSF IN CDP
!
   EQUIVALENCE (sum1,yjkr) , (sum2,yjki)
   DATA subnam , begn , end/4HFBS4 , 4HBEGN , 4HEND /
   DATA zero/0.0D+0/
!
   buf(1) = subnam
   buf(2) = begn
   CALL conmsg(buf,2,0)
   nbritm = Nwds/2
   j = (locfx(Yn)-locfx(Y)+1)/Nwds
   last = max0(j,1)*nbritm
   DO j = 1 , N
      j1 = j - 1
      DO k = 1 , last , nbritm
         yjkr = Y(j1*2+k)
         yjki = Y(j1*2+k+1)
         IF ( yjkr/=zero .OR. yjki/=zero ) GOTO 50
      ENDDO
      CALL skprec(Block(1),1)
      CYCLE
!
!     MAKE 1ST CALL FOR COLUMN AND SAVE DIAGONAL ELEMENT
!
 50   Block(8) = -1
      CALL getstr(*600,Block)
      IF ( Block(4)/=j ) GOTO 600
      jstr = Block(5)
      ljjr = L(jstr)
      ljji = L(jstr+1)
      IF ( Block(6)==1 ) GOTO 150
      nstr = jstr + 2*Block(6) - 2
      jstr = jstr + 2
      Block(4) = Block(4) + 1
!
!     PROCESS CURRENT STRING IN TRIANGULAR FACTOR AGAINST EACH
!     LOAD VECTOR IN CORE -- Y(I,K) = Y(I,K) + L(I,J)*Y(J,K)
!
 100  DO k = 1 , last , nbritm
         yjkr = Y(j1*2+k)
         yjki = Y(j1*2+k+1)
         IF ( yjkr/=zero .OR. yjki/=zero ) THEN
            ik = 2*Block(4) + k - 2
            DO ij = jstr , nstr , 2
               Y(ik) = Y(ik) + L(ij)*yjkr - L(ij+1)*yjki
               Y(ik+1) = Y(ik+1) + L(ij)*yjki + L(ij+1)*yjkr
               ik = ik + 2
            ENDDO
         ENDIF
      ENDDO
!
!     GET NEXT STRING IN TRIANGULAR FACTOR
!
 150  CALL endget(Block)
      CALL getstr(*200,Block)
      jstr = Block(5)
      nstr = jstr + 2*Block(6) - 2
      GOTO 100
!
!     END-OF-COLUMN ON TRIANGULAR FACTOR -- DIVIDE BY DIAGONAL
!
 200  ssqr = 1.0D+0/(ljjr**2+ljji**2)
      DO k = 1 , last , nbritm
         yjkr = (Y(2*j+k-2)*ljjr+Y(2*j+k-1)*ljji)*ssqr
         Y(2*j+k-1) = -(Y(2*j+k-2)*ljji-Y(2*j+k-1)*ljjr)*ssqr
         Y(2*j+k-2) = yjkr
      ENDDO
!
   ENDDO
!
!     INITIALIZE FOR BACKWARD PASS BY SKIPPING THE NTH COLUMN
!
   IF ( N==1 ) GOTO 500
   CALL bckrec(Block)
   j = N - 1
!
!     GET A STRING IN CURRENT COLUMN.  IF STRING INCLUDES DIAGONAL,
!     ADJUST STRING TO SKIP IT.
!
 300  j1 = j - 1
   Block(8) = -1
   DO
      CALL getstb(*400,Block)
      IF ( Block(4)-Block(6)==j1 ) Block(6) = Block(6) - 1
      IF ( Block(6)/=0 ) THEN
         nterms = Block(6)
!
!     PROCESS CURRENT STRING IN TRIANGULAR FACTOR AGAINST EACH
!     LOAD VECTOR IN CORE -- Y(J,K) = Y(J,K) + L(J,I)*Y(I,K)
!
         DO k = 1 , last , nbritm
            ji = Block(5) + 2
            ik = Block(4)*2 + k
            jk = j1*2 + k
            sum1 = 0.0D+0
            sum2 = 0.0D+0
            DO ii = 1 , nterms
               ji = ji - 2
               ik = ik - 2
               sum1 = sum1 + L(ji)*Y(ik) - L(ji+1)*Y(ik+1)
               sum2 = sum2 + L(ji)*Y(ik+1) + L(ji+1)*Y(ik)
            ENDDO
            Y(jk) = Y(jk) + sum1
            Y(jk+1) = Y(jk+1) + sum2
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
 400  IF ( j/=1 ) THEN
!
      j = j - 1
      GOTO 300
   ENDIF
 500  buf(2) = end
   CALL conmsg(buf,2,0)
   RETURN
!
!     FATAL ERROR MESSAGE
!
 600  WRITE (Nout,99001) Sfm , subnam
99001 FORMAT (A25,' 2149, SUBROUTINE ',A4,/5X,'FIRST ELEMENT OF A COLU','MN OF LOWER TRIANGULAR MATRIX IS NOT THE DIAGONAL ELEMENT')
   CALL mesage(-61,0,0)
END SUBROUTINE fbs4
