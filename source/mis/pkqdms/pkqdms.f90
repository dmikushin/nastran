!*==pkqdms.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE pkqdms
   IMPLICIT NONE
   USE c_condas
   USE c_matin
   USE c_pla42c
   USE c_pla42d
   USE c_pla4es
!
! Local variable declarations rewritten by SPAG
!
   REAL :: angl , degra
   INTEGER :: i , j , jnot , k , npt1 , npt2 , npt3
   REAL*8 , DIMENSION(27) :: k3x3
   INTEGER , DIMENSION(12) , SAVE :: m
   INTEGER , DIMENSION(5) :: necpt
!
! End of declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
! THIS SUBROUTINE CALCULATES AND SHIPS TO PLA4B THE STIFFNESS MATRIX FOR
! PLA4
!     *** QUADRILATERAL MEMBRANE SUBROUTINE ***
!
!     CALLS FROM THIS ROUTINE ARE MADE TO THE FOLLOWING
!
!                 PKTRMS - TRIANGULAR MEMBRANE SUBROUTINE
!                 PLA4B  - INSERTION ROUTINE
!                MESAGE - ERROR MESSAGE WRITER
!
!
!
!
   !>>>>EQUIVALENCE (Consts(4),Degra)
   !>>>>EQUIVALENCE (K3x3(1),Kij(1)) , (Necpt(1),Ecpt(1))
!
   DATA m/1 , 2 , 4 , 2 , 3 , 1 , 3 , 4 , 2 , 4 , 1 , 3/
!     ******************************************************************
!          ECPT                       ECPT
!       RECEIVED BY                REQUIRED BY
!         KQDMEM                     KTRMEM
!     ******************************************************************
!     ECPT( 1) = EL. ID          ECPT( 1) = EL. ID
!     ECPT( 2) = GRD. PT. A      ECPT( 2) = GRD. PT. A
!     ECPT( 3) = GRD. PT. B      ECPT( 3) = GRD. PT. B
!     ECPT( 4) = GRD. PT. C      ECPT( 4) = GRD. PT. C
!     ECPT( 5) = GRD. PT. D      ECPT( 5) = THETA
!     ECPT( 6) = THETA           ECPT( 6) = MATERIAL ID
!     ECPT( 7) = MATERIAL ID     ECPT( 7) = T
!     ECPT( 8) = T               ECPT( 8) = NON-STRUCT. MASS
!     ECPT( 9) = NON-STRUCT. MASSECPT( 9) = COORD. SYS. ID 1
!     ECPT(10) = COORD. SYS. ID 1ECPT(10) = X1
!     ECPT(11) = X1              ECPT(11) = Y1
!     ECPT(12) = Y1              ECPT(12) = Z1
!     ECPT(13) = Z1              ECPT(13) = COORD. SYS. ID 2
!     ECPT(14) = COORD. SYS. ID 2ECPT(14) = X2
!     ECPT(15) = X2              ECPT(15) = Y2
!     ECPT(16) = Y2              ECPT(16) = Z2
!     ECPT(17) = Z2              ECPT(17) = COORD. SYS. ID 3
!     ECPT(18) = COORD. SYS. ID 3ECPT(18) = X3
!     ECPT(19) = X3              ECPT(19) = Y3
!     ECPT(20) = Y3              ECPT(20) = Z3
!     ECPT(21) = Z3              ECPT(21) = ELEMENT TEMPERATURE
!     ECPT(22) = COORD. SYS. ID 4    NOTE. THE FOLLOWING ARE INTEGERS...
!     ECPT(23) = X4                  GRID POINTS, MAT ID, EL.ID,
!     ECPT(24) = Y4                  COORD. SYS. IDS.
!     ECPT(25) = Z4                  ALL OTHERS ARE REAL IN THE ECPT.
!     ECPT(26) = ELEMENT TEMPERATURE
!     ******************************************************************
!
!     THE FOLLOWING COMPUTATION IS PERFORMED FOR USE WITH THE
!     COMPUTATION OF SINTH AND COSTH BELOW (ANISOTROPIC MATERIAL
!     POSSIBILITY)  NOTE  FMMS-46 PAGE -9-
!
   angl = ecpt(6)*degra
   cosang = cos(angl)
   sinang = sin(angl)
   ivec(1) = ecpt(15) - ecpt(11)
   ivec(2) = ecpt(16) - ecpt(12)
   ivec(3) = ecpt(17) - ecpt(13)
   vecl = sqrt(ivec(1)**2+ivec(2)**2+ivec(3)**2)
   IF ( vecl/=0.0E0 ) THEN
      ivec(1) = ivec(1)/vecl
      ivec(2) = ivec(2)/vecl
      ivec(3) = ivec(3)/vecl
      vsubk(1) = ivec(2)*(ecpt(25)-ecpt(13)) - ivec(3)*(ecpt(24)-ecpt(12))
      vsubk(2) = ivec(3)*(ecpt(23)-ecpt(11)) - ivec(1)*(ecpt(25)-ecpt(13))
      vsubk(3) = ivec(1)*(ecpt(24)-ecpt(12)) - ivec(2)*(ecpt(23)-ecpt(11))
      vecl = sqrt(vsubk(1)**2+vsubk(2)**2+vsubk(3)**2)
      IF ( vecl/=0.0E0 ) THEN
         kvec(1) = vsubk(1)/vecl
         kvec(2) = vsubk(2)/vecl
         kvec(3) = vsubk(3)/vecl
         jvec(1) = kvec(2)*ivec(3) - kvec(3)*ivec(2)
         jvec(2) = kvec(3)*ivec(1) - kvec(1)*ivec(3)
         jvec(3) = kvec(1)*ivec(2) - kvec(2)*ivec(1)
         DO i = 1 , 3
            pvec(i) = cosang*ivec(i) + sinang*jvec(i)
         ENDDO
