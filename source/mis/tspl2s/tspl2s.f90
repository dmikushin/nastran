!*==tspl2s.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE tspl2s(Ts7)
   USE c_sma1io
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   REAL , DIMENSION(60) :: Ts7
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: i
   REAL :: x2 , x2y , x3 , xy , xy2 , y2 , y3
!
! End of declarations rewritten by SPAG
!
!
!    TRANSVERSE SHEAR ROUTINE2 FOR CTRPLT1 - SINGLE PRECISION VERSION
!
   DO i = 1 , 60
      Ts7(i) = 0.0
   ENDDO
   x2 = x*x
   xy = x*y
   y2 = y*y
   x3 = x2*x
   x2y = x2*y
   xy2 = x*y2
   y3 = y2*y
   Ts7(4) = 2.0
   Ts7(7) = 6.0*x
   Ts7(8) = 2.0*y
   Ts7(11) = 12.0*x2
   Ts7(12) = 6.0*xy
   Ts7(13) = 2.0*y2
   Ts7(16) = 20.0*x3
   Ts7(17) = 6.0*xy2
   Ts7(18) = 2.0*y3
   Ts7(26) = 2.0
   Ts7(29) = 2.0*x
   Ts7(30) = 6.0*y
   Ts7(33) = 2.0*x2
   Ts7(34) = Ts7(12)
   Ts7(35) = 12.0*y2
   Ts7(37) = 2.0*x3
   Ts7(38) = 6.0*x2y
   Ts7(39) = 12.0*xy2
   Ts7(40) = 20.0*y3
   Ts7(45) = 2.0
   Ts7(48) = 4.0*x
   Ts7(49) = 4.0*y
   Ts7(52) = 6.0*x2
   Ts7(53) = 8.0*xy
   Ts7(54) = 6.0*y2
   Ts7(57) = 12.0*x2y
   Ts7(58) = Ts7(39)
   Ts7(59) = 8.0*y3
END SUBROUTINE tspl2s