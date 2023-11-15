
SUBROUTINE mpy3oc(Z,Iz,Dz)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL A(2) , D , Dum(2) , Dum1(2) , Fileb(7) , Scr
   INTEGER Buf1 , Buf2 , Buf3 , Buf4 , Code , Eol , Eor , Filea(7) , Filec(7) , Filee(7) , Iakj , Iantu , Ibcid , Ibcols , Ibntu ,  &
         & Ic , Iflag , Iktbp , Ilast , Incr , Intbu , Intbu2 , Irow , Isavp , J , K , K2 , Ka , Kcount , Laend , Lcore , Lkore ,   &
         & Ltac , Ltbc , M , Maxa , Mcore , Mfilea(7) , Mfileb(7) , Mfilec(7) , Mfilee(7) , Mprec , Mscr , Mt , N , Nakj , Nantu ,  &
         & Nbcid , Nbcols , Nbntu , Nc , Ncb , Nk , Nktbp , Nlast , Nntbu , Nntbu2 , Nout , Nsavp , Prec , Row1 , Rowm , Scr1 ,     &
         & Scr2 , Scr3(7) , Signab , Signc , Sysbuf , Typin , Typout , Uincr , Urow1 , Urown , Utyp , Zpntrs(22)
   DOUBLE PRECISION Da
   LOGICAL E , First1 , First2
   COMMON /mpy3cp/ Dum1 , N , Ncb , M , Nk , D , Maxa , Zpntrs , Laend , First1 , First2 , K , K2 , Kcount , Iflag , Ka , Ltbc , J ,&
                 & Ltac
   COMMON /mpy3tl/ Filea , Fileb , Filee , Filec , Scr1 , Scr2 , Scr , Lkore , Code , Prec , Lcore , Scr3 , Buf1 , Buf2 , Buf3 ,    &
                 & Buf4 , E
   COMMON /mpyadx/ Mfilea , Mfileb , Mfilee , Mfilec , Mcore , Mt , Signab , Signc , Mprec , Mscr
   COMMON /packx / Typin , Typout , Row1 , Rowm , Incr
   COMMON /system/ Sysbuf , Nout
   COMMON /unpakx/ Utyp , Urow1 , Urown , Uincr
   COMMON /zntpkx/ A , Dum , Irow , Eol , Eor
!
! Dummy argument declarations
!
   DOUBLE PRECISION Dz(1)
   INTEGER Iz(1)
   REAL Z(1)
!
! Local variable declarations
!
   INTEGER buf5 , file , i , j1 , j2 , jbck , jfwd , jj , jj1 , kan , kbc , kbn , kc , kf , kk , kl , kn , kn2 , kt , mm , name(2) ,&
         & nams(2) , nerr , precm
   LOGICAL first3
!
! End of declarations
!
!
!     OUT-OF-CORE PRODUCT.
!
!
!     MPYAD COMMON
!
!     FILES
!
!     SUBROUTINE CALL PARAMETERS
!
!     PACK
!
!     UNPACK
!
!     TERMWISE MATRIX READ
!
!     SYSTEM PARAMETERS
   EQUIVALENCE (Isavp,Zpntrs(1)) , (Nsavp,Zpntrs(2)) , (Intbu,Zpntrs(3)) , (Nntbu,Zpntrs(4)) , (Ilast,Zpntrs(5)) , (Nlast,Zpntrs(6))&
    & , (Intbu2,Zpntrs(7)) , (Nntbu2,Zpntrs(8)) , (Ic,Zpntrs(9)) , (Nc,Zpntrs(10)) , (Ibcols,Zpntrs(11)) , (Nbcols,Zpntrs(12)) ,    &
    & (Ibcid,Zpntrs(13)) , (Nbcid,Zpntrs(14)) , (Ibntu,Zpntrs(15)) , (Nbntu,Zpntrs(16)) , (Iktbp,Zpntrs(17)) , (Nktbp,Zpntrs(18)) , &
    & (Iantu,Zpntrs(19)) , (Nantu,Zpntrs(20)) , (Iakj,Zpntrs(21)) , (Nakj,Zpntrs(22)) , (A(1),Da)
   DATA name/4HMPY3 , 4HOC  /
   DATA nams/4HSCR3 , 4H    /
!
!     RECALCULATION OF NUMBER OF COLUMNS OF B ABLE TO BE PUT IN CORE.
!
   buf5 = Buf4 - Sysbuf
   Lcore = buf5 - 1
   Nk = (Lcore-4*N-Prec*M-(2+Prec)*Maxa)/(2+Prec*N)
   IF ( Nk<1 ) THEN
      nerr = -8
      file = 0
      CALL mesage(nerr,file,name)
   ELSE
!
!    INITIALIZATION.
!
      First1 = .TRUE.
      First2 = .TRUE.
      first3 = .FALSE.
      precm = Prec*M
