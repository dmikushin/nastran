
SUBROUTINE tmtsio(*,Debug1)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL A(1) , G(86) , Pu(226) , Rbldpk , Rgetst , Rgino , Rintpk , Rpck , Rputst , Runpak , T(23) , Tbldpk , Tgetsb , Tgetst ,     &
      & Tgino , Tintpk , Tllcdp , Tllcsp , Tllrdp , Tllrsp , Tpack , Tputst , Ttlcdp , Ttlcsp , Ttlrdp , Ttlrsp , Tunpak , X(1) ,   &
      & Z(1)
   INTEGER Eol , Eor , I1 , I2 , Idum(52) , Ig(75) , Incr1 , Incr2 , Iprec , Isy77 , Iwr(75) , Ix , Iz , J1 , J2 , Jdum(21) ,       &
         & Nbuff3 , Nitems , Output , Sysbuf , Typin1 , Typou1 , Typou2
   CHARACTER*25 Sfm , Uwm
   CHARACTER*23 Ufm
   CHARACTER*29 Uim
   DOUBLE PRECISION Xd(2) , Zd(2)
   COMMON /ginox / G , Ig , Nbuff3 , Pu , Iwr
   COMMON /ntime / Nitems , Tgino , Tbldpk , Tintpk , Tpack , Tunpak , Tgetst , Tputst , Ttlrsp , Ttlrdp , Ttlcsp , Ttlcdp ,        &
                 & Tllrsp , Tllrdp , Tllcsp , Tllcdp , Tgetsb , Rgino , Rbldpk , Rintpk , Rpck , Runpak , Rgetst , Rputst
   COMMON /packx / Typin1 , Typou1 , I1 , J1 , Incr1
   COMMON /system/ Sysbuf , Output , Idum , Iprec , Jdum , Isy77
   COMMON /unpakx/ Typou2 , I2 , J2 , Incr2
   COMMON /xmssg / Ufm , Uwm , Uim , Sfm
   COMMON /zblpkx/ Zd , Iz
   COMMON /zntpkx/ Xd , Ix , Eol , Eor
   COMMON /zzzzzz/ A
!
! Dummy argument declarations
!
   INTEGER Debug1
!
! Local variable declarations
!
   INTEGER ablk(15) , bblk(15) , buf1 , buf2 , end , f1 , f2 , files(2) , i , i1000 , i1001 , iret , isubr(2) , j , k , kerr , m ,  &
         & m10 , m100 , mcb(7) , mm , mx , n , n10 , nbrstr , nwds , type , zero
   REAL flag , fm , fn , rpack , t1 , t2 , t3 , t4 , time1 , time2 , tprrec , tprwrd
   INTEGER korsz
!
! End of declarations
!
!
!     TMTSIO TIME TESTS GINO AND THE PACK ROUTINES
!
!     COMMENT FORM G.CHAN/UNISYS   5/91
!     BASICALLY THIS ROUTINE IS SAME AS TIMTS1.
!
   EQUIVALENCE (Zd(1),Z(1)) , (Xd(1),X(1)) , (T(1),Tgino)
   DATA files/301 , 304/ , zero/0/
   DATA i1000/1000/ , i1001/1001/
   DATA isubr/4HTMTS , 4HIO  /
!
!
!     CHECK KORSZ AND DUMMY SUBROUTINES HERE.
!     IF NASTRAN SUBROUTINES WERE NOT COMPILED WITH STATIC OPTION, BUF1
!     COULD BE NEGATIVE HERE.
!     CALL DUMMY NEXT TO SEE WHETHER THE RIGHT DUMMY ROUTINE IS SET UP
!     FOR THIS MACHINE
!
   kerr = 1
   buf1 = korsz(A)
   IF ( buf1<=0 ) GOTO 1800
   IF ( Debug1>0 ) WRITE (Output,99001)
99001 FORMAT (' -LINK1 DEBUG- TMTSIO CALLINS DUMMY NEXT')
!WKBD CALL DUMMY
!
!     NOTE - ISY77 (WHICH IS BULKDATA OPTION) AND TGINO DETERMINE TO
!            SKIP TMTSIO AND TMTSLP OR NOT. DIAG 35 CAN NOT BE USED AT
!            THIS POINT SINCE THE DIAG CARD HAS NOT BEEN READ YET.
!
   IF ( Tgino>0. .AND. Isy77/=-3 ) RETURN 1
!
!     INITIALIZE
!
   CALL page1
   WRITE (Output,99002)
