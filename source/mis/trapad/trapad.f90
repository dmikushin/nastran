!*==trapad.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE trapad
   IMPLICIT NONE
   USE c_condad
   USE c_emgdic
   USE c_emgest
   USE c_emgprm
   USE c_matin
   USE c_matout
   USE c_matpz
   USE c_system
!
! Local variable declarations rewritten by SPAG
!
   REAL*8 , DIMENSION(208) :: acurl
   REAL*8 , DIMENSION(48) :: acurp1 , akuph , d1
   REAL*8 , DIMENSION(16) :: acurp2 , akph2 , d2
   REAL*8 :: ajho , ajjho , ar , c2 , c2s2 , c4 , cosg , del , dgam , gamr , rhod , rmax , rmin , s2 , s4 , sing , v , vr , vz ,    &
           & zmin
   REAL*8 , DIMENSION(144) :: ak , bmbss , d
   REAL*8 , DIMENSION(256) :: akj
   REAL*8 , DIMENSION(27) :: akt
   REAL*8 , DIMENSION(3) :: anu , e
   REAL*8 , DIMENSION(12,12) :: bmass , gb
   REAL :: c3 , cs , cs2 , dict5 , gor , s3 , sc2
   REAL*8 , DIMENSION(12) :: delint
   INTEGER , DIMENSION(14) :: dict
   REAL , DIMENSION(20) :: ecpt
   REAL*8 , DIMENSION(63) :: ee
   REAL*8 , DIMENSION(4,4) :: gbp
   INTEGER :: i , i1 , iai , iakt , iapp , ib , ic , ic1 , idel1 , ik , ika , ikc , ikj , ikja , ikjb , ikjc , iout , ip , ipp ,    &
            & iq , ir1 , irc , ising , isort , it , j , jt , k , kk , korm , ksave , l , masor , mjho
   INTEGER , DIMENSION(4) :: ics , ipart
   INTEGER , SAVE :: idel2 , jax
   INTEGER , DIMENSION(39) :: iecpt
   LOGICAL :: lsys78 , pzmat
   REAL*8 , DIMENSION(4) :: r , z
   REAL*8 , DIMENSION(36) :: sp
   REAL*8 , DIMENSION(45) :: teo
!
! End of declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     THIS SUBROUTINE CALCULATES THE STIFFNESS AND MASS MATRICES FOR
!     THE ASSYMETRIC RING ELEMENT WITH A TRAPEZOIDAL CROSS SECTION
!
!     DOUBLE PRECISION VERSION
!
!     ECPT FOR THE TRAPAX ELEMENT
!
!     ECPT( 1) = ELEMENT ID                                I
!     ECPT( 2) = SIL A                                     I
!     ECPT( 3) = SIL B                                     I
!     ECPT( 4) = SIL C                                     I
!     ECPT( 5) = SIL D
!     ECPT( 6) = MATERIAL ORIENTATION ANGLE(DEGREES)       R
!     ECPT( 8) = MATERIAL ID                               I
!     ECPT( 9) TO ECPT(22) FOR PHI
!     ECPT(23) = COOR. SYS. FOR GRID POINT A               I
!     ECPT(24) = X-COOR. OF GRID POINT A (IN BASIC COOR)   R
!     ECPT(25) = Z-COOR. OF GRID POINT A (IN BASIC COOR)   R
!     ECPT(26) = 0.0
!     ECPT(27) = COOR. SYS. FOR GRID POINT B
!     ECPT(28) = X-COOR. OF GRID POINT B (IN BASIC COOR)   R
!     ECPT(29) = Z-COOR. OF GRID POINT B (IN BASIC COOR)   R
!     ECPT(30) = 0.0
!     ECPT(31) = COOR. SYS. FOR GRID POINT C               I
!     ECPT(32) = X-COOR. FOR GRID POINT C                  R
!     ECPT(33) = Z-COOR. FOR GRID POINT C                  R
!     ECPT(34) = 0.0
!     ECPT(35) = COOR. SYS. FOR GRID POINT D               I
!     ECPT(36) = X-COOR FOR GRID POINT D                   R
!     ECPT(37) = Z-COOR FOR GRID POINT D                   R
!     ECPT(38) = 0.0
!     ECPT(39) = EL. TEMPERATURE FOR MATERIAL PROP         R
!
!     ANY GROUP OF STATEMENTS PREFACED BY AN IF STATEMENT CONTAINING
!     ...KSYS78 OR LSYS78 ...  INDICATES CODING NECESSARY FOR THIS
!     ELEMENT*S PIEZOELECTRIC CAPABILITY
!
!     KSYS78 = 0   ELASTIC, NON-PIEZOELECTRIC MATERIAL
!     KSYS78 = 1   ELECTRICAL-ELASTIC COUPLED, PIEZOELETRIC MATERIAL
!     KSYS78 = 2   ELASTIC ONLY, PIEZOELECTRIC MATERIAL
!     LSYS78 = .TRUE. IF KSYS78 = 0, OR 2
!
!
!     INPUT AND OUTPUT BLOCKS FOR SUBROUTINE MAT
!
!     COMMON /MATPZ /  CE11,CE12,CE13,CE14,CE15,CE16,CE22,CE23,CE24,
!                      CE25,CE26,CE33,CE34,CE35,CE36,CE44,CE45,CE46,
!                      CE55,CE56,CE66,E11,E12,E13,E14,E15,E16,E21,E22,
!                      E23,E24,E25,E26,E31,E32,E33,E34,E35,E36,EPS11,
!                      EPS12,EPS13,EPS22
!
   !>>>>EQUIVALENCE (Ecpt(1),Iecpt(1),Idel) , (Ksystm(2),Iout) , (bmass(1,1),acurl(1),bmbss(1)) , (dict5,dict(5)) ,                      &
!>>>>    & (acurp1(1),acurl(145)) , (acurp2(1),acurl(193))
   DATA idel2 , jax/0 , 4HTRAP/
!
   lsys78 = .FALSE.
   IF ( ksys78==0 .OR. ksys78==2 ) lsys78 = .TRUE.
   idel1 = idel/1000
   isort = 0
   masor = 0
!
!     IF STIFFNESS MATRIX NOT NEEDED GO CALCULATE MASS MATRIX
!
   DO i = 1 , 4
      ics(i) = iecpt(4*i+19)
      r(i) = ecpt(4*i+20)
      z(i) = ecpt(4*i+21)
      d(i) = ecpt(4*i+22)
   ENDDO
