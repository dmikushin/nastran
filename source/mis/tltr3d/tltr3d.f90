!*==tltr3d.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE tltr3d
   USE c_blank
   USE c_condad
   USE c_matin
   USE c_sgtmpd
   USE c_system
   USE c_terms
   USE c_trimex
   USE c_zzzzzz
   USE iso_fortran_env
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   REAL(REAL64) , DIMENSION(1) :: aic
   REAL(REAL64) , DIMENSION(3) :: alfab , alfam , cente , edglen , gtemps , shpt , talfab , talfam , thrmom
   REAL(REAL64) , DIMENSION(6) :: alpha , bterms , dgpth , epslnt , epsubt , ftherm , gepsbt
   REAL(REAL64) :: avgthk , detg2 , detjac , lx , ly , mominr , offset , reali , rho , tbar , tgrad , th , thetae , thetam , tmean ,&
                 & ts , weight , wtstif
   REAL , DIMENSION(4,3) :: bgpdt
   REAL(REAL64) , DIMENSION(162) :: bmatrx
   LOGICAL :: compos , noalfa , sheart , tempp1 , tempp2
   REAL , DIMENSION(4) :: ecpt
   REAL(REAL64) , DIMENSION(4) :: egnor
   REAL(REAL64) , DIMENSION(4,3) :: egpdt , epnorm , gpnorm
   INTEGER :: elid , flag , i , ial , iec , ierr , ig , ig1 , ig2 , ig4 , ipnt , ipoint , ipt , ir , isngg2 , j , jg , k , ll ,     &
            & mcsid , nd2 , nd6 , nd7 , nd8 , ndof , nnod2 , nnode , npart , pid
   REAL :: elth , gdum , gsube , tempel , tsub0 , zoff , zoff1
   REAL(REAL64) , SAVE :: eps
   REAL(REAL64) , DIMENSION(6,6) :: g
   REAL(REAL64) , DIMENSION(3,3) :: g2
   REAL(REAL64) , DIMENSION(36) :: gi , tmptrn
   REAL , DIMENSION(3) :: gpth
   INTEGER , SAVE :: hunmeg
   INTEGER , DIMENSION(4,3) :: igpdt
   INTEGER , DIMENSION(3,3) :: indxg2
   INTEGER , DIMENSION(3) :: iorder , sil
   REAL , DIMENSION(1) :: loadvc
   INTEGER , DIMENSION(4) :: mid , necpt
   INTEGER , DIMENSION(39) :: nest
   REAL(REAL64) , DIMENSION(6,3) :: pt , ptg
   REAL(REAL64) , DIMENSION(9) :: tbg , teb , tem , teu , tub , tum
   REAL(REAL64) , DIMENSION(27) :: trans
   EXTERNAL gmmatd , inverd , mesage , shcsgd , shctsd , shgmgd , t3bmgd , t3setd , tldrd , transd
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     DOUBLE PRECISION ROUTINE TO GENERATE EQUIVALENT THERMAL LOADS FOR
!     THE CTRIA3 ELEMENT.
!
!     WAS NAMED T3THLD (LOADVC,INTZ,Z) IN UAI
!
!
!
!                 EST  LISTING
!
!        WORD     TYP       DESCRIPTION
!     ----------------------------------------------------------------
!     ECT:
!         1        I   ELEMENT ID, EID
!         2-4      I   SIL LIST, GRIDS 1,2,3
!         5-7      R   MEMBRANE THICKNESSES T, AT GRIDS 1,2,3
!         8        R   MATERIAL PROPERTY ORIENTAION ANGLE, THETA
!               OR I   COORD. SYSTEM ID (SEE TM ON CTRIA3 CARD)
!         9        I   TYPE FLAG FOR WORD 8
!        10        R   GRID OFFSET, ZOFF
!    EPT:
!        11        I   MATERIAL ID FOR MEMBRANE, MID1
!        12        R   ELEMENT THICKNESS,T (MEMBRANE, UNIFORMED)
!        13        I   MATERIAL ID FOR BENDING, MID2
!        14        R   MOMENT OF INERTIA FACTOR, I (BENDING)
!        15        I   MATERIAL ID FOR TRANSVERSE SHEAR, MID3
!        16        R   TRANSV. SHEAR CORRECTION FACTOR, TS/T
!        17        R   NON-STRUCTURAL MASS, NSM
!        18-19     R   STRESS FIBER DISTANCES, Z1,Z2
!        20        I   MATERIAL ID FOR MEMBRANE-BENDING COUPLING, MID4
!        21        R   MATERIAL ANGLE OF ROTATION, THETA
!               OR I   COORD. SYSTEM ID (SEE MCSID ON PSHELL CARD)
!                      (DEFAULT FOR WORD 8)
!        22        I   TYPE FLAG FOR WORD 21 (DEFAULT FOR WORD 9)
!        23        I   INTEGRATION ORDER FLAG
!        24        R   STRESS ANGLE OF RATATION, THETA
!               OR I   COORD. SYSTEM ID (SEE SCSID ON PSHELL CARD)
!        25        I   TYPE FLAG FOR WORD 24
!        26        R   OFFSET, ZOFF1 (DEFAULT FOR WORD 10)
!    BGPDT:
!        27-38   I/R   CID,X,Y,Z  FOR GRIDS 1,2,3
!    ETT:
!        39        I   ELEMENT TEMPERATURE
!
!
!
   !>>>>EQUIVALENCE (Est(1),Nest(1)) , (Est(2),Sil(1)) , (Est(5),Gpth(1)) , (Est(10),Zoff) , (Est(12),Elth) , (Est(26),Zoff1) ,          &
