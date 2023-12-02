!*==xread.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE xread(Bufx) !HIDESTARS (*,Bufx)
!
!     THIS ROUTINE MAKES FREE-FIELD INPUT PACKAGE (HANDLED BY FFREAD)
!     COMPLETELY MACHINE INDEPENDENT.
!
!     IF THE XSORT FLAG IN /XECHOX/ IS TURNED ON (XSORT=1), THIS ROUTINE
!     WILL ALSO PREPARES THE NECESSARY GROUND WORK SO THAT THE INPUT
!     CARDS CAN BE SORTED EFFICIENTLY IN XSORT2 ROUTINE. ALL FIELDS IN
!     THE INPUT CARDS ARE ALSO LEFT-ADJUSTED FOR PRINTING.
!
!     WRITTEN BY G.CHAN/UNISYS.   OCT. 1987
!     LAST REVISED, 1/1990, IMPROVED EFFICIENCY BY REDUCING CHARACTER
!     OPERATIONS (VERY IMPORTANT FOR CDC MACHINE)
!
   USE c_machin
   USE c_system
   USE c_xechox
   USE c_xmssg
   USE c_xsortx
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER , DIMENSION(20) :: Bufx
!
! Local variable declarations rewritten by SPAG
!
   LOGICAL :: alpha , bcd2 , bcd3 , double , numric
   INTEGER :: blank1 , cdc , d1 , dollr1 , e1 , er , fp , fromy , i , ib , ie , ioo , ioooo , j , j1 , je , k , l , minus1 ,        &
            & point1 , sign , sigx , slash1 , star1 , sum , type , word , zero1
   INTEGER , SAVE :: blank4 , derr , equal4 , n1 , n2 , n3 , n4 , n5 , n6 , n7 , nname , plus1
   CHARACTER(8) , SAVE :: blank8 , slash8
   CHARACTER(1) , SAVE :: blankk , equ1
   INTEGER , DIMENSION(80) :: card1
   CHARACTER(8) , DIMENSION(10) :: card8
   CHARACTER(80) :: card80
   CHARACTER(8) :: card81
   CHARACTER(8) , DIMENSION(3) , SAVE :: end8
   CHARACTER(1) , DIMENSION(80) :: kard1
   INTEGER , DIMENSION(43) :: khr1
   CHARACTER(43) , SAVE :: khr43
   CHARACTER(1) , DIMENSION(43) :: khrk
   CHARACTER(8) , DIMENSION(15) , SAVE :: name8
   INTEGER , DIMENSION(2) , SAVE :: sub
   INTEGER :: spag_nextblock_1
!
! End of declarations rewritten by SPAG
!
   !>>>>EQUIVALENCE (kard1(1),card8(1),card80,card81) , (blank1,khr1(1)) , (khr43,khrk(1)) , (zero1,khr1(2)) , (d1,khr1(15)) ,           &
!>>>>    & (e1,khr1(16)) , (slash1,khr1(38)) , (dollr1,khr1(39)) , (star1,khr1(40)) , (plus1,khr1(41)) , (minus1,khr1(42)) ,             &
!>>>>    & (point1,khr1(43))
   DATA blank8 , slash8 , blank4 , equal4 , sub/'    ' , '/   ' , 4H     , 4H==== , 4HXREA , 4HD   /
   DATA nname/15/ , name8/'SPC1 ' , 'SPCS ' , 'TICS ' , 'MPCS ' , 'MPCAX' , 'RELES' , 'GTRAN' , 'FLUTTER' , 'BDYC ' , 'SPCSD' ,     &
       &'SPCS1' , 'RANDPS' , 'DAREAS' , 'DELAYS' , 'DPHASES'/
   DATA end8/'ENDDATA ' , 'ENDATA ' , 'END DATA'/ , derr/ - 1/
!
   DATA khr43/' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ/$*+-.'/
!                      2 4 6 8 1 2 4 6 8 2 2 4 6 8 3 2 4 6 8 4 2
!                              0         0         0         0
   DATA n7 , n1 , n2 , n3 , n4 , n5 , n6/44 , 1 , 2 , 11 , 37 , 41 , 43/
   DATA plus1 , blankk , equ1/0 , ' ' , '='/
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
         IF ( plus1==0 ) CALL k2b(khr43,khr1,43)
