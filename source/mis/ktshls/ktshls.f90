!*==ktshls.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE ktshls
   IMPLICIT NONE
   USE c_blank
   USE c_emgdic
   USE c_emgest
   USE c_emgprm
   USE c_matin
   USE c_matout
   USE c_sma1cl
   USE c_sma1dp
   USE c_sma2dp
   USE c_system
   USE c_xmssg
!
! Local variable declarations rewritten by SPAG
!
   REAL :: a , a1 , a1sq , a2 , a2sq , a3 , a3sq , amass , area , b , c , c1 , c10 , c2 , c3 , c4 , c5 , c6 , c7 , c8 , c9 , d11 ,  &
         & d12 , d13 , d132 , d22 , d23 , d232 , d33 , d334 , determ , dista , distb , distc , g11 , g12 , g13 , g22 , g23 , g33 ,  &
         & h4 , h5 , h6 , j11 , j12 , j22 , nsm , rho , rix , riy , rjx , rjy , rkx , rky , rlx , rly , rmnx , rmny , rmx , rmx1 ,  &
         & rmy , rmy1 , rnx , rnx1 , rny , rny1 , s11 , s13 , s22 , s23 , s33 , sb1 , sb10 , sb11 , sb12 , sb13 , sb14 , sb15 ,     &
         & sb16 , sb17
   REAL , SAVE :: blank , degra
   REAL , DIMENSION(30,30) :: cm1
   REAL , DIMENSION(900) :: cms
   REAL , DIMENSION(1296) :: cmt
   REAL , DIMENSION(36,36) :: ctm
   INTEGER :: i , i1 , i2 , i3 , icode , idele , ii , ij , ijk , ioutpt , ipass , ising , ism , ismall , ix , ix0 , ix01 , ix011 ,  &
            & ix1 , ixiy0 , ixky0 , ixky1 , ixky2 , ixmyr , ixmyr1 , ixp1 , ixr01 , ixr1 , iy , iykx0 , iykx1 , iykx2 , iymxr , j , &
            & j1 , ji , jj , jx , jx0 , jx01 , jx011 , jx1 , jxjy0 , jxly0 , jxly1 , jxly2 , jxnys , jxnys1 , jxp1 , jxs01 , jxs1 , &
            & jy , jylx0 , jylx1 , jylx2 , jynxs1 , k , k1 , k2 , kx , kx0 , kx01 , kx1 , kxky0 , kxmyr , kxmyr1 , kxp1 , kxr01 ,   &
            & kxr1 , ky , l , l1 , lx , lx0 , lx01 , lx1 , lxly0 , lxnys , lxnys1 , lxp1
   INTEGER , DIMENSION(42) :: iest
   LOGICAL :: imass , nots , uniben , unimem
   INTEGER , DIMENSION(6,3) :: ind
   REAL , DIMENSION(1024) :: kshl , mshl
   REAL , DIMENSION(36) :: ksup , ksupt
   INTEGER :: lxs01 , lxs1 , ly , m , matid1 , matid2 , matid3 , mx , mx0 , mx01 , mx011 , mx0x , mx1 , mx1x , mx2 , mx2x , mx3 ,   &
            & mx3x , mxiyr , mxiyr1 , mxkyr , mxkyr1 , mxmyr1 , mxp1 , my , my1 , my1x , ndof , nsq , nx , nx0 , nx01 , nx011 ,     &
            & nx0y , nx1 , nx1y , nx2 , nx2y , nx3 , nx3y , nxjys , nxjys1 , nxlys , nxlys1 , nxnys1 , nxp1 , ny , ny1 , ny1y ,     &
            & sil1 , sil2
   INTEGER , DIMENSION(2) , SAVE :: name
   REAL , DIMENSION(960) :: qks
   REAL , DIMENSION(20,20) :: qqq
   REAL , DIMENSION(360) :: qqqinv
   INTEGER , DIMENSION(3) , SAVE :: rk , sk
   REAL :: sb18 , sb19 , sb2 , sb20 , sb21 , sb22 , sb23 , sb24 , sb25 , sb26 , sb27 , sb28 , sb29 , sb3 , sb30 , sb31 , sb32 ,     &
         & sb33 , sb34 , sb35 , sb36 , sb37 , sb38 , sb39 , sb4 , sb40 , sb41 , sb5 , sb6 , sb7 , sb8 , sb9 , st , st1 , st11 ,     &
         & st121 , st122 , st131 , st132 , st133 , st22 , st231 , st232 , st233 , st331 , st332 , tbend1 , tbend3 , tbend5 ,        &
         & theta1 , thetam , thk1 , thk2 , thk3 , tmem1 , tmem3 , tmem5 , tshr , tshr1 , tshr3 , tshr5 , vol
   INTEGER , DIMENSION(10) , SAVE :: xthk , ythk
   INTEGER , DIMENSION(32) , SAVE :: xu , xv , xw , yu , yv , yw
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
!     ECPT ENTRIES
!
!     ECPT( 1) = ELEMENT ID                                     INTEGER
!     ECPT( 2) = SCALAR INDEX NUMBER FOR GRID POINT 1           INTEGER
!     ECPT( 3) = SCALAR INDEX NUMBER FOR GRID POINT 2           INTEGER
!     ECPT( 4) = SCALAR INDEX NUMBER FOR GRID POINT 3           INTEGER
!     ECPT( 5) = SCALAR INDEX NUMBER FOR GRID POINT 4           INTEGER
!     ECPT( 6) = SCALAR INDEX NUMBER FOR GRID POINT 5           INTEGER
!     ECPT( 7) = SCALAR INDEX NUMBER FOR GRID POINT 6           INTEGER
!     ECPT( 8) = THETA                                          REAL
!     ECPT( 9) = MATERIAL ID 1                                  INTEGER
!     ECPT(10) = THICKNESS T1 AT GRID POINT G1
!     ECPT(11) = THICKNESS T3 AT GRID POINT G3
!     ECPT(12) = THICKNESS T5 AT GRID POINT G5
!     ECPT(13) = MATERIAL ID 2                                  INTEGER
!     ECPT(14) = THICKNESS TBEND1 FOR BENDING AT GRID POINT G1
!     ECPT(15) = THICKNESS TBEND3 FOR BENDING AT GRID POINT G3
!     ECPT(16) = THICKNESS TBEND5 FOR BENDING AT GRID POINT G5
!     ECPT(17) = MATERIAL ID 3                                  INTEGER
!     ECPT(18) = THICKNESS TSHR1 FOR TRANSVERSE SHEAR AT GRID POINT G1
!     ECPT(19) = THICKNESS TSHR3 FOR TRANSVERSE SHEAR AT GRID POINT G3
!     ECPT(20) = THICKNESS TSHR5 FOR TRANSVERSE SHEAR AT GRID POINT G5
!     ECPT(21) = NON-STRUCTURAL MASS                            REAL
!     ECPT(22) = DISTANCE Z11 FOR STRESS CALCULATION  AT GRID POINT G1
!     ECPT(23) = DISTANCE Z21 FOR STRESS CALCULATION  AT GRID POINT G1
!     ECPT(24) = DISTANCE Z13 FOR STRESS CALCULATION  AT GRID POINT G3
!     ECPT(25) = DISTANCE Z23 FOR STRESS CALCULATION  AT GRID POINT G3
!     ECPT(26) = DISTANCE Z15 FOR STRESS CALCULATION  AT GRID POINT G5
!     ECPT(27) = DISTANCE Z25 FOR STRESS CALCULATION  AT GRID POINT G5
!
!     X1,Y1,Z1 FOR ALL SIX POINTS ARE  IN NASTRAN BASIC SYSTEM
!
!     ECPT(28) = COORDINATE SYSTEM ID FOR GRID A                INTEGER
!     ECPT(29) = COORDINATE X1                                  REAL
!     ECPT(30) = COORDINATE Y1                                  REAL
!     ECPT(31) = COORDINATE Z1                                  REAL
!     ECPT(32) = COORDINATE SYSTEM ID FOR GRID B                INTEGER
!     ECPT(33) = COORDINATE X1                                  REAL
!     ECPT(34) = COORDINATE Y1                                  REAL
!     ECPT(35) = COORDINATE Z1                                  REAL
!     ECPT(36) = COORDINATE SYSTEM ID FOR GRID C                INTEGER
!     ECPT(37) = COORDINATE X1                                  REAL
!     ECPT(38) = COORDINATE Y1                                  REAL
!     ECPT(39) = COORDINATE Z1                                  REAL
!     ECPT(40) = COORDINATE SYSTEM ID FOR GRID D                INTEGER
!     ECPT(41) = COORDINATE X1                                  REAL
!     ECPT(42) = COORDINATE Y1                                  REAL
!     ECPT(43) = COORDINATE Z1                                  REAL
!     ECPT(44) = COORDINATE SYSTEM ID FOR GRID E                INTEGER
!     ECPT(45) = COORDINATE X1                                  REAL
!     ECPT(46) = COORDINATE Y1                                  REAL
!     ECPT(47) = COORDINATE Z1                                  REAL
!     ECPT(48) = COORDINATE SYSTEM ID FOR GRID F                INTEGER
!     ECPT(49) = COORDINATE X1                                  REAL
!     ECPT(50) = COORDINATE Y1                                  REAL
!     ECPT(51) = COORDINATE Z1                                  REAL
!     EST (52) = ELEMENT TEMPERATURE
!
!                     RK AND SK ARE EXPONENTS IN THICKNESS VARIATION
!
!     SMA1 WORKING STORAGE
!
!     EQUIVALENCE IECPT WITH ECPT IN COMMON BLOCK /SMA1ET/ SINCE ECPT IS
!     A MIXED INTEGER AND REAL ARRAY
!
   !>>>>EQUIVALENCE (C1,Cc(1)) , (C2,Cc(2)) , (C3,Cc(3)) , (C4,Cc(4)) , (C5,Cc(5)) , (C6,Cc(6)) , (C7,Cc(7)) , (C8,Cc(8)) , (C9,Cc(9)) , &
