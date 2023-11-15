
SUBROUTINE ifp4e(Id)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Output
   REAL Sysbuf
   CHARACTER*23 Ufm
   COMMON /system/ Sysbuf , Output
   COMMON /xmssg / Ufm
!
! Dummy argument declarations
!
   INTEGER Id
!
! Local variable declarations
!
   LOGICAL nogo
!
! End of declarations
!
!
!     IFP4E, CALLED BY IFP4, CHECKS TO SEE THAT ID IS WITHIN PERMISSABLE
!     RANGE OF FROM 1 TO 499999.
!
!
   IF ( Id>=1 ) THEN
      IF ( Id<=499999 ) RETURN
   ENDIF
!
!     ERROR
!
   nogo = .TRUE.
   WRITE (Output,99001) Ufm , Id
99001 FORMAT (A23,' 4041, ID =',I12,' IS OUT OF PERMISSIBLE RANGE OF 1',' TO 499999.')
END SUBROUTINE ifp4e
