!*==rcovc.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE rcovc
   IMPLICIT NONE
   USE c_blank
   USE c_condas
   USE c_names
   USE c_rcovcm
   USE c_rcovcr
   USE c_system
   USE c_unpakx
   USE c_xmssg
   USE c_zzzzzz
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , DIMENSION(3) :: acce , disp , nfwd , oload , spcf , velo
   INTEGER , DIMENSION(1) :: buf
   INTEGER , DIMENSION(2) , SAVE :: casecc , name
   INTEGER , SAVE :: casess , eqss , opg1 , oqg1 , ougv1 , pg , pvec , scr1 , scr2 , scr3 , scr6 , scr7 , scr8 , soln , srd , uvec
   LOGICAL :: complx , end , incore , keep , non0 , once , pflag , qflag , supres , uflag
   INTEGER , DIMENSION(3) , SAVE :: comps
   REAL , DIMENSION(12) :: data
   INTEGER , DIMENSION(32) :: dofs
   REAL :: eigen , eigeni , thresh , value
   INTEGER :: file , i , iappro , icode , icomb , idc , ieqss , iform , iloc , in , iopst , iout , isc , iseq , iset , isets ,      &
            & isil , iskip , iss , isub , it , item , itype , ivect , j , jeqss , js , jset , jsil , jss , k , kid , kpoint , kset ,&
            & lcc , lid , lseq , lsets , lskip , mode , n , nccrec , neqss , next , njset , nmodes , np , nreq , ns , nsets ,       &
            & nskip , nss , nsteps , nwds , nword , rc
   INTEGER , DIMENSION(146) :: idbuf
   INTEGER , DIMENSION(2) :: iz , namef
   INTEGER , DIMENSION(7) :: mcba
   REAL , DIMENSION(1) :: rbuf
   REAL , DIMENSION(7) :: rdbuf
   INTEGER , DIMENSION(4) , SAVE :: substr
!
! End of declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     RCOVC COMPUTES REACTION FORCES AND GENERATES OUTPUT DATA BLOCKS
!     FOR DISPLACEMENTS, APPLIED LOADS, AND REACTION FORCES.
!
   !>>>>EQUIVALENCE (Buf(1),Z(1))
   !>>>>EQUIVALENCE (Z(1),Iz(1)) , (Buf(1),Rbuf(1)) , (idbuf(1),rdbuf(1))
   DATA casess , ougv1 , opg1 , oqg1 , scr1 , pg , scr3 , scr6 , scr7 , scr8 , scr2/101 , 201 , 202 , 203 , 301 , 105 , 303 , 306 , &
      & 307 , 308 , 302/
   DATA srd/1/
   DATA eqss , soln , uvec , pvec/4HEQSS , 4HSOLN , 4HUVEC , 4HPVEC/
   DATA name , casecc , substr/4HRCOV , 4HC    , 4HCASE , 4HCC   , 4HSUBS , 4HTRUC , 4HTURE , 4H    /
   DATA comps/4HCOMP , 4HONEN , 4HT   /
!
!     INITIALIZE
!
   IF ( dry<0 ) RETURN
   sof1 = korsz(z) - lreq - sysbuf + 1
   sof2 = sof1 - sysbuf - 1
   sof3 = sof2 - sysbuf
   buf1 = sof3 - sysbuf
   buf2 = buf1 - sysbuf
   buf3 = buf2 - sysbuf
   buf4 = buf3 - sysbuf
   lcore = buf4 - 1
   IF ( lcore<=0 ) THEN
      WRITE (nout,99003) swm , rss
      GOTO 2000
   ELSE
      CALL sofopn(z(sof1),z(sof2),z(sof3))
!
!     ================================================
!     THIS CARD SHOULD BE ADDED WHEN SDR3 IS FIXED
!
!     IF (RFNO .EQ. 9) NOSORT = 1
!
!     ================================================
      pa = 0
      qa = 0
      uflag = .FALSE.
      pflag = .FALSE.
      qflag = .FALSE.
!
!     CHECK OUTPUT REQUESTS ON CASESS
!
      CALL gopen(casess,z(buf1),rdrew)
      nccrec = 1
      file = casess
      DO
         CALL fread(casess,z,2,1)
         nccrec = nccrec + 1
         IF ( iz(1)==casecc(1) .AND. iz(2)==casecc(2) ) THEN
            DO
               CALL read(*100,*1900,casess,idbuf,35,1,i)
               IF ( idbuf(17)/=0 ) pflag = .TRUE.
               IF ( idbuf(20)/=0 ) uflag = .TRUE.
               IF ( idbuf(29)/=0 .AND. rfno>=8 ) uflag = .TRUE.
               IF ( idbuf(32)/=0 .AND. rfno>=8 ) uflag = .TRUE.
               IF ( idbuf(35)/=0 ) qflag = .TRUE.
               IF ( pflag .AND. uflag .AND. qflag ) GOTO 100
            ENDDO
         ENDIF
      ENDDO
   ENDIF
 100  CALL close(casess,rew)
