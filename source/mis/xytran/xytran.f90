!*==xytran.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE xytran
!
   USE c_blank
   USE c_output
   USE c_system
   USE c_xmssg
   USE c_xywork
   USE c_zzzzzz
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: bcd , card , comp , core , flag , i , i1 , i13 , i2 , i23 , icore , icrq , id , idtot , idz , ier , ifcrv , ifle ,    &
            & ij , intrwd , istep , istsv , item , itemp , itry , ival , j , jj , kasknt , ktype , n , nbeg , nslots , nsubs , nuq ,&
            & nwds , place , size , type
   INTEGER , SAVE :: blank , clea , eor , fram , go , i3 , inprwd , namevg , noeor , nwords , outfil , outrwd , pset , rand , rewd ,&
                   & stop , tcur , vdum , vg , xaxi , xy , xycdb , yaxi , ybax , ytax
   INTEGER , DIMENSION(11) , SAVE :: files , majid , namev
   INTEGER , DIMENSION(96) :: headsv
   INTEGER , DIMENSION(5) , SAVE :: indb
   INTEGER , DIMENSION(2) :: name
   LOGICAL :: oomcp , oompp , vgp
   INTEGER , DIMENSION(5) :: openf
   REAL , DIMENSION(100) :: rbuf
   INTEGER , DIMENSION(2) , SAVE :: routin
   REAL , DIMENSION(1) :: rz
   INTEGER , DIMENSION(200) :: subcas
   REAL :: temp , temp1
   REAL , DIMENSION(60) :: value
   INTEGER , DIMENSION(58) , SAVE :: word
   INTEGER , DIMENSION(20) :: xycard
   EXTERNAL bckrec , close , fname , fwdrec , ifp1xy , korsz , mesage , open , page2 , read , rewind , sort , write , wrttrl ,      &
          & xread , xydump , xyfind , xyprpl
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
   !>>>>EQUIVALENCE (Z(1),Rz(1)) , (Buf(1),Rbuf(1)) , (Ivalue(1),Value(1))
!
   DATA stop/4HSTOP/ , go/4HGO  / , vdum/4HVDUM/ , xy/4HXY  / , fram/4HFRAM/ , clea/4HCLEA/ , tcur/4HTCUR/ , xaxi/4HXTIT/ ,         &
       &yaxi/4HYTIT/ , ytax/4HYTTI/ , ybax/4HYBTI/ , blank/4H    / , pset/4HPSET/
!
   DATA eor/1/ , noeor/0/ , outrwd/1/ , inprwd/0/ , rewd/1/
   DATA xycdb/101/ , outfil/201/ , indb/102 , 103 , 104 , 105 , 106/
   DATA nwords/58/ , routin/4HXYTR , 4HAN  / , rand/4HRAND/
   DATA vg/4HVG  / , i3/3/
!
   DATA word/4HXMIN , 4HXMAX , 4HYMIN , 4HYMAX , 4HYTMI , 4HYTMA , 4HYBMI , 4HYBMA , 4HXINT , 4HYINT , 4HYTIN , 4HYBIN , 4HXAXI ,   &
       &4HYAXI , 4HXTAX , 4HXBAX , 4HXDIV , 4HYDIV , 4HYTDI , 4HYBDI , 4HXVAL , 4HYVAL , 4HYTVA , 4HYBVA , 4HUPPE , 4HLOWE ,        &
      & 4HLEFT , 4HRIGH , 4HTLEF , 4HTRIG , 4HBLEF , 4HBRIG , 4HALLE , 4HTALL , 4HBALL , 4HXLOG , 4HYLOG , 4HYTLO , 4HYBLO ,        &
      & 4HCURV , 4HDENS , 4H.... , 4H.... , 4H.... , 4HSKIP , 4HCAME , 4HPLOT , 4HXPAP , 4HYPAP , 4HPENS , 4HXGRI , 4HYGRI ,        &
      & 4HXTGR , 4HYTGR , 4HXBGR , 4HYBGR , 4HCSCA , 4HCOLO/
