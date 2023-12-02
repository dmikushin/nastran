!*==strsl2.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE strsl2(Ti)
   USE c_sdr2x4
   USE c_sdr2x7
   USE c_sdr2x8
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   REAL , DIMENSION(6) :: Ti
!
! Local variable declarations rewritten by SPAG
!
   REAL :: f1 , ff , ftemp , sigx1 , sigx2 , sigxy1 , sigxy2 , sigy1 , sigy2 , z1 , z2
   LOGICAL :: flag
   INTEGER :: i , i1 , i2 , ii , ii1 , ij , ijk , iretrn , j , j1 , j2 , jst , k1 , n1 , npts
   INTEGER , DIMENSION(990) :: nph1ou
   INTEGER , DIMENSION(6) :: nsil
   REAL , DIMENSION(4) :: reali
   REAL , DIMENSION(3) :: sdelta
   REAL , DIMENSION(36) :: si
   REAL , DIMENSION(68) :: stout
   REAL , DIMENSION(18) :: str
   EXTERNAL gmmats
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     PHASE II OF STRESS DATA RECOVERY
!
   !>>>>EQUIVALENCE (Nsil(1),Ph1out(2)) , (Nph1ou(1),Ph1out(1)) , (Si(1),Ph1out(22)) , (Ldtemp,Ftemp) , (f1,n1)
!
!     PHASE I OUTPUT FROM THE PLATE IS THE FOLLOWING
!
!     PH1OUT(1)                        ELEMENT ID
!     PH1OUT(2 THRU 7)                 6 SILS
!     PH1OUT(8 THRU 10)                TMEM1,TMEM3,TMEM5
!     PH1OUT(11 THRU 13) (14)-(21)     Z1 AND Z2  TBEND1,TBEND3,TBEND5
!     PH1OUT (22 THRU 741)             4 S SUB I MATRICES,EACH 6X5X6 ARR
!     PH1OUT (742-753)                 4 - 3X3 S SUB T MATRICES
!
!     PHASE 1 OUTPUT FROM THE MEMBRANE IS THE FOLLOWING
!
!     PH1OUT(754)             ELEMENT ID
!     PH1OUT(755-760)         6 SILS
!     PH1OUT(761)             T SUB 0
!     PH1OUT(762-1193)        4 SETS OF 6 NOS. 3 X 6 S SUB I
!     PH1OUT(1194-1196)       S SUB T MATRIX
!
!     THE ABOVE ELEMENTS ARE COMPOSED OF PLATES AND MEMBRANES...
!     SOME MAY ONLY CONTAIN PLATES WHILE OTHERS MAY ONLY CONTAIN
!     MEMBRANES.
!     A CHECK FOR A ZERO FIRST SIL IN THE PHASE I OUTPUT, WHICH
!     INDICATES WHETHER ONE OR THE OTHER HAS BEEN OMITTED, IS MADE BELOW
!
!     FIRST GET FORCE VECTOR FOR THE PLATE CONSIDERATION
!
!     M ,  M ,  M ,  V ,  V    FOR ALL SIX GRID POINTS
!      X   Y   XY   X   Y
!                                NPTS
!     THE 5X1 FORCE VECTOR = SUMMATION  (S )(U )   FOR EACH POINT
!                                I=1       I   I
!
!     ZERO FORVEC STORAGE
!
         npts = 6
         DO i = 1 , 24
            forvec(i) = 0.0
         ENDDO
         forvec(1) = ph1out(1)
         forvec(7) = ph1out(1)
         forvec(13) = ph1out(1)
         forvec(19) = ph1out(1)
         ii = 0
         spag_nextblock_1 = 2
      CASE (2)
         ii = ii + 1
         IF ( ii>4 ) THEN
!
            DO i = 1 , 17
               ph1out(100+i) = stout(i)
            ENDDO
            DO j = 1 , 3
               DO i = 1 , 16
                  j1 = 117 + (j-1)*16 + i
                  j2 = (j-1)*17 + i + 18
                  ph1out(j1) = stout(j2)
               ENDDO
            ENDDO
            DO i = 1 , 6
               ph1out(200+i) = forvec(i)
            ENDDO
            DO i = 1 , 5
               ph1out(206+i) = forvec(i+7)
               ph1out(211+i) = forvec(i+13)
            ENDDO
            RETURN
         ELSE
!
!     ZERO OUT LOCAL STRESSES
!
            sigx1 = 0.0
            sigy1 = 0.0
            sigxy1 = 0.0
            sigx2 = 0.0
            sigy2 = 0.0
            sigxy2 = 0.0
