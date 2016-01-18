      SUBROUTINE INPUT4 (NMAT,UNITX,TAPE,BCDOPT)
C
C     THIS SUBROUTINE IS CALLED ONLY BY INPTT4. IT READS USER-SUPPLIED
C     TAPE (OR DISC FILE), AS GENERATED BY COSMIC or MSC/OUTPUT4 MODULE,
C     AND CREATES THE CORRESPONDING MATRIX DATA BLOCKS.
C
C     INPUTT4 MODULE DOES NOT HANDLE TABLE DATA BLOCKS.
C
C     DUE TO INSUFFICEINT DOCUMENTATION IN MSC USER MANUAL, THIS INPUT4
C     MAY NOT WORK WITH BCD/ASCII DATA AS GENERATED BY MSC/OUTPUT4
C
C     MATRICES CAN BE IN S.P. OR D.P.; DENSE OR SPARSE.
C     NO MATRIX CONVERSION IN THIS ROUTINE
C     i.e. TYPE OF MATRIX OUT = TYPE OF MATRIX IN
C
C     DEFINITION OF DENSE AND SPARSE MATRICES IN THIS SUBROUTINE -
C     DENSE MATRIX IS PROCESSED FROM FIRST TO LAST NONZERO TERMS OF
C     COLUMNS, AND SPARSE MATRIX IS PROCESSED BY STRINGS.
C
C     WRITTEN BY G.CHAN/UNISYS            JUNE  1989
C     LAST REVISION WITH MAJOR CHANGES    MARCH 1993
C
C     NMAT   = NUMBER OF MATRICES (5 MAX) WRITTEN ON USER'S TAPE
C     UNITX  = INPUT TAPE LOGICAL UNIT*, INTEGER, NO DEFAULT
C     TAPE   = TAPE READ CONTROL
C            = 0  NO ADDITIONAL ACTION BEFORE READ
C            =-1  REWIND UNITX  BEFORE READ
C            =-2  REWIND UNITX  AT END
C            =-3  BOTH
C     BCDOPT = 1  INPUT TAPE IN BINARY FORMAT
C            = 2  INPUT TAPE IN ASCII  FORMAT
C                 IF INPUT MATRIX IS IN S.P., I13 IS USED FOR INTEGER,
C                 AND 10E13.6 FOR S.P.REAL DATA
C                 IF INPUT MATRIX IS IN D.P., I16 IS USED FOR INTEGER,
C                 AND 8D16.9 FOR D.P.REAL DATA
C            = 3  SAME AS BCDOPT=2, EXECPT THAT I16 AND 8E16.9 ARE USED
C                 FOR INTEGERS AND S.P.REAL DATA. (BCDOPT=3 IS USED ONLY
C                 IN MACHINES WITH LONG WORDS (60 OR MORE BITS PER WORD)
C           NOTE- MATRIX HEADER RECORD IS NOT AFFECTED BY ABOVE FORMAT
C                 CHANGES. IT IS WRITTEN OUT BY (1X,4I13,5X,2A4)
C     P4     =-4,-2,-1,0,.GE.1, SEE P4 IN INPTT4
C
C     OUTFIL = UP TO 5 OUTPUT GINO DATA BLOCKS (MATRIX ONLY)
C              IF ANY OF THE OUTPUT DB IS PURGED, THE CORRESPONDING
C              MATRIX ON INPUT TAPE WILL BE SKIPPED.
C
C     * LOGICAL UNIT  vs.  GINO FILE NAME
C              ------     ----------------------
C                11        UT1  (CDC ONLY)
C                12        UT2  (CDC ONLY
C                14        INPT (VAX,UNIVAC)
C                15        INP1 (VAX,UNIVAC,IBM)
C                16        INP2      :
C                17        INP3      :
C                 :          :       :
C                23        INP9      :
C                24        INPT (IBM ONLY)
C
C
C     EACH MATRIX WAS WRITTEN AS FOLLOWS (IN BINARY OR ASCII), 4 INTEGER
C     WORDS + FILE NAME
C                1) NO. OF COLUMNS
C                2) NO. OF ROWS
C                3) FORM (NASTRAN  1 TO 8)
C                4) TYPE (NASTRAN  1 TO 4)
C              5,6) FILE NAME (BCD)
C
C     A  RECORD WAS WRITTEN FOR EACH NON-ZERO COLUMN
C        A) DENSE MATRIX:
C                1) COLUMN NO.
C                2) ROW POSITION OF FIRST NON-ZERO ELEMENT
C                3) NO. OF WORDS IN THIS COLUMN, ZEROS INCLUDED, FROM
C                   THE FIRST TO LAST NON-ZERO TERMS.
C                4) DATA VALUES FOR THIS COLUMN (REAL)
C        B) SPARSE MATRIX:
C                1) COLUMN NO.
C                2) ZERO (THIS ZERO IS THE SPARSE MATRIX FLAG)
C                3) NO. OF WORDS IN THIS COLUMN
C                4) DATA OF ONE OR MORE STRINGS.
C
C
C     EXAMPLE 1 - INPUT TAPE INP1 (UNIT 15) CONTAINS 5 MATRICES,
C     =========   WRITTEN BY COSMIC/OUTPUT4, BINARY.
C                 WE WANT TO COPY
C                 FILE 3 TO A,
C                 FILE 4 TO B
C
C     INPUTT4  /,,A,B,/-1/15      $ REWIND, READ & ECHO HEADER RECORD
C
C
C     EXAMPLE 2 - TO COPY THE FIRST 2 FILES OF A UNFORMATTED TAPE INP2
C     =========   (UNIT 16), WRITTEN BY MSC/OUTPUT4, DENSE MATRIX
C
C     INPUTT4  /A,B,,,/-3/16//-4  $
C
C     EXAMPLE 3 - TO COPY THE FIRST 2 FILES OF A FORMATTED ASCII TAPE
C     =========   INPT (UNIT 14), WRITTEN BY COSMIC/OUTPUT4, SPARSE
C                 MATRIX
C
C     INPUTT4  /A,B,,,/-3/-14//1  $
C
C     EXAMPLE 4 - SEE DEMO PROBLEM T00001A TO INPUT VARIOUS DATA BLOCKS
C     =========   (SQUARE, RECTANGULAR, ROW-VECTOR, 'COLUMN' VECOR,
C                 DIAGONAL, IDENTITY, SYMMETRIC) INTO NASTRAN SYSTEM
C                 USING MSC, ASCII FORMAT FILES.
C
C     A NOTE FOR FUTURE IMPROVEMENT, G.CHAN 4/93 -
C     IF INPUT MATRIX IS SYMMETRIC, MAKE AN OPTION TO INPUT ONLY THE
C     LOWER TRIANGULAR PORTION OF THE MATRIX, AND OBTAIN THE UPPER
C     PROTION THRU SYMMETRY.
C
C
      IMPLICIT INTEGER (A-Z)
