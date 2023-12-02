!*==em3d.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE em3d(Eltype,Istart,Itype,Ncount,Ido,Iwords,Nbdys,All,Nelout)
   USE c_emecpt
   USE c_hmtout
   USE c_matin
   USE c_system
   USE c_xmssg
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Eltype
   INTEGER :: Istart
   INTEGER :: Itype
   INTEGER :: Ncount
   INTEGER :: Ido
   INTEGER :: Iwords
   INTEGER :: Nbdys
   INTEGER :: All
   INTEGER :: Nelout
!
! Local variable declarations rewritten by SPAG
!
   REAL :: ahcx , ahcy , ahcz , det , detj , g1 , g2 , g3 , h1 , h2 , h3 , hc1 , hc2 , hc3 , hl , sfact , term1 , term2 , term3 ,   &
         & term4 , vol , xm , xx , xxc , yy , yyc , zz , zzc
   REAL , DIMENSION(50) :: buf
   REAL , DIMENSION(3,32) :: bxyz , dshp , dshpb
   REAL , DIMENSION(24) :: dr
   INTEGER :: elid , frstgd , i , i1 , i2 , i3 , i4 , iel , ijk , ilis , inip , irow , is , isc2 , isil , ist , isub , isub1 ,      &
            & isub2 , isubx , isys1 , itemp , itt , j , jtype , k , k1 , k2 , kk , ktype , l , mid , nels , ng , ngrid , nip ,      &
            & nopts , np , npts , nsubx , nx , outpt , sysbuf
   REAL , DIMENSION(32) :: f , gpt , shp
   REAL , DIMENSION(9) :: g
   REAL , DIMENSION(8) , SAVE :: gauss
   REAL , DIMENSION(3) :: gh , hcxyz , xlacc
   REAL , DIMENSION(4) :: h , hcx , hcy , hcz , s
   REAL , DIMENSION(96) :: hc
   REAL , DIMENSION(60) :: hcx3
   INTEGER , DIMENSION(50) :: ibuf
   INTEGER , DIMENSION(4) :: ip
   INTEGER , DIMENSION(5) :: isc
   INTEGER , DIMENSION(1) :: iz , necpt
   REAL , DIMENSION(4,5) :: ll
   LOGICAL :: onlyc
   INTEGER , DIMENSION(7,7) , SAVE :: pointr
   REAL , DIMENSION(3,8) :: r
   REAL , DIMENSION(5) :: sc , w
   INTEGER , SAVE :: scr6 , typold
   INTEGER , DIMENSION(88) , SAVE :: tmap
   REAL , DIMENSION(3,3) :: xjacob
   REAL , DIMENSION(8) :: xload
   EXTERNAL axloop , dipole , geloop , gmmats , hmat , ihexss , mesage , write
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
   INTEGER :: spag_nextblock_3
   INTEGER :: spag_nextblock_4
   INTEGER :: spag_nextblock_5
   INTEGER :: spag_nextblock_6
!
!     E  AND  M LOADS FOR 3-D ELEMENTS
!     TETRA  39   WEDGE  40   HEXA1 41  HEXA2  42
!     IHEX1  65   IHEX2  66   IHEX3 67
!
   !>>>>EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(2),Outpt) , (Ecpt(1),Necpt(1)) , (Z(1),Iz(1)) , (i1,ip(1)) , (i2,ip(2)) , (i3,ip(3)) ,  &
!>>>>    & (i4,ip(4))
   !>>>>EQUIVALENCE (buf(1),ibuf(1)) , (isc(1),sc(1))
!
!     GRID POINT NO FOR EACH ELEMENT
!
   DATA tmap/1 , 2 , 3 , 4 , 1 , 2 , 3 , 5 , 1 , 2 , 3 , 6 , 1 , 4 , 5 , 6 , 2 , 4 , 5 , 6 , 3 , 4 , 5 , 6 , 1 , 2 , 4 , 6 , 2 , 3 ,&
      & 4 , 6 , 1 , 3 , 4 , 5 , 2 , 3 , 4 , 5 , 1 , 3 , 5 , 6 , 1 , 2 , 5 , 6 , 1 , 2 , 3 , 6 , 1 , 3 , 4 , 8 , 1 , 3 , 8 , 6 , 1 , &
      & 5 , 6 , 8 , 3 , 6 , 7 , 8 , 2 , 3 , 4 , 7 , 1 , 2 , 4 , 5 , 2 , 4 , 5 , 7 , 2 , 5 , 6 , 7 , 4 , 5 , 7 , 8/
!     DATA    NAM   / 4HEM3D,4H       /
   DATA typold/0/
   DATA scr6/306/
!
!     SET UP GAUSSIAN INTEGRATION POINTS
!
   DATA gauss/0.57735027 , 0.55555556 , 0.77459667 , 0.88888889 , 0.34785484 , 0.86113631 , 0.65214515 , 0.33998104/
