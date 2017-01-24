      SUBROUTINE XRGSUB (IRESTB,SUBSET)
C****
C     PURPOSE - XRGSUB PROCESSES THE ****SBST CONTROL CARD IN
C               RIGID FORMAT DATA BASE
C
C     AUTHOR  - RPK CORPORATION; DECEMBER, 1983
C
C     INPUT
C       ARGUMENTS
C         SUBSET        SUBSET NUMBERS GIVEN BY THE USER
C       OTHER
C         /XRGDXX/
C           NSUBST      NUMBER OF SUBSET NUMBERS GIVEN BY USER
C           NUM         2 WORD ARRAY CONTAINING A RANGE OF NUMBERS
C                       FROM THE LIST OF NUMBERS ON THE ****SBST
C                       CONTROL CARD
C         NUMENT        NUMBER OF WORDS PER ENTRY IN THE MODULE
C                       EXECUTION DECISION TABLE
C
C     OUTPUT
C       ARGUMENTS
C         IRESTB        MODULE EXECUTION DECISION TABLE ENTRY FOR
C                       CURRENT DMAP STATEMENT
C       OTHER
C         /XRGDXX/
C           ICOL      COLUMN NUMBER BEING PROCESSED ON THE CARD
C           IERROR    ERROR FLAG - NON-ZERO IF AN ERROR OCCURRED
C           IGNORE    IGNORE FLAG SET TO NON-ZERO IF THE DMAP
C                     STATEMENT IS TO BE DELETED BY THE SUBSET
C           LIMIT     LOWER/UPPER LIMITS OF VALUES WITHIN AN
C                     ENTRY ON THE CARD
C
C     LOCAL VARIABLES
C       IEND          VALUE OF NUM(2)
C       ISTR          VALUE OF NUM(1)
C
C     FUNCTIONS
C        XRGSUB CALLS XRGDEV TO EXTRAPOLATE THE NUMBER FROM THE
C        THE CARD AND THEN IT COMPARES THE NUMBER(S) WITH THOSE
C        SUPPLIED BY THE USER AS SUBSETS.  IF A MATCH IS FOUND,
C        IGNORE IS SET AND THE MODULE EXECUTION DECISION TABLE
C        ENTRY IS SET TO ZERO.  CHECKS CONTINUE UNTIL ALL VALUES
C        GIVEN ON ****SBST CARD HAD BEEN CHECK OR UNTIL A MATCH
C        IS FOUND
C
C     SUBROUTINES CALLED - XDCODE,XRGDEV
C
C     CALLING SUBROUTINES - XRGDFM
C
C     ERRORS - NONE
C
C****
      INTEGER         RECORD,SUBSET(12),IRESTB(7)
      COMMON /XRGDXX/ IRESTR,NSUBST,IPHASE,ICOL,NUMBER,ITYPE,
     1               ISTATE,IERROR,NUM(2),IND,NUMENT,
     2               RECORD(20),ICHAR(80),LIMIT(2),
     3               ICOUNT,IDMAP,ISCR,NAME(2),MEMBER(2),IGNORE
C
       ICOL   = 9
       IERROR = 0
       CALL XDCODE
       LIMIT(1) = 1
       LIMIT(2) = 12
 200   CALL XRGDEV
       IF (IERROR.NE.0 .OR. ICOL.GT.80) GO TO 700
       ISTR = NUM(1)
       IEND = NUM(2)
       DO 400 K  = ISTR,IEND
       DO 300 KK = 1,NSUBST
       IF (K .EQ. SUBSET(KK)) GO TO 500
 300   CONTINUE
 400   CONTINUE
       ICOL = ICOL + 1
       GO TO 200
 500   DO 600 K = 1,NUMENT
       IRESTB(K) = 0
 600   CONTINUE
       IGNORE = 1
 700   RETURN
       END