CWKBR LOGICAL          BO,SP,CP,DP,MS,TAPEUP,TAPBIT,DEBUG
      LOGICAL          BO,SP,CP,DP,MS,DEBUG
      INTEGER          OUTFIL(5),TRL(7),NAME(2),SUBNAM(2),IZ(1),
     1                 SKIP(2),INAME(2,5),ONAME(2,5),TYP(5),T(2,5),TY(4)
      REAL             Z(1),DR(2),D,ZERO(4)
      DOUBLE PRECISION DZ(1),DD
      CHARACTER*11     FMD,UNF,FM
CWKBI
      character*80 dsnames(89)
      common /dsname/ dsnames
C
      CHARACTER        UFM*23,UWM*25,UIM*29,SFM*25,SWM*27
      COMMON /XMSSG /  UFM,UWM,UIM,SFM,SWM
CWKBI
      COMMON /MACHIN/  MACH
     1       /PACKX /  TYPIN,TYPOUT,II,JJ,INCR
     2       /SYSTEM/  SYSBUF,NOUT,NOGO,DUM36(36),NBPW
     3       /TYPE  /  PREC(2),NWDS(4)
     4       /ZZZZZZ/  CORE(1)
      COMMON /BLANK /  P1,P2,P3(2),P4
      EQUIVALENCE      (IZ(1),Z(1),DZ(1),CORE(1)), (DR(1),D,DD)
      DATA    OUTFIL/  201,202,203,204,205 /, SKIP/4H(SKI,4HP)  /
      DATA    INAME ,  ONAME ,TYP / 25*4H    /    ,SUBNAM/4HINPT,2HT4  /
      DATA    TY    /  4HRSP ,4HRDP ,4HCSP ,4HCDP /, ZERO/4*0.0 /
      DATA    FMD   ,  UNF / 'FORMATTED  ','UNFORMATTED' /BLNK / 4H    /
      DATA    DEBUG /  .FALSE.    /
