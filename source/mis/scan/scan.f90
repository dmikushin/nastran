!*==scan.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE scan
   USE c_blank
   USE c_gpta1
   USE c_names
   USE c_system
   USE c_xmssg
   USE c_xscanx
   USE c_zzzzzz
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , SAVE :: casecc , eor , iol1 , iol2 , irf , llc , scr1
   INTEGER :: file , i , ib , ibuf1 , ibuf2 , ibuf3 , idupl , ie , ii , imax , imin , inc , ioef , ioes , j , jmp , kk , l , l1 ,   &
            & le , lencc , ll , ll2 , lll1 , ls , lsem , lx , ncase , nn , nscan , nxx , nz , sorf
   INTEGER , DIMENSION(2) :: jelt
   LOGICAL :: kopen , lopen
   INTEGER , DIMENSION(2) , SAVE :: nam , oefi , oesfi , oesi
   INTEGER , DIMENSION(166) :: z
   EXTERNAL bisloc , close , fname , fwdrec , khrfn1 , khrfn2 , khrfn3 , korsz , mesage , onlins , open , rdtrl , read , rewind ,   &
          & sort , strscn , write , wrttrl
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     THIS IS THE MAIN DRIVER FOR THE OUTPUT SCAN MODULE - SCAN
!
!     THIS SCAN MODULE CAN BE CALLED DIRECTLY FROM ALL RIGID FORMATS, OR
!     BY USER DMAP ALTER. THE CALLING INSTRUCTIONS ARE
!
!     (THREE INPUT FILES IF CALLED BY RIGID FORMAT VIA SCAN INPUT CARDS)
!     (1) FORCE AND STRESS SCAN -
!     SCAN  CASECC,OESI,OEFI/OESFI/*RF*  $    (WHERE I=1, OR 2)
!           OR
!     SCAN  CASECC,OESI,OEFI/OESFI/*OLI* $    FOR ON-LINE SCAN
!
!         . IF INPUT FILES ARE OES1, OEF1, SORT1 TYPE DATA ARE SCANNED
!         . IF INPUT FILES ARE OES2, OEF2, SORT2 TYPE DATA ARE SCANNED
!
!     (ONE INPUT FILE ONLY IF CALLED BY USER VIA DMAP ALTER)
!     (2) STRESS SCAN -
!     SCAN, ,OESI, /OESFI/C,N,ELEMENT/C,N,ICOMP/C,N,NTOP/C,N,AMAX/
!           C,N,AMIN/C,N,IBEG/C,N,IEND/C,N,ICOMPX $
!     OR (3) FORCE SCAN -
!     SCAN, ,,OEFI /OESFI/C,N,ELEMENT/C,N,ICOMP/C,N,NTOP/C,N,AMAX/
!           C,N,AMIN/C,N,IBEG/C,N,IEND/C,N,ICOMPX $
!
!         . FOR SORT1 TYPE DATA, OESI AND OEFI ARE OES1 AND OEF1, AND
!           IBEG AND IEND ARE RANGE OF ELEMENT IDS TO BE SCANNED
!         . FOR SORT2 TYPE DATA, OESI AND OEFI ARE OES2 AND OEF2, AND
!           IBEG AND IEND ARE RANGE OF SUBCASE IDS TO BE SCANNED
!         . IF IBEG AND IEND ARE NOT GIVEN, ALL IDS IMPLY
!
!         . OESB1, OESC1, OEFB1, AND OEFC1 CAN BE USED IN LIEU OF OES1
!           AND OEF1. SIMILARLY, OESC2 AND OEFC2  FOR OES2 AND OEF2
!
!     INPUT  FILES  - CASECC, OES1, OEF1, (OR OES2, OEF2)
!                     (OESB1, OESC1, OEFB1, OEFC1, OESB2, OEFB2 CAN BE
!                     USED INSTEAD)
!     OUTPUT FILE   - OESF1 (OR OESF2)
!     SCRATCH FILE  - SCR1
!
!     THIS SCAN MODULE SHOULD BE FOLLOWED BY OFP TO PRINT SCAN RESULTS
!     OFP  OESFI,,,,, //S,N,CARDNO $
!
!     PARAMETERS -
!
!           ELEMENT - ELEMENT NAME IN BCD.  E.G. BAR, CBAR, QUAD2, ETC.
!           ICOMP   - THE OUTPUT FIELD NO. (BY COLUMN, 1 THRU 31) OF
!                     OUTPUT LISTING.
!           ICOMPX  - OUTPUT FIELD NO. CONTINUATION (FROM 32 THRU 62)
!           NTOP    - TOP N VALUES TO BE OUTPUT.  DEFAULT=20
!      AMAX-AMIN    - SCAN VALUES OUTSIDE THIS MAX-MIN RANGE, DEFAULT=0.
!      IBEG,IEND    - SEE EXPLANATION ABOVE
!
!     DEFINITION OF SOME LOCAL VARIABLES
!
!           DEBUG   - USED FOR LOCAL DEBUG
!           S OR F  - STRESS OR FORCE SCAN FLAG
!           NSCAN   - NO. OF SCAN INPUT CARDS IN CASECC
!           SUBC    - CURRENT SUBCASE ID
!           NZ      - TOP OF OPEN CORE, JUST BELOW GINO BUFFERS
!           LCORE   - AVAILABLE CORE FOR STRSCN ROUTINE
!           IOPEN   - INPUT  FILE STATUS FLAG, .T. FOR OPEN, .F. NOT
!           JOPEN   - OUTPUT FILE STATUS FLAG, .T. FOR OPEN, .F. NOT
!           KOPEN   - SCR1   FILE STATUS FLAG, .T. FOR OPEN, .F. NOT
!           LOPEN   - CASECC FILE STATUS FLAG, .T. FOR OPEN, .F. NOT
!           ISET    - SCAN ONLY BY THE SPECIFIED SET OF ELEM. IDS
!                   - ALL IS IMPLIED IF ISET IS NOT GIVEN
!                   - USED ONLY IF SCAN IS CALLED FROM RIGID FORMAT
!      IDUPL,INC    - SET UP COMPONENT FIELDS TO BE REPEATEDLY SCANNED
!                     IDUPL TIMES, WITH FIELD INCREMENT BY INC (RF ONLY)
!      LBEG,LEND    - A LIST OF TO-BE-SCANNED ELEMENT IDS, STORED IN
!                     Z(LBEG) THRU Z(LEND).
!                   - NO SUCH LIST EXISTS IF LBEG.GT.LEND OR LBEG=LEND=0
!           IOPT    - DATA SCAN BY AMAX AND AMIN IF IOPT=1, BY NTOP IF 2
!           ISORT   - SET TO 1 (BY STRSCN) IF DATA TYPE IS IN SORT1
!                     FORMAT, AND SET TO 2 IF SORT2
!
!     WRITTEN BY G.CHAN/SPERRY      OCTOBER 1984
!
!     THIS ROUTINE OPENS AND CLOSES ALL INPUT AND OUTPUT FILES.
!     IT SETS UP THE SCANNING PARAMETERS AND CALL STRSCN TO SCAN THE
!     OUTPUT STRESS OR FORCE DATA
!
!     THE SCAN INPUT CARDS OPERATE VERY SIMILARY TO THE ELEMENT STRESS
!     OR FORCE CARDS. THEY CAN BE PLACED ABOVE ALL SUBCASES, OR INSIDE
!     ANY SUBCASE LEVEL, OR BOTH
!     HOWEVER, UNLIKE THE STRESS OR FORCE CARDS, MULTI-SCAN CARDS ARE
!     ALLOWED, AND THEY DO NOT EXCLUDE ONE ANOTHER.
!
!     MODIFIED IN 10/1989, TO ALLOW SETS TO BE DEFINED BEFORE OR AFTER
!     SCAN CARDS IN CASE CONTROL SECTION
!     (CURRENTLY, THIS MODIFICATION IS OK, BUT IFP1/IFP1H DO NOT ALLOW
!     SET TO BE DEFINED AFTER SCAN. IN FACT, IFP1 DOES NOT ALLOW SET TO
!     BE DEFINED AFTER ANY GUY WHO USES THE SET)
!
!WKBI  1/4/94 SPR93010 & 93011
!WKBI  1/4/94 SPR93010 & 93011
!RLBR 12/29/93 SPR 93010 & 93011
!     INTEGER         CASECC,   OESI,     OEFI,     OESFI,    SCR1,
!RLBNB 12/29/93 SPR 93010 & 93011
!RLBNE 12/29/93 SPR 93010 & 93011
 
!WKBR 1/4/94 SPR93010 & 93011     3                DEBUG
   !>>>>EQUIVALENCE (Imax,Amax) , (Imin,Amin) , (Idupl,Ibeg) , (Inc,Iend) , (Core(1),Z(1))
!RLBDB 12/29/93 SPR 93010 & 93011
!     DATA            CASECC,   OESI,     OEFI,     OESFI,    SCR1    /
!    1                101,      102,      103,      201,      301     /
!RLBDE 12/29/93 SPR 93010 & 93011
!RLBNB 12/29/93 SPR 93010 & 93011
   DATA casecc , oesi(1) , oefi(1) , oesi(2) , oefi(2) , oesfi(1) , oesfi(2) , scr1/101 , 102 , 103 , 104 , 105 , 201 , 202 , 301/
!RLBNE 12/29/93 SPR 93010 & 93011
   DATA nam , llc , eor , irf/4HSCAN , 4H     , 4HC    , 1 , 4HRF  /
   DATA iol1 , iol2/4HOL1  , 4HOL2 /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
         debug = .FALSE.
!WKBNB 1/4/94 SPR93011 & 93010
         quad4 = 0
         tria3 = 0
!
!     ALLOCATE OPEN CORE
!
!RLBNB 12/29/93 SPR 93010 & 93011
         lloop = 1
         jelt(1) = ielt(1)
         jelt(2) = ielt(2)
         spag_nextblock_1 = 2
      CASE (2)
!RLBNB 12/29/93 SPR 93010 & 93011
         nz = korsz(z)
         ibuf1 = nz - ibuf + 1
         ibuf2 = ibuf1 - ibuf
         ibuf3 = ibuf2 - ibuf
         nz = ibuf3 - 1
         lcore = ibuf2 - 1
         iopen = .FALSE.
         jopen = .FALSE.
         kopen = .FALSE.
         lopen = .FALSE.
!
!     OPEN CASECC AND CHECK SCAN DATA
!
         iset = 0
         IF ( ielt(1)/=irf ) iset = -2
         IF ( ielt(1)==iol1 .OR. ielt(1)==iol2 ) iset = -3
         IF ( iset/=-2 ) THEN
            file = casecc
            CALL open(*120,casecc,z(ibuf1),rdrew)
            lopen = .TRUE.
            CALL fwdrec(*140,casecc)
            IF ( iset/=-3 ) THEN
               SPAG_Loop_1_1: DO
                  CALL read(*40,*40,casecc,z(1),200,1,l)
                  lencc = z(166)
                  nscan = z(lencc-1)
                  IF ( nscan/=0 ) EXIT SPAG_Loop_1_1
               ENDDO SPAG_Loop_1_1
            ENDIF
         ENDIF
!
!     CHECK THE PRESENCE OF STRESS AND/OR FORCE FILE.
!     QUIT IF BOTH ARE PURGED
!
         ioes = 1
         ioef = 1
!RLBDB 12/29/93 SPR 93010 & 93011
!     Z( 1) = OESI
!     Z(11) = OEFI
!RLBDE 12/29/93 SPR 93010 & 93011
!RLBNB 12/29/93 SPR 93010 & 93011
         z(1) = oesi(lloop)
         z(11) = oefi(lloop)
!RLBNE 12/29/93 SPR 93010 & 93011
         CALL rdtrl(z(1))
         CALL rdtrl(z(11))
         IF ( z(1)<0 ) ioes = 0
         IF ( z(11)<0 ) ioef = 0
         IF ( ioes+ioef==0 .AND. iset/=-3 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     OPEN OUTPUT FILE OESFI
!
!RLBDB 12/29/93 SPR 93010 & 93011
!     FILE = OESFI
!     OUFILE = OESFI
!     CALL FNAME (OESFI,Z)
!     CALL OPEN  (*310,OESFI,Z(IBUF2),WRTREW)
!     CALL WRITE (OESFI,Z,2,EOR)
!RLBDE 12/29/93 SPR 93010 & 93011
!RLBNB 12/29/93 SPR 93010 & 93011
         file = oesfi(lloop)
         oufile = oesfi(lloop)
         CALL fname(oufile,z)
         CALL open(*120,oufile,z(ibuf2),wrtrew)
         CALL write(oufile,z,2,eor)
!RLBNE 12/29/93 SPR 93010 & 93011
         jopen = .TRUE.
         itrl3 = 0
         lx = -1
         IF ( ielt(1)==iol2 ) lx = -2
         IF ( iset==-3 ) CALL onlins(*100,lx)
         IF ( iset/=-2 ) THEN
!
!
!     SCAN IS CALLED BY RIGID FORMAT (ISET .GE. -1)
!     OR CALLED BY INTERACTIVE MODE  (ISET .EQ. -3)
!     =============================================
!
            ls = nz
!
!     OPEN SCR1 FILE, SEPERATE SCAN DATA FROM SET DATA IN CASECC, AND
!     SAVE THE COMPLETE SCAN DATA IN SCR1 FILE.
!
            file = scr1
            CALL open(*120,scr1,z(ibuf3),wrtrew)
            kopen = .TRUE.
            nscan = 0
            ncase = 0
            nxx = nz
            IF ( intra<=0 ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            nxx = 198
            l = lx
            IF ( lx>0 ) GOTO 60
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
         ELSE
!
!     SCAN CALLED BY USER VIA DMAP ALTER (ISET=-2)
!     ============================================
!
            ls = lcore
            lbeg = 0
            lend = 0
!
!     CHECK USER DMAP ERROR, SET IOPT FLAG, AND INITIALIZE ISCAN ARRAY
!     FOR COMPONENT SPECIFIED.
!
            IF ( ioes+ioef>1 ) THEN
!
!     ERROR MESSAGES
!
               WRITE (nout,99001)
!
99001          FORMAT (//5X,48HONLY ONE INPUT FILE ALLOWED FROM SCAN DMAP ALTER)
            ELSEIF ( amin>amax ) THEN
               WRITE (nout,99002)
99002          FORMAT (//5X,21HAMAX-AMIN RANGE ERROR)
            ELSEIF ( icomp<=1 ) THEN
               WRITE (nout,99003)
99003          FORMAT (//5X,35HFIELD COMPONENT SPECIFICATION ERROR)
            ELSEIF ( (amax==0. .AND. amin==0.) .AND. ntop==0 ) THEN
               WRITE (nout,99004)
99004          FORMAT (//5X,30HNO AMAX-AMIN OR NTOP SPECIFIED)
            ELSEIF ( (amax/=0. .OR. amin/=0.) .AND. ntop/=0 ) THEN
               WRITE (nout,99005)
99005          FORMAT (//5X,46HSPECIFY EITHER AMAX-AMIN OR NTOP, BUT NOT BOTH,/5X,21H(NTOP=20  BY DEFAULT))
            ELSEIF ( (ibeg==0 .AND. iend/=0) .OR. ibeg>iend .OR. (ibeg/=0 .AND. iend==0) ) THEN
               WRITE (nout,99006) sfm , ielt , ibeg , iend
99006          FORMAT (A25,' - SCANNING ',2A4,' ELEMENT. IBEG-IEND OUT OF RANGE','.  SCAN ABORTED')
            ELSE
               IF ( ibeg==0 .AND. iend==0 ) ibeg = -1
               iopt = 1
               IF ( ntop>0 ) iopt = 2
!
!     DETERMINE ELEMENT TYPE, DROP THE FIRST LETTER C IF NECESSARY
!
               z(1) = irf
               z(2) = irf
               IF ( khrfn2(ielt(1),1,1)==llc ) THEN
                  z(1) = khrfn3(nam(2),ielt(1),1,1)
                  z(1) = khrfn1(z(1),4,ielt(2),1)
                  z(2) = khrfn3(nam(2),ielt(2),1,1)
               ENDIF
               DO i = 1 , last , incr
                  IF ( ielt(1)==e(i) .AND. ielt(2)==e(i+1) ) GOTO 20
                  IF ( z(1)==e(i) .AND. z(2)==e(i+1) ) GOTO 20
               ENDDO
               WRITE (nout,99007) ielt
99007          FORMAT (//5X,22HELEMENT MIS-SPELLED - ,2A4)
            ENDIF
            spag_nextblock_1 = 9
            CYCLE SPAG_DispatchLoop_1
         ENDIF
 20      iel = e(i+2)
!
!     SPECIAL HANDLING OF THE QUAD4 AND TRIA3 ELEMENT, STRESS ONLY
!     (THE 2ND, 3RD, 9TH, AND 13TH WORDS IN OES1/OES1L FILES ARE
!     NOT PRINTED. THE 9TH AND 13TH WORDS MAY BE BLANKS OR ASTERISKS)
!
         IF ( (iel/=64 .AND. iel/=83) .OR. ioes==0 ) THEN
         ENDIF
!WKBD 1/3/94 SPR93011 & 93011      ICOMP = ICOMP + 2
!WKBD 1/3/94 SPR93010 & 93011      IF (ICOMP .GT. 8) ICOMP = ICOMP + 1
!
!     OPEN INPUT FILE
!
!RLBDB 12/29/93 SPR 93010 & 93011
!75   INFILE = OESI
!     IF (IOES .EQ. 0) INFILE = OEFI
!RLBDE 12/29/93 SPR 93010 & 93011
!RLBNB 12/29/93 SPR 93010 & 93011
         infile = oesi(lloop)
         stress = .TRUE.
         force = .FALSE.
         IF ( ioes==0 ) THEN
            stress = .FALSE.
            force = .TRUE.
            infile = oefi(lloop)
         ENDIF
!RLBNE 12/29/93 SPR 93010 & 93011
         file = infile
         CALL open(*20,infile,z(ibuf1),rdrew)
         iopen = .TRUE.
!
! ... NEXT I/O OPERATION ON INFILE WILL BE IN SUBROUTINE STRSCN
!
!     ALL SET TO GO
!
         j = 1
         IF ( ioes==0 ) j = 2
         CALL strscn(j)
         GOTO 100
!
 40      CALL close(casecc,rew)
         lopen = .FALSE.
         RETURN
      CASE (3)
         file = casecc
         CALL rewind(casecc)
         CALL fwdrec(*140,casecc)
         spag_nextblock_1 = 4
      CASE (4)
!
!     READ CASECC AND PROCESS ALL SUBCASES
!
         CALL read(*80,*60,casecc,z(1),nxx,1,l)
         IF ( nxx>=200 ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
 60      ncase = ncase + 1
         lencc = z(166)
         nscan = z(lencc-1)
         lsem = z(lencc)
         subc = z(1)
!
!     PICK UP ALL THE SET ID'S AND THEIR LOCATIONS IN Z ARRAY, Z(L1)
!     THRU Z(LL). SORT, AND CHECK DUPLICATE
!
         jmp = 0
         ii = lencc + lsem
         l1 = l + 1
         ll = l
         SPAG_Loop_1_2: DO
            ii = ii + jmp
            IF ( ii>=l ) THEN
               lll1 = ll - l1 + 1
               ll2 = lll1/2
               IF ( debug ) WRITE (nout,99008) (z(i),i=l1,ll)
99008          FORMAT (' ...SET/@125',/,(10X,I8,' @',I6))
!
               jmp = 0
               ii = lencc + lsem
               kk = nz
               IF ( ll2>1 ) THEN
                  CALL sort(0,0,2,1,z(l1),lll1)
                  j = l1 + 2
                  DO i = j , ll , 2
                     IF ( z(i)==z(i-2) ) WRITE (nout,99009) uwm , z(i)
99009                FORMAT (A25,' FROM SCAN, DUPLICATE SET',I9)
                  ENDDO
               ENDIF
               EXIT SPAG_Loop_1_2
            ELSE
               jmp = z(ii+2) + 2
               IF ( z(ii+1)<10000000 .OR. jmp/=8 ) THEN
                  z(ll+1) = z(ii+1)
                  z(ll+2) = ii
                  ll = ll + 2
               ENDIF
            ENDIF
         ENDDO SPAG_Loop_1_2
         spag_nextblock_1 = 5
      CASE (5)
         SPAG_Loop_1_3: DO
!
!     PROCESS THE SCAN CARDS
!
!     PICK UP SCAN 8 WORD ARRAY, AND PICK UP SET DATA
!     WRITE TO SCR1 A RECORD (OF EACH SUBCASE) OF THE SCAN INPUT DATA
!     IN REVERSE ORDER (FIRST SCAN CARD LAST, AS SET UP BY CASECC)
!
            ii = ii + jmp
            IF ( ii>=l ) THEN
!
!     AT THE END OF EACH SUBCASE, WE COMPUTE THE TOTAL LENGTH OF THIS
!     SCAN DATA ARRAY, AND WRITE THE ARRAY OUT TO SCR1.  ONE RECORD PER
!     SUBCASE
!
               kk = kk - 2
               IF ( kk<ll ) THEN
!
                  CALL mesage(8,0,nam)
                  RETURN
               ELSE
                  ie = nz - kk
                  z(kk+1) = subc
                  z(kk+2) = ie - 2
                  CALL write(scr1,z(kk+1),ie,1)
                  l = kk + 1
                  nn = 200
                  IF ( debug ) WRITE (nout,99016) nn , (z(j),j=l,nz)
                  IF ( intra>0 .AND. lx>=200 ) EXIT SPAG_Loop_1_3
                  spag_nextblock_1 = 4
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ELSE
               jmp = z(ii+2) + 2
               IF ( z(ii+1)>=10000000 .AND. jmp==8 ) THEN
                  ie = 0
                  iset = z(ii+4)
                  IF ( iset/=-1 ) THEN
                     IF ( lll1<=0 ) GOTO 180
                     CALL bisloc(*180,iset,z(l1),2,ll2,i)
                     ib = z(i+l1) + 2
                     ie = z(ib)
                     IF ( debug ) WRITE (nout,99010) iset , i , ib , ie
99010                FORMAT (' @145, SET',I8,' FOUND.  I,IB,IE =',3I6)
                     kk = kk - ie
                     DO i = 1 , ie
                        z(kk+i) = z(ib+i)
                     ENDDO
                  ENDIF
                  kk = kk - 9
                  DO i = 1 , 8
                     z(kk+i) = z(ii+i)
                  ENDDO
                  z(kk+9) = 0
                  idupl = z(kk+8)
                  IF ( idupl/=0 ) THEN
!WKBD 1/3/94 SPR93010 & 93011      INC = IDUPL/100
!WKBD 1/3/94 SPR93010 & 93011      Z(KK+8) = MOD(IDUPL,100)
!WKBNB 1/3/94 SPR93010 & 93011
                     inc = mod(idupl,100)
                     z(kk+8) = idupl/100
!WKBNE 1/3/94 SPR93010 & 93011
                     z(kk+9) = inc
                  ENDIF
                  z(kk+2) = z(kk+2) + 1 + ie
!
!     HERE AT THE TAIL END OF OPEN CORE, WE ACCUMULATE ANOTHER RECORD
!     OF A SCAN DATA SET
!        WORD 1,  10000000 FOR STRESS, OR 20000000 FOR FORCE
!             2,  NO. OF WORDS OF THIS DATA SET (SCAN + SET)
!                 (FIRST 2 WORDS NOT INCLUDED)
!             3,  ELEMENT TYPE NUMERIC CODE
!             4,  SET-ID, OR -1
!             5,  COMPONENT CODE, ICOMP
!             6,  NTOP, OR AMAX
!             7,  -1,   OR AMIN
!             8,  COMPONENT - DUPLICATION, OR ZERO
!             9,  COMPONENT - INCREMENT,   OR ZERO
!        10-END,  SET DATA
!     REPEAT FOR ANOTHER SCAN CARD
!
!
!     SPECIAL HANDLING OF THE QUAD4 AND TRIA3 ELEMENT, STRESS ONLY
!     (THE 2ND, 3RD, 9TH,  AND 13TH WORDS IN OES1/OES1L FILES ARE
!     NOT PRINTED. THE 9TH AND 13TH WORDS MAY BE BLANKS OR ASTERISKS)
!WKBI 12/93 SPR93010 & 93011
!     ABOVE IS TRUE ONLY FOR LAMINATED QUAD4 AND TRIA3)
!
!WKBD 12/31/93 SPR93010 & 93011
!     IF ((Z(KK+3).NE.64 .AND. Z(KK+3).NE.83) .OR. Z(KK+1).NE.10000000)
                  IF ( (z(kk+3)/=64 .AND. z(kk+3)/=83) .OR. z(kk+8)==0 ) THEN
!WKBDB 1/3/94 SPR93010 & 93011
!      Z(KK+5) = Z(KK+5) + 2
!      IF (Z(KK+5) .GT. 8) Z(KK+5) = Z(KK+5) + 1
!      IF (Z(KK+9) .NE. 0) Z(KK+9) = Z(KK+9) + 2
!WKBDE 1/3/94 SPR93010 & 93011
                  ENDIF
               ENDIF
            ENDIF
         ENDDO SPAG_Loop_1_3
!
!     THUS, END OF THE PREPARATION PHASE.  CLOSE CASECC AND SCR1
!
 80      CALL close(casecc,rew)
         CALL close(scr1,rew)
         kopen = .FALSE.
         lopen = .FALSE.
!
!     NOW, SET UP 2 LOOPS FOR STRESS (10000000) AND FORCE (20000000)
!     OUTPUT SCAN
!
         sorf = 30000000
         SPAG_Loop_1_4: DO
            sorf = sorf - 10000000
            IF ( debug ) WRITE (nout,99011) sorf
99011       FORMAT (///,18H PROCESSING SERIES,I15/1X,8(4H====),/)
            IF ( iopen ) CALL close(infile,rew)
            iopen = .FALSE.
            IF ( sorf/=10000000 .OR. ioes/=0 ) THEN
               IF ( sorf/=20000000 .OR. ioef/=0 ) THEN
                  IF ( sorf<=0 ) EXIT SPAG_Loop_1_4
!
!     OPEN INPUT FILES
!
!RLBDB 12/29/93 SPR 93010 & 93011
!     INFILE = OESI
!     IF (SORF .GE. 20000000) INFILE=OEFI
!RLBDE 12/29/93 SPR 93010 & 93011
!RLBNB 12/29/93 SPR 93010 & 93011
                  infile = oesi(lloop)
                  stress = .TRUE.
                  force = .FALSE.
                  IF ( sorf>=20000000 ) THEN
                     stress = .FALSE.
                     force = .TRUE.
                     infile = oefi(lloop)
                  ENDIF
!RLBNE 12/29/93 SPR 93010 & 93011
                  file = infile
                  CALL open(*120,infile,z(ibuf1),rdrew)
                  iopen = .TRUE.
! ... NEXT I/O OPERATION ON INFILE WILL BE IN SUBROUTINE STRSCN
!
!     NOW, LOAD THE SCAN DATA PREVIOUSLY SAVED IN SCR1, TO THE TAIL END
!     OF THE OPEN CORE.
!     ONE OR MORE SCAN CARDS MAY BE PRESENT IN  ONE SUBCASE
!     SET UP POINTERS IN FRONT OF THE SCAN DATA, SO THAT FIRST SCAN
!     INPUT CARD WILL BE PROCESS FIRST, SECOND CARD SECOND, ETC.
!     NOTE - USE SUBCASE 1 SCAN DATA IF OUTPUT IS SORT 2 TYPE
!            (IF SUBCASE 1 DOES NOT HAVE SCAN DATA, USE NEXT SUBCASE)
!
                  file = scr1
                  IF ( .NOT.kopen ) CALL open(*120,scr1,z(ibuf3),rdrew)
                  IF ( kopen ) CALL rewind(scr1)
                  kopen = .TRUE.
                  isort = 0
                  osubc = 0
                  oel = 0
!
                  SPAG_Loop_2_5: DO ii = 1 , ncase
                     IF ( isort==2 ) EXIT SPAG_Loop_2_5
                     CALL read(*140,*160,scr1,z(1),2,0,l)
                     j = z(2)
                     IF ( j==0 ) THEN
                        CALL fwdrec(*140,scr1)
                     ELSE
                        subc = z(1)
                        ls = nz - j
                        CALL read(*140,*160,scr1,z(ls+1),j,1,l)
                        le = ls
                        i = ls
                        SPAG_Loop_3_6: DO
                           z(ls) = i
                           ls = ls - 1
                           i = i + z(i+2) + 2
                           IF ( i>=nz ) THEN
                              lcore = ls
                              j = ls + 1
                              kk = 230
                              IF ( debug ) WRITE (nout,99016) kk , subc , (z(i),i=j,nz)
!
!     NOW IS THE TIME TO SET THE SCAN PARAMETERS FOR EACH SCAN CARD
!     WITHIN A SUBCASE, AND CALL STRSCN TO SCAN THE OUTPUT DATA
!
                              i = ls
                              DO
                                 i = i + 1
                                 IF ( i>le ) EXIT SPAG_Loop_3_6
                                 ib = z(i)
                                 IF ( z(ib+1)==sorf ) THEN
                                    jmp = z(ib+2)
                                    iel = z(ib+3)
! ONLY QUAD4 (=64) AND TRIA3 (=83) ARE VALID FOR LLOOP=2
                                    IF ( lloop/=2 .OR. iel==64 .OR. iel==83 ) THEN
                                       iset = z(ib+4)
                                       icomp = z(ib+5)
                                       ntop = z(ib+6)
                                       imax = z(ib+6)
                                       imin = z(ib+7)
                                       idupl = z(ib+8)
                                       inc = z(ib+9)
                                       iopt = 1
                                       IF ( imin==-1 ) iopt = 2
                                       IF ( iopt/=2 ) ntop = 0
                                       lbeg = lcore
                                       lend = lcore - 1
                                       IF ( iset/=-1 ) THEN
                                         lbeg = ib + 10
                                         lend = ib + jmp + 2
                                       ENDIF
                                       j = (iel-1)*incr
                                       ielt(1) = e(j+1)
                                       ielt(2) = e(j+2)
                                       IF ( debug ) WRITE (nout,99012) ielt , (z(ib+j),j=3,9) , iopt , lbeg , lend , ii , subc
99012                                  FORMAT (/5X,16HDEBUG/SCAN255 - ,2A4,/5X,12I9)
                                       CALL strscn(sorf/10000000)
                                       IF ( iopt<0 ) THEN
                                         spag_nextblock_1 = 8
                                         CYCLE SPAG_DispatchLoop_1
                                       ENDIF
                                    ENDIF
                                 ENDIF
                              ENDDO
                           ENDIF
                        ENDDO SPAG_Loop_3_6
                     ENDIF
!
!     GO BACK TO PROCESS NEXT INPUT FILE
!
                  ENDDO SPAG_Loop_2_5
               ENDIF
            ENDIF
         ENDDO SPAG_Loop_1_4
!
!     ALL SCAN DONE.  WRITE OUTPUT FILE TRAILERS AND CLOSE ALL FILES
!
 100     IF ( itrl3>0 ) THEN
!RLBR 12/29/93 SPR 93010 & 93011
!     Z(1) = OESFI
            z(1) = oesfi(lloop)
            z(2) = 1
            z(3) = itrl3
            DO i = 4 , 7
               z(i) = 0
            ENDDO
            CALL wrttrl(z(1))
         ENDIF
         spag_nextblock_1 = 6
      CASE (6)
!
         IF ( iopen ) CALL close(infile,rew)
         IF ( jopen ) CALL close(oufile,rew)
         IF ( kopen ) CALL close(scr1,rew)
         IF ( lopen ) CALL close(casecc,rew)
!RLBNE 12/29/93 SPR 93010 & 93011
         IF ( lloop==2 ) THEN
            IF ( quad4==-1 ) WRITE (nout,99017) 'QUAD4'
            IF ( tria3==-1 ) WRITE (nout,99017) 'TRIA3'
!RLBNE 12/29/93 SPR 93010 & 93011
            RETURN
         ELSE
            lloop = 2
            ielt(1) = jelt(1)
            ielt(2) = jelt(2)
            spag_nextblock_1 = 2
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     FILE ERRORS
!
 120     j = -1
         CALL mesage(j,file,nam)
         spag_nextblock_1 = 7
         CYCLE SPAG_DispatchLoop_1
 140     j = -2
         CALL mesage(j,file,nam)
         spag_nextblock_1 = 7
         CYCLE SPAG_DispatchLoop_1
 160     j = -3
         CALL mesage(j,file,nam)
         spag_nextblock_1 = 7
      CASE (7)
         DO
            j = -8
            CALL mesage(j,file,nam)
         ENDDO
 180     WRITE (nout,99013) uwm , iset
99013    FORMAT (A25,' FROM SCAN, SET',I9,' NOT FOUND')
         spag_nextblock_1 = 5
      CASE (8)
         WRITE (nout,99014) iopt
99014    FORMAT (//5X,44HUSER ERROR.  ILLEGAL INPUT FILE SENT TO SCAN,I6)
         spag_nextblock_1 = 9
      CASE (9)
         WRITE (nout,99015) swm
99015    FORMAT (A27,' FROM SCAN.  CASE ABORTED ***')
         GOTO 100
      END SELECT
   ENDDO SPAG_DispatchLoop_1
99016 FORMAT (/,11H SCAN/DEBUG,I3,(/2X,13I9))
99017 FORMAT (//' SCAN MODULE DID NOT FIND ELEMENT ',A5,' IN USER OUTPUT REQUESTS.',/,                                              &
             &' POSSIBLY WRONG COMPONENT SPECIFIED FOR LAYERED OR ','NON-LAYERED CASE',//)
END SUBROUTINE scan