!>>>>    & (C10,Cc(10)) , (Ksub(1,1),Ksup(1)) , (Ksubt(1,1),Ksupt(1)) , (cmt(1),ctm(1,1)) , (qks(1),cmt(1025))
   !>>>>EQUIVALENCE (a,dista) , (b,distb) , (c,distc) , (Iest(1),Est(1))
   !>>>>EQUIVALENCE (cmt(1),kshl(1),mshl(1),qqq(1,1))
   !>>>>EQUIVALENCE (Ksystm(2),Ioutpt)
   !>>>>EQUIVALENCE (thk1,tbend1) , (thk2,tbend3) , (thk3,tbend5)
   !>>>>EQUIVALENCE (cm1(1,1),cms(1)) , (Ind(1,1),Index(1,1))
   DATA xu/0 , 1 , 0 , 2 , 1 , 0 , 26*0/ , yu/0 , 0 , 1 , 0 , 1 , 2 , 26*0/ , xv/6*0 , 0 , 1 , 0 , 2 , 1 , 0 , 20*0/ , yv/6*0 , 0 , &
      & 0 , 1 , 0 , 1 , 2 , 20*0/ , xw/12*0 , 0 , 1 , 0 , 2 , 1 , 0 , 3 , 2 , 1 , 0 , 4 , 3 , 2 , 1 , 0 , 5 , 3 , 2 , 1 ,           &
      & 0/yw/12*0 , 0 , 0 , 1 , 0 , 1 , 2 , 0 , 1 , 2 , 3 , 0 , 1 , 2 , 3 , 4 , 0 , 2 , 3 , 4 , 5/
   DATA blank , name/4H     , 4HTRSH , 4HL   /
   DATA rk/0 , 1 , 0/
   DATA sk/0 , 0 , 1/
   DATA degra/0.0174532925/
   DATA xthk/0 , 1 , 0 , 2 , 1 , 0 , 3 , 2 , 1 , 0/
   DATA ythk/0 , 0 , 1 , 0 , 1 , 2 , 0 , 1 , 2 , 3/
!
   dict(1) = estid
