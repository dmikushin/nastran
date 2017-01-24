      SUBROUTINE BDAT03
C
C     THIS SUBROUTINE PROCESSES TRANS BULK DATA, GENERATES THE
C     TRANSFORMATION MATRIX, AND WRITES TO SCBDAT.
C
      EXTERNAL        RSHIFT,ANDF
      LOGICAL         TDAT
      INTEGER         BUF1,TRANS(2),GEOM4,COMBO,AAA(2),OUTT,BUF2,BUF4,
     1                ANDF,RSHIFT,IHD(10),Z
      DIMENSION       TEMP(9),XAX(3),YAX(3),ZAX(3),V2(3),OUT(9)
      CHARACTER       UFM*23
      COMMON /XMSSG / UFM
      COMMON /CMB001/ SCR1,SCR2,SCBDAT,SCSFIL,SCCONN,SCMCON,SCTOC,
     1                GEOM4,CASECC
      COMMON /ZZZZZZ/ Z(1)
      COMMON /CMB002/ BUF1,BUF2,BUF3,BUF4,BUF5,SCORE,LCORE,INTP,OUTT
      COMMON /CMB003/ COMBO(7,5),CONSET,IAUTO,TOLER,NPSUB,CONECT,TRAN,
     1                MCON,RESTCT(7,7),ISORT,ORIGIN(7,3),IPRINT
      COMMON /OUTPUT/ ITITL(96),IHEAD(96)
      COMMON /SYSTEM/ XXX,IOT,JUNK(6),NLPP,JUNK1(2),LINE,JUNK2(2),
     1                IDAT(3)
      COMMON /CMB004/ TDAT(6)
      COMMON /BLANK / STEP,IDRY
      DATA    IHD   / 4H  SU , 4HMMAR , 4HY OF , 4H PRO  , 4HCESS    ,
     1                4HED T , 4HRANS , 4H BUL , 4HK DA  , 4HTA      /
      DATA    TRANS / 310,3 /,    AAA / 4HBDAT,4H03   /  ,
     1        IBLNK / 4H    /
C
      NGTRN = Z(BUF4)
      INUM  = 1
      IERR  = 0
      DO 10 I = 1,7
      DO 10 J = 1,3
      ORIGIN(I,J) = 0.0
   10 CONTINUE
      DO 20 I = 1,96
      IHEAD(I) = IBLNK
   20 CONTINUE
      J = 1
      DO 30 I = 76,85
      IHEAD(I) = IHD(J)
   30 J = J + 1
      CALL LOCATE (*220,Z(BUF1),TRANS(1),FLAG)
      IFILE = GEOM4
   40 CALL READ (*300,*130,GEOM4,ID,1,0,N)
      DO 50 I = 1,NPSUB
      IT = 1
      IF (ID .EQ. COMBO(I,3)) GO TO 80
   50 CONTINUE
      IF (NGTRN .EQ. 0) GO TO 70
      DO 60 I = 1,NGTRN
      IT = 2
      IF (ID .EQ. Z(BUF4+I)) GO TO 80
   60 CONTINUE
   70 CONTINUE
      CALL READ (*300,*310,GEOM4,TEMP,-9,0,NNN)
      GO TO 40
   80 TDAT(3) = .TRUE.
      IF (IT .EQ. 1) COMBO(I,3) = -COMBO(I,3)
      IF (IT .EQ. 2)  Z(BUF4+I) = -Z(BUF4+I)
      CALL READ (*300,*310,GEOM4,TEMP,9,0,NNN)
      IF (IT .NE. 1) GO TO 100
      DO 90 LL = 1,3
      ORIGIN(I,LL) = TEMP(LL)
   90 CONTINUE
  100 CONTINUE
C
C     DEFINE Z-AXIS
C
      ZAX(1) = TEMP(4) - TEMP(1)
      ZAX(2) = TEMP(5) - TEMP(2)
      ZAX(3) = TEMP(6) - TEMP(3)
C
C     DEFINE Y-AXIS
C
      V2(1)  = TEMP(7) - TEMP(1)
      V2(2)  = TEMP(8) - TEMP(2)
      V2(3)  = TEMP(9) - TEMP(3)
      YAX(1) = ZAX(2)*V2(3) - ZAX(3)*V2(2)
      YAX(2) = ZAX(3)*V2(1) - ZAX(1)*V2(3)
      YAX(3) = ZAX(1)*V2(2) - ZAX(2)*V2(1)
C
C     DEFINE X-AXIS
C
      XAX(1) = YAX(2)*ZAX(3) - ZAX(2)*YAX(3)
      XAX(2) = YAX(3)*ZAX(1) - ZAX(3)*YAX(1)
      XAX(3) = YAX(1)*ZAX(2) - ZAX(1)*YAX(2)
