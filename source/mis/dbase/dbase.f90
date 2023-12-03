!*==dbase.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE dbase
!
!     DRIVER FOR DATABASE MODULE
!
!     THIS UTILITY MODULE TRANSFERS GRID POINT DATA, CONNECTING ELEMENT
!     DATA, AND MOST OF THE OFP DATA BLOCKS (DISPLACEMENT, VELOCITY,
!     ACCELERTION, LOAD, GRID POINT FORCE, EIGENVECTOR, ELEMENT STRESS
!     AND ELEMENT FORCE) TO A FORTRAN FILE, FORMATTED OR UNFORMATTED.
!     THE GRID POINT DATA ARE IN BASIC COORDINATE SYSTEM, AND THE
!     DISPLACEMENT DATA IF REQUESTED, CAN BE IN BASIC SYSTEM (DEFAULT)
!     OR IN GLOBAL COORDINATE SYSTEM. GRID POINTS ARE IN EXTERNAL GRID
!     NUMBERING SYSTEM.
!     THE FORMATTED OUTTP FILE CAN BE PRINTED, OR EDITTED BY SYSTEM
!     EDITOR. ALL OUTPUT LINES ARE 132 COLUMNS OR LESS.
!
!
!     WRITTEN ON THE LAST DAY OF 1988 BY G.CHAN/UNISYS.
!     REVISED 10/89, EXPANDED TO INCLUDE THREE OFP FILES
!
!     DATABASE  EQEXIN,BGPDT,GEOM2,CSTM,O1,O2,O3//C,N,OUTTP/C,N,FORMAT
!                                                /C,N,BASIC   $
!
!               EQEXIN - MUST BE PRESENT
!               BGPDT  - IF PURGE, NO GRID POINT DATA SENT TO OUTTP
!               GEOM2  - IF PURGE, NO ELEMENT CONNECTIVITY DATA SENT TO
!                        OUTTP
!               CSTM   - IF PURGE, DISPLACEMENT VECTOR IN GLOBAL COORD.
!               Oi     - ANY ONE OF NASTRAN STANDARD OFP FILES LISTED
!                        BELOW. IF PURGE, NO DATA SENT TO OUTTP.
!                        IF THE DATA IN THIS OFP FILE IS COORDINATE
!                        SENSITIVE, SUCH AS DISPLACEMENT, THE DATA CAN
!                        BE SENT OUT TO OUTTP IN BASIC OR GLOBAL
!                        COORDINATES AS SPECIFIED THE PARAMETER BASIC.
!               OUTTP  - MUST BE ONE OF THE UT1,UT2,INPT,INP1,...,9 FILE
!               FORMAT = 0, UNFORMATTED OUTPUT TO OUTTP FILE (DEFAULT)
!                      = 1, FORMATTED
!               BASIC  = 0, DISPLACEMENT VECTORS REMAIN IN GLOBAL COORD.
!                           SYSTEM (DEFAULT)
!                      = 1, DISPLACEMENT VECTORS IN BASIC COORD. SYSTEM
!                           (NOT USED IN ELEMENT FORCES AND STRESSES)
!
!     LIST OF AVAILABLE OFP FILES (Oi)
!          OUDV1,  OUDVC1, OUGV1,  OUHV1,  OUHVC1, OUPV1,  OUPVC1,
!          OUDV2,  OUDVC2, OUGV2,  OUHV2,  OUHVC2, OUPV2,  OUPVC2,
!          OUBGV1, OPHID,  OPHIG,  OPHIH,  OCPHIP,
!          OPG1,   OPP1,   OPPC1,  OQG1,   OQP1,   OQPC1,  OQBG1,
!          OPG2,   OPP2,   OPPC2,  OQG2,   OQP2,   OQPC2,  OQBG2,
!          OEF1,   OEFC1,  OES1,   OESC1,  OEFB1,  OBEF1,
!          OEF2,   OEFC2,  OES2,   OESC2,  OESB1,  OBES1
!          OES1A,
!          HOUDV1, HOUGV1, HOPG1,  HOQG1,  HOEF1,  HOES1,  HOPNL1,
!          HOUDV2, HOUGV2, HOPP2,  HOQP2,  HOEF2,  HOEFIX, HOPNL2
!
!
!     MAP THIS ROUTINE IN LINK2, LINK4 AND LINK14
!
   USE c_blank
   USE c_gpta1
   USE c_machin
   USE c_names
   USE c_system
   USE c_xmssg
   USE c_zzzzzz
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , DIMENSION(10) :: a
   INTEGER , DIMENSION(80) :: a1
   CHARACTER(8) , SAVE :: acc , ba , blk8 , ca , dash , dis , eign , elf , elm , forc , gl , gpt , lod , mo , str , velo
   INTEGER :: again , buf1 , buf2 , case , cmplx , coor , dspl , eltyp , fi , file , flag , g1 , grid , i , icstm , imhere , iougv ,&
            & j , j16 , j17 , j31 , j32 , jb , jbm1 , jbp1 , je , jos , jso , k , k5 , khi , kiougv , kk , klo , kount , l , lastk ,&
            & left , mid , na4 , nbg5 , nbgt , ncstm , ne , neq , neq2 , ng , ng3 , ngd , nsub , nwds , nz , ofp , ofpset , ofpx ,  &
            & ougv , pid , set , symbol
   INTEGER , DIMENSION(5) :: b
   CHARACTER(8) :: bagl , camo , dxx
   LOGICAL :: basc , ecxyz , efs , fmttd , nobgpt , nocstm , nogeom
   INTEGER , SAVE :: bgpdt , blank , bzero , cstm , end1 , end2 , end3 , eqexin , fmt1 , geom2 , izero , limaf , limrx , ls , mone ,&
                   & scr1
   LOGICAL , SAVE :: debug
   CHARACTER(8) , DIMENSION(3) :: dyy
   INTEGER , DIMENSION(79) :: f
   INTEGER , DIMENSION(6) :: f8 , oname
   INTEGER , DIMENSION(4) , SAVE :: fmt , fstf
   REAL :: freq
   INTEGER , DIMENSION(8) , SAVE :: inp
   INTEGER , DIMENSION(3) , SAVE :: inpx
   INTEGER , DIMENSION(1) :: ix
   INTEGER , DIMENSION(8) :: nam
   REAL , DIMENSION(1) :: ra , rz
   REAL , DIMENSION(200) :: rx
   INTEGER , DIMENSION(2) , SAVE :: sub
   INTEGER , DIMENSION(3) :: subn
   REAL , DIMENSION(9) :: t
   EXTERNAL bckrec , close , fname , fwdrec , gmmats , ifb2ar , korsz , mesage , numtyp , open , page , page2 , pretrs , rdtrl ,    &
          & read , sort , transs , write
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
   !>>>>EQUIVALENCE (Z(1),Rz(1)) , (b(1),nam(1)) , (a(1),ra(1),a1(3)) , (rx(1),ix(1))
   DATA eqexin , bgpdt , geom2 , cstm , scr1 , sub/101 , 102 , 103 , 104 , 301 , 4HDBAS , 4HE   /
   DATA end1 , end2 , end3 , fmt/4H -EN , 2HD- , 2H-- , 4H, UN , 4HFORM , 4HATTE , 1HD/
   DATA fmt1 , mone , blank , bzero , izero , debug/1H, , -1 , 4H     , 4H 0.0 , 4H-0   , .FALSE./
   DATA ls , inpx , limaf , limrx/1HS , 4H INP , 4HINPT , 4H  UT , 78 , 200/
   DATA gpt , elm , dis , dash/'GRID PTS' , 'ELEMENTS' , 'DISPLCNT' , '--------'/
   DATA lod , forc , velo , blk8/'LOADINGS' , 'GD FORCE' , 'VELOCITY' , '        '/
   DATA acc , eign , str , elf/'ACCELERN' , 'EIGENVCR' , 'E.STRESS' , 'E.FORCES'/
   DATA ca , mo , ba , gl/' CASE = ' , ' MODE = ' , '  BASIC ' , ' GLOBAL '/
   DATA fstf/4H1ST  , 4H2ND  , 4H3RD  , 4H4TH / , inp/4HEQEX , 2HIN , 4HBGPD , 2HT  , 4HGEOM , 4H2    , 4HCSTM , 1H /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!
         IF ( debug ) WRITE (nout,99001)
99001    FORMAT (/5X,'-- DBASE LOCAL DEBUG --')
         nam(1) = 106
         CALL rdtrl(nam(1))
         IF ( nam(1)<=0 ) THEN
            CALL page
            WRITE (nout,99002) uim
99002       FORMAT (A29,', DATABASE NEW DMAP FORMAT',//5X,'DATABASE   EQEXIN,BGPDT,GEOM2,CSTM,O1,O2,O3//C,N,OUTTP/',                &
                   &'C,N,FORMAT/C,N,BASIC  $',/5X,'FIRST 4 FILES ARE FIXED ',                                                       &
                   &'IN NAMES AND ORDER, NEXT 3 FILES CAN BE SELECTED BY USER',/5X,                                                 &
                   &'FIRST EQEXIN FILE MUST BE PRESENT, OTHERS CAN BE ','SELECTIVELY OMITTED')
         ENDIF
         IF ( outtp<11 .OR. outtp>24 ) THEN
            WRITE (nout,99003) ufm , outtp
