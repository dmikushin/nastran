!*==ktrirg.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE ktrirg
   USE c_condad
   USE c_matin
   USE c_matout
   USE c_sma1cl
   USE c_sma1dp
   USE c_sma1et
   USE c_sma1io
   USE iso_fortran_env
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   REAL(REAL64) , DIMENSION(36) :: aki
   REAL(REAL64) , DIMENSION(9) :: akt
   REAL(REAL64) :: dampc , degrad , r1 , r2 , r3 , twopi , z1 , z2 , z3
   INTEGER :: i , i1 , iai , iapp , ic1 , idel , ieror1 , ieror2 , ip , ipp , iq , ir1 , irc , ising , j , j1 , j2 , k , kode ,     &
            & matid
   INTEGER , DIMENSION(19) :: iecpt
   EXTERNAL dki , gmmatd , inverd , mat , mesage , sma1b , transd
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!
!*****
! THIS ROUTINE COMPUTES THE STIFFNESS MATRIX FOR A AXI-SYMMETRIC RING
! WITH A TRIANGULAR CROSS SECTION
!*****
!
!
!                        ECPT FOR THE TRIANGULAR RING
!
!
!                                                      TYPE
! ECPT( 1) ELEMENT IDENTIFICATION                        I
! ECPT( 2) SCALAR INDEX NO. FOR GRID POINT A             I
! ECPT( 3) SCALAR INDEX NO. FOR GRID POINT B             I
! ECPT( 4) SCALAR INDEX NO. FOR GRID POINT C             I
! ECPT( 5) MATERIAL ORIENTATION ANGLE(DEGREES)           R
! ECPT( 6) MATERIAL IDENTIFICATION                       I
! ECPT( 7) COOR. SYS. ID. FOR GRID POINT A               I
! ECPT( 8) X-COOR. OF GRID POINT A (IN BASIC COOR.)      R
! ECPT( 9) Y-COOR. OF GRID POINT A (IN BASIC COOR.)      R
! ECPT(10) Z-COOR. OF GRID POINT A (IN BASIC COOR.)      R
! ECPT(11) COOR. SYS. ID. FOR GRID POINT B               I
! ECPT(12) X-COOR. OF GRID POINT B (IN BASIC COOR.)      R
! ECPT(13) Y-COOR. OF GRID POINT B (IN BASIC COOR.)      R
! ECPT(14) Z-COOR. OF GRID POINT B (IN BASIC COOR.)      R
! ECPT(15) COOR. SYS. ID. FOR GRID POINT C               I
! ECPT(16) X-COOR. OF GRID POINT C (IN BASIC COOR.)      R
! ECPT(17) Y-COOR. OF GRID POINT C (IN BASIC COOR.)      R
! ECPT(18) Z-COOR. OF GRID POINT C (IN BASIC COOR.)      R
! ECPT(19) EL. TEMPERATURE FOR MATERIAL PROPERTIES       R
!
!
!
!
!
   !>>>>EQUIVALENCE (Constd(2),Twopi)
   !>>>>EQUIVALENCE (Constd(4),Degrad)
   !>>>>EQUIVALENCE (Iecpt(1),Ecpt(1))
   !>>>>EQUIVALENCE (R(1),R1) , (R(2),R2) , (R(3),R3) , (Z(1),Z1) , (Z(2),Z2) , (Z(3),Z3)
   !>>>>EQUIVALENCE (Aki(1),Gambq(1))
   !>>>>EQUIVALENCE (Akt(1),Teo(1))
!
! ----------------------------------------------------------------------
!
! STORE ECPT PARAMETERS IN LOCAL VARIABLES
!
   idel = iecpt(1)
   igp(1) = iecpt(2)
   igp(2) = iecpt(3)
   igp(3) = iecpt(4)
   matid = iecpt(6)
   ics(1) = iecpt(7)
   ics(2) = iecpt(11)
   ics(3) = iecpt(15)
   r(1) = ecpt(8)
   d(1) = ecpt(9)
   z(1) = ecpt(10)
   r(2) = ecpt(12)
   d(2) = ecpt(13)
   z(2) = ecpt(14)
   r(3) = ecpt(16)
   d(3) = ecpt(17)
   z(3) = ecpt(18)
   tempe = ecpt(19)
   dgama = ecpt(5)
!
!
! CHECK INTERNAL GRID POINTS FOR PIVOT POINT
!
   ipp = 0
   DO i = 1 , 3
      IF ( npvt==igp(i) ) ipp = i
   ENDDO
   IF ( ipp==0 ) CALL mesage(-30,34,idel)