!
   IF ( buf(ireq)==1 ) uflag = .TRUE.
   IF ( buf(ireq+1)==1 ) pflag = .TRUE.
   IF ( buf(ireq+2)==1 ) qflag = .TRUE.
   IF ( energy/=0 ) THEN
      uflag = .TRUE.
      IF ( rfno>=3 .AND. rfno<=8 ) pflag = .TRUE.
      IF ( rfno>=3 .AND. rfno<=8 ) qflag = .TRUE.
   ENDIF
!
   IF ( .NOT.(uflag .OR. pflag .OR. qflag) ) GOTO 1500
!
!     COMPUTE THE APPLIED STATIC LOADS FOR THE REQUESTED SUBSTRUCTURE
!     IF WE ARE PRINTING THE SOLUTION SUBSTRUCTURE CHECK IF THE LOADS
!     ARE ON A GINO FILE.
!
   IF ( rfno==3 ) pflag = .FALSE.
   IF ( .NOT.(.NOT.pflag .AND. (.NOT.qflag .OR. rfno==3)) ) THEN
      IF ( rss(1)==fss(1) .AND. rss(2)==fss(2) ) THEN
         pa = pg
         mcba(1) = pg
         CALL rdtrl(mcba)
         IF ( mcba(1)>0 ) GOTO 200
      ENDIF
      pa = scr3
      CALL rcovsl(rss,pvec,0,scr6,scr7,scr8,pa,z(1),z(1),sof3-1,.FALSE.,rfno)
      IF ( pa<=0 ) pflag = .FALSE.
   ENDIF
!
!     GET THE DISPLACEMENT VECTOR AND IF RIGID FORMAT 8 THEN
!     CALCULATE THE VELOCITIES AND ACCELERATIONS.
!
 200  IF ( .NOT.uflag .AND. .NOT.qflag ) GOTO 500
   mcba(1) = ua
   CALL rdtrl(mcba)
   IF ( mcba(1)>0 ) GOTO 400
   ua = scr2
   CALL mtrxi(ua,rss,uvec,0,rc)
   IF ( rc==1 ) GOTO 400
 300  ua = 0
   WRITE (nout,99001) swm , rss
99001 FORMAT (A27,' 6319, DISPLACEMENT MATRIX FOR SUBSTRUCTURE ',2A4,' MISSING.'/5X,'DISPLACEMENT OUTPUT REQUESTS CANNOT BE ',      &
             &'HONORED.  SPCFORCE OUTPUT REQUESTS CANNOT BE HONORED UN','LESS THE',/5X,'REACTIONS HAVE BEEN PREVIOUSLY COMPUTED.')
   uflag = .FALSE.
   qflag = .FALSE.
   energy = 0
!
 400  IF ( .NOT.(rfno/=8 .OR. .NOT.(uflag .OR. qflag)) ) THEN
      CALL rcovva(ua,0,scr1,0,0,0,rss,z(1),z(1),z(1))
      IF ( ua<=0 ) GOTO 300
      ua = scr1
   ENDIF
!
!     COMPUTE THE SPCF REACTIONS IF OUTPUT REQUESTS WERE SPECIFIED
!
 500  IF ( qflag ) CALL rcovqv
   IF ( qa<=0 ) qflag = .FALSE.
!
!     OUTPUT PROCESSING
!
!
!     IF IOPT IS EQUAL TO ONE THEN THE OUTPUT WILL BE SORTED BY SUBCASE
!     IF EQUAL TO TWO IT WILL BE SORTED BY SUBSTRUCTURE
!
   np = buf(ireq+3)
   ns = buf(ireq+4)
!
!     FIND THE LENGTH AND TYPE OF THE VECTORS TO BE OUTPUT
!
   CALL softrl(rss,uvec,mcba)
   nmodes = mcba(2)
   nsteps = mcba(2)
   IF ( rfno==9 ) nsteps = nsteps/3
   complx = .FALSE.
   IF ( mcba(5)>=3 ) complx = .TRUE.
   nword = 1
   IF ( complx ) nword = 2
!
!     PERFORM GENERAL INITIALIZATION OF OFP ID RECORD
!
   idbuf(3) = 0
   idbuf(6) = 0
   idbuf(7) = 0
   idbuf(8) = 0
   idbuf(10) = 8
   IF ( complx ) idbuf(10) = 14
   DO i = 11 , 50
      idbuf(i) = 0
   ENDDO
!
!     INITALIZE THE UNPACK COMMON BLOCK
!
   utypo = 1
   IF ( complx ) utypo = 3
   iru = 1
   nru = mcba(3)
   incu = 1
