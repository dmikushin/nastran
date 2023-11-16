
SUBROUTINE sdcmm(Z,Mset,Msze,Matrix,Uset,Gpl,Sil,Subnam)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Buf , Filmsg , Iout , Isubst , Kcl2 , Krd2 , Krr0 , Ksystm(69) , Nbufsz , Nerr(2) , Noglev
   REAL Skpn(3)
   CHARACTER*23 Ufm
   CHARACTER*25 Uwm
   COMMON /names / Krd2 , Krr0 , Skpn , Kcl2
   COMMON /sdcq  / Nerr , Noglev , Buf , Filmsg
   COMMON /system/ Ksystm
   COMMON /xmssg / Ufm , Uwm
!
! Dummy argument declarations
!
   INTEGER Gpl , Matrix , Mset , Msze , Sil , Uset
   INTEGER Subnam(2) , Z(1)
!
! Local variable declarations
!
   INTEGER buf2 , err(14) , exit(8) , gpid(4) , i , iblk , in(3) , iner(4) , iret , j , k , l , n(7) , name(2) , nstart , nwds ,    &
         & typ(6)
   CHARACTER*4 ctyp(6)
   REAL xgpid(4) , xin(3)
!
! End of declarations
!
!
!     THIS ROUTINE WRITES THE EXTERNAL ID AND COMPONENT ID FOR VARIOUS
!     MATRIX ERROR CONDITIONS.
!     SCRATCH1 CONTAINS 3 WORDS/ERROR, EACH MESSAGE BEING 1 RECORD
!         WORD 1 = COLUMN * 10 + ERROR CODE
!         WORD 2 = INPUT DIAGONAL
!         WORD 3 = OUTPUT DIAGONAL
!     SUBROUTINE -MXCID- (NON-SUBSTRUCTURING) IS CALLED TO SUPPLY IDENT.
!     DATA FOR EACH COLUMN.  FOR SUBSTRUCTURING -MXCIDS- IS CALLED - IT
!     RETURNS TWO WORDS/COLUMN PLUS THE BCD NAME OF THE SUBSTRUCTURES AT
!     THE START OF CORE.  IN EITHER CASE, THE 1ST WORD IS 10*ID +
!         COMPONENT.
!     THE SCRATCH FILE IS READ AND THE EXTERNAL ID INDEXED DIRECTLY.E
!     NOTE - THAT EACH COLUMN MAY GENERATE MORE THAN 1 MESSAGE.
!     OPEN CORE IS Z(1) TO Z(BUF-1).  TWO BUFFERS FOLLOW Z(BUF)
!
!WKBNB 8/94
!WKBNE 8/94
!WKBI  8/94
   EQUIVALENCE (ctyp,typ) , (xgpid,gpid) , (xin,in)
   EQUIVALENCE (Ksystm(1),Nbufsz) , (Ksystm(2),Iout) , (Ksystm(69),Isubst)
   DATA err/4HNULL , 4HCOL. , 4HZERO , 4HDIAG , 4HNEG. , 4HDIAG , 4HSING , 4HTEST , 4HBAD  , 4HCOL. , 4HNON- , 4HCONS , 4HZERO ,    &
       &4HDIAG/
   DATA iner/4HINPU , 2HT  , 4HDECM , 2HP /
   DATA exit/4HCONT , 4HINUE , 4HAT E , 4HND   , 4HAT S , 4HTART , 4HIN D , 4HECMP/
   DATA name/4HSDCM , 2HM /
   DATA iblk/4H    /
!
   buf2 = Buf + Nbufsz
   n(1) = 0
   n(2) = 0
   n(3) = 0
   n(4) = 0
   n(5) = 0
   n(6) = 0
   n(7) = 0
   IF ( Buf<=0 ) GOTO 500
!
!     GENERATE EXTERNAL ID
!
   IF ( Isubst==0 ) THEN
!
      nstart = 0
      nwds = 1
!
!     2 BUFFERS NEEDED
!
      CALL mxcid(*500,Z,Mset,Msze,nwds,Uset,Gpl,Sil,Buf)
   ELSE
!
!     SUBSTRUCTURING - READ EQSS FILE ON THE SOF
!
!     4 BUFFERS NEEDED
!
      i = Buf - 2*Nbufsz
      IF ( i<=3*Msze ) GOTO 500
      nwds = 2
      CALL mxcids(*500,Z,Mset,Msze,nwds,Uset,i,Subnam)
      nstart = i - 1
   ENDIF
