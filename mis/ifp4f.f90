
SUBROUTINE ifp4f(Ibit,File,Bit)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Two(32)
   COMMON /two   / Two
!
! Dummy argument declarations
!
   LOGICAL Bit
   INTEGER File , Ibit
!
! Local variable declarations
!
   INTEGER andf
   INTEGER i1 , i2 , trail(7)
   EXTERNAL andf
!
! End of declarations
!
!
!     TEST BIT -IBIT- IN TRAILER OF DATA BLOCK -FILE-
!
!
   trail(1) = File
   CALL rdtrl(trail)
   i1 = (Ibit-1)/16 + 2
   i2 = Ibit - (i1-2)*16 + 16
   IF ( andf(trail(i1),Two(i2))/=0 ) THEN
      Bit = .TRUE.
      RETURN
   ELSE
      Bit = .FALSE.
   ENDIF
END SUBROUTINE ifp4f