CWKBI
      DATA  IFIRST / 0 /
C
      SP    = .FALSE.
      CP    = .FALSE.
      DP    = .FALSE.
      MS    = P4.EQ.-4
      BO    = BCDOPT.NE.1
      LCORE = KORSZ(Z(1))
      BUF1  = LCORE - SYSBUF
      LCOR  = BUF1  - 1
      IF (LCOR .LE. 0) CALL MESAGE (-8,LCORE,SUBNAM)
      IF (UNITX.LT.10 .OR. UNITX.GT.24) GO TO 30
      IF (UNITX .EQ. 13) GO TO 30
      IF (MACH.EQ.4 .AND. UNITX.GE.13) GO TO 30
      IF (MACH.NE.4 .AND. UNITX.LE.13) GO TO 30
C
      FM = UNF
      IF (BO) FM = FMD
CWKBR WRITE  (NOUT,10) UIM,UNITX,INP(UNITX-10),FM
      WRITE  (NOUT,10) UIM,UNITX,DSNAMES(UNITX),FM
C    1,                BCDOPT,P1,P2,P3,P4
CWKBR10 FORMAT (A29,'. INPUTT4 MODULE OPENING FORTRAN TAPE',I4,' (',A4,
   10 FORMAT (A29,'. INPUTT4 MODULE OPENING FORTRAN TAPE',I4,/,' (',
     1       A44,')',/,
     1       ' FOR ',A11,' READ.')
C    2,      /5X,'BCDOPT,P1,P2,P3,P4 =',3I3,1X,2A4,I4)
C
CWKBR IF (MACH .GE. 5) GO TO 50
CWKBI
      CLOSE ( UNIT=UNITX )
CWKBR OPEN (UNIT=UNITX,ACCESS='SEQUENTIAL',STATUS='OLD',FORM=FM,ERR=920)
      OPEN (UNIT=UNITX,ACCESS='SEQUENTIAL',STATUS='OLD',FORM=FM,ERR=920,
CWKBI
     &     FILE=DSNAMES(UNITX) )
      GO TO 50
CWKBD FILE   = INP(UNITX-10)
CWKBD TAPEUP = TAPBIT(FILE)
CWKBD IF (TAPEUP) GO TO 50
CWKBD WRITE  (NOUT,20) UFM,FILE,UNITX
CWKBD 20 FORMAT (A23,'. ',A4,' (TAPE UNIT',I4,') NOT ASSIGNED')
CWKBD GO TO 990
C
   30 WRITE  (NOUT,40) UFM,UNITX
   40 FORMAT (A23,', TAPE UNIT',I4,' SPEC. ERROR')
      GO TO 990
C
   50 IF (TAPE.EQ.-1 .OR. TAPE.EQ.-3) REWIND UNITX
CWKBI
      IFIRST = 1
C
C     SET UP LOOP TO READ MATRIX FILES
C
      INCR  = 1
      II    = 1
      DO 800 NN = 1,NMAT
C
C     CHECK OUTPUT FILE REQUEST
C
      OUTPUT = OUTFIL(NN)
      TRL(1) = OUTPUT
      CALL RDTRL (TRL)
      IF (TRL(1) .GT. 0) GO TO 200
C
C     IF OUTPUT FILE IS PURGED, PURGE THE CORRESPONDING FILE ON INPUT
C     TAPE. CHECK IF THERE ARE MORE OUTPUT DATA BLOCK REQUESTED ON THE
C     SAME OUTPUT2 DMAP. QUIT IF THERE ARE NONE
C
      I = NN
  100 I = I + 1
      IF (I .GT. 5) GO TO 810
      TRL(1) = OUTFIL(I)
      CALL RDTRL (TRL)
      IF (TRL(1) .LE. 0) GO TO 100