!
!     COMPONENT CODE,ICODE,IS  111111  AND HAS A VALUE OF 63
!
   icode = 63
   ndof = 36
   nsq = ndof**2
   dict(2) = 1
   dict(3) = ndof
   dict(4) = icode
   dict(5) = gsube
   nots = .FALSE.
   imass = .FALSE.
   IF ( nom>0 ) imass = .TRUE.
   ipass = 1
   idele = iest(1)
   DO i = 1 , 6
      nl(i) = iest(i+1)
   ENDDO
   thetam = est(8)
   matid1 = iest(9)
   tmem1 = est(10)
   tmem3 = est(11)
   tmem5 = est(12)
   matid2 = iest(13)
   tbend1 = (est(14)*12.0)**0.3333333333
   tbend3 = (est(15)*12.0)**0.3333333333
   tbend5 = (est(16)*12.0)**0.3333333333
   matid3 = iest(17)
   tshr1 = est(18)
   tshr3 = est(19)
   tshr5 = est(20)
   nsm = est(21)
   j = 0
   DO i = 28 , 48 , 4
      j = j + 1
      ics(j) = iest(i)
      xc(j) = est(i+1)
      yc(j) = est(i+2)
      zc(j) = est(i+3)
   ENDDO
!
!     IF TMEM3 OR TMEM5 EQUAL TO ZERO OR BLANK, THEY WILL BE
!     SET EQUAL TO TMEM1 SO ALSO FOR TSHR3,TSHR5,TBEND3 AND TBEND5
!
   IF ( tmem3==0.0 .OR. tmem3==blank ) tmem3 = tmem1
   IF ( tmem5==0.0 .OR. tmem5==blank ) tmem5 = tmem1
   IF ( tshr3==0.0 .OR. tshr3==blank ) tshr3 = tshr1
   IF ( tshr5==0.0 .OR. tshr5==blank ) tshr5 = tshr1
   IF ( tshr1==0.0 ) nots = .TRUE.
   tshr = (tshr1+tshr3+tshr5)/3.0
   IF ( tbend3==0.0 .OR. tbend3==blank ) tbend3 = tbend1
   IF ( tbend5==0.0 .OR. tbend5==blank ) tbend5 = tbend1
   eltemp = est(52)
   theta1 = thetam*degra
   sinth = sin(theta1)
   costh = cos(theta1)
   IF ( abs(sinth)<=1.0E-06 ) sinth = 0.0
!
!     EVALUTE MATERIAL PROPERTIES
!
   matflg = 2
   matid = matid1
   IF ( matid1/=0 ) THEN
      CALL mat(idele)
!
      g11 = em(1)
      g12 = em(2)
      g13 = em(3)
      g22 = em(4)
      g23 = em(5)
      g33 = em(6)
   ENDIF
   matflg = 2
   matid = matid2
   IF ( matid2/=0 ) THEN
      CALL mat(idele)
      d11 = em(1)
      d12 = em(2)
      d13 = em(3)
      d22 = em(4)
      d23 = em(5)
      d33 = em(6)
      j11 = 0.0
      j12 = 0.0
      j22 = 0.0
      IF ( .NOT.(nots) ) THEN
         matflg = 3
         matid = matid3
         CALL mat(idele)
         j11 = 1.0/(rj11*tshr)
         j12 = 0.0
         j22 = 1.0/(rj22*tshr)
      ENDIF
   ENDIF
!
!     CALCULATIONS FOR THE TRIANGLE
!
   CALL trif(xc,yc,zc,ivect,jvect,kvect,a,b,c,iest(1),name)
!
!     COMPUTE THE AREA INTEGRATION FUNCTION F
!
   CALL af(f,14,a,b,c,0,0,0,0,0,0,-1)
!
!     CALCULATIONS FOR QMATRIX (QQQ) AND ITS INVERSE
!
   DO i = 1 , 20
      DO j = 1 , 20
         qqq(i,j) = 0.0
      ENDDO
   ENDDO
   DO i = 1 , 6
      i1 = (i-1)*3 + 1
      i2 = (i-1)*3 + 2
      i3 = (i-1)*3 + 3
      qqq(i1,1) = 1.0
      qqq(i1,2) = xc(i)
      qqq(i1,3) = yc(i)
      qqq(i1,4) = xc(i)*xc(i)
      qqq(i1,5) = xc(i)*yc(i)
      qqq(i1,6) = yc(i)*yc(i)
      qqq(i1,7) = qqq(i1,4)*xc(i)
      qqq(i1,8) = qqq(i1,4)*yc(i)
      qqq(i1,9) = qqq(i1,5)*yc(i)
      qqq(i1,10) = qqq(i1,6)*yc(i)
      qqq(i1,11) = qqq(i1,7)*xc(i)
      qqq(i1,12) = qqq(i1,7)*yc(i)
      qqq(i1,13) = qqq(i1,8)*yc(i)
      qqq(i1,14) = qqq(i1,9)*yc(i)
      qqq(i1,15) = qqq(i1,10)*yc(i)
      qqq(i1,16) = qqq(i1,11)*xc(i)
      qqq(i1,17) = qqq(i1,12)*yc(i)
      qqq(i1,18) = qqq(i1,13)*yc(i)
      qqq(i1,19) = qqq(i1,14)*yc(i)
      qqq(i1,20) = qqq(i1,15)*yc(i)
      qqq(i2,3) = 1.0
      qqq(i2,5) = xc(i)
      qqq(i2,6) = yc(i)*2.0
      qqq(i2,8) = qqq(i1,4)
      qqq(i2,9) = qqq(i1,5)*2.0
      qqq(i2,10) = qqq(i1,6)*3.0
      qqq(i2,12) = qqq(i1,7)
      qqq(i2,13) = qqq(i1,8)*2.0
      qqq(i2,14) = qqq(i1,9)*3.0
      qqq(i2,15) = qqq(i1,10)*4.0
      qqq(i2,17) = qqq(i1,12)*2.0
      qqq(i2,18) = qqq(i1,13)*3.0
      qqq(i2,19) = qqq(i1,14)*4.0
      qqq(i2,20) = qqq(i1,15)*5.0
      qqq(i3,2) = -1.0
      qqq(i3,4) = -2.0*xc(i)
      qqq(i3,5) = -yc(i)
      qqq(i3,7) = -qqq(i1,4)*3.0
      qqq(i3,8) = -qqq(i1,5)*2.0
      qqq(i3,9) = -qqq(i1,6)
      qqq(i3,11) = -qqq(i1,7)*4.0
      qqq(i3,12) = -qqq(i1,8)*3.0
      qqq(i3,13) = -qqq(i1,9)*2.0
      qqq(i3,14) = -qqq(i1,10)
      qqq(i3,16) = -qqq(i1,11)*5.0
      qqq(i3,17) = -qqq(i1,13)*3.0
      qqq(i3,18) = -qqq(i1,14)*2.0
      qqq(i3,19) = -qqq(i1,15)
   ENDDO
   qqq(19,16) = 5.0*a**4*c
   qqq(19,17) = 3.0*a**2*c**3 - 2.0*a**4*c
   qqq(19,18) = -2.0*a*c**4 + 3.0*a**3*c**2
   qqq(19,19) = c**5 - 4.0*a**2*c**3
   qqq(19,20) = 5.0*a*c**4
   qqq(20,16) = 5.0*b**4*c
   qqq(20,17) = 3.0*b**2*c**3 - 2.0*b**4*c
   qqq(20,18) = 2.0*b*c**4 - 3.0*b**3*c**2
   qqq(20,19) = c**5 - 4.0*b**2*c**3
   qqq(20,20) = -5.0*b*c**4
   DO i = 1 , 6
      DO j = 1 , 6
         i1 = (i-1)*3 + 1
         q(i,j) = qqq(i1,j)
      ENDDO
   ENDDO