!
!     CALL FFREAD TO READ INPUT CARD
!     IF INPUT IS A COMMENT CARD, SET IBUF(1)=-1, AND RETURN
!     IF INPUT IS IN FREE-FIELD, ALL 10 BULKDATA FIELDS ARE ALREADY
!     LEFT-ADJUSTED, AND WASFF IS SET TO +1 BY FFREAD
!     IF INPUT IS IN FIXED-FIELD, ALL 10 BULKDATA FIELDS MAY NOT BE IN
!     LEFT-ADJUSTED FORMAT, AND WASFF IS SET TO -1 BY FFREAD
!
         CALL ffread(*20,card8)
         CALL k2b(card80,card1,80)
         IF ( card1(1)==dollr1 ) THEN
            spag_nextblock_1 = 15
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ie = 0
         IF ( xsort/=0 .AND. wasff/=1 ) THEN
!
!     LEFT-ADJUSTED THE BULKDATA FIELDS, FIRST 9 FIELDS
!     (FIRST 4 AND A HALF FIELDS IF DOUBLE FIELD CARDS)
!
            ib = 1
            l = 8
            IF ( card1(1)==plus1 .OR. card1(1)==star1 ) ib = 9
            IF ( card1(1)==star1 ) l = 16
            DO i = ib , 72 , l
               IF ( card1(i)==blank1 ) THEN
                  k = i
                  je = i + l - 1
                  DO j = i , je
                     IF ( card1(j)/=blank1 ) THEN
                        card1(k) = card1(j)
                        kard1(k) = kard1(j)
                        k = k + 1
                     ENDIF
                  ENDDO
                  IF ( k/=i ) THEN
                     DO j = k , je
                        kard1(j) = blankk
                        card1(j) = blank1
                     ENDDO
                  ENDIF
               ENDIF
            ENDDO
         ENDIF
         SPAG_Loop_1_1: DO
!
!     CHECK COMMENT CARD WITH DOLLAR SIGN NOT IN COLUMN 1. CONVERT
!     CHARACTER STRING TO BCD STRING, AND RETURN TO CALLER IF IT IS
!     NOT CALLED BY XSORT.
!
            ie = ie + 1
            IF ( card1(ie)/=blank1 ) THEN
               IF ( card1(ie)==dollr1 ) THEN
!
                  IF ( xsort==0 ) kard1(ie) = khrk(1)
                  spag_nextblock_1 = 15
                  CYCLE SPAG_DispatchLoop_1
               ELSE
                  CALL khrbcd(card80,Bufx)
                  IF ( xsort==0 ) THEN
!
                     ibuf(1) = 0
                     spag_nextblock_1 = 16
                     CYCLE SPAG_DispatchLoop_1
                  ELSE
!
!
!     IF THIS ROUTINE IS CALLED BY XSORT, PASS THE FIRST 3 FIELDS TO
!     IBUF ARRAY IN /XSORTX/, IN INTEGER FORMS
!
!     FIRST BULKDATA FIELD IS ALPHA-NUMERIC, COMPOSED OF TWO 4-CHARACTER
!     WORDS. CHECK WHETHER OR NOT THIS IS A CONTINUATION OR COMMENT CARD
!     IF IT IS NOT, WE CHANGE ALL 8 CHARACTER BYTES INTO THEIR NUMERIC
!     CODE VALUES GIVEN BY TABLE /KHR43/ AND STORE THE VALUE IN IBUF(1)
!     AND IBUF(2)
!
!     WE SET IBUF(1) AND (2)    IF INPUT CARD IS
!     ----------------------    -------------------
!                -1             A COMMENT CARD
!                -2             A CONTINUATION CARD
!                -3             A DELETE CARD (RANGE IN IBUF(3) AND (4))
!                -3, -4         A DIRTY DELETE CARD
!                -5             A BLANK CARD
!                -9             A ENDDATA CARD
!     AND IBUF(2) AND IBUF(3) ARE NOT SET, EXECPT -3 CASE
!
!     IF FIELD 2 AND/OR FIELD 3 ARE IN CHARACTERS, WE PUT THE FIRST 6
!     BYTES (OUT OF POSSIBLE 8 CHARACTER-BYTES) INTO IBUF(3) AND/OR
!     IBUFF(4) RESPECTIVELY, IN INTERNAL NUMERIC CODE QUITE SIMILAR TO
!     RADIX-50
!     IF FIELD 2 HAS MORE THAN 7 CHARACTERS, IBUF(4) IS USED TO RECEIVE
!     THE LAST 2 CHARACTERS OF FIELD 2
!
!     IF FIELD 2 AND/OR FIELD 3 ARE NUMERIC DATA (0-9,+,-,.,E), THEIR
!     ACTUAL INTEGER VALUES ARE STORED IBUF(3) AND/OR IBUF(4).
!     IF THEY ARE F.P. NUMBERS, THEIR EXPONENT VALUES (X100000) ARE
!     CHANGED INTO INTEGERS, AND THEN STORED IN IBUF(3) AND/OR IBUF(4)
!
!     NOTE - XREAD WILL HANDLE BOTH SINGLE- AND DOUBLE-FIELD BULKDATA
!     INPUT IN FIELDS 2 AND 3, AND MOVED THEM ACCORDINGLY INTO IBUF(3)
!     AND IBUF(4)
!
!
!     PRESET TABLE IF THIS IS VERY FIRST CALL TO XREAD ROUTINE
!     TABLE SETTING IS MOVED UP BY ONE IF MACHINE IS CDC (TO AVOID
!     BLANK CHARACTER WHICH IS ZERO FROM ICHAR FUNCTION)
!
                     fromy = 0
                     IF ( xsort==1 ) THEN
                        xsort = 2
                        cdc = 0
                        IF ( mach==4 ) cdc = 1
                        DO i = 1 , 255
                           table(i) = n7
                        ENDDO
                        DO i = 1 , n6
                           j = ichar(khrk(i)) + cdc
                           table(j) = i
                        ENDDO
                        f3long = 0
                        large = rshift(complf(0),1)/20
                     ENDIF
                     EXIT SPAG_Loop_1_1
                  ENDIF
               ENDIF
            ENDIF
         ENDDO SPAG_Loop_1_1
         spag_nextblock_1 = 2
      CASE (2)
