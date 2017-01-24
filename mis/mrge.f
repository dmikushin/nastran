      SUBROUTINE MRGE (LIST, N, STRING, M)
C*****
C MRGE IS A MERGE ROUTINE. GIVEN A SORTED LIST AND A SORTED STRING,
C MRGE ADDS THE ENTRIES IN THE STRING TO THE LIST IN THEIR APPROPRIATE
C POSITIONS.  DUPLICATES ARE DISCARDED.
C
C  ARGUMENTS
C
C     LIST   --- THE ARRAY CONTAINING THE SORTED LIST
C     N      --- THE NUMBER OF TERMS BEFORE AND AFTER THE MERGE
C     STRING --- THE ARRAY CONTAINING THE SORTED STRING
C     M      --- THE NUMBER OF TERMS IN THE STRING
C
C*****
      INTEGER LIST(1), STRING(1)
C
C LOCATE THE POSITION IN THE LIST OF THE FIRST TERM IN THE STRING
C
      KK = 1
      ID = STRING(KK)
      CALL BISLOC (*12, ID, LIST, 1, N, K)
      KSTART = MIN0( K+1, N )
      K2 = 2
      GO TO 13
   12 KSTART = MAX0( 1, K-1 )
      K2 = 1
C
C CREATE A HOLE IN THE LIST BY MOVING THE END OF THE LIST.
C
   13 K = N
   14 LIST(K+M) = LIST(K)
      K = K - 1
      IF( K .GE. KSTART ) GO TO 14
      K1 = KSTART + M
      NM = N + M
      K = KSTART
C
C NOW ADD TO THE LIST BY MERGING FROM THE TWO STRINGS
C
   16 IF( K1 .GT. NM ) GO TO 60
      IF( K2 .GT. M  ) GO TO 50
      IF (LIST(K1) - STRING(K2)) 20, 40, 30
C
C    CHOOSE TERM FROM OLD LIST
C
   20 LIST(K) = LIST(K1)
      K1 = K1 + 1
      K  = K  + 1
      GO TO 16
C
C    CHOOSE TERM FROM STRING
C
   30 LIST(K) = STRING(K2)
      K2 = K2 + 1
      K  = K  + 1
      GO TO 16
C
C    DUPLICATES -- DISCARD TERM FROM STRING
C
   40 K2 = K2 + 1
      GO TO 20
C
C    STRING EXHAUSTED -- COMPLETE LIST FROM OLD LIST
C
   50 DO 52 KX=K1,NM
      LIST(K) = LIST(KX)
      K = K + 1
   52 CONTINUE
      GO TO 68
C
C    OLD LIST EXHAUSTED -- COMPLETE LIST FROM STRING
C
   60 IF( K2 .GT. M ) GO TO 68
      DO 62 KX=K2,M
      LIST(K) = STRING(KX)
      K = K + 1
   62 CONTINUE
C
C RETURN NEW NUMBER OF TERMS IN LIST.
C
   68 N = K - 1
      RETURN
      END
