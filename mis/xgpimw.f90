
SUBROUTINE xgpimw(Msgno,I,J,A)
!
!     XGPIMW IS USED TO WRITE ALL NON-DIAGNOSTIC MESSAGES
!     GENERATED BY THE XGPI MODULE.
!
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Alter(2) , Bkdata , Cnmtp , Cppgct , Diag14 , Diag17 , Fnmtp , Iallon , Iapnd , Iapp , Icfiat , Icfpnt , Icftop , Icold ,&
         & Icst , Ictlfl(1) , Idmapp , Idsapp , Idum(5) , Iecho , Ieqflg , Iequl , Iestim , Iflag , Iflg(6) , Ihapp , Imst , Iplus ,&
         & Irdict , Iropen , Isave , Isgnon , Islsh , Itpflg , Iunst , Lctlfl , Ldict , Lmed , Lpch , Maskhi , Masklo , Masks(1) ,  &
         & Medpnt , Medtp , Namopt(26) , Nbegin , Nblank , Nbpc , Nchkpt , Ncond , Ncpw , Ndiag , Ndmap , Nend , Nequiv , Nestm1 ,  &
         & Nestm2 , Nexit , Njump , Nlines , Nlpp , Nogo , Nosgn , Noutpt , Npurge , Nrept , Nsave , Nsol , Ntime , Nwpc , Nxequi , &
         & Op , Pghdg(1) , Sol , Start , Subset , Zsys(90)
   CHARACTER*23 Ufm
   CHARACTER*29 Uim
   CHARACTER*25 Uwm
   COMMON /moddmp/ Iflg , Namopt
   COMMON /output/ Pghdg
   COMMON /resdic/ Irdict , Iropen
   COMMON /system/ Zsys , Lpch , Ldict
   COMMON /xgpi5 / Iapp , Start , Alter , Sol , Subset , Iflag , Iestim , Icftop , Icfpnt , Lctlfl , Ictlfl
   COMMON /xgpi6 / Medtp , Fnmtp , Cnmtp , Medpnt , Lmed , Iplus , Diag14 , Diag17
   COMMON /xgpic / Icold , Islsh , Iequl , Nblank , Nxequi , Ndiag , Nsol , Ndmap , Nestm1 , Nestm2 , Nexit , Nbegin , Nend ,       &
                 & Njump , Ncond , Nrept , Ntime , Nsave , Noutpt , Nchkpt , Npurge , Nequiv , Ncpw , Nbpc , Nwpc , Maskhi ,        &
                 & Masklo , Isgnon , Nosgn , Iallon , Masks
   COMMON /xgpid / Icst , Iunst , Imst , Ihapp , Idsapp , Idmapp , Isave , Itpflg , Iapnd , Idum , Ieqflg
   COMMON /xmssg / Ufm , Uwm , Uim
!
! Dummy argument declarations
!
   INTEGER I , J , Msgno
   INTEGER A(6)
!
! Local variable declarations
!
   INTEGER andf , rshift
   INTEGER diag09 , diagi4 , hdg1(18) , hdg2(7) , hdg3(2) , hdg4(22) , hdg5(26) , i1 , i2 , ia1 , ia2 , iappnd , iblnk , iequiv ,   &
         & ifile , ipage , ireel , istar , itape , iunit , iwrite , kdlh , kkdj , l , l1 , line(12) , ltu , m , m1 , m2 , nscr
   EXTERNAL andf , rshift