!
!     OPEN CORE POINTERS
!
      Isavp = 1
      Nsavp = Ncb
      Intbu = Nsavp + 1
      Nntbu = Nsavp + Ncb
      Ilast = Nntbu + 1
      Nlast = Nntbu + Ncb
      Intbu2 = Nlast + 1
      Nntbu2 = Nlast + Ncb
      Ic = Nntbu2 + 1
      Nc = Nntbu2 + Prec*M
      Ibcols = Nc + 1
      Nbcols = Nc + Prec*N*Nk
      Ibcid = Nbcols + 1
      Nbcid = Nbcols + Nk
      Ibntu = Nbcid + 1
      Nbntu = Nbcid + Nk
      Iktbp = Nbntu + 1
      Nktbp = Nbntu + Maxa
      Iantu = Nktbp + 1
      Nantu = Nktbp + Maxa
      Iakj = Nantu + 1
      Nakj = Nantu + Prec*Maxa
      kf = Nsavp
      kl = Nntbu
      kn2 = Nlast
      kbc = Nbcols
      kbn = Nbcid
      kt = Nbntu
      kan = Nktbp
!
!     PACK PARAMETERS
!
      Typin = Prec
      Typout = Prec
      Row1 = 1
      Incr = 1
!
!     UNPACK PARAMETERS
!
      Utyp = Prec
      Urow1 = 1
      Uincr = 1
!
!     MATRIX TRAILERS
!
      CALL makmcb(Scr3,Scr3(1),N,2,Prec)
      IF ( M==N ) Scr3(4) = 1
!
!     PUT B ONTO SCRATCH FILE IN UNPACKED FORM.
!
      CALL mpy3a(Z,Z,Z)
!
!     OPEN FILES AND CHECK EXISTENCE OF MATRIX E.
!
      IF ( .NOT.(Code==0 .OR. .NOT.E) ) THEN
         file = Filee(1)
         CALL open(*200,Filee,Z(buf5),2)
         CALL fwdrec(*300,Filee)
      ENDIF
      file = Filea(1)
      CALL open(*200,Filea,Z(Buf1),0)
      CALL fwdrec(*300,Filea)
      file = Scr1
      CALL open(*200,Scr1,Z(Buf2),0)
      file = Scr2
      CALL open(*200,Scr2,Z(Buf3),1)
      IF ( Code==0 ) THEN
         file = Scr3(1)
         CALL open(*200,Scr3,Z(Buf4),1)
         CALL write(Scr3,nams,2,1)
         Rowm = Scr3(3)
      ELSE
         file = Filec(1)
         CALL gopen(Filec,Z(Buf4),1)
         Rowm = Filec(3)
      ENDIF
!
!     PROCESS SCR2 AND SET FIRST-TIME-USED AND LAST-TIME-USED FOR EACH
!     ROW OF A.
!
      DO K = 1 , Ncb
         Iz(kf+K) = 0
         Iz(kl+K) = 0
      ENDDO
      DO J = 1 , M
         K = 0
         CALL intpk(*20,Filea,0,Prec,0)
         DO
            CALL zntpki
            K = K + 1
            Iz(kt+K) = Irow
            IF ( Iz(kf+Irow)<=0 ) Iz(kf+Irow) = J
            Iz(kl+Irow) = J
            IF ( Eol==1 ) THEN
               CALL write(Scr2,Iz(Iktbp),K,0)
               EXIT
            ENDIF
         ENDDO
 20      CALL write(Scr2,0,0,1)
      ENDDO
      CALL close(Filea,1)
      CALL open(*200,Filea,Z(Buf1),2)
      CALL fwdrec(*300,Filea)
      CALL close(Scr2,1)
      CALL open(*200,Scr2,Z(Buf3),0)
!
!     PROCESS COLUMNS OF A ONE AT A TIME.
!
      DO J = 1 , M
!
!     INITIALIZE SUM - ACCUMULATION MATRIX TO 0.
!
         DO i = Ic , Nc
            Z(i) = 0.
         ENDDO
         IF ( .NOT.(Code==0 .OR. .NOT.E) ) THEN
            Urown = N
            CALL unpack(*40,Filee,Z(Ic))
         ENDIF
!
!     PROCESS A AND PERFORM FIRST PART OF PRODUCT BA(J).
!
 40      CALL mpy3b(Z,Z,Z)
!
!     TEST IF PROCESSING IS COMPLETE
!
         IF ( Iflag==0 ) GOTO 160
!
!     PROCESS REMAINING TERMS OF COLUMN J OF A.
!
!     TEST IF BCOLS IS FULL
!
 60      IF ( K2<Nk ) GOTO 140
