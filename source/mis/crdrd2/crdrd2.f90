!*==crdrd2.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE crdrd2(*,*,Mu,Indcom,N23)
   USE c_gp4fil
   USE c_gp4prm
   USE c_zzzzzz
   USE iso_fortran_env
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Mu
   INTEGER :: Indcom
   INTEGER :: N23
!
! Local variable declarations rewritten by SPAG
!
   REAL(REAL64) :: cdep , rlngth , xd , yd , zd
   REAL :: coeff
   REAL(REAL64) , DIMENSION(3) :: ddrcos , idrcos , rodcos
   REAL(REAL64) , DIMENSION(9) :: deptfm , indtfm
   REAL(REAL64) , DIMENSION(1) :: dz
   INTEGER :: i , idep
   INTEGER , SAVE :: mask15
   INTEGER , DIMENSION(2) :: mcode
   REAL , DIMENSION(1) :: rz
   EXTERNAL gmmatd , transd , write
!
! End of declarations rewritten by SPAG
!
!
!     WRITE THE RIGID ROD ELEMENT ON THE RG FILE
!
!     EXTERNAL          ORF    ,LSHIFT
!     INTEGER           ORF
   !>>>>EQUIVALENCE (Z(1),Dz(1)) , (Z(1),Rz(1))
   DATA mask15/32767/
!
!     INDTFM = INDEPENDENT GRID POINT TRANSFORMATION MATRIX
!     DEPTFM = DEPENDENT GRID POINT TRANSFORMATION MATRIX
!     RODCOS = BASIC COSINES OF ROD ELEMENT
!     IDRCOS = DIRECTION COSINES OF INDEPENDENT GRID POINT
!     DDRCOS = DIRECTION COSINES OF DEPENDENT GRID POINT
!
!     OBTAIN TRANSFORMATION MATRIX
!
   IF ( z(knkl1+3)/=0 ) THEN
      DO i = 1 , 4
         buf(i) = z(knkl1+2+i)
      ENDDO
      CALL transd(buf,indtfm)
   ENDIF
   IF ( z(knkl1+10)/=0 ) THEN
      DO i = 1 , 4
         buf(i) = z(knkl1+9+i)
      ENDDO
      CALL transd(buf,deptfm)
   ENDIF
!
!     COMPUTE THE LENGTH OF THE RIGID ROD ELEMENT
!
   xd = rz(knkl1+11) - rz(knkl1+4)
   yd = rz(knkl1+12) - rz(knkl1+5)
   zd = rz(knkl1+13) - rz(knkl1+6)
!
!     CHECK TO SEE IF LENGTH OF ROD IS ZERO
!
   IF ( xd==0.0D0 .AND. yd==0.0D0 .AND. zd==0.0D0 ) RETURN 1
   rlngth = dsqrt(xd*xd+yd*yd+zd*zd)
!
!     COMPUTE THE BASIC DIRECTION COSINES OF THE RIGID ROD ELEMENT
!
   rodcos(1) = xd/rlngth
   rodcos(2) = yd/rlngth
   rodcos(3) = zd/rlngth
!
!     OBTAIN THE DIRECTION COSINES ASSOCIATED WITH
!     THE INDEPENDENT GRID POINT
!
   IF ( z(knkl1+3)/=0 ) THEN
      CALL gmmatd(rodcos,1,3,0,indtfm,3,3,0,idrcos)
   ELSE
      DO i = 1 , 3
         idrcos(i) = rodcos(i)
      ENDDO
   ENDIF
!
!     OBTAIN THE DIRECTION COSINES ASSOCIATED WITH
!     THE DEPENDENT GRID POINT
!
   IF ( z(knkl1+10)/=0 ) THEN
      CALL gmmatd(rodcos,1,3,0,deptfm,3,3,0,ddrcos)
   ELSE
      DO i = 1 , 3
         ddrcos(i) = rodcos(i)
      ENDDO
   ENDIF
!
!     DETERMINE THE DEPENDENT SIL AND THE CORRESPONDING COEFFICIENT
!
   SPAG_Loop_1_1: DO i = 1 , 3
      IF ( Indcom==i ) THEN
         idep = z(knkl1+6+i)
         cdep = rodcos(i)
         EXIT SPAG_Loop_1_1
      ENDIF
   ENDDO SPAG_Loop_1_1
!
!     CHECK TO SEE IF RIGID ROD IS PROPERLY DEFINED
!
   IF ( dabs(cdep)<0.001D0 ) RETURN 2
   mcode(2) = idep
   IF ( idep>mask15 ) N23 = 3
   DO i = 1 , 3
      mcode(1) = z(knkl1+i-1)
      IF ( mcode(1)>mask15 ) N23 = 3
      coeff = -idrcos(i)/cdep
      CALL write(rgt,mcode,2,0)
      CALL write(rgt,coeff,1,0)
      mcode(1) = z(knkl1+6+i)
      IF ( mcode(1)>mask15 ) N23 = 3
      coeff = ddrcos(i)/cdep
      CALL write(rgt,mcode,2,0)
      CALL write(rgt,coeff,1,0)
   ENDDO
   z(Mu) = idep
   Mu = Mu - 1
END SUBROUTINE crdrd2