!
!     ALLOCATE OPEN CORE
!
   isets = 1
   lsets = 100
   ivect = isets + lsets
   isil = ivect + (nru*nword)
   ieqss = isil + np
   IF ( ieqss+2>lcore ) THEN
      WRITE (nout,99003) swm , rss
      GOTO 2000
   ELSE
!
!
!                          OPEN CORE DIAGRAM FOR /RCOVCX/
!
!                       +----------------------------------+
!          Z(ISETS)     I                                  I
!                       I     CASECC SET INFORMATION       I
!                       I                                  I
!                       +----------------------------------+
!          Z(IVECT)     I                                  I
!                       I     VECTOR TO BE PRINTED         I
!                       I                                  I
!                       +----------------------------------+
!          Z(ISIL )     I                                  I
!                       I     SCALAR INDEX LIST FROM EQSS  I
!                       I                                  I
!                       +----------------------------------+
!          Z(IEQSS)     I                                  I
!                       I     EQSS DATA IN TRIPLES OF      I
!                       I        (1) EXTERNAL GRID ID      I
!                       I        (2) INTERNAL POINT INDEX  I
!                       I        (3) COMPONENT CODE        I
!                       I     DATA FOR EACH BASIC SUB-     I
!                       I     STRUCTURE TERMINATED BY      I
!                       I     THREE (-1)S                  I
!                       I                                  I
!                       I     NOTE  EQSS DATA MAY NOT BE   I
!                       I     IN CORE IF SPILL LOGIC       I
!                       I     INVOKED.                     I
!                       I                                  I
!                       +----------------------------------+
!          Z(ISEQ)      I                                  I
!                       I     SYMMETRY SEQUENCE            I
!                       I                                  I
!                       +----------------------------------+
!          Z(ICOMB)     I                                  I
!                       I     VECTOR CONTRIBUTING TO THE   I
!                       I     LINEAR COMBINATION FOR THE   I
!                       I     SYMMETRY SEQUENCE            I
!                       I                                  I
!                       +----------------------------------+
!
!     READ SIL FROM EQSS INTO OPEN CORE AT ISIL
!
      CALL sfetch(rss,eqss,srd,rc)
      n = ns + 1
      CALL sjump(n)
      DO i = 1 , np
         CALL suread(z(isil+i-1),1,nwds,rc)
         CALL suread(j,1,nwds,rc)
      ENDDO
!
!     READ EQSS DATA INTO OPEN CORE AT IEQSS IF IT WILL FIT.  IF IOPT
!     EQUALS 2, READ ONLY ONE GROUP AND PRCESS ONE BASIC SUBSTRUCTURE
!     A TIME.
!
      incore = .FALSE.
      neqss = ieqss + 2
      CALL sfetch(rss,eqss,srd,rc)
      n = 1
      CALL sjump(n)
      nss = ns
      IF ( iopt==2 ) nss = 1
      iss = 0
   ENDIF
!
!     TOP OF LOOP OVER BASIC SUBSTRUCTURES WHEN PROCESSING ONE AT A TIME
!
 600  iss = iss + 1
   k = lcore - ieqss + 1
   j = ieqss
   item = eqss
   DO i = 1 , nss
      CALL suread(z(j),k,nwds,rc)
      IF ( rc==3 ) GOTO 1600
      IF ( rc/=2 ) GOTO 700
      j = j + nwds
      IF ( j+3>lcore ) GOTO 700
      iz(j) = -1
      iz(j+1) = -1
      iz(j+2) = -1
      j = j + 3
      neqss = j - 1
      k = k - nwds - 3
      IF ( k<=0 ) GOTO 700
   ENDDO
   incore = .TRUE.
   GOTO 800
!
!     EQSS WILL NOT FIT IN CORE
!
 700  neqss = ieqss + 2
 800  iseq = neqss + 1
!
!     WRITE HEADER RECORDS ON OUTPUT DATA BLOCKS AND POSITION BOTH
!     INPUT AND OUTPUT DATA BLOCKS AFTER THE HEADER RECORD
!
   DO i = 1 , 3
      IF ( i==2 ) THEN
!
!     CHECK LOAD VECTOR
!
         IF ( .NOT.pflag ) CYCLE
         in = pa
         iout = opg1
      ELSEIF ( i==3 ) THEN
!
!     CHECK READTIONS VECTOR
!
         IF ( .NOT.qflag ) CYCLE
         in = qa
         iout = oqg1
      ELSE
!
!     CHECK DISPLACEMENT VECTOR
!
         IF ( .NOT.uflag ) CYCLE
         in = ua
         iout = ougv1
      ENDIF