!
!     DATA FOR THE 11 VECTOR TYPES POSSIBLE
!
!                                                         BASIC
!              VECTOR-NAME         RESIDENT-FILE       MAJOR - ID
!          ******************     ***************   ****************
   DATA namev(1)/4HDISP/ , files(1)/3/ , majid(1)/1/
   DATA namev(2)/4HVELO/ , files(2)/3/ , majid(2)/10/
   DATA namev(3)/4HACCE/ , files(3)/3/ , majid(3)/11/
   DATA namev(4)/4HSPCF/ , files(4)/2/ , majid(4)/3/
   DATA namev(5)/4HLOAD/ , files(5)/1/ , majid(5)/2/
   DATA namev(6)/4HSTRE/ , files(6)/4/ , majid(6)/5/
   DATA namev(7)/4HFORC/ , files(7)/5/ , majid(7)/4/
   DATA namev(8)/4HSDIS/ , files(8)/1/ , majid(8)/15/
   DATA namev(9)/4HSVEL/ , files(9)/1/ , majid(9)/16/
   DATA namev(10)/4HSACC/ , files(10)/1/ , majid(10)/17/
   DATA namev(11)/4HNONL/ , files(11)/2/ , majid(11)/12/
   DATA namevg/4H VG /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     - IDOUT DATA RECORD DISCRIPTION -
!
!     WORD    TYPE   DISCRIPTION
!     ==================================================================
!       1     I/R    SUBCASE ID OR IF RANDOM THE MEAN RESPONSE
!       2      I     FRAME NUMBER
!       3      I     CURVE NUMBER
!       4      I     POINT-ID OR ELEMENT-ID
!       5      I     COMPONENT NUMBER
!       6      I     VECTOR NUMBER  1 THRU 11
!
!       7      I     1 -- CURVE USES TOP HALF OF FRAME
!                    0 -- CURVE USES FULL FRAME
!                   -1 -- CURVE USES LOWER HALF OF FRAME
!
!       8      I     0 -- AXIS,TICS,LABELS,VALUES, ETC. HAVE BEEN DRAWN
!                         AND THIS CURVE IS TO BE SCALED AND PLOTTED
!                         IDENTICALLY AS LAST EXCEPT FOR CURVE SYMBOLS.
!                    1 -- AXIS, TICS, LABELS, SCALEING, ETC. ARE TO BE
!                         PERFORMED OR COMPUTED AND IF IDOUT(7)=0 OR 1
!                         A SKIP TO NEW FRAME IS TO BE MADE.
!
!       9      I     NUMBER OF BLANK FRAMES BETWEEN FRAMES (FRAME-SKIP)
!      10      R     MINIMUM X-INCREMENT
!      11      R     XMIN  *
!      12      R     XMAX   *   DEFINES ACTUAL LIMITS OF DATA OF THIS
!      13      R     YMIN   *   UPPER, LOWER, OR FULL FRAME CURVE.
!      14      R     YMAX  *
!      15      R     ACTUAL VALUE OF FIRST TIC                 *
!      16      R     ACTUAL INCREMENT TO SUCCESSIVE TICS        *
!      17      I     ACTUAL MAXIMUM VALUE OF FRAME               *  X-
!      18      I     MAXIMUM NUMBER OF DIGITS IN ANY PRINT-VALUE  * DIRE
!      19      I     + OR - POWER FOR PRINT VALUES                * TICS
!      20      I     TOTAL NUMBER OF TICS TO PRINT THIS EDGE     *
!      21      I     VALUE PRINT SKIP  0,1,2,3---               *
!      22      I     SPARE                                     *
!      23      R     *
!      24      R      *
!      25      I       *
!      26      I        *  SAME AS  15 THRU 22
!      27      I        *  BUT FOR  Y-DIRECTION TICS
!      28      I       *
!      29      I      *
!      30      I     *
!      31      I     TOP EDGE TICS   **   EACH OF 31 THRU 34 MAY BE
!      32      I     BOTTOM EDGE TICS **  LESS THAN 0 -- TICS W/O VALUES
!      33      I     LEFT EDGE TICS   **  EQUAL TO  0 -- NO TICS HERE
!      34      I     RIGHT EDGE TICS **   GREATER   0 -- TICS W VALUES
!
!      35      I     0 -- X-DIRECTION IS LINEAR
!                    GREATER THAN 0 - NUMBR OF CYCLES AND X-DIREC IS LOG
!      36      I     0 -- Y-DIRECTION IS LINEAR
!                    GREATER THAN 0 - NUMBR OF CYCLES AND Y-DIREC IS LOG
!      37      I     0 -- NO X-AXIS
!                    1 -- DRAW X-AXIS
!
!      38      R     X-AXIS  Y-INTERCEPT
!
!      39      I     0 -- NO Y-AXIS
!                    1 -- DRAW Y-AXIS
!
!      40      R     Y-AXIS  X-INTERCEPT
!
!      41      I     LESS THAN 0 ----- PLOT SYMBOL FOR EACH CURVE POINT.
!                                      SELECT SYMBOL CORRESPONDING TO
!                                      CURVE NUMBER IN IDOUT(3)
!                    EQUAL TO  0 ----- CONNECT POINTS BY LINES WHERE
!                                      POINTS ARE CONTINUOUS I.E.(NO
!                                      INTEGER 1 PAIRS)
!                    GREATER THAN 0 -- DO BOTH OF ABOVE
!
!      42
!       .
!       .
!      50
!      51     BCD    TITLE(32)
!       .     BCD    SUBTITLE(32)
!       .     BCD    LABEL(32)
!       .     BCD    CURVE TITLE(32)
!       .     BCD    X-AXIS TITLE(32)
!     242     BCD    Y-AXIS TITLE(32)
!     243      I     XGRID LINES   0=NO   1=YES
!     244      I     YGRID LINES   0=NO   1=YES
!     245      I     TYPE OF PLOT  1=RESPONSE, 2=PSDF, 3=AUTO
!     246      I     STEPS
!       .
!       .
!     281      I     PAPLOT FRAME NUMBER
!     282      R     CSCALE (REAL NUMBER)
!     283      I     PENSIZE OR DENSITY
!     284      I     PLOTTER (LSHIFT 16) AND MODEL NUMBER.
!     285      R     INCHES PAPER X-DIRECTION
!     286      R     INCHES PAPER Y-DIRECTION
!     287      I     CAMERA FOR SC4020 LESS THAN 0=35MM, 0=F80,
!                                        GREATER 0=BOTH
!     288      I     PRINT FLAG  **
!     289      I     PLOT  FLAG  ** 0=NO, +=YES (PLOT- 2=BOTH, -1=PAPLT)
!     290      I     PUNCH FLAG  **
!     291      R     X-MIN OF ALL DATA
!     292      R     X-MAX OF ALL DATA
!     293      R     Y-MIN WITHIN X-LIMITS OF FRAME
!     294      R     X-VALUE AT THIS Y-MIN
!     295      R     Y-MAX WITHIN X-LIMITS OF FRAME
!     296      R     X-VALUE AT THIS Y-MAX
!     297      R     Y-MIN FOR ALL DATA
!     298      R     X-VALUE AT THIS Y-MIN
!     299      R     Y-MAX FOR ALL DATA
!     300      R     X-VALUE AT THIS Y-MAX
!     ==================================================================
!
!     SAVE OUTPUT HEADING
!
         DO i = 1 , 96
            headsv(i) = ihead(i)
         ENDDO