!>>>>    & (Est(39),Tempel) , (Est(27),Bgpdt(1,1),Igpdt(1,1))
   !>>>>EQUIVALENCE (necpt(1),ecpt(1)) , (Stemp(7),Flag) , (Z(1),Loadvc(1))
   DATA hunmeg , eps/100000000 , 1.0D-7/
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!
!     INITIALIZE
!
         nnode = 3
         elid = nest(1)
         weight = 1.0D0/6.0D0
         sheart = .FALSE.
         noalfa = .FALSE.
         tgrad = 0.0D0
         eltemp = tempel
         offset = zoff
         IF ( zoff==0.0 ) offset = zoff1
!
         DO ll = 1 , 3
            talfam(ll) = 0.0D0
            talfab(ll) = 0.0D0
            ftherm(ll) = 0.0D0
            ftherm(ll+3) = 0.0D0
         ENDDO
!
!     TEST FOR COMPOSITE ELEMENT
!
         pid = nest(11) - hunmeg
         compos = comps== - 1 .AND. pid>0
!
!     CHECK FOR THE TYPE OF TEMPERATURE DATA
!     - TYPE TEMPP1 ALSO INCLUDES TYPE TEMPP3.
!     - IF TEMPPI ARE NOT SUPPLIED, GRID POINT TEMPERATURES ARE PRESENT.
!
         tempp1 = flag==13
         tempp2 = flag==2
!
!     SET UP THE ELEMENT FORMULATION
!
         CALL t3setd(ierr,sil,igpdt,elth,gpth,dgpth,egpdt,gpnorm,epnorm,iorder,teb,tub,cente,avgthk,lx,ly,edglen,elid)
         IF ( ierr==0 ) THEN
            CALL gmmatd(teb,3,3,0,tub,3,3,1,teu)
!
!     SET THE NUMBER OF DOF'S
!
            nnod2 = nnode*nnode
            ndof = nnode*6
            npart = ndof*ndof
            nd2 = ndof*2
            nd6 = ndof*6
            nd7 = ndof*7
            nd8 = ndof*8
!
!     OBTAIN MATERIAL INFORMATION
!
!     PASS THE LOCATION OF THE ELEMENT CENTER FOR MATERIAL
!     TRANSFORMATIONS.
!
            DO iec = 2 , 4
               ecpt(iec) = cente(iec-1)
            ENDDO
!
!     SET MATERIAL FLAGS
!     0.833333333D0 = 5.0D0/6.0D0
!
            IF ( nest(13)/=0 ) mominr = est(14)
            IF ( nest(13)/=0 ) ts = est(16)
            IF ( est(16)==.0 ) ts = 0.83333333D0
            IF ( nest(13)==0 .AND. nest(11)>hunmeg ) ts = 0.83333333D0
!
            mid(1) = nest(11)
            mid(2) = nest(13)
            mid(3) = nest(15)
            mid(4) = nest(20)
!
            membrn = mid(1)>0
            bendng = mid(2)>0 .AND. mominr>0.0D0
            shrflx = mid(3)>0
            mbcoup = mid(4)>0
            norpth = mid(1)==mid(2) .AND. mid(1)==mid(3) .AND. mid(4)==0 .AND. dabs(mominr-1.0D0)<=eps