!
!     TEST THE VALIDITY OF THE GRID POINT COORDINATES
!     NOTE THAT INTEGRATION ROUTINE FAILS FOR R = 0.0
!
   DO i = 1 , 4
      IF ( r(i)<=0. ) GOTO 600
      IF ( d(i)/=0. ) GOTO 600
   ENDDO
!
!     COMPUTE THE ELEMENT COORDINATES
!
   zmin = dmin1(z(1),z(2),z(3),z(4))
   DO i = 1 , 4
      z(i) = z(i) - zmin
   ENDDO
!
!     FATAL IF RATIO OF RADII IS TO LARGE FOR GUASS QUADRATURE
!
   rmin = dmin1(r(1),r(2),r(3),r(4))
   rmax = dmax1(r(1),r(2),r(3),r(4))
   IF ( rmax/rmin>10.D0 ) THEN
      IF ( rmax/rmin>10.D0 ) THEN
!
!     SET FATAL ERROR FLAG AND ALLOWING ERROR MESSAGES TO ACCUMULATE
!
         i = 218
         GOTO 700
      ENDIF
   ENDIF
!
   IF ( r(1)>=r(2) .OR. r(4)>=r(3) .OR. z(4)<=z(1) ) GOTO 600
   IF ( dabs(z(1)-z(2))>1.0D-3 ) GOTO 600
   IF ( dabs(z(3)-z(4))>1.0D-3 ) GOTO 600
   d(5) = (r(1)+r(4))/2.D0
   d(6) = (r(2)+r(3))/2.D0
   IF ( d(5)/=0.D0 ) THEN
      IF ( dabs((r(1)-r(4))/d(5))<=.5D-2 ) THEN
         r(1) = d(5)
         r(4) = d(5)
      ENDIF
   ENDIF
   IF ( d(6)/=0.D0 ) THEN
      IF ( dabs((r(2)-r(3))/d(6))<=.5D-2 ) THEN
         r(2) = d(6)
         r(3) = d(6)
      ENDIF
   ENDIF
!
!     FORM THE TRANSFORMMATION MATRIX(12X12) FROM FIELD COOR, TO GRID
!     POINT DEGREES OF FREEDOM
!
   DO i = 1 , 144
      gb(i,1) = 0.D0
   ENDDO
   gb(1,1) = 1.
   gb(2,1) = r(1)
   gb(3,1) = z(1)
   gb(4,1) = r(1)*z(1)
   gb(5,2) = 1.
   gb(6,2) = r(1)
   gb(7,2) = z(1)
   gb(8,2) = gb(4,1)
   gb(9,3) = 1.
   gb(10,3) = r(1)
   gb(11,3) = z(1)
   gb(12,3) = gb(4,1)
   gb(1,4) = 1.
   gb(2,4) = r(2)
   gb(3,4) = z(2)
   gb(4,4) = r(2)*z(2)
   gb(5,5) = 1.
   gb(6,5) = r(2)
   gb(7,5) = z(2)
   gb(8,5) = gb(4,4)
   gb(9,6) = 1.
   gb(10,6) = r(2)
   gb(11,6) = z(2)
   gb(12,6) = gb(4,4)
   gb(1,7) = 1.
   gb(2,7) = r(3)
   gb(3,7) = z(3)
   gb(4,7) = r(3)*z(3)
   gb(5,8) = 1.
   gb(6,8) = r(3)
   gb(7,8) = z(3)
   gb(8,8) = gb(4,7)
   gb(9,9) = 1.
   gb(10,9) = r(3)
   gb(11,9) = z(3)
   gb(12,9) = gb(4,7)
   gb(1,10) = 1.
   gb(2,10) = r(4)
   gb(3,10) = z(4)
   gb(4,10) = r(4)*z(4)
   gb(5,11) = 1.
   gb(6,11) = r(4)
   gb(7,11) = z(4)
   gb(8,11) = gb(4,10)
   gb(9,12) = 1.
   gb(10,12) = r(4)
   gb(11,12) = z(4)
   gb(12,12) = gb(4,10)
!
   IF ( .NOT.(lsys78) ) THEN
      gbp(1,1) = 1.D0
      gbp(2,1) = r(1)
      gbp(3,1) = z(1)
      gbp(4,1) = r(1)*z(1)
      gbp(1,2) = 1.D0
      gbp(2,2) = r(2)
      gbp(3,2) = z(2)
      gbp(4,2) = r(2)*z(2)
      gbp(1,3) = 1.D0
      gbp(2,3) = r(3)
      gbp(3,3) = z(3)
      gbp(4,3) = r(3)*z(3)
      gbp(1,4) = 1.D0
      gbp(2,4) = r(4)
      gbp(3,4) = z(4)
      gbp(4,4) = r(4)*z(4)
   ENDIF
!
   IF ( ismb(1)==0 ) GOTO 300
!
!     NO NEED TO COMPUTE DETERMINANT SINCE IT IS NOT USED SUBSEQUENTLY.
!
   ising = -1
   CALL inverd(12,gb,12,d(10),0,d(11),ising,sp)
   IF ( ising==2 ) THEN
      i = 26
      GOTO 700
   ELSE
!
      IF ( ksys78==1 ) CALL inverd(4,gbp,4,d(10),0,d(11),ising,sp)
      IF ( ising==2 ) THEN
         i = 26
         GOTO 700
      ELSE
         IF ( nogo ) RETURN
!
!       DELINT( 1) = (-1,0)
!       DELINT( 2) = (-1,1)
!       DELINT( 3) = (-1,2)
!       DELINT( 4) = ( 0,0)
!       DELINT( 5) = ( 0,1)
!       DELINT( 6) = ( 0,2)
!       DELINT( 7) = ( 1,0)
!       DELINT( 8) = ( 1,1)
!       DELINT( 9) = ( 1,2)
!       DELINT(10) = ( 2,0)
!       DELINT(11) = ( 2,1)
!       DELINT(12) = ( 3,0)
!
         i1 = 0
         DO i = 1 , 4
            ip = i - 2
            DO j = 1 , 3
               iq = j - 1
               i1 = i1 + 1
               IF ( i1==12 ) THEN
                  ip = 3
                  iq = 0
               ENDIF
               delint(i1) = rzintd(ip,iq,r,z,4)
            ENDDO
         ENDDO
!
!     LOCATE THE MATERIAL PROPERTIES IN THE MAT1 OR MAT3
!
         matidc = matid
         matflg = 7
         IF ( ksys78>0 ) matflg = 9
         eltemp = tempe