C
C     CHANGE TO UNIT VECTORS
C
      ZMAG = SQRT(ZAX(1)**2 + ZAX(2)**2 + ZAX(3)**2)
      YMAG = SQRT(YAX(1)**2 + YAX(2)**2 + YAX(3)**2)
      XMAG = SQRT(XAX(1)**2 + XAX(2)**2 + XAX(3)**2)
      DO 110 I = 1,3
      ZAX(I) = ZAX(I)/ZMAG
      YAX(I) = YAX(I)/YMAG
      XAX(I) = XAX(I)/XMAG
  110 CONTINUE
      CALL WRITE (SCBDAT,ID,1,0)
      CALL WRITE (SCBDAT, 1,1,0)
      CALL WRITE (SCBDAT,TEMP(1),3,0)
      OUT(1) = XAX(1)
      OUT(2) = YAX(1)
      OUT(3) = ZAX(1)
      OUT(4) = XAX(2)
      OUT(5) = YAX(2)
      OUT(6) = ZAX(2)
      OUT(7) = XAX(3)
      OUT(8) = YAX(3)
      OUT(9) = ZAX(3)
      CALL WRITE (SCBDAT,OUT,9,0)
      IF (ANDF(RSHIFT(IPRINT,6),1) .NE. 1) GO TO 120
      INUM = INUM + 1
      IF (MOD(INUM,2) .EQ. 0) CALL PAGE
      WRITE (OUTT,430) ID
      WRITE (OUTT,440) (TEMP(I),I=1,3)
      WRITE (OUTT,420) ( OUT(I),I=1,9)
  120 CONTINUE
      GO TO 40
  130 CONTINUE
C
C     PROCESS REPEATED GTRAN IDS
C
      IF (NGTRN .LT. 2) GO TO 160
      NGTRN1 = NGTRN - 1
      DO 150 I = 1,NGTRN1
      IF (Z(BUF4+I) .GE. 0) GO TO 150
      KK = I + 1
      DO 140 J = KK,NGTRN
      IF (IABS(Z(BUF4+I)) .EQ. Z(BUF4+J)) Z(BUF4+J) = -Z(BUF4+J)
  140 CONTINUE
  150 CONTINUE
  160 NPM1 = NPSUB - 1
      DO 190 I = 1,NPM1
      IF (COMBO(I,3) .GE. 0) GO TO 190
      KK = I + 1
      DO 180 J = KK,NPSUB
      IF (IABS(COMBO(I,3)) .NE. COMBO(J,3)) GO TO 180
      COMBO(J,3) = -COMBO(J,3)
      DO 170 JDH = 1,3
      ORIGIN(J,JDH) = ORIGIN(I,JDH)
  170 CONTINUE
  180 CONTINUE
  190 CONTINUE
C
C     TEST TO SEE THAT ALL TRANS HAVE BEEN FOUND
C
      DO 200 I = 1,NPSUB
      IF (COMBO(I,3) .LE. 0) GO TO 200
      IERR = 1
      WRITE (OUTT,400) UFM,COMBO(I,3)
  200 CONTINUE
      IF (NGTRN .EQ. 0) GO TO 220
      DO 210 I = 1,NGTRN
      IF (Z(BUF4+I) .LE. 0) GO TO 210
      IERR = 1
      WRITE (OUTT,410) UFM,Z(BUF4+I)
  210 CONTINUE
  220 CALL EOF (SCBDAT)
      CALL WRITE (SCBDAT,ID,1,1)
      CALL CLOSE (SCBDAT,1)
      DO 230 I = 1,NPSUB
      COMBO(I,3) = IABS(COMBO(I,3))
  230 CONTINUE
      IF (IERR .EQ. 1) IDRY = -2
      RETURN
C
  300 IMSG = -2
      GO TO 320
  310 IMSG = -3
  320 CALL MESAGE (IMSG,IFILE,AAA)
      RETURN
C
  400 FORMAT (A23,' 6511, THE REQUESTED TRANS SET ID',I9,
     1       ' HAS NOT BEEN DEFINED BY BULK DATA.')
  410 FORMAT (A23,' 6513, THE TRANS SET ID',I9,' REQUESTED BY A GTRAN ',
     1       'BULK DATA CARD HAS NOT BEEN DEFINED.')
  420 FORMAT (43X,5H*****,42X,5H*****, /3(43X,1H*,50X,1H*, /43X,1H*,1X,
     1       3E15.6,4X,1H*,/),43X,1H*,50X,1H*, /43X,5H*****,42X,5H*****)
  430 FORMAT (//48X,34HTRANS SET IDENTIFICATION NUMBER = ,I8)
  440 FORMAT ( /50X,37HCOORDINATES OF ORIGIN IN BASIC SYSTEM ,
     1         /45X,3E15.6, //58X,21HTRANSFORMATION MATRIX/)
      END
