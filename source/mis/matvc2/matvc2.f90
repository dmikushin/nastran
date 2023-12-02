!*==matvc2.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE matvc2(Y,X,Filea,Buf)
   IMPLICIT NONE
   USE c_names
   USE c_trdxx
   USE c_zntpkx
!
! Dummy argument declarations rewritten by SPAG
!
   REAL*8 , DIMENSION(1) :: Y
   REAL*8 , DIMENSION(1) :: X
   INTEGER , DIMENSION(7) :: Filea
   REAL , DIMENSION(1) :: Buf
!
! Local variable declarations rewritten by SPAG
!
   REAL*8 :: da
   INTEGER :: i , ncol , no
   INTEGER , DIMENSION(2) , SAVE :: sub
!
! End of declarations rewritten by SPAG
!
!
! Dummy argument declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     MATVC2 WILL FORM THE PRODUCT X = X + A*Y WHERE A IS A MATRIX
!     AND Y IS A VECTOR
!
!     THIS ROUTINE IS SUITABLE FOR DOUBLE PRECISION OPERATION
!
!     COMMON   /DESCRP/  LENGTH    ,MAJOR(1)
   !>>>>EQUIVALENCE (A(1),Da)
   DATA sub/4HMATV , 4HC2  /
!
   IF ( Filea(1)==0 ) RETURN
   ncol = Filea(2)
   IF ( Filea(4)==identy ) THEN
!
!     MATRIX IS THE IDENTITY
!
      DO i = 1 , ncol
         X(i) = Y(i) + X(i)
      ENDDO
      RETURN
   ELSE
      IF ( iopen/=1 ) CALL open(*200,Filea(1),Buf,rdrew)
      CALL fwdrec(*300,Filea(1))
      IF ( Filea(4)==diag ) THEN
!
!     MATRIX IS DIAGONAL
!
         CALL intpk(*100,Filea(1),0,rdp,0)
         DO
            CALL zntpki
            X(ii) = Y(ii)*da + X(ii)
            IF ( eol/=0 ) EXIT
         ENDDO
      ELSE
!
!     MATRIX IS FULL
!
         DO i = 1 , ncol
            IF ( Y(i)==0.0D0 ) THEN
               CALL fwdrec(*300,Filea(1))
            ELSE
               CALL intpk(*20,Filea(1),0,rdp,0)
               DO
                  CALL zntpki
                  X(ii) = da*Y(i) + X(ii)
                  IF ( eol/=0 ) EXIT
               ENDDO
            ENDIF
 20      ENDDO
      ENDIF
   ENDIF
!
 100  CALL rewind(Filea(1))
   IF ( iopen==0 ) CALL close(Filea(1),rew)
   RETURN
!
 200  no = -1
   GOTO 400
 300  no = -2
 400  CALL mesage(no,Filea(1),sub(1))
END SUBROUTINE matvc2