!
!     POSITION FILES
!
      CALL gopen(in,z(buf1),rdrew)
      CALL close(in,norew)
      IF ( iss<=1 ) THEN
         CALL open(*850,iout,z(buf2),wrtrew)
         CALL fname(iout,namef)
         CALL write(iout,namef,2,1)
         CALL close(iout,norew)
      ENDIF
      CYCLE
!
!     OUTPUT FILE PURGED - TURN OFF REQUEST FLAG
!
 850  WRITE (nout,99002) swm , iout
99002 FORMAT (A27,' 6314, OUTPUT REQUEST CANNOT BE HONORED.',/34X,'RCOVR MODULE OUTPUT DATA BLOCK',I4,' IS PURGED.')
      IF ( iout==ougv1 ) uflag = .FALSE.
      IF ( iout==opg1 ) pflag = .FALSE.
      IF ( iout==oqg1 ) qflag = .FALSE.
   ENDDO
!
!     SETUP FOR LOOP OVER SUBCASES
!
   isc = 0
   DO i = 1 , 3
      nfwd(i) = 0
   ENDDO
!
!     POSITION CASESS TO FIRST CASECC SUBCASE
!
   file = casess
   CALL open(*1700,casess,z(buf3),rdrew)
   DO i = 1 , nccrec
      CALL fwdrec(*1800,casess)
   ENDDO
   end = .FALSE.
!
!     TOP OF LOOP OVER SUBCASES
!
 900  isc = isc + 1
   itype = 1
   IF ( end ) GOTO 1300
!
!     READ OUTPUT REQUESTS FROM CASECC RECORD
!
   CALL read(*1000,*1900,casess,0,-3,0,nwds)
   CALL fread(casess,lid,1,0)
   CALL fread(casess,0,-12,0)
   CALL fread(casess,oload,3,0)
   CALL fread(casess,disp,3,0)
   CALL fread(casess,0,-6,0)
   CALL fread(casess,acce,3,0)
   CALL fread(casess,velo,3,0)
   CALL fread(casess,spcf,3,0)
   CALL fread(casess,0,-1,0)
!
!     SET OUTPUT TYPE AND MEDIA - IF NO REQUEST IN CASE CONTROL
!     THE DEFAULT VALUES ARE REAL AND PRINTER
!
   iform = 1
   IF ( complx ) iform = 2
   IF ( disp(2)==0 ) disp(2) = 1
   IF ( disp(3)==0 ) disp(3) = iform
   IF ( disp(3)<0 ) nosort = 1
   IF ( oload(2)==0 ) oload(2) = 1
   IF ( oload(3)==0 ) oload(3) = iform
   IF ( oload(3)<0 ) nosort = 1
   IF ( spcf(2)==0 ) spcf(2) = 1
   IF ( spcf(3)==0 ) spcf(3) = iform
   IF ( spcf(3)<0 ) nosort = 1
   IF ( velo(2)==0 ) velo(2) = 1
   IF ( velo(3)==0 ) velo(3) = iform
   IF ( velo(3)<0 ) nosort = 1
   IF ( acce(2)==0 ) acce(2) = 1
   IF ( acce(3)==0 ) acce(3) = iform
   IF ( acce(3)<0 ) nosort = 1
!
!     READ TITLE, SUBTITLE, AND LABEL.  WILL REPLACE RIGHTMOST WORDS OF
!     SUBTITLE WITH BASIC SUBSTRUCTURE NAME
!
   CALL fread(casess,idbuf(51),96,0)
   DO i = 1 , 3
      idbuf(i+101) = substr(i)
      idbuf(i+133) = comps(i)
   ENDDO
   idbuf(105) = substr(4)
   idbuf(106) = rss(1)
   idbuf(107) = rss(2)
!
!     READ SYMMETRY SEQUENCE AND SET INFORMATION
!
   nwds = -1
   iz(isets) = 0
   iz(isets+1) = 0
   CALL fread(casess,0,-31,0)
   CALL fread(casess,lcc,1,0)
   lskip = 167 - lcc
   CALL fread(casess,0,lskip,0)
   CALL read(*1800,*1200,casess,lseq,1,0,n)
   IF ( neqss+lseq>lcore ) THEN
      WRITE (nout,99003) swm , rss
      GOTO 2000
   ELSE
      IF ( lseq>0 ) CALL read(*1800,*1200,casess,z(iseq),lseq,0,n)
      icomb = iseq + lseq
      IF ( icomb+nru>lcore ) THEN
         WRITE (nout,99003) swm , rss
         GOTO 2000
      ELSE
         CALL read(*1800,*1200,casess,z(isets),lsets,0,nwds)
         k = lsets
         DO
