      SUBROUTINE FRLG
C
C     FREQUENCE RESPONSE LOAD GENERATOR
C
C     INPUTS  - CASEXX,USETD,DLT,FRL,GMD,GOD,DIT,PHIDH
C
C     OUTPUTS - PPF,PSF,PDF,FOL,PHF
C
C     4 SCRATHCES
C
C
      EXTERNAL        ANDF
      INTEGER         CASEXX,USETD,DLT,FRL,GMD,GOD,DIT,PHIDH,PPF,PSF,
     1                PDF,FOL,PHF,SCR1,SCR2,SCR3,SCR4,MCB(7),ANDF,
     2                SINGLE,OMIT,IFREQ(2),ITRAN(2)
      COMMON /TWO   / ITWO(32)
      COMMON /BLANK / MODAL(2),NOTRD,IAPP(2)
      COMMON /BITPOS/ IUM,IUO,SKP(6),IUS
      DATA    CASEXX, USETD,DLT,FRL,GMD,GOD,DIT,PHIDH      /
     1        101   , 102  ,103,104,105,106,107,108        /
      DATA    PPF   , PSF,PDF,FOL,PHF, SCR1,SCR2,SCR3,SCR4 /
     1        201   , 202,203,204,205, 301 ,302 ,303 ,304  /
      DATA    MODA  / 4HMODA  /
      DATA    IFREQ , ITRAN   /4HFREQ,1H ,4HTRAN,1H /
C
C     DETERMINE USET DATA
C
      MCB(1) = USETD
      CALL RDTRL (MCB)
      LUSETD = MCB(2)
      MULTI  =-1
      IF (ANDF(MCB(5),ITWO(IUM)) .NE. 0) MULTI =  1
      SINGLE =-1
      IF (ANDF(MCB(5),ITWO(IUS)) .NE. 0) SINGLE =  1
      OMIT =-1
      IF (ANDF(MCB(5),ITWO(IUO)) .NE. 0) OMIT =  1
C
      IAPP(1) = IFREQ(1)
      IAPP(2) = IFREQ(2)
C
C     BUILD LOADS ON P SET
C
C     ORDER IS ALL FREQUENCIES FOR GIVEN LOAD TOGETHER
C
      CALL FRLGA (DLT,FRL,CASEXX,DIT,PPF,LUSETD,NFREQ,NLOAD,FRQSET,FOL,
     1            NOTRD)
      IF (NOTRD .EQ. -1) GO TO 10
      IAPP(1) = ITRAN(1)
      IAPP(2) = ITRAN(2)
  10  CONTINUE
C
C     REDUCE LOADS TO D OR H SET
C
      IF (MULTI.LT.0 .AND. SINGLE.LT.0 .AND. OMIT.LT.0 .AND.
     1    MODAL(1).NE.MODA) RETURN
      CALL FRLGB (PPF,USETD,GMD,GOD,MULTI,SINGLE,OMIT,MODAL,PHIDH,PDF,
     1            PSF,PHF,SCR1,SCR2,SCR3,SCR4)
      RETURN
      END
