
SUBROUTINE sub(X,Y,A,B)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Ncol
   REAL Xx
   COMMON /invpwx/ Xx , Ncol
!
! Dummy argument declarations
!
   DOUBLE PRECISION A , B
   DOUBLE PRECISION X(1) , Y(1)
!
! Local variable declarations
!
   INTEGER i
!
! End of declarations
!
!*******
!     SUB WILL FORM Y = A*X - B*Y  WHERE A AND B ARE SCALAR MULTIPLIERS
!     FOR THE VECTORS X AND Y
!*******
   DO i = 1 , Ncol
      Y(i) = X(i)*A - Y(i)*B
   ENDDO
END SUBROUTINE sub