!
!     CHECK BLANK, ENDDATA, AND CONTINUATION CARDS
!
         er = 0
         j1 = card1(1)
         j = table(ichar(kard1(1))+cdc)
         IF ( j>=n7 ) THEN
            spag_nextblock_1 = 17
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( card81==blank8 .AND. card8(2)==blank8 ) THEN
            ibuf(1) = -5
            ibuf(2) = ibuf(1)
            spag_nextblock_1 = 16
            CYCLE SPAG_DispatchLoop_1
         ELSE
            IF ( card81==end8(1) .OR. card81==end8(2) .OR. card81==end8(3) ) THEN
               ibuf(1) = -9
               ibuf(2) = ibuf(1)
               spag_nextblock_1 = 16
               CYCLE SPAG_DispatchLoop_1
            ELSE
               IF ( j1/=plus1 .AND. j1/=star1 ) THEN
!
!     CHECK ASTERISK IN FIELD 1 (BUT NOT IN COLUMN1 1) AND SET DOUBLE-
!     FIELD FLAG. MERGE EVERY TWO SINGLE FIELDS TO ENSURE CONTINUITY OF
!     DOUBLE FIELD DATA (FIXED FIELD CARDS ONLY)
!
                  double = .FALSE.
                  IF ( wasff/=1 ) THEN
                     ie = 8
                     DO j = 2 , 8
                        IF ( card1(ie)==star1 ) GOTO 5
                        ie = ie - 1
                     ENDDO
                  ENDIF
                  GOTO 10
               ELSE
                  ibuf(1) = -2
                  ibuf(2) = ibuf(1)
                  spag_nextblock_1 = 16
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
 5             double = .TRUE.
               ib = 0
               DO i = 8 , 71 , 16
                  k = i
                  DO j = 1 , 16
                     l = i + j
                     IF ( card1(l)/=blank1 ) THEN
                        k = k + 1
                        IF ( k/=l ) THEN
                           ib = 1
                           card1(k) = card1(l)
                           kard1(k) = kard1(l)
                        ENDIF
                     ENDIF
                  ENDDO
                  IF ( k/=l ) THEN
                     k = k + 1
                     DO j = k , l
                        kard1(j) = blankk
                        card1(j) = blank1
                     ENDDO
                  ENDIF
               ENDDO
               IF ( ie<=0 ) CALL mesage(-37,0,sub)
               IF ( ib==1 ) CALL khrbcd(card80,Bufx)
               card1(ie) = blank1
               kard1(ie) = blankk
            ENDIF
!
!     CHECK DELETE CARD
!     SET IBUF(1)=IBUF(2)=-3 IF IT IS PRESENT, AND SET THE DELETE RANGE
!     IN IBUF(3) AND IBUF(4)
!     SET IBUF(1)=-3 AND IBUF(2)=-4 IF TRASH FOUND AFTER SLASH IN
!     FIELD 1
!     NOTE - IF FIELD 3 IS BLANK, IBUF(4) IS -3
!
 10         IF ( j1/=slash1 ) THEN