!
!     SET UP POINTR ARRAY ONTO EST
!
!                    TYPE  MID   FRSTGD  ISYS1   NIP     ITEMP     NELS
   DATA pointr/39 , 2 , 3 , 7 , 0 , 23 , 1 , 40 , 2 , 3 , 9 , 0 , 33 , 12 , 41 , 2 , 3 , 11 , 0 , 43 , 5 , 42 , 2 , 3 , 11 , 0 ,    &
      & 43 , 10 , 65 , 10 , 2 , 16 , 12 , 48 , 1 , 66 , 22 , 2 , 28 , 24 , 108 , 1 , 67 , 34 , 2 , 40 , 36 , 168 , 1/
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!
         onlyc = .FALSE.
         nopts = 6
         IF ( Eltype==typold ) THEN
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         typold = Eltype
         SPAG_Loop_1_1: DO l = 1 , 7
            ilis = l
            IF ( Eltype<pointr(1,l) ) EXIT SPAG_Loop_1_1
            IF ( Eltype==pointr(1,l) ) THEN
               spag_nextblock_1 = 2
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDDO SPAG_Loop_1_1
!
         WRITE (outpt,99001) ufm
99001    FORMAT (A23,' - WRONG ELEMENT TYPE IN EM3D PROBLEM.')
         CALL mesage(-61,0,0)
         RETURN
      CASE (2)
!
!     SET UPPOINTERS INTO EST(ECPT) DATA
!
         mid = pointr(2,ilis)
!
!     MATERIAL ID
!
         frstgd = pointr(3,ilis)
!
!     FIRST SIL
!
         isys1 = pointr(4,ilis)
!
!     FIRST CSIL
!
         nip = pointr(5,ilis)
!
!     NO OF INTEGRATION POINTS (ISOPARAMETRICS ONLY)
!
         itemp = pointr(6,ilis)
!
!     TEMPERATURE DATA
!
         nels = pointr(7,ilis)
         spag_nextblock_1 = 3
      CASE (3)
!
!     NO. OF ELEMENTS
!
!     GO TO SECTION 190 FOR ISOPARAMETRICS
!
!     CHECK FOR ZERO LOAD
!
         ngrid = isys1 - frstgd
         IF ( Eltype>=65 ) ngrid = ngrid - 6
!                     65 TO 67 ??
         isc(1) = necpt(1)
         isc(2) = 1
         IF ( Eltype==65 ) isc(2) = 9
         IF ( Eltype==66 .OR. Eltype==67 ) isc(2) = 21
!
!     CHECK TO SEE IF THIS ELEMENT CONTAINS A GRID POINT ON A PERMBDY
!     CARD. IF SO, OR IF NO PERMBDY CARD EXISTS, COMPUTE LOADS FOR THE
!     ELEMENT. IF NOT, COMPUTE HC CENTROIDAL VALUE ONLY. (ONLYC=.TRUE.)
!     THE PERMBDY SILS START AT Z(ISTART-NBDYS-1)
!
         IF ( Nbdys/=0 ) THEN
!
            DO i = 1 , ngrid
               ng = necpt(frstgd+i-1)
               DO j = 1 , Nbdys
                  IF ( ng==iz(Istart-Nbdys-Nelout+j-1) ) THEN
                     spag_nextblock_1 = 4
                     CYCLE SPAG_DispatchLoop_1
                  ENDIF
               ENDDO
            ENDDO
!
!     ELEMENT HAS NO GRIDS ON PERMBDY
!
            onlyc = .TRUE.
            nopts = 1
         ENDIF
         spag_nextblock_1 = 4
      CASE (4)
         IF ( onlyc .AND. Itype==24 ) RETURN
!
!     IF ONLYC=TRUE, CHECK TO SEE IF THE ELEMENT HAD AN ELFORCE REQUEST.
!     IF SO, CONTINUE. IF NOT, JUST WRITE ZEROS TO HCCEN,SCR6) AND
!     RETURN.
!
         IF ( onlyc ) THEN
            IF ( All/=1 ) THEN
               IF ( Nelout/=0 ) THEN
