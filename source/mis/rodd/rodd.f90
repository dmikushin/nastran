!*==rodd.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE rodd
   USE c_emgdic
   USE c_emgest
   USE c_emgprm
   USE c_hmtout
   USE c_matin
   USE c_matout
   USE c_system
   USE c_xmssg
   USE c_zzzzzz
   USE iso_fortran_env
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   REAL :: cp
   INTEGER , DIMENSION(7) :: dict
   REAL(REAL64) :: el , ke , me , scale , te
   REAL , DIMENSION(200) :: est
   REAL(REAL64) , DIMENSION(3) :: evect , ha , hb , kha , khb
   INTEGER :: i , iaa , iaaz , iab , iabz , iba , ibaz , ibb , ibbz , icode , iheat , ij , ioutpt , ipart , ipass , iti , itj , iz ,&
            & izero , izp5 , izpi , j , kz , ldata , ndof , ng , npart , nsq , nz
   INTEGER , DIMENSION(13) :: iest
   REAL(REAL64) , DIMENSION(9) :: massii , massij , massji , massjj , mijdum , mjidum , ta , tb
   EXTERNAL emgout , gmmatd , hmat , mat , transd
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     THIS ROUTINE PROCESSES ROD ELEMENT DATA TO PRODUCE STIFFNESS AND
!     MASS MATRICES. IF THE HEAT TRANSFER OPTION IS ON, CONDUCTIVITY AND
!     CAPACITY MATRICES ARE PRODUCED
!
!     THIS ROUTINE CAN COMPUTE BOTH CONVENTIONAL AND CONSISTENT
!     MASS MATRICES
!
!     DOUBLE PRECISION VERSION
!
!     THIS VERSION WAS SPECIALLY CODED TO ILLUSTRATE A GENERAL
!     USE OF THE IMPROVED MATRIX GENERATOR.
!
!     THE EST ENTRY FOR THIS ELEMENT CONTAINS
!
!     POSITION     NAME       DESCRIPTION
!     *****        *****      *******************************
!     1             EID       ELEMENT ID NO.
!     2             SIL1      SCALAR INDEX OF POINT A
!     3             SIL2      SCALAR INDEX OF POINT B
!     4             MID       MATERIAL DATA ID
!     5             AFACT     AREA OF CROSS SECTION
!     6             JFACT     TORSIONAL STIFFNESS COEFFICIENT
!     7             CFACT     TORSIONAL STRESS RECOVERY DISTANCE
!     8             MU        NON-STRUCTURAL MASS PER LENGTH
!     9-16          BGPDT     BASIC GRID POINT DATA. COORDINATE SYSTEM
!                             NUMBER AND  X,Y,Z LOCATION FOR 2 POINTS
!     17            TBAR      AVERAGE ELEMENT TEMPERATURE
!
!
!
!     THE VARIABLE K IS OPEN CORE. OPEN SPACE EXISTS FROM Z(IZ) TO Z(NZ)
!     THIS IS INTENDED AS AN EXAMPLE. NORMALLY FOR SMALL ARRAYS
!     LOCAL VARIABLES MAY BE USED.
!
   !>>>>EQUIVALENCE (Ksystm(2),Ioutpt) , (Ksystm(56),Iheat) , (Eid,Est(1),Iest(1)) , (Cp,Kcon)
!
!     FOR DOUBLE PRECISION THE POINTERS TO OPEN CORE MUST BE MODIFIED.
!
         iz = (izr-2)/iprec + 2
         nz = nzr/iprec
         IF ( nz-iz<=144 ) THEN
!
            nogo = .TRUE.
            WRITE (ioutpt,99001) ufm
99001       FORMAT (A23,' 3119, INSUFFICIENT CORE TO PROCESS ROD ELEMENTS')
            RETURN
         ELSE
            dict(1) = estid
!
!     SUBTRACT BASIC LOCATIONS TO OBTAIN LENGTH ETC.
!
            DO i = 1 , 3
               evect(i) = bgpdt(i+1,2) - bgpdt(i+1,1)
            ENDDO
!
            el = dsqrt(evect(1)**2+evect(2)**2+evect(3)**2)
            IF ( el<=0.0D0 ) THEN
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ENDIF
!
!     IF HEAT TRANSFER PROBLEM TRANSFER.  CALL MATERIAL SUBROUTINE
!
            inflag = 1
            matid = mid
            eltemp = tbar
            IF ( iheat==1 ) THEN
