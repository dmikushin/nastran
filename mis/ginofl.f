      SUBROUTINE GINOFL
C
C     ROUTINE FOR GINOFILE MODULE
C
C     MODULE GINOFILE WILL CAPTURE ONE SCRATCH FILE (301 THRU 309) OF
C     PREVIOUS DAMP MODULE, AND MAKE IT A LEGITIMATE GINO FILE.
C     THE SCRATCH FILE CAN BE A TABLE DATA BLOCK OR A MATRIX DATA BLOCK.
C     USE DMAP ALTER TO PLACE THIS MODULE IMMEDIATELY AFTER ANY NASTRAN
C     EXECUTABLE DMAP MODULE WHOSE SCRATCH FILE IS TO BE CAPTURED
C
C     IT IS USER'S RESPONSIBILITY TO SEE THAT NO FIAT TABLE RE-
C     ARRANGEMENT BY MODULE XSFA BETWEEN THIS GINOFILE MODULE AND THE
C     PREVIOUS INTENDED MODULE
C
C     GINOFILE  /OUTFL/C,N,P1/C,N,P2/C,N,P3  $
C
C     INPUT   FILE = NONE
C     OUTPUT  FILE = OUTFL, ANY UNIQUE NAME
C     SCRATCH FILE = 301
C     PARAMETERS   -
C             P1   = SCRATCH FILE NUMBER, 301,302,303,...,309
C                    (NO DEFAULT)
C             P2   = ADDITIONAL NUMBER OF RECORDS IN P1 FILE TO BE
C                    SKIPPED (NOT INCLUDING HEADER RECORD, WHETHER IT
C                    EXISTS OR NOT, DEFAULT = 0)
C             P3   = NO. OF RECORDS TO BE COPIED TO OUTPUT FILE OUTFL,
C                    STARTING FROM THE P2+1 RECORD, OR UP TO EOF RECORD
C                    (DEFAULT JJ=999999)
C
C     THIS GINOFILE MODULE SHOULD BE MAPPED IN ALL LINKS EXCEPT LINK1
C
C     WRITTEN BY G.CHAN/UNISYS, MAY 1988
C     DEFINITELY THIS IS NOT AN ORDINARY JOB FOR AMATEUR OR SEASONNED
C     PROGRAMMERS, MY FRIENDS
C
C     THE TRICKY PART OF THIS PROGRAM IS THAT GINOFILE MODULE USES ONLY
C     ONE OUTPUT FILE AND ONE SCRATCH FILE, WHICH IS 301
C     THE PROBLEMS HERE ARE (1) HOW TO CAPTURE OTHER SCRATCH FILE OF THE
C     PREVIOUS DMAP MODULE, SAY 303, WHILE ONLY 301 IS AVAILABLE. AND
C     (2) HOW TO CAPTURE SCRATCH1 FILE WHILE THE ORIGINAL 301 GINO DATA,
C     SUCH AS TRAILER, UNIT NUMBER, FILE INDEX ETC. ARE GONE. (THE
C     ORIGINAL 301 GINO DATA HAS BEEN ZEROED OUT TO GIVE ROOM FOR THE
C     NEW SCRATCH1 BEING ASSIGNED TO GINOFILE MODULE).
C
      IMPLICIT INTEGER (A-Z)
      LOGICAL          DEBUG
      CHARACTER*6      TBMX,MXTB(2)
      DIMENSION        TRL(7),FN(2),NAME(2),TCHI(9)
      DIMENSION        ITRL(7)
C
      COMMON /PACKX /  ITYPEP, JTYPEP, IROWP, JROWP, INCRP
      COMMON /UNPAKX/  ITYPEU,         IROWU, JROWU, INCRU
      CHARACTER        UFM*23,UWM*25,UIM*29
      COMMON /XMSSG /  UFM,UWM,UIM
      COMMON /SYSTEM/  SYSBUF,NOUT,SKIP(21),ICFIAT
      COMMON /BLANK /  P1,P2,P3
      COMMON /XFIAT /  FIAT(3)
      COMMON /XFIST /  FIST(2)
      COMMON /XSORTX/  SAVE(6)
      COMMON /ZZZZZZ/  Z(1)
      EQUIVALENCE      (SCR,P1)
      DATA    NAME  /  4HGINO,4HFL  /,  SCRA, TCH / 4HSCRA, 4H     /
CWKBR DATA    BLANK /  4H           /,  IZ2 / 2   /,OUTFL  / 201   /
      DATA    IZ2 / 2   /,OUTFL  / 201   /
      DATA    TCHI  /  4HTCH1,4HTCH2 ,  4HTCH3,4HTCH4,4HTCH5,4HTCH6,
     1                 4HTCH7,4HTCH8 ,  4HTCH9    /
      DATA    MXTB  /  'MATRIX'      ,  'TABLE '  /,DEBUG  /.FALSE./