!
            IF ( nsil(1)==0 ) THEN
               z1 = 0.0
               z2 = 0.0
               spag_nextblock_1 = 3
            ELSE
!
!     FORM SUMMATION
!
               DO i = 1 , 6
!
!     POINTER TO DISPLACEMENT VECTOR IN VARIABLE CORE
!
                  npoint = ivec + nsil(i) - 1
!
                  ii1 = (ii-1)*180 + 30*i - 29
                  CALL gmmats(si(ii1),5,6,0,z(npoint),6,1,0,vec(1))
!
                  DO j = 2 , 6
                     ij = (ii-1)*6 + j
                     forvec(ij) = forvec(ij) + vec(j-1)
                  ENDDO
               ENDDO
!
               IF ( tloads/=0 ) THEN
                  jst = 741 + (ii-1)*3
                  i1 = (ii-1)*6
                  flag = .FALSE.
                  f1 = Ti(6)
                  IF ( n1==1 ) THEN
                     forvec(i1+2) = forvec(i1+2) + Ti(2)*ph1out(jst+1)
                     forvec(i1+3) = forvec(i1+3) + Ti(2)*ph1out(jst+2)
                     forvec(i1+4) = forvec(i1+4) + Ti(2)*ph1out(jst+3)
                     IF ( Ti(3)==0.0 .AND. Ti(4)==0.0 ) flag = .TRUE.
                  ELSE
                     forvec(i1+2) = forvec(i1+2) - Ti(2)
                     forvec(i1+3) = forvec(i1+3) - Ti(3)
                     forvec(i1+4) = forvec(i1+4) - Ti(4)
                     IF ( Ti(5)==0.0 .AND. Ti(6)==0.0 ) flag = .TRUE.
                  ENDIF
               ENDIF
!
!     FORCE VECTOR IS NOW COMPLETE
!
               IF ( ii==4 ) THEN
                  z1ovri = -1.5/ph1out(20)**2
                  z2ovri = -z1ovri
               ELSE
                  i1 = 13 + 2*ii - 1
                  i2 = i1 + 1
                  z1ovri = -12.0*ph1out(i1)/ph1out(10+ii)**3
                  z2ovri = -12.0*ph1out(i2)/ph1out(10+ii)**3
               ENDIF
               ii1 = (ii-1)*6
!
               k1 = 0
               ASSIGN 20 TO iretrn
               spag_nextblock_1 = 4
            ENDIF
            CYCLE
         ENDIF
!
 20      sigx1 = forvec(ii1+2)*z1ovri - sdelta(1)
         sigy1 = forvec(ii1+3)*z1ovri - sdelta(2)
         sigxy1 = forvec(ii1+4)*z1ovri - sdelta(3)
!
         k1 = 1
         ASSIGN 40 TO iretrn
         spag_nextblock_1 = 4
         CYCLE SPAG_DispatchLoop_1
!
 40      sigx2 = forvec(ii1+2)*z2ovri - sdelta(1)
         sigy2 = forvec(ii1+3)*z2ovri - sdelta(2)
!
         sigxy2 = forvec(ii1+4)*z2ovri - sdelta(3)
         spag_nextblock_1 = 3
      CASE (3)
!
         IF ( nph1ou(754)/=0 ) THEN
!
!     ZERO STRESS VECTOR STORAGE
!
            DO i = 1 , 3
               stress(i) = 0.0
            ENDDO
!
!                            I=NPTS
!        STRESS VECTOR = (  SUMMATION(S )(U )  ) - (S )(LDTEMP - T )
!                            I=1       I   I         T            0
!
            DO i = 1 , 6
!
!     POINTER TO I-TH SIL IN PH1OUT
!     POINTER TO DISPLACEMENT VECTOR IN VARIABLE CORE
!     POINTER TO S SUB I 3X3
!
               npoint = 754 + i
               npoint = ivec + nph1ou(npoint) - 1
               npt1 = 762 + (i-1)*18 + (ii-1)*108
               CALL gmmats(ph1out(npt1),3,6,0,z(npoint),6,1,0,vec(1))
!
               DO j = 1 , 3
                  stress(j) = stress(j) + vec(j)
               ENDDO
!
            ENDDO
!
            IF ( ldtemp/=-1 ) THEN
!
!     POINTER TO T SUB 0 = 761
!
               tem = ftemp - ph1out(761)
               DO i = 1 , 3
                  npoint = 1193 + i
                  stress(i) = stress(i) - ph1out(npoint)*tem
               ENDDO
            ENDIF