!
!     NO NEED TO COMPUTE DETERMINANT SINCE IT IS NOT USED SUBSEQUENTLY.
!
   ising = -1
   CALL invers(6,q,6,balotr(1),0,determ,ising,ind)
   IF ( ising==2 ) GOTO 400
!
!     FOURTH ARGUMENT IS A DUMMY LOCATION FOR INVERSE AND HENCE TS1(1)
!     IS U
!
   ising = -1
   CALL invers(20,qqq,20,balotr(1),0,determ,ising,index)
!
!     ISING EQUAL TO 2 IMPLIES THAT QQQ IS SINGULAR
!
   IF ( ising==2 ) GOTO 400
!
!     FIRST 18 COLUMNS OF QQQ INVERSE IS THE QQQINV FOR USE IN STIFFNESS
!     CALCULATIONS
!
!
   DO i = 1 , 20
      DO j = 1 , 18
         ijk = (i-1)*18 + j
         qqqinv(ijk) = qqq(i,j)
      ENDDO
   ENDDO
!
!     START EXECUTION FOR STIFFNESS MATRIX CALCULATION
!
!     CM IS STIFFNESS MATRIX IN ELEMENT COORDINATES
!
!
!     EVALUATE THE CONSTANTS C1,C2,AND C3 IN THE LINEAR EQUATION FOR
!     THICKNESS VARIATION - MEMBRANE
!
 100  CALL af(f,14,a,b,c,c1,c2,c3,tmem1,tmem3,tmem5,1)
   cab(1) = c1
   cab(2) = c2
   cab(3) = c3
   area = f(1,1)
   vol = c1*f(1,1) + c2*f(2,1) + c3*f(1,2)
!
!
   d334 = d33*4.0
   d132 = d13*2.0
   d232 = d23*2.0
!
!     A1,A2,A3 ARE THE COEFFICIENTS OF LINEAR EQUATION FOR VARIATION
!     OF BENDING THICKNESSES
!
   CALL af(f,14,a,b,c,a1,a2,a3,thk1,thk2,thk3,1)
   unimem = .FALSE.
   uniben = .FALSE.
   IF ( abs(c2)<=1.0E-06 .AND. abs(c3)<=1.0E-06 ) unimem = .TRUE.
   IF ( abs(a2)<=1.0E-06 .AND. abs(a3)<=1.0E-06 ) uniben = .TRUE.
   a1sq = a1*a1
   a2sq = a2*a2
   a3sq = a3*a3
   c1 = a1sq*a1
   c2 = 3.0*a1sq*a2
   c3 = 3.0*a1sq*a3
   c4 = 3.0*a1*a2sq
   c5 = 6.0*a1*a2*a3
   c6 = 3.0*a3sq*a1
   c7 = a2sq*a2
   c8 = 3.0*a2sq*a3
   c9 = 3.0*a2*a3sq
   c10 = a3*a3sq
!
!     AA1, AA2, AA3  ARE COEFFICIENTS IN THICKNESS VARIATION FOR
!     TRANSVERSE SHEAR
!
!
!    (POSSIBLY AN ERROR HERE - AA1,AA2, AND AA3 ARE NOT USED IN PROGRAM)
!     CALL AF (F,14,A,B,C,AA1,AA2,AA3,TSHR1,TSHR3,TSHR5,1)
!
   h4 = q(4,1)*zc(1) + q(4,2)*zc(2) + q(4,3)*zc(3) + q(4,4)*zc(4) + q(4,5)*zc(5) + q(4,6)*zc(6)
   h5 = q(5,1)*zc(1) + q(5,2)*zc(2) + q(5,3)*zc(3) + q(5,4)*zc(4) + q(5,5)*zc(5) + q(5,6)*zc(6)
   h6 = q(6,1)*zc(1) + q(6,2)*zc(2) + q(6,3)*zc(3) + q(6,4)*zc(4) + q(6,5)*zc(5) + q(6,6)*zc(6)
   h4 = h4*2.0
   h6 = h6*2.0
!
!     H5 IS MULTIPLIED BY 2.0, SO THAT EXY=DU/DY + DV/DX - ZXY*W
!
   h5 = h5*2.0
