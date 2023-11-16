
SUBROUTINE nastim(Ihr,Imn,Isc,Cpusec)
   IMPLICIT NONE
!
! Dummy argument declarations
!
   REAL Cpusec
   INTEGER Ihr , Imn , Isc
!
! Local variable declarations
!
   REAL array(2) , secs , time
!
! End of declarations
!
!DME  19 JAN 2016
!DME  D. Everhart
!DME  Changed to conform to GFORTRAN implementation of ETIME subroutine.
   CALL etime(array,time)
!DME  CALL ETIME(ARRAY)
   secs = array(2)
   Ihr = secs/3600.
   Imn = (secs-3600.*Ihr)/60.
   Isc = secs - (3600.*Ihr) - (60.*Imn)
   Cpusec = secs
END SUBROUTINE nastim