!
!
! TEST THE VALIDITY OF THE GRID POINT COORDINATES
!
   ieror1 = 0
   DO i = 1 , 3
      IF ( r(i)<=0.0D0 ) THEN
         IF ( ieror1==0 ) THEN
            CALL mesage(30,211,idel)
            ieror1 = 1
         ENDIF
      ENDIF
   ENDDO
   ieror2 = 0
   DO i = 1 , 3
      IF ( d(i)/=0.0D0 ) THEN
         IF ( ieror2==0 ) THEN
            CALL mesage(30,212,idel)
            ieror2 = 1
         ENDIF
      ENDIF
   ENDDO
   IF ( ieror1/=0 .OR. ieror2/=0 ) THEN
      nogo = 2
      RETURN
   ELSEIF ( (r2-r1)*(z3-z1)-(r3-r1)*(z2-z1)>=0.0D0 ) THEN
!
!
! COMPUTE THE ELEMENT COORDINATES
!
      zmin = dmin1(z1,z2,z3)
      z1 = z1 - zmin
      z2 = z2 - zmin
      z3 = z3 - zmin
!
!
!
! FORM THE TRANSFORMATION MATRIX (6X6) FROM FIELD COORDINATES TO GRID
! POINT DEGREES OF FREEDOM
!
      DO i = 1 , 36
         gambq(i) = 0.0D0
      ENDDO
      gambq(1) = 1.0D0
      gambq(2) = r1
      gambq(3) = z1
      gambq(10) = 1.0D0
      gambq(11) = r1
      gambq(12) = z1
      gambq(13) = 1.0D0
      gambq(14) = r2
      gambq(15) = z2
      gambq(22) = 1.0D0
      gambq(23) = r2
      gambq(24) = z2
      gambq(25) = 1.0D0
      gambq(26) = r3
      gambq(27) = z3
      gambq(34) = 1.0D0
      gambq(35) = r3
      gambq(36) = z3
!
!
!     NO NEED TO COMPUTE DETERMINANT SINCE IT IS NOT USED SUBSEQUENTLY.
      ising = -1
      CALL inverd(6,gambq(1),6,d(10),0,d(11),ising,sp)
!
      IF ( ising/=2 ) THEN
!
!
!
! CALCULATE THE INTEGRAL VALUES IN ARRAY DELINT WHERE THE ORDER IS
! INDICATED BY THE FOLLOWING TABLE
!
!              DELINT( 1) - (-1,0)
!              DELINT( 2) - (-1,1)
!              DELINT( 3) - (-1,2)
!              DELINT( 4) - ( 0,0)
!              DELINT( 5) - ( 0,1)
!              DELINT( 6) - ( 1,0)
!              DELINT( 7) - ( 0,2)
!              DELINT( 8) - ( 1,2)
!
!
! TEST FOR RELATIVE SMALL AREA OF INTEGRATION
! AND IF AREA IS SMALL THEN APPROXIMATE INTEGRALS
!
         dr = dmax1(dabs(r1-r2),dabs(r2-r3),dabs(r3-r1))
         rh = dmin1(r1,r2,r3)/10.0D0
         dz = dmax1(dabs(z1-z2),dabs(z2-z3),dabs(z3-z1))
         zh = dmin1(z1,z2,z3)/10.0D0
         ra = (r1+r2+r3)/3.0D0
         za = (z1+z2+z3)/3.0D0
         area = (r1*(z2-z3)+r2*(z3-z1)+r3*(z1-z2))/2.0D0
         kode = 0
         IF ( dabs((r2-r1)/r2)<1.0D-5 ) kode = 1
         IF ( dr<=rh .OR. dz<=zh ) kode = -1
         SPAG_Loop_1_1: DO
            spag_nextblock_1 = 1
            SPAG_DispatchLoop_1: DO
               SELECT CASE (spag_nextblock_1)
               CASE (1)
!
!
                  i1 = 0
                  DO i = 1 , 3
                     ip = i - 2
                     DO j = 1 , 3
                        iq = j - 1
                        IF ( ip/=1 .OR. iq/=1 ) THEN
                           i1 = i1 + 1
                           IF ( kode<0 ) THEN
                              delint(i1) = ((ra)**ip)*((za)**iq)*area
                           ELSEIF ( kode==0 ) THEN
                              delint(i1) = dki(1,3,1,2,1,3,ip,iq,r,z) + dki(3,2,1,2,3,2,ip,iq,r,z)
                           ELSE
                              delint(i1) = dki(1,3,3,2,1,3,ip,iq,r,z)
                           ENDIF
                        ENDIF
                     ENDDO
                  ENDDO
                  d(1) = delint(6)
                  delint(6) = delint(7)
                  delint(7) = d(1)