!
   DO i = 1 , 32
      ix = xu(i)
      rix = ix
      jx = yu(i)
      rjx = jx
      kx = xv(i)
      rkx = kx
      lx = yv(i)
      rlx = lx
      mx = xw(i)
      rmx = mx
      nx = yw(i)
      rnx = nx
      rmnx = rmx*rnx
      rmx1 = rmx*(rmx-1.0)
      rnx1 = rnx*(rnx-1.0)
      ixp1 = ix + 1
      jxp1 = jx + 1
      kxp1 = kx + 1
      lxp1 = lx + 1
      mxp1 = mx + 1
      nxp1 = nx + 1
      DO j = i , 32
         ij = (i-1)*32 + j
         ji = (j-1)*32 + i
         iy = xu(j)
         riy = iy
         jy = yu(j)
         rjy = jy
         ky = xv(j)
         rky = ky
         ly = yv(j)
         rly = ly
         my = xw(j)
         rmy = my
         ny = yw(j)
         rny = ny
         rmny = rmy*rny
         rmy1 = rmy*(rmy-1.0)
         rny1 = rny*(rny-1.0)
         mx0 = mx + my
         mx1 = mx + my - 1
         mx2 = mx + my - 2
         mx3 = mx + my - 3
         nx0 = nx + ny
         nx1 = nx + ny - 1
         nx2 = nx + ny - 2
         nx3 = nx + ny - 3
         my1 = mx + my + 1
         ny1 = nx + ny + 1
         ix0 = ix + iy
         ix1 = ix0 - 1
         ix01 = ix0 + 1
         jx0 = jx + jy
         jx1 = jx0 - 1
         jx01 = jx0 + 1
         kx0 = kx + ky
         kx1 = kx0 - 1
         kx01 = kx0 + 1
         lx0 = lx + ly
         lx1 = lx0 - 1
         lx01 = lx0 + 1
         IF ( ipass==1 ) THEN
            st = 0.0
            IF ( i>12 .OR. j<=12 ) THEN
               IF ( i>12 ) THEN
                  st = 0.0
                  DO k = 1 , 10
                     mx3x = mx3 + xthk(k)
                     ny1y = ny1 + ythk(k)
                     my1x = my1 + xthk(k)
                     nx3y = nx3 + ythk(k)
                     mx1x = mx1 + xthk(k)
                     nx1y = nx1 + ythk(k)
                     mx2x = mx2 + xthk(k)
                     nx0y = nx0 + ythk(k)
                     mx0x = mx0 + xthk(k)
                     nx2y = nx2 + ythk(k)
                     s11 = 0.0
                     s22 = 0.0
                     s33 = 0.0
                     s13 = 0.0
                     s23 = 0.0
                     IF ( mx3x>0 ) s11 = d11*rmx1*rmy1*cc(k)*f(mx3x,ny1y)
                     IF ( nx3y>0 ) s22 = d22*rnx1*rny1*cc(k)*f(my1x,nx3y)
                     IF ( mx1x>0 .AND. nx1y>0 ) s33 = (d334*rmnx*rmny+d12*(rmx1*rny1+rmy1*rnx1))*cc(k)*f(mx1x,nx1y)
                     IF ( mx2x>0 .AND. nx0y>0 ) s13 = d132*(rmx1*rmny+rmnx*rmy1)*cc(k)*f(mx2x,nx0y)
                     IF ( mx0x>0 .AND. nx2y>0 ) s23 = d232*(rmnx*rny1+rnx1*rmny)*cc(k)*f(mx0x,nx2y)
                     st = st + (s11+s22+s33+s13+s23)/12.0
                     IF ( uniben ) EXIT
                  ENDDO
               ELSE
                  DO k = 1 , 3
                     ixr1 = ix1 + rk(k)
                     jxs01 = jx01 + sk(k)
                     lxs1 = lx1 + sk(k)
                     kxr01 = kx01 + rk(k)
                     ixr01 = ix01 + rk(k)
                     jxs1 = jx1 + sk(k)
                     kxr1 = kx1 + rk(k)
                     lxs01 = lx01 + sk(k)
                     iykx1 = iy + kx + rk(k)
                     jylx1 = jy + lx + sk(k)
                     ixky1 = ix + ky + rk(k)
                     jxly1 = jx + ly + sk(k)
                     ixiy0 = ix + iy + rk(k)
                     jxjy0 = jx + jy + sk(k)
                     iykx2 = iykx1 - 1
                     jylx0 = jylx1 + 1
                     ixky2 = ixky1 - 1
                     jxly0 = jxly1 + 1
                     kxky0 = kx + ky + rk(k)
                     lxly0 = lx + ly + sk(k)
                     ixky0 = ix + ky + rk(k) + 1
                     jxly2 = jxly1 - 1
                     iykx0 = iy + kx + rk(k) + 1
                     jylx2 = jylx1 - 1
                     st11 = 0.0
                     st22 = 0.0
                     st331 = 0.0
                     st332 = 0.0
                     st121 = 0.0
                     st122 = 0.0
                     st131 = 0.0
                     st132 = 0.0
                     st133 = 0.0
                     st231 = 0.0
                     st232 = 0.0
                     st233 = 0.0
                     IF ( ixr1>0 ) st11 = g11*rix*riy*f(ixr1,jxs01)
                     IF ( lxs1>0 ) st22 = g22*rlx*rly*f(kxr01,lxs1)
                     IF ( jxs1>0 ) st331 = g33*rjx*rjy*f(ixr01,jxs1)
                     IF ( kxr1>0 ) st332 = g33*rkx*rky*f(kxr1,lxs01)
                     IF ( ixky1>0 .AND. jxly1>0 ) st121 = (g33*rjx*rky+g12*rix*rly)*f(ixky1,jxly1)
                     IF ( iykx1>0 .AND. jylx1>0 ) st122 = (g33*rjy*rkx+g12*riy*rlx)*f(iykx1,jylx1)
                     IF ( ixiy0>0 .AND. jxjy0>0 ) st131 = g13*(riy*rjx+rix*rjy)*f(ixiy0,jxjy0)
                     IF ( iykx2>0 ) st132 = g13*riy*rkx*f(iykx2,jylx0)
                     IF ( ixky2>0 ) st133 = g13*rix*rky*f(ixky2,jxly0)
                     IF ( kxky0>0 .AND. lxly0>0 ) st231 = g23*(rkx*rly+rky*rlx)*f(kxky0,lxly0)
                     IF ( jxly2>0 ) st232 = g23*rjx*rly*f(ixky0,jxly2)
                     IF ( jylx2>0 ) st233 = g23*rjy*rlx*f(iykx0,jylx2)