99002 FORMAT ('0*** USER INFORMATION MESSAGE 225, GINO TIME CONSTANTS ','ARE BEING COMPUTED',/5X,                                   &
             &'(SEE NASINFO FILE FOR ELIMINATION OF THESE COMPUTATIONS)')
   IF ( Tgino>0. ) WRITE (Output,99003) T
99003 FORMAT ('0*** EXISTING TIME CONSTANTS IN /NTIME/ -',/,2(/5X,9F8.3))
   n = 50
   m = n
   type = Iprec
!     NITEMS = 23
!
   f1 = files(1)
   f2 = files(2)
   buf1 = buf1 - Sysbuf
   buf2 = buf1 - Sysbuf
   end = n*m
   IF ( end>=buf1-1 ) CALL mesage(-8,0,isubr)
   DO i = 1 , end
      A(i) = i
   ENDDO
   n10 = n*10
   m10 = m/10
   IF ( m10<=0 ) m10 = 1
   fn = n
   fm = m
!
!     WRITE TEST
!
   IF ( Debug1>0 ) WRITE (Output,99004) Nbuff3 , Ig
99004 FORMAT (' -LINK1 DEBUG- OPEN OUTPUT FILE NEXT FOR WRITE. NBUFF3 =',I5,/5X,'GINO BUFADD 75 WORDS =',/,(2X,11I7))
   CALL open(*1700,f1,A(buf1),1)
   IF ( Debug1>0 ) THEN
      WRITE (Output,99005) Nbuff3 , Ig
99005 FORMAT (' -LINK1 DEBUG- FILE OPEN OK. NBUFF3 =',I5,/5X,'GINO BUFADD 75 WORDS =',/,(2X,11I7))
      WRITE (Output,99006) Iwr(41)
