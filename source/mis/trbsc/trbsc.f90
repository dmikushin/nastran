!*==trbsc.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE trbsc(Iopt,Ti)
   USE c_condas
   USE c_matin
   USE c_matout
   USE c_ssgtri
   USE c_ssgwrk
   USE c_trimex
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Iopt
   REAL , DIMENSION(6) :: Ti
!
! Local variable declarations rewritten by SPAG
!
   REAL :: degra
   REAL , DIMENSION(25) :: ecpt
   REAL , DIMENSION(9) :: g , t
   REAL , DIMENSION(4) :: g2x2 , j2x2
   REAL , DIMENSION(18) :: hib , hic , s , tite
   REAL , DIMENSION(36) :: hinv
   INTEGER :: i , j , k
   EXTERNAL gbtran , gmmats , invers , mat , mesage , ssgkhi
!
! End of declarations rewritten by SPAG
!
!
!     ELEMENT THERMAL LOADING ROUTINE FOR THE BASIC BENDING TRIANGLE.
!
!       IOPT = 0    (BASIC BENDING TRIANGLE)
!       IOPT = 1    (SUB-CALCULATIONS FOR SQDPL1)
!       IOPT = 2    (SUB-CALCULATIONS FOR STRPL1)
!
!
!     ECPT LIST FOR BASIC BENDING TRIANGLE           NAME IN
!                                                    THIS
!     ECPT                                           ROUTINE    TYPE
!     --------   ---------------------------------   --------  -------
!     ECPT( 1) = ELEMENT ID                          NECPT(1)  INTEGER
!     ECPT( 2) = GRID POINT A                        NGRID(1)  INTEGER
!     ECPT( 3) = GRID POINT B                        NGRID(2)  INTEGER
!     ECPT( 4) = GRID POINT C                        NGRID(3)  INTEGER
!     ECPT( 5) = THETA = ANGLE OF MATERIAL           ANGLE     REAL
!     ECPT( 6) = MATERIAL ID 1                       MATID1    INTEGER
!     ECPT( 7) = I = MOMENT OF INERTIA               EYE       REAL
!     ECPT( 8) = MATERIAL ID 2                       MATID2    INTEGER
!     ECPT( 9) = T2                                  T2        REAL
!     ECPT(10) = NON-STRUCTURAL-MASS                 FMU       REAL
!     ECPT(11) = Z1                                  Z11       REAL
!     ECPT(12) = Z2                                  Z22       REAL
!     ECPT(13) = COORD. SYSTEM ID 1                  NECPT(13) INTEGER
!     ECPT(14) = X1                                  X1        REAL
!     ECPT(15) = Y1                                  Y1        REAL
!     ECPT(16) = Z1                                  Z1        REAL
!     ECPT(17) = COORD. SYSTEM ID 2                  NECPT(17) INTEGER
!     ECPT(18) = X2                                  X2        REAL
!     ECPT(19) = Y2                                  Y2        REAL
!     ECPT(20) = Z2                                  Z2        REAL
!     ECPT(21) = COORD. SYSTEM ID 3                  NECPT(21) INTEGER
!     ECPT(22) = X3                                  X3        REAL
!     ECPT(23) = Y3                                  Y3        REAL
!     ECPT(24) = Z3                                  Z3        REAL
!     ECPT(25) = ELEMENT TEMPERATURE                 ELTEMP    REAL
!
   !>>>>EQUIVALENCE (Consts(4),Degra) , (G(1),A(79)) , (Ecpt(1),Necpt(1)) , (G2x2(1),A(88)) , (S(1),A(55)) , (Tite(1),A(127)) ,          &
!>>>>    & (J2x2(1),A(92)) , (T(1),A(118)) , (Hib(1),A(109)) , (Hic(1),A(127)) , (Hinv(1),A(73))
!
   IF ( Iopt<=0 ) THEN
      eltemp = ecpt(25)
!
!     SET UP  I, J, K VECTORS STORING AS FOLLOWS AND ALSO CALCULATE
!     X-SUB-B, X-SUB-C, AND Y-SUB-C.
!
!     E(11), E(14), E(17) WILL BE THE I-VECTOR.
!     E(12), E(15), E(18) WILL BE THE J-VECTOR.
!     E( 1), E( 4), E( 7) WILL BE THE K-VECTOR.
!
!     FIND I-VECTOR = RSUBB - RUBA (NON-NORMALIZED)
      e(11) = x2 - x1
      e(14) = y2 - y1
      e(17) = z2 - z1
