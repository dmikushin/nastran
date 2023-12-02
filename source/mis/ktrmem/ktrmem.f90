!*==ktrmem.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE ktrmem(Ntype)
   IMPLICIT NONE
   USE c_condas
   USE c_hmtout
   USE c_matin
   USE c_matout
   USE c_sma1cl
   USE c_sma1dp
   USE c_sma1et
   USE c_sma1ht
   USE c_sma1io
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Ntype
!
! Local variable declarations rewritten by SPAG
!
   REAL :: degra
   REAL , DIMENSION(21) :: ecpt
   REAL*8 , DIMENSION(9) :: g
   INTEGER :: i , j , k , n1 , n2 , ncom , npt1 , npt2
   INTEGER , DIMENSION(6) :: necpt
   REAL*8 , DIMENSION(2) :: tt
!
! End of declarations rewritten by SPAG
!
!
! Dummy argument declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     TRIANGULAR MEMBRANE ELEMENT
!
!     IF NTYPE = 0 COMPLETE MEMBRANE COMPUTATION IS PERFORMED
!     IF NTYPE = 1 RETURN 3 TRANSFORMED  3X3 MATRICES ONLY FOR THE PIVOT
!
!     CALLS FROM THIS ROUTINE ARE MADE TO -
!
!     MAT    - MATERIAL DATA ROUTINE
!     SMA1B  - INSERTION ROUTINE
!     TRANSD - DOUBLE PRECISION TRANSFORMATION SUPPLIER
!     GMMATD - DOUBLE PRECISION MATRIX MULTIPLY AND TRANSPOSE
!     MESAGE - ERROR MESSAGE WRITER
!
   !>>>>EQUIVALENCE (Consts(4),Degra) , (G(1),Tempar(19)) , (Ecpt(1),Mecpt(1),Necpt(1))
!
!     ECPT LIST
!                                                      THIS
!     ECPT       DESCRIPTION                         ROUTINE    TYPE
!     ======================================         ========  =======
!     ECPT( 1) = ELEMENT ID                          NECPT(1)  INTEGER
!     ECPT( 2) = GRID POINT A                        NGRID(1)  INTEGER
!     ECPT( 3) = GRID POINT B                        NGRID(2)  INTEGER
!     ECPT( 4) = GRID POINT C                        NGRID(3)  INTEGER
!     ECPT( 5) = THETA = ANGLE OF MATERIAL           ANGLE     REAL
!     ECPT( 6) = MATERIAL ID                         MATID     INTEGER
!     ECPT( 7) = T                                   T         REAL
!     ECPT( 8) = NON-STRUCTURAL MASS                 FMU       REAL
!     ECPT( 9) = COORD. SYSTEM ID 1                  NECPT(9)  INTEGER
!     ECPT(10) = X1                                  X1        REAL
!     ECPT(11) = Y1                                  Y1        REAL
!     ECPT(12) = Z1                                  Z1        REAL
!     ECPT(13) = COORD. SYSTEM ID 2                  NECPT(13) INTEGER
!     ECPT(14) = X2                                  X2        REAL
!     ECPT(15) = Y2                                  Y2        REAL
!     ECPT(16) = Z2                                  Z2        REAL
!     ECPT(17) = COORD. SYSTEM ID 3                  NECPT(17) INTEGER
!     ECPT(18) = X3                                  X3        REAL
!     ECPT(19) = Y3                                  Y3        REAL
!     ECPT(20) = Z3                                  Z3        REAL
!     ECPT(21) = ELEMENT TEMPERATURE                 ELTEMP    REAL
!
!
!     SET UP THE E MATRIX WHICH IS (3X2) FOR THE TRI-MEMBRANE
!
!     E(1), E(3), E(5) WILL BE THE I-VECTOR
!     E(2), E(4), E(6) WILL BE THE J-VECTOR
!     E(7), E(8), E(9) WILL BE THE K-VECTOR NOT USED IN E FOR MEMBRANE
!
!     FIRST FIND I-VECTOR = RSUBB - RSUBA  (NON-NORMALIZED)
!
   e(1) = dble(x2) - dble(x1)
   e(3) = dble(y2) - dble(y1)
   e(5) = dble(z2) - dble(z1)
!
!     NOW FIND LENGTH = X-SUB-B   COORD. IN ELEMENT SYSTEM
!
   xsubb = dsqrt(e(1)**2+e(3)**2+e(5)**2)
   IF ( xsubb>1.0D-06 ) THEN