99006 FORMAT (5X,'RWFLG(41) =',I7,//,' -LINK1 DEBUG- CALLING SECOND NEXT')
   ENDIF
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      CALL write(f1,A,m,1)
   ENDDO
   CALL cputim(t2,t2,1)
   IF ( Debug1>0 ) WRITE (Output,99007)
99007 FORMAT (' -LINK1 DEBUG- CLOSE FILE NEXT')
   CALL close(f1,1)
   IF ( Debug1>0 ) WRITE (Output,99008)
99008 FORMAT (' -LINK1 DEBUG- OPEN ANOTHER OUTPUT FILE NEXT FOR WRITE')
   CALL open(*1700,f2,A(buf2),1)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      CALL write(f2,A,m10,1)
   ENDDO
   CALL cputim(t4,t4,1)
   CALL close(f2,1)
   ASSIGN 200 TO iret
!
!     INTERNAL ROUTINE TO STORE TIMING DATA IN /NTIME/ COMMON BLOCK
!
 100  time1 = t2 - t1
   time2 = t4 - t3
   tprrec = 1.0E6*(time2-time1)/(9.0*fn)
   tprwrd = (1.0E6*time1-fn*tprrec)/(fn*fm)
   GOTO iret
 200  Tgino = tprwrd
   Rgino = tprrec
!
!     READ TEST
!
   IF ( Debug1>0 ) WRITE (Output,99009)
99009 FORMAT (' -LINK1 DEBUG- OPEN INPUT FILE NEXT FOR READ')
   CALL open(*1700,f1,A(buf1),0)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      CALL read(*1700,*1700,f1,A(i1000),m,1,flag)
   ENDDO
   CALL cputim(t2,t2,1)
   CALL close(f1,2)
   CALL open(*1700,f2,A(buf2),0)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      CALL read(*1700,*1700,f2,A(i1000),m10,1,flag)
   ENDDO
   CALL cputim(t4,t4,1)
   CALL close(f2,2)
   ASSIGN 300 TO iret
   GOTO 100
 300  Tgino = Tgino + tprwrd
   Rgino = Rgino + tprrec
!
!     BACKWARD READ TEST
!
   CALL open(*1700,f1,A(buf1),2)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      CALL bckrec(f1)
      CALL read(*1700,*1700,f1,A(i1000),m,1,flag)
      CALL bckrec(f1)
   ENDDO
   CALL cputim(t2,t2,1)
   CALL close(f1,1)
   CALL open(*1700,f2,A(buf2),2)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      CALL bckrec(f2)
      CALL read(*1700,*1700,f2,A(i1000),m10,1,flag)
      CALL bckrec(f2)
   ENDDO
   CALL cputim(t4,t4,1)
   CALL close(f2,1)
   ASSIGN 400 TO iret
   GOTO 100
 400  Tgino = Tgino + tprwrd
   Tgino = Tgino/3.0
   Rgino = Rgino + tprrec
   Rgino = Rgino/3.0
!
!     BLDPK TEST
!
   CALL open(*1700,f1,A(buf1),1)
   CALL makmcb(mcb,f1,m,2,type)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      CALL bldpk(type,type,f1,0,0)
      DO j = 1 , m
         Z(1) = 1.0
         Iz = j
         CALL zblpki
      ENDDO
      CALL bldpkn(f1,0,mcb)
   ENDDO
   CALL cputim(t2,t2,1)
   CALL wrttrl(mcb)
   CALL close(f1,1)
   CALL makmcb(mcb,f2,m10,2,type)
   CALL open(*1700,f2,A(buf2),1)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      CALL bldpk(type,type,f2,0,0)
      DO j = 1 , m10
         Z(1) = 2.0
         Iz = j
         CALL zblpki
      ENDDO
      CALL bldpkn(f2,0,mcb)
   ENDDO
   CALL cputim(t4,t4,1)
   CALL wrttrl(mcb)
   CALL close(f2,1)
   ASSIGN 500 TO iret
   GOTO 100
 500  Tbldpk = tprwrd
   Rbldpk = tprrec
!
!     INTPK TEST
!
   CALL open(*1700,f1,A(buf1),0)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      CALL intpk(*1700,f1,0,type,0)
      DO j = 1 , m
         CALL zntpki
         IF ( Ix/=j ) GOTO 1600
         IF ( Eol/=0 ) THEN
            IF ( Ix/=m ) GOTO 1600
         ENDIF
      ENDDO
      IF ( Eol==0 ) GOTO 1600
   ENDDO
   CALL cputim(t2,t2,1)
   CALL close(f1,1)
   CALL open(*1700,f2,A(buf2),0)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      CALL intpk(*1700,f2,0,type,0)
      DO j = 1 , m10
         CALL zntpki
         IF ( Ix/=j ) GOTO 1600
         IF ( Eol/=0 ) THEN
            IF ( Ix/=m10 ) GOTO 1600
         ENDIF
      ENDDO
      IF ( Eol==0 ) GOTO 1600
   ENDDO
   CALL cputim(t4,t4,1)
   CALL close(f2,1)
   ASSIGN 600 TO iret
   GOTO 100
 600  Tintpk = tprwrd
   Rintpk = tprrec
!
!     PACK TEST
!
   CALL makmcb(mcb,f1,m,2,type)
   Typin1 = type
   Typou1 = type
   I1 = 1
   J1 = m
   Incr1 = 1
   mx = m*type
   DO i = 1 , mx
      A(i+1000) = i
   ENDDO
   CALL open(*1700,f1,A(buf1),1)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      CALL pack(A(i1001),f1,mcb)
   ENDDO
   CALL cputim(t2,t2,1)
   CALL wrttrl(mcb)
   CALL close(f1,1)
   CALL makmcb(mcb,f2,m10,2,type)
   J1 = m10
   CALL open(*1700,f2,A(buf2),1)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      CALL pack(A(i1001),f2,mcb)
   ENDDO
   CALL cputim(t4,t4,1)
   CALL wrttrl(mcb)
   CALL close(f2,1)
   ASSIGN 700 TO iret
   GOTO 100
 700  Tpack = tprwrd
   rpack = tprrec
!
!     UNPACK TEST
!
   Typou2 = type
   I2 = 1
   J2 = m
   Incr2 = 1
   CALL open(*1700,f1,A(buf1),0)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      CALL unpack(*1700,f1,A(i1001))
   ENDDO
   CALL cputim(t2,t2,1)
   CALL close(f1,1)
   J2 = m10
   CALL open(*1700,f2,A(buf2),0)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      CALL unpack(*1700,f2,A(i1001))
   ENDDO
   CALL cputim(t4,t4,1)
   CALL close(f2,2)
   ASSIGN 800 TO iret
   GOTO 100
 800  Tunpak = tprwrd
   Runpak = tprrec
!
!     PUTSTR TEST
!
   kerr = 2
   ablk(1) = f1
   ablk(2) = type
   ablk(3) = 1
   CALL gopen(f1,A(buf1),1)
   nwds = type
   IF ( type==3 ) nwds = 2
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      ablk(4) = 0
      ablk(8) = -1
      DO j = 1 , 10
         nbrstr = m10
         DO
            CALL putstr(ablk)
            IF ( nbrstr==0 ) GOTO 1800
            ablk(7) = min0(ablk(6),nbrstr)
            ablk(4) = ablk(4) + ablk(7) + 4
            mm = ablk(7)*nwds
            DO k = 1 , mm
               X(1) = A(k)
            ENDDO
            IF ( ablk(7)==nbrstr ) THEN
               IF ( j==10 ) ablk(8) = 1
               CALL endput(ablk)
               EXIT
            ELSE
               CALL endput(ablk)
               nbrstr = nbrstr - ablk(7)
            ENDIF
         ENDDO
      ENDDO
   ENDDO
   CALL cputim(t2,t2,1)
   CALL close(f1,1)
   m100 = max0(m10/10,1)
   CALL gopen(f2,A(buf2),1)
   kerr = 3
   bblk(1) = f2
   bblk(2) = type
   bblk(3) = 1
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      bblk(4) = 0
      bblk(8) = -1
      DO j = 1 , 10
         nbrstr = m100
         DO
            CALL putstr(bblk)
            IF ( nbrstr==0 ) GOTO 1800
            bblk(7) = min0(bblk(6),nbrstr)
            bblk(4) = bblk(4) + bblk(7) + 4
            mm = bblk(7)*nwds
            DO k = 1 , mm
               X(1) = A(k)
            ENDDO
            IF ( bblk(7)==nbrstr ) THEN
               IF ( j==10 ) bblk(8) = 1
               CALL endput(bblk)
               EXIT
            ELSE
               nbrstr = nbrstr - bblk(7)
            ENDIF
         ENDDO
      ENDDO
   ENDDO
   CALL cputim(t4,t4,1)
   CALL close(f2,1)
   ASSIGN 900 TO iret
   GOTO 100
 900  Tputst = tprwrd
   Rputst = tprrec
!
!     GETSTR TEST (GET STRING FORWARD)
!
   CALL gopen(f1,A(buf1),0)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      ablk(8) = -1
      DO
         CALL getstr(*1000,ablk)
         mm = ablk(6)*nwds
         DO k = 1 , mm
            X(1) = A(k)
         ENDDO
         CALL endget(ablk)
      ENDDO
 1000 ENDDO
   CALL cputim(t2,t2,1)
!     CALL CLOSE  (F1,1)
   CALL gopen(f2,A(buf2),0)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      bblk(8) = -1
      DO
         CALL getstr(*1100,bblk)
         mm = bblk(6)*nwds
         DO k = 1 , mm
            X(1) = A(k)
         ENDDO
         CALL endget(bblk)
      ENDDO
 1100 ENDDO
   CALL cputim(t4,t4,1)
!     CALL CLOSE  (F2,1)
   ASSIGN 1200 TO iret
   GOTO 100
 1200 Tgetst = tprwrd
   Rgetst = tprrec
!
!     GETSTB TEST, (GET BACKWARD STRING)
!     F1 AND F2 FILES ARE STILL OPENED, AND POSITIONED AT THE END
!
!     CALL GOPEN (F1,A(BUF1),0)
!     CALL REWIND (F1)
!     CALL SKPFIL (F1,N+1)
   CALL cputim(t1,t1,1)
   DO i = 1 , n
      ablk(8) = -1
      DO
         CALL getstb(*1300,ablk)
         mm = ablk(6)*nwds
         DO k = 1 , mm
            X(1) = A(k)
         ENDDO
         CALL endgtb(ablk)
      ENDDO
 1300 ENDDO
   CALL cputim(t2,t2,1)
   CALL close(f1,1)
!     CALL GOPEN  (F2,A(BUF2),0)
!     CALL REWIND (F2)
!     CALL SKPFIL (F2,N10+1)
   CALL cputim(t3,t3,1)
   DO i = 1 , n10
      bblk(8) = -1
      DO
         CALL getstb(*1400,bblk)
         mm = bblk(6)*nwds
         DO k = 1 , mm
            X(1) = A(k)
         ENDDO
         CALL endgtb(bblk)
      ENDDO
 1400 ENDDO
   CALL cputim(t4,t4,1)
   CALL close(f2,1)
   ASSIGN 1500 TO iret
   GOTO 100
 1500 Tgetsb = tprwrd
   IF ( Debug1>0 ) WRITE (Output,99010)
99010 FORMAT (' -LINK1 DEBUG- TMTSIO FINISHED')
   RETURN
!
!     INTERNAL ROUTINE CALLED FOR AN ABORT IN THE INTPK TEST
!
 1600 WRITE (Output,99011) Sfm
99011 FORMAT (A25,' 2197, ABORT CALLED DURING TIME TEST OF INTPK')
!
!     ABNORMAL RETURNS FROM GINO - ALL FATAL ERRORS
!
 1700 CALL mesage(-61,0,0)
 1800 WRITE (Output,99012) kerr
99012 FORMAT ('0*** TMTSIO FATAL ERROR',I7)
   GOTO 1700
END SUBROUTINE tmtsio