!
!     ALLOCATE CORE AND OPEN DATA BLOCKS
!
         oompp = .FALSE.
         vgp = .FALSE.
         oomcp = .FALSE.
         random = .FALSE.
         ifle = xycdb
         core = korsz(z) - 1
         DO i = 1 , 32
            tcurve(i) = blank
            xaxis(i) = blank
            yaxis(i) = blank
            ytaxis(i) = blank
            ybaxis(i) = blank
         ENDDO
         DO i = 1 , 5
            subc(i) = 1
         ENDDO
         nsubs = 0
         core = core - sysbuf
         IF ( core<0 ) THEN
!
!     INSUFFICIENT CORE
!
            CALL mesage(8,-core,routin)
!
!     CALL THE PRINTER-PLOTTER IF ANY REQUESTS FOR PRINTER-PLOTTER
!
            IF ( oompp ) CALL xyprpl
            GOTO 240
         ELSE
            intrwd = inprwd
            IF ( intr>0 ) THEN
               intrwd = outrwd
               xycdb = 301
            ENDIF
            CALL open(*240,xycdb,z(core+1),intrwd)
            IF ( intr<=0 ) THEN
               spag_nextblock_1 = 4
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            card = 1
            WRITE (l,99001)
!
99001       FORMAT ('  ENTER XYPLOT DEFINITION OR GO TO PLOT OR STOP TO EXIT')
         ENDIF
         spag_nextblock_1 = 2
      CASE (2)
         DO ij = 1 , 20
            xycard(ij) = blank
         ENDDO
         CALL xread(*20,xycard)
         IF ( xycard(1)==stop ) THEN