!
                     st1 = (st11+st22+st331+st332+st121+st122+st131+st132+st133+st231+st232+st233)*cab(k)
                     st = st + st1
                     IF ( unimem ) EXIT
                  ENDDO
                  GOTO 120
               ENDIF
            ENDIF
            sb7 = 0.0
            sb9 = 0.0
            sb10 = 0.0
            sb18 = 0.0
            sb21 = 0.0
            sb26 = 0.0
            sb28 = 0.0
            sb31 = 0.0
            sb36 = 0.0
            sb38 = 0.0
            DO k = 1 , 3
               ixmyr = ix + my + rk(k)
               jxnys1 = jx + ny + sk(k) + 1
               sb1 = 0.0
               sb2 = 0.0
               sb3 = 0.0
               sb4 = 0.0
               sb5 = 0.0
               sb6 = 0.0
               sb8 = 0.0
               sb11 = 0.0
               sb12 = 0.0
               sb13 = 0.0
               sb14 = 0.0
               sb15 = 0.0
               sb16 = 0.0
               sb17 = 0.0
               sb19 = 0.0
               sb20 = 0.0
               sb22 = 0.0
               sb23 = 0.0
               sb24 = 0.0
               sb25 = 0.0
               sb27 = 0.0
               sb29 = 0.0
               sb30 = 0.0
               sb32 = 0.0
               sb33 = 0.0
               sb34 = 0.0
               sb35 = 0.0
               sb37 = 0.0
               sb39 = 0.0
               sb40 = 0.0
               IF ( ixmyr>0 ) sb1 = -g11*rix*h4*cab(k)*f(ixmyr,jxnys1)
               iymxr = iy + mx + rk(k)
               jynxs1 = jy + nx + sk(k) + 1
               IF ( iymxr>0 ) sb2 = -g11*riy*h4*cab(k)*f(iymxr,jynxs1)
               mxmyr1 = mx + my + rk(k) + 1
               nxnys1 = nx + ny + sk(k) + 1
               sb3 = g11*h4**2*cab(k)*f(mxmyr1,nxnys1)
               kxmyr1 = kx + my + rk(k) + 1
               lxnys = lx + ny + sk(k)
               IF ( lxnys>0 ) sb4 = -g22*rlx*h6*cab(k)*f(kxmyr1,lxnys)
               mxkyr1 = mx + ky + rk(k) + 1
               nxlys = nx + ly + sk(k)
               IF ( nxlys>0 ) sb5 = -g22*rly*h6*cab(k)*f(mxkyr1,nxlys)
               mxmyr1 = mx + my + rk(k) + 1
               nxnys1 = nx + ny + sk(k) + 1
               sb6 = g22*h6**2*cab(k)*f(mxmyr1,nxnys1)
               ixmyr1 = ix + my + rk(k) + 1
               jxnys = jx + ny + sk(k)
               IF ( jxnys>0 ) sb8 = -g33*rjx*h5*cab(k)*f(ixmyr1,jxnys)
               kxmyr = kx + my + rk(k)
               lxnys1 = lx + ny + sk(k) + 1
               IF ( kxmyr>0 ) sb11 = -g33*rkx*h5*cab(k)*f(kxmyr,lxnys1)
               mxiyr1 = mx + iy + rk(k) + 1
               nxjys = nx + jy + sk(k)
               IF ( nxjys>0 ) sb12 = -g33*rjy*h5*cab(k)*f(mxiyr1,nxjys)
               mxkyr = mx + ky + rk(k)
               nxlys1 = nx + ly + sk(k) + 1
               IF ( mxkyr>0 ) sb13 = -g33*rky*h5*cab(k)*f(mxkyr,nxlys1)
               mxmyr1 = mx + my + rk(k) + 1
               nxnys1 = nx + ny + sk(k) + 1
               sb14 = g33*h5**2*cab(k)*f(mxmyr1,nxnys1)
               ixmyr = ix + my + rk(k)
               jxnys1 = jx + ny + sk(k) + 1
               IF ( ixmyr>0 ) sb15 = -g12*rix*h6*cab(k)*f(ixmyr,jxnys1)
               mxkyr1 = mx + ky + rk(k) + 1
               nxlys = nx + ly + sk(k)
               IF ( nxlys>0 ) sb16 = -g12*rly*h4*cab(k)*f(mxkyr1,nxlys)
               mxmyr1 = mx + my + rk(k) + 1
               nxnys1 = nx + ny + sk(k) + 1
               sb17 = 2*g12*h4*h6*cab(k)*f(mxmyr1,nxnys1)
               kxmyr1 = kx + my + rk(k) + 1
               lxnys = lx + ny + sk(k)
               IF ( lxnys>0 ) sb19 = -g12*rlx*h4*cab(k)*f(kxmyr1,lxnys)
               mxiyr = mx + iy + rk(k)
               nxjys1 = nx + jy + sk(k) + 1
               IF ( mxiyr>0 ) sb20 = -g12*riy*h6*cab(k)*f(mxiyr,nxjys1)
               ixmyr = ix + my + rk(k)
               jxnys1 = jx + ny + sk(k) + 1
               IF ( ixmyr>0 ) sb22 = -g13*rix*h5*cab(k)*f(ixmyr,jxnys1)
               mxiyr1 = mx + iy + rk(k) + 1
               nxjys = nx + jy + sk(k)
               IF ( nxjys>0 ) sb23 = -g13*rjy*h4*cab(k)*f(mxiyr1,nxjys)
               mxkyr = mx + ky + rk(k)
               nxlys1 = nx + ly + sk(k) + 1
               IF ( mxkyr>0 ) sb24 = -g13*rky*h4*cab(k)*f(mxkyr,nxlys1)
               mxmyr1 = mx + my + rk(k) + 1
               nxnys1 = nx + ny + sk(k) + 1
               sb25 = 2*g13*h4*h5*cab(k)*f(mxmyr1,nxnys1)
               ixmyr1 = ix + my + rk(k) + 1
               jxnys = jx + ny + sk(k)
               IF ( jxnys>0 ) sb27 = -g13*rjx*h4*cab(k)*f(ixmyr1,jxnys)
               kxmyr = kx + my + rk(k)
               lxnys1 = lx + ny + sk(k) + 1
               IF ( kxmyr>0 ) sb29 = -g13*rkx*h4*cab(k)*f(kxmyr,lxnys1)
               mxiyr = mx + iy + rk(k)
               nxjys1 = nx + jy + sk(k) + 1
               IF ( mxiyr>0 ) sb30 = -g13*riy*h5*cab(k)*f(mxiyr,nxjys1)
               kxmyr1 = kx + my + rk(k) + 1
               lxnys = lx + ny + sk(k)
               IF ( lxnys>0 ) sb32 = -g23*rlx*h5*cab(k)*f(kxmyr1,lxnys)
               mxiyr1 = mx + iy + rk(k) + 1
               nxjys = nx + jy + sk(k)
               IF ( nxjys>0 ) sb33 = -g23*rjy*h6*cab(k)*f(mxiyr1,nxjys)
               mxkyr = mx + ky + rk(k)
               nxlys1 = nx + ly + sk(k) + 1
               IF ( mxkyr>0 ) sb34 = -g23*rky*h6*cab(k)*f(mxkyr,nxlys1)
               mxmyr1 = mx + my + rk(k) + 1
               nxnys1 = nx + ny + sk(k) + 1
               sb35 = 2*g23*h5*h6*cab(k)*f(mxmyr1,nxnys1)
               ixmyr1 = ix + my + rk(k) + 1
               jxnys = jx + ny + sk(k)
               IF ( jxnys>0 ) sb37 = -g23*rjx*h6*cab(k)*f(ixmyr1,jxnys)
               kxmyr = kx + my + rk(k)
               lxnys1 = lx + ny + sk(k) + 1
               IF ( kxmyr>0 ) sb39 = -g23*rkx*h6*cab(k)*f(kxmyr,lxnys1)
               mxkyr1 = mx + ky + rk(k) + 1
               nxlys = nx + ly + sk(k)
               IF ( nxlys>0 ) sb40 = -g23*rly*h5*cab(k)*f(mxkyr1,nxlys)
               sb41 = sb3 + sb6 + sb14 + sb17 + sb25 + sb35
               IF ( i<=12 ) sb41 = 0.0
               st = st + sb1 + sb2 + sb4 + sb5 + sb7 + sb8 + sb9 + sb10 + sb11 + sb12 + sb13 + sb15 + sb16 + sb18 + sb19 + sb20 +   &
                  & sb21 + sb22 + sb23 + sb24 + sb26 + sb27 + sb28 + sb29 + sb30 + sb31 + sb32 + sb33 + sb34 + sb36 + sb37 + sb38 + &
                  & sb39 + sb40 + sb41
               IF ( unimem ) EXIT
            ENDDO
         ELSE
            ix011 = ix01 + 1
            jx011 = jx01 + 1
            rho = rhoy*1.0
            IF ( j<=12 ) THEN
               mshl(ij) = rho*(cab(1)*f(ix01,jx01)+cab(2)*f(ix011,jx01)+cab(3)*f(ix01,jx011)) + nsm*f(ix01,jx01)
               mshl(ji) = mshl(ij)
            ENDIF
            mx01 = mx0 + 1
            nx01 = nx0 + 1
            mx011 = mx01 + 1
            nx011 = nx01 + 1
            mshl(ij) = rho*(a1*f(mx01,nx01)+a2*f(mx011,nx01)+a3*f(mx01,nx011)) + nsm*f(mx01,nx01)
            mshl(ji) = mshl(ij)
            CYCLE
         ENDIF
 120     kshl(ij) = st
         kshl(ji) = kshl(ij)
      ENDDO
   ENDDO
   IF ( ipass==2 ) THEN
   ENDIF
