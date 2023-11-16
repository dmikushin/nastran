
SUBROUTINE lamx
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL Hdg(96) , Pi , Twopi , Z(7)
   INTEGER Ie , Ii , Iii , Incr , Incr1 , Ito , Ityin , Ityout , Iz(1) , Nlam , Nnn , Nout , Sysbuf
   COMMON /blank / Nlam
   COMMON /condas/ Pi , Twopi
   COMMON /output/ Hdg
   COMMON /packx / Ityin , Ityout , Iii , Nnn , Incr1
   COMMON /system/ Sysbuf , Nout
   COMMON /unpakx/ Ito , Ii , Ie , Incr
   COMMON /zzzzzz/ Iz
!
! Local variable declarations
!
   REAL a , b , c , d(3)
   INTEGER bufa , bufb , bufe , edit , i , icore , ied , ist(10) , iz2 , j , l , lama , lamb , lma , m , nam , ncol , nloop , nwr , &
         & trl(7)
   INTEGER korsz
!
! End of declarations
!
!
!     LAMX MAKES OR EDITS THE LAMA DATA BLOCK
!
!     LAMX  EDIT,LAMA/LAMB/C,Y,NLAM=0 $
!     IF NLAM LT 0 MAKE LAMB A MATRIX OF 5 COLUMNS
!     LAMA  OMEGA FREQ GM GS
!     UNTIL GM = 0.0
!
!
!
!
!
   EQUIVALENCE (d(1),a) , (d(2),b) , (d(3),c)
   EQUIVALENCE (Z(1),Iz(1))
!
   DATA edit , lama , lamb/101 , 102 , 201/
   DATA ist/21 , 6 , 7*0 , 7/
   DATA lma/1/ , ied/1/ , iz2/2/
   DATA nam/4HLAMX/
!
!     INITILIZE AND DECIDE MODE OF OPERATIONS
!
   icore = korsz(Z)
   trl(1) = lama
   CALL rdtrl(trl)
   IF ( trl(1)<0 ) lma = 0
   trl(1) = edit
   CALL rdtrl(trl)
   IF ( trl(1)<0 ) ied = 0
   ncol = trl(2)
   IF ( ncol==0 ) ied = 0
   IF ( lma==0 .AND. ied==0 ) GOTO 99999
   Ito = 1
   Ii = 1
   Incr = 1
   Ie = trl(3)
   IF ( Ie>3 ) Ie = 3
   b = 0.0
   c = 0.0
   bufb = icore - Sysbuf
   CALL gopen(lamb,Z(bufb),1)
   IF ( lma==0 ) THEN
!
!      MAKE A NEW LAMB
!
      bufe = bufb - Sysbuf
      CALL gopen(edit,Z(bufe),0)
      IF ( Nlam>0 ) ncol = min0(ncol,Nlam)
!
!     WRITE HEADER
!
      CALL write(lamb,ist,50,0)
      CALL write(lamb,Hdg,96,1)
!
!     MAKE RECORDS
!
      DO i = 1 , ncol
         CALL unpack(*20,edit,d)
         GOTO 40
 20      d(1) = 0.0
         d(2) = 0.0
         d(3) = 0.0
 40      Iz(1) = i
         Iz(iz2) = i
         Z(5) = a
         Z(4) = Twopi*a
         Z(3) = Z(4)*Z(4)
         Z(6) = c
         Z(7) = c*Z(3)
         CALL write(lamb,Z,7,0)
      ENDDO
      j = ncol
      GOTO 300
   ELSE
      bufa = bufb - Sysbuf
      CALL gopen(lama,Z(bufa),0)
      IF ( Nlam<0 ) THEN
!
!     BUILD LAMB AS A MATRIX
!
         trl(1) = lamb
         trl(2) = 0
         trl(4) = 1
         trl(5) = 1
         trl(6) = 0
         trl(7) = 0
         Ityin = 1
         Ityout = 1
         Iii = 1
         Incr1 = 7
         CALL fwdrec(*400,lama)
         CALL read(*400,*500,lama,Z,bufa,0,nwr)
         CALL mesage(8,0,nam)
         GOTO 400
      ELSE
         bufe = bufa - Sysbuf
!
!      EDITING LAMA FROM EDIT
!
         IF ( ied/=0 ) CALL gopen(edit,Z(bufe),0)
!
!     WRITE HEADER
!
         CALL read(*100,*100,lama,Z,bufe,1,nwr)
      ENDIF
   ENDIF
 100  CALL write(lamb,Z,nwr,1)
   IF ( ied==0 ) THEN
!
!     COPY LAMA TO LAMB FOR NLAM RECORDS
!
      IF ( Nlam==0 ) GOTO 400
      j = Nlam
      m = 7*Nlam
      CALL read(*300,*200,lama,Z,m,0,nwr)
      CALL write(lamb,Z,7*Nlam,0)
      GOTO 300
   ELSE
!
!     MAKE RECORDS
!
      j = 0
      DO i = 1 , ncol
         CALL read(*300,*300,lama,Z,7,0,nwr)
         CALL unpack(*120,edit,d)
         IF ( a/=0.0 .OR. b/=0.0 .OR. c/=0.0 ) THEN
            IF ( c<0.0 ) CYCLE
            Z(5) = Z(5)*(1.0+b) + a
            Z(4) = Z(5)*Twopi
            Z(3) = Z(4)*Z(4)
            IF ( c/=0.0 ) Z(6) = c
            Z(7) = Z(6)*Z(3)
         ENDIF
 120     j = j + 1
         Iz(1) = j
         IF ( Nlam>0 ) THEN
            IF ( j>Nlam ) EXIT
         ENDIF
         CALL write(lamb,Z,7,0)
      ENDDO
      GOTO 300
   ENDIF
 200  CALL write(lamb,Z,nwr,0)
 300  trl(1) = lamb
   trl(2) = j
   CALL wrttrl(trl)
 400  CALL close(lama,1)
   CALL close(lamb,1)
   CALL close(edit,1)
   GOTO 99999
 500  nloop = 0
   DO i = 1 , nwr , 7
      IF ( Z(i+5)==0.0 ) EXIT
      nloop = nloop + 1
   ENDDO
   IF ( nloop/=0 ) THEN
      trl(3) = nloop
      Nnn = nloop
      l = 3
      DO i = 1 , 5
         CALL pack(Z(l),lamb,trl)
         l = l + 1
      ENDDO
      CALL wrttrl(trl)
   ENDIF
   GOTO 400
99999 END SUBROUTINE lamx