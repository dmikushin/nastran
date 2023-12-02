!*==trplt.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE trplt(Ti)
   IMPLICIT NONE
   USE c_condas
   USE c_matin
   USE c_ssgtri
   USE c_ssgwrk
   USE c_trimex
   USE c_zzzzzz
!
! Dummy argument declarations rewritten by SPAG
!
   REAL , DIMENSION(6) :: Ti
!
! Local variable declarations rewritten by SPAG
!
   REAL :: degra
   REAL , DIMENSION(36) :: g
   REAL , DIMENSION(12) :: hq
   INTEGER :: i , j , k , l
   INTEGER , DIMENSION(9) , SAVE :: m
   INTEGER , DIMENSION(25) :: necpt
   REAL , DIMENSION(15) :: prod15 , temp15
   REAL , DIMENSION(9) :: requiv
   REAL , DIMENSION(10) :: tite
   REAL , DIMENSION(25) :: v
   REAL , DIMENSION(3) :: v1 , v2 , v3
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
!     ELEMENT THERMAL LOADING FOR THE BENDING TRIANGULAR PLATE.
!
!                 DEFINITION
!       ECPT      BSC.BEND.TRI. AND THE TRI-PLATE
!     --------   ---------------------------------------
!     ECPT( 1) = ELEMENT ID         INTEGER
!     ECPT( 2) = GRID PT. A         INTEGER
!     ECPT( 3) = GRID PT. B         INTEGER
!     ECPT( 4) = GRID PT. C         INTEGER
!     ECPT( 5) = THETA              REAL
!     ECPT( 6) = MAT ID 1           INTEGER
!     ECPT( 7) = I  MOM. OF INERT.  REAL
!     ECPT( 8) = MAT ID 2           INTEGER
!     ECPT( 9) = T2                 REAL
!     ECPT(10) = NON-STRUCT. MASS   REAL
!     ECPT(11) = Z1                 REAL
!     ECPT(12) = Z2                 REAL
!     ECPT(13) = COORD. SYS. ID 1   INTEGER
!     ECPT(14) = X1                 REAL
!     ECPT(15) = Y1                 REAL
!     ECPT(16) = Z1                 REAL
!     ECPT(17) = COORD. SYS. ID 2   INTEGER
!     ECPT(18) = X2                 REAL
!     ECPT(19) = Y2                 REAL
!     ECPT(20) = Z2                 REAL
!     ECPT(21) = COORD. SYS. ID 3   INTEGER
!     ECPT(22) = X3                 REAL
!     ECPT(23) = Y3                 REAL
!     ECPT(24) = Z3                 REAL
!     ECPT(25) = ELEMENT TEMP       REAL
!
   !>>>>EQUIVALENCE (Consts(4),Degra) , (Prod15(1),Prod9(1)) , (Requiv(1),R(1,1)) , (Necpt(1),Ecpt(1)) , (V1(1),Ecpt(14)) ,              &
!>>>>    & (V2(1),Ecpt(18)) , (V3(1),Ecpt(22)) , (Tite(1),A(1)) , (V(1),Prod12(1)) , (Hq(1),A(1))
   DATA m/1 , 2 , 4 , 2 , 3 , 4 , 3 , 1 , 4/
!
   eltemp = ecpt(25)
   theta = ecpt(5)*degra
   sinang = sin(theta)
   cosang = cos(theta)
!
!     FORMATION OF THE R-MATRIX CONTAINING COORDINATES OF THE
!     SUB TRIANGLES. (2X4) FOR THE TRIANGULAR PLATE.
!     FORMATION ALSO OF THE I,J, AND K VECTORS USED IN THE E-MATRIX.
!
!     ZERO OUT R-MATRIX
!
   DO i = 1 , 8
      requiv(i) = 0.0
   ENDDO
!
   DO i = 1 , 3
      d2(i) = v2(i) - v1(i)
      d1(i) = v3(i) - v1(i)
   ENDDO
!
!     X2  GOES IN R(1,2)
!
   r(1,2) = sqrt(d2(1)**2+d2(2)**2+d2(3)**2)
   DO i = 1 , 3
      ivect(i) = d2(i)/r(1,2)
   ENDDO