!
!     MUST EXPAND SETS PORTION OF OPEN CORE
!
            n = lcore - neqss
            IF ( n>0 ) THEN
               DO i = isil , neqss
                  iz(lcore-i+1) = iz(neqss-i+1)
               ENDDO
               ivect = ivect + n
               isil = isil + n
               ieqss = ieqss + n
               neqss = neqss + n
               CALL read(*1800,*1100,casess,z(isets+lsets),n,0,nwds)
               k = k + n
            ELSEIF ( .NOT.incore ) THEN
               WRITE (nout,99003) swm , rss
               GOTO 2000
            ELSE
               incore = .FALSE.
               neqss = ieqss + 2
            ENDIF
         ENDDO
      ENDIF
   ENDIF
!
!     END OF CASE CONTROL RECORDS - CHECK IF THIS IS REALLY THE END
!
 1000 end = .TRUE.
   IF ( rfno<=2 ) GOTO 1400
   IF ( rfno==3 .AND. isc>nmodes ) GOTO 1400
   IF ( rfno<8 .OR. isc<=nsteps ) GOTO 1300
   GOTO 1400
 1100 nwds = k + nwds
 1200 nsets = isets + nwds
 1300 DO
!
!     PROCESS OUTPUT ITYPE
!
      once = .FALSE.
      jeqss = ieqss - 3
      iskip = 0
      IF ( .NOT.(itype==1 .AND. .NOT.uflag) ) THEN
         IF ( .NOT.(itype==2 .AND. .NOT.pflag) ) THEN
            IF ( .NOT.(itype==3 .AND. .NOT.qflag) ) THEN
               IF ( .NOT.(itype==4 .AND. .NOT.uflag) ) THEN
                  IF ( .NOT.(itype==5 .AND. .NOT.uflag) ) THEN
!
!     FOR EACH BASIC SUBSTRUCTURE CURRENTLY BEING PROCESSED, CONSTRUCT
!     ONE OFP ID AND DATA RECORD PAIR.  THE BASIC LOOP IS ABOVE THE
!     VECTOR PROCESSING BECAUSE OUTPUT REQUESTS CAN CHANGE FOR EACH
!     BASIC
!
                     DO js = 1 , nss
                        jss = iss + js - 1
                        nreq = ireq + (jss-1)*lbasic + 5
                        kpoint = buf(nreq+12)
!
!     STATICS
!
                        IF ( rfno>2 ) THEN
!
!     FOR NORMAL MODES GET MODE NUMBER, EIGENVALUE AND FREQUENCY
!
                           IF ( rfno/=3 ) THEN
!
!     FOR DYNAMICS GET THE TIME OR FREQUENCY
!
                              IF ( rfno==8 .OR. rfno==9 ) THEN
                                 IF ( js<=1 ) THEN
                                    CALL sfetch(fss,soln,srd,rc)
                                    n = 1
                                    CALL sjump(n)
                                    j = isc - 1
                                    IF ( j/=0 ) THEN
                                       DO i = 1 , j
                                         CALL suread(mcba(1),1,nwds,rc)
                                       ENDDO
                                    ENDIF
                                    CALL suread(value,1,nwds,rc)
!
                                    iappro = 5
                                    IF ( rfno==9 ) iappro = 6
                                    idbuf(4) = isc
                                    rdbuf(5) = value
                                    idbuf(8) = lid
                                 ENDIF
                              ENDIF
                           ELSEIF ( js<=1 ) THEN
                              CALL sfetch(fss,soln,srd,rc)
                              n = 1
                              CALL sjump(n)
                              j = isc - 1
                              IF ( j/=0 ) THEN
                                 DO i = 1 , j
                                    CALL suread(mcba(1),7,nwds,rc)
                                 ENDDO
                              ENDIF
                              CALL suread(mode,1,nwds,rc)
                              CALL suread(i,1,nwds,rc)
                              CALL suread(eigen,1,nwds,rc)
                              CALL suread(eigeni,1,nwds,rc)
                              CALL suread(value,1,nwds,rc)
!
                              iappro = 2
                              IF ( complx ) iappro = 9
                              idbuf(4) = isc
                              idbuf(5) = mode
                              rdbuf(6) = eigen
                              rdbuf(7) = 0.0
                              IF ( complx ) rdbuf(7) = eigeni
                           ENDIF
                        ELSEIF ( js<=1 ) THEN
                           iappro = 1
                           idbuf(4) = isc
                           idbuf(5) = lid
                        ENDIF
!
!     GET SUBCASE OR MODE REQUEST
!
                        IF ( rfno<=2 ) THEN
                           isub = isc
                           iloc = 5
                        ELSEIF ( rfno/=3 ) THEN
                           isub = isc
                           iloc = 11
                        ELSE
                           isub = mode
                           iloc = 6
                        ENDIF
                        iset = buf(nreq+iloc)
                        IF ( iset>=0 ) THEN
                           IF ( iset==0 ) GOTO 1316
!
!     FIND THE REQUESTED SET
!
                           jset = isets
                           DO WHILE ( iset/=iz(jset) )
                              jset = jset + iz(jset+1) + 2
                              IF ( jset>=nsets ) THEN