!
!
!     SAVE COORDINATE SYSTEMS AND GRID POINT SIL NUMBERS
!
         ngrid(1) = necpt(2)
         ngrid(2) = necpt(3)
         ngrid(3) = necpt(4)
         ngrid(4) = necpt(5)
         DO i = 1 , 16
            coord(i) = ecpt(i+9)
         ENDDO
!
!     NOTE. COORD 1, 5, 9, AND 13  ARE INTEGER CSID NUMBERS.
!
!     CORRECT ECPT FOR MEMBRANE USE
         ecpt(5) = ecpt(6)
         ecpt(6) = ecpt(7)
         ecpt(7) = ecpt(8)/2.0E0
         ecpt(8) = ecpt(9)
!
!     FOR EACH TRIANGLE THEN THE THREE GRID POINTS AND COORDINATES
!     ARE INSERTED INTO THE ECPT BEFORE THE CALL TO KTRMEM.
!
!     FILL MAP MATRIX  (PERFORMED IN DATA STATEMENT - DO NOT ALTER)
!              A              B              C
!           M1 = 1         M2 = 2         M3 = 4      (TRIANGLE    I)
!
!           M4 = 2         M5 = 3         M6 = 1      (TRIANGLE   II)
!
!           M7 = 3         M8 = 4         M9 = 2      (TRIANGLE  III)
!
!           M10= 4         M11= 1         M12= 3      (TRIANGLE   IV)
!
!     ******************************************************************
!     FIND WHICH POINT IS THE PIVOT POINT.
         DO i = 1 , 4
            IF ( npvt==ngrid(i) ) THEN
               npivot = i
               GOTO 20
            ENDIF
         ENDDO
!
!     FALL THRU ABOVE LOOP IMPLIES AN ERROR CONDITION.
!
         CALL mesage(-30,34,ecpt(1))
!
!     COMPUTE JNOT WHICH EQUALS THE ONE TRIANGLE OF THE FOUR NOT USED
!     AND THUS NOT COMPUTED FOR THE PIVOT POINT IN QUESTION.  (NOTE THE
!     ROWS OF THE MAPPING MATRIX ABOVE AND THE TRIANGLE NUMBERS)
!
 20      IF ( npivot<=2 ) THEN
            jnot = npivot + 2
         ELSE
            jnot = npivot - 2
         ENDIF
!
!     ZERO OUT KSUM FOR 36
         DO i = 1 , 36
            ksum(i) = 0.0D0
         ENDDO
!
         DO j = 1 , 4
            IF ( j/=jnot ) THEN
!
!     FILL IN ECPT FOR TRIANGLE J
               mpoint = 3*j - 3
               DO i = 1 , 3
                  npt1 = mpoint + i
                  nsubsc = m(npt1)
                  necpt(i+1) = ngrid(nsubsc)