!
!     FIND LENGTH = X-SUB-B COOR. IN ELEMENT SYSTEM
!
      xsubb = sqrt(e(11)**2+e(14)**2+e(17)**2)
      IF ( xsubb<=1.0E-06 ) CALL mesage(-30,37,ecpt(1))
!
!     NORMALIZE I-VECTOR WITH X-SUB-B
!
      e(11) = e(11)/xsubb
      e(14) = e(14)/xsubb
      e(17) = e(17)/xsubb
!
!     TAKE RSUBC - RSUBA AND STORE TEMPORARILY IN E(2), E(5), E(8)
!
      e(2) = x3 - x1
      e(5) = y3 - y1
      e(8) = z3 - z1
!
!     X-SUB-C = I . (RSUBC - RSUBA), THUS
!
      xsubc = e(11)*e(2) + e(14)*e(5) + e(17)*e(8)
!
!     CROSSING I-VECTOR TO (RSUBC - RSUBA) GIVES THE K-VECTOR
!     (NON-NORMALIZED)
!
      e(1) = e(14)*e(8) - e(5)*e(17)
      e(4) = e(2)*e(17) - e(11)*e(8)
      e(7) = e(11)*e(5) - e(2)*e(14)
!
!     FIND LENGTH = Y-SUB-C COOR. IN ELEMENT SYSTEM
!
      ysubc = sqrt(e(1)**2+e(4)**2+e(7)**2)
      IF ( ysubc<=1.0E-06 ) CALL mesage(-30,37,ecpt(1))
!
!     NORMALIZE K-VECTOR WITH Y-SUB-C
!
      e(1) = e(1)/ysubc
      e(4) = e(4)/ysubc
      e(7) = e(7)/ysubc
!
!     NOW HAVING I AND K VECTORS GET -- J = K CROSS I
!
      e(12) = e(4)*e(17) - e(14)*e(7)
      e(15) = e(11)*e(7) - e(1)*e(17)
      e(18) = e(1)*e(14) - e(11)*e(4)
!
!     NORMALIZE J-VECTOR FOR COMPUTER EXACTNESS JUST TO MAKE SURE
!
      temp = sqrt(e(12)**2+e(15)**2+e(18)**2)
      e(12) = e(12)/temp
      e(15) = e(15)/temp
      e(18) = e(18)/temp
      e(2) = 0.0
      e(3) = 0.0
      e(5) = 0.0
      e(6) = 0.0
      e(8) = 0.0
      e(9) = 0.0
      e(10) = 0.0
      e(13) = 0.0
      e(16) = 0.0
!
!     CONVERT ANGLE FROM DEGREES TO RADIANS STORING IN THETA.
!
      theta = angle*degra
      sinth = sin(theta)
      costh = cos(theta)
      IF ( abs(sinth)<1.0E-06 ) sinth = 0.0
   ENDIF
!
!     SETTING UP G MATRIX
!
   matid = matid1
   inflag = 2
   CALL mat(ecpt(1))
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
!     COMPUTATION OF D = I.G-MATRIX (EYE IS INPUT FROM THE ECPT)
!
   DO i = 1 , 9
      d(i) = g(i)*eye
   ENDDO
!
   xbar = (xsubb+xsubc)/3.0
   ybar = ysubc/3.0
   xc = xbar
   yc = ybar
!
!     FORMING K  5X6
!              S
!
   xc3 = 3.0*xc
   yc3 = 3.0*yc
   yc2 = 2.0*yc
   ks(1) = d(1)
   ks(2) = d(3)
   ks(3) = d(2)
   ks(4) = d(1)*xc3
   ks(5) = d(2)*xc + d(3)*yc2
   ks(6) = d(2)*yc3
   ks(7) = d(2)
   ks(8) = d(6)
   ks(9) = d(5)
   ks(10) = d(2)*xc3
   ks(11) = d(5)*xc + d(6)*yc2
   ks(12) = d(5)*yc3
   ks(13) = d(3)
   ks(14) = d(9)
   ks(15) = d(6)
   ks(16) = d(3)*xc3
   ks(17) = d(6)*xc + d(9)*yc2
   ks(18) = d(6)*yc3
!
!     ROWS 4 AND 5
!
   ks(19) = 0.0
   ks(20) = 0.0
   ks(21) = 0.0
   ks(22) = -d(1)*6.0
   ks(23) = -d(2)*2.0 - d(9)*4.0
   ks(24) = -d(6)*6.0
   ks(25) = 0.0
   ks(26) = 0.0
   ks(27) = 0.0
   ks(28) = -d(3)*6.0
   ks(29) = -d(6)*6.0
   ks(30) = -d(5)*6.0