!
         gamr = dgama*degrad
         cosg = dcos(gamr)
         sing = dsin(gamr)
         sinth = sing
         costh = cosg
         CALL mat(idel)
         pzmat = .FALSE.
         IF ( setmat==4. .OR. setmat==5. ) pzmat = .TRUE.
         IF ( pzmat ) THEN
            rho = pzout(46)
            alf(1) = pzout(47)
            alf(2) = pzout(48)
            alf(3) = pzout(49)
            tzero = pzout(50)
            gsube = pzout(51)
         ELSE
            ksave = ksys78
            ksys78 = 0
            lsys78 = .TRUE.
         ENDIF
!
         IF ( setmat==2. ) THEN
!
!     MAT2 NOT LEGAL
!
            i = 126
            GOTO 700
         ELSE
!WKBI SPR94002 5/94
            dict5 = gsube
            IF ( ksys78<=0 ) THEN
               DO i = 1 , 3
                  anu(i) = anus(i)
                  e(i) = es(i)
               ENDDO
               v = anu(1)*e(2)/e(1)
               vz = anu(2)*e(3)/e(2)
               vr = anu(3)*e(1)/e(3)
               del = 1./(1.-v*anu(1)-vz*anu(2)-vr*anu(3)-anu(1)*anu(2)*anu(3)-v*vz*vr)
            ENDIF
!
!     COMPUTE ELASTIC CONSTANTS MATRIX FROM MATERIAL TO ELEMENT AXIS
!
            DO i = 1 , 45
               teo(i) = 0.
            ENDDO
!
            IF ( ksys78>0 ) THEN
!
!     PIEZOELECTRIC MATERIAL PROPERTIES STORED IN TEO(22-39)
!     DIELECTRIC MATERIAL PROPERTIES STORED IN TEO(40-45)
!     TEO(22-39) CONTAINS E-TRANSPOSE
!
               teo(1) = pzout(1)
               teo(2) = pzout(2)
               teo(3) = pzout(7)
               teo(4) = pzout(3)
               teo(5) = pzout(8)
               teo(6) = pzout(12)
               teo(7) = pzout(4)
               teo(8) = pzout(9)
               teo(9) = pzout(13)
               teo(10) = pzout(16)
               teo(11) = pzout(5)
               teo(12) = pzout(10)
               teo(13) = pzout(14)
               teo(14) = pzout(17)
               teo(15) = pzout(19)
               teo(16) = pzout(6)
               teo(17) = pzout(11)
               teo(18) = pzout(15)
               teo(19) = pzout(18)
               teo(20) = pzout(20)
               teo(21) = pzout(21)
               IF ( ksys78/=2 ) THEN
                  teo(22) = pzout(22)
                  teo(23) = pzout(28)
                  teo(24) = pzout(34)
                  teo(25) = pzout(23)
                  teo(26) = pzout(29)
                  teo(27) = pzout(35)
                  teo(28) = pzout(24)
                  teo(29) = pzout(30)
                  teo(30) = pzout(36)
                  teo(31) = pzout(25)
                  teo(32) = pzout(31)
                  teo(33) = pzout(37)
                  teo(34) = pzout(26)
                  teo(35) = pzout(32)
                  teo(36) = pzout(38)
                  teo(37) = pzout(27)
                  teo(38) = pzout(33)
                  teo(39) = pzout(39)
                  teo(40) = -pzout(40)
                  teo(41) = -pzout(41)
                  teo(42) = -pzout(42)
                  teo(43) = -pzout(43)
                  teo(44) = -pzout(44)
                  teo(45) = -pzout(45)
               ENDIF
            ELSE
               teo(1) = e(1)*(1.-anu(2)*vz)*del
               teo(2) = e(1)*(anu(3)+vz*v)*del
               teo(3) = e(3)*(1.-anu(1)*v)*del
               teo(4) = e(1)*(v+anu(3)*anu(2))*del
               teo(5) = e(2)*(vz+anu(1)*anu(3))*del
               teo(6) = e(2)*(1.-vr*anu(3))*del
               teo(10) = g(3)
               teo(15) = g(1)
               teo(21) = g(2)
            ENDIF
!
!     MATRIX EG STORED AS FOLLOWS IN EE
!      1
!      2  3
!      4  5  6
!      7  8  9 10
!     11 12 13 14 15
!     16 17 18 19 20 21
!
            c2 = cosg*cosg
            s2 = sing*sing
            c4 = c2*c2
            s4 = s2*s2
            c2s2 = c2*s2
            c3 = cosg*c2
            s3 = sing*s2
            cs2 = cosg*s2
            sc2 = sing*c2
            cs = cosg*sing
!
            ee(1) = teo(1)*c4 + teo(3)*s4 + 2.*c2s2*(teo(2)+2.*teo(10))
            ee(2) = teo(2)*(c4+s4) + c2s2*(teo(1)+teo(3)-4.0D0*teo(10))
            ee(3) = teo(1)*s4 + 2.*c2s2*(teo(2)+2.*teo(10)) + teo(3)*c4
            ee(4) = teo(4)*c2 + teo(5)*s2
            ee(5) = teo(4)*s2 + teo(5)*c2
            ee(6) = teo(6)
            ee(7) = cosg*sing*s2*(teo(2)-teo(3)+2.*teo(10)) + sing*cosg*c2*(teo(1)-teo(2)-2.*teo(10))
            ee(8) = sing*cosg*c2*(teo(2)-teo(3)+2.*teo(10)) + cosg*sing*s2*(teo(1)-teo(2)-2.*teo(10))
            ee(9) = sing*cosg*(teo(4)-teo(5))
            ee(10) = c2s2*(teo(1)-2.*teo(2)+teo(3)) + teo(10)*(c2-s2)**2
            ee(11) = 0.
            ee(12) = 0.
            ee(13) = 0.
            ee(14) = 0.
            ee(15) = teo(15)*c2 + teo(21)*s2
            ee(20) = cosg*sing*(teo(15)-teo(21))
            ee(21) = teo(15)*s2 + teo(21)*c2
!
!     COMPUTE HARMONIC COEFFICIENT
!
            mjho = mod(iecpt(1),1000) - 1
            ajho = mjho
            ajjho = ajho*ajho
