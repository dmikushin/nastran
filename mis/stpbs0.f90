
SUBROUTINE stpbs0(X,Ncode,Bj0,By0)
   IMPLICIT NONE
!
! Dummy argument declarations
!
   REAL Bj0 , By0 , X
   INTEGER Ncode
!
! Local variable declarations
!
   REAL a , e , t , u , uw , w , z
   INTEGER name(2)
!
! End of declarations
!
!     SUBROUTINE  BES0.  J AND Y BESSEL FUNCTIONS OF ORDER ZERO
!     E. ALBANO, ORGN 3721, EXT 1022, OCT. 1967
!     COMPUTES J0(X)  IF X IS GREATER THAN -3.
!     COMPUTES Y0(X)  IF (X IS GREATER THAN E AND NCODE = 1 ),
!           WHERE
   DATA name/4HSTPB , 4HS0  /
   e = 0.00001
!                 REF. US DEPT OF COMMERCE HANDBOOK (AMS 55)  PG. 369
   a = abs(X)
   IF ( a<=3. ) THEN
      z = X*X/9.
      Bj0 = 1. + z*(-2.2499997+z*(1.2656208+z*(-0.3163866+z*(0.0444479+z*(-0.0039444+z*0.00021)))))
      IF ( Ncode==1 ) THEN
         IF ( X<e ) THEN
            CALL mesage(-7,0,name)
            GOTO 100
         ELSE
            By0 = 0.63661977*Bj0*(alog(X)-.69314718) + .36746691 +                                                                  &
                & z*(0.60559366+z*(-0.74350384+z*(0.25300117+z*(-0.04261214+z*(0.00427916-0.00024846*z)))))
            RETURN
         ENDIF
      ENDIF
   ELSEIF ( X<=0 ) THEN
      CALL mesage(-7,0,name)
      GOTO 100
   ELSE
      u = 1./sqrt(X)
      z = 3./X
      w = 0.79788456 + z*(-0.00000077+z*(-0.0055274+z*(-0.00009512+z*(0.00137237+z*(-0.00072805+0.00014476*z)))))
      t = X - 0.78539816 + z*(-0.04166397+z*(-0.00003954+z*(0.00262573+z*(-0.00054125+z*(-0.00029333+0.00013558*z)))))
      uw = u*w
      Bj0 = uw*cos(t)
      IF ( Ncode==1 ) THEN
         By0 = uw*sin(t)
         GOTO 100
      ENDIF
   ENDIF
   RETURN
 100  RETURN
END SUBROUTINE stpbs0
