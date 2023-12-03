!*==fnxtvd.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE fnxtvd(V1,V2,V3,V4,V5,Zb,Ifn)
   USE c_feercx
   USE c_feerxx
   USE c_names
   USE c_opinv
   USE c_packx
   USE c_system
   USE c_unpakx
   USE c_xmssg
   USE iso_fortran_env
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   REAL , DIMENSION(1) :: V1
   REAL , DIMENSION(1) :: V2
   REAL , DIMENSION(1) :: V3
   REAL , DIMENSION(1) :: V4
   REAL , DIMENSION(1) :: V5
   REAL , DIMENSION(1) :: Zb
   INTEGER :: Ifn
!
! Local variable declarations rewritten by SPAG
!
   REAL(REAL64) :: aii , d , db , dbi , depx , depx2 , dsq , omdepx , opdepx , sd , sdmax
   REAL(REAL64) , DIMENSION(2) :: b
   REAL :: dtmp , tmp , tmx
   INTEGER :: i , ifg , ifv , io , ix , iy , nord1 , sysbuf
   INTEGER , DIMENSION(5) , SAVE :: name
   INTEGER , SAVE :: vddot
   REAL(REAL64) , SAVE :: zero
   EXTERNAL close , conmsg , frbk , frmlt , frsw , gopen , pack , unpack , write
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     THIS ROUTINE IS SAME AS FNXTV EXCEPT IN CERTAIN KEY AREAS THE
!     COMPUTATIONS ARE REINFORCED BY DOUBLE PRECISION OPERATIONS FOR
!     IMPROVED NUMERIC ACCURACY. IT IS INTENED TO BE USED IN THE 60/64
!     BIT WORD MACHINES
!
!     FOR THE 32 BIT WORD MACHINES, USE FNXTVQ.
!
!     IN SOME 60/64 BIT MACHINES, FNXTVD MAY RUN MUCH SLOWER THAN FNXTV
!
!     THIS ROUTINE IS ACTIVATED BY THE EIGR BULKDATA CARD USING THE BCD
!     WORD 'FEER-Q' INSTEAD OF 'FEER' ON THE 3RD FIELD.
!
!     FNXTVD OBTAINS THE REDUCED TRIDIAGONAL MATRIX B WHERE FRBK2
!     PERFORMS THE OPERATIONAL INVERSE.   (QUAD/DOUBLE PREC VERSION)
!
!           T   -
!      B = V  * A  * V
!
!     V1  = SPACE FOR THE PREVIOUS CURRENT TRIAL VECTOR. INITALLY NULL
!     V2  = SPACE FOR THE CURRENT TRIAL VECTOR. INITIALLY A PSEUDO-
!           RANDOM START VECTOR
!     V3,V4,V5 = WORKING SPACES FOR THREE VECTORS
!     IFN = NO. OF TRIAL VECOTRS EXTRACTED. INITIALLY ZERO.
!     SEE FEER FOR DEFINITIONS OF OTHER PARAMETERS. ALSO PROGRAMMER'S
!           MANUAL PP. 4.48-19G THRU I
!
   !>>>>EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(2),Io)
   DATA name/4HFNXT , 4HVD   , 2*4HBEGN , 4HEND /
   DATA vddot , zero/4HVD.  , 0.0D+0/
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     SR5FLE CONTAINS THE REDUCED TRIDIAGONAL ELEMENTS
!
!     SR6FLE CONTAINS THE G VECTORS
!     SR7FLE CONTAINS THE ORTHOGONAL  VECTORS
!     SR8FLE CONTAINS THE CONDITIONED MAA MATRIX
!
         IF ( mcblt(7)<0 ) name(2) = vddot
         name(3) = name(4)
         CALL conmsg(name,3,0)
         iter = iter + 1
         iprc = 2
         incr = 1
         incrp = incr
         itp1 = iprc
         itp2 = iprc
         ifg = mcbrm(1)
         ifv = mcbvec(1)
         depx = dble(epx)
         depx2 = depx**2
         opdepx = 1.0D0 + depx
         omdepx = 1.0D0 - depx
         d = zero
         nord1 = nord - 1