C
C     SKIP PRESENT MATRIX DATA BLOCK ON INPUT TAPE
C
      IMHERE = 120
      IF (BO) GO TO 120
C
C     SKIP BINARY FILES
C
      IMHERE = 105
      READ (UNITX,ERR=960,END=940) NCOL,J1,J2,NTYPE,NAME
      IMHERE = -110
  110 READ (UNITX,ERR=780,END=940) ICOL
      IF (ICOL-NCOL) 110,110,170
C
C     SKIP ASCII FILES
C
  120 IF (.NOT.MS) READ (UNITX,220,ERR=960,END=940) NCOL,J1,J2,NTYPE,
     1             NAME
      IF (MS) READ (UNITX,230,ERR=960,END=940) NCOL,J1,J2,NTYPE,NAME
      IF (MS) GO TO 130
      DP = NTYPE.EQ.2 .OR. NTYPE.EQ.4
      SP = .NOT.DP
      CP = P4.GE.1 .AND. NBPW.GE.60
      IF (.NOT.CP) GO TO 130
      SP = .FALSE.
      DP = .FALSE.
  130 IF (MS) READ (UNITX,440) ICOL,IROW,NW
      IF (SP) READ (UNITX,450) ICOL,IROW,NW
      IF (CP .OR. DP) READ (UNITX,460) ICOL,IROW,NW
      IF (ICOL .GT. NCOL) GO TO 160
      IF (IROW .EQ. 0) NW = NW/65536
C
C     COMPUTE NO. OF RECORDS TO SKIP.
C
C     S.P. DATA ARE WRITTEN IN 10 VALUES PER RECORD (5 FOR MSC RECORD)
C     D.P. DATA, AND DATA FROM LONG WORD MACHINE, ARE IN 8 VALUES PER
C     RECORD (SEE FORMAT 650, 660, 670 AND 680)
C
      IF (MS) NW = (NW+4)/5
      IF (SP) NW = (NW+9)/10
      IF (CP .OR. DP) NW = (NW+7)/8
      DO 150 J = 1,NW
      READ (UNITX,140) K
  140 FORMAT (A1)
  150 CONTINUE
      GO TO 130
C
  160 READ (UNITX,140) J
C
  170 INAME(1,NN) = NAME(1)
      INAME(2,NN) = NAME(2)
      ONAME(1,NN) = SKIP(1)
      ONAME(2,NN) = SKIP(2)
      TYP(NN) = TY(NTYPE)
      T(1,NN) = J1
      T(2,NN) = J2
      GO TO 800
C
C     TRANSFER DATA FROM INPUT TAPE TO OUTPUT FILE
C
  200 IMHERE = 210
      IF (BO) GO TO 210
      IMHERE = 200
      READ (UNITX,ERR=960,END=940) NCOL,NROW,NFORM,NTYPE,NAME
      GO TO 240
  210 IF (.NOT.MS) READ (UNITX,220,ERR=960,END=940) NCOL,NROW,NFORM,
     1             NTYPE,NAME
      IF (MS) READ (UNITX,230,ERR=960,END=940) NCOL,NROW,NFORM,NTYPE,
     1             NAME
  220 FORMAT (1X,4I13,5X,2A4)
  230 FORMAT (4I8,2A4)
C
  240 IF (DEBUG) WRITE (NOUT,220) NCOL,NROW,NFORM,NTYPE,NAME
      IF (.NOT.DEBUG) WRITE (NOUT,245) NN,NAME
  245 FORMAT (5X,'READING DATA BLOCK NO.',I4,' - ',2A4,
     1       ' FROM INPUT TAPE')
C
      IF (MS) NFORM = -NFORM
      IF (BO .AND. NFORM.GT.0) GO TO 900
