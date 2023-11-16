
SUBROUTINE ofsplt(*,Esym,Elid,G,Offset,X,Deform,Gplst)
!
!     CALLED ONLY BY LINEL TO PRCESS ELEMENT OFFSET PLOT
!     THIS ROUTINE DRAW THE CBAR, CTRIA3, AND CQUAD4, WITH OFFSET IN
!     PLACE.
!
!     INPUT:
!         ESYM   = BCD, SHOULD BE 'BR', 'T3', OR 'Q4'                BCD
!         ELID   = ELEMENT ID                                         I
!         G      = SIL LIST                                           I
!         OFFSET = 6 COORDINATES (GLOBAL) FOR CBAR,                   I
!                = 1 OFFSET, NORMAL TO PLATE, FOR CTRIA3 OR CQUAD4
!         X      = GRID POINT COORDINATE, ALREADY CONVERTED TO SCREEN
!                  (X-Y) COORDINATES                                  R
!         DEFORM = 0, FOR UNDEFORM PLOT,  .NE.0 FOR DEFORMED OR BOTH  I
!                  THIS ROUTINE WILL NOT PROCESS DEFORMED-OFFSET PLOT
!         OFFSCL = OFFSET MULTIPLICATION FACTOR                       I
!         PEDGE  = OFFSET PLOT FLAG                                   I
!                = 3, PLOT OFFSET ELEMENTS ONLY, SKIP OTHER ELEMNETS
!            NOT = 3, PLOT OFFSET ELEMENTS, RETURN TO PLOT OTHERS
!         PLABEL = FLAG FOR ELEM ID LABEL                             I
!         PEN    = PEN SELECTION, 1-31.  32-62 FOR COLOR FILL         I
!         OFFLAG = HEADING CONTROL                                    I
!         ELSET  = ECT DATA BLOCK. THIS DATA BLOCK WAS MODIFIED IN    I
!                  COMECT TO INCLUDE OFFSET DATA FOR BAR,TRIA3,QUAD4
!         GPLST  = A SUBSET OF GRID POINTS PERTAININGS TO THOSE GRID  I
!                  POINTS USED ONLY IN THIS PLOT
!     LOCAL:
!         SCALE  = REAL NUMBER OF OFFSCL
!         OFF    = OFFSET VALUES FROM ELEMENT DATA IN ELSET DATA BLOCK
!         PN1    = PEN COLOR FOR OFFSET LEG.
!                  IF PEN.GT.1, PN1 = PEN-1. IF PEN.LE.1, PN1 = PEN+1
!         NL     = NO. OF LINES TO BE DRAWN PER ELEMENT
!         DELX   = SMALL OFFSET FROM MIDDLE OF LINE FOR ELEM ID PRINTING
!         0.707  = AN ABITRARY FACTOR TO PUT OFFSET 45 DEGREE OFF GRID
!                  POINT
!
!     TWO METHODS
!     (1) PEDGE .NE. 3
!         AN OFFSET PLOT WITHOUT CONSIDERING ITS TRUE DIRECTION, OFFSET
!         VALUE(S) MAGNIFIED 20 TIMES
!     (2) PEDGE .EQ. 3
!         PLOT WITH TRUE OFFSET DIRECTIONS, AND PLOT, WITH COLOR OPTION,
!         GRID(A)-OFFSET(A)-OFFSET(B)-GRID(B)
!         OFFSET CAN BE SCALE UP BY USER VIA PLOT OFFSET COMMAND,
!         DEFAULT IS NO SCALE UP. (NEW 93)
!
!     A SYMBOL * IS ADDED AT THE TIP OF EACH OFFSET
!     CURRENTLY THE SYMBOLS KBAR,KT3 AND KQ4 ARE NOT USED
!
!     CURRENTLY ONLY CBAR (OFFSET=6), CTRIA3 AND CQUAD4 (OFFSET=1 BOTH)
!     HAVE OFFSET CAPABILITY
!
!     WRITTEN BY G.CHAN/UNISYS   10/1990
!
!     COMMENTS FORM G.C.  3/93
!     THE LOGIC IN COMPUTING THE TRUE OFFSET INVOLVING COORDINATE
!     TRANSFORMATION AT EACH POINT POINT SEEMS SHAKY. MAKE SURE THAT
!     AXIS AND SIGN DATA (FROM PROCES) ARE TRUELY AVAILBLE. ARE THE
!     GIRD POINT XYZ COORDINATES AT HAND IN GLOBAL ALREADY?
!     THE OFFSET PLOT IS QUESTIONABLE.
!
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Axis(3) , Elset , Nout , Offlag , Offscl , Pedge , Pen , Plabel , Skp1(12) , Skp2 , Skp3(12) , Skp4(235) , Skp5 , Skp6 , &
         & Skp7(11) , Skp8(6) , Skp9(15)
   REAL Cntx , Cnty , Cstm(3,3) , Sign(3) , Xmax , Ymax
   COMMON /blank / Skp1 , Elset
   COMMON /drwdat/ Skp5 , Plabel , Skp6 , Pen , Skp7 , Pedge , Offlag
   COMMON /pltdat/ Skp8 , Xmax , Ymax , Skp9 , Cntx , Cnty
   COMMON /rstxxx/ Cstm , Skp3 , Axis , Sign
   COMMON /system/ Skp2 , Nout
   COMMON /xxparm/ Skp4 , Offscl