!
   CALL open(*800,Filmsg,Z(buf2),Krr0)
   CALL page2(3)
   WRITE (Iout,99001) Uwm
99001 FORMAT (A25,' 2377A, MATRIX CONDITIONING ERRORS GIVEN WITH ','EXTERNAL ID',/5X,'GID - C  INPUT-DIAG.   DECOMP-DIAG.',6X,      &
            & 'TYPE',17X,'SUBSTRUCTURE')
!
   ASSIGN 400 TO iret
   typ(5) = iblk
   typ(6) = iblk
   IF ( Isubst/=0 ) ASSIGN 300 TO iret
!
!     LOOP ON MESSAGES - 0 COLUMN IS FLAG TO QUIT
!
 100  CALL fread(Filmsg,in,3,1)
   IF ( in(1)==0 ) GOTO 900
   i = in(1)/10
   j = in(1) - i*10
   l = nstart + i*nwds
   gpid(1) = Z(l)/10
   gpid(2) = Z(l) - gpid(1)*10
   gpid(3) = in(2)
   gpid(4) = in(3)
!
!     INTERNAL FUNCTION
!
 200  IF ( j<=0 .OR. j>7 ) THEN
!
!     ILLEGAL DATA
!
      CALL mesage(7,Filmsg,name)
      GOTO 900
   ELSE
      k = 2*j - 1
      typ(1) = err(k)
      typ(2) = err(k+1)
      k = 1
      IF ( j>1 .AND. j<7 ) k = 3
      typ(3) = iner(k)
      typ(4) = iner(k+1)
      n(j) = n(j) + 1
      CALL page2(2)
      GOTO iret
   ENDIF
!
 300  typ(5) = Z(2*l-1)
   typ(6) = Z(2*l)
!WKBR 8/94      WRITE  (IOUT,40) GPID,TYP
 400  WRITE (Iout,99002) gpid(1) , gpid(2) , xgpid(3) , xgpid(4) , ctyp
99002 FORMAT (1H0,I9,2H -,I2,1P,2E14.6,3X,2A5,2H/ ,A4,A2,6HMATRIX,2X,2A4)
   GOTO 100
!
!     INSUFFICIENT CORE IN -MATCID-
!
 500  CALL page2(3)
   WRITE (Iout,99003) Uwm
99003 FORMAT (A25,' 2377B, MATRIX CONDITIONING ERRORS GIVEN WITH ','INTERNAL ID',/,5X,'COLUMN  INPUT DIAG.   DECOMP-DIAG.',6X,      &
            & 'TYPE')
!
   CALL open(*800,Filmsg,Z(buf2),Krr0)
   ASSIGN 700 TO iret
!
!     LOOP
!
 600  CALL fread(Filmsg,in,3,1)
   IF ( in(1)==0 ) GOTO 900
   i = in(1)/10
   j = in(1) - i*10
   in(1) = i
   GOTO 200
!
!WKBR 8/94  WRITE  (IOUT,90) IN,TYP
 700  WRITE (Iout,99004) in(1) , xin(2) , xin(3) , ctyp
99004 FORMAT (1H0,I8,1P,2E14.6,3X,2A5,2H/ ,A4,A2,6HMATRIX,2X,2A4)
   GOTO 600
!
!     SCRATCH FILE NOT AVAILABLE
!
 800  CALL mesage(1,Filmsg,name)
!
!     ALL DONE, SUMMARIZE
!
 900  CALL page2(11)
   WRITE (Iout,99005) Matrix , Msze , n
99005 FORMAT (1H0,3X,10HFOR MATRIX,I4,6H, SIZE,I8,/I9,13H NULL COLUMNS,/I9,15H ZERO DIAGONALS,/I9,19H NEGATIVE DIAGONALS,/I9,       &
             &31H SINGULARITY TOLERANCE EXCEEDED,/I9,12H BAD COLUMNS,/I9,24H NONCONSERVATIVE COLUMNS,/I9,23H ZERO DIAGONALS (INPUT))
!
!     CHECK FOR EXIT CONDITIONS
!
   i = 2*Noglev + 1
!
!     NOTE - NOGLEV OF 4 ALSO HAS NEGATIVE PARM(1)
!
   IF ( Noglev==4 ) i = 7
   j = i + 1
   WRITE (Iout,99006) exit(i) , exit(j)
99006 FORMAT (1H0,3X,13HABORT CODE = ,2A4)
   CALL close(Filmsg,Kcl2)
END SUBROUTINE sdcmm