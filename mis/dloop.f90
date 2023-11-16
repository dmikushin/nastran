
SUBROUTINE dloop(X,Y,Mpy,End)
   IMPLICIT NONE
!
! Dummy argument declarations
!
   DOUBLE PRECISION A , Mpy
   INTEGER End , Nn
   REAL Endd
   DOUBLE PRECISION B(1) , C(1) , X(1) , Xx(1) , Y(1) , Yy(1)
!
! Local variable declarations
!
   INTEGER i
!
! End of declarations
!
!*******
!     DLOOP IMPROVES THE EFFICIENCY OF AN INNER DCOMP LOOP
!*******
!*******
!     DDLOOP IMPROVES THE EFFICIENCY OF THE ACTIVE ROW LOOP
!*******
   DO i = 1 , End
      X(i) = X(i) + Mpy*Y(i)
   ENDDO
   RETURN
!*******************************
   ENTRY ddloop(A,B,C,Endd)
   DO i = 1 , Endd
      A = A - B(i)*C(i)
   ENDDO
   RETURN
!************
!     ENTRY FOR ANOTHER LOOP
!***********
   ENTRY xloop(Xx,Yy,Nn)
   DO i = 1 , Nn
      Xx(i) = Yy(i)
   ENDDO
END SUBROUTINE dloop