!
!     TURN BCD2 AND BCD3 FLAGS ON IF THE 2ND AND 3RD INPUT FIELDS ARE
!     NOT NUMERIC RESPECTIVELY
!     IF 2ND FIELD HAS MORE THAN 6 CHARACTERS, REPLACE 3RD FIELD BY THE
!     7TH AND 8TH CHARACTERS OF THE 2ND FIELD
!     (FOR DMI AND DTI CARDS, MERGE 7TH AND 8TH CHARACTERS INTO 3RD
!     FIELD AND TREAT THE ORIG. 3RD FIELD AS A NEW BCD WORD)
!     IF 3RD FIELD HAS MORE THAN 6 CHARACTERS, SET F3LONG FLAG TO 1, AND
!     USER INFORMATION MESSAGE 217A WILL BE PRINTED BY XSORT
!     FIELDS 2 AND 3 SHOULD NOT START WITH A /, $, *
!     IF FIELD2 IS A BCD WORD, FIELD3 PROCESSING ACTUALLY BEGINS IN
!     CARD8(4)
!
               bcd2 = .FALSE.
               IF ( derr==+1 ) derr = 0
               j = table(ichar(kard1(9))+cdc)
               IF ( j>=n7 ) THEN
                  spag_nextblock_1 = 17
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               numric = (j>=n2 .AND. j<=n3) .OR. j>=n5
               IF ( .NOT.(numric) ) THEN
                  bcd2 = .TRUE.
                  IF ( card1(15)/=blank1 ) THEN
!
!     SINCE THE NAME IN THE 2ND FIELD OF DMI, DTI, DMIG, DMIAX CARDS
!     ARE NOT UNIQUELY DEFINED FOR SORTING, SPECIAL CODES HERE TO MOVE
!     THE LAST PART OF A LONG NAME (7 OR 8 LETTER NAME) INTO THE 3RD
!     FIELD, AND TREAT THE NEW 3RD FIELD AS BCD WORD. THUS THE ORIGINAL
!     3RD FIELD (THE COLUMN NUMBER, RIGHT ADJUSTED WITH LEADING ZEROS)
!     IS LIMITED TO 4 DIGITS OR LESS.  IF THE NAME IN THE 2ND FIELD IS
!     SHORT (6 LETTERS OR LESS), MERGING OF THE 3RD FIELD IS NOT NEEDED.
!
                     IF ( card1(1)/=d1 .OR. card1(3)/=khr1(20) .OR. (card1(2)/=khr1(24) .AND. card1(2)/=khr1(31)) ) THEN
!
                        kard1(17) = kard1(15)
                        kard1(18) = kard1(16)
                        DO k = 19 , 24
                           kard1(k) = blankk
                        ENDDO
                     ELSE
                        bcd3 = .TRUE.
                        k = 24
                        IF ( double ) k = 32
                        IF ( card1(k-3)/=blank1 ) THEN
                           IF ( echou/=1 ) THEN
                              IF ( derr==-1 ) CALL page
                              CALL page2(-2)
                              IF ( double ) card1(8) = star1
                              WRITE (nout,99001) card8
99001                         FORMAT (30X,10A8)
                              IF ( double ) card1(8) = blank1
                           ENDIF
                           CALL page2(-2)
                           WRITE (nout,99002) ufm
99002                      FORMAT (A23,', THE 3RD INPUT FIELD OF THE ABOVE CARD IS LIMITED ',                                       &
                                  &'TO 4 OR LESS DIGITS, WHEN A NAME OF 7 OR MORE',/5X,'LETTERS IS USED IN THE 2ND FIELD',/)
                           derr = +1
                           nogo = 1
                        ENDIF
                        SPAG_Loop_1_2: DO j = 1 , 4
                           IF ( card1(k-4)/=blank1 ) EXIT SPAG_Loop_1_2
                           kard1(k-4) = kard1(k-5)
                           kard1(k-5) = kard1(k-6)
                           kard1(k-6) = kard1(k-7)
                           kard1(k-7) = blankk
                        ENDDO SPAG_Loop_1_2
                        DO j = 1 , 6
                           kard1(k) = kard1(k-2)
                           k = k - 1
                        ENDDO
                        kard1(k) = kard1(16)
                        kard1(k-1) = kard1(15)
                        kard1(15) = blankk
                        GOTO 15
                     ENDIF
                  ENDIF
               ENDIF
!
               bcd3 = .FALSE.
               k = 17
               IF ( double ) k = 25
               j = table(ichar(kard1(k))+cdc)
               alpha = j==n1 .OR. (j>n3 .AND. j<n5)
               IF ( alpha ) bcd3 = .TRUE.
               IF ( .NOT.(bcd3) ) THEN
