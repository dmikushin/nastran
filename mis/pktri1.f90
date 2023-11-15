
SUBROUTINE pktri1
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL Costh , Deps , Depss , Dum(297) , Dum1 , Dumcl(145) , Dummy(58) , Ecpt(27) , Ecptsa(100) , Elid , Eltemp , Eps0 , Eps1 ,    &
      & Eps2 , Epss , Estar , Esub0 , Extra(4) , F , G11 , G12 , G13 , G22 , G23 , G33 , Gamma , Gammas , Gp(9) , Nu , Ph1out(200) ,&
      & Plaans , Plaarg , S(3) , Sigxs , Sigxys , Sigys , Sinth , Sx , Sy , Tau0 , Tau1 , Tau2 , Ui(09) , Z(24)
   INTEGER Idum2 , Idum3(3,3) , Inflag , Ipass , Ivec , Matid , Midgp , Necpt(27) , Necpts(27) , Nirof , Nogo , Npvt
   COMMON /matin / Matid , Inflag , Eltemp , Plaarg , Sinth , Costh
   COMMON /matout/ G11 , G12 , G13 , G22 , G23 , G33
   COMMON /pla42c/ Npvt , Gamma , Gammas , Ipass , Dumcl , Nogo
   COMMON /pla42e/ Ecpt , Eps0 , Epss , Estar , Sigxs , Sigys , Sigxys , Ui , Dummy
   COMMON /pla42s/ S , Dum , Tau0 , Tau1 , Tau2 , F , Sx , Sy , Deps , Depss , Eps1 , Eps2 , Dum1 , Idum2 , Idum3 , Extra
   COMMON /pla4es/ Ecptsa , Ph1out
   COMMON /pla4uv/ Ivec , Z
   COMMON /plagp / Gp , Midgp , Elid
!
! Local variable declarations
!
   INTEGER i , matid1
   LOGICAL istiff
!
! End of declarations
!
!  THIS ROUTINE CALCULATES GP,SET-S UP THE ECPT AND UPDATES THE ECPT
!  FOR THE TRIA1 ELEMENTS
!  PLA4
!
!     ECPT FOR TRIA1
!
!     EL.ID                                       ECPT( 1)
!     GRID A                                      ECPT( 2)
!     GRID B                                      ECPT( 3)
!     GRID C                                      ECPT( 4)
!     THETA                                       ECPT( 5)
!     MATID1                                      ECPT( 6)
!     T1                                          ECPT( 7)
!     MATID2                                      ECPT( 8)
!     I                                           ECPT( 9)
!     MATID3                                      ECPT(10)
!     T2                                          ECPT(11)
!     NS MASS                                     ECPT(12)
!     Z1                                          ECPT(13)
!     Z2                                          ECPT(14)
!     CSID 1                                      ECPT(15)
!     X1                                          ECPT(16)
!     Y1                                          ECPT(17)
!     Z1                                          ECPT(18)
!     CSID 2                                      ECPT(19)
!     X2                                          ECPT(20)
!     Y2                                          ECPT(21)
!     Z2                                          ECPT(22)
!     CSID3                                       ECPT(23)
!     X3                                          ECPT(24)
!     Y3                                          ECPT(25)
!     Z3                                          ECPT(26)
!     TEMP                                        ECPT(27)
!     EPS SUB 0      (PREVIOUS  STRAIN)           ECPT(28)
!     EPS SUB STAR   (LAST STRAIN)                ECPT(29)
!     MODULUS OF ELASTICITY                       ECPT(30)
!     SIGMA X        STRESS                       ECPT(31)
!     SIGMA Y        STRESS                       ECPT(32)
!     SIGMA XY       STRESS                       ECPT(33)
!     U A       (3X1 DISPLACEMENT VECTOR)         ECPT(34)
!     U B       (3X1 DISPLACEMENT VECTOR)         ECPT(37)
!     U C       (3X1 DISPLACEMENT VECTOR)         ECPT(40)
!
!     ******************************************************************
!
!
!
!
!
! SCRATCH BLOCK  325 CELLS
!
!
   EQUIVALENCE (Necpt(6),matid1) , (Ecpt(1),Necpt(1)) , (G11,Plaans) , (G13,Nu) , (G11,Esub0) , (Necpts(1),Ecptsa(1)) , (G12,Nirof)
!
! SETUP GP MATRIX FOR PLAMAT
!
   istiff = .FALSE.
   Elid = Ecpt(1)
   Midgp = matid1
   DO i = 1 , 9
      Gp(i) = 0.0
   ENDDO
   Tau0 = sqrt(Sigxs**2-Sigxs*Sigys+Sigys**2+3.0*Sigxys**2)
   IF ( Estar==0.0 ) GOTO 200
   IF ( Ipass==1 ) THEN
      Matid = matid1
      Costh = 1.0
      Sinth = 0.0E0
      Inflag = 2
