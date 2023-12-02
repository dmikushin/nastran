!*==emgsoc.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE emgsoc(Icore,Ncore,Heat)
   IMPLICIT NONE
   USE c_machin
   USE c_zzemgx
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Icore
   INTEGER :: Ncore
   REAL :: Heat
!
! End of declarations rewritten by SPAG
!
!
! Dummy argument declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     THIS .MDS VERSION IS USED ONLY IN THE VIRTUAL MACHINES (IBM, VAX,
!     AND UNIX)
!     CDC & UNIVAC, NON-VIRTUAL MACHINES, SHOULD USE THE EMGSOC.MIS
!     VERSION
!
!     ICORE = RELATIVE ADDRESS OF FIRST WORD OF OPEN CORE.
!     NCORE = RELATIVE ADDRESS OF FINAL WORD OF OPEN CORE.
!
!     IFILE = GINO FILE WHOSE TRAILER BITS INDICATE ACTIVE COMMON GROUPS
!
!     BOUNDARY ALIGNMENT IS ASSURED BY THE FACT THAT ALL COMMON BLOCKS
!     START AT AN ODD ADDRESS.
!
!
   Ncore = korsz(ixxx)
   Icore = 3
   IF ( mach==3 .OR. mach==4 ) STOP ' EMGSOC'
END SUBROUTINE emgsoc