!
!    CURRENTLY,TRANSVERSE SHEAR CALCULATIONS ARE NOT CODED FOR SHELL
!    ELEMENT WHEN IT IS CODED, CALL THE ROUTINE HERE
!
!
!     (QQQINV) TRANSPOSE (KTR3)  (QQQINV)
!
   CALL gmmats(q,6,6,0,kshl(1),6,32,0,qks(1))
   CALL gmmats(q,6,6,0,kshl(193),6,32,0,qks(193))
   CALL gmmats(qqqinv,20,18,+1,kshl(385),20,32,0,qks(385))
   DO i = 1 , 30
      DO j = 1 , 6
         ij = (i-1)*32 + j
         ji = (i-1)*6 + j
         kshl(ji) = qks(ij)
         kshl(180+ji) = qks(6+ij)
      ENDDO
   ENDDO
   DO i = 1 , 30
      DO j = 1 , 20
         ij = (i-1)*32 + j + 12
         ji = (i-1)*20 + j + 360
         kshl(ji) = qks(ij)
      ENDDO
   ENDDO
   CALL gmmats(kshl(1),30,6,0,q,6,6,1,qks(1))
   CALL gmmats(kshl(181),30,6,0,q,6,6,1,qks(181))
   CALL gmmats(kshl(361),30,20,0,qqqinv,20,18,0,qks(361))
   DO i = 1 , 30
      DO j = 1 , 6
         ij = (i-1)*30 + j
         ji = (i-1)*6 + j
         cms(ij) = qks(ji)
         cms(ij+6) = qks(ji+180)
      ENDDO
   ENDDO
   DO i = 1 , 30
      DO j = 1 , 18
         ij = (i-1)*30 + j + 12
         ji = (i-1)*18 + j + 360
         cms(ij) = qks(ji)
      ENDDO
   ENDDO
   DO i = 1 , 30
      ee(i) = 0.0
   ENDDO
   ee(1) = ivect(1)
   ee(2) = jvect(1)
   ee(3) = kvect(1)
   ee(6) = ivect(2)
   ee(7) = jvect(2)
   ee(8) = kvect(2)
   ee(11) = ivect(3)
   ee(12) = jvect(3)
   ee(13) = kvect(3)
   ee(19) = ivect(1)
   ee(20) = jvect(1)
   ee(24) = ivect(2)
   ee(25) = jvect(2)
   ee(29) = ivect(3)
   ee(30) = jvect(3)
   DO k = 1 , 6
      DO i = 1 , 2
         k1 = 6*(i-1) + k
         i1 = 5*(k-1) + i
         DO j = 1 , 30
            ctm(i1,j) = cm1(k1,j)
         ENDDO
      ENDDO
   ENDDO
   DO k = 1 , 6
      DO i = 1 , 3
         i2 = 5*(k-1) + i + 2
         k2 = 12 + (k-1)*3 + i
         DO j = 1 , 30
            ctm(i2,j) = cm1(k2,j)
         ENDDO
      ENDDO
   ENDDO
   DO k = 1 , 6
      DO i = 1 , 2
         k1 = 6*(i-1) + k
         i1 = 5*(k-1) + i
         DO j = 1 , 30
            cm1(j,i1) = ctm(j,k1)
         ENDDO
      ENDDO
   ENDDO
   DO k = 1 , 6
      DO i = 1 , 3
         i2 = 5*(k-1) + i + 2
         k2 = 12 + (k-1)*3 + i
         DO j = 1 , 30
            cm1(j,i2) = ctm(j,k2)
         ENDDO
      ENDDO
   ENDDO
   DO i = 1 , 1296
      cmt(i) = 0.0
   ENDDO