!
                  npt1 = 4*nsubsc - 4
                  DO k = 1 , 4
                     npt2 = npt1 + k
                     npt3 = 4*i + 4 + k
                     ecpt(npt3) = coord(npt2)
                  ENDDO
               ENDDO
!
!     ECPT IS COMPLETE FOR TRIANGLE J
!
!     SET UP SINTH AND COSTH FOR THIS SUB TRIANGLE
!
               IF ( j/=1 ) THEN
!
!     NOTE FMMS-46 PAGE-9 FOR FOLLOWING
!
                  v(1) = ecpt(14) - ecpt(10)
                  v(2) = ecpt(15) - ecpt(11)
                  v(3) = ecpt(16) - ecpt(12)
                  vecl = sqrt(v(1)**2+v(2)**2+v(3)**2)
                  IF ( vecl==0.0E0 ) GOTO 100
                  u1 = (v(1)*pvec(1)+v(2)*pvec(2)+v(3)*pvec(3))/vecl
                  si(1) = v(2)*pvec(3) - v(3)*pvec(2)
                  si(2) = v(3)*pvec(1) - v(1)*pvec(3)
                  si(3) = v(1)*pvec(2) - v(2)*pvec(1)
                  u2 = (si(1)*kvec(1)+si(2)*kvec(2)+si(3)*kvec(3))/vecl
                  vecl = sqrt(u1**2+u2**2)
                  IF ( vecl==0.0E0 ) GOTO 100
                  u1 = u1/vecl
                  u2 = u2/vecl
                  sinth = sinang*u1 - cosang*u2
                  costh = cosang*u1 + sinang*u2
               ELSE
                  sinth = sinang
                  costh = cosang
               ENDIF
               IF ( abs(sinth)<1.0E-06 ) sinth = 0.0E0
!
               CALL pktrms(1)
!
!     RETURNING FROM PKTRMS THE 3 3X3 ARRAYS FOR THE PIVOT ARE STORED IN
!     COMMON UNDER THE NAME   K3X3(27)
!
!     NOW ADD THE 3 3X3 ARRAYS INTO THE 4 3X3 ARRAYS OF KSUM
!
               DO i = 1 , 3
                  npt1 = 9*i - 9
!     NPT1   POINTS TO THE ZERO POSITION OF THE I-TH K3X3.
!     MPOINT POINTS TO THE ZERO POSITION OF THE J-TH ROW OF MAP MATRIX
!
                  mi = mpoint + i
                  npt2 = 9*m(mi) - 9
!     NPT2 NOW POINTS TO THE ZERO POSITION OF THE  M(MI) TH  SUM MATRIX
!
                  DO k = 1 , 9
                     npt3 = npt2 + k
                     mi = npt1 + k
                     ksum(npt3) = ksum(npt3) + k3x3(mi)
                  ENDDO
               ENDDO
            ENDIF
!
         ENDDO
!
!     ******************************************************************
!
!     NOW INSERT EACH OF THE 4-KSUM (3X3) MATRICES INTO A 6X6 AND
!     SHIP TO PLA4B
!
         DO i = 1 , 36
            kij(i) = 0.0D0
         ENDDO
!
         DO j = 1 , 4
            mpoint = 9*j - 9
!     MPOINT POINTS TO THE ZERO POSITION OF THE J-TH KSUM 3X3.
            kij(1) = ksum(mpoint+1)
            kij(2) = ksum(mpoint+2)
            kij(3) = ksum(mpoint+3)
            kij(7) = ksum(mpoint+4)
            kij(8) = ksum(mpoint+5)
            kij(9) = ksum(mpoint+6)
            kij(13) = ksum(mpoint+7)
            kij(14) = ksum(mpoint+8)
            kij(15) = ksum(mpoint+9)
!
!     SHIP TO PLA4B
            CALL pla4b(kij(1),ngrid(j))
!
         ENDDO
!
         RETURN
      ENDIF
   ENDIF
 100  CALL mesage(30,26,ecpt(1))
!
!  SET FLAG FOR FATAL ERROR WHILE ALLOWING ERROR MESSAGES TO ACCUMULATE
!
   nogo = 1
END SUBROUTINE pkqdms