!
!     SET UP TRANSFORMATION MATRIX FROM MATERIAL TO ELEMENT COORD.SYSTEM
!
            CALL shcsgd(*20,nest(9),nest(8),nest(8),nest(21),nest(20),nest(20),necpt,tub,mcsid,thetam,tum)
            CALL gmmatd(teu,3,3,0,tum,3,3,0,tem)
!
!     CALCULATE THE ANGLE BETWEEN THE MATERIAL AXIS AND THE ELEMENT AXIS
!
            thetae = datan2(tem(4),tem(1))
!
!     FETCH MATERIAL PROPERTIES
!
            CALL shgmgd(*40,elid,tem,mid,ts,noalfa,gi,rho,gsube,tsub0,egnor,alpha)
!
            DO ial = 1 , 3
               alfam(ial) = alpha(ial)
               alfab(ial) = alpha(ial+3)
            ENDDO
!
!     TURN OFF THE COUPLING FLAG WHEN MID4 IS PRESENT WITH ALL
!     CALCULATED ZERO TERMS.
!
            IF ( mbcoup ) THEN
               DO i = 28 , 36
                  IF ( dabs(gi(i))>eps ) GOTO 10
               ENDDO
               mbcoup = .FALSE.
            ENDIF
!
!     OBTAIN TEMPERATURE INFORMATION
!
!     IF TEMPP1 DATA, GET AVERAGE TEMP AND THERMAL GRADIENT.
!
 10         IF ( tempp1 ) THEN
               tmean = stemp(1)
               tgrad = stemp(2)
!
!     IF TEMPP2 DATA, GET THERMAL MOMENTS.
!
            ELSEIF ( .NOT.tempp2 ) THEN
!
!     TEMPPI TEMPERATURE DATA IS NOT AVAILABLE, THEREFORE SORT THE GRID
!     POINT TEMPERATURES (IN STEMP(1-7)).
!
               DO i = 1 , nnode
                  ipnt = iorder(i)
                  gtemps(i) = stemp(ipnt)
               ENDDO
               tmean = (gtemps(1)+gtemps(2)+gtemps(3))/3.0D0
            ELSE
               tmean = stemp(1)
!
               thrmom(1) = stemp(2)
               thrmom(2) = stemp(3)
               thrmom(3) = stemp(4)
!
               ftherm(4) = thrmom(1)
               ftherm(5) = thrmom(2)
               ftherm(6) = thrmom(3)
            ENDIF
            tbar = tmean - tsub0
!
!     CALCULATE THERMAL STRAINS FOR COMPOSITE ELEMENTS
!
            IF ( compos ) THEN
               CALL shctsd(ierr,elid,pid,mid,avgthk,tmean,tgrad,thetae,ftherm,epslnt,z,z)
               IF ( ierr/=0 ) THEN
!
!     FATAL ERRORS
!
                  WRITE (nout,99001)
99001             FORMAT ('0*** SYSTEM FATAL ERROR.  APPROPRIATE COMPOSITE DATA ','NOT FOUND IN MODULE SSG1.')
                  spag_nextblock_1 = 4
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDIF
!
!     INITIALIZE FOR THE MAIN INTEGRATION LOOP
!
            DO i = 1 , 6
               epsubt(i) = 0.0D0
               DO j = 1 , nnode
                  pt(i,j) = 0.0D0
                  ptg(i,j) = 0.0D0
               ENDDO
            ENDDO
!
!     MAIN INTEGRATION LOOP
!
            DO ipt = 1 , nnode
               CALL t3bmgd(ierr,sheart,ipt,iorder,egpdt,dgpth,aic,th,detjac,shpt,bterms,bmatrx)
               IF ( ierr/=0 ) THEN
                  spag_nextblock_1 = 2
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
!
               wtstif = detjac*weight
               reali = mominr*th*th*th/12.0D0
!
!     FILL IN THE 6X6 [G]
!
               DO ig = 1 , 6
                  DO jg = 1 , 6
                     g(ig,jg) = 0.0D0
                  ENDDO
               ENDDO
!
               IF ( membrn ) THEN
                  DO ig = 1 , 3
                     ig1 = (ig-1)*3
                     DO jg = 1 , 3
                        g(ig,jg) = gi(ig1+jg)*th
                     ENDDO
                  ENDDO
               ENDIF