!
!     THE FIRST 3 FIELDS OF THE DMIG OR DMIAX CARDS (NOT THE 1ST HEADER
!     CARD), ARE NOT UNIQUE. MERGE THE 4TH FIELD (1 DIGIT INTEGER) INTO
!     THE 3RD FIELD (INTEGER, 8 DIGITS OR LESS) TO INCLUDE THE COMPONENT
!     FIELD FOR SORTING
!
                  IF ( .NOT.(card1(1)/=d1 .OR. card1(2)/=khr1(24) .OR. card1(3)/=khr1(20) .OR.                                      &
                     & (card1(4)/=khr1(18) .AND. card1(4)/=khr1(12))) ) THEN
                     IF ( card1(1)/=khr1(2) ) THEN
                        k = 24
                        IF ( double ) k = 32
                        IF ( card1(k)==blank1 ) THEN
                           SPAG_Loop_1_3: DO j = 1 , 7
                              k = k - 1
                              IF ( card1(k)/=blank1 ) EXIT SPAG_Loop_1_3
                           ENDDO SPAG_Loop_1_3
                           kard1(k+1) = kard1(25)
                           IF ( double ) kard1(k+1) = kard1(41)
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF
!
!
!     CHANGE ALL CHARACTERS IN FIRST 3 FIELDS TO INTEGER INTEGER CODES
!     ACCORDING TO THE TABLE ARRANGEMENT IN /KHR43/
!     MAKE SURE THE INTERNAL CODE IS NOT IN NASTRAN INTEGER RANGE (1 TO
!     8 DIGITS), AND WITHIN MACHINE INTEGER WORD LIMIT
!     IN 2ND AND 3RD FIELDS, INTERCHANGE ALPHABETS AND NUMERIC DIGITS
!     SEQUENCE TO AVOID SYSTEM INTEGER OVERFLOW
!
!     -------------- REMEMBER, FROM HERE DOWN,
!                    CARD1 (1-BYTE ) HOLD ONE CHARACTER, AND
!                    IBUFX (4-BYTES) HOLD AN  INTEGER -----------------
!     WE ALSO HAVE   CARD8 (8-BYTES) HOLDING 8 CHARACTERS,
!              AND   BUFX  (4-BYTES) HOLDING 4 BCD-CHARACTERS
!
!
!     MAP OF THE FIRST 3 BULKDATA FIELDS -
!     (INPUT)
!
!           WORD1 WORD2 WORD3 WORD4 WORD5 WORD6 WORD7 WORD8 WORD9 WORD10
!     BYTE: 1         8 9        16 17       24 25       32 33       40
!          +-----+-----+-----+-----+-----+-----+-----+-----+-----+-----+
!     SF:  !<-FIELD 1->!<-FIELD 2->!<-FIELD 3->!
!     DF:  !<-FIELD 1->!<------ FIELD 2 ------>!<------ FIELD 3 ------>!
!
!
!     MAP OF IBUF -           WORD1 WORD2 WORD3 WORD4
!     (OUTPUT)         BYTE:  1         8 9  12 13 16
!                            +-----+-----+-----+-----+
!     FOR CORE SORT          !<-FIELD 1->!<--->!<--->!
!     PERFORMED IN                        FIELD FIELD
!     XSORT2                                 2     3
!
 15            numric = .FALSE.
               l = 0
               ioo = 100
               word = 0
               word = word + 1
            ELSE
               DO l = 1 , 4
                  ibuf(l) = -3
               ENDDO
               IF ( card81/=slash8 ) ibuf(2) = -4
               l = 2
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         spag_nextblock_1 = 3
      CASE (3)
         ie = word*4
         ib = ie - 3
         j = table(ichar(kard1(ib))+cdc)
         IF ( j>=n7 ) THEN
            spag_nextblock_1 = 17
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( .NOT.(mod(word,2)==0 .AND. .NOT.numric) ) THEN
            numric = (j>=n2 .AND. j<=n3) .OR. j>=n5
            IF ( numric ) THEN
               spag_nextblock_1 = 4
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         IF ( ioo/=100 ) THEN
            ie = ie + 2
            k = j
            IF ( k>n3 ) j = k - n3
            IF ( k<=n3 ) j = k + 25
         ENDIF
         sum = j
         ib = ib + 1
         DO i = ib , ie
            j = table(ichar(kard1(i))+cdc)
            sum = sum*ioo + j
         ENDDO
         IF ( ioo==100 ) sum = sum + 200000000
         ibuf(l+1) = sum
         spag_nextblock_1 = 4
      CASE (4)
         SPAG_Loop_1_4: DO
            l = l + 1
            IF ( l==1 ) THEN
               word = word + 1
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ELSEIF ( l==2 ) THEN
               ioo = n4
               IF ( bcd2 ) THEN
                  word = 3
                  spag_nextblock_1 = 3
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ELSEIF ( l==3 ) THEN
               word = 5
               IF ( double ) word = 7
               IF ( .NOT.(.NOT.bcd2 .OR. kard1(15)==blankk) ) THEN
                  word = 4
                  ioo = 100
                  bcd3 = .TRUE.
               ENDIF
               IF ( bcd3 ) THEN
                  IF ( word/=4 .AND. kard1(word*4+3)/=blankk .AND. derr/=+1 ) f3long = 1
                  spag_nextblock_1 = 3
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ELSE
!
!     CHECK INTEGERS ON 2ND AND 3RD FIELDS
!
               IF ( bcd2 .AND. bcd3 ) THEN
                  spag_nextblock_1 = 7
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               l = 2
               IF ( bcd2 ) l = 3
               EXIT SPAG_Loop_1_4
            ENDIF
         ENDDO SPAG_Loop_1_4
         spag_nextblock_1 = 5
      CASE (5)
         SPAG_Loop_1_5: DO
            l = l + 1
            IF ( l<4 ) THEN
               ib = 9
            ELSEIF ( l==4 ) THEN
               ib = 17
               IF ( double ) ib = 25
            ELSE
               spag_nextblock_1 = 7
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            ie = ib + 7
            IF ( double ) ie = ib + 15
            j1 = card1(ib)
            IF ( j1==plus1 .OR. j1==minus1 .OR. j1==point1 .OR. j1==zero1 ) THEN