!
!     NON-NORMALIZED K-VECTOR
!
   kvect(1) = ivect(2)*d1(3) - d1(2)*ivect(3)
   kvect(2) = ivect(3)*d1(1) - d1(3)*ivect(1)
   kvect(3) = ivect(1)*d1(2) - d1(1)*ivect(2)
!
!     Y3 GOES INTO R(2,3)
!
   r(2,3) = sqrt(kvect(1)**2+kvect(2)**2+kvect(3)**2)
   DO i = 1 , 3
      kvect(i) = kvect(i)/r(2,3)
   ENDDO
!
!     J-VECTOR = K X I  VECTORS
!
   jvect(1) = kvect(2)*ivect(3) - ivect(2)*kvect(3)
   jvect(2) = kvect(3)*ivect(1) - ivect(3)*kvect(1)
   jvect(3) = kvect(1)*ivect(2) - ivect(1)*kvect(2)
!
!     NORMALIZE J VECTOR TO MAKE SURE
!
   temp = sqrt(jvect(1)**2+jvect(2)**2+jvect(3)**2)
   DO i = 1 , 3
      jvect(i) = jvect(i)/temp
   ENDDO
!
!     X3 GOES INTO R(1,3) = D1 DOT IVECT
!
   r(1,3) = d1(1)*ivect(1) + d1(2)*ivect(2) + d1(3)*ivect(3)
!
!     CENTROID POINT GOES INTO R(1,4) AND R(2,4)
!
   r(1,4) = (r(1,2)+r(1,3))/3.0
   r(2,4) = r(2,3)/3.0
!
!     COMPUTE SUB-TRIANGLE COORDINATES
!     CALL BASIC BENDING ROUTINE FOR ALL SUB-TRIANGLES.
!
   DO i = 1 , 60
      ssum(i) = 0.0
   ENDDO
   DO i = 1 , 36
      g(i) = 0.0
   ENDDO
!
   DO j = 1 , 3
      km = 3*j - 3
      subsca = m(km+1)
      subscb = m(km+2)
      subscc = m(km+3)
!
      DO i = 1 , 2
         vv1(i) = r(i,subscb) - r(i,subsca)
         vv2(i) = r(i,subscc) - r(i,subsca)
      ENDDO
      xsubb = sqrt(vv1(1)**2+vv1(2)**2)
      u1 = vv1(1)/xsubb
      u2 = vv1(2)/xsubb
      xsubc = u1*vv2(1) + vv2(2)*u2
      ysubc = u1*vv2(2) - vv2(1)*u2
!
      xc = xsubc
      yc = ysubc
!
      sinth = sinang*u1 - cosang*u2
      costh = cosang*u1 + sinang*u2
      IF ( abs(sinth)<1.0E-06 ) sinth = 0.0
!
!     AT THIS POINT, XSUBB, XSUBC, YSUBC ARE AT HAND FOR
!     TRIANGLE -J-
!
      CALL trbsc(2,Ti(1))
!
!     RETURNING FROM STRBS1 THE FOLLOWING QUANTITIES ARE AT HAND.
!
!       S   , S   , S   , EACH 5X3.   45 WORDS STORED IN A( 1)...A(45)
!        A     B     C
!
!     AND ALSO H-INVERSE IS AT A(73)...A(108) AND S IS AT A(55)...A(72)
!
!     COMPUTE KHI   (5X1)  MATRIX
!                E
!
!     THIS WILL BE USED AT THE END OF THE INTERMEDIATE COMPUTATIONS.
!     KHI-SUB-E MUST BE COMPUTED AFTER THE FIRST SUBTRIANGLE IN ORDER
!     TO USE THE -D- MATERIAL MATRIX WITH THE CORRECT ORIENTATION.
!
!     NFACTOR = 3.0 FOR THE CLOUGH TRIANGLE
!
      IF ( j==1 ) CALL ssgkhi(Ti(1),Ti(1),3.0)
!
!     SET UP OF T-MATRIX
!
      t(1) = 1.0
      t(2) = 0.0
      t(3) = 0.0
      t(4) = 0.0
      t(5) = u1
      t(6) = u2
      t(7) = 0.0
      t(8) = -u2
      t(9) = u1