99003       FORMAT (A23,', OUTPUT FILE SPEC. ERROR')
            CALL mesage(-37,0,sub)
         ENDIF
         efs = .FALSE.
         fmttd = .FALSE.
         basc = .FALSE.
         ecxyz = .FALSE.
         IF ( formtd==1 ) fmttd = .TRUE.
         IF ( basic==1 ) basc = .TRUE.
         IF ( fmttd ) fmt(1) = fmt1
         CALL fname(101,nam(1))
         IF ( nam(1)/=inp(1) .OR. nam(2)/=inp(2) ) THEN
            CALL page2(3)
            WRITE (nout,99029) fstf(1) , nam(1) , nam(2)
            nogo = 1
         ENDIF
         nobgpt = .FALSE.
         nogeom = .FALSE.
         nocstm = .FALSE.
         nam(1) = bgpdt
         CALL rdtrl(nam)
         IF ( nam(1)<=0 ) nobgpt = .TRUE.
         IF ( .NOT.(nobgpt) ) THEN
            CALL fname(102,nam(1))
            IF ( nam(1)/=inp(3) .OR. nam(2)/=inp(4) ) THEN
               CALL page2(3)
               WRITE (nout,99029) fstf(2) , nam(1) , nam(2)
               nogo = 1
            ENDIF
         ENDIF
         nam(1) = geom2
         CALL rdtrl(nam)
         IF ( nam(1)<=0 ) nogeom = .TRUE.
         IF ( .NOT.(nogeom) ) THEN
            CALL fname(103,nam(1))
            IF ( nam(1)/=inp(5) .OR. nam(2)/=inp(6) ) THEN
               CALL page2(3)
               WRITE (nout,99029) fstf(3) , nam(1) , nam(2)
               nogo = 1
            ENDIF
         ENDIF
         nam(1) = cstm
         CALL rdtrl(nam)
         IF ( nam(1)<=0 ) nocstm = .TRUE.
         IF ( .NOT.(nocstm) ) THEN
            CALL fname(104,nam(1))
            IF ( nam(1)/=inp(7) .OR. nam(2)/=inp(8) ) THEN
               CALL page2(3)
               WRITE (nout,99029) fstf(4) , nam(1) , nam(2)
               nogo = 1
            ENDIF
         ENDIF
         IF ( nogo==1 ) RETURN
!
         nz = korsz(z(1))
         buf1 = nz - sysbuf
         buf2 = buf1 - sysbuf
         nz = buf2 - 1
         coor = 0
!
!     OPEN EQEXIN, READ FIRST RECORD, AND SORT EX-INT TABLE BY INTERNAL
!     NUMBERS, Z(1) THRU Z(NEQ)
!
         file = eqexin
         CALL open(*420,eqexin,z(buf1),rdrew)
         CALL fwdrec(*420,eqexin)
         CALL read(*420,*40,eqexin,z(1),nz,1,neq)
         j = 0
         DO
            CALL read(*420,*20,eqexin,z(1),nz,1,neq)
            j = j + nz
         ENDDO
 20      j = j + neq
         j = j*2
         CALL mesage(-8,j,sub)
!
 40      CALL close(eqexin,rew)
         left = nz - neq - 1
         neq2 = neq/2
         j = neq2*5 - left
         IF ( j>0 ) CALL mesage(-8,j,sub)
         CALL sort(0,0,2,2,z(1),neq)
!
!     IF BGPDT FILE NOT REQUESTED, SKIP PROCESSING GRID POINT DATA
!
         IF ( nobgpt ) GOTO 80
!
!
!     GRID POINTS PROCESSING
!     ======================
!
!     OPEN BGPDT, READ THE ENTIRE RECORD, AND REPLACE THE COORD.SYSTEM
!     WORD BY THE EXTERNAL GRID POINT NUMBER.
!     NOTE - EXT.GRID IDS ARE NO LONGER SORTED.
!     WRITE THE NEW DATA TO SCR1 FILE - EXT.GIRD ID, X,Y,Z BASIC COORD.
!
         file = scr1
         CALL open(*420,scr1,z(buf1),wrtrew)
         file = bgpdt
         CALL open(*80,bgpdt,z(buf2),rdrew)
         CALL fwdrec(*420,bgpdt)
         ngd = 0
         DO
            CALL read(*60,*60,bgpdt,b(2),4,0,flag)
            ngd = ngd + 1
            k = ngd*2 - 1
            b(1) = z(k)
            b(2) = 0
            CALL write(scr1,b,5,0)
         ENDDO
 60      CALL write(scr1,0,0,1)
         CALL close(scr1,rew)
         CALL close(bgpdt,rew)
!
!     OPEN SCR1 AND OUTTP
!     SORT THE GRID POINT DATA BY THEIR EXTERNAL NUMBERS
!
!     FOR UNFORMATTED TPAE, TRANSFER GRID DATA FROM SCR1 TO OUTTP IN ONE
!     LONG RECORD
!
!          WORD         CONTENT (UNFORMATTED, 2ND RECORD)
!        ------    ----------------------------------------------------
!             1     NO. OF WORDS (THIS FIRST WORD NOT INCLUDED) IN THIS
!                   RECORD (INTEGER)
!             2     EXTERNAL GRID ID (SORTED)
!             3     0 (NOT USED, RESERVED FOR FUTURE USE. INTEGER)
!         4,5,6     X,Y,Z COORDINATES IN BASIC COORD SYSTEM (REAL)
!             :     REPEAT 2 THRU 6 AS MANY TIMES AS THERE ARE GRIDS.
!
         file = scr1
         jb = neq + 1
         jbp1 = jb + 1
         jbm1 = jb - 1
         k = ngd*5
         CALL open(*420,scr1,z(buf1),rdrew)
         CALL read(*420,*440,scr1,z(jbp1),k,1,flag)
         CALL close(scr1,rew)
         CALL sort(0,0,5,1,z(jbp1),k)
!
!     FIRST GRID POINT IDENTIFICATION RECORD TO OUTTP
!
         IF ( .NOT.fmttd ) WRITE (outtp) gpt , dash
         IF ( fmttd ) WRITE (outtp,99030) gpt , dash
!
         IF ( fmttd ) THEN
!
!     FOR FORMATTED TAPE
!
!       RECORD   WORD     CONTENT                               FORMAT
!       ------   ----    ----------------------------------------------
!           2      1      TOTAL NUMBER OF GRID POINTS             I8
!           3      1      EXTERNAL GRID ID (NOT SORTED)           I8
!                  2      0 (NOT USED, RESERVED FOR FUTURE USE)   I8
!                3,4,5    X,Y,Z COORDINATES IN BASIC SYSTEM  3(1P,E12.5)
!           :     1-5     REPEAT RECORD 3 AS MANY TIMES AS THERE
!                         ARE GRIDS
!
            WRITE (outtp,99004) ngd
99004       FORMAT (1X,I8,'= TOTAL NUMBER OF GRID POINTS')
            k = jb
            DO i = 1 , ngd
               WRITE (outtp,99005) z(k+1) , z(k+2) , rz(k+3) , rz(k+4) , rz(k+5)
99005          FORMAT (1X,2I8,3(1P,E12.5))
               k = k + 5
            ENDDO
         ELSE
            z(jb) = k
            je = k + jb
            WRITE (outtp) (z(j),j=jb,je)
         ENDIF
!
!     IF GEOM2 IS NOT REQUESTED, SKIP PROCESSING ELEMENT DATA
!
 80      IF ( nogeom ) GOTO 220
!
!
!     ELEMENT CONNECTIVITY PROCESSING
!     ===============================
!
!     OPEN GEOM2 AND SCR1. TRANSFER ELEMENT DATA TO SCR1 FILE
!
         file = geom2
         CALL open(*220,geom2,z(buf2),rdrew)
         CALL fwdrec(*420,geom2)
!
!     FIRST ELEMENT IDENTIFICATION RECORD TO OUTTUP
!
         IF ( .NOT.fmttd ) WRITE (outtp) elm , dash
         IF ( fmttd ) WRITE (outtp,99030) elm , dash
         spag_nextblock_1 = 2
      CASE (2)