!
!     FORM THE ELEMENT STIFFNESS MATRIX IN FIELD SYSTEM
!
            acurl(1) = (ee(6)+ajjho*ee(15))*delint(1)
            acurl(2) = (ee(4)+ee(6)+ajjho*ee(15))*delint(4)
            acurl(3) = (ee(6)+ajjho*ee(15))*delint(2) + ee(9)*delint(4)
            acurl(4) = (ee(4)+ee(6)+ajjho*ee(15))*delint(5) + ee(9)*delint(7)
            acurl(5) = ajho*(ee(6)+ee(15))*delint(1)
            acurl(6) = ajho*ee(6)*delint(4)
            acurl(7) = ajho*(ee(6)+ee(15))*delint(2) - ajho*ee(20)*delint(4)
            acurl(8) = ajho*ee(6)*delint(5) - ajho*ee(20)*delint(7)
            acurl(9) = ajjho*ee(20)*delint(1)
            acurl(10) = delint(4)*(ee(9)+ajjho*ee(20))
            acurl(11) = delint(4)*ee(5) + ajjho*delint(2)*ee(20)
            acurl(12) = delint(7)*ee(5) + delint(5)*(ee(9)+ajjho*ee(20))
            acurl(14) = (ee(1)+2.*ee(4)+ee(6)+ajjho*ee(15))*delint(7)
            acurl(15) = (ee(4)+ee(6)+ajjho*ee(15))*delint(5) + (ee(7)+ee(9))*delint(7)
            acurl(16) = (ee(1)+2.*ee(4)+ajjho*ee(15)+ee(6))*delint(8) + (ee(7)+ee(9))*delint(10)
            acurl(17) = ajho*(ee(4)+ee(6)+ee(15))*delint(4)
            acurl(18) = ajho*(ee(4)+ee(6))*delint(7)
            acurl(19) = ajho*(ee(4)+ee(6)+ee(15))*delint(5) - ajho*ee(20)*delint(7)
            acurl(20) = ajho*(ee(4)+ee(6))*delint(8) - ajho*ee(20)*delint(10)
            acurl(21) = ajjho*ee(20)*delint(4)
            acurl(22) = delint(7)*(ee(7)+ee(9)+ajjho*ee(20))
            acurl(23) = delint(7)*(ee(2)+ee(5)) + ajjho*delint(5)*ee(20)
            acurl(24) = delint(10)*(ee(2)+ee(5)) + delint(8)*(ee(7)+ee(9)) + delint(8)*ajjho*ee(20)
            acurl(27) = (ee(6)+ajjho*ee(15))*delint(3) + 2.*ee(9)*delint(5) + ee(10)*delint(7)
            acurl(28) = (ee(4)+ee(6)+ajjho*ee(15))*delint(6) + ee(10)*delint(10) + (ee(7)+2.*ee(9))*delint(8)
            acurl(29) = ajho*(ee(6)+ee(15))*delint(2) + ajho*ee(9)*delint(4)
            acurl(30) = ajho*ee(6)*delint(5) + ajho*ee(9)*delint(7)
            acurl(31) = ajho*(ee(6)+ee(15))*delint(3) + ajho*(ee(9)-ee(20))*delint(5)
            acurl(32) = ajho*(ee(9)-ee(20))*delint(8) + ajho*ee(6)*delint(6)
            acurl(33) = ajjho*ee(20)*delint(2)
            acurl(34) = delint(7)*ee(10) + delint(5)*(ee(9)+ajjho*ee(20))
            acurl(35) = delint(7)*ee(8) + delint(5)*ee(5) + ajjho*delint(3)*ee(20)
            acurl(36) = delint(10)*ee(8) + delint(8)*(ee(5)+ee(10)) + delint(6)*(ee(9)+ajjho*ee(20))
            acurl(40) = (ee(1)+2.*ee(4)+ee(6)+ajjho*ee(15))*delint(9) + (2.*ee(7)+2.*ee(9))*delint(11) + ee(10)*delint(12)
            acurl(41) = ajho*(ee(4)+ee(6)+ee(15))*delint(5) + ajho*ee(9)*delint(7)
            acurl(42) = ajho*(ee(4)+ee(6))*delint(8) + ajho*ee(9)*delint(10)
            acurl(43) = ajho*(ee(4)+ee(6)+ee(15))*delint(6) + ajho*(ee(9)-ee(20))*delint(8)
            acurl(44) = ajho*(ee(4)+ee(6))*delint(9) + ajho*(ee(9)-ee(20))*delint(11)
            acurl(45) = ajjho*ee(20)*delint(5)
            acurl(46) = delint(8)*(ee(7)+ee(9)+ajjho*ee(20)) + delint(10)*ee(10)
            acurl(47) = delint(8)*(ee(2)+ee(5)) + delint(10)*ee(8) + ajjho*delint(6)*ee(20)
            acurl(48) = delint(11)*(ee(2)+ee(5)+ee(10)) + delint(12)*ee(8) + delint(9)*(ee(7)+ee(9)+ajjho*ee(20))
            acurl(53) = (ee(15)+ajjho*ee(6))*delint(1)
            acurl(54) = ajjho*ee(6)*delint(4)
            acurl(55) = (ee(15)+ajjho*ee(6))*delint(2) - ee(20)*delint(4)
            acurl(56) = ajjho*ee(6)*delint(5) - ee(20)*delint(7)
            acurl(57) = ajho*ee(20)*delint(1)
            acurl(58) = ajho*delint(4)*(ee(9)+ee(20))
            acurl(59) = ajho*(delint(4)*ee(5)+delint(2)*ee(20))
            acurl(60) = ajho*(delint(7)*ee(5)+delint(5)*(ee(9)+ee(20)))
            acurl(66) = ajjho*ee(6)*delint(7)
            acurl(67) = ajjho*ee(6)*delint(5)
            acurl(68) = ajjho*ee(6)*delint(8)
            acurl(69) = 0.
            acurl(70) = ajho*delint(7)*ee(9)
            acurl(71) = ajho*delint(7)*ee(5)
            acurl(72) = ajho*(delint(10)*ee(5)+delint(8)*ee(9))
            acurl(79) = (ee(15)+ajjho*ee(6))*delint(3) - 2.*ee(20)*delint(5) + ee(21)*delint(7)
            acurl(80) = ajjho*ee(6)*delint(6) - ee(20)*delint(8) + ee(21)*delint(10)
            acurl(81) = ajho*(ee(20)*delint(2)-ee(21)*delint(4))
            acurl(82) = ajho*(delint(5)*(ee(9)+ee(20))-delint(7)*ee(21))
            acurl(83) = ajho*(delint(5)*(ee(5)-ee(21))+delint(3)*ee(20))
!
            IF ( .NOT.(lsys78) ) THEN