!
!     INTERACTIVE STOP INITIATED HERE.
!
            nogo = 1
            RETURN
         ELSE
            IF ( xycard(1)==go ) card = -1
            CALL ifp1xy(card,xycard)
            IF ( xycard(1)==go ) THEN
               CALL close(xycdb,rewd)
               IF ( intr>10 ) l = 1
               CALL open(*240,xycdb,z(core+1),inprwd)
               spag_nextblock_1 = 4
               CYCLE SPAG_DispatchLoop_1
            ELSE
               card = 0
               IF ( nogo==0 ) THEN
                  spag_nextblock_1 = 3
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               nogo = 0
            ENDIF
         ENDIF
 20      WRITE (l,99002)
99002    FORMAT ('  BAD CARD TRY AGAIN')
         spag_nextblock_1 = 3
      CASE (3)
         WRITE (l,99003) xycard
99003    FORMAT (20A4)
         spag_nextblock_1 = 2
      CASE (4)
         IF ( intr<=0 ) CALL fwdrec(*60,xycdb)
         outopn = .FALSE.
         IF ( blkcom==rand ) random = .TRUE.
         IF ( blkcom==vg ) vgp = .TRUE.
         IF ( blkcom==vg ) namev(5) = namevg
!
         core = core - sysbuf
         DO i = 1 , 5
            openf(i) = -1
            IF ( core<0 ) THEN
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ENDIF
!
            CALL open(*40,indb(i),z(core),inprwd)
            openf(i) = 0
            vecid(i) = 0
            core = core - sysbuf
 40      ENDDO
!
         core = core + sysbuf - 1
!
!     NOTE - OUTPUT DATA BLOCKS WILL BE OPENED WHEN AND IF REQUIRED
!
!
!
!     READ FIRST BCD WORD FROM -XYCDB- THEN GO INITIALIZE DATA
!
         bcd = clea
         spag_nextblock_1 = 16
         CYCLE SPAG_DispatchLoop_1
 60      ier = 2
         spag_nextblock_1 = 6
         CYCLE SPAG_DispatchLoop_1
 80      ier = 3
         spag_nextblock_1 = 6
      CASE (5)
         ier = 8
         ifle = -core
         spag_nextblock_1 = 6
      CASE (6)
         CALL mesage(ier,ifle,routin)
!
!     CLOSE ANY OPEN FILES AND RETURN
!
 100     CALL close(xycdb,rewd)
         DO i = 1 , 5
            CALL close(indb(i),rewd)
         ENDDO
         IF ( .NOT.outopn ) RETURN
!
!     NO CAMERA PLOTS SO DONT WRITE TRAILER
!
         IF ( oomcp ) THEN
            buf(1) = outfil
            buf(2) = 9999999
            CALL wrttrl(buf(1))
         ENDIF
         CALL close(outfil,rewd)
         IF ( oompp ) CALL xyprpl
         GOTO 240
!
!     ERROR,  PLOTS REQUESTED AND OUTFIL PURGED.  DO ALL ELSE.
!
 120     CALL page2(2)
         WRITE (l,99004) uwm , outfil
99004    FORMAT (A25,' 976, OUTPUT DATA BLOCK',I4,' IS PURGED.','  XYTRAN WILL PROCESS ALL REQUESTS OTHER THAN PLOT')
         plot = .FALSE.
         spag_nextblock_1 = 7
      CASE (7)
!
         IF ( buf(3)/=0 ) punch = .TRUE.
         type = buf(4)
         vector = buf(5)
         nsubs = buf(7)
         knt = 0
         IF ( nsubs>0 ) CALL read(*60,*80,xycdb,subcas(1),nsubs,noeor,flag)
         IF ( nsubs>0 ) CALL sort(0,0,1,1,subcas(1),nsubs)
         IF ( random .AND. type/=2 .AND. type/=3 ) THEN
            spag_nextblock_1 = 10
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( (.NOT.random) .AND. (type==2 .OR. type==3) ) THEN
            spag_nextblock_1 = 10
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( (.NOT.random) .AND. ipset==pset .AND. vector>7 ) THEN
            spag_nextblock_1 = 10
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( (.NOT.random) .AND. ipset/=pset .AND. vector<=7 ) THEN
            spag_nextblock_1 = 10
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     INITIALIZE DATA BLOCK POINTERS FOR THIS VECTOR
!
         file = files(vector)