!
! End of declarations
!
   EQUIVALENCE (Zsys(2),Op) , (Zsys(3),Nogo) , (Zsys(9),Nlpp) , (Zsys(12),Nlines) , (Zsys(77),Bkdata) , (Zsys(26),Cppgct) ,         &
    & (Zsys(19),Iecho) , (Zsys(24),Icfiat)
   DATA hdg1/17 , 4H     , 4H COS , 4HMIC  , 4H/ NA , 4HSTRA , 4HN DM , 4HAP C , 4HOMPI , 4HLER  , 4H- SO , 4HURCE , 4H LIS ,       &
      & 4HTING , 4*4H    /
   DATA hdg2/6 , 6*4H    /
   DATA hdg3/1 , 4H    /
   DATA hdg4/21 , 4HINTE , 4HRPRE , 4HTED  , 4HFROM , 4H THE , 4H OSC , 4HAR.  , 4HNEGA , 4HTIVE , 4H DMA , 4HP IN , 4HDICA ,       &
      & 4HTES  , 4HA NO , 4HN EX , 4HECUT , 4HABLE , 4H INS , 4HTRUC , 4HTION , 4H    /
   DATA hdg5/25 , 4H* *  , 4H*  D , 4H M A , 4H P   , 4H C R , 4H O S , 4H S - , 4H R E , 4H F E , 4H R E , 4H N C , 4H E   ,       &
      & 4H * * , 4H *   , 7*4H     , 4HMODU , 4HLE   , 4H  NA , 4HMES /
   DATA kdlh/0/
   DATA istar/1H*/
   DATA ipage/0/
   DATA iblnk/4H    /
!
!
   diagi4 = Diag14
   IF ( Diag14==10 ) diagi4 = 0
   IF ( diagi4/=0 .OR. Diag17/=0 ) THEN
      IF ( Iecho==-2 .AND. (Msgno<=4 .OR. Msgno==8) .AND. Msgno/=9 ) RETURN
   ELSEIF ( Iecho==-2 .AND. Msgno/=9 ) THEN
      RETURN
   ENDIF
   IF ( Msgno<=0 .OR. Msgno>13 ) THEN
      Nlines = 2 + Nlines
      IF ( Nlines>=Nlpp ) CALL page1
      WRITE (Op,99001) Msgno