!
! Dummy argument declarations
!
   INTEGER Deform , Elid , Esym , Offset
   INTEGER G(3) , Gplst(1)
   REAL X(3,1)
!
! Local variable declarations
!
   REAL cnty4 , delx , off(3,2) , ofv(3,2) , scale , v(3) , x1 , x2 , x3 , y1 , y2 , y3 , ymax1
   INTEGER i , ipen , j , k , kbar , kq4 , kt3 , l , mpen , nl , offhdg(5) , pn1 , sym(2)
!
! End of declarations
!
   DATA kbar , kt3 , kq4/2HBR , 2HT3 , 2HQ4/ , sym/2 , 0/
   DATA offhdg/4H OFF , 4HSET  , 4HSCAL , 4HE =  , 4H   X/
!
   CALL fread(Elset,off,Offset,0)
!
   IF ( Deform==0 .AND. Offscl>=0 ) THEN
      IF ( Pedge==3 .AND. Offlag/=1 ) THEN
         Offlag = 1
         cnty4 = 4.*Cnty
         ymax1 = Ymax - Cnty
         scale = 1.0
         IF ( Pedge/=3 ) scale = 20.0
         IF ( Pedge==3 ) scale = float(Offscl)
         mpen = mod(Pen,31)
         IF ( mpen>1 ) pn1 = mpen - 1
         IF ( mpen<=1 ) pn1 = mpen + 1
!
!     ADD OFFSET HEADER LINE
!
         CALL print(30.*Cntx,Ymax,1,offhdg,5,0)
         x1 = 48.
         IF ( Offscl>=100 ) x1 = 47.
         CALL typint(x1*Cntx,Ymax,1,Offscl,1,0)
      ENDIF
!
      x1 = 0.0
      DO i = 1 , Offset
         x1 = x1 + abs(off(i,1))
         ofv(i,1) = off(i,1)
      ENDDO
      IF ( abs(x1)>=1.0E-7 ) THEN
!
         nl = 1
         IF ( Esym==kt3 ) nl = 3
         IF ( Esym==kq4 ) nl = 4
         IF ( Pedge/=3 ) THEN
!
!     PLOT OFFSET WITHOUT CONSIDERING ITS TRUE OFFSET DIRECTION IN
!     GENERAL PLOT. (SEE 130 LOOP FOR ELEMENTS WITH COLOR FILL)
!
            IF ( Offset==1 ) THEN
!
               v(1) = 0.707*off(1,1)
               v(2) = v(1)
            ELSE
               v(1) = off(1,1)*off(1,1) + off(2,1)*off(2,1) + off(3,1)*off(3,1)
               v(2) = off(1,2)*off(1,2) + off(2,2)*off(2,2) + off(3,2)*off(3,2)
               v(1) = 0.707*sqrt(v(1))
               v(2) = 0.707*sqrt(v(2))
            ENDIF
!
            v(1) = v(1)*scale
            v(2) = v(2)*scale
            DO l = 1 , nl
               i = G(l)
               j = G(l+1)
               i = Gplst(i)
               j = Gplst(j)
               x1 = X(2,i) + v(1)
               y1 = X(3,i) + v(1)
               x2 = X(2,j) + v(2)
               y2 = X(3,j) + v(2)
               ipen = Pen
               IF ( Pen>31 .AND. nl>=3 .AND. l==nl ) ipen = 0
               CALL line(x1,y1,x2,y2,ipen,0)
               CALL symbol(x1,y1,sym,0)
               IF ( nl==1 ) CALL symbol(x2,y2,sym,0)
            ENDDO
         ELSE
!
            j = alog10(float(Elid)) + 1.0
            delx = (j+.03)*Cntx