!
!     PIEZOELECTRIC MATERIAL PROPERTIES IN ELEMENT COORDINATES
!
               ee(37) = c3*teo(22) - s3*teo(26) + cs2*(teo(25)+2.0*teo(32)) - sc2*(teo(23)+2.0*teo(31))
               ee(38) = c3*teo(23) + s3*teo(25) + cs2*(teo(26)-2.0*teo(31)) + sc2*(teo(22)-2.0*teo(32))
               ee(39) = s2*teo(27) + c2*teo(24) - 2.0*cs*teo(33)
               ee(40) = c3*teo(25) - s3*teo(23) + cs2*(teo(22)-2.0*teo(32)) - sc2*(teo(26)-2.0*teo(31))
               ee(41) = c3*teo(26) + s3*teo(22) + cs2*(teo(23)+2.0*teo(31)) + sc2*(teo(25)+2.0*teo(32))
               ee(42) = s2*teo(24) + c2*teo(27) + 2.0*cs*teo(33)
               ee(43) = cosg*teo(28) - sing*teo(29)
               ee(44) = cosg*teo(29) + sing*teo(28)
               ee(45) = teo(30)
               ee(46) = c3*teo(31) + s3*teo(32) - cs2*(teo(23)-teo(26)+teo(31)) + sc2*(-teo(32)-teo(25)+teo(22))
               ee(47) = c3*teo(32) - s3*teo(31) - cs2*(teo(25)-teo(22)+teo(32)) + sc2*(teo(23)+teo(31)-teo(26))
               ee(48) = (c2-s2)*teo(33) + cs*(teo(24)-teo(27))
               ee(49) = c2*teo(34) + s2*teo(38) - cs*(teo(35)+teo(37))
               ee(50) = c2*teo(35) - s2*teo(37) + cs*(teo(34)-teo(38))
               ee(51) = cosg*teo(36) - sing*teo(39)
               ee(52) = c2*teo(37) - s2*teo(35) - cs*(teo(38)-teo(34))
               ee(53) = c2*teo(38) + s2*teo(34) + cs*(teo(35)+teo(37))
               ee(54) = cosg*teo(39) + sing*teo(36)
!
!     DIELECTRIC MATERIAL PROPERTIES IN ELEMENT COORDINTES
!
               ee(55) = s2*teo(43) - 2.0*cs*teo(41) + c2*teo(40)
               ee(56) = (c2-s2)*teo(41) - cs*(teo(43)-teo(40))
               ee(57) = -sing*teo(44) + cosg*teo(42)
               ee(59) = c2*teo(43) + 2.0*cs*teo(41) + s2*teo(40)
               ee(60) = cosg*teo(44) + sing*teo(42)
               ee(63) = teo(45)
            ENDIF
            acurl(84) = ajho*(delint(8)*(ee(5)-ee(21))+delint(6)*(ee(9)+ee(20)))
            acurl(92) = ee(21)*delint(12) + ajjho*ee(6)*delint(9)
            acurl(93) = -ajho*ee(21)*delint(7)
            acurl(94) = ajho*(delint(8)*ee(9)-delint(10)*ee(21))
            acurl(95) = ajho*delint(8)*(ee(5)-ee(21))
            acurl(96) = ajho*(delint(11)*(ee(5)-ee(21))+delint(9)*ee(9))
            acurl(105) = ajjho*ee(21)*delint(1)
            acurl(106) = ajjho*delint(4)*ee(21)
            acurl(107) = ajjho*delint(2)*ee(21)
            acurl(108) = ajjho*delint(5)*ee(21)
            acurl(118) = delint(7)*(ee(10)+ajjho*ee(21))
            acurl(119) = delint(7)*ee(8) + ajjho*delint(5)*ee(21)
            acurl(120) = delint(10)*ee(8) + delint(8)*(ee(10)+ajjho*ee(21))
            acurl(131) = delint(7)*ee(3) + ajjho*delint(3)*ee(21)
            acurl(132) = delint(10)*ee(3) + delint(8)*ee(8) + ajjho*delint(6)*ee(21)
            acurl(144) = delint(12)*ee(3) + 2.*delint(11)*ee(8) + delint(9)*(ee(10)+ajjho*ee(21))