C
C     CHECK SCRATCH FILE PARAMETER
C
      IF (SCR.GT.300 .AND. SCR.LT.400) GO TO 20
      WRITE  (NOUT,10) UWM,SCR
   10 FORMAT (A25,', SCRATCH FILE PARAMETER ERROR. GINOFILE ABORTED AND'
     1,      ' NO OUTPUT GINO FILE CREATED', /5X,'FIRST PARAMETER =',I5)
      GO TO 300
   20 IF (SCR .LT. 310) GO TO 40
      WRITE  (NOUT,30) UFM
   30 FORMAT (A23,', GINOFILE IS PROGRAMMED TO PROCESS ONLY THE FIRST ',
     1       '9 SCRATCH FILES')
      CALL MESAGE (-61,0,0)
C
C     SETUP CORE, BUFFERS, AND GINO OUTPUT FILE NAME
C
   40 KORE  = KORSZ(Z(1))
      IBUF1 = KORE - SYSBUF - 1
      IBUF2 = IBUF1- SYSBUF
      KORE  = IBUF2- 1
      CALL FNAME (OUTFL,FN)
C
C     RECAPTURE SCRATCH FILE NUMBER, TRAILER, AND INDEX POINTER IN FIAT
C     AND FIST
C     NOTE -
C     IT IS HERE THAT SCRATCH FILE IS LIMITED FROM 301 THRU 309
C     SCRATCH FILES 310 AND HIGHER MAY NOT HAVE UNIQUE 8-LETTER NAMES
C     IN ALL COMPUTERS.
C
      INDEX = 0
      K   = FIAT(3)*ICFIAT - 2
      TCH = TCHI(SCR-300)
      DO 50 I = 4,K,ICFIAT
      IF (FIAT(I+1).EQ.SCRA .AND. FIAT(I+2).EQ.TCH) GO TO 70
   50 CONTINUE
      WRITE  (NOUT,60) UFM,SCR
   60 FORMAT (A23,', SCRATCH FILE',I4,' DOES NOT EXIST IN FIAT TABLE. ',
     1       'THIS ERROR MAY DUE TO', /5X,
     2       'USER ERROR, OR GINOFILE WAS PRECEDED BY XSFA MODULE')
      CALL MESAGE (-37,0,NAME)
   70 INDEX = I
      IF (DEBUG) WRITE (6,80) INDEX
   80 FORMAT (5X,'INDEX =',I6)
      IF (SCR .NE. 301) GO TO 90
C
C     IF SCRATCH FILE IS 301, THE TRAILER IN FIAT HAS BEEN INITIALIZED
C     TO ZEROS. MUST RECLAIM THE TRAILER FROM /XSORTX/, SAVED BY WRTTRL
C
C     THE LABEL COMMON /XSORTX/, DEFINED VIA SEMDBD AND AVAILABLE IN ALL
C     LINKS, IS ORIGNALLY USED ONLY BY XSORT2 ROUTINE WHICH WAS EXECUTED
C     IN EARLY LINK1. THUS IT IS SAFE TO SAVE THE SCRATCH 301 TRAILER IN
C     /XSORTX/. NOTE THE OTHER SCARTCH FILES 302 THRU 309 DO NOT HAVE
C     THIS PROBLEM
C
      FIAT(INDEX+ 3) = SAVE(1)
      FIAT(INDEX+ 4) = SAVE(2)
      FIAT(INDEX+ 5) = SAVE(3)
      IF (ICFIAT .EQ. 8) GO TO 90
      FIAT(INDEX+ 8) = SAVE(4)
      FIAT(INDEX+ 9) = SAVE(5)
      FIAT(INDEX+10) = SAVE(6)
C
C     LOCATE 301 IN FIST TABLE AND SWAP FIAT INDEX THAT POINTS TO THE
C     TARGET SCR FILE
C
   90 K = FIST(2)*2+2
      DO 100 I=3,K,2
      IF (FIST(I) .EQ. 301) GO TO 110
  100 CONTINUE
      CALL MESAGE (-37,0,NAME)
  110 FISTI  = I
      FISTI1 = FIST(I+1)
      FIST(I+1) = INDEX-1
      IF (DEBUG) WRITE (6,120) I,FIST(I),FIST(I+1),INDEX
  120 FORMAT (10X,' I,FIST(I),FIST(I+1),INDEX =',4I6)
C
C     NOW, WE CAN READ THE SCRATCH FILE TRAILER
C
      TRL(1) = 301
      CALL RDTRL (TRL(1))
      TRL(1) = SCR
      TBMX = MXTB(2)
      IF (TRL(7) .GT. 0) TBMX = MXTB(1)
      WRITE  (NOUT,130) UIM,TCH,TRL,TBMX,FN
  130 FORMAT (A29,' FROM GINOFILE MODULE', /5X,'TRAILER OF SCRA',A4,
     1       ' FILE IN PREVIOUS MODULE = (',I3,1H),5I5,I8,  /5X,A6,
     2       ' CONTENTS OF THIS FILE WILL BE TRANSFERRED TO GINO FILE ',
     3       2A4,/)