!
!     NORMALIZE START VECTOR
!
         dsq = zero
         IF ( ioptf==1 ) THEN
            DO i = 1 , nord
               dsq = dsq + dble(V2(i)*V2(i))
            ENDDO
         ELSE
            CALL frmlt(mcbsma(1),V2(1),V3(1),V5(1))
            DO i = 1 , nord
               dsq = dsq + dble(V2(i)*V3(i))
            ENDDO
         ENDIF
         dsq = 1.0D+0/dsqrt(dsq)
         tmp = sngl(dsq)
         DO i = 1 , nord
            V2(i) = V2(i)*tmp
         ENDDO
         IF ( northo==0 ) THEN
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     ORTHOGONALIZE WITH PREVIOUS VECTORS
!
         DO i = 1 , nord
            V3(i) = V2(i)
         ENDDO
         spag_nextblock_1 = 2
      CASE (2)
         SPAG_Loop_1_1: DO ix = 1 , 14
            nonul = nonul + 1
            CALL gopen(ifv,Zb(1),rdrew)
            IF ( ioptf==0 ) CALL frmlt(mcbsma(1),V2(1),V3(1),V5(1))
            sdmax = zero
            DO iy = 1 , northo
               ii = 1
               nn = nord
               sd = zero
               CALL unpack(*5,ifv,V5(1))
               DO i = 1 , nord
                  sd = sd + dble(V3(i)*V5(i))
               ENDDO
 5             IF ( dabs(sd)>sdmax ) sdmax = dabs(sd)
               tmp = sngl(sd)
               DO i = 1 , nord
                  V2(i) = V2(i) - tmp*V5(i)
               ENDDO
            ENDDO
            CALL close(ifv,eofnrw)
            dsq = zero
            IF ( ioptf==1 ) THEN
               DO i = 1 , nord1
                  dsq = dsq + dble(V2(i)*V2(i))
               ENDDO
            ELSE
               CALL frmlt(mcbsma(1),V2(1),V3(1),V5(1))
               DO i = 1 , nord1
                  dsq = dsq + dble(V2(i)*V3(i))
               ENDDO
            ENDIF
!
            d = dble(V3(nord))
            IF ( ioptf==1 ) d = dble(V2(nord))
            d = dble(V2(nord))*d
            dtmp = dsq
            dsq = dsq + d
            IF ( dsq<depx2 ) EXIT SPAG_Loop_1_1
            dtmp = dabs(d/dtmp)
            IF ( dtmp>omdepx .AND. dtmp<opdepx ) EXIT SPAG_Loop_1_1
            d = zero
!
            dsq = dsqrt(dsq)
            IF ( l16/=0 ) WRITE (io,99001) ix , sdmax , dsq