!
!     HEAT TRANSFER CALCULATIONS ARE PERFORMED HERE
!
               inflag = 1
               dict(2) = 1
               dict(3) = 2
               dict(4) = 1
               dict(5) = 0
               IF ( kmbgg(1)/=0 ) THEN
                  CALL hmat(eid)
                  k(iz) = dble(afact*kcon)/el
                  IF ( k(iz)/=0.0D0 ) THEN
                     k(iz+1) = -k(iz)
                     k(iz+2) = -k(iz)
                     k(iz+3) = k(iz)
                     CALL emgout(k(iz),k(iz),4,1,dict,1,iprec)
                  ENDIF
               ENDIF
               inflag = 4
               IF ( kmbgg(1)==0 ) RETURN
               CALL hmat(eid)
               k(iz) = dble(afact*cp)*el/2.0D0
               IF ( k(iz)==0.0D0 ) RETURN
               k(iz+1) = k(iz)
               dict(2) = 2
               CALL emgout(k(iz),k(iz),2,1,dict,3,iprec)
               RETURN
            ELSE
               CALL mat(eid)
               ke = dble(e*afact)/el
               me = (dble(rho*afact+mu))*el/2.0D0
               te = dble(g*jfact)/el
!
!     PROCESS STIFFNESS HERE
!
               IF ( kmbgg(1)==0 ) THEN
                  spag_nextblock_1 = 4
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               IF ( ke==0.0D0 .AND. te==0.0D0 ) THEN
                  spag_nextblock_1 = 4
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
!
!     GENERATE   HA  =  (E*TA)/EL   AND  HB = (E*TB)/EL
!
               IF ( iest(9)==0 ) THEN
                  DO i = 1 , 3
                     ha(i) = evect(i)/el
                  ENDDO
               ELSE
                  CALL transd(bgpdt(1,1),ta)
                  CALL gmmatd(evect,1,3,0,ta,3,3,0,ha)
                  DO i = 1 , 3
                     ha(i) = ha(i)/el
                  ENDDO
               ENDIF
               IF ( iest(13)==0 ) THEN
                  DO i = 1 , 3
                     hb(i) = evect(i)/el
                  ENDDO
               ELSE
                  CALL transd(bgpdt(1,2),tb)
                  CALL gmmatd(evect,1,3,0,tb,3,3,0,hb)
                  DO i = 1 , 3
                     hb(i) = hb(i)/el
                  ENDDO
               ENDIF
!
!     THE GENERAL 12X12  MATRIX FOR THE ROD ELEMENT IS
!                            -                              -
!                            1HA K HA1   0  1HA K HB1       1
!                **   **     1 ------1------1-------1-------1
!                *  K  *   = 1   0   1HA T A1       1HA T HB1
!                **   **     1 ------1------1-------1-------1
!                            1HB K HA1      1HB K HB1       1
!                            1 ------1------1-------1-------1
!                            1       1HB T A1       1HB T HB1
!                            1       1      1       1       1
!                            -                              -
!                      EACH BLOCK  ABOVE IS A 3 BY 3 MATRIX
!
!     TEST AND SET COMPONENT CODE    111= 7     111000=56
!
               icode = 0
               ndof = 0
               IF ( te==0.D0 ) THEN
                  icode = 7
                  ndof = 6
               ELSEIF ( ke/=0.D0 ) THEN
                  icode = 63
                  ndof = 12
               ELSE
                  icode = 56
                  ndof = 6
               ENDIF
               nsq = ndof**2
               ng = ndof/2
               npart = ng*ndof
               izero = iz - 1
               ipass = 1
               DO i = 1 , nsq
                  izpi = iz + i - 1
                  k(izpi) = 0.0D0
               ENDDO
!
!     EXTENSIONAL STIFFNESS TERMS ARE COMPUTED HERE.
!
               IF ( icode==56 ) THEN
                  spag_nextblock_1 = 3
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               scale = ke
            ENDIF
         ENDIF
         spag_nextblock_1 = 2
      CASE (2)
         DO i = 1 , 3
            kha(i) = scale*ha(i)
            khb(i) = scale*hb(i)
         ENDDO