99001 FORMAT (//,' NO MESSAGE AVAILABLE FOR MESSAGE NO. ',I4)
   ELSEIF ( Msgno==2 ) THEN
!
!     MESSAGE 2  (XGPI)
!     =================
!
      IF ( Start==Iunst ) THEN
!
         CALL page2(-6)
         WRITE (Op,99024)
         WRITE (Op,99002)
99002    FORMAT ('0  * INDICATES DMAP INSTRUCTIONS THAT ARE FLAGGED FOR ','EXECUTION IN THIS UNMODIFIED RESTART.')
      ELSE
         CALL page2(-6)
         WRITE (Op,99024)
         WRITE (Op,99003)
99003    FORMAT ('0  * INDICATES DMAP INSTRUCTIONS THAT ARE FLAGGED FOR ','EXECUTION IN THIS MODIFIED RESTART.')
      ENDIF
   ELSEIF ( Msgno==3 ) THEN
!
!     MESSAGE 3  (KYXFLD)
!     ===================
!
      Nlines = Nlines + 2
      IF ( Nlines>=Nlpp ) CALL page1
      WRITE (Op,99004) I , J
99004 FORMAT ('0TO GENERATE DATA BLOCK ',2A4,' - TURN ON THE EXECUTE ','FLAG FOR THE FOLLOWING DMAP INSTRUCTIONS',/)
   ELSEIF ( Msgno==4 ) THEN
!
!     MESSAGE 4  (KYXFLD)
!     ===================
!
      Nlines = Nlines + 1
      IF ( Nlines>=Nlpp ) CALL page1
      l = andf(A(6),Maskhi)
      WRITE (Op,99005) l , A(4) , A(5)
99005 FORMAT (1X,I4,2X,2A4)
   ELSEIF ( Msgno==5 ) THEN
!
!     MESSAGE 5 - WRITE DMAP INSTRUCTION, FIRST LINE   (XSCNDM)
!     =========================================================
!
      IF ( diagi4/=0 ) THEN
         IF ( kdlh==0 ) THEN
!
!     PROCESS DMAP COMPILER OPTIONS SUMMARY
!
            IF ( kdlh/=0 ) GOTO 99999
            IF ( ipage==0 ) CALL page
            Nlines = Nlines + 4
            line(1) = Namopt(1)
            line(2) = Namopt(2)
            line(3) = Namopt(5)
            line(4) = Iflg(2)
            line(5) = Namopt(9)
            line(6) = Namopt(10)
            line(7) = Namopt(13)
            line(8) = Namopt(14)
            line(9) = Namopt(17)
            line(10) = Namopt(18)
            line(11) = Namopt(21)
            line(12) = Namopt(22)
            IF ( Iflg(1)<=0 ) line(1) = Namopt(3)
            IF ( Iflg(3)>0 ) THEN
               line(5) = Namopt(7)
               line(6) = Namopt(8)
            ENDIF
            IF ( Iflg(4)>0 ) THEN
               line(7) = Namopt(11)
               line(8) = Namopt(12)
            ENDIF
            IF ( Iflg(5)>0 ) THEN
               line(9) = Namopt(15)
               line(10) = Namopt(16)
            ENDIF
            IF ( Iflg(6)>0 ) THEN
               line(11) = Namopt(19)
               line(12) = Namopt(20)
            ENDIF
            WRITE (Op,99006) (line(kkdj),kkdj=1,12)
99006       FORMAT ('0  OPTIONS IN EFFECT ',2A4,A3,1H=,I1,3X,8A4,/3X,17(1H-),/)
            kdlh = 1
         ENDIF
         CALL page2(-2)
         WRITE (Op,99025) J , (A(m),m=1,I)
      ENDIF
      IF ( Diag17/=0 ) WRITE (Lpch,99007) (A(m),m=1,I)
99007 FORMAT (20A4)
   ELSEIF ( Msgno==6 ) THEN
!
!     MESSAGE 6 - WRITE DMAP INSTRUCTION, CONTINUATION LINE   (XSCNDM)
!     ================================================================
!
      IF ( diagi4/=0 ) THEN
         Nlines = Nlines + 1
         IF ( Nlines>=Nlpp ) CALL page
         WRITE (Op,99026) (A(m),m=1,I)
      ENDIF
      IF ( Diag17/=0 ) WRITE (Lpch,99008) (A(m),m=1,I)
99008 FORMAT (20A4)
   ELSEIF ( Msgno==7 .OR. Msgno==10 ) THEN
!
!     MESSAGE 7   (XLNKHD)
!     MESSAGE 10  (XLNKHD AND XOSGEN)
!     ===============================
!
      IF ( diagi4/=0 ) THEN
         iwrite = istar
         IF ( Msgno==10 ) iwrite = Iplus
         WRITE (Op,99009) Iplus , iwrite
99009    FORMAT (A1,2X,A1)
      ENDIF
   ELSEIF ( Msgno==8 ) THEN
!
!     MESSAGE 8  (KYGPI)
!     ==================
!
      CALL page1
      Nlines = Nlines + 4
      WRITE (Op,99010)
99010 FORMAT ('0THE FOLLOWING FILES FROM THE OLD PROBLEM TAPE WERE ','USED TO INITIATE RESTART',//4X,                               &
            & 'FILE NAME  REEL NO.  FILE NO.',/)
      DO m = I , J , 3
         ireel = andf(rshift(A(m+2),16),31)
         ifile = andf(A(m+2),Maskhi)
         CALL page2(-1)
         IF ( ifile==0 ) THEN
            WRITE (Op,99011) A(m) , A(m+1)
99011       FORMAT (5X,2A4,2X,8H(PURGED))
         ELSE
            WRITE (Op,99012) A(m) , A(m+1) , ireel , ifile
99012       FORMAT (5X,2A4,2X,I8,2X,I8)
         ENDIF
      ENDDO
   ELSEIF ( Msgno==9 ) THEN
!
!     MESSAGE 9  (KYGPI)
!     ==================
!
      IF ( Bkdata<0 ) CALL page2(-2)
      IF ( Bkdata==-2 ) THEN
         WRITE (Op,99013)
99013    FORMAT (1H0,9X,'**NO ERRORS FOUND - NASTRAN EXECUTION TERMINATED',' BY USER REQUEST**')
      ELSE
         IF ( Iflg(1)/=1 ) THEN
            WRITE (Op,99014)
99014       FORMAT (1H0,10X,'**COMPILATION COMPLETE - JOB TERMINATING WITH ','NOGO STATUS**')
         ELSEIF ( Bkdata<0 ) THEN
            WRITE (Op,99015)
99015       FORMAT (1H0,10X,'**NO ERRORS FOUND - EXECUTE NASTRAN PROGRAM**')
         ENDIF
!
!     DUMP FIAT IF SENSE SWITCH 2 IS ON
!
         CALL sswtch(2,l)
         IF ( l/=0 ) THEN
            CALL page1
            Nlines = Nlines + 4
            WRITE (Op,99016) A(1) , A(2) , A(3)
99016       FORMAT (1H ,/5X,22HFIAT AT END OF PREFACE,3I15,/,1H ,/5X,'EQUIV','  APPEND    LTU  TAPE  UNIT  FILE NAME',31X,          &
                   &'---TRAILER---')
            l1 = A(3)*Icfiat - 2
            DO l = 4 , l1 , Icfiat
               iequiv = 0
               iappnd = 0
               itape = 0
               IF ( rshift(andf(A(l),Ieqflg),1)>0 ) iequiv = 1
               IF ( andf(A(l),Iapnd)>0 ) iappnd = 1
               IF ( andf(A(l),Itpflg)>0 ) itape = 1
               ltu = andf(rshift(A(l),16),16383)
               iunit = andf(A(l),16383)
               ia1 = A(l+1)
               ia2 = A(l+2)
               IF ( ia1==0 ) THEN
                  ia1 = iblnk
                  ia2 = iblnk
               ENDIF
               m1 = l + 3
               m2 = l + 5
               CALL page2(-1)
               WRITE (Op,99017) iequiv , iappnd , ltu , itape , iunit , ia1 , ia2
99017          FORMAT (7X,I1,7X,I1,3X,I6,4X,I1,1X,I6,2X,2A4)
               IF ( Icfiat==8 ) WRITE (Op,99018) (A(m),m=m1,m2)
99018          FORMAT (1H+,48X,3I20)
               IF ( Icfiat==11 ) WRITE (Op,99019) (A(m),m=m1,m2) , (A(m+m2),m=3,5)
99019          FORMAT (1H+,48X,6I10)
            ENDDO
         ENDIF
         IF ( J/=0 ) THEN
!WKBD OPEN (UNIT=4, FILE='FORTDIC.ZAP', STATUS='UNKNOWN')
            IF ( Iropen/=1 ) Iropen = 1
            WRITE (Irdict,99027) I
            CALL sswtch(9,diag09)
            IF ( diag09/=1 ) THEN
               CALL page1
               Nlines = Nlines + 3
               WRITE (Op,99020)
99020          FORMAT (9X,'CONTINUATION OF CHECKPOINT DICTIONARY',/,1H )
               WRITE (Op,99027) I
            ENDIF
         ENDIF
      ENDIF
   ELSEIF ( Msgno==11 ) THEN
!
!     MESSAGE 11
!     ==========
!
      CALL page2(-6)
      WRITE (Op,99021) Uim , I
99021 FORMAT (A29,' 4148',/5X,'NOTE THAT ADDITIONAL DMAP INSTRUCTIONS',' (NOT INDICATED BY AN * IN THE DMAP SOURCE LISTING)',/5X,   &
             &'NEED TO BE FLAGGED FOR EXECUTION SINCE THIS UNMODIFIED ','RESTART INVOLVES DMAP LOOPING AND',/5X,                    &
             &'THE REENTRY POINT IS WITHIN A DMAP LOOP.  SUCH INSTRUCT','IONS ARE IDENTIFIED BELOW.',/5X,                           &
             &'THE EXECUTION WILL, HOWEVER, RESUME AT THE LAST REENTRY',' POINT (DMAP INSTRUCTION NO.',I5,2H).,/)
   ELSEIF ( Msgno==12 ) THEN