!
!     COMPUTE THE TRUE OFFSET DIRECTION IF PEDGE = 3,
!     OTHERWISE, JUST PLOT OFFSET AT 45 DEGREE
!
            IF ( Offset==1 ) THEN
!
!     CTRIA3 AND CQUAD4, OFFSET = 1
!     COMPUTE UNIT NORMAL TO THE PLATE BY CROSS PRODUCT, THEN
!     THE MAGNITUDE OF OFFSET
!
               i = G(1)
               j = G(2)
               k = G(3)
               i = Gplst(i)
               j = Gplst(j)
               k = Gplst(k)
               v(1) = (X(2,j)-X(2,i))*(X(3,k)-X(3,i)) - (X(3,j)-X(3,i))*(X(2,k)-X(2,i))
               v(2) = (X(3,j)-X(3,i))*(X(1,k)-X(1,i)) - (X(1,j)-X(1,i))*(X(3,k)-X(3,i))
               v(3) = (X(1,j)-X(1,i))*(X(2,k)-X(2,i)) - (X(2,j)-X(2,i))*(X(1,k)-X(1,i))
               x1 = 0.5*sqrt(v(1)*v(1)+v(2)*v(2)+v(3)*v(3))
               v(2) = v(2)/x1
               v(3) = v(3)/x1
               off(2,1) = ofv(1,1)*v(2)*scale
               off(3,1) = ofv(1,1)*v(3)*scale
               off(2,2) = off(2,1)
               off(3,2) = off(3,1)
            ELSE
!
!     CBAR, OFFSET = 6
!     CONVERT OFFSET FROM GLOBAL TO PLOT COORDINATES
!
!     AXIS AND SIGN DATA FROM SUBROUTINE PROCES
!
               DO k = 1 , 2
                  DO i = 1 , 3
                     j = Axis(i)
                     v(j) = Sign(i)*ofv(j,k)
                  ENDDO
                  DO j = 1 , 3
                     l = Axis(j)
                     x1 = 0.0
                     DO i = 1 , 3
                        x1 = x1 + Cstm(l,i)*v(i)
                     ENDDO
                     off(j,k) = x1*scale
                  ENDDO
               ENDDO
            ENDIF
!
!     DRAW THE ELEMENT LINES AND ELEMENT ID
!     IF COLOR FILL IS REQUESTED, SET PEN TO ZERO ON THE LAST CLOSING-IN
!     EDGE (2- OR 3-DIMESIONAL ELEMENTS ONLY)
!
            DO l = 1 , nl
               i = G(l)
               j = G(l+1)
               i = Gplst(i)
               j = Gplst(j)
               x1 = X(2,i)
               y1 = X(3,i)
               x2 = X(2,i) + off(2,1)
               y2 = X(3,i) + off(3,1)
               IF ( x2<0.1 ) x2 = 0.1
               IF ( x2>Xmax ) x2 = Xmax
               IF ( y2<cnty4 ) y2 = cnty4
               IF ( y2>ymax1 ) y2 = ymax1
               CALL line(x1,y1,x2,y2,pn1,0)
               CALL symbol(x2,y2,sym,0)
               x3 = X(2,j) + off(2,2)
               y3 = X(3,j) + off(3,2)
               IF ( x3<0.1 ) x3 = 0.1
               IF ( x3>Xmax ) x3 = Xmax
               IF ( y3<cnty4 ) y3 = cnty4
               IF ( y3>ymax1 ) y3 = ymax1
               ipen = Pen
               IF ( Pen>31 .AND. nl>=3 .AND. l==nl ) ipen = 0
               CALL line(x2,y2,x3,y3,ipen,0)
!
               IF ( l<=1 ) THEN
                  IF ( Plabel==3 .OR. Plabel==6 ) THEN
                     IF ( x2>=x1 ) delx = -delx
                     x1 = 0.5*(x3+x2) + delx
                     y1 = 0.5*(y3+y2)
                     CALL typint(x1,y1,1,Elid,1,0)
                  ENDIF
                  IF ( nl<=1 ) THEN
                     CALL symbol(x3,y3,sym,0)
                     x2 = X(2,j)
                     y2 = X(3,j)
                     CALL line(x3,y3,x2,y2,Pen,0)
                  ENDIF
               ENDIF
            ENDDO
         ENDIF
         GOTO 100
      ENDIF
   ENDIF
!
   IF ( Pedge/=3 .OR. Offscl<0 ) RETURN
 100  RETURN 1
END SUBROUTINE ofsplt