!
                  DO i = 1 , Nelout
                     IF ( necpt(1)==iz(Istart-Nelout+i-1) ) THEN
                        spag_nextblock_1 = 5
                        CYCLE SPAG_DispatchLoop_1
                     ENDIF
                  ENDDO
               ENDIF
               spag_nextblock_1 = 6
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         spag_nextblock_1 = 5
      CASE (5)
         IF ( Itype/=20 .AND. Itype/=24 ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         g1 = 0.
         g2 = 0.
         g3 = 0.
         h1 = 0.
         h2 = 0.
         h3 = 0.
         SPAG_Loop_1_2: DO i = 1 , ngrid
            isub = Istart + 3*necpt(frstgd+i-1) - 3
            IF ( Itype==24 ) isub = Istart + 3*Ncount - 3
            h1 = h1 + abs(z(isub))
            h2 = h2 + abs(z(isub+1))
            h3 = h3 + abs(z(isub+2))
            g1 = g1 + z(isub)
            g2 = g2 + z(isub+1)
            g3 = g3 + z(isub+2)
            IF ( Itype==24 ) EXIT SPAG_Loop_1_2
         ENDDO SPAG_Loop_1_2
         hl = h1 + h2 + h3
         IF ( hl/=0. ) THEN
!
            IF ( Itype/=24 ) THEN
!
!     AVERGAGE SPCFLD
!
               ahcx = g1/float(ngrid)
               ahcy = g2/float(ngrid)
               ahcz = g3/float(ngrid)
            ENDIF
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ELSEIF ( Itype==24 ) THEN
            RETURN
         ENDIF
         spag_nextblock_1 = 6
      CASE (6)
!
         sc(3) = 0.
         sc(4) = 0.
         sc(5) = 0.
         CALL write(scr6,sc,2,0)
         isc2 = isc(2)
         DO i = 1 , isc2
            CALL write(scr6,sc(3),3,0)
         ENDDO
         RETURN
      CASE (7)
!
         IF ( Eltype>=65 ) THEN
!
!     ISOPARAMETRIC SOLIDS
!
            jtype = Itype
            Itype = Eltype - 64
            inip = necpt(nip)
            IF ( inip==0 ) inip = Itype/2 + 2
            np = 12*Itype - 4
            elid = necpt(1)
!
!     SET UP FOR FETCHING SHAPE FUNCTIONS
!
            DO i = 1 , np
               gpt(i) = ecpt(itemp-1+i)
               DO j = 1 , 3
                  bxyz(j,i) = ecpt(np+4+4*i+j)
               ENDDO
            ENDDO
            IF ( .NOT.(onlyc) ) THEN
               i = inip - 1
               IF ( i==2 ) THEN
                  h(1) = gauss(2)
                  s(1) = gauss(3)
                  h(2) = gauss(4)
                  s(2) = 0.
                  h(3) = h(1)
                  s(3) = -s(1)
               ELSEIF ( i==3 ) THEN
                  h(1) = gauss(5)
                  s(1) = gauss(6)
                  h(2) = gauss(7)
                  s(2) = gauss(8)
                  h(3) = h(2)
                  s(3) = -s(2)
                  h(4) = h(1)
                  s(4) = -s(1)
               ELSE
                  h(1) = 1.
                  s(1) = gauss(1)
                  h(2) = h(1)
                  s(2) = -s(1)
               ENDIF
               DO i = 1 , 32
                  f(i) = 0.0
               ENDDO
!
!     SET UP HC ARRAY GIVING HC AT EACH GRID
!
               IF ( jtype==24 ) THEN
!
!     REMFLUX
!
                  isub = Istart + 3*Ncount - 3
                  gh(1) = z(isub)
                  gh(2) = z(isub+1)
                  gh(3) = z(isub+2)
                  spag_nextblock_1 = 8
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDIF
!
!     IF SPCFLD,PICK UP GRID VALUES HERE. IF NOT, PICK UP INTEGRATION
!     POINT VALUES LATER.(THERE IS ONLY ONE SPCFLD CARD AT THIS POINT)
!
            IF ( jtype==20 ) THEN
               DO i = 1 , np
                  isil = 3*necpt(i+1)
                  hc(3*i-2) = z(Istart+isil-3)
                  hc(3*i-1) = z(Istart+isil-2)
                  hc(3*i) = z(Istart+isil-1)
               ENDDO
            ENDIF
            inflag = 3
            matid = necpt(mid)
         ELSE
            IF ( .NOT.(onlyc) ) THEN
!
!     GET MATERIAL INFO
!     INFLAG = 3  RETURNS A 3X3 MATRIX
!
               ll(1,1) = .25
               ll(2,1) = .25
               ll(3,1) = .25
               ll(4,1) = .25
               ll(1,2) = .5
               ll(2,2) = 1./6.
               ll(3,2) = ll(2,2)
               ll(4,2) = ll(2,2)
               ll(1,3) = 1./6.
               ll(2,3) = .5
               ll(3,3) = ll(1,3)
               ll(4,3) = ll(1,3)
               ll(1,4) = 1./6.
               ll(2,4) = ll(1,4)
               ll(3,4) = .5
               ll(4,4) = ll(1,4)
               ll(1,5) = 1./6.
               ll(2,5) = ll(1,5)
               ll(3,5) = ll(1,5)
               ll(4,5) = .5
               w(1) = -.8
               w(2) = 9./20.
               w(3) = w(2)
               w(4) = w(2)
               w(5) = w(2)
               inflag = 3
               matid = necpt(mid)
               eltemp = ecpt(itemp)
               CALL hmat(necpt(1))
!
!     G STORED BY ROW
!
               g(1) = xmat(1)
               g(2) = xmat(2)
               g(3) = xmat(3)
               g(4) = xmat(2)
               g(5) = xmat(4)
               g(6) = xmat(5)
               g(7) = xmat(3)
               g(8) = xmat(5)
               g(9) = xmat(6)
!
!     PUT COORDINATES OF GRID POINTS INTO ARRAY
!     FOR HEXA2  DIVIDE VOLUME BY 2.
!
               xm = 1.
               IF ( Eltype==42 ) xm = 2.
            ENDIF
!
!     TETRA   4 GRID PTS    1 ELEMENT
!     WEDGE   6 GRID PTS   18 ELEMENTS(6 ARE DUPLICATES-4 POINTS AT A
!     HEXA1   8 GRID PTS    5 ELEMENT (4 PTS AT A TIME)
!     HEXA2   8 GRID PTS    10ELEMENT (4 PTS AT A TIME)
!     SET UP PROPER POINTERS VIA TMAP
!     R ARRAY CONTAINS COORDINATE INFO
!
            DO i = 1 , ngrid
               itt = isys1 + 4*i - 4
               r(1,i) = ecpt(itt+1)
               r(2,i) = ecpt(itt+2)
               r(3,i) = ecpt(itt+3)
            ENDDO
!
!     SET UP POINTER TO GRID PT NO
!
            irow = 0
            IF ( Eltype==41 .OR. Eltype==42 ) irow = 12
            DO i = 1 , 8
               xload(i) = 0.0
            ENDDO
!
!     SET UP POINTS FOR AVERAGE COORDINATES
!
            xxc = 0.
            yyc = 0.
            zzc = 0.
            DO i = 1 , ngrid
               xxc = xxc + r(1,i)
               yyc = yyc + r(2,i)
               zzc = zzc + r(3,i)
            ENDDO
            xxc = xxc/float(ngrid)
            yyc = yyc/float(ngrid)
            zzc = zzc/float(ngrid)
!
!     PRINCIPAL LOOP OVER ELEMENT OF THE GIVEN TYPE
!
            DO iel = 1 , nels
               spag_nextblock_2 = 1
               SPAG_DispatchLoop_2: DO
                  SELECT CASE (spag_nextblock_2)
                  CASE (1)
                     IF ( .NOT.(onlyc) ) THEN
!
!     RESET XM FOR WEDGES. 1ST 12 CONFIGURATIONS ARE MULTIPLIED BY 2.
!     ALL 18 ARE DIVIDED BY 6.(SINCE XM IS A DIVISOR, USE RECIPROCALS)
!
                        IF ( Eltype==40 .AND. iel<=6 ) xm = 6./2.
                        IF ( Eltype==40 .AND. iel>6 ) xm = 6.
                        isub = (irow+iel-1)*4
                        DO i = 1 , 4
                           f(i) = 0.
                           ip(i) = i
                           IF ( Eltype>=40 ) ip(i) = tmap(isub+i)
                        ENDDO
!
!     NEED DET TO COMPUTE VOL
!
                        term1 = r(3,i4)*((r(1,i2)-r(1,i1))*r(2,i3)+(r(1,i1)-r(1,i3))*r(2,i2)+(r(1,i3)-r(1,i2))*r(2,i1))
                        term2 = r(3,i3)*((r(1,i1)-r(1,i2))*r(2,i4)+(r(1,i4)-r(1,i1))*r(2,i2)+(r(1,i2)-r(1,i4))*r(2,i1))
                        term3 = r(3,i2)*((r(1,i3)-r(1,i1))*r(2,i4)+(r(1,i1)-r(1,i4))*r(2,i3)+(r(1,i4)-r(1,i3))*r(2,i1))
                        term4 = r(3,i1)*((r(1,i2)-r(1,i3))*r(2,i4)+(r(1,i4)-r(1,i2))*r(2,i3)+(r(1,i3)-r(1,i4))*r(2,i2))
                        det = term1 + term2 + term3 + term4
                        vol = abs(det)/6.
!
!     GRADIENTS OF SHAPE FUNCTIONS
!
                        dr(1) = r(3,i3)*r(2,i4) - r(3,i4)*r(2,i3) + r(2,i2)*(r(3,i4)-r(3,i3)) - r(3,i2)*(r(2,i4)-r(2,i3))
                        dr(2) = r(1,i3)*r(3,i4) - r(1,i4)*r(3,i3) - r(1,i2)*(r(3,i4)-r(3,i3)) + r(3,i2)*(r(1,i4)-r(1,i3))
                        dr(3) = r(2,i3)*r(1,i4) - r(1,i3)*r(2,i4) + r(1,i2)*(r(2,i4)-r(2,i3)) - r(2,i2)*(r(1,i4)-r(1,i3))
                        dr(4) = r(2,i3)*r(3,i4) - r(2,i4)*r(3,i3) - r(2,i1)*(r(3,i4)-r(3,i3)) + r(3,i1)*(r(2,i4)-r(2,i3))
                        dr(5) = r(1,i4)*r(3,i3) - r(1,i3)*r(3,i4) + r(1,i1)*(r(3,i4)-r(3,i3)) - r(3,i1)*(r(1,i4)-r(1,i3))
                        dr(6) = r(1,i3)*r(2,i4) - r(2,i3)*r(1,i4) - r(1,i1)*(r(2,i4)-r(2,i3)) + r(2,i1)*(r(1,i4)-r(1,i3))
                        dr(7) = r(3,i2)*r(2,i4) - r(2,i2)*r(3,i4) + r(2,i1)*(r(3,i4)-r(3,i2)) - r(3,i1)*(r(2,i4)-r(2,i2))
                        dr(8) = r(1,i2)*r(3,i4) - r(1,i4)*r(3,i2) - r(1,i1)*(r(3,i4)-r(3,i2)) + r(3,i1)*(r(1,i4)-r(1,i2))
                        dr(9) = r(2,i2)*r(1,i4) - r(1,i2)*r(2,i4) + r(1,i1)*(r(2,i4)-r(2,i2)) - r(2,i1)*(r(1,i4)-r(1,i2))
                        dr(10) = r(2,i2)*r(3,i3) - r(3,i2)*r(2,i3) - r(2,i1)*(r(3,i3)-r(3,i2)) + r(3,i1)*(r(2,i3)-r(2,i2))
                        dr(11) = r(3,i2)*r(1,i3) - r(1,i2)*r(3,i3) + r(1,i1)*(r(3,i3)-r(3,i2)) - r(3,i1)*(r(1,i3)-r(1,i2))
                        dr(12) = r(1,i2)*r(2,i3) - r(2,i2)*r(1,i3) - r(1,i1)*(r(2,i3)-r(2,i2)) + r(2,i1)*(r(1,i3)-r(1,i2))
!
                        DO k = 1 , 12
                           dr(k) = dr(k)/det
                        ENDDO
!
!     MULTIPLY SHAPE FUNCTION  BY G
!
                        IF ( Itype/=24 ) CALL gmmats(dr(1),4,3,0,g,3,3,0,dr(13))
!
!     COMPUTE HC
!
                        IF ( Itype==24 ) THEN
!
!     REMFLUX
!
                           nsubx = Istart + 3*Ncount - 3
                           hc(1) = z(nsubx)
                           hc(2) = z(nsubx+1)
                           hc(3) = z(nsubx+2)
                           spag_nextblock_2 = 2
                           CYCLE SPAG_DispatchLoop_2
                        ENDIF
                     ENDIF
!
!     INTEGRATE TO GET HC
!
                     ktype = Itype - 19
                     xlacc(1) = 0.
                     xlacc(2) = 0.
                     xlacc(3) = 0.
!
!     START INTEGRATION PROCEDURE-NEED 5 POINTS FOR CUBIC + CENTROID
!
                     DO npts = 1 , nopts
                        spag_nextblock_3 = 1
                        SPAG_DispatchLoop_3: DO
                           SELECT CASE (spag_nextblock_3)
                           CASE (1)
!
!     DO CENTROID FOR ONLY 1ST TETRA
!
                              IF ( npts==nopts .AND. iel>1 ) CYCLE
!
!     COMPUTE BASIC COORDS OF INTEGRATION POINT
!
                              IF ( npts/=nopts ) THEN
                                 xx = ll(1,npts)*r(1,i1) + ll(2,npts)*r(1,i2) + ll(3,npts)*r(1,i3) + ll(4,npts)*r(1,i4)
                                 yy = ll(1,npts)*r(2,i1) + ll(2,npts)*r(2,i2) + ll(3,npts)*r(2,i3) + ll(4,npts)*r(2,i4)
                                 zz = ll(1,npts)*r(3,i1) + ll(2,npts)*r(3,i2) + ll(3,npts)*r(3,i3) + ll(4,npts)*r(3,i4)
                              ELSE
!
!     CENTROID
!
                                 xx = xxc
                                 yy = yyc
                                 zz = zzc
                                 IF ( Itype==20 ) THEN
!
!     AVERAGE SPCFLD
!
                                    hc(1) = ahcx
                                    hc(2) = ahcy
                                    hc(3) = ahcz
                                    spag_nextblock_3 = 2
                                    CYCLE SPAG_DispatchLoop_3
                                 ENDIF
                              ENDIF
                              hc(1) = 0.
                              hc(2) = 0.
                              hc(3) = 0.
!
!     COMPUTE HC AT THIS PPOINT FOR ALL LOADS OF THIS TYPE IN THIS
!     SUBCASE
!
                              DO ijk = 1 , Ido
                                 spag_nextblock_4 = 1
                                 SPAG_DispatchLoop_4: DO
                                    SELECT CASE (spag_nextblock_4)
                                    CASE (1)
                                       IF ( Itype/=20 ) THEN
                                         isub = Istart + (ijk-1)*Iwords - 1
                                         DO i = 1 , Iwords
                                         buf(i) = z(isub+i)
                                         ENDDO
!
                                         IF ( ktype==2 ) THEN
!
!     CEMLOOP,GEMLOOP,MDIPOLE
!
                                         CALL axloop(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                                         ELSEIF ( ktype==3 ) THEN
                                         CALL geloop(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                                         ELSEIF ( ktype==4 ) THEN
                                         CALL dipole(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                                         ELSE
                                         spag_nextblock_4 = 2
                                         CYCLE SPAG_DispatchLoop_4
                                         ENDIF
                                         spag_nextblock_4 = 3
                                         CYCLE SPAG_DispatchLoop_4
                                       ENDIF
                                       spag_nextblock_4 = 2
                                    CASE (2)
!
!     SPCFLD
!
                                       DO i = 1 , 4
                                         isil = frstgd - 1 + ip(i)
                                         ist = Istart + 3*necpt(isil) - 3
                                         hcx(i) = z(ist)
                                         hcy(i) = z(ist+1)
                                         hcz(i) = z(ist+2)
                                       ENDDO
                                       hc1 = ll(1,npts)*hcx(1) + ll(2,npts)*hcx(2) + ll(3,npts)*hcx(3) + ll(4,npts)*hcx(4)
                                       hc2 = ll(1,npts)*hcy(1) + ll(2,npts)*hcy(2) + ll(3,npts)*hcy(3) + ll(4,npts)*hcy(4)
                                       hc3 = ll(1,npts)*hcz(1) + ll(2,npts)*hcz(2) + ll(3,npts)*hcz(3) + ll(4,npts)*hcz(4)
                                       spag_nextblock_4 = 3
                                    CASE (3)
                                       hc(1) = hc(1) + hc1
                                       hc(2) = hc(2) + hc2
                                       hc(3) = hc(3) + hc3
                                       EXIT SPAG_DispatchLoop_4
                                    END SELECT
                                 ENDDO SPAG_DispatchLoop_4
                              ENDDO
                              spag_nextblock_3 = 2
                           CASE (2)
                              IF ( npts/=nopts ) THEN
!
!     WE HAVE HC AT THIS POINT. MULT. BY  WEIGHT AND ACCUMULATE
!
                                 DO i = 1 , 3
                                    xlacc(i) = xlacc(i) + hc(i)*w(npts)
                                 ENDDO
                              ELSE
                                 sc(3) = hc(1)
                                 sc(4) = hc(2)
                                 sc(5) = hc(3)
                                 CALL write(scr6,sc,5,0)
                              ENDIF
                              EXIT SPAG_DispatchLoop_3
                           END SELECT
                        ENDDO SPAG_DispatchLoop_3
!
!     GET ANOTHER INTEGRATTION POINT
!
                     ENDDO
!
                     IF ( onlyc ) RETURN
                     DO i = 1 , 3
                        hc(i) = xlacc(i)
                     ENDDO
                     spag_nextblock_2 = 2
                  CASE (2)
!
!     MULTIPLY HC BY GRADIENTS AND MATERIALS
!
                     isubx = 13
                     IF ( Itype==24 ) isubx = 1
                     CALL gmmats(dr(isubx),4,3,0,hc,3,1,0,f(1))
!
                     DO k = 1 , 4
                        kk = ip(k)
                        xload(kk) = xload(kk) + f(k)*vol/xm
                     ENDDO
                     EXIT SPAG_DispatchLoop_2
                  END SELECT
               ENDDO SPAG_DispatchLoop_2
!
!     XLOAD   IS SUM OF ALL LOADS FOR ALL THE ELEMENTS
!     F COMPUTED FOR A GIVEN TETRA OF THE TOTAL SHAPE
!     SO MULTIPLY BY VOL
!
            ENDDO
!
            DO i = 1 , ngrid
               spag_nextblock_5 = 1
               SPAG_DispatchLoop_5: DO
                  SELECT CASE (spag_nextblock_5)
                  CASE (1)
                     is = frstgd - 1 + i
                     isil = necpt(is)
!
!     IF PERMBDY EXISTS AND IF GRID IS NOT ON IT, IGNORE ITS LOAD
!
                     IF ( Nbdys/=0 ) THEN
                        SPAG_Loop_4_1: DO j = 1 , Nbdys
                           IF ( isil==iz(Istart-Nbdys-Nelout+j-1) ) THEN
                              spag_nextblock_5 = 2
                              EXIT SPAG_Loop_4_1
                           ENDIF
                        ENDDO SPAG_Loop_4_1
                        CYCLE
                     ENDIF
                     spag_nextblock_5 = 2
                  CASE (2)
                     z(isil) = z(isil) - xload(i)
                     EXIT SPAG_DispatchLoop_5
                  END SELECT
               ENDDO SPAG_DispatchLoop_5
            ENDDO
            RETURN
         ENDIF
         spag_nextblock_1 = 8
      CASE (8)
         ktype = jtype - 20
         IF ( .NOT.(onlyc) ) THEN
!
!     START INTEGRATION
!
            DO i = 1 , inip
               DO j = 1 , inip
                  DO k = 1 , inip
!
!     FETCH SHAPE FUNCTIONS FOR THIS INTEGRATION POINT
!
                     CALL ihexss(Itype,shp,dshp,xjacob,detj,elid,s(i),s(j),s(k),bxyz)
!
!     COMPUTE NI W.R.T. X,Y,Z(REVERVSE CALLING SEQUENCE,SINCE COL STOR)
!
                     CALL gmmats(dshp,np,3,0,xjacob,3,3,0,dshpb)
!
!     COMPUTE TEMPERATURES AND HC  AT THIS INTEGRSTION POINT
!
                     eltemp = 0
                     DO l = 1 , np
                        eltemp = eltemp + shp(l)*gpt(l)
                     ENDDO
                     IF ( jtype/=24 ) THEN
                        hcxyz(1) = 0.
                        hcxyz(2) = 0.
                        hcxyz(3) = 0.
                        IF ( jtype==20 ) THEN
!
!     SPCFLD
!
                           DO l = 1 , np
                              hcxyz(1) = hcxyz(1) + shp(l)*hc(3*l-2)
                              hcxyz(2) = hcxyz(2) + shp(l)*hc(3*l-1)
                              hcxyz(3) = hcxyz(3) + shp(l)*hc(3*l)
                           ENDDO
!
                           CALL hmat(elid)
                        ELSE
!
!     FOR LOOPS AND DIPOLES, COMPUTE BASIC COORDS FOR THIS INTEGRATION
!     POINT
!
                           xx = 0.
                           yy = 0.
                           zz = 0.
                           DO l = 1 , np
                              xx = xx + shp(l)*bxyz(1,l)
                              yy = yy + shp(l)*bxyz(2,l)
                              zz = zz + shp(l)*bxyz(3,l)
                           ENDDO
                           DO ijk = 1 , Ido
                              isub = Istart + (ijk-1)*Iwords - 1
                              DO l = 1 , Iwords
                                 buf(l) = z(isub+l)
                              ENDDO
!
!     COMPUTE HC AT THIS POINT DUE TO ALL LOADS OF PRESENT TYPE
!
                              IF ( ktype==2 ) THEN
                                 CALL geloop(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                              ELSEIF ( ktype==3 ) THEN
                                 CALL dipole(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                              ELSE
                                 CALL axloop(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                              ENDIF
                              hcxyz(1) = hcxyz(1) + hc1
                              hcxyz(2) = hcxyz(2) + hc2
                              hcxyz(3) = hcxyz(3) + hc3
                           ENDDO
                        ENDIF
!
                        g(1) = xmat(1)
                        g(2) = xmat(2)
                        g(3) = xmat(3)
                        g(4) = xmat(2)
                        g(5) = xmat(4)
                        g(6) = xmat(5)
                        g(7) = xmat(3)
                        g(8) = xmat(5)
                        g(9) = xmat(6)
!
                        CALL gmmats(g,3,3,0,hcxyz,3,1,0,gh)
                     ENDIF
!
                     sfact = h(i)*h(j)*h(k)*detj
                     DO l = 1 , np
                        f(l) = f(l) + (dshpb(1,l)*gh(1)+dshpb(2,l)*gh(2)+dshpb(3,l)*gh(3))*sfact
                     ENDDO
!
!     GET ANOTHER INTEGRATIONPOINT
!
                  ENDDO
               ENDDO
            ENDDO
!
!     ADD LOADS INTO LOAD ARRAY
!
            DO l = 1 , np
               spag_nextblock_6 = 1
               SPAG_DispatchLoop_6: DO
                  SELECT CASE (spag_nextblock_6)
                  CASE (1)
                     isil = necpt(frstgd+l-1)
!
!     IF PERMBDY EXISTS AND IF GRID IS NOT ON IT, IGNORE ITS LOAD
!
                     IF ( Nbdys/=0 ) THEN
                        SPAG_Loop_4_2: DO i = 1 , Nbdys
                           IF ( isil==iz(Istart-Nbdys-Nelout+i-1) ) THEN
                              spag_nextblock_6 = 2
                              EXIT SPAG_Loop_4_2
                           ENDIF
                        ENDDO SPAG_Loop_4_2
                        CYCLE
                     ENDIF
                     spag_nextblock_6 = 2
                  CASE (2)
                     z(isil) = z(isil) - f(l)
                     EXIT SPAG_DispatchLoop_6
                  END SELECT
               ENDDO SPAG_DispatchLoop_6
            ENDDO
         ENDIF
         Itype = jtype
!
!     BEFORE LEAVING, WE MUST COMPUTE HC VALUES AT GRIDS OF ISOPARA-
!     METRICS AND WRITE TO SCR6
!
         IF ( jtype/=24 ) THEN
            CALL write(scr6,isc,2,0)
            IF ( jtype/=20 ) THEN
!
!     CEMLOOP, GEMLOOP, MDIPOLE
!
               nx = np + 1
               IF ( Eltype==67 ) nx = 21
               DO j = 1 , nx
                  IF ( j==nx ) THEN
!
!     CENTROID
!
                     CALL ihexss(Eltype-64,shp,dshp,xjacob,detj,elid,0.,0.,0.,bxyz)
                     xx = 0.
                     yy = 0.
                     zz = 0.
                     DO l = 1 , np
                        xx = xx + shp(l)*bxyz(1,l)
                        yy = yy + shp(l)*bxyz(2,l)
                        zz = zz + shp(l)*bxyz(3,l)
                     ENDDO
!
                  ELSEIF ( Eltype/=67 ) THEN
!
                     xx = bxyz(1,j)
                     yy = bxyz(2,j)
                     zz = bxyz(3,j)
                  ELSE
!
!     IHEX3
!
                     IF ( j==1 ) k1 = -1
                     IF ( j==13 ) k1 = 7
                     IF ( j==1 ) k2 = -1
                     IF ( j==13 ) k2 = 7
                     IF ( j>=9 .AND. j<=12 ) THEN
                        xx = .5*(bxyz(1,j+4)+bxyz(1,j+8))
                        yy = .5*(bxyz(2,j+4)+bxyz(2,j+8))
                        zz = .5*(bxyz(3,j+4)+bxyz(3,j+8))
                     ELSEIF ( (j/2)*2/=j ) THEN
                        k2 = k2 + 1
                        xx = bxyz(1,j+k2)
                        yy = bxyz(2,j+k2)
                        zz = bxyz(3,j+k2)
                     ELSE
                        k1 = k1 + 1
                        xx = .5*(bxyz(1,j+k1)+bxyz(1,j+k1+1))
                        yy = .5*(bxyz(2,j+k1)+bxyz(2,j+k1+1))
                        zz = .5*(bxyz(3,j+k1)+bxyz(3,j+k1+1))
                     ENDIF
                  ENDIF
                  hc(1) = 0.
                  hc(2) = 0.
                  hc(3) = 0.
                  DO ijk = 1 , Ido
                     isub = Istart + (ijk-1)*Iwords - 1
                     DO i = 1 , Iwords
                        buf(i) = z(isub+i)
                     ENDDO
!
!     COMPUTE HC AT THIS POINT
!
                     IF ( ktype==2 ) THEN
                        CALL geloop(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                     ELSEIF ( ktype==3 ) THEN
                        CALL dipole(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                     ELSE
                        CALL axloop(buf,ibuf,xx,yy,zz,hc1,hc2,hc3)
                     ENDIF
                     hc(1) = hc(1) + hc1
                     hc(2) = hc(2) + hc2
                     hc(3) = hc(3) + hc3
                  ENDDO
!
                  CALL write(scr6,hc,3,0)
               ENDDO
            ELSE
!
!     FOR SPCFLD THE VALUES ARE IN CORE(EXCEPT FOR MIFPOINTS OF IHEX3)
!
               IF ( Eltype==67 ) THEN
                  isub1 = 1
                  isub2 = 10
                  j = -5
                  SPAG_Loop_1_3: DO
                     DO i = isub1 , isub2 , 3
                        j = j + 6
                        k = 3*i - 2
                        hcx3(j) = hc(k)
                        hcx3(j+1) = hc(k+1)
                        hcx3(j+2) = hc(k+2)
                        hcx3(j+3) = .5*(hc(k+3)+hc(k+6))
                        hcx3(j+4) = .5*(hc(k+4)+hc(k+7))
                        hcx3(j+5) = .5*(hc(k+5)+hc(k+8))
                     ENDDO
                     IF ( isub1==21 ) THEN
!
!     DONE - WRITE RESULTS
!
                        CALL write(scr6,hcx3,60,0)
                        EXIT SPAG_Loop_1_3
                     ELSE
                        j = 22
                        DO i = 13 , 16
                           j = j + 3
                           k = 3*i - 2
                           hcx3(j) = .5*(hc(k)+hc(k+12))
                           hcx3(j+1) = .5*(hc(k+1)+hc(k+13))
                           hcx3(j+2) = .5*(hc(k+2)+hc(k+14))
                        ENDDO
                        isub1 = 21
                        isub2 = 30
                        j = 31
                     ENDIF
                  ENDDO SPAG_Loop_1_3
               ELSE
                  CALL write(scr6,hc,3*np,0)
               ENDIF
!
!     CENTROID/ XI = ETA = ZETA = 0
!
               CALL ihexss(Eltype-64,shp,dshp,xjacob,detj,elid,0.,0.,0.,bxyz)
               hcx3(1) = 0.
               hcx3(2) = 0.
               hcx3(3) = 0.
               DO l = 1 , np
                  hcx3(1) = hcx3(1) + shp(l)*hc(3*l-2)
                  hcx3(2) = hcx3(2) + shp(l)*hc(3*l-1)
                  hcx3(3) = hcx3(3) + shp(l)*hc(3*l)
               ENDDO
               CALL write(scr6,hcx3,3,0)
            ENDIF
         ENDIF
!
         RETURN
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE em3d
