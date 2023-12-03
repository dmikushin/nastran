!*==xsave.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE xsave
   IMPLICIT NONE
   USE c_blank
   USE c_oscent
   USE c_xvps
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: i1 , i2 , j , k , l , n
!
! End of declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!     THE PURPOSE OF THIS ROUTINE IS TO PERFORM THE FUNCTIONS ASSIGNED
!     TO THE SAVE DMAP INSTRUCTION.
!
!     GET NUMBER OF PARAMETERS FROM OSCAR
   n = ioscr(7)*2 + 6
   DO i1 = 8 , n , 2
!     GET VPS POINTER AND POINTER TO VALUE IN BLANK COMMON.
      j = ioscr(i1)
      k = ioscr(i1+1)
!     GET LENGTH OF VALUE FROM VPS
      l = ivps(j-1)
!     TRANSFER VALUE FROM BLANK COMMON TO VPS
      DO i2 = 1 , l
         ivps(j) = ipar(k)
         j = j + 1
         k = k + 1
      ENDDO
   ENDDO
END SUBROUTINE xsave