!*==alg2.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
FUNCTION alg2(S,P)
   USE c_gas
   IMPLICIT NONE
!
! Function and Dummy argument declarations rewritten by SPAG
!
   REAL :: alg2
   REAL :: S
   REAL :: P
!
! End of declarations rewritten by SPAG
!
!
!
   alg2 = cp*exp(S/cp+rojcp*alog(P))
END FUNCTION alg2