!
            IF ( .NOT.(lsys78) ) THEN
               acurl(145) = delint(1)*ajho*(ajho*ee(51)-ee(45))
               acurl(146) = delint(4)*(ee(43)+ajho*(ajho*ee(51)-ee(49)-ee(45)))
               acurl(147) = delint(2)*ajho*(ajho*ee(51)-ee(45)) + delint(4)*(ee(44)-ajho*ee(50))
               acurl(148) = delint(5)*(ee(43)+ajho*(ajho*ee(51)-ee(49)-ee(45))) + delint(7)*(ee(44)-ajho*ee(50))
               acurl(149) = delint(4)*ajho*(ajho*ee(51)-ee(45)-ee(39))
               acurl(150) = delint(7)*(ee(43)+ee(37)+ajho*(ajho*ee(51)-ee(49)-ee(45)-ee(39)))
               acurl(151) = delint(5)*ajho*(ajho*ee(51)-ee(45)-ee(39)) + delint(7)*(ee(44)+ee(38)-ajho*ee(50))
               acurl(152) = delint(8)*(ee(43)+ee(37)+ajho*(ajho*ee(51)-ee(49)-ee(45)-ee(39))) + delint(10)                          &
                          & *(ee(44)+ee(38)-ajho*ee(50))
               acurl(153) = delint(2)*ajho*(ajho*ee(51)-ee(45)) - delint(4)*ajho*ee(48)
               acurl(154) = delint(5)*(ee(43)+ajho*(ajho*ee(51)-ee(49)-ee(45))) + delint(7)*(ee(46)-ajho*ee(48))
               acurl(155) = delint(3)*ajho*(ajho*ee(51)-ee(45)) + delint(5)*(ee(44)-ajho*(ee(50)+ee(48))) + delint(7)*ee(47)
               acurl(156) = delint(6)*(ee(43)+ajho*(ajho*ee(51)-ee(49)-ee(45))) + delint(8)*(ee(46)+ee(44)-ajho*(ee(50)+ee(48)))    &
                          & + delint(10)*ee(47)
               acurl(157) = delint(5)*ajho*(ajho*ee(51)-ee(45)-ee(39)) - delint(7)*ajho*ee(48)
               acurl(158) = delint(8)*(ee(43)+ee(47)+ajho*(ajho*ee(51)-ee(49)-ee(45)-ee(39))) - delint(10)*(ee(46)-ajho*ee(48))
               acurl(159) = delint(6)*ajho*(ajho*ee(51)-ee(45)-ee(39)) + delint(8)*(ee(44)+ee(38)-ajho*(ee(50)+ee(48))) + delint(10)&
                          & *ee(47)
               acurl(160) = delint(9)*(ee(43)+ee(37)+ajho*(ajho*ee(51)-ee(49)-ee(45)-ee(39))) + delint(11)                          &
                          & *(ee(46)+ee(44)+ee(38)-ajho*(ee(50)+ee(48))) + delint(12)*ee(47)
               acurl(161) = delint(1)*ajho*(ee(51)-ajho*ee(45))
               acurl(162) = delint(4)*(-ee(49)+ajho*(ee(51)+ee(43)-ajho*ee(45)))
               acurl(163) = delint(2)*ajho*(ee(51)-ajho*ee(45)) + delint(4)*(ajho*ee(44)-ee(50))
               acurl(164) = delint(5)*(-ee(49)+ajho*(ee(51)+ee(43)-ajho*ee(51))) + delint(7)*(ajho*ee(44)-ee(50))
               acurl(165) = -delint(4)*ajjho*ee(45)
               acurl(166) = delint(7)*ajho*(ee(43)-ajho*ee(45))
               acurl(167) = delint(7)*ajho*ee(44) - delint(5)*ajjho*ee(45)
               acurl(168) = delint(8)*ajho*(ee(43)-ajho*ee(45)) + delint(10)*ajho*ee(44)
               acurl(169) = delint(2)*ajho*(ee(51)-ajho*ee(45)) - delint(4)*ajho*ee(54)
               acurl(170) = delint(5)*(-ee(49)+ajho*(ee(51)+ee(43)-ajho*ee(45))) + delint(7)*(ee(52)-ajho*ee(54))
               acurl(171) = delint(3)*ajho*(ee(51)-ajho*ee(45)) + delint(5)*(ajho*(ee(44)-ee(54))-ee(50)) + delint(7)*ee(53)
               acurl(172) = delint(6)*(-ee(49)+ajho*(ee(51)+ee(43)-ajho*ee(45))) + delint(8)*(ee(52)-ee(50)+ajho*(ee(44)-ee(54)))   &
                          & + delint(10)*ee(53)
               acurl(173) = -delint(5)*ajjho*ee(45) - delint(7)*ajho*ee(54)
               acurl(174) = delint(8)*ajho*(ee(43)-ajho*ee(45)) + delint(10)*(ee(54)-ajho*ee(54))
               acurl(175) = -delint(6)*ajjho*ee(45) + delint(8)*ajho*(ee(44)-ee(54)) + delint(10)*ee(53)
               acurl(176) = delint(9)*ajho*(ee(43)-ajho*ee(45)) + delint(11)*(ee(52)+ajho*(ee(44)-ee(54))) + delint(12)*ee(53)
               acurl(177) = delint(1)*ajjho*ee(54)
               acurl(178) = delint(4)*ajho*(ajho*ee(54)-ee(52))
               acurl(179) = delint(2)*ajjho*ee(54) - delint(4)*ajho*ee(53)
               acurl(180) = delint(5)*ajho*(ajho*ee(54)-ee(52)) - delint(7)*ajho*ee(53)
               acurl(181) = delint(4)*ajho*(ajho*ee(54)-ee(48))
               acurl(182) = delint(7)*(ee(46)+ajho*(ajho*ee(54)-ee(52)-ee(48)))
               acurl(183) = delint(5)*ajho*(ajho*ee(54)-ee(48)) + delint(7)*(ee(47)-ajho*ee(53))
               acurl(184) = delint(8)*(ee(46)+ajho*(ajho*ee(54)-ee(52)-ee(48))) + delint(10)*(ee(47)-ajho*ee(53))
               acurl(185) = delint(2)*ajjho*ee(54) - delint(4)*ajho*ee(42)
               acurl(186) = delint(5)*ajho*(ajho*ee(54)-ee(52)) + delint(7)*(ee(40)-ajho*ee(42))
               acurl(187) = delint(3)*ajjho*ee(54) - delint(5)*ajho*(ee(53)+ee(42)) + delint(7)*ee(41)
               acurl(188) = delint(6)*ajho*(ajho*ee(54)-ee(52)) + delint(8)*(ee(40)-ajho*(ee(53)+ee(42))) + delint(10)*ee(41)
               acurl(189) = -delint(5)*ajho*ee(48) + delint(4)*ajjho*ee(54) - delint(7)*ajho*ee(42)
               acurl(190) = delint(8)*(ee(46)-ajho*ee(48)) + delint(7)*ajho*(ajho*ee(54)-ee(52)) + delint(10)*(ee(40)-ajho*ee(42))
               acurl(191) = -delint(6)*ajho*ee(48) + delint(5)*ajjho*ee(54) + delint(8)*(ee(47)-ajho*ee(42)) - delint(7)*ajho*ee(53)&
                          & + delint(10)*ee(41)
               acurl(192) = delint(9)*(ee(46)-ajho*ee(48)) + delint(8)*ajho*(ajho*ee(54)-ee(52)) + delint(11)                       &
                          & *(ee(47)+ee(40)-ajho*ee(42)) - delint(10)*ajho*ee(53) + delint(12)*ee(41)
!
               acurl(193) = delint(1)*ajjho*ee(63)
               acurl(194) = delint(4)*ajho*(ajho*ee(63)-ee(57))
               acurl(195) = delint(2)*ajjho*ee(63) - delint(4)*ajho*ee(60)
               acurl(196) = delint(5)*ajho*(ajho*ee(63)-ee(57)) - delint(7)*ajho*ee(60)
               acurl(197) = delint(4)*ajho*(ajho*ee(63)-ee(57))
               acurl(198) = delint(7)*(ajjho*ee(63)-2.0*ajho*ee(57)+ee(55))
               acurl(199) = delint(5)*ajho*(ajho*ee(63)-ee(57)) + delint(7)*(ee(56)-ajho*ee(60))
               acurl(200) = delint(8)*(ajjho*ee(63)-2.0*ajho*ee(57)+ee(55)) + delint(10)*(ee(56)-ajho*ee(60))
               acurl(201) = delint(2)*ajjho*ee(63) - delint(4)*ajho*ee(60)
               acurl(202) = delint(5)*ajho*(ajho*ee(63)-ee(57)) + delint(7)*(ee(56)-ajho*ee(60))
               acurl(203) = delint(3)*ajjho*ee(63) - delint(5)*2.0*ajho*ee(60) + delint(7)*ee(59)
               acurl(204) = delint(6)*ajho*(ajho*ee(63)-ee(57)) + delint(8)*(ee(56)-2.0*ajho*ee(60)) + delint(10)*ee(59)
               acurl(205) = delint(5)*ajho*(ajho*ee(63)-ee(57)) - delint(7)*ajho*ee(60)
               acurl(206) = delint(8)*(ajjho*ee(63)-2.0*ee(57)+ee(55)) + delint(10)*(ee(56)-ajho*ee(60))
               acurl(207) = delint(6)*ajho*(ajho*ee(63)-ee(57)) + delint(8)*(ee(56)-2.0*ajho*ee(60)) + delint(10)*ee(59)
               acurl(208) = delint(9)*(ajjho*ee(63)-2.0*ajho*ee(57)+ee(55)) + 2.0*delint(11)*(ee(56)-ajho*ee(60)) + delint(12)      &
                          & *ee(59)
            ENDIF