!
!     ADD MEMBRANE STRESSES TO PLATE STRESSES
!
            sigx1 = sigx1 + stress(1)
            sigy1 = sigy1 + stress(2)
            sigxy1 = sigxy1 + stress(3)
            sigx2 = sigx2 + stress(1)
            sigy2 = sigy2 + stress(2)
            sigxy2 = sigxy2 + stress(3)
         ENDIF
!
!     STRESS OUTPUT VECTOR IS THE FOLLOWING
!
!      1) ELEMENT ID
!      2) Z1 = FIBER DISTANCE 1
!      3) SIG X  1
!      4) SIG Y  1
!      5) SIG XY 1
!      6) ANGLE OF ZERO SHEAR AT Z1
!      7) SIG P1 AT Z1
!      8) SIG P2 AT Z1
!      9) TAU MAX = MAXIMUM SHEAR STRESS AT Z1
!     10) ELEMENT ID
!     11) Z2 = FIBER DISTANCE 2
!     12) SIG X  2
!     13) SIG Y  2
!     14) SIG XY 2
!     15) ANGLE OF ZERO SHEAR AT Z2
!     16) SIG P1 AT Z2
!     17) SIG P2 AT Z2
!     S7) SIG P2 AT Z2
!     18) TAU MAX = MAXIMUM SHEAR STRESS AT Z2
!
         IF ( nph1ou(755)==0 .AND. nph1ou(2)==0 ) THEN
            DO i = 2 , 18
               str(i) = 0.0
            ENDDO
         ELSE
!
!     COMPUTE PRINCIPAL STRESSES
!
            str(1) = ph1out(1)
            str(2) = ph1out(ii*2+12)
            str(3) = sigx1
            str(4) = sigy1
            str(5) = sigxy1
            str(10) = ph1out(1)
            str(11) = ph1out(ii*2+13)
            str(12) = sigx2
            str(13) = sigy2
            str(14) = sigxy2
!
            DO i = 3 , 12 , 9
               temp = str(i) - str(i+1)
               str(i+6) = sqrt((temp/2.0)**2+str(i+2)**2)
               delta = (str(i)+str(i+1))/2.0
               str(i+4) = delta + str(i+6)
               str(i+5) = delta - str(i+6)
               delta = 2.0*str(i+2)
               IF ( abs(delta)<1.0E-15 .AND. abs(temp)<1.0E-15 ) THEN
                  str(i+3) = 0.0
               ELSE
                  str(i+3) = atan2(delta,temp)*28.6478898
               ENDIF
            ENDDO
         ENDIF
         str(1) = ph1out(1)
         str(10) = ph1out(1)
!
!     ADDITION TO ELIMINATE 2ND ELEMENT ID IN OUTPUT
!
         ijk = (ii-1)*17
         stout(ijk+1) = ph1out(1)
         DO i = 2 , 9
            stout(ijk+i) = str(i)
         ENDDO
         DO i = 10 , 17
            stout(ijk+i) = str(i+1)
         ENDDO
         spag_nextblock_1 = 2
      CASE (4)
!
!     INTERNAL SUBROUTINE
!
         IF ( .NOT.(tloads==0 .OR. flag) ) THEN
            jst = 741 + (ii-1)*3
            reali(1) = ph1out(11)**3/12.0
            reali(2) = ph1out(12)**3/12.0
            reali(3) = ph1out(13)**3/12.0
            reali(4) = ph1out(20)**3/1.50
            IF ( n1/=1 ) THEN
               ff = Ti(k1+5) - Ti(1)
               IF ( abs(ph1out(k1+12+2*ii))>1.0E-07 ) THEN
                  sdelta(1) = (ph1out(jst+1)*ff+Ti(2)*ph1out(k1+12+2*ii))/reali(ii)
                  sdelta(2) = (ph1out(jst+2)*ff+Ti(3)*ph1out(k1+12+2*ii))/reali(ii)
                  sdelta(3) = (ph1out(jst+3)*ff+Ti(4)*ph1out(k1+2*ii+12))/reali(ii)
                  spag_nextblock_1 = 5
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ELSEIF ( abs(ph1out(k1+12+2*ii))>1.0E-07 ) THEN
               ff = (Ti(k1+3)-ph1out(k1+12+2*ii)*Ti(2)-Ti(1))/reali(ii)
               sdelta(1) = ph1out(jst+1)*ff
               sdelta(2) = ph1out(jst+2)*ff
               sdelta(3) = ph1out(jst+3)*ff
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         sdelta(1) = 0.0
         sdelta(2) = 0.0
         sdelta(3) = 0.0
         spag_nextblock_1 = 5
      CASE (5)
         GOTO iretrn
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE strsl2