!
               IF ( bendng ) THEN
                  DO ig = 4 , 6
                     ig2 = (ig-2)*3
                     DO jg = 4 , 6
                        g(ig,jg) = gi(ig2+jg)*reali
                     ENDDO
                  ENDDO
!
                  IF ( mbcoup ) THEN
                     DO ig = 1 , 3
                        ig4 = (ig+8)*3
                        DO jg = 1 , 3
                           g(ig,jg+3) = gi(ig4+jg)*th*th
                           g(ig+3,jg) = g(ig,jg+3)
                        ENDDO
                     ENDDO
                  ENDIF
               ENDIF
!
!     PREPARE THERMAL STRAINS FOR COMPOSITE ELEMENTS
!
               IF ( .NOT.compos ) THEN
!
!     CALCULATE THERMAL STRAINS FOR NON-COMPOSITE ELEMENTS
!
                  IF ( membrn ) THEN
                     DO i = 1 , 3
                        talfam(i) = tbar*alfam(i)
                     ENDDO
                  ENDIF
!
                  IF ( bendng ) THEN
                     IF ( tempp1 ) THEN
                        DO i = 1 , 3
                           talfab(i) = -tgrad*alfab(i)
                        ENDDO
!
                     ELSEIF ( .NOT.tempp2 ) THEN
!
                        DO i = 1 , 3
                           talfab(i) = 0.0D0
                        ENDDO
                     ELSE
                        DO ig = 1 , 3
                           DO jg = 1 , 3
                              g2(ig,jg) = g(ig+3,jg+3)
                           ENDDO
                        ENDDO
!
                        CALL inverd(3,g2,3,gdum,0,detg2,isngg2,indxg2)
                        CALL gmmatd(g2,3,3,0,thrmom,3,1,0,talfab)
                     ENDIF
                  ENDIF
!
                  DO i = 1 , 3
                     epsubt(i) = wtstif*talfam(i)
                     epsubt(i+3) = wtstif*talfab(i)
                  ENDDO
               ELSE
                  DO ir = 1 , 6
                     epsubt(ir) = wtstif*epslnt(ir)
                  ENDDO
               ENDIF
!
!                                T
!     [P]  = [P]  + WTSTIF*[B] [G][EPS]
!        T      T                      T
!
               CALL gmmatd(g,6,6,0,epsubt,6,1,0,gepsbt)
               CALL gmmatd(bmatrx,6,ndof,-1,gepsbt,6,1,0,pt)
!
            ENDDO
!
!     END OF MAIN INTEGRATION LOOP
!
!     PICK UP THE ELEMENT TO GLOBAL TRANSFORMATION FOR EACH NODE.
!
            DO i = 1 , nnode
               ipoint = 9*(i-1) + 1
               CALL transd(bgpdt(1,i),tbg)
               CALL gmmatd(teb,3,3,0,tbg,3,3,0,trans(ipoint))
            ENDDO
!
!     TRANSFORM THE THERMAL LOAD VECTOR INTO THE INDIVIDUAL GLOBAL
!     COORDINATE SYSTEMS OF EACH NODE.
!
!                 T
!     [PT] = [TEG] [PT]
!         G            E
!
            DO i = 1 , nnode
               CALL tldrd(offset,i,trans,tmptrn)
               CALL gmmatd(tmptrn,6,6,1,pt(1,i),6,1,0,ptg(1,i))
            ENDDO
!
!     ADD THE THERMAL LOAD VECTOR TO THE GLOBAL LOAD VECTOR WHICH
!     RESIDES IN [LOADVC].
!
            DO i = 1 , nnode
               k = sil(i) - 1
               DO j = 1 , 6
                  loadvc(k+j) = loadvc(k+j) + sngl(ptg(j,i))
               ENDDO
            ENDDO
            RETURN
         ENDIF
         spag_nextblock_1 = 2
      CASE (2)
         j = 224
         spag_nextblock_1 = 3
         CYCLE SPAG_DispatchLoop_1
 20      j = 225
         nest(2) = mcsid
         spag_nextblock_1 = 3
         CYCLE SPAG_DispatchLoop_1
 40      j = 226
         nest(2) = mid(3)
         spag_nextblock_1 = 3
      CASE (3)
         CALL mesage(30,j,nest(1))
         spag_nextblock_1 = 4
      CASE (4)
         nogo = 1
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
!
END SUBROUTINE tltr3d