!
!     TRANSFORM THE ELEMENT STIFFNESS MATRIX FROM FIELD SYSTEM
!     TO GRID POINT DEGREES OF FREEDOM
!
!     EXPAND ACURL INTO (12X12)
!
            DO ib = 2 , 12
               ic = 13*ib - 25
               i = ic
               DO j = ib , 12
                  ic = ic + 12
                  i = i + 1
                  acurl(ic) = acurl(i)
               ENDDO
            ENDDO
!
            dgam = pi
            IF ( ajho==0. ) dgam = twopi
            DO i = 1 , 144
               acurl(i) = acurl(i)*dgam
            ENDDO
!
            IF ( .NOT.(lsys78) ) THEN
               DO i = 145 , 208
                  acurl(i) = acurl(i)*dgam
               ENDDO
            ENDIF
!
            CALL gmmatd(gb,12,12,1,acurl,12,12,0,d)
            CALL gmmatd(d,12,12,0,gb,12,12,0,ak)
!
            IF ( .NOT.(lsys78) ) THEN
               CALL gmmatd(gb,12,12,1,acurp1,12,4,0,d1)
               CALL gmmatd(d1,12,4,0,gbp,4,4,0,akuph)
               CALL gmmatd(gbp,4,4,1,acurp2,4,4,0,d2)
               CALL gmmatd(d2,4,4,0,gbp,4,4,0,akph2)
            ENDIF
!
            DO i = 1 , 256
               akj(i) = 0.
            ENDDO
!
!     COORDINATE SYSTEMS NOT POSSIBLE WITH RINGAX    CODE BELOW COULD
!     IMPLEMENT IT.
! **  IF FOLLOWING CODE IS IMPLEMENTED MUST BE MODIFIED FOR PIEZO-
!     ELECTRIC
!
            i = 0
            IF ( i/=0 ) THEN
!**
!
               DO i = 1 , 4
                  IF ( ics(i)/=0 ) THEN
                     k = 9*(i-1) + 1
                     CALL transd(ics(i),d(k))
                  ENDIF
               ENDDO
!
!     SELECT THE APPROPRIATE SUB MATRIX FOR TRANSFORMATION
!
               DO ipp = 1 , 4
                  ir1 = 3*(ipp-1) + 1
                  iapp = 9*(ipp-1) + 1
                  DO i = 1 , 4
                     ic1 = 3*(i-1) + 1
                     irc = (ir1-1)*12 + ic1
                     akt(1) = ak(irc)
                     akt(2) = ak(irc+1)
                     akt(3) = ak(irc+2)
                     akt(4) = ak(irc+12)
                     akt(5) = ak(irc+13)
                     akt(6) = ak(irc+14)
                     akt(7) = ak(irc+24)
                     akt(8) = ak(irc+25)
                     akt(9) = ak(irc+26)
!
!     MORE COORDINATE SYSTEM CHANGE CODE
!     TRANSFORM  THE STIFFNESS  SUB MATRICES  AS NECESSARY
!
                     iakt = 1
                     IF ( ics(ipp)/=0 ) THEN
                        CALL gmmatd(d(iapp),3,3,1,akt(1),3,3,0,akt(10))
                        iakt = 10
                        IF ( ics(i)==0 .AND. ics(ipp)==0 ) CYCLE
                        gor = g(1)
                     ENDIF
                     IF ( ics(i)/=0 ) THEN
                        iai = 9*(i-1) + 1
                        CALL gmmatd(akt(iakt),3,3,0,d(iai),3,3,0,akt(iakt+9))
                        iakt = iakt + 9
                     ENDIF
!
!     REPLACE THE TRANSFORMED MATRICES IN ORIGINAL MATRIX
!
                     ak(irc) = akt(iakt)
                     ak(irc+1) = akt(iakt+1)
                     ak(irc+2) = akt(iakt+2)
                     ak(irc+12) = akt(iakt+3)
                     ak(irc+13) = akt(iakt+4)
                     ak(irc+14) = akt(iakt+5)
                     ak(irc+24) = akt(iakt+6)
                     ak(irc+25) = akt(iakt+7)
                     ak(irc+26) = akt(iakt+8)
!
                  ENDDO
               ENDDO
            ENDIF
!
!     CREATE AN ARRAY POINTING TO THE GRIDS ACCORDING TO INCREASING
!     SIL  VALUE
!
            ASSIGN 200 TO korm
         ENDIF
      ENDIF
   ENDIF
 100  DO i = 1 , 4
      ipart(i) = iecpt(i+1)
   ENDDO
   i = -4
   DO
      j = 0
      DO kk = 1 , 4
         IF ( ipart(kk)>=j ) THEN
            j = ipart(kk)
            l = kk
         ENDIF
      ENDDO
      ipart(l) = i
      i = i + 1
      IF ( i>=0 ) THEN
         DO i = 1 , 4
            ipart(i) = -ipart(i)
         ENDDO
         isort = 1
         GOTO korm
      ENDIF
   ENDDO
!
!     REARRANGE  AK  INTO AKJ BY INCREASING SIL VALUE
!     NOTE AKJ ALREADY INITALIZED TO ZERO
!
 200  DO i = 1 , 4
      it = ipart(i)
      DO j = 1 , 4
         jt = ipart(j)
         DO k = 1 , 3
            DO l = 1 , 3
               ikj = (it-1)*64 + (jt-1)*4 + (k-1)*16 + l
               IF ( masor==1 ) ikj = (it-1)*36 + (jt-1)*3 + (k-1)*12 + l
               ik = (i-1)*36 + (j-1)*3 + (k-1)*12 + l
               akj(ikj) = ak(ik)