!
!     CALCULATE NEW NEXT TIME USED VALUES
!
         IF ( .NOT.(first3) ) THEN
            First2 = .FALSE.
            first3 = .TRUE.
            DO jj = 1 , J
               CALL fwdrec(*300,Scr2)
            ENDDO
         ENDIF
         file = Scr2
         kc = 0
         kn = kf
         DO Ka = 1 , Ncb
            kn = kn + 1
            IF ( J<Iz(kn) ) THEN
               kc = kc + 1
               IF ( J+1<Iz(kn) ) THEN
                  Iz(kn2+Ka) = Iz(kn)
                  kc = kc + 1
                  CYCLE
               ELSEIF ( J+1>=Iz(kl+Ka) ) THEN
                  Iz(kn2+Ka) = 99999999
                  kc = kc + 1
                  CYCLE
               ENDIF
            ELSEIF ( J<Iz(kl+Ka) ) THEN
               Iz(kn) = 0
            ELSE
               Iz(kn) = 99999999
               Iz(kn2+Ka) = Iz(kn)
               kc = kc + 2
               CYCLE
            ENDIF
            Iz(kn2+Ka) = 0
         ENDDO
         IF ( kc==2*Ncb ) THEN
            IF ( J/=M ) CALL fwdrec(*300,Scr2)
            GOTO 120
         ELSE
            jj = J + 1
         ENDIF
 80      DO
            CALL read(*300,*100,Scr2,Ka,1,0,kk)
            IF ( Iz(kn2+Ka)<=0 ) THEN
               IF ( jj/=J+1 ) THEN
                  Iz(kn2+Ka) = jj
                  kc = kc + 1
               ENDIF
               IF ( Iz(kf+Ka)<=0 ) THEN
                  Iz(kf+Ka) = jj
                  kc = kc + 1
               ENDIF
               IF ( kc==2*Ncb ) THEN
                  mm = M - 1
                  IF ( J/=mm ) THEN
!
!     POSITION SCRATCH FILE FOR NEXT PASS THROUGH
!
                     jj = jj - J
                     j2 = J + 2
                     jj1 = jj - 1
                     IF ( j2<jj1 ) THEN
                        CALL rewind(Scr2)
                        j1 = J + 1
                        DO jfwd = 1 , j1
                           CALL fwdrec(*300,Scr2)
                        ENDDO
                     ELSEIF ( jj1>0 ) THEN
                        DO jbck = 1 , jj1
                           CALL bckrec(Scr2)
                        ENDDO
                     ELSE
                        CALL fwdrec(*300,Scr2)
                     ENDIF
                  ENDIF
                  GOTO 120
               ENDIF
            ENDIF
         ENDDO
 100     jj = jj + 1
         GOTO 80
!
!     ASSIGN NEXT TIME USED TO COLUMNS OF B IN CORE
!
 120     DO kk = 1 , Nk
            i = Iz(kbc+kk)
            Iz(kbn+kk) = Iz(kf+i)
         ENDDO
!
!     ASSIGN NEXT TIME USED TO NON-ZERO TERMS IN COLUMN OF A
!
         DO kk = 1 , K
            IF ( Iz(kt+kk)==0 ) THEN
               Iz(kan+kk) = 0
            ELSE
               i = Iz(kt+kk)
               Iz(kan+kk) = Iz(kf+i)
            ENDIF
         ENDDO
 140     DO
!
!     PERFORM MULTIPLICATION AND SUMMATION FOR NEXT TERM OF COLUMN OF A
!
            CALL mpy3c(Z,Z,Z)
!
!     TEST IF PROCESSING OF BA(J) IS COMPLETE
!
            IF ( Kcount==K ) EXIT
            IF ( First2 ) GOTO 60
            Iz(kbn+Ltbc) = Iz(kn2+Ltac)
         ENDDO
!
!     PACK COLUMN OF C OR BA.
!
 160     IF ( Code==0 ) THEN
            CALL pack(Z(Ic),Scr3,Scr3)
         ELSE
            CALL pack(Z(Ic),Filec,Filec)
         ENDIF
      ENDDO
!
!     CLOSE FILES.
!
      CALL close(Filea,2)
      CALL close(Scr1,1)
      CALL close(Scr2,1)
      IF ( E ) CALL close(Filee,2)
      IF ( Code==0 ) THEN
         CALL close(Scr3,1)
         CALL wrttrl(Scr3)
!
!     CALL MPYAD TO FINISH PRODUCT
!
         DO i = 1 , 7
            Mfilea(i) = Filea(i)
            Mfileb(i) = Scr3(i)
            Mfilee(i) = Filee(i)
            Mfilec(i) = Filec(i)
         ENDDO
         Mt = 1
         Signab = 1
         Signc = 1
         Mprec = Prec
         Mscr = Scr1
         CALL mpyad(Z,Z,Z)
      ELSE
         CALL close(Filec,1)
      ENDIF
   ENDIF
   GOTO 99999
!
!     ERROR MESSAGES.
!
 200  nerr = -1
   CALL mesage(nerr,file,name)
   GOTO 99999
 300  nerr = -2
   CALL mesage(nerr,file,name)
!
99999 END SUBROUTINE mpy3oc
