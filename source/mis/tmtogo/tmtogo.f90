!*==tmtogo.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE tmtogo(Togo)
   USE c_stime
   USE c_system
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Togo
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: tbegin , tnow
   EXTERNAL klock
!
! End of declarations rewritten by SPAG
!
!
!     TO COMPUTE THE TIME (IN SECONDS) REMAINING
!
!
!     GET PRESENT TIME
!
   CALL klock(tnow)
!
!     COMPUTE TIME TO GO
!
   tbegin = tmbegn
   Togo = tprob - (tnow-tbegin)
END SUBROUTINE tmtogo