!
               IF ( masor/=1 ) THEN
                  IF ( .NOT.(lsys78) ) THEN
                     ikja = ikj - l + 4
                     ika = (ik-l)/3 + 1
                     ikjb = (jt-1)*64 + 48 + (it-1)*4 + k
                     ikjc = (it-1)*64 + 52 + (jt-1)*4
                     ikc = (i-1)*4 + j
                     akj(ikja) = akuph(ika)
                     akj(ikjb) = akuph(ika)
                     akj(ikjc) = akph2(ikc)
                  ENDIF
               ENDIF
            ENDDO
         ENDDO
      ENDDO
   ENDDO
   IF ( masor==1 ) THEN
!
      dict(1) = estid
      dict(2) = 1
      dict(3) = 12
      dict(4) = 7
!WKBD SPR94002 5/94      DICT5   =  0.
      ip = iprec
!
      CALL emgout(akj,akj,144,1,dict,2,ip)
      GOTO 500
   ELSE
!
!     SET UP CONSTANTS AND OUTPUT AKJ
!
      dict(1) = estid
      dict(2) = 1
      dict(3) = 16
      dict(4) = 15
      ip = iprec
      CALL emgout(akj,akj,256,1,dict,1,ip)
   ENDIF
!
!     COME HERE TO CALCULATE THE MASS  MATRIX. THIS ROUTINE WILL
!     CALCULATE EITHER THE CONSISTENT OR LUMPED MASS MATRICES
!     DEPENDING ON THE PARAMETER ICM BAR
!
!     IF STIFFNESS MATRIX NOT NEEDED WE HAVE ALL WE NEED FOR THE
!     MASS MATRIX CALCULATIONS
!
 300  IF ( ismb(2)==0 .AND. .NOT.pzmat ) ksys78 = ksave
   IF ( ismb(2)==0 ) RETURN
   IF ( icmbar>=0 ) THEN
      i1 = 0
      DO i = 1 , 3
         ip = i
         DO j = 1 , 3
            iq = j - 1
            i1 = i1 + 1
            delint(i1) = rzintd(ip,iq,r,z,4)
         ENDDO
      ENDDO
   ENDIF
!
   IF ( ismb(1)==0 ) THEN
      matidc = matid
      matflg = 7
      IF ( ksys78>0 ) matflg = 9
      eltemp = tempe
      gamr = dgama*degrad
      costh = dcos(gamr)
      sinth = dsin(gamr)
      CALL mat(idel)
      IF ( ksys78>0 ) rho = pzout(46)
      IF ( setmat==2. ) THEN
         i = 126
         GOTO 700
      ENDIF
   ENDIF
!
!     COMPUTE THE HARMONIC COEFFICIENT
!
   mjho = mod(iecpt(1),1000) - 1
   ajho = mjho
   rhod = rho*pi
   IF ( ajho==0.D0 ) rhod = 2.*rhod
   IF ( icmbar<0 ) THEN
!
!     LUMPED MASS CALCULATIONS HANDLED HERE
!
      ar = (r(1)*(z(2)-z(4))+r(2)*(z(3)-z(1))+r(3)*(z(4)-z(2))+r(4)*(z(1)-z(3)))/2.
      akj(1) = rhod*(r(1)+r(2)+r(3)+r(4))/4.*ar
      akj(1) = akj(1)/4.0D0
      DO i = 2 , 12
         akj(i) = akj(1)
      ENDDO
!
      dict(1) = estid
      dict(2) = 2
      dict(3) = 12
      dict(4) = 7
!WKBD SPR94002 5/94      DICT5   = 0.
      ip = iprec
!
      CALL emgout(akj,akj,12,1,dict,2,ip)
      GOTO 500
   ELSE
!
!     COMPUTE THE CONSISTENT MASS MATRIX IN FIELD COORDINATES
!
      DO i = 1 , 12
         DO j = 1 , 12
            bmass(i,j) = 0.
         ENDDO
      ENDDO
      bmass(1,1) = delint(1)
      bmass(1,2) = delint(4)
      bmass(1,3) = delint(2)
      bmass(1,4) = delint(5)
      bmass(2,2) = delint(7)
      bmass(2,3) = delint(5)
      bmass(2,4) = delint(8)
      bmass(3,3) = delint(3)
      bmass(3,4) = delint(6)
      bmass(4,4) = delint(9)
      bmass(5,5) = delint(1)
      bmass(5,6) = delint(4)
      bmass(5,7) = delint(2)
      bmass(5,8) = delint(5)
      bmass(6,6) = delint(7)
      bmass(6,7) = delint(5)
      bmass(6,8) = delint(8)
      bmass(7,7) = delint(3)
      bmass(7,8) = delint(6)
      bmass(8,8) = delint(9)
      bmass(9,9) = delint(1)
      bmass(9,10) = delint(4)
      bmass(9,11) = delint(2)
      bmass(9,12) = delint(5)
      bmass(10,10) = delint(7)
      bmass(10,11) = delint(5)
      bmass(10,12) = delint(8)
      bmass(11,11) = delint(3)
      bmass(11,12) = delint(6)
      bmass(12,12) = delint(9)
      DO ib = 2 , 12
         ic = 13*ib - 25
         i = ic
         DO j = ib , 12
            ic = ic + 12
            i = i + 1
            bmbss(i) = bmbss(ic)
         ENDDO
      ENDDO
      DO i = 1 , 144
         bmbss(i) = bmbss(i)*rhod
      ENDDO
!
!     TRANSFORM THE ELEMENT MASS MATRIX FROM FIELD COORDINATES TO
!     GRID  POINT DEGREES  OF FREEDOM
!
      CALL gmmatd(gb,12,12,1,bmass,12,12,0,d)
      CALL gmmatd(d,12,12,0,gb,12,12,0,ak)
      DO i = 1 , 256
         akj(i) = 0.
      ENDDO
      IF ( isort/=1 ) THEN
         ASSIGN 400 TO korm
         GOTO 100
      ENDIF
   ENDIF
!
!     REARRANGE AK INTO AKJ BY INCREASING SIL VALUE
!
 400  masor = 1
   GOTO 200
 500  IF ( .NOT.pzmat ) ksys78 = ksave
   RETURN
 600  i = 37
 700  IF ( idel1/=idel2 ) THEN
      idel2 = idel1
      ics(1) = idel1
      ics(2) = jax
      CALL mesage(30,i,ics)
   ENDIF
   nogo = .TRUE.
   GOTO 500
END SUBROUTINE trapad