C
C     THE ABOVE CHECK ON NFORM AND BO MAY BE ALREADY TOO LATE
C
      IF (MS) GO TO 250
      DP = .FALSE.
      IF (NTYPE.EQ.2 .OR. NTYPE.EQ.4) DP = .TRUE.
      SP = .NOT.DP
      CP = P4.GE.1 .AND. NBPW.GE.60
      IF (CP) SP = .FALSE.
      IF (CP) DP = .FALSE.
  250 FLAG = 0
      IF (MS) FLAG = 1
      IF (SP) FLAG = 2
      IF (CP) FLAG = 3
      IF (DP) FLAG = 4
      IF (FLAG .EQ. 0) CALL MESAGE (-37,0,SUBNAM)
      NFORM  = IABS(NFORM)
      JJ     = NROW
      TYPIN  = NTYPE
      IF (MS .AND. (TYPIN.EQ.2 .OR. TYPIN.EQ.4)) TYPIN = TYPIN - 1
      TYPOUT = NTYPE
      NWORDS = NWDS(TYPIN)
      BASE   = NROW*NWORDS
      IF (BASE .GT. LCOR) CALL MESAGE (-8,LCORE,SUBNAM)
      CALL MAKMCB (TRL(1),OUTPUT,NROW,NFORM,TYPOUT)
      INAME(1,NN) = NAME(1)
      INAME(2,NN) = NAME(2)
      CALL FNAME (OUTPUT,NAME)
      CALL OPEN  (*260,OUTPUT,IZ(BUF1),1)
      CALL WRITE (OUTPUT,NAME,2,1)
      ONAME(1,NN) = NAME(1)
      ONAME(2,NN) = NAME(2)
      TYP(NN) = TY(NTYPE)
      T(1,NN) = NCOL
      T(2,NN) = NROW
      GO TO 280
C
  260 WRITE  (NOUT,270) UFM,DSNAMES(UNITX)
  270 FORMAT (A23,'. CANNOT OPEN OUTPUT FILE - ',/,A80)
      GO TO 990
C
C     PROCESS EACH COLUMN (NON-ZERO OR NULL COLUMN ON FILE)
C     PLUS ONE EXTRA COLUMN, NCOL+1, AT THE END
C
  280 IOLD = -1
      II = 1
      JJ = NROW
      NCOL1 = NCOL + 1
      I  = 0
C
  290 I  = I + 1
      IF (DEBUG) WRITE (NOUT,300) I,NCOL1
  300 FORMAT ('   INPUT4/@290   I,NCOL1 =',2I5)
      IF (I .GT. NCOL1) GO TO 760
      DO 310 J = 1,BASE
  310 Z(J) = 0.0
      IMHERE = -400
      IF (BO) GO TO 400
C
C     BINARY (UNFORMATTED) READ
C     -------------------------
C
      IMHERE = -315
      READ (UNITX,ERR=780,END=940) ICOL,IROW,NW,(Z(K+BASE),K=1,NW)
C
      IF (ICOL .GT. NCOL) GO TO 760
      IF (NW+BASE .GT. LCOR) CALL MESAGE (-8,LCORE,SUBNAM)
  320 IF (I .GE. ICOL) GO TO 330
C
C     NULL COLUMN(S) ENCOUNTERED
C
      JJ = 1
      CALL PACK (Z(1),OUTPUT,TRL)
      JJ = NROW
      I  = I + 1
      GO TO 320
C
  330 IF (IROW .EQ. 0) GO TO 360
C
C     DENSE MATRIX FORMAT
C
C     DATA WERE WRITTEN FROM FIRST NON-ZERO TERM TO LAST NON-ZERO TERM
C     INCLUDING POSSIBLE ZERO TERMS.
C     IROW IS THE FIRST NON-ZERO TERM ROW POSITION
C
C     S.P. OR D.P. MATRIX IN, S.P. OR. D.P. MATRIX OUT. THAT INCLUDE
C     REAL AND COMPLEX.
C
      IROWP = (IROW-1)*NWORDS
      DO 340 J = 1,NW
  340 Z(J+IROWP) = Z(J+BASE)
C
C     PACK ONE COLUMN OUT
C
  350 CALL PACK (Z(1),OUTPUT,TRL)
      GO TO 290