!
!     SET UP V-MATRIX PER FMMS 51-A
!
      v(1) = u1*u1/3.0
      v(2) = u2*u2/3.0
      v(11) = u1*u2/3.0
      v(3) = -v(11)*2.0
      v(4) = 0.0
      v(5) = 0.0
      v(6) = v(2)
      v(7) = v(1)
      v(8) = -v(3)
      v(9) = 0.0
      v(10) = 0.0
      v(12) = -v(11)
      v(13) = v(1) - v(2)
      v(14) = 0.0
      v(15) = 0.0
      v(16) = 0.0
      v(17) = 0.0
      v(18) = 0.0
      v(19) = u1/3.0
      v(20) = -u2/3.0
      v(21) = 0.0
      v(22) = 0.0
      v(23) = 0.0
      v(24) = -v(20)
      v(25) = v(19)
!
!     ADD IN S , S , S   TO THE 4 5X3 SSUM MATRICES
!             A   B   C
!
      DO i = 1 , 3
         CALL gmmats(v(1),5,5,0,a(15*i-14),5,3,0,temp15(1))
         CALL gmmats(temp15(1),5,3,0,t(1),3,3,0,prod15(1))
!
!     POINTER TO SSUM MATRIX
!
         npoint = km + i
         npoint = 15*m(npoint) - 15
         DO k = 1 , 15
            nsubc = npoint + k
            ssum(nsubc) = ssum(nsubc) + prod15(k)
         ENDDO
      ENDDO
!
!     FORM HQ (2X6)
!
      temp1 = xsubb - xsubc
      temp2 = ysubc**2
      l1 = sqrt(xsubc**2+temp2)
      l2 = sqrt(temp1**2+temp2)
      s1 = xsubc/l1
      s2 = temp1/l2
      c1 = ysubc/l1
      c2 = ysubc/l2
      x1 = xsubc/2.0
      y1 = ysubc/2.0
      x2 = (xsubb+xsubc)/2.0
      y2 = y1
      hq(1) = -xsubc*c1
      hq(2) = x1*s1 - y1*c1
      hq(3) = 2.0*y1*s1
      hq(4) = -3.0*x1*x1*c1
      hq(5) = y1*(2.0*x1*s1-y1*c1)
      hq(6) = 3.0*y1*y1*s1
      hq(7) = 2.0*x2*c2
      hq(8) = x2*s2 + y2*c2
      hq(9) = 2.0*y2*s2
      hq(10) = 3.0*x2*x2*c2
      hq(11) = y2*(2.0*x2*s2+y2*c2)
      hq(12) = 3.0*y2*y2*s2
!
!                      I                    -1
!     COMPUTE (H       I  H     )  = (HQ)(H)    STORE IN PROD12
!               PSI,B  I   PSI,C
!                      I
!
!
      CALL gmmats(hq(1),2,6,0,hinv(1),6,6,0,prod12(1))
!
!
!     COMPUTE (H     ) = -(PROD12)(S)
!               PSI,A
!
      CALL gmmats(prod12(1),2,6,0,s(1),6,3,0,habc(1))
      habc(1) = -habc(1)
      habc(2) = -habc(2) + s1
      habc(3) = -habc(3) + c1
      habc(4) = -habc(4)
      habc(5) = -habc(5) + s2
      habc(6) = -habc(6) - c2
!
!     SPLIT(H     ) AND (H     )  PARTITION
!            PSI,B        PSI,C
!
      habc(7) = prod12(1)
      habc(8) = prod12(2)
      habc(9) = prod12(3)
      habc(10) = prod12(7)
      habc(11) = prod12(8)
      habc(12) = prod12(9)
      habc(13) = prod12(4)
      habc(14) = prod12(5)
      habc(15) = prod12(6)
      habc(16) = prod12(10)
      habc(17) = prod12(11)
      habc(18) = prod12(12)
!
!     MAP  H , H , AND H  INTO THE G-MATRICES.
!           A   B       C
!
!     TRIANGLE NUMBER = J, THE THREE POINTS ARE SUBSCA,SUBSCB,SUBSCC.
!
      DO i = 1 , 3
!
!     POINTER TO H  = 6*I - 6
!                 I
!
!     TRANSFORM H SUB I
!
         CALL gmmats(habc(6*i-5),2,3,0,t(1),3,3,0,temp9(1))