!
!     IT IS NUMERIC
!
               ib = ib + 1
               EXIT SPAG_Loop_1_5
            ELSE
               j = table(ichar(kard1(ib))+cdc)
!
!     IT IS CHARACTER FIELDS, NOTHING ELSE NEEDS TO BE DONE
!
               IF ( j>=n2 .AND. j<=n3 ) EXIT SPAG_Loop_1_5
            ENDIF
         ENDDO SPAG_Loop_1_5
         sum = 0
         fp = 0
         sigx = 1
         sign = 1
         IF ( j1==minus1 ) sign = -1
         IF ( j1==point1 ) fp = 1
         SPAG_Loop_1_6: DO i = ib , ie
            IF ( kard1(i)==blankk ) EXIT SPAG_Loop_1_6
            j = table(ichar(kard1(i))+cdc) - n2
            IF ( j<0 .OR. j>9 ) THEN
!
!     A NON-NUMERIC SYMBOL FOUND IN NUMERIC STRING
!     ONLY 'E', 'D', '+', '-', OR '.' ARE ACCEPTABLE HERE
!
               j1 = card1(i)
               IF ( j1==point1 ) THEN
                  fp = 1
               ELSE
                  IF ( fp==0 .OR. ibuf(3)==-3 ) THEN
                     spag_nextblock_1 = 6
                     CYCLE SPAG_DispatchLoop_1
                  ENDIF
                  IF ( j1/=e1 .AND. j1/=d1 .AND. j1/=plus1 .AND. j1/=minus1 ) THEN
                     spag_nextblock_1 = 6
                     CYCLE SPAG_DispatchLoop_1
                  ENDIF
                  IF ( j1==minus1 ) sigx = -1
                  fp = -1
                  sum = 0
               ENDIF
            ELSE
               IF ( fp<=0 .AND. iabs(sum)<large ) sum = sum*10 + sign*j
            ENDIF
!
         ENDDO SPAG_Loop_1_6
!
!     BEEF UP NUMERIC DATA BY 2,000,000,000 SO THAT THEY WILL BE
!     SORTED BEHIND ALL ALPHABETIC DATA, AND MOVE THE NUMERIC DATA, IN
!     INTEGER FORM (F.P. MAY NOT BE EXACT) INTO IBUF(3) OR IBUF(4)
!
         IF ( fp<0 ) THEN
            ibuf(l) = sign*2000000000
            IF ( sigx>0 .AND. sum<9 ) ibuf(l) = sign*(10**(sigx*sum)+2000000000)
            IF ( sigx>0 .AND. sum>=9 ) ibuf(l) = 2147000000*sign
         ELSE
            ibuf(l) = sum + sign*2000000000
         ENDIF
         spag_nextblock_1 = 5
         CYCLE SPAG_DispatchLoop_1
      CASE (6)