!
!     NOW NORMALIZE I-VECTOR WITH X-SUB-B
!
      e(1) = e(1)/xsubb
      e(3) = e(3)/xsubb
      e(5) = e(5)/xsubb
!
!     HERE WE NOW TAKE RSUBC - RSUBA AND STORE TEMPORARILY IN
!     E(2), E(4), E(6) WHICH IS WHERE THE J-VECTOR WILL FIT LATER
!
      e(2) = dble(x3) - dble(x1)
      e(4) = dble(y3) - dble(y1)
      e(6) = dble(z3) - dble(z1)
!
!     X-SUB-C  =  I . (RSUBC - RSUBA),  THUS
!
      xsubc = e(1)*e(2) + e(3)*e(4) + e(5)*e(6)
!
!     AND CROSSING THE I-VECTOR TO (RSUBC-RSUBA) GIVES THE K-VECTOR
!     (NON-NORMALIZED)
!
      e(7) = e(3)*e(6) - e(5)*e(4)
      e(8) = e(5)*e(2) - e(1)*e(6)
      e(9) = e(1)*e(4) - e(3)*e(2)
!
!     THE LENGTH OF THE K-VECTOR IS NOW FOUND AND EQUALS Y-SUB-C
!     COORD. IN ELEMENT SYSTEM
!
      ysubc = dsqrt(e(7)**2+e(8)**2+e(9)**2)
      IF ( ysubc>1.0D-06 ) THEN
!
!     NOW NORMALIZE K-VECTOR WITH YSUBC JUST FOUND
!
         e(7) = e(7)/ysubc
         e(8) = e(8)/ysubc
         e(9) = e(9)/ysubc
!
!     J VECTOR = K CROSS I
!     STORE IN THE SPOT FOR J
!
         e(2) = e(5)*e(8) - e(3)*e(9)
         e(4) = e(1)*e(9) - e(5)*e(7)
         e(6) = e(3)*e(7) - e(1)*e(8)
!
!     AND JUST FOR COMPUTER EXACTNESS NORMALIZE J-VECTOR TO MAKE SURE.
!
         temp = dsqrt(e(2)**2+e(4)**2+e(6)**2)
         IF ( temp/=0.0D0 ) THEN
!
            e(2) = e(2)/temp
            e(4) = e(4)/temp
            e(6) = e(6)/temp
!
!     VOLUME OF ELEMENT, THETA, MU, LAMDA, AND DELTA
!
            vol = xsubb*ysubc*dble(t)/2.0D0
            reelmu = 1.0D0/xsubb
            flamda = 1.0D0/ysubc
            delta = xsubc/xsubb - 1.0D0
!
!     NOW FORM THE  C MATRIX   (3X6) PARTITIONED AS FOLLOWS HERE.
!         CSUBA = (3X2) STORED IN C( 1) THRU C( 6) BY ROWS
!         CSUBB = (3X2) STORED IN C( 7) THRU C(12) BY ROWS
!         CSUBC = (3X2) STORED IN C(13) THRU C(18) BY ROWS
!
            c(1) = -reelmu
            c(2) = 0.0D0
            c(3) = 0.0D0
            c(4) = flamda*delta
            c(5) = c(4)
            c(6) = -reelmu
            c(7) = reelmu
            c(8) = 0.0D0
            c(9) = 0.0D0
            c(10) = -flamda*reelmu*xsubc
            c(11) = c(10)
            c(12) = reelmu
            c(13) = 0.0D0
            c(14) = 0.0D0
            c(15) = 0.0D0
            c(16) = flamda
            c(17) = flamda
            c(18) = 0.0D0
!
            IF ( Ntype/=1 ) THEN
!
               theta = angle*degra
               sinth = sin(theta)
               costh = cos(theta)
            ENDIF
            IF ( abs(sinth)<1.0E-06 ) sinth = 0.0E0
!
!     BRANCH ON -HEAT- PROBLEM AT THIS POINT.
!
            IF ( heat ) THEN
!
!     HEAT PROBLEM LOGIC PICKS UP HERE.  CALL HMAT FOR MATERIAL DATA.
!
               inflag = 2
               matid = necpt(6)
               eltemp = ecpt(21)
               CALL hmat(necpt)
               g(1) = matbuf(1)
               g(2) = matbuf(2)
               g(3) = matbuf(2)
               g(4) = matbuf(3)