!
!     MESSAGE 12
!     ==========
!
      CALL page2(-5)
      WRITE (Op,99022) Uim
99022 FORMAT (A29,' 4147',/5X,'NOTE THAT ADDITIONAL DMAP INSTRUCTIONS',' (NOT INDICATED BY AN * IN THE DMAP SOURCE LISTING)',/5X,   &
             &'NEED TO BE FLAGGED FOR EXECUTION IN ORDER TO GENERATE ','CERTAIN REQUIRED DATA BLOCKS.',/5X,                         &
             &'SUCH INSTRUCTIONS AND THE ASSOCIATED DATA BLOCKS ARE ','IDENTIFIED BELOW.')
   ELSEIF ( Msgno==13 ) THEN
!
!     MESSAGE 13   (XGPI)
!     ===================
!
      nscr = 315
      l = 20
      CALL open(*99999,nscr,A(l),0)
      CALL page1
      CALL page3(4)
      WRITE (Op,99023) Uim
99023 FORMAT (A29,' - DUE TO ERROR(S), POSSIBLY ORIGINATED FROM USER''S',' ALTER PACKAGE, THE UNMODIFIED RIGID FORMAT LISTING',/5X, &
             &'IS PRINTED FOR CROSS REFERENCE',/)
      l = 0
      DO
         CALL read(*100,*100,nscr,A(1),18,0,m)
         IF ( A(1)==iblnk ) THEN
            Nlines = Nlines + 1
            IF ( Nlines>=Nlpp ) CALL page
            WRITE (Op,99026) (A(m),m=1,18)
         ELSE
            CALL page3(2)
            l = l + 1
            WRITE (Op,99025) l , (A(m),m=1,18)
         ENDIF
      ENDDO
   ELSE