!
!     ERROR IN NUMERIC FIELD
!
         IF ( ib==10 .OR. ib==18 ) ib = ib - 1
         k = 1
         IF ( echou==0 .AND. er/=-9 ) k = 2
         CALL page2(-k)
         IF ( echou==0 .AND. er/=-9 ) WRITE (nout,99005) card80
         k = 2
         IF ( double ) THEN
            k = 4
            IF ( l/=4 ) word = word + 1
         ENDIF
         IF ( l==4 ) word = word + 2
         WRITE (nout,99006) (blank4,i=1,word) , (equal4,i=1,k)
         nogo = 1
         er = -9
         spag_nextblock_1 = 7
      CASE (7)
!
!     BOTH FIELDS 2 AND 3 (OF BULK DATA CARD) DONE.
!
!
!     FOR MOST BULK DATA CARDS, EXCEPT THE ONES IN NAME8, THE FIRST
!     3 FIELDS, IN INTERNAL CODES AND SAVED IN THE IBUF 4-WORD ARRAY,
!     ARE SUFFICIENT FOR ALPHA-NUMERIC SORT (BY XSORT2)
!
!     THOSE SPECIAL ONES IN NAME8 ADDITIONAL FIELDS FOR SORTING
!
         DO type = 1 , nname
            IF ( card81==name8(type) ) THEN
               IF ( type==1 .OR. type==2 .OR. type==3 .OR. type==4 .OR. type==6 .OR. type==7 .OR. type==8 .OR. type==9 ) THEN
                  spag_nextblock_1 = 8
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               IF ( type==5 ) THEN
                  spag_nextblock_1 = 13
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               IF ( type==10 .OR. type==13 .OR. type==14 .OR. type==15 ) THEN
                  spag_nextblock_1 = 10
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               IF ( type==11 ) THEN
                  spag_nextblock_1 = 11
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               IF ( type==12 ) THEN
                  spag_nextblock_1 = 12
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDIF
!
!    1   SPC1   SPCS   TICS   MPCS  MPCAX  RELES   GTRAN  FLUTTER
!    2   BDYC  SPCSD   SPCS1 RANDPS DELAYS DAREAS  DPHASES
!
         ENDDO
         spag_nextblock_1 = 14
         CYCLE SPAG_DispatchLoop_1
      CASE (8)
!
!     SPC1,SPCS,TICS,MPCS,RELES,GTRAN,FLUTTER,BDYC CARDS -
!     ADD 4TH INTEGER FIELD TO IBUF ARRAY
!
         ibuf(2) = ibuf(3)
         ibuf(3) = ibuf(4)
         spag_nextblock_1 = 9
      CASE (9)
         sum = 0
         SPAG_Loop_1_7: DO i = 25 , 32
            j1 = card1(i)
            IF ( j1==blank1 ) EXIT SPAG_Loop_1_7
            j = table(ichar(kard1(i))+cdc) - n2
            IF ( j>=0 .AND. j<=9 ) sum = sum*10 + j
         ENDDO SPAG_Loop_1_7
         ibuf(4) = sum
         IF ( type==12 ) ibuf(4) = ibuf(4) + ioooo
         spag_nextblock_1 = 14
         CYCLE SPAG_DispatchLoop_1
      CASE (10)
!
!     DAREAS,DELAYS,DPHASES,SPCSD CARDS -
!     ADD ONE TO IBUF(1), THUS CREATE DARF,DELB,DPHB,OR SPCT IN
!     IBUF(1), THEN ADD 4TH INTEGER FIELD INTO IBUF ARRAY
!
         ibuf(1) = ibuf(1) + 1
         spag_nextblock_1 = 8
         CYCLE SPAG_DispatchLoop_1
      CASE (11)
!
!     SPCS1 CARD -
!     ADD TWO TO IBUF(1), THUS CREATE SPCU IN IBUF(1), THEN ADD
!     4TH INTEGER FIELD INTO IBUF ARRAY
!
         ibuf(1) = ibuf(1) + 2
         spag_nextblock_1 = 8
         CYCLE SPAG_DispatchLoop_1
      CASE (12)
!
!     RANDPS -
!     MERGE FIELDS 3 AND 4 IF SUBCASE NUMBERS ARE NOT TOO BIG
!
         IF ( ibuf(4)>=10000 .OR. Bufx(8)/=blank4 ) THEN
            spag_nextblock_1 = 14
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ioooo = ibuf(4)*10000
         spag_nextblock_1 = 9
         CYCLE SPAG_DispatchLoop_1
      CASE (13)
