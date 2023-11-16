
SUBROUTINE typflt(X,Y,Xyd,V,Field,Opt)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL Cntx , Cnty , Skpa(3) , Skpplt(18)
   INTEGER Model , Ploter
   COMMON /pltdat/ Model , Ploter , Skpplt , Skpa , Cntx , Cnty
!
! Dummy argument declarations
!
   INTEGER Field , Opt , Xyd
   REAL V , X , Y
!
! Local variable declarations
!
   REAL a , ten7 , ten8 , tenm2 , xx , xy , yy
   INTEGER aster , c(100) , d(9) , decpnt , dir , exp , expfld , fw , i , j , minus , n , nsig , num , plus , tra
   DOUBLE PRECISION val , z
!
! End of declarations
!
!
!
!     (X,Y) = STARTING OR ENDING POINT OF THE NUMBER TO BE TYPED (ALWAYS
!             LEFT-TO-RIGHT OR TOP-TO-BOTTOM).
!     XYD   = +/-1 IF X = STARTING OR ENDING POINT OF THE NUMBER.
!           = +/-2 IF Y = STARTING OR ENDING POINT OF THE NUMBER.
!     V     = REAL NUMBER TO BE TYPED.
!     FIELD = FIELD WIDTH OF THE NUMBER (IF POSITIVE, THE NUMBER WILL BE
!             CENTERED AT (X,Y) - IF NEGATIVE, THE NUMBER WILL BE TYPED
!             STARTING OR ENDING AT (X,Y) - IF XYD = 1 OR 2, THE NUMBER
!             WILL BE TYPED IN THE X OR Y DIRECTION).
!     OPT   = -1 TO INITIATE  THE TYPING MODE.
!           = +1 TO TERMINATE THE TYPING MODE.
!           =  0 TO TYPE THE NUMBER.
!
   DATA aster , decpnt , plus , minus/41 , 44 , 39 , 40/
   DATA tenm2 , ten7 , ten8/1.E-2 , 1.E7 , 1.E8/
!
   IF ( Opt==0 ) THEN
      val = abs(V)
      fw = min0(25,iabs(Field))
      IF ( fw==0 ) GOTO 99999
      DO i = 1 , fw
         c(i) = 1
      ENDDO
      exp = 0
      IF ( V/=0. ) THEN
!
         expfld = 0
         IF ( V<0. ) THEN
!
!     SINCE -V- IS NEGATIVE, THE NUMBER WILL BE SIGNED.  IF FIELD.GT.5,
!     THE NUMBER OF SIGNIFICANT DIGITS TYPED WILL BE AT LEAST -FIELD-5-.
!     IF FIELD.LE.5, -FIELD-2-.
!
            nsig = fw - 5
            IF ( nsig>0 ) GOTO 50
         ELSE
!
!     SINCE -V- IS POSITIVE, THE NUMBER WILL BE UNSIGNED. IF FIELD.GT.4,
!     THE NUMBER OF SIGNIFICANT DIGITS TYPED WILL BE AT LEAST -FIELD-4-.
!     IF FIELD.LE.4, -FIELD-1-.
!
            nsig = fw - 4
            IF ( nsig>0 ) GOTO 50
         ENDIF
!
!     THE NUMBER WILL BE TYPED WITHOUT AN EXPONENT.
!
         nsig = nsig + 3
         expfld = 1
      ELSE
!
!     INPUT VALUE = 0.
!
         fw = min0(fw,2)
         nsig = 1
         c(2) = decpnt
         GOTO 500
      ENDIF
 50   DO
!
!     THE NUMBER MUST FIRST BE MULTIPLIED BY SOME POWER OF TEN (EXP)
!     SUCH THAT THE PRODUCT IS BETWEEN 10**7 AND 10**8 SO THAT IT
!     CAN BE EXPRESSED AS AN 8-SIGNIFICANT DIGIT INTEGER.
!
         z = 10.D0**iabs(exp)
         IF ( exp<0 ) a = val/z
         IF ( exp>=0 ) a = val*z
         IF ( a<tenm2 ) THEN
!
!     A .LT. 10**-2
!
            exp = exp + 10
!
         ELSEIF ( a>=ten7 .AND. a<ten8 ) THEN
!
!     A .GE. 10**7  AND  .LT. 10**8  (SEPARATE THE 8 SIGNIFICANT DIGITS)
!
            num = a
            exp = -exp + 7
            DO i = 1 , 8
               j = num/10**(8-i)
               d(i) = j + 1
               num = num - j*10**(8-i)
            ENDDO
            IF ( expfld==0 ) THEN
               IF ( exp>=-4 .AND. exp<=nsig+2 ) THEN
