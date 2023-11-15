
SUBROUTINE ffhelp(*,*,J)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL Dummy(3) , Skip(2)
   INTEGER Iechos , In , Mach , Nout
   CHARACTER*1 Qmark
   COMMON /machin/ Mach
   COMMON /qmarkq/ Qmark
   COMMON /system/ Dummy , In
   COMMON /xechox/ Skip , Iechos
   COMMON /xreadx/ Nout
!
! Dummy argument declarations
!
   INTEGER J
!
! Local variable declarations
!
   CHARACTER*4 help , stop , xx , yes
!
! End of declarations
!
   DATA stop , yes , help/'STOP' , 'Y   ' , 'HELP'/
!
!     THIS ROUTINE IS CALLED ONLY BY FF
!
   IF ( J==2 ) THEN
   ELSEIF ( J==3 ) THEN
!
      WRITE (Nout,99001)
99001 FORMAT (//,24H ENTER 'N' FOR NO PUNCH,,/7X,38H'Y' FOR PUNCH IN FREE-FIELD FORMAT, OR,/7X,                                     &
             &43H'X' FOR PUNCH IN NASTRAN FIXED-FIELD FORMAT,/)
      GOTO 500
   ELSEIF ( J==4 ) THEN
!
      WRITE (Nout,99002)
99002 FORMAT (/,' MIFYLE - IS A RESERVED WORD.  TRY ANY OTHER NAME')
      GOTO 500
   ELSEIF ( J==5 ) THEN
      GOTO 300
   ELSE
      WRITE (Nout,99003)
99003 FORMAT (///1X,'GENERATED OUTPUT CARDS ARE SAVED ONLY IF FILE NAME IS GIVEN.',//,                                              &
             &' YOU MAY ENTER NASTRAN EXECUTIVE CONTROL AND CASE CONTROL',' CARDS FIRST',/,' (NO INPUT ECHO ON SCREEN)',//,         &
             &' ADDITIONAL INPUT INFORMATION WILL BE GIVEN WHEN YOU ENTER ',12H'BEGIN BULK',//,                                     &
             &' YOU MAY QUIT FREE-FIELD PROGRAM AT ANY TIME BY ENTERING ',6H'STOP',/,' NORMALLY, JOB TERMINATES BY ',9H'ENDDATA',//,&
             &' YOU MAY USE ',10H'READFILE',' COMMAND TO READ ANY FILE WHICH',14H WAS 'STOPPED',/,                                  &
             &' BEFORE, AND CONTINUE FROM WHERE THE PREVIOUS JOB ENDED',//,                                                         &
             &' FREE-FIELD INPUT IS AVAILABLE ONLY IN BULK DATA SECTION',/,                                                         &
             &' AND IS ACTIVATED BY A COMMA OR EQUAL SIGN IN COLS. 1 THRU 10',//,                                                   &
             &' BOTH UPPER-CASE AND LOWER-CASE LETTERS ARE ACCEPTABLE',//,' REFERENCE - G.CHAN: ',1H',                              &
             &'COSMIC/NASTRAN FREE-FIELD INPUT',2H',,/13X,'12TH NASTRAN USERS',1H',' COLLOQUIUM, MAY 1984')
      WRITE (Nout,99008) Qmark
      READ (In,99009,END=200) xx
      CALL upcase(xx,4)
      IF ( xx/=yes ) GOTO 200
   ENDIF
!
 100  WRITE (Nout,99004)
