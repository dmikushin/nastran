!*==af.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE af(F,N,A,B,C,C1,C2,C3,T1,T3,T5,Jump)
USE iso_fortran_env
USE ISO_FORTRAN_ENV                 
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: N
   REAL , DIMENSION(N,N) :: F
   REAL :: A
   REAL :: B
   REAL :: C
   REAL :: C1
   REAL :: C2
   REAL :: C3
   REAL :: T1
   REAL :: T3
   REAL :: T5
   INTEGER :: Jump
!
! Local variable declarations rewritten by SPAG
!
   REAL :: ab
   REAL(REAL64) , DIMENSION(20) , SAVE :: fac
   INTEGER :: i , i1 , j
   REAL(REAL64) :: temp
   EXTERNAL mesage
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
!     THIS AREA INTEGRATION ROUTINE IS USED IN TRIM6, TRPLT1 AND TRSHL
!     IT COMPUTES THE F FUNCTION, AND CONSTANTS C1, C2, C3
!
!     FAC ARE THE FACTORIALS 1 THRU 36
!     B   IS  DISTANCE OF GRID POINT 1
!     A   IS  DISTANCE OF GRID POINT 3
!     C   IS  DISTANCE OF GRID POINT 5
!     T1  IS  ASSOCIATIVE VARIABLE AT GRID POINT 1
!     T3  IS  ASSOCIATIVE VARIABLE AT GRID POINT 3
!     T5  IS  ASSOCIATIVE VARIABLE AT GRID POINT 5
!     N   IS  DIMENSION OF AREA FUNCTION F
!
!
!
   DATA fac/1.D0 , 1.D0 , 2.D0 , 6.D0 , 2.4D1 , 1.2D2 , 7.2D2 , 5.04D3 , 4.032D4 , 3.6288D5 , 3.6288D6 , 3.99168D7 , 4.790016D8 ,   &
      & 6.227021D9 , 8.7178291D10 , 1.307674D12 , 2.092279D13 , 3.556874D14 , 6.402374D15 , 1.216451D17/
!
   IF ( Jump<=0 ) THEN
      IF ( N>18 ) STOP 'IN AF'
      DO i = 1 , N
         DO j = 1 , N
            F(i,j) = 0.0
         ENDDO
      ENDDO
      DO i = 1 , N
         i1 = i
         DO j = 1 , i
            temp = dble(C**j)*fac(i1)/fac(i+2)
            temp = dble(A**i1-(-B)**i1)*temp*fac(j)
            F(i1,j) = sngl(temp)
            i1 = i1 - 1
         ENDDO
      ENDDO
      IF ( Jump<0 ) RETURN
   ENDIF
!
   ab = A - B
   IF ( A==B .AND. A/=0.0 ) ab = A + B
   IF ( ab==0.0 ) CALL mesage(-37,0,0)
   C1 = (T1*A-T3*B)/ab
   C2 = (T3-T1)/ab
   C3 = (T5-C1)/C
END SUBROUTINE af
