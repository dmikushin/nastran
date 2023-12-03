!*==dk100.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
FUNCTION dk100(I,A,B,M,N,X)
USE iso_fortran_env
USE ISO_FORTRAN_ENV                 
   IMPLICIT NONE
!
! Function and Dummy argument declarations rewritten by SPAG
!
   REAL(REAL64) :: dk100
   INTEGER :: I
   REAL(REAL64) :: A
   REAL(REAL64) :: B
   INTEGER :: M
   INTEGER :: N
   REAL(REAL64) , DIMENSION(1) :: X
!
! Local variable declarations rewritten by SPAG
!
   REAL(REAL64) :: am1f , amn2f , amn2sf , an1 , an1f , an1p1 , an2 , capx , f100 , s , sf , xx
   INTEGER :: iret , is , kfac , lfac , n1 , n2 , n3 , n4 , nfac , spag_nextblock_1
!
! End of declarations rewritten by SPAG
!
!
! Function and Dummy argument declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
         f100 = 0.0D0
         capx = A + B*X(I)
         xx = X(I)
         n1 = M + N - 2
         n2 = M - 1
         n3 = n1 + 1
         an1 = n1
         an2 = n2
         nfac = n1
         ASSIGN 20 TO iret
         spag_nextblock_1 = 4
         CYCLE SPAG_DispatchLoop_1
 20      amn2f = kfac
         an1p1 = an1 + 1.0D0
         is = 0
         s = 0.0D0
         sf = 1.0D0
         amn2sf = amn2f
         spag_nextblock_1 = 2
      CASE (2)
         n4 = n2 - is
         IF ( n4==0 ) THEN
            nfac = n2
            ASSIGN 40 TO iret
            spag_nextblock_1 = 4
         ELSE
            f100 = f100 + amn2f*(capx**n4)*((-B)**is)/(amn2sf*sf*(an2-s)*(xx**n4))
            spag_nextblock_1 = 3
         ENDIF
         CYCLE
 40      am1f = kfac
         nfac = N - 1
         ASSIGN 60 TO iret
         spag_nextblock_1 = 4
         CYCLE SPAG_DispatchLoop_1
 60      an1f = kfac
         f100 = f100 + amn2f*((-B)**n2)*dlog(dabs(capx/xx))/(am1f*an1f)
         spag_nextblock_1 = 3
      CASE (3)
         IF ( is<n1 ) THEN
            is = is + 1
            s = is
            sf = sf*s
            amn2sf = amn2sf/(an1p1-s)
            spag_nextblock_1 = 2
         ELSE
            f100 = -f100/(A**n3)
            dk100 = f100
            RETURN
         ENDIF
      CASE (4)
         kfac = 1
         IF ( nfac>=2 ) THEN
            DO lfac = 2 , nfac
               kfac = kfac*lfac
            ENDDO
         ENDIF
         GOTO iret
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END FUNCTION dk100