C
C     SPARSE INCOMING MATRIX.
C     THIS RECORD CONATINS ONE OR MORE STRINGS.
C
C     DATA ARE WRITTEN IN MULTIPLE STRINGS OF NON-ZERO TERMS. EACH
C     STRING IS PRECEED BY A CONTROL WORD
C       LN   = LENGTH OF STRING, LEFT HALF OF WORD
C       IROW = ROW POSITION,    RIGHT HALF OF WORD
C       LN AND IROW ARE DATA TYPE DEPENDENT
C     AND
C       K    = A RUNNING POINTER, POINTS TO THE CONTROL WORD OF EACH
C              STRING IN ARRAY Z HOLDING LN AND IROW INFORMATION
C
  360 K    = 1
  370 KPB  = K + BASE
      LN   = IZ(KPB)/65536
      IROW = IZ(KPB) - LN*65536
      IROW = (IROW-1)*NWORDS
      LN   = LN*NWORDS
C
C     S.P. OR D.P. MATRIX IN, S.P. OR. D.P. MATRIX OUT. THAT INCLUDE
C     REAL AND COMPLEX
C
      DO 380 J = 1,LN
  380 Z(J+IROW) = Z(J+KPB)
      K  = K + LN + 1
      IF (K-NW) 370,350,350
C
C     ASCII (FORMATTED) READ
C     ----------------------
C
C     THIS ASCII OPTION WORKS WELL WITH INPUT TAPE GENERATED FROM
C     COSMIC/OUTPUT4 MODULE. HOWEVER IT MAY OR MAY NOT WORK WITH INPUT
C     TAPE FROM MSC/OUTPUT4.
C
C     ASSUMPTIONS HERE FOR MSC/OUTPUT4 TAPE ARE -
C     1. INTEGER RECORDS AND FLOATING POINT RECORDS DO NOT MIXED
C     2. ONE OR MORE RECORDS HOLD A MATRIX COLUMN, EACH RECORD IS LESS
C        THAN 80 BYTES LONG.
C        INTEGER IN 3I8, BCD IN 2A4, AND S.P. REAL DATA IN 5E16.9
C
  400 GO TO (410,420,430,430), FLAG
  410 READ (UNITX,440,ERR=780,END=940) ICOL,IROW,NW
      IF (DEBUG) WRITE (NOUT,450) ICOL,IROW,NW
      GO TO 470
  420 READ (UNITX,450,ERR=780,END=940) ICOL,IROW,NW
      GO TO 470
  430 READ (UNITX,460,ERR=780,END=940) ICOL,IROW,NW
  440 FORMAT (3I8)
  450 FORMAT (1X,3I13)
  460 FORMAT (1X,3I16)
C
C     ICOL IS MATRIX COLUMN NUMBER READ IN FROM THE INPUT TAPE.
C          REPEATED ICOL FOR MULTIPLE STRINGS.
C     IROW IS .LT. 0, AND IABS(IROW) IS THE ROW POSITION OF STRING.
C     NW   IS LENGTH OF STRING.
C     I    IS THE CURRENT COLUMN NUMBER OF THE OUTPUT MATRIX.
C
C     POSSIBILITIES AT THIS POINT ARE -
C
C     1. ICOL = IOLD, ADD NEW STRING TO CURRENT COLUMN OF OUTPUT MATRIX.
C     2. ICOL = IOLD+1, PREVIOUS COLUMN JUST FINISHED, PACK IT OUT.
C     3. ICOL.GT.NCOL, OUTPUT MATRIX FINISH. ALL COLUMNS HAVE BEEN READ.
C               READ ONE MORE DUMMY RECORD BEFORE WRAP UP THIS MATRIX
C     4. IN ALL CASES, ZERO OUT Z ARRAY FOR NEW DATA, AND INCREASE
C        COLUMN COUNTER I BY 1
C     5. ICOL .LT. I, LOGIC ERROR
C     6. ICOL .GT. I, PACK NULL COLUMN(S) OUT.
C     7. ICOL .EQ. I, CURRENT INPUT RECORD IS FOR THE I-TH COLUMN.
C
  470 IF (NW*NWORDS .GT. LCOR) CALL MESAGE (-8,LCORE,SUBNAM)
      IF (ICOL .EQ. IOLD  ) GO TO 710
      IF (ICOL .EQ. IOLD+1) CALL PACK (Z(1),OUTPUT,TRL)
      IMHERE = -550
      IF (ICOL .GT. NCOL) GO TO 550
      DO 480 J = 1,BASE
  480 Z(J) = 0.0