!
!     CHECK FOR RANDOM
!
         IF ( random .AND. type==3 ) file = 2
         IF ( random .AND. type==2 ) file = 1
         ifile = indb(file)
         IF ( openf(file)<0 ) THEN
            spag_nextblock_1 = 9
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     CHECK TO SEE IF THIS FILES SUBCASE IS TO BE OUTPUT
!
         IF ( openf(file)<0 ) THEN
            spag_nextblock_1 = 9
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( openf(file)/=0 ) THEN
            spag_nextblock_1 = 11
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         CALL fwdrec(*160,ifile)
         CALL read(*160,*140,ifile,idin(1),20,eor,flag)
         CALL read(*160,*180,ifile,idin(1),-core,eor,flag)
         spag_nextblock_1 = 5
         CYCLE SPAG_DispatchLoop_1
!
!     EOR HIT ON IFILE.  SHOULD NOT HAVE HAPPENED
!
 140     ier = 3
         spag_nextblock_1 = 8
         CYCLE SPAG_DispatchLoop_1
!
!     EOF HIT ON IFILE.  SHOULD NOT HAVE HAPPENED
!
 160     ier = 2
         spag_nextblock_1 = 8
      CASE (8)
         CALL mesage(ier,ifile,routin)
         openf(file) = -1
         spag_nextblock_1 = 9
      CASE (9)
!
!     FILE IFILE IS NOT SATISFACTORY
!
         CALL fname(ifile,buf(1))
         CALL page2(3)
         WRITE (l,99005) uwm , buf(1) , buf(2) , namev(vector)
99005    FORMAT (A25,' 978',/5X,'XYTRAN MODULE FINDS DATA-BLOCK(',2A4,') PURGED, NULL, OR INADEQUATE, AND IS IGNORING XY-OUTPUT',   &
                &' REQUEST FOR -',A4,'- CURVES')
         spag_nextblock_1 = 10
      CASE (10)
         DO
!
!     SKIP OVER ANY AND ALL FRAME DATA FOR THIS CARD.
!
            CALL read(*60,*100,xycdb,bcd,1,noeor,flag)
            IF ( bcd/=fram ) THEN
               spag_nextblock_1 = 16
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            SPAG_Loop_2_1: DO
               CALL read(*60,*80,xycdb,buf(1),3,noeor,flag)
               IF ( buf(1)==-1 ) EXIT SPAG_Loop_2_1
            ENDDO SPAG_Loop_2_1
         ENDDO
 180     CALL bckrec(ifile)
         CALL bckrec(ifile)
         size = flag/idin(10)
         ktype = (idin(2)/1000)*1000
         openf(file) = 1
         spag_nextblock_1 = 11
      CASE (11)
         kasknt = kasknt + 1
         IF ( nsubs==0 ) THEN
            subc(file) = 0
         ELSE
            subc(file) = subcas(kasknt)
         ENDIF
         spag_nextblock_1 = 12
      CASE (12)
!
!     NOW READY TO PROCEED WITH DATA SELECTION
!
         CALL read(*60,*100,xycdb,bcd,1,noeor,flag)
         IF ( bcd/=fram ) THEN
            spag_nextblock_1 = 16
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     READ IN THE ID-COMP-COMP SETS AND SORT ON ID-S.
!
         knt = 0
         itry = 0
         iat = 0
         SPAG_Loop_1_2: DO
            CALL read(*60,*80,xycdb,z(iat+1),3,noeor,flag)
            IF ( z(iat+1)==-1 ) THEN
!
!     SORT ON ID-S
!
               CALL sort(0,0,3,1,z(1),iat)
               EXIT SPAG_Loop_1_2
            ELSE
               iat = iat + 3
            ENDIF
         ENDDO SPAG_Loop_1_2
         spag_nextblock_1 = 13
      CASE (13)
         icore = core - iat
!
!     COMPUTE FINAL REGIONS
!
         nslots = iat/3
         nat = iat
         IF ( z(i3)>0 .AND. .NOT.random ) nslots = nslots + nslots
         SPAG_Loop_1_3: DO
            steps = size
            IF ( vgp ) THEN
               itemp = 0
               nuq = 0
               DO i = 1 , nat , 3
                  IF ( z(i)/=itemp ) THEN
                     nuq = nuq + 1
                     itemp = z(i)
                  ENDIF
               ENDDO
               steps = steps*nuq
!
!     SET CORE TO 1
!
               j = iat + 1
               n = j + min0(icore,(nslots+1)*steps)
               DO i = j , n
                  z(i) = 1
               ENDDO
            ENDIF
            IF ( steps*(nslots+1)<=icore ) THEN
               ntops = nslots/2
               nbots = ntops
               IF ( .NOT.(z(i3)>0 .AND. .NOT.random) ) THEN
                  ntops = nslots
                  nbots = 0
               ENDIF
               center = iat + ntops*steps