99004 FORMAT (///,' THE FOLLOWING SYMBOLS ARE USED FOR FREE-FIELD INPUT',//10X,'SYMBOL',12X,'FUNCTION',/,9X,2('----'),5X,10('----'),&
            & /10X,', OR BLANK  FIELD SEPERATORS',/10X,'  =         DUPLICATES ONE CORRESPONDING FIELD',/10X,                       &
             &'  ==        DUPLICATES THE REMAINING FIELDS',/10X,'  *(N)      INCREMENT BY N',/10X,'  %(E)      ENDING VALUE BY E', &
            & /10X,'  /         THIS INPUT FIELD IS SAME AS PREVIOUS FIELD',/10X,                                                   &
             &'  J)        FIELD INDEX, J-TH FIELD (MUST FOLLOWED BY A VALUE)',/10X,')+ OR 10)   INDEX FOR CONTINUATION FIELD',/10X,&
             &'  )         (IN COL. 1 ONLY) DUPLICATES THE CONTINUATION ID',/22X,'OF PREVIOUS CARD INTO FIELD 1 OF CURRENT CARD',   &
            & /10X,'  ,         COL.1 ONLY, AUTO-CONTINUATION ID GENERATION',/10X,                                                  &
             &'  =(N)      1ST FIELD ONLY, DUPLICATES N CARDS WITH PROPER',/22X,' INCREMENTS',/12X,'+A-I',6X,                       &
             &'CONTINUATION ID CAN BE DUPLICATED AUTOMATICALLY',/22X,'ONLY IF IT IS IN PLUS-ALPHA-MINUS-INTEGER FORM',//1X,         &
             &'EXAMPLES:',/1X,'GRID, 101,,  0.  0. ,  7. 8)2  )+ABC-2',/1X,'=(11),*(1)  ,,  *(1.), /  %(23.45),==')
   IF ( J==1 .OR. Iechos/=-2 ) GOTO 400
   WRITE (Nout,99008) Qmark
   READ (In,99009,END=200) xx
   CALL upcase(xx,4)
   IF ( xx==yes ) GOTO 300
 200  IF ( xx==stop ) RETURN 2
   IF ( Mach==4 .AND. In==5 ) REWIND In
   GOTO 500
!
 300  WRITE (Nout,99005)
99005 FORMAT (//,' *** FREE-FIELD INPUT IS OPTIONAL.',//5X,'FOUR (4)',' CONTROL OPTIONS ARE AVAILABLE - CAN BE ENTERED AT ANY TIME',&
            & /7X,'1.  PROMPT=ON, PROMPT=OFF, OR PROMPT=YES(DEFAULT)',/7X,'2.  SCALE/10,  OR SCALE/8',/7X,                          &
             &'3.  CANCEL=N,  (TO CANCEL N PREVIOUSLY GENERATED CARDS)',/7X,                                                        &
             &'4.  LIST  =N,  (TO   LIST N PREVIOUSLY GENERATED CARDS)',//7X,'ENTER ''HELP'' IF YOU NEED ADDITIONAL INSTRUCTIONS',  &
            & //7X,'INTEGER INPUT SHOULD BE LIMITED TO 8 DIGITS',/7X,'UP TO 12 DIGITS ARE ALLOWED FOR FLOATING PT. NUMBER INPUT',   &
            & /7X,'HOWEVER, ONLY UP TO 8 DIGIT ACCURACY IS KEPT',/7X,'             INPUT           RESULT ',/7X,                    &
             &'         ------------       --------',/7X,'E.G.     123.456789         123.4567',/7X,                                &
             &'         123.456789+6       .12345+9',/7X,'         -123.4567D+5       -.1234+8',/7X,                                &
             &'         123.45678E+4       1234567.',/7X,'         0.00123456-3       .12345-5',/7X,                                &
             &'         0.0123456789       .0123456',/7X,'         .00000123456       .12345-5')
   IF ( Iechos/=-2 ) WRITE (Nout,99006)
99006 FORMAT (/7X,'(3 AND 4 ARE AVAILABLE ONLY IN THE FREE-FIELD STAND','-ALONE VERSION)')
 400  WRITE (Nout,99007)
99007 FORMAT (/4X,'UP TO 94 CHARATERS ALLOWABLE ON AN INPUT LINE. ',' C/R TO CONTINUE')
   READ (In,99009,END=200) xx
   CALL upcase(xx,4)
   IF ( xx==help ) GOTO 100
   IF ( J/=1 ) GOTO 200
 500  RETURN 1
99008 FORMAT (/,' MORE',A1,' (Y,N) - ')
99009 FORMAT (A4)
END SUBROUTINE ffhelp