C 490 I = I + 1
  490 IF (ICOL - I) 510,600,500
  500 CALL PACK (Z(1),OUTPUT,TRL)
      I = I + 1
      GO TO 490
  510 WRITE  (NOUT,520) SFM,I,ICOL, IOLD,NCOL,IROW,NW, SP,CP,DP,MS,FLAG
  520 FORMAT (A25,'. LOGIC ERROR @470, I,ICOL =',2I6, /5X,
     1       '  IOLD,NCOL,IROW,NW =',4I6,'  SP,CP,DP,MS,FLAG =',4L2,I4)
      CALL MESAGE (-37,0,SUBNAM)
C
  550 READ (UNITX,140,ERR=780,END=940) J
      GO TO 760
C
  600 IF (IROW .LE. 0) GO TO 700
C
C     DENSE MATRIX FORMAT
C
      IROW = IROW - 1
      IMHERE = 605
      GO TO (610,620,630,640), FLAG
  610 READ (UNITX,650,ERR=780,END=940) ( Z(K+IROW),K=1,NW)
      IF (DEBUG) WRITE (NOUT,660) (Z(K+IROW),K=1,NW)
      GO TO 350
  620 READ (UNITX,660,ERR=780,END=940) ( Z(K+IROW),K=1,NW)
      GO TO 350
  630 READ (UNITX,670,ERR=780,END=940) ( Z(K+IROW),K=1,NW)
      GO TO 350
  640 READ (UNITX,680,ERR=780,END=940) (DZ(K+IROW),K=1,NW)
      GO TO 350
  650 FORMAT (    5E16.9)
  660 FORMAT (1X,10E13.6)
  670 FORMAT (1X, 8E16.9)
  680 FORMAT (1X, 8D16.9)
C
C     SPARSE INCOMING MATRIX
C
C     OUTPUT4 WRITES OUT THE ASCII STRING DATA IN FOLLOWING FORMATS -
C     EACH STRING, PRECEEDED BY A 3-INTEGER - ICOL,IROW,NW - CONTROL
C     RECORD, AND CONTINUE INTO ONE OR MORE DATA RECORDS OF 130 OR
C     128 BYTES EACH. (80 BYTES MSC RECORD)
C     NW   = LENGTH OF STRING IN THE FOLLOWING DATA RECORDS, S.P. OR
C            D.P. DEPENDENT.
C     IROW = IABS(IROW) IS ROW POSITION IF FIRST WORD OF STRING
C     ICOL = COLUMN NUMBER OF MATRIX
C
C     NOTICE THAT OUTPUT4 MAY WRITE OUT A MATRIX COLUMN IN MULTI-STRING
C     RECORDS, WITH THE SAME COLUMN VALUE ICOL IN THE EACH 3-INTEGER
C     CONTROL RECORD. IN THIS CASE, MROW IS ALWAYS NEGATIVE.
C     (IF IROW IS ZERO, MATRIX WAS WRITTEN OUT IN DENSE FORMAT)
C
  700 IOLD = ICOL
  710 IROW = IABS(IROW) - 1
      IF (TYPIN .GE. 3) IROW = IROW*2
      IMHERE = 715
      GO TO (720,730,740,750), FLAG
  720 READ (UNITX,650,ERR=780,END=940) ( Z(K+IROW),K=1,NW)
      GO TO 400
  730 READ (UNITX,660,ERR=780,END=940) ( Z(K+IROW),K=1,NW)
      GO TO 400
  740 READ (UNITX,670,ERR=780,END=940) ( Z(K+IROW),K=1,NW)
      GO TO 400
  750 READ (UNITX,680,ERR=780,END=940) (DZ(K+IROW),K=1,NW)
      GO TO 400
C
  760 CALL CLOSE  (OUTPUT,1)
      CALL WRTTRL (TRL)
      IF (DEBUG) WRITE (NOUT,770) UIM,NAME,DSNAMES(UNITX),TRL
  770 FORMAT (A29,' FROM INPUTT4 MODULE. ',2A4,' WAS RECOVERED FROM ',
     1 /, A44,' INPUT TAPE SUCCESSFULLY.', /5X,'TRAIL =',6I6,I9)
      GO TO 800
