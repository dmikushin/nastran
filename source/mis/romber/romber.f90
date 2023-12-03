!*==romber.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE romber(B,Precis,Itdone,Fintg,K,X)
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   REAL :: B
   REAL :: Precis
   INTEGER :: Itdone
   REAL :: Fintg
   INTEGER :: K
   REAL , DIMENSION(6) :: X
!
! Local variable declarations rewritten by SPAG
!
   REAL :: const , den , diff , f , faaac , faaad , faaae , faaaf , faaag , faaah
   REAL , DIMENSION(20) :: faaaa , faaab
   INTEGER :: iaaaa , iaaac , iaaad , iaaaf , iret , spag_nextblock_1
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
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     TO INTEGRATE F(X) FROM X = A TO X = B
!
!         A = LOWER LIMIT = 0.0
!         B = UPPER LIMIT
!         NOSIG = NUMBER OF CORRECT SIGNIFICANT DIGITS DESIRED
!                 (NOT MORE THAN 7) = 5
!         PRECIS = 0.0  UPON RETURN, PRECIS = ACTUAL NUMBER
!                       OF SIGNIFICANT DIGITS ATTAINED
!         NUM = MAXIMUM NUMBER OF HALVINGS OF B-A TO BE MADE
!               (NOT MORE THAN 99) = 15
!         PROGRAMMER MUST ALSO PROGRAM SUBROUTINE FUNCT(F,X)
!         GIVING F AS THE DESIRED FUNCTION OF X, UPON
!         DEMAND OF ROMBER
!         UPON RETURN FROM ROMBER, THE VALUE OF THE INTEGRAL
!         WILL BE FOUND IN FINTG
!         IT IS CUSTOMARY TO MEASURE THE PRECISION OF LARGE NUMBERS IN
!     TERMS OF NUMBER OF SIGNIFICANT DIGITS AND THE ACCURACY OF SMALL
!     NUMBERS IN TERMS OF NUMBER OF SIGNIFICANT DECIMALS.  TO CONFORM
!     TO THIS PRACTICE, THE SUBROUTINE TERMINATES WHEN EITHER OF THESE
!     CONDITIONS IS MET.
!
!
         faaac = 0.00001
         iaaaa = 1
         faaad = B
         X(1) = 0.0
         ASSIGN 20 TO iret
         IF ( K==1 ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( K==2 ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( K==3 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DispatchLoop_1
         ENDIF
 20      faaae = f
         X(1) = B
         ASSIGN 40 TO iret
         IF ( K==1 ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( K==2 ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( K==3 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DispatchLoop_1
         ENDIF
 40      faaae = faaae + f
         faaaa(1) = 0.5*faaad*faaae
         spag_nextblock_1 = 2
      CASE (2)
         faaad = 0.5*faaad
         iaaac = 2**(iaaaa-1)
         faaae = 0.0
         iaaad = 0
         spag_nextblock_1 = 3
      CASE (3)
         iaaad = iaaad + 1
         faaaf = iaaad
         X(1) = (2.0*faaaf-1.0)*faaad
         ASSIGN 60 TO iret
         IF ( K==1 ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( K==2 ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( K==3 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DispatchLoop_1
         ENDIF
 60      faaae = faaae + f
         IF ( iaaad<iaaac ) THEN
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         faaab(1) = 0.5*faaaa(1) + faaad*faaae
         iaaaa = iaaaa + 1
         DO iaaad = 2 , iaaaa
            faaag = 4.0**(iaaad-1)
            faaah = faaag - 1.0
            iaaaf = iaaad - 1
            faaab(iaaad) = (faaag*faaab(iaaaf)-faaaa(iaaaf))/faaah
         ENDDO
         iaaac = 2*iaaac + 1
         diff = faaab(iaaaa) - faaaa(iaaaa-1)
         IF ( abs(diff)>=abs(faaac*faaab(iaaaa)) ) THEN
            DO iaaad = 1 , iaaaa
               faaaa(iaaad) = faaab(iaaad)
            ENDDO
            IF ( iaaaa<15 ) THEN
               spag_nextblock_1 = 2
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         Precis = diff
         Itdone = iaaaa - 1
         Fintg = faaab(iaaaa)
         RETURN
      CASE (4)
!
!     THIS CODE REPLACES F4
!
         IF ( X(1)==0.0 ) THEN
            f = 0.0
         ELSE
            den = X(3) - X(2)*X(5) + X(2)*X(5)*cos(X(1)) + X(2)*X(4)*sin(X(1))
            f = X(1)**(X(6)-1.0)*sin(X(1))**2/den
         ENDIF
         GOTO iret
      CASE (5)
!
!     THIS CODE REPLACES F5
!
         IF ( X(1)==0.0 ) THEN
            f = 0.0
         ELSE
            den = X(3) - X(2)*X(5) + X(2)*X(5)*cos(X(1)) + X(2)*X(4)*sin(X(1))
            f = X(1)**(X(6)-1.0)*2.*sin(X(1))*cos(X(1))/den
         ENDIF
         GOTO iret
      CASE (6)
!
!     THIS CODE REPLACES F6
!
         den = X(3) - X(2)*X(5) + X(2)*X(5)*cos(X(1)) + X(2)*X(4)*sin(X(1))
         IF ( X(6)==1.0 ) const = 1.0
         IF ( X(6)/=1.0 ) const = X(1)**(X(6)-1.0)
         IF ( den==0.0 ) THEN
            f = 0.0
         ELSE
            f = const*cos(X(1))**2/den
         ENDIF
         GOTO iret
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE romber