!
!     SET NOT FOUND, ISSUE WARNING AND PRINT ALL INSTEAD.
!
                                 WRITE (nout,99004) uwm , iset
                                 buf(nreq+iloc) = -1
                                 GOTO 1302
                              ENDIF
                           ENDDO
!
!     FIND IF CURRENT SUBCASE OR MODE IS IN REQUESTED SET
!
                           next = 1
                           kset = iz(jset+1)
                           CALL setfnd(*1316,iz(jset+2),kset,isub,next)
                        ENDIF
!
!     SO FAR SO GOOD - IF NORMAL MODES OR DYNAMICS PROBLEM CHECK IF
!     EIGEN VALUE, TIME OR FREQUENCY IS IN REQUESTED RANGE
!
 1302                   IF ( rfno>=3 ) THEN
                           IF ( value<rbuf(nreq+7) ) GOTO 1316
                           IF ( value>rbuf(nreq+8) ) GOTO 1316
                        ENDIF
!
                        IF ( itype==2 ) THEN
!
!     PROCESS OLOAD REQUESTS
!
                           iopst = oload(1)
                           IF ( buf(nreq+3)>-2 ) iopst = buf(nreq+3)
                           IF ( iopst==0 .AND. lseq==0 ) GOTO 1316
                           IF ( once ) GOTO 1310
                           once = .TRUE.
!
                           idc = oload(2)
                           iform = iabs(oload(3))
                           thresh = pthres
                           supres = .TRUE.
                           idbuf(2) = 2
                           in = pa
                           iout = opg1
                        ELSEIF ( itype==3 ) THEN
!
!     PROCESS SPCFORCE (ACTUALLY, ALL REACTIONS) REQUESTS
!
                           iopst = spcf(1)
                           IF ( buf(nreq+4)>-2 ) iopst = buf(nreq+4)
                           IF ( iopst==0 .AND. lseq==0 ) GOTO 1316
                           IF ( once ) GOTO 1310
                           once = .TRUE.
!
                           idc = spcf(2)
                           iform = iabs(spcf(3))
                           thresh = qthres
                           supres = .TRUE.
                           idbuf(2) = 3
                           in = qa
                           iout = oqg1
                        ELSEIF ( itype==4 ) THEN
!
!     PROCESS VELOCITY REQUESTS
!
                           iopst = velo(1)
                           IF ( buf(nreq+9)>-2 ) iopst = buf(nreq+9)
                           IF ( iopst==0 .AND. lseq==0 ) GOTO 1316
                           IF ( once ) GOTO 1310
                           once = .TRUE.
!
                           idc = velo(2)
                           iform = iabs(velo(3))
                           idbuf(2) = 10
                           thresh = uthres
                           supres = .FALSE.
                           in = ua
                           iout = ougv1
                        ELSEIF ( itype==5 ) THEN
!
!     PROCESS ACCELERATION REQUESTS
!
                           iopst = acce(1)
                           IF ( buf(nreq+10)>-2 ) iopst = buf(nreq+10)
                           IF ( iopst==0 .AND. lseq==0 ) GOTO 1316
                           IF ( once ) GOTO 1310
                           once = .TRUE.
!
                           idc = acce(2)
                           iform = iabs(acce(3))
                           idbuf(2) = 11
                           thresh = uthres
                           supres = .FALSE.
                           in = ua
                           iout = ougv1
                        ELSE
!
!     PROCESS DISPLACEMENT REQUESTS
!
                           iopst = disp(1)
                           IF ( buf(nreq+2)>-2 ) iopst = buf(nreq+2)
                           IF ( iopst==0 .AND. lseq==0 ) GOTO 1316
                           IF ( once ) GOTO 1310
                           once = .TRUE.
!
                           idc = disp(2)
                           iform = iabs(disp(3))
                           idbuf(2) = 1
                           IF ( rfno==3 ) idbuf(2) = 7
                           thresh = uthres
                           supres = .FALSE.
                           in = ua
                           iout = ougv1
                        ENDIF
!
!     OPEN FILES AND UNPACK VECTOR TO BE PRINTED
!
                        file = in
                        CALL gopen(in,z(buf1),rd)
                        CALL gopen(iout,z(buf2),wrt)
                        it = itype
                        IF ( itype>3 ) it = 1
                        IF ( lseq>0 ) THEN