!
!     CONDENSE C MATRIX FOR HEAT PROBLEM (FORMED ABOVE)  C IS (2X3)
!
               c(2) = c(4)
               c(3) = c(7)
               c(4) = c(10)
               c(5) = c(13)
               c(6) = c(16)
!
!     DETERMINE THE PIVOT POINT.
!
               DO i = 1 , 3
                  IF ( ngrid(i)==npvt ) GOTO 5
               ENDDO
               CALL mesage(-30,34,ecpt(1))
!
!     PIVOT C MATRIX TIMES VOLUME (STORED INTO TT(1) AND TT(2).)
!
 5             tt(1) = vol*c(2*i-1)
               tt(2) = vol*c(2*i)
!
!     OUTPUT THE CONDUCTIVITY MATRICES
!
               k = 36
               IF ( Ntype/=0 ) k = 27
               DO i = 1 , k
                  kij(i) = 0.0D0
               ENDDO
               npoint = 0
!
               DO i = 1 , 3
                  n2 = 2*i
                  n1 = n2 - 1
                  tempar(1) = (g(1)*c(n1)+g(2)*c(n2))*tt(1) + (g(3)*c(n1)+g(4)*c(n2))*tt(2)
                  IF ( Ntype/=0 ) THEN
!
!     SUB-TRIANGLE (RETURN 3X3-S AS ABOVE IN STIFFNESS PORTION)
!
                     kij(npoint+1) = tempar(1)
                     npoint = npoint + 9
                  ELSE
!
!     TRIANGLE BY ITSELF
!
                     CALL sma1b(tempar(1),necpt(i+1),npvt,ifkgg,0.0D0)
                  ENDIF
               ENDDO
               GOTO 99999
            ELSE
               eltemp = ecpt(21)
               matid = matid1
               inflag = 2
               CALL mat(ecpt(1))
               IF ( nogo==1 ) RETURN
!
!     FILL G-MATRIX WITH OUTPUT FROM MAT ROUTINE
!
               g(1) = g11
               g(2) = g12
               g(3) = g13
               g(4) = g12
               g(5) = g22
               g(6) = g23
               g(7) = g13
               g(8) = g23
               g(9) = g33
!
!     G, E, AND C MATRICES ARE COMPLETE
!
!     AT THIS POINT THE FOLLOWING EQUATION CAN BE SOLVED FOR K-SUB-IJ
!
!                    T         T     T
!       K   = VOL . T *E*C *G*C *E *T
!        IJ          I         I  J  J
!
!     T-SUB-I WILL BE USED IN THE ABOVE ONLY IF THE PIVOT COORDINATE
!     SYSTEM ID IS NOT ZERO, OTHERWISE IT IS ASSUMED TO BE THE
!     IDENTITY MATRIX.
!
!     THE I SUBSCRIPT IMPLIES THE PIVOT POINT  1,2, OR 3 (ELEMENT SYST)
!     THE J SUBSCRIPT IMPLIES  1 THRU 3  FOR EACH CALL TO THIS ROUTINE.
!
!
!     FIRST LOCATE WHICH POINT IS THE PIVOT
!
!
               DO i = 1 , 3
                  IF ( ngrid(i)==npvt ) THEN
                     ka = 4*i + 5
                     npoint = 6*i - 5
                     GOTO 10
                  ENDIF
               ENDDO
!
!     FALLING THRU ABOVE LOOP INDICATES THE PIVOT POINT SPECIFIED BY
!     NPVT WAS NOT FOUND EQUAL TO ANY OF THE 3 GRID POINTS IN THE ECPT
!     THUS ERROR CONDITION.
!
               CALL mesage(-30,34,ecpt(1))
!
!                     T
!     COMPUTE   E*C *G       AND STORE IN TEMPAR (1 THRU 9)
!                  I
!
 10            CALL gmmatd(e,3,2,0,c(npoint),3,2,1,tempar(10))
               CALL gmmatd(tempar(10),3,3,0,g,3,3,0,tempar(1))
!
!     NCOM WILL ALWAYS POINT TO THE COMMON 3 X 3 PRODUCT ABOVE
!     NPT1 WILL POINT TO FREE WORKING SPACE LENGTH 9
!
               ncom = 1
               npt1 = 10