C
C     SWAP SCR AND SCRX (301) FILE
C     OPEN SCRS FILE, AND SKIP P2 RECORDS IF REQUESTED BY USER
C     (DEFAULT SKIP 1 HEADER RECORD IF IT EXISTS)
C
      TRL2  = TRL(2)
      FILE  = SCR
      SCRX  = 301
      CALL OPEN (*260,SCRX,Z(IBUF1),0)
      NWDS = TRL(5)
      IF (NWDS .EQ. 3) NWDS =2
      NWDS = TRL(3)*NWDS
      ITYPEU = TRL(5)
      IROWU  = 1
      JROWU  = TRL(3)
      INCRU  = 1
      ITYPEP = ITYPEU
      JTYPEP = ITYPEU
      IROWP  = 1
      JROWP  = TRL(3)
      INCRP  = 1
      ITRL(1) = OUTFL
      ITRL(2) = 0
      ITRL(3) = TRL(3)
      ITRL(4) = TRL(4)
      ITRL(5) = TRL(5)
      ITRL(6) = 0
      ITRL(7) = 0
      CALL RECTYP (SCRX, IRCTYP)
      IF (IRCTYP .EQ. 0) GO TO 135
      ICRQ = NWDS -KORE
      IF (ICRQ .LE. 0) GO TO 145
      CALL MESAGE (-8, SCRX, NAME)
  135 CALL READ (*250,*140,SCRX,Z,2,1,K)
CWKBR  140 IF (Z(1).NE.SCRA .OR. Z(IZ2).NE.TCH) CALL BCKREC (SCRX,1)
  140 IF (Z(1).NE.SCRA .OR. Z(IZ2).NE.TCH) CALL BCKREC (SCRX)
  145 NCOL = 0
      IF (P3 .LE. 0) P3 = 999999
      IF (P2 .LE. 0) GO TO 160
      DO 150 II=1,P2
  150 CALL FWDREC (*250,SCRX)
C
C     OPEN OUTPUT GINO FILE AND WRITE A HEADER RECORD
C
  160 FILE = OUTFL
      CALL OPEN  (*260,OUTFL,Z(IBUF2),1)
      CALL WRITE (OUTFL,FN,2,1)
  162 CALL RECTYP (SCRX, IRCTYP)
      IF (IRCTYP .EQ. 0) GO TO 170
C
C     PROCESS STRING-FORMATED RECORD HERE
C
      CALL UNPACK (*164, SCRX, Z)
      GO TO 168
  164 DO 166 L = 1, NWDS
      Z(L) = 0
  166 CONTINUE
  168 CALL PACK (Z, OUTFL, ITRL)
      GO TO 185
C
C     COPY SCRATCH FILE DATA DIRECTLY TO OUTPUT FILE
C
  170 CALL READ  (*190,*180,SCRX,Z,KORE,0,K)
      CALL WRITE (OUTFL,Z,KORE,0)
      GO TO 170
  180 CALL WRITE (OUTFL,Z,K,1)
  185 NCOL = NCOL + 1
      IF (NCOL .LT. P3) GO TO 162
C
C     ALL DONE, CLOSE ALL FILES, WRITE TRAILER, AND ISSUE FRIENDLY
C     MESSAGES
C
  190 CALL CLOSE (SCRX ,1)
      CALL CLOSE (OUTFL,1)
      TRL(1) = OUTFL
      TRL(2) = NCOL
      IF (NCOL .GT. ITRL(2)) CALL WRTTRL (TRL)
      IF (NCOL .EQ. ITRL(2)) CALL WRTTRL (ITRL)
      WRITE  (NOUT,200) UIM,TCH,FN
  200 FORMAT (A29,', DATA TRANSFER FROM PREVIOUS SCRA',A4,' FILE TO ',
     1        2A4,' IS ACCOMPLISHED')
      IF (P2 .GT.      0) WRITE (NOUT,210) TCH,P2
      IF (P3 .LT. 999999) WRITE (NOUT,220) P3
  210 FORMAT (5X,'FIRST',I5,' RECORDS IN SCRA',A4,' FILE WERE SKIPPED ',
     1       'BEFORE DATA TRANSFER')
  220 FORMAT (5X,'LAST RECORD COPIED WAS RECORD NO.',I5)
      WRITE  (NOUT,230) FN,TRL
  230 FORMAT (5X,'TRAILER OF THE NEW GINO FILE ',2A4,'  = (',I3,1H),
     1        5I5,I8)
C
C     IF SCRATCH FILE CONTAINS MATRIX DATA, CHECK NO. OF COLUMNS
C
      IF (TBMX.EQ.MXTB(1) .AND. NCOL.NE.TRL2 .AND.
     1   (P2.EQ.0 .AND. P3.EQ.999999)) WRITE (NOUT,240) UIM,TCH,FN
  240 FORMAT (A29,', POSSIBLE ERROR IN GINOFILE WAS DETECTED', /5X,
     1       'NUMBERS OF COLUMNS IN INPUT FILE SCAR',A4,
     2       ' AND OUTPUT FILE ',2A4,' DISAGREE',//)
C
C     RESET FIST ORIGINAL INDEX FOR SCRATCH FILE 301
C
      FIST(FISTI+1) = FISTI1
      GO TO 300
C
C     ERRORS
C
  250 K =-2
      GO TO 270
  260 K = -1
  270 CALL MESAGE (K,FILE,NAME)
C
  300 RETURN
      END