!
!     MESSAGE 1 - INITIALIZE PAGE HEADING
!     ===================================
!
      i1 = -I
      IF ( i1<0 ) THEN
         i1 = hdg1(1)
         i2 = i1 + 1
         DO m = 1 , i1
            Pghdg(m+96) = hdg1(m+1)
         ENDDO
         DO m = i2 , 32
            Pghdg(m+96) = Nblank
         ENDDO
         IF ( I==1 ) THEN
            i1 = hdg2(1)
            i2 = i1 + 1
            DO m = 1 , i1
               Pghdg(m+128) = hdg2(m+1)
            ENDDO
            DO m = i2 , 32
               Pghdg(m+128) = Nblank
            ENDDO
            i1 = hdg3(1)
            i2 = i1 + 1
            DO m = 1 , i1
               Pghdg(m+160) = hdg3(m+1)
            ENDDO
            DO m = i2 , 32
               Pghdg(m+160) = Nblank
            ENDDO
            IF ( diagi4/=0 .OR. Start/=Icst ) THEN
               ipage = 1
               CALL page
            ENDIF
            GOTO 99999
         ELSE
            IF ( I==2 ) THEN
               i1 = hdg4(1)
               DO m = 1 , i1
                  Pghdg(m+128) = hdg4(m+1)
               ENDDO
            ELSE
               i1 = hdg5(1)
               DO m = 1 , i1
                  Pghdg(m+128) = hdg5(m+1)
               ENDDO
            ENDIF
            i1 = i1 + 32
         ENDIF
      ENDIF
!
!     BLANK OUT HEADING
!
      i2 = i1 + 1
      DO m = i2 , 96
         Pghdg(m+96) = Nblank
      ENDDO
      Nlines = Nlpp
   ENDIF
   GOTO 99999
 100  CALL close(nscr,1)
99024 FORMAT (1H0,/,'0  + INDICATES DMAP INSTRUCTIONS THAT ARE PROCESS','ED ONLY AT DMAP COMPILATION TIME.')
99025 FORMAT (/1X,I7,2X,20A4)
99026 FORMAT (10X,20A4)
99027 FORMAT (9X,'1,   XVPS    ,   FLAGS = 0,   REEL =  1,   FILE =',I7)
!
99999 END SUBROUTINE xgpimw