!
!     THE MATRIX COLUMNS AND ROWS MUST BE IN THE NUMERICAL ORDER
!     OF TH SIL VALUES. THE POINTERS INTO THE MATRIX ARE VARIABLES.
!
         IF ( sil2<sil1 ) THEN
            ibbz = izero
            iabz = izero + ng
            ibaz = izero + npart
            iaaz = ibaz + ng
         ELSEIF ( sil2==sil1 ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ELSE
            iaaz = izero
            ibaz = izero + ng
            iabz = izero + npart
            ibbz = iabz + ng
         ENDIF
         DO j = 1 , 3
            DO i = 1 , 3
               ij = ndof*(j-1) + i
               iaa = ij + iaaz
               k(iaa) = kha(i)*ha(j)
               iba = ij + ibaz
               k(iba) = -khb(i)*ha(j)
               iab = ij + iabz
               k(iab) = -kha(i)*hb(j)
               ibb = ij + ibbz
               k(ibb) = khb(i)*hb(j)
            ENDDO
         ENDDO
         spag_nextblock_1 = 3
      CASE (3)
!
!     THE TORSIONAL STIFFNESS TERMS ARE FORMED USING TE INSTEAD OF KE
!     THEY ARE INSERTED IN THE MATRIX WITH  A CONSTANT OFFSET, 3*12+3.
!
         IF ( ipass/=2 ) THEN
            IF ( ndof==12 ) izero = 38 + iz
            ipass = 2
            scale = te
            IF ( icode/=7 ) THEN
               spag_nextblock_1 = 2
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         ipart = iz
         dict(2) = 1
         dict(3) = ndof
         dict(4) = icode
         dict(5) = ge
         CALL emgout(k(ipart),k(ipart),nsq,1,dict,1,iprec)
         spag_nextblock_1 = 4
      CASE (4)
!
!     THE MASS MATRIX TERMS ARE CALCULATED HERE.
!
         IF ( kmbgg(2)==0 .OR. me==0.0D0 ) RETURN
         dict(3) = 6
         dict(4) = 7
         dict(5) = 0
!
!     CHECK TO SEE IF CONVENTIONAL OR CONSISTENT MASS MATRIX IS REQUIRED
!
         IF ( icmbar>0 ) THEN
!
!     CONSISTENT MASS MATRIX TERMS ARE COMPUTED HERE
!
            dict(2) = 1
            ldata = 36
            DO i = 1 , 9
               massii(i) = 0.0D0
               massjj(i) = 0.0D0
               massij(i) = 0.0D0
               massji(i) = 0.0D0
               mijdum(i) = 0.0D0
               mjidum(i) = 0.0D0
            ENDDO
            me = 2.0D0*me
            DO i = 1 , 9 , 4
               massii(i) = me/3.0D0
               massjj(i) = me/3.0D0
               massij(i) = me/6.0D0
               massji(i) = me/6.0D0
               mijdum(i) = me/6.0D0
               mjidum(i) = me/6.0D0
            ENDDO
            IF ( sil2<sil1 ) THEN
               iti = 13
               itj = 9
            ELSEIF ( sil2==sil1 ) THEN
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ELSE
               iti = 9
               itj = 13
            ENDIF
            IF ( iest(iti)/=0 ) THEN
               CALL transd(iest(iti),ta)
               CALL gmmatd(ta,3,3,1,massii,3,3,0,k(iz))
               CALL gmmatd(k(iz),3,3,0,ta,3,3,0,massii)
               CALL gmmatd(ta,3,3,1,mijdum,3,3,0,massij)
               CALL gmmatd(mjidum,3,3,0,ta,3,3,0,massji)
            ENDIF
            IF ( iest(itj)/=0 ) THEN
               CALL transd(iest(itj),ta)
               CALL gmmatd(ta,3,3,1,massjj,3,3,0,k(iz))
               CALL gmmatd(k(iz),3,3,0,ta,3,3,0,massjj)
               CALL gmmatd(massij,3,3,0,ta,3,3,0,mijdum)
               CALL gmmatd(ta,3,3,1,massji,3,3,0,mjidum)
               DO i = 1 , 9
                  massij(i) = mijdum(i)
                  massji(i) = mjidum(i)
               ENDDO
            ENDIF
            DO i = 1 , 3
               kz = iz + i - 1
               k(kz) = massii(i)
               k(kz+6) = massii(i+3)
               k(kz+12) = massii(i+6)
               k(kz+3) = massij(i)
               k(kz+9) = massij(i+3)
               k(kz+15) = massij(i+6)
               k(kz+18) = massji(i)
               k(kz+24) = massji(i+3)
               k(kz+30) = massji(i+6)
               k(kz+21) = massjj(i)
               k(kz+27) = massjj(i+3)
               k(kz+33) = massjj(i+6)
            ENDDO
         ELSE
!
!     CONVENTIONAL MASS MATRIX TERMS ARE COMPUTED HERE
!
            dict(2) = 2
            ldata = 6
            izp5 = iz + 5
            DO i = iz , izp5
               k(i) = me
            ENDDO
         ENDIF
         CALL emgout(k(iz),k(iz),ldata,1,dict,2,iprec)
         RETURN
      CASE (5)
!
         nogo = .TRUE.
         WRITE (ioutpt,99002) ufm , eid
99002    FORMAT (A23,' 3118, ROD ELEMENT NO.',I9,' HAS ILLEGAL GEOMETRY OR CONNECTIONS.')
         RETURN
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE rodd
