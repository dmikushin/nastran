!*==bint.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
FUNCTION bint(I,J,A,B,Iv,Iw,R,Z)
   IMPLICIT NONE
!
! Function and Dummy argument declarations rewritten by SPAG
!
   REAL :: bint
   INTEGER :: I
   INTEGER :: J
   REAL :: A
   REAL :: B
   INTEGER :: Iv
   INTEGER :: Iw
   REAL , DIMENSION(1) :: R
   REAL , DIMENSION(1) :: Z
!
! Local variable declarations rewritten by SPAG
!
   REAL :: aj , aw , c1 , c1p , c2 , c2p , coef , sp1
   INTEGER :: ic , id , in , is1 , it , iw1 , k
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
   bint = 0.0
   iw1 = Iw + 1
   c1p = B
   c2p = A
   c1 = c1p
   c2 = c2p
   aw = 0.0
   IF ( R(I)/=0.0E0 .AND. R(J)/=0.0E0 ) aw = alog(R(J)/R(I))
   DO it = 1 , iw1
      ic = Iw - it + 1
      IF ( ic==0 ) c1 = 1.0
      IF ( it==1 ) c2 = 1.0
!
!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!
! THE FOLLOWING CODE REPLACES REAL FUNCTION COEF
!
      IF ( it==1 ) THEN
         coef = 1.0
      ELSE
         in = 1
         id = 1
         DO k = 2 , it
            in = in*(Iw-k+2)
            id = id*(k-1)
         ENDDO
         coef = in/id
      ENDIF
!
!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!
!
!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!
! THE FOLLOWING CODE REPLACES REAL FUNCTION AJ
!
      is1 = ic + Iv + 1
      IF ( is1==0 ) THEN
         aj = aw
      ELSE
         sp1 = is1
         aj = (R(J)**is1-R(I)**is1)/sp1
      ENDIF
!
!+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
!
      bint = bint + c1**ic*aj*c2**(it-1)*coef
      c1 = c1p
      c2 = c2p
   ENDDO
   aw = Iw
   bint = bint/aw
END FUNCTION bint