!
!
! TEST FOR EXCESSIVE ROUND-OFF ERROR IN INTEGRAL CALCULATIONS
! AND IF IT EXIST APPROXIMATE INTEGRALS
!
                  IF ( kode<0 ) EXIT SPAG_Loop_1_1
                  DO i = 1 , 8
                     IF ( delint(i)<0.0D0 ) THEN
                        spag_nextblock_1 = 2
                        CYCLE SPAG_DispatchLoop_1
                     ENDIF
                  ENDDO
                  IF ( delint(8)>delint(7) ) THEN
                     IF ( delint(3)<delint(8) ) THEN
                        IF ( delint(3)<=delint(7) ) EXIT SPAG_Loop_1_1
                     ENDIF
                  ENDIF
                  spag_nextblock_1 = 2
               CASE (2)
                  kode = -1
                  EXIT SPAG_DispatchLoop_1
               END SELECT
            ENDDO SPAG_DispatchLoop_1
         ENDDO SPAG_Loop_1_1
!
!
!
! LOCATE THE MATERIAL PROPERTIES IN THE MAT1 OR MAT3 TABLE
!
         matidc = matid
         matflg = 7
         eltemp = tempe
         CALL mat(idel)
!
!
! SET MATERIAL PROPERTIES IN DOUBLE PRECISION VARIABLES
!
         er = e(1)
         et = e(2)
         ez = e(3)
         vrt = anu(1)
         vtz = anu(2)
         vzr = anu(3)
         grz = g(3)
         vtr = vrt*et/er
         vzt = vtz*ez/et
         vrz = vzr*er/ez
         del = 1.0D0 - vrt*vtr - vtz*vzt - vzr*vrz - vrt*vtz*vzr - vrz*vtr*vzt
!
!
! GENERATE ELASTIC CONSTANTS MATRIX (4X4)
!
         ee(1) = er*(1.0D0-vtz*vzt)/del
         ee(2) = er*(vtr+vzr*vtz)/del
         ee(3) = er*(vzr+vtr*vzt)/del
         ee(4) = 0.0D0
         ee(5) = ee(2)
         ee(6) = et*(1.0D0-vrz*vzr)/del
         ee(7) = et*(vzt+vrt*vzr)/del
         ee(8) = 0.0D0
         ee(9) = ee(3)
         ee(10) = ee(7)
         ee(11) = ez*(1.0D0-vrt*vtr)/del
         ee(12) = 0.0D0
         ee(13) = 0.0D0
         ee(14) = 0.0D0
         ee(15) = 0.0D0
         ee(16) = grz
!
!
! FORM TRANSFORMATION MATRIX (4X4) FROM MATERIAL AXIS TO ELEMENT
! GEOMETRIC AXIS
!
         dgamr = dgama*degrad
         cosg = dcos(dgamr)
         sing = dsin(dgamr)
         teo(1) = cosg**2
         teo(2) = 0.0D0
         teo(3) = sing**2
         teo(4) = sing*cosg
         teo(5) = 0.0D0
         teo(6) = 1.0D0
         teo(7) = 0.0D0
         teo(8) = 0.0D0
         teo(9) = teo(3)
         teo(10) = 0.0D0
         teo(11) = teo(1)
         teo(12) = -teo(4)
         teo(13) = -2.0D0*teo(4)
         teo(14) = 0.0D0
         teo(15) = -teo(13)
         teo(16) = teo(1) - teo(3)
!
!
! TRANSFORM THE ELASTIC CONSTANTS MATRIX FROM MATERIAL
! TO ELEMENT GEOMETRIC AXIS
!
         CALL gmmatd(teo,4,4,1,ee,4,4,0,d)
         CALL gmmatd(d,4,4,0,teo,4,4,0,ee)