!
         npoint = km + i
         npoint = 9*m(npoint) - 9
!
!     J = 1  ROW 1 OF H INTO ROW 1 OF G.
!            ROW 2 OF H INTO ROW 2 OF G.
!     J = 2  ROW 1 OF H INTO ROW 2 OF G.
!            ROW 2 OF H INTO ROW 3 OF G.
!     J = 3  ROW 1 OF H INTO ROW 3 OF G.
!            ROW 2 OF H INTO ROW 1 OF G.
!
         IF ( j<2 ) THEN
         ELSEIF ( j==2 ) THEN
!
            npoint = npoint + 3
         ELSE
            g(npoint+7) = g(npoint+7) + temp9(1)
            g(npoint+8) = g(npoint+8) + temp9(2)
            g(npoint+9) = g(npoint+9) + temp9(3)
            g(npoint+1) = g(npoint+1) + temp9(4)
            g(npoint+2) = g(npoint+2) + temp9(5)
            g(npoint+3) = g(npoint+3) + temp9(6)
            CYCLE
         ENDIF
         DO k = 1 , 6
            npoint = npoint + 1
            g(npoint) = g(npoint) + temp9(k)
         ENDDO
!
      ENDDO
!
   ENDDO
!
!     FILL E-MATRIX
!
   DO i = 1 , 18
      e(i) = 0.0
   ENDDO
   e(1) = kvect(1)
   e(4) = kvect(2)
   e(7) = kvect(3)
   e(11) = ivect(1)
   e(14) = ivect(2)
   e(17) = ivect(3)
   e(12) = jvect(1)
   e(15) = jvect(2)
   e(18) = jvect(3)
!
!               *         *     -1
!     (S ) = (S  )  -  (S  )(G )  (G )           I=A,B,C
!       I      I         4    4     I
!
!
!        E            T                  T
!     (S  ) = (S ) (E) (C ) = (S ) (TITE)    I=A,B,C
!       I       I        I      I
!
!                                 *     -1
!     FIRST GET COMMON PRODUCT (S  )(G )
!                                4    4
!
!     INVERT  (G )  STORE INVERSE BACK INTO  (G )
!               4                              4
!
!     NO NEED TO COMPUTE DETERMINANT SINCE IT IS NOT USED SUBSEQUENTLY.
!
   ising = -1
   CALL invers(3,g(28),3,prod9(1),0,determ,ising,temp9(1))
!
!     CHECK FOR SINGULARITY.  ISING = 2 IMPLIES SINGULARITY...
!
   IF ( ising/=1 ) CALL mesage(-30,36,ecpt(1))
!
   CALL gmmats(ssum(46),5,3,0,g(28),3,3,0,prod15(1))
!
   DO i = 1 , 3
!
!    (PROD15) (G )
!               I
!
      CALL gmmats(prod15(1),5,3,0,g(9*i-8),3,3,0,temp15(1))
!
!     SUBTRACT TEMP15 FROM S
!                          I
!
      npoint = 15*i - 15
      DO k = 1 , 15
         npoint = npoint + 1
         ssum(npoint) = ssum(npoint) - temp15(k)
      ENDDO
!
!     DO WE NEED TRANSFORMATION T
!                                I
      nsubc = 4*i + 9
      IF ( necpt(nsubc)==0 ) THEN
!
         DO k = 1 , 18
            tite(k) = e(k)
         ENDDO
      ELSE
         CALL gbtran(necpt(nsubc),necpt(nsubc+1),t(1))
         CALL gmmats(t(1),3,3,1,e(1),3,3,0,tite(1))
         CALL gmmats(t(1),3,3,1,e(10),3,3,0,tite(10))
      ENDIF
!
      CALL gmmats(ssum(15*i-14),5,3,0,tite(1),6,3,1,ks(1))
!
!     COMPUTE THE LOAD VECTOR AND INSERT IT INTO OPEN CORE.
!
      CALL gmmats(ks(1),5,6,1,khi(1),5,1,0,p(1))
      k = necpt(i+1) - 1
      DO l = 1 , 6
         k = k + 1
         z(k) = z(k) + p(l)
      ENDDO
!
   ENDDO
!
END SUBROUTINE trplt