!
!     FORM LINEAR COMBINATION FOR SYMMETRY SEQUENCE
!
                           n = nfwd(it) - lseq
                           IF ( n<0 ) THEN
                              n = -n
                              DO i = 1 , n
                                 CALL bckrec(in)
                              ENDDO
                           ELSEIF ( n/=0 ) THEN
                              DO i = 1 , n
                                 CALL fwdrec(*1800,in)
                              ENDDO
                           ENDIF
                           DO i = 1 , nru
                              z(ivect+i-1) = 0.0E0
                           ENDDO
                           DO i = 1 , lseq
                              CALL unpack(*1304,in,z(icomb))
                              DO j = 1 , nru
                                 z(ivect+j-1) = z(ivect+j-1) + z(iseq+i-1)*z(icomb+j-1)
                              ENDDO
 1304                      ENDDO
                           nfwd(it) = 0
                        ELSE
                           n = nfwd(it)
                           IF ( n>0 ) THEN
                              DO i = 1 , n
                                 CALL fwdrec(*1800,in)
                              ENDDO
                              nfwd(it) = 0
                           ENDIF
                           CALL unpack(*1306,in,z(ivect))
                        ENDIF
                        GOTO 1308
 1306                   n = nru*nword
                        DO i = 1 , n
                           z(ivect+i-1) = 0.0
                        ENDDO
!
!     IF EQSS DATA NOT IN CORE, POSITION THE SOF
!
 1308                   IF ( .NOT.(incore) ) THEN
                           CALL sfetch(rss,eqss,srd,rc)
                           nskip = iss + iskip
                           CALL sjump(nskip)
                           jeqss = ieqss
                        ENDIF
!
!     INSERT SUBSTRUCTURE NAME IN IDREC WRITE IT OUT
!
 1310                   idbuf(1) = idc + 10*iappro
                        IF ( complx .AND. js==1 ) idbuf(2) = idbuf(2) + 1000
                        idbuf(9) = iform
                        idbuf(138) = buf(nreq)
                        idbuf(139) = buf(nreq+1)
                        keep = .FALSE.
!
!     FIND THE REQUESTED OUTPUT SET
!
                        next = 1
                        jset = isets
                        njset = jset + 1
                        IF ( iopst>=0 ) THEN
                           DO WHILE ( iopst/=iz(jset) )
                              jset = jset + iz(jset+1) + 2
                              IF ( jset>=nsets ) THEN
!
!     SET NOT FOUND. ISSUE A WARNING AND PRINT ALL INSTEAD
!
                                 WRITE (nout,99004) uwm , iopst
                                 i = itype + 1
                                 IF ( itype>3 ) i = i + 4
                                 buf(nreq+i) = -1
                                 iopst = -1
                                 EXIT
                              ENDIF
                           ENDDO
                        ENDIF
!
!     FOR EACH GRID POINT ID IN EQSS FOR THE CURRENT SUBSTRUCTURE WHICH
!     IS A MEMBER OF THE REQUESTED OUTPUT SET, WRITE A LINE OF OUTPUT
!
 1312                   IF ( incore ) THEN
                           jeqss = jeqss + 3
                           IF ( iz(jeqss)<=0 ) GOTO 1314
                        ELSE
                           CALL suread(z(jeqss),3,nwds,rc)
                           IF ( rc/=1 ) GOTO 1314
                        ENDIF
!
                        IF ( iopst>=0 ) THEN
                           IF ( next>iz(jset+1) ) GOTO 1314
                           kset = iz(jset+1)
                           kid = iz(jeqss)
                           CALL setfnd(*1312,iz(jset+2),kset,kid,next)
                        ENDIF
!
!     WRITE A LINE OF OUTPUT
!
                        icode = iz(jeqss+2)
                        CALL decode(icode,dofs(1),n)
                        dofs(n+1) = -1
                        jsil = iz(jeqss+1) + isil - 1
                        k = 0
                        non0 = .FALSE.
                        DO i = 1 , 6
                           IF ( dofs(k+1)+1==i ) THEN
                              j = ivect + (iz(jsil)-1)*nword + k*nword
                              k = k + 1
                              data(i) = z(j)
                              IF ( complx ) THEN
                                 data(6+i) = z(j+1)
                                 IF ( iform==3 .AND. data(i)+data(6+i)/=0.0 ) THEN
                                    data(i) = sqrt(z(j)**2+z(j+1)**2)
                                    data(6+i) = atan2(z(j+1),z(j))*raddeg
                                    IF ( data(6+i)<-.000005 ) data(6+i) = data(6+i) + 360.0
                                 ENDIF
                                 IF ( .NOT.(supres .AND. data(i)+data(6+i)==0.0) ) THEN
                                    IF ( abs(data(i))>=thresh .OR. abs(data(6+i))>=thresh ) THEN
                                       non0 = .TRUE.
                                       CYCLE
                                    ENDIF
                                 ENDIF
                              ELSEIF ( .NOT.(supres .AND. data(i)==0.0) ) THEN
                                 IF ( abs(data(i))>=thresh ) THEN
                                    non0 = .TRUE.
                                    CYCLE
                                 ENDIF
                              ENDIF
                           ENDIF
                           data(i) = 0.0
                           data(6+i) = 0.0
                        ENDDO
                        IF ( non0 ) THEN
                           IF ( .NOT.keep ) CALL write(iout,idbuf,146,1)
                           CALL write(iout,10*iz(jeqss)+idc,1,0)
                           CALL write(iout,kpoint,1,0)
                           CALL write(iout,data,6*nword,0)
                           keep = .TRUE.
                        ENDIF
                        IF ( next<=iz(jset+1) .OR. iopst<0 ) GOTO 1312