C
C     BAD DATA ON INPUT TAPE
C
  780 WRITE  (NOUT,790) UFM,DSNAMES(UNITX),UNITX,NN,IMHERE
  790 FORMAT (A23,'. BAD DATA ENCOUNTERED WHILE READING INPUT TAPE ',/,A80
     1,/,     ' FORTRAN UNIT',I4,',  DATA BLOCK',I4, /5X,'IMHERE =',I5)
      NOGO = 1
C
  800 CONTINUE
C
  810 IF (TAPE .LE. -2) REWIND UNITX
      CALL PAGE2 (-8)
CWKBR WRITE  (NOUT,820) UIM,FM,INP(UNITX-10)
      WRITE  (NOUT,820) UIM,FM,DSNAMES(UNITX)
  820 FORMAT (A29,' FROM INPUTT4 MODULE. THE FOLLOWING FILES WERE ',
     1       'SUCCESSFULLY RECOVERED FROM USER ',/5X,A11,' INPUT TAPE ',
CWKBR2       /A80/,' TO NASTRAN GINO FILES')
     2       /,A44,' TO NASTRAN GINO FILES')
      DO 840 J = 1,5
      IF (INAME(1,J) .NE. BLNK) WRITE (NOUT,830) INAME(1,J),INAME(2,J),
     1       ONAME(1,J),ONAME(2,J),TYP(J),T(1,J),T(2,J)
  830 FORMAT (5X,2A4,' ==COPIED TO== ',2A4,4X,'MATRIX TYPE = ',A4,
     1       ',  SIZE (',I6,2H X,I6,1H))
  840 CONTINUE
      GO TO 1000
C
C     ERRORS
C
  900 WRITE  (NOUT,910) UFM,DSNAMES(UNITX),BO,NCOL,NROW,NFORM,NTYPE,
     1        NAME,BCDOPT
  910 FORMAT (A23,'. PARAMETER P3 ERROR. FORTRAN INPUT TAPE ',A4,' WAS',
     1       ' WRITTEN IN BINARY RECORDS, NOT ASCII.', /5X,'BO =',L2,2X,
     2       'NCOL,NROW,NFORM,NTYPE,NAME =',4I8,1X,2A4,'   BCDOPT =',I3)
      GO TO  990
  920 WRITE  (NOUT,930) UFM,UNITX
  930 FORMAT (A23,'. INPUTT4 MODULE CANNOT OPEN FORTRAN INPUT TAPE',I4)
      GO TO  990
  940 WRITE  (NOUT,950) UFM,DSNAMES(UNITX),UNITX,NN,IMHERE
  950 FORMAT (A23,' 3001, EOF ENCOUNTERED WHILE READING INPUT TAPE ',/,A80
     1,/,    ' FORTRAN UNIT',I4,',  DATA BLOCK',I4, /5X,'IMHERE =',I4)
      IF (IMHERE.EQ.210 .OR. IMHERE.EQ.220) WRITE (NOUT,975)
      GO TO 990
  960 WRITE  (NOUT,970) UFM,DSNAMES(UNITX),UNITX,NN,IMHERE
  970 FORMAT (A23,'. BAD DATA IN HEADER RECORD ON INPUT TAPE ',
     1/,A80,/
     2, ' FORTRAN UNIT',I4,',  DATA BLOCK',I4, /5X,'IMHERE =',I5)
      IF (IMHERE.EQ.105 .OR. IMHERE.EQ.120) WRITE (NOUT,975)
  975 FORMAT (1H+,22X,'POSSIBLY TAPE UNIT NOT CORRECTLY ASSIGNED')
      IF (IMHERE .LT. 0) WRITE (NOUT,980)
  980 FORMAT (1H+,22X,'POSSIBLY ERROR IN CONTRL RECORD 3 WORDS')
C
  990 NOGO = 1
C
CWKBR 1000 CLOSE (UNIT=UNITX)
 1000 CONTINUE
      RETURN
      END