!
         CALL read(*200,*200,geom2,b,3,0,flag)
         IF ( b(1)==b(2) .AND. b(2)==b(3) ) GOTO 200
         DO i = 4 , last , incr
            IF ( b(1)==e(i) ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDDO
         CALL mesage(-61,0,0)
         spag_nextblock_1 = 3
      CASE (3)
         nam(1) = e(i-3)
         nam(2) = e(i-2)
         eltyp = e(i-1)
         nwds = e(i+2)
         pid = e(i+3)
         symbol = e(i+12)
         ng = e(i+6)
         g1 = e(i+9) - 1
         ng3 = ng + 3
         ne = 0
         mid = 0
!               TETRA,WEDGE,HEXA1,HEXA2            FHEX1          FHEX2
         IF ( eltyp>=39 .AND. eltyp<=42 .OR. eltyp==76 .OR. eltyp==77 ) mid = 2
         nam(3) = eltyp
         nam(4) = symbol
         nam(5) = ng
         nam(6) = ne
         nam(7) = ng3
         nam(8) = 1
         IF ( ng>13 ) nam(8) = 2
         IF ( ng>28 ) nam(8) = 3
!
!     FOR UNFORMATTED TAPE -
!
!     ELEMENT HEADER RECORD WRITTEN TO SCR1
!
!        WORD        CONTENT  (UNFORMATTED)
!        ----    ----------------------------------------------------
!         1-2     ELEMENT BCD NAME
!           3     ELEMENT TYPE NUMBER, ACCORDING TO GPTABD ORDER
!           4     ELEMENT SYMBOL (2 LETTERS)
!           5     NG= NUMBER OF GRID POINTS
!           6     NE= TOTAL NO. OF ELEMENTS OF THIS CURRENT ELEMENT TYPE
!           7     NO. OF WORDS IN NEXT RECORD PER ELEMENT = NG+2
!           8     NO. OF 132-COLUMN LINES NEEDED IN NEXT RECORD IF OUTTP
!                 IS WRITTED WITH A FORMAT
!
         file = scr1
         CALL open(*420,scr1,z(buf1),wrtrew)
         CALL write(scr1,nam,8,0)
         file = geom2
         DO
            CALL read(*220,*100,geom2,a,nwds,0,flag)
            a1(1) = a(1)
            a1(2) = a(2)
            a1(3) = 0
            IF ( pid==0 ) a1(2) = 0
            IF ( mid==2 ) a1(2) = -a(2)
            DO j = 1 , ng
               a1(j+3) = a(g1+j)
            ENDDO
            CALL write(scr1,a1,ng3,0)
            ne = ne + 1
         ENDDO
 100     CALL write(scr1,0,0,1)
         CALL close(scr1,rew)
         file = scr1
         CALL open(*420,scr1,z(buf1),rdrew)
         CALL read(*420,*160,scr1,z(jb),left,1,nwds)
         CALL bckrec(scr1)
         IF ( .NOT.fmttd ) THEN
!
!     BYPASSING INSUFF. CORE SITUATION, FORMATTED TAPE ONLY
!
            CALL read(*420,*420,scr1,a,8,0,flag)
            a(6) = ne
            WRITE (outtp,99031,ERR=460) (a(j),j=1,8)
            DO
               CALL read(*420,*180,scr1,a,ng3,0,flag)
               IF ( ng3>16 ) THEN
                  WRITE (outtp,99033,ERR=460) (a(j),j=1,16)
                  IF ( ng3>32 ) THEN
                     WRITE (outtp,99032,ERR=460) (a(j),j=17,32)
                     WRITE (outtp,99032,ERR=460) (a(j),j=33,ng3)
                  ELSE
                     WRITE (outtp,99032,ERR=460) (a(j),j=17,ng3)
                  ENDIF
               ELSE
                  WRITE (outtp,99033,ERR=460) (a(j),j=1,ng3)
               ENDIF
            ENDDO
         ELSE
            j = 0
            CALL read(*420,*120,scr1,z(jb),left,0,flag)
         ENDIF
 120     DO
            CALL read(*420,*140,scr1,z(jb),left,0,flag)
            j = j + left
         ENDDO
 140     j = j + flag
         CALL mesage(-8,j,sub)
 160     CALL close(scr1,rew)
         z(jb+5) = ne
         IF ( fmttd ) THEN
!
!     ELEMENT RECORD TO SCR1
!
!       WORD      CONTENT, ALL INTEGERS  (UNFORMATTED)
!       ----    ------------------------------------------------
!         1      ELEMENT ID
!         2      POSITIVE INTEGER  = PROPERTY ID
!                ZERO IF ELEM HAS NO PROPERTY ID
!                NEGATIVE INTEGER  = MATERIAL ID (ELEMENT HAS NO
!                  PROPERTY ID, BUT IT HAS A MATERIAL ID)
!         3      0 (NOT USED. RESERVED FOR FUTURE USE)
!       4,5,...  ELEMENT CONNECTING GRID POINTS
!         :      REPEAT 1,2,3,4,... AS MANY TIMES AS THERE ARE ELEMENTS
!                  OF THIS SAME TYPE
!
!
!
!     FOR FORMATTED TAPE -
!
!     ELEMENT HEADER RECORD, IN 8-COLUMN FORMAT
!     (LINE ---+++ IS FOR VIDEO AID, NOT PART OF A RECORD)
!
!     --------++++++++--------++++++++--------++++++++--------++++++++
!     ELEMENT CBAR      TYPE =  34  BR GRIDS =       2 TOTAL = ETC...
!
!       RECORD  COLUMNS    CONTENT                             FORMAT
!       ------  -------  -----------------------------------------------
!          2      1- 8   'ELEMENT '                          8 LETTERS
!                 9-16   ELEMENT NAME                             2A4
!                17-24   '  TYPE ='                          8 LETTERS
!                25-28   ELEM. TYPE NO. ACCORDING TO GPTABD        I4
!                29,30   BLANK                                     2X
!                31-32   ELEMENT SYMBOL                            A2
!                33-40   ' GRIDS ='                          8 LETTERS
!                41-48   NO. OF GRIDS PER ELEMENT                  I8
!                49-56   ' TOTAL ='                          8 LETTERS
!                57-64   TOTAL NO. OF ELEMENTS OF THIS ELEM. TYPE  I8
!                65-72   ' WDS/EL='                          8 LETTERS
!                73-80   NO. OF WORDS PER ELEMENT IN NEXT RECORDS  I8
!                81-88   ' LINES ='                          8 LETTERS
!                89-96   NO. OF LINES (RECORDS) NEEDED ON NEXT     I8
!                        RECORD FOR THIS ELEMENT TYPE
!
!     ELEMENT RECORD
!     THERE SHOULD BE (TOTAL X LINES) RECORDS IN THIS GROUP
!
!       RECORD  WORD      CONTENT                               FORMAT
!       ------  ----     -----------------------------------------------
!          3      1       ELEMENT ID                               I8
!                 2       POSITIVE INTEGER  = PROPERTY ID          I8
!                         ZERO IF ELEM HAS NO PROPERTY ID
!                         NEGATIVE INTEGER  = MATERIAL ID (ELEMENT HAS
!                            NO PROPERTY ID, BUT IT HAS A MATERIAL ID)
!                 3       0 (NOT USED. RESERVED FOR FUTURE USE)    I8
!              4,5,...16  FIRST 13 EXTERNAL CONNECTING GRID PTS.  13I8
!          4              (IF NEEDED)
!              1,2,...15  NEXT 15 GRID POINTS                  8X,15I8
!          5              (IF NEEDED)
!              1,2,...15  MORE GRID POINTS                     8X,15I8
!
!
!     REPEAT FORMATTED RECORD 3 (AND POSSIBLE 4 AND 5) AS MANY TIMES AS
!     THERE ARE ELEMENTS
!
            WRITE (outtp,99031) (z(j+jbm1),j=1,8)
            i = jb + 8
            SPAG_Loop_1_1: DO j = 9 , nwds , ng3
               je = i + ng3 - 1
               IF ( ng3>16 ) THEN
                  j16 = i + 15
                  j17 = i + 16
                  WRITE (outtp,99033,ERR=460) (z(k),k=i,j16)
                  IF ( ng3>31 ) THEN
                     j31 = i + 30
                     j32 = i + 31
                     WRITE (outtp,99032,ERR=460) (z(k),k=j17,j31)
                     WRITE (outtp,99032,ERR=460) (z(k),k=j32,je)
                  ELSE
                     WRITE (outtp,99032,ERR=460) (z(k),k=j17,je)
                     EXIT SPAG_Loop_1_1
                  ENDIF
               ELSE
                  WRITE (outtp,99033,ERR=460) (z(k),k=i,je)
               ENDIF
               i = je + 1
            ENDDO SPAG_Loop_1_1
         ELSE
            k = jb + 7
            WRITE (outtp) (z(j),j=jb,k)
            i = k + 1
            k = nwds + jb - 1
            WRITE (outtp) (z(j),j=i,k)
         ENDIF
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
 180     CALL close(scr1,rew)
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
!
!
!     LAST RECORD FOR ELEMENT DATA, UNFORMATTED AND FORMATTED
!
!     --------++++++++--------++++++++--------++++++++--------++++++++
!     ELEMENT -END-     TYPE =   0  -- GRIDS =       0 TOTAL =  ETC...
!
 200     CALL close(geom2,rew)
         DO i = 3 , 8
            nam(i) = 0
         ENDDO
         nam(1) = end1
         nam(2) = end2
         nam(4) = end3
         IF ( .NOT.fmttd ) WRITE (outtp) nam
         IF ( fmttd ) WRITE (outtp,99031) nam
!
!
!     PROCESS OFP DATA BLOCKS   SIGNITURE
!     =======================   =========
!       DISPLACEMENT                 1
!       VELOCITIES                  10
!       ACCELERATIONS               11
!       LOADS                        2
!       GRID POINT OR SPC FORCES     3
!       EIGENVECTORS                 7
!       ELEMENT STRESSES, AND        5
!       ELEMENT STRAIN              21
!       ELEMENT FORCES               4
!
!    (GINO INPUT FILE 105,106,107)
!
 220     ofpset = 0
         ofp = 0
         spag_nextblock_1 = 4
      CASE (4)
!
!     SETUP 500-1000 BIG LOOP FOR 3 OFP DATA BLOCKS
!
         ofp = ofp + 1
         ofpx = cstm + ofp
         nam(1) = ofpx
         CALL rdtrl(nam)
!
!     SKIP CURRENT OFP DATA BLOCK IF IT IS PURGED
!
         IF ( nam(1)<=0 ) GOTO 400
!
         file = ofpx
         CALL open(*400,ofpx,z(buf1),rdrew)
         CALL fwdrec(*380,ofpx)
         jos = 2*ofpset + 1
         ofpset = ofpset + 1
         CALL fname(ofpx,oname(jos))
         IF ( basc .AND. nobgpt .AND. .NOT.nocstm ) THEN
!
            WRITE (nout,99006) uim
99006       FORMAT (A29,' FROM DATABASE MODULE - DISPLACEMENT VECTORS REMAIN',' IN GLOBAL COOR. SYSTEM',/5X,                        &
                   &'DUE TO BGPDT OR CSTM FILE BEING PURGED',/)
            basc = .FALSE.
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ELSE
            IF ( nobgpt .OR. nocstm ) basc = .FALSE.
            kount = 0
         ENDIF
         spag_nextblock_1 = 5
      CASE (5)
         kount = kount + 1
         file = ofpx
         DO i = 1 , 6
            f8(i) = 0
         ENDDO
!
!     IDENTIFY CURRENT OFP DATA BLOCK IS A DISPLACEMENT FILE OR A NON-
!     DISPLACEMENT FILE
!
         CALL read(*380,*380,ofpx,a,10,0,flag)
         dspl = mod(a(2),100)
         nwds = a(10)
         dxx = blk8
         IF ( nwds==8 .OR. nwds==14 ) THEN
!
!     CURRENT OFP DATA BLOCK IS A DISPLACEMENT FILE
!
            CALL bckrec(ofpx)
            IF ( dspl==1 ) dxx = dis
            IF ( dspl==2 ) dxx = lod
            IF ( dspl==3 ) dxx = forc
            IF ( dspl==7 .OR. dspl==14 ) dxx = eign
            IF ( dspl==15 .OR. dspl==10 ) dxx = velo
            IF ( dspl==16 .OR. dspl==11 ) dxx = acc
            IF ( dxx/=blk8 ) THEN
               f(1) = 1
               f(2) = 1
               DO i = 3 , nwds
                  f(i) = 2
               ENDDO
               f8(1) = 11222222
               kk = 1
               na4 = 22
               IF ( nwds/=8 ) THEN
                  f8(2) = 22222200
                  kk = 2
                  na4 = 40
               ENDIF
               spag_nextblock_1 = 6
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
!
!     CURRENT OFP DATA BLOCK IS STRESS OR EL FORCE FILE.
!     THE DATA RECORDS HAVE VARIABLE LENGTH (I.E NWDS IS NOT A CONSTANT
!     OF 8 OR 14)
!     CONSTRUCT THE FORMAT CODE IN F AND F8
!           1 = INTEGER
!           2 = REAL
!           3 = BCD
!     AND TURN OFF GLOBAL TO BASIC CONVERSION FLAG BASC
!
         IF ( dspl==4 ) dxx = elf
         IF ( dspl==5 ) dxx = str
         IF ( dxx==blk8 ) THEN
            spag_nextblock_1 = 10
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( nwds>limaf ) THEN
            WRITE (nout,99040) uim , oname(jso) , oname(jso+1)
            WRITE (nout,99007) limaf
99007       FORMAT (5X,'THE A AND F WORKING ARRAYS OF',I4,' WORDS IN DBASE ','SUBROUTINE ARE NOT BIG ENOUGH TO RECEIVE OFP DATA.')
            spag_nextblock_1 = 12
            CYCLE SPAG_DispatchLoop_1
         ELSEIF ( basc ) THEN
            WRITE (nout,99040) uim , oname(jso) , oname(jso+1)
            WRITE (nout,99008)
99008       FORMAT (5X,'ELEMENT STRESSES OR FORCES CAN NOT BE OUTPUT IN ','BASIC COORDINATES AS REQUESTED')
            CALL close(ofpx,rew)
            GOTO 400
         ELSE
            efs = .TRUE.
            CALL fwdrec(*380,ofpx)
            CALL read(*380,*380,ofpx,a,nwds,0,flag)
            DO i = 1 , nwds
               j = numtyp(a(i))
               IF ( j==0 .AND. i>1 ) j = f(i-1)
               f(i) = j
            ENDDO
            IF ( debug ) WRITE (nout,99034) nwds , (f(i),i=1,nwds)
            again = 0
            CALL read(*380,*240,ofpx,a,nwds,0,flag)
            DO i = 1 , nwds
               j = numtyp(a(i))
               IF ( f(i)/=j ) THEN
                  IF ( j/=0 ) f(i) = -j
                  again = 1
               ENDIF
            ENDDO
            IF ( again/=0 ) THEN
               CALL read(*380,*240,ofpx,a,nwds,0,flag)
               DO i = 1 , nwds
                  IF ( f(i)<=0 ) THEN
                     j = numtyp(a(i))
                     IF ( j/=0 ) f(i) = j
                  ENDIF
               ENDDO
               imhere = 560
               IF ( debug ) WRITE (nout,99034) imhere , (f(i),i=1,nwds)
            ENDIF
         ENDIF
 240     f(nwds+1) = -9
         CALL bckrec(ofpx)
         CALL bckrec(ofpx)
         na4 = 0
         kk = 0
         DO i = 1 , nwds , 8
            kk = kk + 1
            k = i + 7
            IF ( k>nwds ) k = nwds
            l = 10000000
            DO j = i , k
               f8(kk) = f8(kk) + f(j)*l
               na4 = na4 + f(j) + 1
               IF ( f(j)==3 ) na4 = na4 - 3
               l = l/10
            ENDDO
         ENDDO
         IF ( debug ) WRITE (nout,99009) na4 , (f8(i),i=1,kk)
99009    FORMAT (/,'  NA4 =',I4,'  FORMAT CODE/@590 =',6I10)
         spag_nextblock_1 = 6
      CASE (6)
!
         IF ( kount<=1 ) THEN
            IF ( .NOT.fmttd ) WRITE (outtp) dxx , dash
            IF ( fmttd ) WRITE (outtp,99030) dxx , dash
         ENDIF
!
         IF ( ecxyz ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ecxyz = .TRUE.
         ncstm = 0
         nsub = 0
         IF ( .NOT.basc ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     DISPLACEMENT OFP FILE IS PRESENT, USER IS REQUESTING DISPLACEMENT
!     OUTPUT.
!
!     REMEMBER, WE STILL HAVE THE EXT-INT GRID TABLE IN Z(1) THRU Z(NEQ)
!     IN INTERNAL GIRD NUMBER (2ND WORD OF THE EXT-INT PAIR) SORT.
!     NOW, OPEN BGPDT, READ IN THE BASIC GRID POINT DATA (4 WORDS EACH
!     GRID) AND ADD THE EXTERNAL GRID POINT ID IN FRONT OF THE DATA SET.
!     THUS WE CREATE A NEW TABLE AFTER THE EXT-INT TABLE.
!
!     THE FOLLOWING 5 DATA WORDS FOR EACH GRID POINT:
!            EXTERNAL GRID ID
!            COORDINATE SYSTEM ID
!            X,Y,Z COORDINATES, IN BASIC COORD. SYSTEM
!
!     MOVE THIS NEW TABLE TO THE BEGINNING OF OPEN CORE SPACE
!     OVERWRITING THE OLD EXT-INT TABLE WHICH HAS NO LONGER NEEDED,
!     FROM Z(1) THRU Z(NBGT)
!     SORT THIS NEW TABLE BY THE EXTERNAL GRID NUMBERS.
!
         file = bgpdt
         CALL open(*420,bgpdt,z(buf2),rdrew)
         CALL fwdrec(*420,bgpdt)
         k = -1
         j = jb
         DO
            CALL read(*260,*260,bgpdt,z(j+1),4,0,flag)
            k = k + 2
            z(j) = z(k)
            j = j + 5
         ENDDO
 260     CALL close(bgpdt,rew)
         IF ( k+1/=neq ) CALL mesage(-61,0,0)
         nbgt = j - jb
         nbg5 = nbgt/5
         DO j = 1 , nbgt
            z(j) = z(j+jbm1)
         ENDDO
         CALL sort(0,0,5,1,z(1),nbgt)
         IF ( debug ) WRITE (nout,99010) (z(j),z(j+1),rz(j+2),rz(j+3),rz(j+4),j=1,nbgt,5)
99010    FORMAT (/11X,'EXT.GRID - COOR - X,Y,Z/@640',/,(10X,2I8,3E11.4))
!
!     OPEN CSTM FILE IF IT EXISTS.  SAVE ALL COORDINATE TRANSFORMATION
!     MATRICES IN THE OPEN CORE SPACE IN Z(ICSTM) THRU Z(NCSTM), EITHER
!     AFTER THE EXT-COORD-X,Y,X TABLE, OR IN FRONT OF THE TABLE
!
         icstm = nbgt + 1
         ncstm = nbgt
         file = cstm
         CALL open(*420,cstm,z(buf2),rdrew)
         CALL fwdrec(*420,cstm)
         CALL read(*280,*280,cstm,z(icstm),left,1,flag)
         CALL mesage(-8,0,sub)
 280     CALL close(cstm,rew)
         ncstm = ncstm + flag
         CALL pretrs(z(icstm),flag)
         spag_nextblock_1 = 7
      CASE (7)
!
!     NOW READ THE DISPLACMENT VECTORS (SUBCASES) FROM CURRENT OFP DATA
!     BLOCK, COMPUTE THE DISPLACEMENT FROM THE DISPLACMENT COORDINATE
!     BACK TO SYSTEM BASIC COORDINATE. SAVE THE VECTOR IN SCR1 FOR RE-
!     PROCESSING LATER.
!
!     2 (3 IF COMPLEX DATA) RECORDS PER ELEMENT TYPE,
!     SAME FORMAT AS GINO OUGV1 FILE
!
!     UNFORMATTED TAPE -
!
!     HEADER RECORD (UNFORMATTED)
!
!        RECORD  WORD       CONTENT (UNFORMATTED)
!        ------  ----   -----------------------------------------------
!           1      1     SUBCASE OR MODE NUMBER, INTEGER
!                  2     ZERO OR FREQUENCY, REAL
!                  3     NWDS, NUMBER OF WORDS PER ENTRY IN NEXT RECORD,
!                        INTEGER. (=8 FOR REAL DATA, OR =14 FOR COMPLEX
!                        FOR ALL DISPLACEMENT RECORDS)
!                 4-5    ORIGINAL GINO FILE NAME, BCD
!                 6-7    ' BASIC  '  OR 'GLOBAL  ', BCD
!                8-13    FORMAT CODE FOR NEXT RECORD, INTEGER
!                        8 DIGITS PER WORD,  1 FOR INTEGER
!                                            2 FOR REAL
!                        EX.  13222222       3 FOR BCD
!                                            0 NOT APPLICABLE
!               14-45    TITLE,    BCD
!               46-77    SUBTITLE, BCD
!              78-109    LABEL,    BCD
!
!     DISPLACEMENT RECORDS (UNFORMATTED)
!
!        RECORD  WORD       CONTENT (UNFORMATTED)
!        ------  ----   -----------------------------------------------
!           2      1     LENGTH, THIS FIRST WORD EXCLUDED, OF THIS
!                        RECORD (INTEGER)
!                  2     EXTERNAL GRID POINT NUMBER (INTEGER)
!                  3     POINT TYPE (1=GRID  PT.  2=SCALAR PT.
!                                    3=EXTRA PT.  4=MODAL  PT., INTEGER)
!                4-9     DISPLACEMENTS (REAL PARTS, REAL
!                        T1,T2,T3,R1,R2,R3)
!               10-15    (COMPLEX DATA ONLY)
!                        DISPLACEMENTS (IMGAGINARY PARTS, REAL
!                        T1,T2,T3,R1,R2,R3)
!                  :     REPEAT WORDS 2 THRU 9 (OR 15) AS MANY TIMES AS
!                        THERE ARE GRID POINT DISPLACEMENT DATA
!           :      :     REPEAT RECORD 2 AS MANY TIMES AS THERE ARE
!                        SUBCASES (OR MODES)
!
!
!     FORMATTED TAPE -
!
!     HEADER RECORD (FORMATTED)
!
!        RECORD   WORD      CONTENT (FORMATTED)                   FORMAT
!        ------   ----   -----------------------------------------------
!           1      1-2    ' CASE = ' OR ' MODE = '             8-LETTERS
!                    3    SUBCASE NUMBER                             I8
!                    4    ZERO OR FREQUENCY                     1P,E12.5
!                  5-6    ' WORDS ='                           8-LETTERS
!                    7    NWDS, NUMBER OF WORDS PER ENTRY IN NEXT    I8
!                         RECORD (=8 FOR REAL DATA, OR =14 COMPLEX,
!                         FOR ALL DISPLACEMENT RECORDS)
!                  8-9    ' INPUT ='                           8-LETTERS
!                10-11    ORIGINAL GINO FILE NAME                   2A4
!                12-13    ' COORD ='                           8-LETTERS
!                14-15    ' BASIC  ' OR 'GLOBAL  '                  2A4
!                16-17    '  CODE ='                           8-LETTERS
!                18-23    FORMAT CODE                               6I8
!                         8 DIGITS PER WORD,  1 FOR INTEGER
!                                             2 FOR REAL
!                         EX.  13222200       3 FOR BCD
!                                             0 NOT APPLICABLE
!                   23    NA4, NUMBER OF WORDS PER ENTRY IN NEXT    (I8)
!                         RECORD, IN A4-WORD COUNT (ONLY IF THE
!                         LAST FORMAT CODE WORD IS NOT USED)
!           2     1-32    TITLE,    32 BCD WORDS                   32A4
!           3    33-64    SUBTITLE, 32 BCD WORDS                   32A4
!           4    65-96    LABEL,    32 BCD WORDS                   32A4
!               (95-96    ELEMENT ID, STRESS AND FORCE ONLY         2A4)
!
!
!     DISPLACEMENT RECORDS (FORMATTED)
!
!        RECORD   WORD      CONTENT (FORMATTED)                   FORMAT
!        ------   ------------------------------------------------------
!           5       1     EXTERNAL GRID POINT NUMBER                 I8
!                   2     POINT TYPE (1=GRID  PT.  2=SCALAR PT.      I8
!                                     3=EXTRA PT.  4=MODAL  PT.)
!                 3-8     DISPLACEMENTS (REAL PARTS,         6(1P,E12.5)
!                         T1,T2,T3,R1,R2,R3)
!           6             (COMPLEX DATA ONLY)
!                 1-6     DISPLACEMENTS (IMAGINARY PARTS,    6(1P,E12.5)
!                         T1,T2,T3,R1,R2,R3)
!           :       :     REPEAT RECORD 5 (OR RECORDS 5 AND 6) AS MANY
!                         TIMES AS THERE ARE GRID POINT DISPLACMENT DATA
!         LAST      1     MINUS 0                                    I8
!                   2     MINUS 0                                    I8
!                 3-8     ZEROS                              6(1P,E12.5)
!        LAST+1           (COMPLEX DATA ONLY)
!                 1-6     ZEROS                              6(1P,E12.5)
!
!     IF CURRENT OFP DATA BLOCK IS AN ELEMENT STRESS OR ELEMENT FORCE
!     FILE, THE STRESS OR FORCE DATA HAVE VARIABLE LENGTH. (NWDS IS NO
!     LONGER 8 OR 14.)
!
!     THE ELEMENT STRESS OR FORCE RECORDS -
!
!        RECORD   WORD      CONTENT (UNFORMATTED)
!        ------   ------------------------------------------------------
!           2       1      NO. OF WORDS, EXCLUDING THIS FIRST WORD,
!                          IN THIS RECORD. (INTEGER)
!               2-NWDS+1   ELEMENT ID, STRESS OR FORCE DATA
!                          (VARIABLE DATA TYPES ARE DESCRIBED IN 'CODE')
!                   :      REPEAT (2-NWDS+1) WORDS AS MANY TIMES AS
!                          THERE ARE ELEMENTS
!           :       :      REPEAT RECORD 2 AS MANY TIMES AS THERE ARE
!                          SUBCASES.
!
!         WHERE NWDS IS THE NUMBER OF COMPUTER WORDS PER ENTRY, AND
!               CODE IS THE 6-WORD FORMAT CODE, AS DESCRIBED IN THE
!               HEADER RECORD.
!
!
!        RECORD   WORD      CONTENT (FORMATTED)                   FORMAT
!        ------   ------------------------------------------------------
!           5     1-NA4     ELEMENT ID, STRESS OR FORCE DATA       33A4
!                           (THE DATA TYPES ARE DESCRIBED IN
!                           'CODE'; ALL INTEGERS IN 2A4, REAL
!                           NUMBERS IN 3A4, AND BCD IN A4)
!           :       :       (MAXIMUM RECORD LENGTH IS 132 COLUMNS (33A4)
!                           CONTINUATION AND FOLDED INTO NEXT
!                           RECORD(S) IF NECESSARY.
!           :       :       A CARRIAGE CONTROL WORD ALWAYS PRECEEDS
!                           AN OUTPUT RECORD. THUS 1+132=133 COLUMNS
!                           LAST DATA VALUE ON A RECORD MAY SPILL
!                           TO THE NEXT RECORD)
!           :       :       REPEAT ABOVE RECORD(S) AS MANY TIMES
!                           AS THERE ARE ELEMENTS.
!
!         WHERE NA4 IS THE NUMBER OF WORDS PER ENTRY IN A4-WORD COUNT,
!               AND CODE IS 5-WORD FORMAT CODE
!
         file = ofpx
         iougv = ncstm + 1
         CALL read(*380,*300,ofpx,z(iougv),nz-iougv,1,flag)
         CALL mesage(-37,file,sub)
 300     IF ( flag/=146 ) THEN
            spag_nextblock_1 = 11
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         dspl = mod(z(iougv+1),100)
         nwds = z(iougv+9)
         IF ( .NOT.efs .AND. nwds/=8 .AND. nwds/=14 ) THEN
            spag_nextblock_1 = 11
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         nsub = nsub + 1
         camo = ca
         case = z(iougv+3)
         freq = 0.0
         IF ( dspl==7 .OR. dspl==14 ) THEN
            camo = mo
            case = z(iougv+4)
            freq = rz(iougv+5)
         ENDIF
         bagl = ba
         IF ( .NOT.basc ) bagl = gl
         IF ( fmttd .AND. f8(6)==0 ) f8(6) = na4
         IF ( efs ) THEN
            j = (z(iougv+2)-1)*incr
            z(iougv+144) = e(j+1)
            z(iougv+145) = e(j+2)
         ENDIF
         IF ( .NOT.fmttd ) WRITE (outtp) case , freq , nwds , oname(jos) , oname(jos+1) , f8 , (z(j+iougv),j=50,145)
         IF ( fmttd ) WRITE (outtp,99035) camo , case , freq , nwds , oname(jos) , oname(jos+1) , bagl , f8 , (z(j+iougv),j=50,145)
         IF ( .NOT.(fmttd) ) THEN
            file = scr1
            CALL open(*420,scr1,z(buf2),wrtrew)
            file = ofpx
         ENDIF
         spag_nextblock_1 = 8
      CASE (8)
         CALL read(*360,*320,ofpx,a,nwds,0,flag)
         a(1) = a(1)/10
         IF ( .NOT.(efs) ) THEN
            IF ( debug ) WRITE (nout,99011) a(1)
99011       FORMAT (10X,'EXT.GRID/@740 =',I8)
            IF ( basc ) THEN
!
!     INTERNAL ROUTINE TO SEARCH FOR THE EXTERNAL GRID POINT AND RETURN
!     THE DISPLACEMENT COORDINATE ID ASSOCIATE WITH THAT POINT, AND SET
!     THE POINTER TO WHERE THE COORDINATE TRANSFORMATION MATRIX DATA
!     BEGINS.
!     EXTERNAL GRID VS. COORD SYSTEM ID TABLE IN Z(1) THRU Z(NEQ), IN
!     EXTERNAL GRID SORT
!     THE COORDINATE TRANSFORMATION MATRICES IN Z(ICSTM) THRU Z(NCSTM),
!     (14 WORDS PER MATRIX, FROM GLOBAL TO BASIC)
!
               grid = a(1)
               klo = 0
               khi = nbg5
               lastk = 0
               SPAG_Loop_1_2: DO
                  k = (klo+khi+1)/2
                  IF ( lastk==k ) CALL mesage(-61,0,0)
                  lastk = k
                  k5 = k*5
                  IF ( grid<z(k5-4) ) THEN
                     khi = k
                  ELSEIF ( grid==z(k5-4) ) THEN
                     coor = z(k5-3)
                     IF ( coor>0 ) THEN
                        CALL transs(z(k5-3),t)
                        IF ( debug ) THEN
                           WRITE (nout,99012) grid , coor , t
99012                      FORMAT (20X,'EXT GRID, COORD.ID AND TRANSF.MATRIX/@1250 =',2I8,/,(25X,3E13.5))
                        ENDIF
                     ENDIF
                     EXIT SPAG_Loop_1_2
                  ELSE
                     klo = k
                  ENDIF
               ENDDO SPAG_Loop_1_2
            ENDIF
            IF ( coor>0 ) THEN
!
!     TRANSFORM THE DISPLACEMENT VECTOR FROM GLOBAL TO BASIC
!     UPON RETURN FROM 800, TRANSFORMATION MATRIX IN T
!
               DO i = 3 , nwds
                  rx(i) = ra(i)
               ENDDO
               cmplx = 0
               SPAG_Loop_1_3: DO
                  CALL gmmats(t,3,3,0,rx(3),3,1,0,ra(3+cmplx))
                  CALL gmmats(t,3,3,0,rx(6),3,1,0,ra(6+cmplx))
                  IF ( nwds/=14 .OR. cmplx==6 ) EXIT SPAG_Loop_1_3
                  cmplx = 6
                  DO i = 3 , 8
                     rx(i) = rx(i+cmplx)
                  ENDDO
               ENDDO SPAG_Loop_1_3
            ENDIF
         ENDIF
!
!     WRITE THE 8 (OR 14) DATA WORDS OUT TO SCR1 FILE IF OUTTP IS
!     UNFORMATTED, OR WRITE TO OUTTP DIRECTLY IF OUTTP IS FORMATTED
!
         IF ( .NOT.(fmttd) ) THEN
            CALL write(scr1,a,nwds,0)
            spag_nextblock_1 = 8
            CYCLE SPAG_DispatchLoop_1
         ELSEIF ( efs ) THEN
!
!     ELEMENT STRESS AND ELEMENT FORCE HAVE MIXED DATA, CHANGE THEM ALL
!     TO BCD WORDS, AND WRITE THEM OUT TO OUTTP UNDER A4 FORMAT
!     MAXIMUM OF 132 COLUMNS PER LINE.
!     NOTE - LAST DATA VALUE ON OUTPUT LINE MAY SPILL INTO NEXT RECORD.
!
            l = 0
            k = 0
            DO
               k = k + 1
               IF ( f(k)==-9 ) THEN
                  WRITE (outtp,99036,ERR=460) (ix(k),k=1,l)
                  spag_nextblock_1 = 8
                  CYCLE SPAG_DispatchLoop_1
               ELSEIF ( l+3>limrx ) THEN
                  WRITE (nout,99040) uim , oname(jso) , oname(jso+1)
                  WRITE (nout,99013) limrx
99013             FORMAT (5X,'THE RX WORKING ARRAY OF',I5,' WORDS IN DBASE ','SUBROUTINE IS NOT BIG ENOUGH TO RECEIVE OFP DATA.')
                  spag_nextblock_1 = 12
                  CYCLE SPAG_DispatchLoop_1
               ELSE
                  CALL ifb2ar(f(k),a(k),ix,l)
               ENDIF
            ENDDO
         ELSE
            WRITE (outtp,99014,ERR=460) a(1) , a(2) , (ra(k),k=3,8)
99014       FORMAT (1X,2I8,6(1P,E12.5))
            IF ( nwds==14 ) WRITE (outtp,99037,ERR=460) (ra(k),k=9,14)
            spag_nextblock_1 = 8
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!
!     JUST FINISH ONE VECTOR
!
!     UNFORMATTED TAPE -
!     TRANSFER THIS VECTOR FROM SCR1 TO OUTTP IN ONE LONG RECORD
!     (NO ZERO RECORD)
!     LOOP BACK FOR NEXT VECTOR
!
 320     IF ( fmttd ) THEN
!
!     FORMATTED TAPE -
!     (DISPLACEMENTS ALREDY WRITTEN OUT IN SHORT RECORDS)
!     WRITE A ZERO RECORD
!     AND LOOP BACK FOR NEXT VECTOR
!
            IF ( efs ) THEN
!
!     WRITE A ZERO RECORD FOR EL.STRESS OR EL.FORCE TYPE OF DATA
!
               l = 0
               DO i = 1 , nwds
                  ix(l+2) = blank
                  fi = f(i)
                  IF ( fi==2 ) THEN
                     ix(l+1) = bzero
                     ix(l+3) = blank
                     l = l + 3
                  ELSEIF ( fi==3 ) THEN
                     l = l + 1
                  ELSE
                     ix(l+1) = izero
                     l = l + 2
                  ENDIF
               ENDDO
               WRITE (outtp,99036,ERR=460) (ix(i),i=1,l)
            ELSE
               DO i = 1 , 6
                  rx(i) = 0.0
               ENDDO
               WRITE (outtp,99015,ERR=460) (rx(i),i=1,6)
99015          FORMAT (1X,2(6X,2H-0),6(1P,E12.5))
               IF ( nwds==14 ) WRITE (outtp,99037,ERR=460) (rx(i),i=1,6)
            ENDIF
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ELSE
            CALL write(scr1,0,0,1)
            CALL close(scr1,rew)
            file = scr1
            CALL open(*420,scr1,z(buf2),rdrew)
            CALL read(*340,*340,scr1,z(iougv+1),nz-iougv,1,k)
            CALL mesage(-8,file,sub)
         ENDIF
 340     CALL close(scr1,rew)
         z(iougv) = k
         kiougv = k + iougv
         WRITE (outtp) (z(j),j=iougv,kiougv)
         spag_nextblock_1 = 5
         CYCLE SPAG_DispatchLoop_1
!
!     END OF CURRENT OFP FILE
!     ADD AN ENDING RECORD TO OUTTP FILE AND ENDFILE
!
 360     CALL close(scr1,rew)
 380     CALL close(ofpx,rew)
!
         dyy(ofpset) = dxx
         subn(ofpset) = nsub
         case = 0
         freq = 0.0
         z(1) = 0
         j = 0
         z(j+2) = end1
         z(j+3) = end2
         z(j+4) = blank
         DO j = 5 , 10
            z(j) = 0
         ENDDO
         DO j = 11 , 106
            z(j) = blank
         ENDDO
         IF ( .NOT.fmttd ) WRITE (outtp) case , freq , (z(j),j=1,106)
         IF ( fmttd ) WRITE (outtp,99035,ERR=460) camo , case , freq , (z(j),j=1,106)
 400     IF ( ofp<3 ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     JOB DONE. WRITE A USER FRIENDLY MESSAGE OUT
!
         ENDFILE outtp
         REWIND outtp
         set = ofpset
         IF ( .NOT.nobgpt ) set = set + 1
         IF ( .NOT.nogeom ) set = set + 1
         j = blank
         IF ( set>1 ) j = ls
         k = 3 + 2*set
         CALL page2(k)
         IF ( outtp>12 ) THEN
            nam(1) = inpx(1)
            nam(2) = outtp - 14
            IF ( outtp==14 .OR. outtp==25 ) THEN
               WRITE (nout,99038) uim , set , j , inpx(2)
               spag_nextblock_1 = 9
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ELSE
            nam(1) = inpx(3)
            nam(2) = outtp - 10
         ENDIF
         WRITE (nout,99038) uim , set , j , nam(1) , nam(2)
         spag_nextblock_1 = 9
      CASE (9)
         WRITE (nout,99016) outtp , fmt
99016    FORMAT (1H+,85X,'(FORTRAN UNIT',I3,1H),4A4)
         set = 0
         IF ( .NOT.(nobgpt) ) THEN
            set = set + 1
            WRITE (nout,99017) set
99017       FORMAT (/4X,I2,'. GRID POINT DATA - EXTERNAL NUMBERS AND BASIC ','RECTANGULAR COORDINATES')
         ENDIF
         IF ( .NOT.(nogeom) ) THEN
            set = set + 1
            WRITE (nout,99018) set
99018       FORMAT (/4X,I2,'. ELEMENT CONNECTIVITY DATA - ALL GRID POINTS ','ARE EXTERNAL NUMBERS')
         ENDIF
         IF ( ofpset==0 ) THEN
!
            WRITE (nout,99039)
            RETURN
         ELSE
            jso = 1
            DO j = 1 , ofpset
               spag_nextblock_2 = 1
               SPAG_DispatchLoop_2: DO
                  SELECT CASE (spag_nextblock_2)
                  CASE (1)
                     set = set + 1
                     nsub = subn(j)
                     WRITE (nout,99019) set , dyy(j) , oname(jso) , oname(jso+1)
99019                FORMAT (/4X,I2,2H. ,A8,' DATA FROM INPUT FILE ',2A4)
                     IF ( .NOT.(efs) ) THEN
                        IF ( basc ) WRITE (nout,99020)
99020                   FORMAT (1H+,46X,', CONVERTED TO BASIC RECT. COORDINATES,')
                        IF ( .NOT.basc ) WRITE (nout,99021)
99021                   FORMAT (1H+,46X,', IN NASTRAN GLOBAL COORDINATE SYSTEM,')
                        IF ( dspl==7 .OR. dspl==14 ) THEN
                           WRITE (nout,99022) nsub
99022                      FORMAT (1H+,87X,I4,' FRQUENCIES')
                           spag_nextblock_2 = 2
                           CYCLE SPAG_DispatchLoop_2
                        ENDIF
                     ENDIF
                     IF ( .NOT.efs ) WRITE (nout,99023) nsub
99023                FORMAT (1H+,87X,I4,' SUBCASES')
                     IF ( efs ) WRITE (nout,99024) nsub
99024                FORMAT (1H+,46X,I4,' SUBCASES')
                     spag_nextblock_2 = 2
                  CASE (2)
                     IF ( nobgpt .AND. nogeom ) WRITE (nout,99039)
                     jso = jso + 2
                     EXIT SPAG_DispatchLoop_2
                  END SELECT
               ENDDO SPAG_DispatchLoop_2
            ENDDO
            RETURN
         ENDIF
      CASE (10)
!
!     ILLEGITIMATE DATA IN OUGV FILE, ADVANCE TO NEXT RECORD
!
         CALL fwdrec(*380,ougv)
         CALL fwdrec(*380,ougv)
         spag_nextblock_1 = 5
         CYCLE SPAG_DispatchLoop_1
!
!     ERRORS
!
 420     j = -1
         spag_nextblock_1 = 13
         CYCLE SPAG_DispatchLoop_1
 440     j = -2
         spag_nextblock_1 = 13
      CASE (11)
         WRITE (nout,99040) uim , oname(jso) , oname(jso+1)
         WRITE (nout,99025) nwds
99025    FORMAT (5X,'THE REQUEST OF AN ILLEGITIMATE DATA BLOCK.',7X,'NO. OF WORDS =',I6)
         CALL close(ofpx,rew)
         GOTO 400
      CASE (12)
         WRITE (nout,99026)
99026    FORMAT (5X,'SUGGESTION - USE OUTPUT5 OR OUTPUT2 TO CAPTURE THE ','REQUESTED DATA BLOCK')
         spag_nextblock_1 = 10
         CYCLE SPAG_DispatchLoop_1
 460     WRITE (nout,99027)
99027    FORMAT ('0*** SYSTEM FATAL ERROR WRITING FORMATTED TAPE IN DATA','BASE MODULE')
         IF ( mach==3 ) WRITE (nout,99028)
99028    FORMAT (5X,'IBM USER - CHECK FILE ASSIGNMENT FOR DCB PARAMETER ','OF 133 BYTES')
         j = -37
         spag_nextblock_1 = 13
      CASE (13)
         CALL mesage(j,file,sub)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
99029 FORMAT (//,' *** USER FATAL ERROR IN DATABASE MODULE, THE ',A4,'INPUT DATA BLOCK ',2A4,' IS ILLEGAL.',/5X,'THE FIRST 4 INPUT',&
             &' DATA BLOCKS MUST BE ''EQEXIN,BGPDT,GEOM2,CSTM'', AND IN ','EXACT ORDER SHOWN')
99030 FORMAT (1X,2A8)
99031 FORMAT (1X,'ELEMENT ',2A4,'  TYPE =',I4,2X,A2,' GRIDS =',I8,' TOTAL =',I8,' WDS/EL=',I8,' LINES =',I8)
99032 FORMAT (1X,8X,15I8)
!
!     320  FORMAT (1X,16I8,/,(1X,8X,15I8))
!     THIS FORMAT MAY CAUSE AN EXTRA LINE IN SOME MACHINE IF NG3=16
!
99033 FORMAT (1X,16I8)
99034 FORMAT (/,' NWDS/@540=',I3,' F=',50I2,/,(14X,50I2))
99035 FORMAT (1X,A8,I8,1P,E12.5,' WORDS =',I8,' INPUT =',2A4,' COORD =',A8,'  CODE =',6I8,/1X,32A4,/1X,32A4,/1X,32A4)
99036 FORMAT (1X,33A4)
99037 FORMAT (17X,6(1P,E12.5))
99038 FORMAT (A29,' -',/5X,'DATABASE MODULE TRANSFERRED THE FOLLOWING',I3,' SET',A1,' OF DATA TO OUTPUT FILE ',A4,I1)
99039 FORMAT (/6X,'1. NONE')
99040 FORMAT (A29,', DATABASE MODULE SKIPS OUTPUTING ',2A4,' FILE (OR PART OF THE FILE), DUE TO')
!     END
!
!
!     THE FOLLOWING PROGRAM WAS USED TO CHECKOUT THE UNFORMATTED TAPE
!     GENERATED BY DBASE. IT CAN BE SERVED AS A GUIDE TO OTHER USER WHO
!     WANTS TO ABSTRACT DATA FROM THAT TAPE.
!
!
!+    PROGRAM RDBASE
!
!     THIS FORTRAN PROGRAM READS THE UNFORMATTED OUTPUT FILE INP1
!     (FORTRAN UNIT 15) GENERATED BY DATABASE MODULE
!
!     (1) GRID POINTS DATA ARE READ AND SAVED IN GRID-ARRAY
!     (2) ELEMENTS DATA ARE READ AND SAVED IN ELM-ARRAY,
!         WITH ELEMENT NAMES AND POINTERS IN SAVE-ARRAY
!     (3) DISPLACEMENTS (VELOCITIES, ACCELERATIONS, LOADS, GRID-POINT
!         FORCE, OR EIGENVECTORS) DATA ARE READ AND SAVED IN DIS-ARRAY,
!         WITH SUBASES AND POINTERS IN SAVD-ARRAY
!
!     TO READ ELEMENT FORCES OR ELEMENT STRESSES, (3) ABOVE NEEDS SOME
!     CHANGES. PARTICULARLY WE NEED THE INFORMATION IN CODE TO GIVE US
!     THE TYPE OF EACH DATA WORD IN THE DATA LINE.
!     ASSUME CODE(1) = 11222222
!            CODE(2) = 31222000
!     THIS MEANS
!            THE 1ST, 2ND, AND 10TH DATA WORDS ARE INTEGERS;
!            9TH DATA WORD IS BCD; AND
!            3RD THRU 8TH, 11TH, 12TH AND 13TH WORDS ARE REAL NUMBERS
!
!
!     ANY OF ABOVE 3 SETS OF DATA NEED NOT EXIST IN ORIGINAL INP1 FILE
!
!     WRITTEN BY G.CHAN/UNISYS, JAN. 1989
!
!+    IMPLICIT INTEGER (A-Z)
!+    INTEGER          GRID(5,500),ELM(35,300),DIS(11200),SAVE(4,10),
!+   1                 SAVD(3,20),NAME(2),TITLE(32),SUBTTL(32),
!+   2                 LABL(32),CODE(6)
!+    REAL             GRIR(5,1),RIS(1),FREQ
!+    DOUBLE PRECISION GED,GD,EL,DS,ENDD,COORD
!+    EQUIVALENCE      (GRID(1),GRIR(1)),(DIS(1),RIS(1))
!+    DATA             INTAP, NOUT, MAXGRD, MAXELM, MAXDIS, MAXWDS    /
!+   1                 15,    6,    500,    300,    11200,  35        /
!+    DATA             GD,         EL,         DS,          END1      /
!+   1                 8HGRID PTS, 8HELEMENTS, 8HDISPLCNT,  4H -EN    /
!
!+    REWIND INTAP
!
!     READ DATA IDENTICATION RECORD
!
!+ 10 READ (INTAP,END=500) GED
!+    IF (NOUT .EQ. 6) WRITE (NOUT,20) GED
!+ 20 FORMAT (1X,A8,'--------')
!+    IF (GED .EQ. GD) GO TO 100
!+    IF (GED .EQ. EL) GO TO 200
!+    IF (GED .EQ. DS) GO TO 310
!+    STOP 'DATA TYPE UNKNOWN'
!
!     PROCESS GRID DATA
!     =================
!
!     READ GRID POINT DATA, ONE LONG RECORD OF MIXED INTEGERS AND REALS
!
!+100 READ (INTAP,END=500) L,(GRID(J,1),J=1,L)
!+    IF (NOUT .NE. 6) GO TO 10
!+    NGRID = L/5
!+    IF (NGRID .GT. MAXGRD) STOP 'GRID DIMENSION TOO SMALL'
!+    WRITE  (NOUT,110) NGRID
!+110 FORMAT (1X,I8,'=TOTAL NO. OF GRID POINTS')
!+    DO 130 I = 1,NGRID
!+    WRITE (NOUT,120) GRID(1,I),GRID(2,I),GRIR(3,I),GRIR(4,I),GRIR(5,I)
!+120 FORMAT (1X,2I8,3(1P,E12.5))
!+130 CONTINUE
!+    GO TO 10
!
!     PROCESS ELEMENT DATA
!     ====================
!
!+200 JS = 0
!+    JE = 0
!+
!+    READ ELEMENT HEADER RECORD, 8 WORDS
!+
!+210 READ (INTAP,END=500) NAME,TYPE,SYMBOL,GRIDS,TOTAL,WDS,LINE
!+    IF (NAME(1).EQ.END1 .AND. TYPE.EQ.0) GO TO 250
!+    IF (WDS .GT. MAXWDS) STOP 'ELM ROW DIMENSION TOO SMALL'
!+    IF (JE  .GT. MAXELM) STOP 'ELM COL DIMENSION TOO SMALL'
!+    JB = JE + 1
!+    JE = JE + TOTAL
!
!     READ ELEMENT DATA, ONE LONG RECORD PER ELEMENT TYPE (ALL INTEGERS)
!
!+    READ (INTAP) ((ELM(I,J),I=1,WDS),J=JB,JE)
!+    JS = JS + 1
!+    IF (JS .GE. 10) STOP 'SAVE DIMENSION TOO SMALL'
!
!     SAVE ELEMENT NAMES AND BEGINNING POINTERS IN SAVE-ARRAY
!     FOR EASY IDENTIFICATION
!
!+    SAVE(1,JS) = NAME(1)
!+    SAVE(2,JS) = NAME(2)
!+    SAVE(3,JS) = JB
!+    SAVE(4,JS) = WDS
!+    IF (NOUT .NE. 6) GO TO 210
!+    WRITE  (NOUT,220) NAME,TYPE,SYMBOL,GRIDS,TOTAL,WDS,LINE
!+220 FORMAT (1X,'ELEMNT =',2A4,'  TYPE =',I4,2X,A2,' GRIDS =',I8,
!+   1           ' TOTAL =',I8,' WDS/EL=',I8,      ' LINE  =',I8)
!+    DO 240 J = JB,JE
!+    WRITE  (NOUT,230) (ELM(I,J),I=1,WDS)
!+230 FORMAT (1X,3I8,13I8, /,(1X,8X,15I8))
!+240 CONTINUE
!+    GO TO 210
!
!     WRAP UP SAVE-ARRAY
!
!+250 JS = JS + 1
!+    SAVE(1,JS) = END1
!+    SAVE(2,JS) = NAME(2)
!+    SAVE(3,JS) = JE + 1
!+    SAVE(4,JS) = 0
!+    IF (NOUT .NE. 6) GO TO 10
!+    WRITE (NOUT,260)
!+    WRITE (NOUT,270) ((SAVE(I,J),I=1,4),J=1,JS)
!+260 FORMAT (/30X,'THIS REFERENCE TABLE IS NOT PART OF INPUT FILE')
!+270 FORMAT (40X,2A4,3H @ ,I4,',  WORDS=',I3)
!+    GO TO 10
!
!     PROCESS DISPLACEMENT DATA
!     =========================
!
!
!+300 STOP 'ERROR IN READING DISPLACEMENT DATA'
!+
!+310 KB = 1
!+    KS = 0
!
!     READ DISPLACEMENT HEADER RECORD
!
!+320 KS = KS + 1
!+    IF (KS .GT. 20) STOP 'SAVD DEMINSION TOO SMALL'
!+    READ (INTAP,END=390) CASE,FREQ,NWDS,NAME,COORD,CODE,TITLE,SUBTTL,
!+                         LABEL
!+    IF (CASE+NWDS .EQ. 0) GO TO 390
!+    IF (NOUT      .NE. 6) GO TO 340
!+    WRITE  (NOUT,330) CASE,FREQ,NWDS,NAME,COORD,CODE(1),CODE(2),TITLE,
!+                      SUBTTL,LABEL
!+330 FORMAT ('  CASES =',I8,1P,E12.5,' WORDS =',I8,' INPUT =',2A4,
!+   1        '  COORD =',A8,'  CODE = ',2I8, /,(1X,32A4))
!
!     DISPLACEMENT RECORS HAVE EITHER 8 OR 14 WORDS EACH DATA POINT
!     WITH CODE(1)=11222222, CODE(2) THRU (6) ARE ZEROS.
!
!
!     ------------------------------------------------------------------
!     IF ELEMENT STRESS OR ELEMENT FORCE FILE IS READ HERE, NWDS IS A
!     VARIABLE, NOT NECESSARY 8 OR 14. ALL INTEGERS ARE IN 2A4 FORMAT
!     (8-DIGITS), ALL REAL NUMBERS IN 3A4 (12-DIGITS), AND BCD WORD IN
!     A4 (4-LETTERS). THERE ARE NA4 A4-WORDS FOR EACH ELEMENT THAT HOLD
!     NWDS DATA VALUES.  MAXIMUM RECORD LENGTH IS 132 COLUMNS. ONE OR
!     MORE RECORDS ARE NEEDED PER ELEMENT. LAST DATA VALUE OF A RECORD
!     MAY SPILL INTO NEXT RECORD. NA4 IS THE 6TH WORD OF CODE. THE DATA
!     TYPE OF THIS RECORD IS DESCRIBED IN CODE. 1 FOR INTEGER, 2 FOR
!     REAL NUMBER, AND 3 FOR A BCD WORD. THERE ARE 5 CODE WORDS, EACH
!     HOLDS 8 DIGITS, AND ARE ARRANGED FROM LEFT TO RIGHT.
!
!     FOR EXAMPLE -
!     CODE(1)=12212222, CODE(2)=22213200, CODE(3)=CODE(4)=CODE(5)=0
!     INDICATE
!     DATA VALUES 1, 4 AND 12 ARE INTEGERS, DATA VALUE 13 IS ABCD WORD,
!     THE REST ARE REAL NUMBERS.
!     IN THIS EXAMPLE, NWDS SHOULD BE 14,
!                      NA4  SHOULD = 3X2 + 10X3 + 1X1 = 37.
!     2 RECORDS ARE NEEDED, 1ST RECORD 132 CHARACTERS LONG, 2ND RECORD
!     16 CHARACTERS. THESE TWO RECORDS CAN BE READ BY ONE FORTRAN LINE
!
!         READ (INTAP,10) (SS(J),J=1,NA4)
!     10  FORMAT (33A4)                        OR BY
!
!         READ (INTAP,20) IS(1),RS(2),RS(3),IS(4),(RS(J),J=5,11),IS(12)
!         READ (INTAP,30) IS(13),RS(14)
!     20  FORMAT (I8,2F12.0,I8,7F12.0,I8)
!     30  FORMAT (A4,F12.0)
!     ------------------------------------------------------------------
!
!+340 IF (NWDS.NE.8 .AND. NWDS.NE.14) STOP 'WORD COUNT ERROR'
!+    IF (CODE(1) .NE. 11222222) STOP 'FORMAT CODE ERROR'
!
!     SAVE SUBCASE NUMBER AND BEGINNING POINTERS IN SAVD-ARRAY
!     FOR EASY IDENTIFICATION
!
!+    KBM1 = KB - 1
!+    SAVD(1,KS) = CASE
!+    SAVD(2,KS) = KB
!+    SAVD(3,KS) = NWDS
!
!     READ DISPLACEMENT RECORD, ONE LONG RECORD PER SUBCASE (OR FREQ.)
!     EACH GRID POINT DISPLACEMENT DATA IN EVERY 8 OR 14 WORDS,
!     2 INTEGERS + 6 (OR 12) REALS
!
!+350 READ (INTAP,ERR=300) L,(DIS(I+KBM1),I=1,L)
!+    KE = L + KBM1
!+    DO 380 K = KB,KE,NWDS
!+    WRITE (NOUT,360) DIS(K),DIS(K+1),(RIS(K+I),I=2, 7)
!+    IF (NWDS .EQ. 14) WRITE (NOUT,370) (RIS(K+I),I=8,13)
!+360 FORMAT (1X,2I8,6(1P,E12.5))
!+370 FORMAT (1X,16X,6(1P,E12.5))
!+380 CONTINUE
!+    KB = KE + 1
!+    GO TO 320
!
!     WRAP UP SAVD-ARRAY
!
!+390 SAVD(1,KS) = 0
!+    SAVD(2,KS) = KE + 1
!+    SAVD(3,KS) = 0
!+    IF (NOUT .NE. 6) GO TO 10
!+    WRITE (NOUT,260)
!+    WRITE (NOUT,400) (SAVD(1,K),SAVD(2,K),SAVD(3,K),K=1,KS)
!+400 FORMAT (40X,'CASE',I8,3H @ ,I4,',  WORDS=',I4)
!+    GO TO 10
!
!+500 REWIND INTAP
END SUBROUTINE dbase