!
!     THE NUMBER CAN BE EXPRESSED WITHOUT AN EXPONENT.
!
                  nsig = min0(8,nsig+3)
                  ASSIGN 200 TO tra
               ELSE
!
!     USE STANDARD FORMAT (-X.XXX-XX)
!
                  nsig = min0(nsig,8)
                  ASSIGN 100 TO tra
               ENDIF
               GOTO 600
!
!     STANDARD FORMAT CANNOT BE USED.
!
            ELSEIF ( exp<nsig .AND. exp>=-nsig ) THEN
               ASSIGN 200 TO tra
               GOTO 600
            ELSE
               DO i = 1 , fw
                  c(i) = aster
               ENDDO
               GOTO 500
            ENDIF
         ELSEIF ( a<ten7 ) THEN
!
!     A .GE. 10**-2  AND  .LT. 10**7
!
            exp = exp + 1
         ELSE
!
!     A .GE. 10**8
!
            exp = exp - 10
         ENDIF
      ENDDO
   ELSE
      CALL tipe(0,0,0,0,0,Opt)
      GOTO 99999
   ENDIF
 100  n = 0
   IF ( V<=0. ) THEN
      c(1) = minus
      n = 1
   ENDIF
   c(n+1) = d(1)
   c(n+2) = decpnt
   n = n + 2
   IF ( nsig/=1 ) THEN
      DO i = 2 , nsig
         n = n + 1
         c(n) = d(i)
      ENDDO
   ENDIF
   IF ( exp>=0 ) c(n+1) = plus
   IF ( exp<0 ) c(n+1) = minus
   n = n + 1
   num = iabs(exp)
   DO i = 1 , 2
      j = num/10**(2-i)
      n = fw - (2-i)
      c(n) = j + 1
      num = num - j*10**(2-i)
   ENDDO
   GOTO 500
 200  n = 1
   IF ( V<=0. ) THEN
      c(1) = minus
      n = 2
   ENDIF
   IF ( exp>=0 ) THEN
!
!     POSITIVE EXPONENT.
!
      ASSIGN 400 TO tra
      IF ( nsig+n<fw ) GOTO 400
      GOTO 600
   ELSE
!
!     NEGATIVE EXPONENT
!
      j = nsig
      DO
         d(j+1) = d(j)
         j = j - 1
         IF ( j==0 ) THEN
            d(1) = 1
            ASSIGN 300 TO tra
            IF ( nsig+n>=fw ) GOTO 600
            nsig = nsig + 1
            EXIT
         ENDIF
      ENDDO
   ENDIF
 300  c(n+0) = d(1)
   c(n+1) = decpnt
   n = n + 1 + iabs(exp)
   DO i = 2 , nsig
      c(n) = d(i)
      n = n + 1
   ENDDO
   GOTO 500
 400  j = exp + 1
   DO i = 1 , j
      c(n) = d(i)
      n = n + 1
   ENDDO
   c(n) = decpnt
   j = j + 1
   IF ( j<=nsig ) THEN
      DO i = j , nsig
         n = n + 1
         c(n) = d(i)
      ENDDO
   ENDIF
!
 500  xx = X
   yy = Y
   IF ( Field>0 .AND. nsig>1 ) THEN
!
!     THE TYPED NUMBER IS TO BE CENTERED AT (X,Y).
!
      xy = fw/2
      IF ( fw/2==(fw+1)/2 ) xy = xy - .5
      dir = max0(1,iabs(Xyd))
      IF ( dir==1 ) xx = X - xy*Cntx
      IF ( dir==2 ) yy = Y - xy*Cnty
   ELSE
!
!     THE TYPED NUMBER IS NOT TO BE CENTERED AT (X,Y).
!
      dir = Xyd
   ENDIF
!
!     TYPE THE NUMBER.
!
   CALL type10(xx,yy,dir,c,fw,0)
   GOTO 99999
!
!     ROUND THE NUMBER.
!
 600  IF ( nsig/=8 ) THEN
      IF ( d(nsig+1)>5 ) THEN
         j = nsig
         DO
            d(j) = d(j) + 1
            IF ( d(j)<=10 ) EXIT
            d(j) = 1
            j = j - 1
            IF ( j==0 ) THEN
               IF ( d(1)/=1 ) EXIT
               j = nsig - 1
               DO WHILE ( j/=0 )
                  d(j+1) = d(j)
                  j = j - 1
               ENDDO
               d(1) = 2
               exp = exp + 1
               EXIT
            ENDIF
         ENDDO
      ENDIF
   ENDIF
   GOTO tra
!
99999 END SUBROUTINE typflt