!
!     GET CURVE DATA
!
               major = ktype + majid(vector)
               i2 = 0
               ifcrv = -1
               istsv = 0
               idtot = nat/3
               EXIT SPAG_Loop_1_3
            ELSE
               CALL page2(4)
               WRITE (l,99006) uwm , z(iat-2) , z(iat-1) , z(iat)
99006          FORMAT (A25,' 980, INSUFFICIENT CORE TO HANDLE ALL DATA FOR ALL ','CURVES OF THIS FRAME',/5X,' ID =',I10,            &
                      &2(' COMPONENT =',I4,5X),' DELETED FROM OUTPUT')
               icrq = steps*(nslots+1) - icore
               WRITE (l,99007) icrq
99007          FORMAT (5X,'ADDITIONAL CORE NEEDED =',I9,' WORDS.')
               nslots = nslots - 1
               IF ( z(i3)>0 .AND. .NOT.random ) nslots = nslots - 1
               nat = nat - 3
               IF ( nslots<=0 ) THEN
                  spag_nextblock_1 = 12
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDIF
         ENDDO SPAG_Loop_1_3
!
!     I1 = 1-ST ROW OF NEXT ID
!     I2 = LAST ROW OF NEXT ID
!
 200     i1 = i2 + 1
         nbeg = 3*i1 - 3
         IF ( nbeg>=nat ) THEN
!
!     ALL DATA IS NOW IN SLOTS. INTEGER 1-S REMAIN IN VACANT SLOTS.
!
            IF ( nsubs==0 ) subc(file) = idin(4)
            CALL xydump(outfil,type)
            knt = 1
            IF ( nsubs/=0 ) THEN
               spag_nextblock_1 = 15
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            subc(file) = 0
            itry = itry + 1
            spag_nextblock_1 = 13
            CYCLE SPAG_DispatchLoop_1
         ELSE
            idz = nbeg + 1
            id = z(idz)
            i2 = i1
            SPAG_Loop_1_4: DO WHILE ( .NOT.(i2>=idtot .OR. random) )
               IF ( z(3*i2+1)/=id ) EXIT SPAG_Loop_1_4
               i2 = i2 + 1
            ENDDO SPAG_Loop_1_4
!
!     FIND THIS ID ON IFILE
!
            CALL xyfind(*160,*140,*220,majid(1),idz)
            knt = -1
            IF ( itry==0 .AND. subc(file)==-1 ) THEN
!
!     NSUBS = 0 AND POINT NOT FOUND START FRAME OVER
!
               CALL page2(3)
               WRITE (l,99011) uwm , id , namev(vector) , ifile
               CALL rewind(ifile)
               subc(file) = 0
               knt = 0
               IF ( nat/3>i2 ) THEN
                  spag_nextblock_1 = 14
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               IF ( i1/=1 ) THEN
                  spag_nextblock_1 = 14
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               subc(file) = 0
               spag_nextblock_1 = 12
               CYCLE SPAG_DispatchLoop_1
!
!     THIS IS THE WAY OUT FOR ALL SUBCASE REQUEST
!
            ELSEIF ( itry/=0 .AND. subc(file)==-1 ) THEN
               subc(file) = 0
               spag_nextblock_1 = 12
               CYCLE SPAG_DispatchLoop_1
            ELSE
               ktype = (idin(2)/1000)*1000
               IF ( ktype==2000 .OR. ktype==3000 ) THEN
!
!     ID FOUND. READ DATA AND DISTRIBUTE INTO SLOTS.
!
                  nwds = idin(10)
                  istep = 0
                  ifcrv = ifcrv + 1
                  IF ( vgp ) istep = istsv
                  DO
                     CALL read(*160,*200,ifile,buf(1),nwds,noeor,flag)
                     istep = istep + 1
                     IF ( istep<=steps ) THEN
                        itemp = iat + istep
                        istsv = istep
                        IF ( vgp ) THEN
                           IF ( ifcrv/=0 ) THEN
!
!     SORT X AND MOVE Y TO PROPER SLOTS
!
                              IF ( rbuf(1)<rz(itemp-1) ) THEN
                                 n = istep - 1
                                 DO i = 1 , n
                                    IF ( rbuf(1)<rz(iat+i) ) GOTO 202
                                 ENDDO
                              ENDIF
                              GOTO 204
 202                          istep = i
                              j = istep
                              itemp = iat + istep
                              n = nslots + 1
                              jj = istsv - 1
                              DO i = 1 , n
                                 item = iat + (i-1)*steps + j
                                 temp1 = rz(item)
                                 z(item) = 1
                                 DO ij = j , jj
                                    item = iat + (i-1)*steps + ij + 1
                                    temp = rz(item)
                                    rz(item) = temp1
                                    temp1 = temp
                                 ENDDO
                              ENDDO
                           ENDIF
                        ENDIF
 204                    rz(itemp) = rbuf(1)