!
!     IF NO DATA WAS WRITTEN FOR THIS BASIC BACKREC THE OFP FILE
!     OVER THE PREVIOUSLY WRITTEN ID RECORD
!
 1314                   IF ( keep ) CALL write(iout,0,0,1)
                        IF ( iz(jeqss)<0 .OR. (.NOT.incore .AND. rc/=1) ) CYCLE
!
!     NO MORE OUTPUT FOR THIS BASIC - SKIP EQSS DATA
!
 1316                   IF ( incore ) THEN
                           DO
                              jeqss = jeqss + 3
                              IF ( iz(jeqss)<=0 ) EXIT
                           ENDDO
                        ELSEIF ( once ) THEN
                           n = 1
                           CALL sjump(n)
                        ELSE
                           iskip = iskip + 1
                        ENDIF
                     ENDDO
!
!     GO BACK AND DO ANOTHER OUTPUT TYPE
!
                     CALL close(in,norew)
                     CALL close(iout,norew)
                  ENDIF
               ENDIF
            ENDIF
         ENDIF
      ENDIF
      IF ( .NOT.(once) ) THEN
         it = itype
         IF ( itype>3 ) it = 1
         nfwd(it) = nfwd(it) + 1
      ENDIF
      itype = itype + 1
      IF ( itype>3 ) THEN
         IF ( itype>5 .OR. rfno<8 ) THEN
            IF ( end ) THEN
               IF ( rfno/=3 .OR. isc>=nmodes ) THEN
                  IF ( rfno<8 .OR. isc>=nsteps ) EXIT
               ENDIF
            ENDIF
            GOTO 900
         ENDIF
      ENDIF
   ENDDO
!
!     ALL SUBCASES PROCESSED,  IF IOPT EQ 2, GO BACK AND PROCESS
!     NEXT BASIC SUBSTRUCTURE
!
 1400 CALL close(casess,rew)
   IF ( iopt==1 .OR. iss==ns ) THEN
!
!     WRITE TRAILERS AND EOF ON OUTPUT DATA BLOCKS
!
      DO i = 2 , 7
         mcba(i) = 1
      ENDDO
      IF ( uflag ) THEN
         CALL gopen(ougv1,z(buf1),wrt)
         CALL close(ougv1,rew)
         mcba(1) = ougv1
         CALL wrttrl(mcba)
      ENDIF
      IF ( pflag ) THEN
         CALL gopen(opg1,z(buf1),wrt)
         CALL close(opg1,rew)
         mcba(1) = opg1
         CALL wrttrl(mcba)
      ENDIF
      IF ( qflag ) THEN
         CALL gopen(oqg1,z(buf1),wrt)
         CALL close(oqg1,rew)
         mcba(1) = oqg1
         CALL wrttrl(mcba)
      ENDIF
   ELSE
      CALL sfetch(rss,eqss,srd,rc)
      n = iss + 1
      CALL sjump(n)
      GOTO 600
   ENDIF
!
!     NORMAL MODULE TERMINATION
!
 1500 CALL sofcls
   RETURN
!
!     ERROR PROCESSING
!
 1600 n = 7
   CALL smsg(n,item,rss)
   GOTO 2000
 1700 n = 1
   CALL mesage(n,file,name)
   GOTO 2000
 1800 n = 2
   CALL mesage(n,file,name)
   GOTO 2000
 1900 n = 3
   CALL mesage(n,file,name)
 2000 CALL sofcls
   DO i = 101 , 111
      CALL close(i,rew)
   ENDDO
   DO i = 201 , 203
      CALL close(i,rew)
   ENDDO
   DO i = 301 , 308
      CALL close(i,rew)
   ENDDO
   RETURN
!
!     DIAGNOSTICS FORMAT STATEMENTS
!
99003 FORMAT (A27,' 6313, INSUFFICIENT CORE FOR RCOVR MODULE WHILE ','TRYING TO PROCESS',/34X,'PRINTOUT DATA BLOCKS FOR ',          &
             &'SUBSTRUCTURE',2A4)
99004 FORMAT (A25,' 6365, REQUESTED OUTPUT SET ID',I6,' IS NOT DECLARED',' IN CASE CONTROL, ALL OUTPUT WILL BE PRODUCED.')
END SUBROUTINE rcovc