!
!     LUMPED MASS COMPUTATION
!
   IF ( ipass/=2 ) THEN
!
!     LOCATE THE TRANSFORMATION MATRICES FROM BASIC TO LOCAL (THAT IS
!     COORDINATE AT ANY GRID POINT IN WHICH DISPLACEMENT AND STRESSES
!     ARE R
!     - NOT NEEDED IF FIELD 7 IN GRID CARD IS ZERO)
!
!     TRANSFORM STIFFNESS MATRIX FROM ELEMENT COORDINATES TO BASIC
!     COORDINATES
!
!     TRANSFORM STIFFNESS MATRIX FROM BASIC COORDINAYES TO GLOBAL (DISP)
!     COORDINATES
!
!     INSERT THE 6X6 SUBMATRIX  INTO KGG MATRIX
!
      DO i = 1 , 6
         save(i) = nl(i)
      ENDDO
      DO i = 1 , 6
         small(i) = i
         ismall = nl(i)
         DO j = 1 , 6
            IF ( ismall>nl(j) ) THEN
               small(i) = j
               ismall = nl(j)
            ENDIF
         ENDDO
         ism = small(i)
         nl(ism) = 1000000
      ENDDO
      DO i = 1 , 6
         nl(i) = save(i)
      ENDDO
      DO i = 1 , 6
         sil1 = small(i)
         DO j = i , 6
            sil2 = small(j)
            DO ii = 1 , 36
               balotr(ii) = 0.0
               ksup(ii) = 0.0
            ENDDO
            DO k = 1 , 5
               k1 = (sil1-1)*5 + k
               DO l = 1 , 5
                  l1 = (sil2-1)*5 + l
                  csub(k,l) = cm1(k1,l1)
               ENDDO
            ENDDO
            CALL gmmats(ee,6,5,0,csub,5,5,0,csubt)
            CALL gmmats(csubt,6,5,0,ee,6,5,+1,ksupt)
            DO k = 1 , 6
               DO l = 1 , 6
                  k1 = (k-1)*6 + l
                  l1 = (l-1)*6 + k
                  ksup(l1) = ksupt(k1)
               ENDDO
            ENDDO
!
!     TRANSFORM THE KSUP(36) FROM BASIC TO DISPLACEMENT COORDINATES
!
            IF ( nl(sil1)/=0 .AND. ics(sil1)/=0 ) THEN
               jj = 4*sil1 + 24
               CALL transs(iest(jj),trand)
               DO jj = 1 , 3
                  l = 6*(jj-1) + 1
                  m = 3*(jj-1) + 1
                  balotr(l) = trand(m)
                  balotr(l+1) = trand(m+1)
                  balotr(l+2) = trand(m+2)
                  balotr(l+21) = trand(m)
                  balotr(l+22) = trand(m+1)
                  balotr(l+23) = trand(m+2)
               ENDDO
               CALL gmmats(balotr(1),6,6,1,ksup(1),6,6,0,ksupt)
               DO k = 1 , 36
                  ksup(k) = ksupt(k)
               ENDDO
            ENDIF
            IF ( nl(sil2)/=0 .AND. ics(sil2)/=0 ) THEN
               IF ( j/=i ) THEN
                  jj = 4*sil2 + 24
                  CALL transs(iest(jj),trand)
                  DO jj = 1 , 3
                     l = 6*(jj-1) + 1
                     m = 3*(jj-1) + 1
                     balotr(l) = trand(m)
                     balotr(l+1) = trand(m+1)
                     balotr(l+2) = trand(m+2)
                     balotr(l+21) = trand(m)
                     balotr(l+22) = trand(m+1)
                     balotr(l+23) = trand(m+2)
                  ENDDO
               ENDIF
               CALL gmmats(ksup(1),6,6,0,balotr(1),6,6,0,ksupt)
               DO k = 1 , 36
                  ksup(k) = ksupt(k)
               ENDDO
            ENDIF
            DO ii = 1 , 6
               DO jj = 1 , 6
                  i1 = (i-1)*6 + ii
                  j1 = (j-1)*6 + jj
                  ctm(i1,j1) = ksub(jj,ii)
                  ctm(j1,i1) = ksub(jj,ii)
               ENDDO
            ENDDO
         ENDDO
      ENDDO
      GOTO 300
   ENDIF
 200  amass = (rhoy*vol+nsm*area)/6.
   DO i = 1 , 1296 , 37
      cmt(i) = amass
   ENDDO
   ipass = 2
 300  CALL emgout(cmt(1),cmt(1),1296,1,dict,ipass,iprec)
   IF ( .NOT.imass .OR. ipass>=2 ) RETURN
!
!     TO TO 295 TO COMPUTE LUMPED MASS MATRIX
!     GO TO 211 TO COMPUTE CONSIST. MASS MATRIX (THIS PATH DOES NOT
!     WROK)
!
   ipass = 3
   IF ( ipass==1 ) GOTO 99999
   IF ( ipass==2 ) GOTO 100
   IF ( ipass==3 ) GOTO 200
!
!     ERROR
!
 400  nogo = .TRUE.
   knogo = 1
   WRITE (ioutpt,99001) ufm , iest(1)
99001 FORMAT (A23,' 2416, MATRIX RELATING GENERALIZED PARAMETERS AND ','GRID POINT DISPLACEMENTS IS SINGULAR.',//26X,               &
             &'CHECK COORDINATES OF ELEMENT  TRSHL WITH ID',I9,1H.)
99999 END SUBROUTINE ktshls