!
!     MULTIPLY FIRST 3 ROWS BY 2.0
!
   DO i = 1 , 18
      ks(i) = ks(i)*2.0
   ENDDO
!
!     MULTIPLY KS BY THE AREA
!
   area = xsubb*ysubc/2.0
   DO i = 1 , 30
      ks(i) = ks(i)*area
   ENDDO
!
   xcsq = xsubc**2
   ycsq = ysubc**2
   xbsq = xsubb**2
   xcyc = xsubc*ysubc
!
!     F1LL  (HBAR) MATRIX STORING AT A(37) THRU A(72)
!
   DO i = 37 , 72
      a(i) = 0.0
   ENDDO
!
   a(37) = xbsq
   a(40) = xbsq*xsubb
   a(44) = xsubb
   a(49) = -2.0*xsubb
   a(52) = -3.0*xbsq
   a(55) = xcsq
   a(56) = xcyc
   a(57) = ycsq
   a(58) = xcsq*xsubc
   a(59) = ycsq*xsubc
   a(60) = ycsq*ysubc
   a(62) = xsubc
   a(63) = ysubc*2.0
   a(65) = xcyc*2.0
   a(66) = ycsq*3.0
   a(67) = -2.0*xsubc
   a(68) = -ysubc
   a(70) = -3.0*xcsq
   a(71) = -ycsq
!
   IF ( t2/=0.0 ) THEN
!
!     ALL OF THE FOLLOWING OPERATIONS THROUGH STATEMENT LABEL 500
!     ARE NECESSARY IF T2 IS NON-ZERO.
!
!     GET THE G2X2 MATRIX
!
      matid = matid2
      inflag = 3
      CALL mat(ecpt(1))
      IF ( g2x211/=0.0 .OR. g2x212/=0.0 .OR. g2x222/=0.0 ) THEN
         g2x2(1) = g2x211*t2
         g2x2(2) = g2x212*t2
         g2x2(3) = g2x212*t2
         g2x2(4) = g2x222*t2
!
         determ = g2x2(1)*g2x2(4) - g2x2(3)*g2x2(2)
         j2x2(1) = g2x2(4)/determ
         j2x2(2) = -g2x2(2)/determ
         j2x2(3) = -g2x2(3)/determ
         j2x2(4) = g2x2(1)/determ
!
!     (H  ) IS PARTITIONED INTO A LEFT AND RIGHT PORTION AND ONLY THE
!       YQ  RIGHT PORTION IS COMPUTED AND USED AS A  (2X3). THE LEFT
!           2X3 PORTION IS NULL.  THE RIGHT PORTION WILL BE STORED AT
!           A(73) THRU A(78) UNTIL NOT NEEDED ANY FURTHER.
!
         temp = 2.0*d(2) + 4.0*d(9)
         a(73) = -6.0*(j2x2(1)*d(1)+j2x2(2)*d(3))
         a(74) = -j2x2(1)*temp + 6.0*j2x2(2)*d(6)
         a(75) = -6.0*(j2x2(1)*d(6)+j2x2(2)*d(5))
         a(76) = -6.0*(j2x2(2)*d(1)+j2x2(4)*d(3))
         a(77) = -j2x2(2)*temp + 6.0*j2x2(4)*d(6)
         a(78) = -6.0*(j2x2(2)*d(6)+j2x2(4)*d(5))
!
!     THE ABOVE 6 ELEMENTS NOW REPRESENT THE (H  ) MATRIX (2X3)
!                                              YQ
!
!     ADD TO 6 OF THE (HBAR) ELEMENTS THE RESULT OF(H  )(H  )
!                                                    UY   YQ
!     THE PRODUCT IS FORMED DIRECTLY IN THE ADDITION PROCESS BELOW.
!     NO (H  ) MATRIX IS ACTUALLY COMPUTED DIRECTLY.
!          UY
!
!     THE FOLLOWING IS THEN PER STEPS 6 AND 7 PAGE -16- MS-17.
!
         DO i = 1 , 3
            a(i+39) = a(i+39) + xsubb*a(i+72)
            a(i+57) = a(i+57) + xsubc*a(i+72) + ysubc*a(i+75)
         ENDDO
      ENDIF
   ENDIF
!
!     THIS ENDS ADDED COMPUTATION FOR CASE OF T2 NOT ZERO
!
!
!     AT THIS POINT INVERT  (H) WHICH IS STORED AT A(37) THRU A(72)
!     STORE INVERSE BACK IN A(37) THRU A(72)
!
!     NO NEED TO COMPUTE DETERMINANT SINCE IT IS NOT USED SUBSEQUENTLY.
!
   ising = -1
   CALL invers(6,a(37),6,a(73),0,determ,ising,a(79))
