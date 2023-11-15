
SUBROUTINE mbgae(Ajjl,In17,A,F,Df,F1,Df1,F2,Df2,Q,Q1,Q2,Mood)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   LOGICAL Asym , Cntrl1 , Cntrl2 , Crank1 , Crank2
   REAL Beta , Boxa , Boxl , Boxw , Cr , Ek , Ekbar , Ekm , Gc , Mach , Sysbuf
   INTEGER Kc , Kc1 , Kc1t , Kc2 , Kc2t , Kct , Mcb(7) , N6 , Nbox , Ncb , Njj , Npts0 , Npts1 , Npts2 , Nsb , Nsbd , Ntote
   COMMON /amgmn / Mcb
   COMMON /mboxc / Njj , Crank1 , Crank2 , Cntrl1 , Cntrl2 , Nbox , Npts0 , Npts1 , Npts2 , Asym , Gc , Cr , Mach , Beta , Ek ,     &
                 & Ekbar , Ekm , Boxl , Boxw , Boxa , Ncb , Nsb , Nsbd , Ntote , Kc , Kc1 , Kc2 , Kct , Kc1t , Kc2t
   COMMON /system/ Sysbuf , N6
!
! Dummy argument declarations
!
   INTEGER Ajjl , In17 , Mood
   COMPLEX A(1) , Q(1) , Q1(1) , Q2(1)
   REAL Df(1) , Df1(1) , Df2(1) , F(1) , F1(1) , F2(1)
!
! Local variable declarations
!
   LOGICAL debug
   REAL gck
   INTEGER i , j , jj , kcc , kcc1 , kcc2
!
! End of declarations
!
!
!     MULTIPLY SUM OBTAINED PREVIOUSLY BY SCRIPT A FACTOR
!
   DATA debug/.FALSE./
!
   gck = Gc*Boxw
   DO i = 1 , Njj
      A(i) = (0.0,0.0)
   ENDDO
   DO i = 1 , Npts0
      CALL fread(In17,F,Kct,0)
      CALL fread(In17,Df,Kct,0)
      DO j = 1 , Kc
         A(i) = A(i) + cmplx(Df(j),-Ek*F(j))*Q(j)
      ENDDO
      IF ( Kc/=Kct ) THEN
         kcc = Kc + 1
         DO j = kcc , Kct
            A(i) = A(i) + F(j)*Q(j)
         ENDDO
      ENDIF
   ENDDO
   IF ( Cntrl1 ) THEN
      jj = Npts0
      DO i = 1 , Npts1
         CALL fread(In17,F1,Kc1t,0)
         CALL fread(In17,Df1,Kc1t,0)
         DO j = 1 , Kc1
            A(i+jj) = A(i+jj) + cmplx(Df1(j),-Ek*F1(j))*Q1(j)
         ENDDO
         IF ( Kc1/=Kc1t ) THEN
            kcc1 = Kc1 + 1
            DO j = kcc1 , Kc1t
               A(i+jj) = A(i+jj) + F1(j)*Q1(j)
            ENDDO
         ENDIF
      ENDDO
   ENDIF
   IF ( Cntrl2 ) THEN
      jj = jj + Npts1
      DO i = 1 , Npts2
         CALL fread(In17,F2,Kc2t,0)
         CALL fread(In17,Df2,Kc2t,0)
         DO j = 1 , Kc2
            A(i+jj) = A(i+jj) + cmplx(Df2(j),-Ek*F2(j))*Q2(j)
         ENDDO
         IF ( Kc2/=Kc2t ) THEN
            kcc2 = Kc2 + 1
            DO j = kcc2 , Kc2t
               A(i+jj) = A(i+jj) + F2(j)*Q2(j)
            ENDDO
         ENDIF
      ENDDO
   ENDIF
   CALL bckrec(In17)
   DO i = 1 , Njj
      A(i) = A(i)*gck
   ENDDO
   CALL pack(A,Ajjl,Mcb)
!
!     PRINT OUT GENERALIZED AERODYNAMIC FORCE COEFFICIENTS
!
   IF ( .NOT.debug ) RETURN
   IF ( Mood<=1 ) THEN
      WRITE (N6,99001) Mach , Boxl , Ek , Boxw
99001 FORMAT (1H1,31X,30HGENERALIZED AERODYNAMIC FORCE ,12HCOEFFICIENTS/1H0,9X,11HMACH NUMBER,F9.3,40X,10HBOX LENGTH,F12.6/1H0,9X,  &
             &33HREDUCED FREQUENCY  ( ROOT CHORD ),F10.5,17X,9HBOX WIDTH,F13.6/1H0,42X,21H- -  A ( I , J )  - -/6H-  ROW,9X,4HREAL, &
            & 10X,4HIMAG,14X,4HREAL,10X,4HIMAG,14X,4HREAL,10X,4HIMAG)
   ENDIF
   WRITE (N6,99002) Mood , (A(j),j=1,Njj)
99002 FORMAT (1H0,I4,3(E18.4,E14.4)/(1H0,4X,3(E18.4,E14.4)))
END SUBROUTINE mbgae