!
      CALL mat(Ecpt(1))
!
      Gp(1) = G11
      Gp(2) = G12
      Gp(3) = G13
      Gp(4) = G12
      Gp(5) = G22
      Gp(6) = G23
      Gp(7) = G13
      Gp(8) = G23
      Gp(9) = G33
      GOTO 200
   ELSEIF ( Tau0==0.0 ) THEN
      GOTO 200
   ENDIF
 100  Matid = matid1
   Inflag = 1
!
   CALL mat(Ecpt(1))
!
   F = 9.0*(Esub0-Estar)/(4.0*Tau0**2*Estar)
   Sx = (2.0*Sigxs-Sigys)/3.0
   Sy = (2.0*Sigys-Sigxs)/3.0
   Gp(1) = (1.0+Sx**2*F)/Esub0
   Gp(2) = (-Nu+Sx*Sy*F)/Esub0
   Gp(3) = (2.0*Sigxys*Sx*F)/Esub0
   Gp(4) = Gp(2)
   Gp(5) = (1.0+Sy**2*F)/Esub0
   Gp(6) = (2.0*Sigxys*Sy*F)/Esub0
   Gp(7) = Gp(3)
   Gp(8) = Gp(6)
   Gp(9) = (2.0*(1.0+Nu)+4.0*F*Sigxys**2)/Esub0
!
!     NO NEED TO COMPUTE DETERMINANT SINCE IT IS NOT USED SUBSEQUENTLY.
   Idum2 = -1
   CALL invers(3,Gp,3,0,0,Dum1,Idum2,Idum3)
!
! CHECK SINGULARITY
!
   IF ( Idum2==2 ) THEN
      CALL mesage(30,38,Ecpt(1))
!
!  SET FLAG FOR FATAL ERROR WHILE ALLOWING ERROR MESSAGES TO ACCUMULATE
!
      Nogo = 1
      GOTO 99999
   ENDIF
!
 200  IF ( .NOT.(istiff) ) THEN
      istiff = .TRUE.
!
! CALCULATE PHASE I STRESSES
!
      DO i = 1 , 32
         Ecptsa(i) = Ecpt(i)
      ENDDO
      Necpts(2) = 1
      Necpts(3) = 4
      Necpts(4) = 7
!
      CALL pktq1(1)
!
!
! CALCULATE PHASE II STRESSES
!
      Ivec = 1
      DO i = 1 , 24
         Z(i) = Ui(i)
      ENDDO
      DO i = 1 , 200
         Ecptsa(i) = Ph1out(i)
      ENDDO
      S(1) = Sigxs
      S(2) = Sigys
      S(3) = Sigxys
!
      CALL pktq2(3)
!
!  UPDATE ECPT FOR STRESSES
!
      Sigxs = S(1)
      Sigys = S(2)
      Sigxys = S(3)
      Tau1 = sqrt(Sigxs**2-Sigxs*Sigys+Sigys**2+3.0*Sigxys**2)
      Matid = matid1
      Inflag = 8
      Plaarg = Tau1
!
      CALL mat(Ecpt(1))
!
! TEST FOR TAU 1 OUTSIDE THE RANGE OF FUNCTION
!
      IF ( Nirof==1 ) THEN
         Estar = 0.0
      ELSE
!
! RETURNS EPS SUB 1 GIVEN TAU1
!
         Eps1 = Plaans
         Deps = Eps1 - Epss
         Depss = Epss - Eps0
         Eps2 = Eps1 + Gamma*Deps
         Inflag = 6
         Plaarg = Eps2
!
         CALL mat(Ecpt(1))
!
! RETURNS  TAU2 GIVEN EPS2
!
         Tau2 = Plaans
         Estar = 0.0
         IF ( (Eps2-Eps1)/=0.0 ) Estar = (Tau2-Tau1)/(Eps2-Eps1)
         Eps0 = Epss
         Epss = Eps1
      ENDIF
!
!  SETUP STIFFNESS CALCULATIONS FOR GP
!
      DO i = 1 , 9
         Gp(i) = 0.0
      ENDDO
      Tau0 = sqrt(Sigxs**2-Sigxs*Sigys+Sigys**2+3.0*Sigxys**2)
      IF ( Estar/=0.0 .AND. Tau0/=0.0 ) GOTO 100
   ENDIF
!
!  SETUP CALL TO ELEMENT STIFFNESS ROUTINE IT WILL ALSO INSERT
!
   DO i = 1 , 32
      Ecptsa(i) = Ecpt(i)
   ENDDO
   CALL pktrqd(1)
   RETURN
99999 END SUBROUTINE pktri1