!
!     CHECK TO SEE IF H WAS SINGULAR
!
!
!     ISING = 2 IMPLIES SINGULAR MATRIX THUS ERROR CONDITION.
!
   IF ( ising==2 ) CALL mesage(-30,38,ecpt(1))
!
!     SAVE H-INVERSE IF TRI-PLATE IS CALLING
!
   DO i = 1 , 36
      hinv(i) = a(i+36)
   ENDDO
!
!     FILL  S-MATRIX, EQUIVALENCED TO A(55).  (6X3)
!
   s(1) = 1.0
   s(2) = 0.0
   s(3) = -xsubb
   s(4) = 0.0
   s(5) = 1.0
   s(6) = 0.0
   s(7) = 0.0
   s(8) = 0.0
   s(9) = 1.0
   s(10) = 1.0
   s(11) = ysubc
   s(12) = -xsubc
   s(13) = 0.0
   s(14) = 1.0
   s(15) = 0.0
   s(16) = 0.0
   s(17) = 0.0
   s(18) = 1.0
!
!     COMPUTE  S , S ,  AND S    NO TRANSFORMATIONS
!               A   B        C
!
!                -1
!     S  = - K  H  S ,   S  = K  H   ,   S  = K  H
!      A      S           B    S  IB      C    S  IC
!
!     S   COMPUTATION.
!      A
!
   CALL gmmats(hinv(1),6,6,0,s(1),6,3,0,a(16))
!
!     DIVIDE  H-INVERSE INTO A LEFT 6X3 AND RIGHT 6X3 PARTITION.
!
   i = 0
   j = -6
   SPAG_Loop_1_1: DO
      j = j + 6
      k = 0
      SPAG_Loop_2_2: DO
         k = k + 1
         i = i + 1
         isub = j + k
         hib(i) = hinv(isub)
         hic(i) = hinv(isub+3)
         IF ( k>=3 ) THEN
            IF ( j<30 ) CYCLE SPAG_Loop_1_1
!
            CALL gmmats(ks(1),5,6,0,a(16),6,3,0,a(1))
!
!     MULTIPLY S SUB A BY (-1)
!
            DO i = 1 , 15
               a(i) = -a(i)
            ENDDO
!
!     S  COMPUTATION
!      B
!
            CALL gmmats(ks,5,6,0,hib,6,3,0,a(16))
!
!     S  COMPUTATION
!      C
!
            CALL gmmats(ks,5,6,0,hic,6,3,0,a(31))
!
!     RETURN IF TRI OR QUAD PLATE ROUTINE IS CALLING.
!
            IF ( Iopt>0 ) RETURN
!
!     FILL KHI   (5 X 1)
!             E
!
!     THE N FACTOR = 1.0 FOR THE BASIC BENDING TRIANGLE.
!
            CALL ssgkhi(Ti(1),Ti(1),1.0)
!
!                                   T
!     TRANSFORM  S , S , S  WITH   E  T  , I = A,B,C
!                 A   B   C            I
!
!                              T         T
!     COMPUTING TRANSPOSE OF  E  T  =  T  E
!                                 I     I
!
            DO i = 1 , 3
!
!     POINTER TO S MATRIX = 15 * I - 14
!                 I
!
!     CHECK TO SEE IF T IS NEEDED.
!
               IF ( necpt(4*i+9)/=0 ) THEN
                  CALL gbtran(necpt(4*i+9),necpt(4*i+10),t(1))
                  CALL gmmats(t,3,3,1,e(1),3,3,0,tite(1))
                  CALL gmmats(t,3,3,1,e(10),3,3,0,tite(10))
                  CALL gmmats(a(15*i-14),5,3,0,tite,6,3,1,ks(1))
               ELSE
                  CALL gmmats(a(15*i-14),5,3,0,e,6,3,1,ks(1))
               ENDIF
!
!     COMPUTE THE LOAD VECTOR AND INSERT IT INTO OPEN CORE
!
               CALL gmmats(ks(1),5,6,1,khi(1),5,1,0,p(1))
               k = ngrid(i) - 1
               DO j = 1 , 6
                  k = k + 1
                  z(k) = z(k) + p(j)
               ENDDO
            ENDDO
            EXIT SPAG_Loop_2_2
         ENDIF
      ENDDO SPAG_Loop_2_2
      EXIT SPAG_Loop_1_1
   ENDDO SPAG_Loop_1_1
END SUBROUTINE trbsc