!
!
!
! FORM THE ELEMENT STIFFNESS MATRIX IN FIELD COORDINATES
!
         ak(1) = ee(6)*delint(1)
         ak(2) = (ee(2)+ee(6))*delint(4)
         ak(3) = ee(6)*delint(2) + ee(8)*delint(4)
         ak(4) = 0.0D0
         ak(5) = ee(8)*delint(4)
         ak(6) = ee(7)*delint(4)
         ak(7) = ak(2)
         ak(8) = (ee(1)+2.0D0*ee(2)+ee(6))*delint(6)
         ak(9) = (ee(2)+ee(6))*delint(5) + (ee(4)+ee(8))*delint(6)
         ak(10) = 0.0D0
         ak(11) = (ee(4)+ee(8))*delint(6)
         ak(12) = (ee(3)+ee(7))*delint(6)
         ak(13) = ak(3)
         ak(14) = ak(9)
         ak(15) = ee(6)*delint(3) + 2.0D0*ee(8)*delint(5) + ee(16)*delint(6)
         ak(16) = 0.0D0
         ak(17) = ee(8)*delint(5) + ee(16)*delint(6)
         ak(18) = ee(7)*delint(5) + ee(12)*delint(6)
         ak(19) = 0.0D0
         ak(20) = 0.0D0
         ak(21) = 0.0D0
         ak(22) = 0.0D0
         ak(23) = 0.0D0
         ak(24) = 0.0D0
         ak(25) = ak(5)
         ak(26) = ak(11)
         ak(27) = ak(17)
         ak(28) = 0.0D0
         ak(29) = ee(16)*delint(6)
         ak(30) = ee(12)*delint(6)
         ak(31) = ak(6)
         ak(32) = ak(12)
         ak(33) = ak(18)
         ak(34) = 0.0D0
         ak(35) = ak(30)
         ak(36) = ee(11)*delint(6)
!
         DO i = 1 , 36
            ak(i) = twopi*ak(i)
         ENDDO
!
! TRANSFORM THE ELEMENT STIFFNESS MATRIX FROM FIELD COORDINATES
! TO GRID POINT DEGREES OF FREEDOM
!
         CALL gmmatd(gambq,6,6,1,ak,6,6,0,d)
         CALL gmmatd(d,6,6,0,gambq,6,6,0,ak)
!
!
!
! ZERO OUT THE (6X6) MATRIX USED AS INPUT TO THE INSERTION ROUTINE
!
         DO i = 1 , 36
            aki(i) = 0.0D0
         ENDDO
!
!
! LOCATE THE TRANSFORMATION MATRICES FOR THE THREE GRID POINTS
!
         DO i = 1 , 3
            IF ( ics(i)/=0 ) THEN
               k = 9*(i-1) + 1
               CALL transd(ics(i),d(k))
            ENDIF
         ENDDO
!
!
!
! START THE LOOP FOR INSERTION OF THE THREE (6X6) MATRICES
! INTO THE MASTER STIFFNESS MATRIX
!
         ir1 = 2*ipp - 1
         iapp = 9*(ipp-1) + 1
         DO i = 1 , 3
!
! PLACE THE APPROIATE (2X2) SUBMATRIX OF THE STIFFNESS MATRIX
! IN A (3X3) MATRIX FOR TRANSFORMATION
!
            ic1 = 2*i - 1
            irc = (ir1-1)*6 + ic1
            akt(1) = ak(irc)
            akt(2) = 0.0D0
            akt(3) = ak(irc+1)
            akt(4) = 0.0D0
            akt(5) = 0.0D0
            akt(6) = 0.0D0
            akt(7) = ak(irc+6)
            akt(8) = 0.0D0
            akt(9) = ak(irc+7)
!
! TRANSFORM THE (3X3) STIFFNESS MATRIX
!
            IF ( ics(ipp)/=0 ) THEN
               CALL gmmatd(d(iapp),3,3,1,akt(1),3,3,0,d(28))
               DO j = 1 , 9
                  akt(j) = d(j+27)
               ENDDO
            ENDIF
            IF ( ics(i)/=0 ) THEN
               iai = 9*(i-1) + 1
               CALL gmmatd(akt(1),3,3,0,d(iai),3,3,0,d(28))
               DO j = 1 , 9
                  akt(j) = d(j+27)
               ENDDO
            ENDIF
!
! PLACE THE TRANSFORMED (3X3) MATRIX INTO A (6X6) MATRIX FOR
! THE INSERTION ROUTINE
!
            j = 0
            DO j1 = 1 , 18 , 6
               DO j2 = 1 , 3
                  j = j + 1
                  k = j1 + j2 - 1
                  aki(k) = akt(j)
               ENDDO
            ENDDO
!
! CALL THE INSERTION ROUTINE
!
            CALL sma1b(aki(1),igp(i),-1,ifkgg,0.0D0)
            IF ( iopt4/=0 .AND. gsube/=0.0 ) THEN
               k4ggsw = 1
               dampc = gsube
               CALL sma1b(aki(1),igp(i),-1,if4gg,dampc)
            ENDIF
         ENDDO
         RETURN
      ENDIF
   ENDIF
   CALL mesage(30,26,idel)
!
!  SET FLAG FOR FATAL ERROR WHILE ALLOWING ERROR MESSAGES TO ACCUMULATE
!
   nogo = 1
!
END SUBROUTINE ktrirg