!
!     MPCAX -
!     MOVE THE 6TH FIELD INTO IBUF(4)
!
         j = 41
         DO i = 25 , 32
            card1(i) = card1(j)
            kard1(i) = kard1(j)
            j = j + 1
         ENDDO
         spag_nextblock_1 = 9
         CYCLE SPAG_DispatchLoop_1
      CASE (14)
!
!     CHECK NUMERIC ERROR IN 4TH TO 9TH FIELDS IF NO ERROR IN FIRST
!     3 FIELDS (NEW BULK DATA CARDS ONLY)
!
         IF ( fromy==1 .OR. er==-9 ) THEN
            spag_nextblock_1 = 16
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         word = 5
         IF ( double ) word = 7
         SPAG_Loop_1_8: DO
            word = word + 2
            IF ( double ) word = word + 2
            IF ( word>=19 ) THEN
               spag_nextblock_1 = 16
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            ib = word*4 - 3
            j = table(ichar(kard1(ib))+cdc)
            IF ( j<n7 ) THEN
               alpha = j==n1 .OR. (j>n3 .AND. j<n5)
               IF ( .NOT.(alpha) ) THEN
                  ie = ib + 7
                  IF ( double ) ie = ib + 15
                  l = ib + 1
                  SPAG_Loop_2_9: DO i = l , ie
                     j1 = card1(i)
                     IF ( j1==blank1 ) CYCLE SPAG_Loop_1_8
                     j = table(ichar(kard1(i))+cdc)
                     numric = (j>=n2 .AND. j<=n3) .OR. (j>=n5 .AND. j<=n6)
                     IF ( .NOT.(numric .OR. j==15 .OR. j==16) ) THEN
!                           D            E
                        k = 1
                        IF ( echou==0 .AND. er/=-9 ) k = 2
                        CALL page2(-k)
                        IF ( echou==0 .AND. er/=-9 ) WRITE (nout,99005) card80
                        word = word + 2
                        k = 2
                        IF ( double ) k = 4
                        WRITE (nout,99006) (blank4,j=1,word) , (equal4,j=1,k)
                        nogo = 1
                        EXIT SPAG_Loop_2_9
                     ENDIF
                  ENDDO SPAG_Loop_2_9
                  spag_nextblock_1 = 16
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDIF
         ENDDO SPAG_Loop_1_8
         spag_nextblock_1 = 15
      CASE (15)
         IF ( xsort==0 ) kard1(1) = khrk(39)
         ibuf(1) = -1
         CALL khrbcd(card80,Bufx)
         spag_nextblock_1 = 16
      CASE (16)
!
         RETURN
      CASE (17)
!
         IF ( xsort/=2 ) THEN
            WRITE (nout,99003) xsort
99003       FORMAT (//,' *** TABLE IN XREAD HAS NOT BEEN INITIALIZED.',/5X,'XSORT=',I4)
            CALL mesage(-37,0,sub)
         ENDIF
         WRITE (nout,99004) card8
99004    FORMAT (/,' *** ILLEGAL CHARACTER ENCOUNTERED IN INPUT CARD',/4X,1H',10A8,1H')
         nogo = 1
 20      RETURN 1
!
!
         ENTRY yread(Bufx)
                     !HIDESTARS (*,Bufx)
!     ====================
!
!     YREAD IS CALLED ONLY BY XSORT TO RE-PROCESS CARD IMAGES FROM
!     THE OPTP FILE
!
         CALL bcdkh8(Bufx,card80)
         CALL k2b(card80,card1,80)
         fromy = 1
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
!
!
         ENTRY rmveq(Bufx)
!     ==================
!
!     RMVEQ, CALLED ONLY BY XCSA, REMOVES AN EQUAL SIGN FROM TEXT.
!     THUS, 1 EQUAL SIGN BEFORE COLUMN 36 IS ALLOWED ON ONE EXECUTIVE
!     CONTROL LINE
!
!     AT THIS POINT, THE DATA IN KARD1 IS STILL GOOD
!
         DO i = 1 , 36
            IF ( kard1(i)==equ1 ) THEN
               spag_nextblock_1 = 18
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDDO
         RETURN
      CASE (18)
         kard1(i) = blankk
         CALL khrbcd(card80,Bufx)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
99005 FORMAT (1H ,29X,A80)
99006 FORMAT (7X,'*** ERROR -',24A4)
END SUBROUTINE xread