!
!     DISTRIBUTE DATA
!
                        DO i = i1 , i2
                           place = i*steps + istep
!
!     TOP CURVE
!
                           comp = z(3*i-1)
!
!     SET MEAN RESPONSE IF RANDOM
!
                           IF ( random ) z(3*i) = idin(8)
!
!     SET NUMBER OF ZERO CROSSINGS IF RANDOM
!
                           IF ( random ) buf(i+20) = idin(9)
                           IF ( comp==1000 ) THEN
                              itemp = iat + place
                              z(itemp) = 1
                           ELSE
                              IF ( comp==0 ) CYCLE
                              IF ( random ) comp = 2
                              IF ( comp<=nwds ) THEN
!
                                 itemp = iat + place
                                 z(itemp) = buf(comp)
                              ELSE
                                 z(3*i-1) = 0
                                 CALL page2(2)
                                 WRITE (l,99012) uwm , comp , id
                              ENDIF
                           ENDIF
!
!     BOTTOM CURVE IF DOUBLE FRAME
!
                           IF ( .NOT.(random) ) THEN
                              comp = z(3*i)
                              IF ( comp==1000 ) THEN
                                 itemp = center + place
                                 z(itemp) = 1
                              ELSEIF ( comp/=0 ) THEN
                                 IF ( comp<=nwds ) THEN
!
                                    itemp = center + place
                                    z(itemp) = buf(comp)
                                 ELSE
                                    z(3*i) = 0
                                    CALL page2(2)
                                    WRITE (l,99012) uwm , comp , id
                                 ENDIF
                              ENDIF
                           ENDIF
                        ENDDO
                        istep = istsv
                     ENDIF
                  ENDDO
               ELSE
                  CALL page2(2)
                  WRITE (l,99008) uwm
99008             FORMAT (A25,' 977, FOLLOWING NAMED DATA-BLOCK IS NOT IN SORT-II',' FORMAT')
                  spag_nextblock_1 = 9
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDIF
         ENDIF
!
!     ID NOT FOUND. PRINT MESSAGE AND SHRINK LIST.
!
!
!     SUBCASE REQUEST EITHER SUBCASE NOT FOUND OR POINT NOT FOUND
!
 220     IF ( knt==-1 ) idz = -1
         IF ( idz/=-1 ) THEN
            spag_nextblock_1 = 15
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         CALL page2(3)
         WRITE (l,99011) uwm , id , namev(vector) , ifile
         WRITE (l,99009) subc(file)
99009    FORMAT (5X,'SUBCASE',I10)
         knt = 0
         IF ( nat/3<=i2 .AND. i1==1 ) THEN
            spag_nextblock_1 = 15
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         spag_nextblock_1 = 14
      CASE (14)
         i13 = 3*i1 - 3
         i23 = 3*i2 + 1
         IF ( i23<nat ) THEN
            DO i = i23 , nat
               i13 = i13 + 1
               z(i13) = z(i)
            ENDDO
         ENDIF
         idtot = idtot - (i2-i1) - 1
         i2 = i1 - 1
         nat = i13
         IF ( idz==-1 .AND. i1/=1 .AND. .NOT.vgp ) GOTO 200
         iat = nat
         spag_nextblock_1 = 13
      CASE (15)
         IF ( kasknt<nsubs ) THEN
            kasknt = kasknt + 1
            subc(file) = subcas(kasknt)
            DO i = 1 , 5
               vecid(i) = 0
            ENDDO
            spag_nextblock_1 = 13
         ELSE
            kasknt = 0
            spag_nextblock_1 = 11
         ENDIF
      CASE (16)
!
!     INITIALIZE PARAMETERS
!
         plot = .FALSE.
         punch = .FALSE.
         print = .FALSE.
         paplot = .FALSE.
         DO i = 1 , 5
            vecid(i) = 0
!
!     VALUE DUMP
!
         ENDDO
!
!     BRANCH ON BCD WORD
!
         DO WHILE ( bcd/=xy )
            spag_nextblock_2 = 1
            SPAG_DispatchLoop_2: DO
               SELECT CASE (spag_nextblock_2)
               CASE (1)
                  IF ( bcd==tcur ) THEN