99001       FORMAT (11X,'ORTH ITER (IX)',I5,',  MAX PROJ (SDMAX)',1P,D16.8,',  NORMAL FACT (DSQ)',1P,D16.8)
            dsq = 1.0D+0/dsq
            tmp = sngl(dsq)
            DO i = 1 , nord
               V2(i) = V2(i)*tmp
               V3(i) = V2(i)
            ENDDO
            IF ( sdmax<depx ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDDO SPAG_Loop_1_1
         spag_nextblock_1 = 4
      CASE (3)
!
         IF ( Ifn/=0 ) THEN
!
!     CALCULATE OFF DIAGONAL TERM OF B
!
            d = zero
            DO i = 1 , nord
               d = d + dble(V2(i)*V4(i))
            ENDDO
!
!     COMMENTS FROM G.CHAN/UNISYS   1/92
!     WHAT HAPPENS IF D IS NEGATIVE HERE? NEXT LINE WOULD BE ALWAYS TRUE
!
            IF ( d<depx*dabs(aii) ) THEN
               spag_nextblock_1 = 4
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ELSE
!
!     SWEEP START VECTOR FOR ZERO ROOTS
!
            dsq = zero
            IF ( ioptf==1 ) THEN
               CALL frbk(V2(1),V4(1),V3(1),V5(1))
               DO i = 1 , nord
                  dsq = dsq + dble(V3(i)*V3(i))
               ENDDO
            ELSE
               CALL frsw(V2(1),V4(1),V3(1),V5(1))
               CALL frmlt(mcbsma(1),V3(1),V4(1),V5(1))
               DO i = 1 , nord
                  dsq = dsq + dble(V3(i)*V4(i))
               ENDDO
            ENDIF
            dsq = 1.0D+0/dsqrt(dsq)
            tmp = sngl(dsq)
            DO i = 1 , nord
               V2(i) = V3(i)*tmp
            ENDDO
         ENDIF
         CALL gopen(ifg,Zb(1),wrt)
         iip = 1
         nnp = nord
         IF ( ioptf==1 ) THEN
            CALL frbk(V2(1),V4(1),V3(1),V5(1))
            CALL pack(V4(1),ifg,mcbrm(1))
            DO i = 1 , nord
               V4(i) = V3(i)
            ENDDO
         ELSE
            CALL frsw(V2(1),V4(1),V3(1),V5(1))
            CALL frmlt(mcbsma(1),V3(1),V4(1),V5(1))
            CALL pack(V2(1),ifg,mcbrm(1))
         ENDIF
         CALL close(ifg,norew)
!
!     CALCULATE DIAGONAL TERM OF B
!
         aii = zero
         DO i = 1 , nord
            aii = aii + dble(V2(i)*V4(i))
         ENDDO
         tmp = sngl(aii)
         IF ( d==zero ) THEN
            DO i = 1 , nord
               V3(i) = V3(i) - tmp*V2(i)
            ENDDO
         ELSE
            tmx = sngl(d)
            DO i = 1 , nord
               V3(i) = V3(i) - tmp*V2(i) - tmx*V1(i)
            ENDDO
         ENDIF
         db = zero
         IF ( ioptf==1 ) THEN
            DO i = 1 , nord
               db = db + dble(V3(i)*V3(i))
            ENDDO
         ELSE
            CALL frmlt(mcbsma(1),V3(1),V4(1),V5(1))
            DO i = 1 , nord
               db = db + dble(V3(i)*V4(i))
            ENDDO
         ENDIF
         db = dsqrt(db)
         errc = sngl(db)
         b(1) = aii
         b(2) = d
         CALL write(sr5fle,b(1),4,1)
         CALL gopen(ifv,Zb(1),wrt)
         iip = 1
         nnp = nord
         CALL pack(V2(1),ifv,mcbvec(1))
         CALL close(ifv,norew)
         northo = northo + 1
         Ifn = northo - nzero
         IF ( l16/=0 ) WRITE (io,99002) Ifn , mord , aii , db , d
99002    FORMAT (5X,'TRIDIAGONAL ELEMENTS ROW (IFN)',I5,/5X,'MORD =',I5,', AII,DB,D = ',1P,3D16.8)
         IF ( Ifn>=mord ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     IF NULL VECTOR GENERATED, RETURN TO OBTAIN A NEW SEED VECTOR
!
         IF ( db<depx*dabs(aii) ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     A GOOD VECTOR IN V2. MOVE IT INTO 'PREVIOUS' VECTOR SPACE V1,
!     NORMALIZE V3 AND V2. LOOP BACK FOR MORE VECTORS.
!
         dbi = 1.0D+0/db
         tmp = sngl(dbi)
         DO i = 1 , nord
            V1(i) = V2(i)
            V3(i) = V3(i)*tmp
            V2(i) = V3(i)
         ENDDO
         spag_nextblock_1 = 2
      CASE (4)
!
         mord = Ifn
         WRITE (io,99003) uwm , mord
!
99003    FORMAT (A23,' 2387, PROBLEM SIZE REDUCED TO',I5,' DUE TO -',/5X,'ORTHOGONALITY DRIFT OR NULL TRIAL VECTOR',/5X,            &
                &'ALL EXISTING MODES MAY HAVE BEEN OBTAINED.  USE DIAG 16',' TO DETERMINE ERROR BOUNDS',/)
         spag_nextblock_1 = 5
      CASE (5)
!
         name(3) = name(5)
         CALL conmsg(name,3,0)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE fnxtvd