!
!     MULTIPLY COMMON PRODUCT BY SCALER VOL
!
               DO i = 1 , 9
                  tempar(i) = tempar(i)*vol
               ENDDO
!
!     CHECK FOR PIVOT  CSID = 0,  IF ZERO SKIP TRANSFORMATION TSUBI.
!
               IF ( necpt(ka)/=0 ) THEN
!
!     NOT-ZERO THUS GET TI
!
                  CALL transd(necpt(ka),ti)
!
!     INTRODUCE TI INTO THE COMMON PRODUCT AND STORE AT
!     TEMPAR (10 THRU 18)
!
                  CALL gmmatd(ti,3,3,1,tempar(1),3,3,0,tempar(10))
!
!     COMMON PRODUCT NOW STARTS AT TEMPAR(10) THUS CHANGE NCOM AND NPT1
!
                  ncom = 10
                  npt1 = 1
               ENDIF
            ENDIF
         ELSE
            CALL mesage(30,26,ecpt(1))
!
!     SET FLAG FOR FATAL ERROR WHILE ALLOWING ERROR MESSAGES TO
!     ACCUMULATE
!
            nogo = 1
            RETURN
         ENDIF
      ELSE
         CALL mesage(30,32,ecpt(1))
!
!     SET FLAG FOR FATAL ERROR WHILE ALLOWING ERROR MESSAGES TO
!     ACCUMULATE
!
         nogo = 1
         RETURN
      ENDIF
   ELSE
      CALL mesage(30,31,ecpt(1))
!
!     SET FLAG FOR FATAL ERROR WHILE ALLOWING ERROR MESSAGES TO
!     ACCUMULATE
!
      nogo = 1
      RETURN
   ENDIF
!
!     NOW HAVE COMMON PRODUCT STORED BEGINNING TEMPAR(NCOM),  (3X3).
!     NPT1 POINTS TO FREE WORKING SPACE LENGTH 9.
!
!     PROCEED NOW AND RUN OUT THE 3 6X6 MATRICES KIJ-SUB-1,2,3.
!
!     FIRST ZERO OUT (6 X 6) K
!                             IJ
!
   nsave = npt1
   DO i = 1 , 36
      kij(i) = 0.0D0
   ENDDO
   npoint = 0
!
   DO i = 1 , 3
      CALL gmmatd(c(6*i-5),3,2,0,e,3,2,1,tempar(nsave))
!
!                                                                  T
!     NPT2 IS SET TO POINT TO THE BEGINNING OF THE PRODUCT  C *E *T
!                                                            J     J
      npt2 = nsave
      npt1 = 19
!
!     CHECK FOR ZERO CSID IN WHICH CASE TJ IS NOT NEEDED
!
      IF ( necpt(4*i+5)/=0 ) THEN
!
!     COMMING HERE IMPLIES NEED FOR TJ
!     WILL STORE TJ IN TI
!
         CALL transd(necpt(4*i+5),ti)
         CALL gmmatd(tempar(npt2),3,3,0,ti,3,3,0,tempar(19))
         npt1 = npt2
         npt2 = 19
      ENDIF
!
!     AT THIS POINT COMPLETE COMPUTATION FOR  K-SUB-I,J
!
      CALL gmmatd(tempar(ncom),3,3,0,tempar(npt2),3,3,0,tempar(npt1))
!
      IF ( Ntype==0 ) THEN
!
         kij(1) = tempar(npt1)
         kij(2) = tempar(npt1+1)
         kij(3) = tempar(npt1+2)
         kij(7) = tempar(npt1+3)
         kij(8) = tempar(npt1+4)
         kij(9) = tempar(npt1+5)
         kij(13) = tempar(npt1+6)
         kij(14) = tempar(npt1+7)
         kij(15) = tempar(npt1+8)
!
         CALL sma1b(kij(1),necpt(i+1),-1,ifkgg,0.0D0)
         temp = gsube
         IF ( iopt4/=0 ) THEN
            IF ( gsube/=0 ) THEN
               CALL sma1b(kij(1),necpt(i+1),-1,if4gg,temp)
               k4ggsw = 1
            ENDIF
         ENDIF
      ELSE
         DO j = 1 , 9
            npoint = npoint + 1
            npt2 = npt1 + j - 1
            kij(npoint) = tempar(npt2)
         ENDDO
      ENDIF
!
   ENDDO
99999 END SUBROUTINE ktrmem