!
!     SET TITLES
!
                     CALL read(*60,*80,xycdb,tcurve(1),32,noeor,flag)
                  ELSEIF ( bcd==xaxi ) THEN
                     CALL read(*60,*80,xycdb,xaxis(1),32,noeor,flag)
                  ELSEIF ( bcd==yaxi ) THEN
                     CALL read(*60,*80,xycdb,yaxis(1),32,noeor,flag)
                  ELSEIF ( bcd==ytax ) THEN
                     CALL read(*60,*80,xycdb,ytaxis(1),32,noeor,flag)
                  ELSEIF ( bcd==ybax ) THEN
                     CALL read(*60,*80,xycdb,ybaxis(1),32,noeor,flag)
!
!     SET SINGLE VALUE FLAGS. READ IN VALUE
!
                  ELSEIF ( bcd==clea ) THEN
!
!     CLEAR ALL VALUES SET AND RESTORE DEFAULTS
!
                     DO i = 1 , 12
                        ivalue(i) = 1
                     ENDDO
                     DO i = 13 , nwords
                        IF ( i/=47 ) ivalue(i) = 0
                     ENDDO
                     DO i = 25 , 32
                        ivalue(i) = 1
                     ENDDO
!
!     DEFAULT CAMERA TO BOTH
!
                     ivalue(46) = 3
                  ELSE
                     IF ( bcd/=vdum ) THEN
                        CALL read(*60,*80,xycdb,ival,1,noeor,flag)
                        DO i = 1 , nwords
                           IF ( bcd==word(i) ) GOTO 222
                        ENDDO
!
!     WORD NOT RECOGNIZED
!
                        CALL page2(2)
                        WRITE (l,99010) uwm , bcd
!
!
99010                   FORMAT (A25,' 975, XYTRAN DOES NOT RECOGNIZE ',A4,' AND IS IGNORING')
                     ENDIF
                     spag_nextblock_2 = 2
                     CYCLE SPAG_DispatchLoop_2
!
!     KEY WORD FOUND
!
 222                 IF ( bcd/=word(58) ) THEN
                        ivalue(i) = ival
                     ELSE
                        ivalue(i) = ival
                        CALL read(*60,*80,xycdb,ival,1,noeor,flag)
                        ivalue(i+1) = ival
                     ENDIF
                  ENDIF
                  spag_nextblock_2 = 2
               CASE (2)
!
!     READ NEXT BCD WORD
!
                  CALL read(*60,*100,xycdb,bcd,1,noeor,flag)
                  EXIT SPAG_DispatchLoop_2
               END SELECT
            ENDDO SPAG_DispatchLoop_2
         ENDDO
!
!     XY-COMMAND OPERATIONS HIT
!
         CALL read(*60,*80,xycdb,buf(1),7,noeor,flag)
         IF ( buf(6)/=0 ) paplot = .TRUE.
         IF ( buf(6)/=0 ) oompp = .TRUE.
         IF ( buf(2)/=0 ) oomcp = .TRUE.
         IF ( buf(1)/=0 ) print = .TRUE.
         IF ( buf(2)/=0 ) plot = .TRUE.
         kasknt = 0
         IF ( outopn ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( .NOT.plot .AND. .NOT.paplot ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     OPEN OUTPUT PLOT DATA BLOCK
!
         core = core - sysbuf
         IF ( core<=0 ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
         CALL open(*120,outfil,z(core+1),outrwd)
         CALL fname(outfil,name(1))
         CALL write(outfil,name(1),2,eor)
         outopn = .TRUE.
         spag_nextblock_1 = 7
         CYCLE SPAG_DispatchLoop_1
!
!     RESTORE OUTPUT HEADING AND RETURN
!
 240     DO i = 1 , 96
            ihead(i) = headsv(i)
         ENDDO
         RETURN
      END SELECT
   ENDDO SPAG_DispatchLoop_1
99011 FORMAT (A25,' 979, AN XY-OUTPUT REQUEST FOR POINT OR ELEMENT ID',I10,/5X,1H-,A4,'- CURVE IS BEING PASSED OVER.  THE ID ',     &
             &'COULD NOT BE FOUND IN DATA BLOCK',I10)
99012 FORMAT (A25,' 981, COMPONENT =',I10,' FOR ID =',I10,' IS TOO LARGE. THIS COMPONENTS CURVE NOT OUTPUT')
END SUBROUTINE xytran