
SUBROUTINE mma324(Zi,Zd)
   IMPLICIT NONE
   INCLUDE 'MMACOM.COM'
!
! COMMON variable declarations
!
   DOUBLE COMPLEX Cd
   INTEGER Cls , Clsrew , Filea(7) , Fileb(7) , Filec(7) , Filed(7) , Incrp , Incru , Iprc(2) , Iprow1 , Iprown , Irc(4) , Iurow1 , &
         & Iurown , Iwr , Kdrow , Ksystm(152) , Nac , Nadens , Naform , Nanzwd , Nar , Natype , Nbc , Nbdens , Nbform , Nbnzwd ,    &
         & Nbr , Nbtype , Ncc , Ncdens , Ncform , Ncnzwd , Ncr , Nctype , Ndc , Nddens , Ndform , Ndnzwd , Ndr , Ndtype , Nwords(4) &
         & , Nz , Rd , Rdrew , Signab , Signc , T , Typei , Typep , Typeu , Wrt , Wrtrew
   REAL D(4) , Prec1 , Scrtch , Sysbuf , Time
   COMMON /mpyadx/ Filea , Fileb , Filec , Filed , Nz , T , Signab , Signc , Prec1 , Scrtch , Time
   COMMON /names / Rd , Rdrew , Wrt , Wrtrew , Clsrew , Cls
   COMMON /packx / Typei , Typep , Iprow1 , Iprown , Incrp
   COMMON /system/ Ksystm
   COMMON /type  / Iprc , Nwords , Irc
   COMMON /unpakx/ Typeu , Iurow1 , Iurown , Incru
   COMMON /zblpkx/ D , Kdrow
!
! Dummy argument declarations
!
   DOUBLE PRECISION Zd(2)
   INTEGER Zi(2)
!
! Local variable declarations
!
   DOUBLE COMPLEX cdtemp
   INTEGER i , icola , icrows , idrow , ii , indxa , indxal , indxav , indxb , indxbs , indxbv , indxc , indxcv , irow1 , irowa1 ,  &
         & irowan , irowb1 , irowbn , irowc1 , irowcn , irown , irows , k , kcnt , lasindb , lasindc , nrows , ntms
!
! End of declarations
!
!
!     MMA324 PERFORMS THE MATRIX OPERATION IN COMPLEX DOUBLE PRECISION
!       (+/-)A(T & NT) * B (+/-)C = D
!
!     MMA324 USES METHOD 32 WHICH IS AS FOLLOWS:
!       1.  THIS IS FOR "A" NON-TRANSPOSED AND TRANSPOSED
!       2.  CALL MMARM1 TO PACK AS MANY COLUMNS OF "A" INTO MEMORY
!           AS POSSIBLE LEAVING SPACE FOR ONE COLUMN OF "B" AND "D".
!       3.  ADD EACH ROW TERM OF "C" TO "D" MATRIX COLUMN
!       4.  CALL MMARC1,2,3,4 TO READ COLUMNS OF "B" AND "C".
!
   EQUIVALENCE (D(1),Cd)
   EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(2),Iwr)
   EQUIVALENCE (Filea(2),Nac) , (Filea(3),Nar) , (Filea(4),Naform) , (Filea(5),Natype) , (Filea(6),Nanzwd) , (Filea(7),Nadens)
   EQUIVALENCE (Fileb(2),Nbc) , (Fileb(3),Nbr) , (Fileb(4),Nbform) , (Fileb(5),Nbtype) , (Fileb(6),Nbnzwd) , (Fileb(7),Nbdens)
   EQUIVALENCE (Filec(2),Ncc) , (Filec(3),Ncr) , (Filec(4),Ncform) , (Filec(5),Nctype) , (Filec(6),Ncnzwd) , (Filec(7),Ncdens)
   EQUIVALENCE (Filed(2),Ndc) , (Filed(3),Ndr) , (Filed(4),Ndform) , (Filed(5),Ndtype) , (Filed(6),Ndnzwd) , (Filed(7),Nddens)
!
!   OPEN CORE ALLOCATION AS FOLLOWS:
!     Z( 1        ) = ARRAY FOR ONE COLUMN OF "B" MATRIX IN COMPACT FORM
!     Z( IDX      ) = ARRAY FOR ONE COLUMN OF "D" MATRIX
!     Z( IAX      ) = ARRAY FOR MULTIPLE COLUMNS OF "A" MATRIX
!        THROUGH
!     Z( LASMEM   )
!     Z( IBUF4    ) = BUFFER FOR "D" FILE
!     Z( IBUF3    ) = BUFFER FOR "C" FILE
!     Z( IBUF2    ) = BUFFER FOR "B" FILE
!     Z( IBUF1    ) = BUFFER FOR "A" FILE
!     Z( NZ       ) = END OF OPEN CORE THAT IS AVAILABLE
!
   Filed(2) = 0
   Filed(6) = 0
   Filed(7) = 0
   idrow = Ibrow
   DO ii = 1 , Nbc
      CALL bldpk(Ndtype,Ndtype,Ofile,0,0)
!      PRINT *,' PROCESSING B MATRIX COLUMN, II=',II
!
! READ A COLUMN FROM THE "B" MATRIX
!
      Sign = 1
      Irfile = Fileb(1)
      CALL mmarc4(Zi,Zd)
      lasindb = Lasind
!
! NOW READ "C", OR SCRATCH FILE WITH INTERMEDIATE RESULTS.
! IF NO "C" FILE AND THIS IS THE FIRST PASS, INITIALIZE "D" COLUMN TO ZERO.
!
      IF ( Ifile/=0 ) THEN
         IF ( Ipass==1 ) Sign = Signc
         Irfile = Ifile
!
! READ A COLUMN FROM THE "C" MATRIX
!
         CALL mmarc4(Zi(Idx),Zd(Idx2+1))
         lasindc = Lasind + Idx - 1
      ENDIF
!
! CHECK IF COLUMN OF "B" IS NULL
!
      IF ( Zi(1)/=0 ) THEN
         irowb1 = Zi(1)
         irows = Zi(2)
         irowbn = irowb1 + irows - 1
         indxb = 1
         indxa = Iax
         indxc = Idx
         IF ( Ifile/=0 .AND. indxc<lasindc ) THEN
            irowc1 = Zi(indxc)
            icrows = Zi(indxc+1)
            irowcn = irowc1 + icrows - 1
!
! CHECK TO ADD TERMS FROM "C" OR INTERIM SCRATCH FILE BEFORE CURRENT ROW
!
            IF ( idrow/=0 .AND. irowc1<=idrow ) THEN
               DO
                  irown = idrow
                  IF ( irowcn<idrow ) irown = irowcn
                  indxcv = (indxc+3)/2
                  nrows = irown - irowc1 + 1
                  DO i = 1 , nrows
                     Kdrow = irowc1 + i - 1
                     Cd = dcmplx(Zd(indxcv),Zd(indxcv+1))
                     indxcv = indxcv + 2
                     CALL zblpki
                  ENDDO
                  IF ( irowcn>=idrow ) EXIT
                  indxc = indxc + 2 + icrows*Nwdd
                  IF ( indxc>=lasindc ) EXIT
                  irowc1 = Zi(indxc)
                  icrows = Zi(indxc+1)
                  irowcn = irowc1 + icrows - 1
               ENDDO
            ENDIF
         ENDIF
!
! CHECK FOR NULL COLUMN FROM "B" MATRIX
!
         IF ( irowb1/=0 ) THEN
!
!  TRANSPOSE CASE ( A(T) * B + C )
!
! COMPLEX DOUBLE PRECISION
            DO i = 1 , Ncolpp
               Cd = (0.0D0,0.0D0)
               Kdrow = idrow + i
               icola = Ibrow + i
               IF ( icola/=iabs(Zi(indxa)) ) GOTO 100
               indxal = Zi(indxa+1) + Iax - 1
               indxa = indxa + 2
               indxb = 1
               DO WHILE ( indxb<lasindb )
                  irowb1 = Zi(indxb)
                  irows = Zi(indxb+1)
                  irowbn = irowb1 + irows - 1
                  indxbs = indxb
                  indxb = indxb + 2 + irows*Nwdd
                  DO WHILE ( indxa<indxal )
                     irowa1 = Zi(indxa)
                     ntms = Zi(indxa+1)
                     irowan = irowa1 + ntms - 1
                     IF ( irowbn<irowa1 ) GOTO 5
                     IF ( irowan<irowb1 ) THEN
                        indxa = indxa + 2 + ntms*Nwdd
                     ELSE
                        irow1 = max0(irowa1,irowb1)
                        irown = min0(irowan,irowbn)
                        indxav = ((indxa+3)/2) + 2*(irow1-irowa1) - 1
                        indxbv = ((indxbs+3)/2) + 2*(irow1-irowb1) - 1
                        cdtemp = (0.0D0,0.0D0)
                        kcnt = (irown-irow1)*2 + 1
                        DO k = 1 , kcnt , 2
                           cdtemp = cdtemp + dcmplx(Zd(indxav+k),Zd(indxav+k+1))*dcmplx(Zd(indxbv+k),Zd(indxbv+k+1))
                        ENDDO
                        Cd = Cd + cdtemp
                        IF ( irowan>irowbn ) GOTO 5
                        indxa = indxa + 2 + ntms*Nwdd
                     ENDIF
                  ENDDO
                  indxa = indxal
                  GOTO 10
 5             ENDDO
               indxa = indxal
 10            DO WHILE ( indxc<lasindc .AND. Ifile/=0 )
                  IF ( Kdrow<irowc1 ) EXIT
                  IF ( Kdrow>irowcn ) THEN
                     indxc = indxc + 2 + icrows*Nwdd
                     IF ( indxc>=lasindc ) EXIT
                     irowc1 = Zi(indxc)
                     icrows = Zi(indxc+1)
                     irowcn = irowc1 + icrows - 1
                  ELSE
                     indxcv = (indxc+3)/2 + 2*(Kdrow-irowc1)
                     Cd = Cd + dcmplx(Zd(indxcv),Zd(indxcv+1))
                     EXIT
                  ENDIF
               ENDDO
               CALL zblpki
            ENDDO
         ENDIF
         IF ( Kdrow/=Ndr .AND. Ifile/=0 .AND. indxc<lasindc ) THEN
!
! ADD REMAINING TERMS FROM EITHER THE "C" MATRIX OR INTERIM SCRATCH MATRIX
!
            irow1 = Kdrow + 1
            DO
               indxcv = (indxc+3)/2
               IF ( irow1<irowc1 ) EXIT
               IF ( irow1<=irowcn ) THEN
                  indxcv = (indxc+3)/2 + 2*(irow1-irowc1)
                  irowc1 = irow1
                  EXIT
               ELSE
                  indxc = indxc + 2 + icrows*Nwdd
                  IF ( indxc>=lasindc ) GOTO 50
                  irowc1 = Zi(indxc)
                  icrows = Zi(indxc+1)
                  irowcn = irowc1 + icrows - 1
               ENDIF
            ENDDO
            DO
               nrows = irowcn - irowc1 + 1
               DO k = 1 , nrows
                  Kdrow = irowc1 + k - 1
                  Cd = dcmplx(Zd(indxcv),Zd(indxcv+1))
                  indxcv = indxcv + 2
                  CALL zblpki
               ENDDO
               indxc = indxc + 2 + icrows*Nwdd
               IF ( indxc>=lasindc ) EXIT
               irowc1 = Zi(indxc)
               icrows = Zi(indxc+1)
               irowcn = irowc1 + icrows - 1
               indxcv = (indxc+3)/2
            ENDDO
         ENDIF
      ELSE
         IF ( Ifile/=0 ) THEN
            IF ( Zi(Idx)/=0 ) THEN
               indxc = Idx
               DO WHILE ( indxc<lasindc )
                  irowc1 = Zi(indxc)
                  icrows = Zi(indxc+1)
                  irowcn = irowc1 + icrows - 1
                  indxcv = (indxc+3)/2
                  DO i = irowc1 , irowcn
                     Cd = dcmplx(Zd(indxcv),Zd(indxcv+1))
                     Kdrow = i
                     CALL zblpki
                     indxcv = indxcv + 2
                  ENDDO
                  indxc = indxc + 2 + icrows*Nwdd
               ENDDO
               GOTO 50
            ENDIF
         ENDIF
         Cd = (0.0D0,0.0D0)
         Kdrow = 1
         CALL zblpki
      ENDIF
 50   CALL bldpkn(Ofile,0,Filed)
! END OF PROCESSING THIS COLUMN FOR THIS PASS
   ENDDO
   GOTO 99999
 100  WRITE (Iwr,99001) icola , Zi(indxa) , Iax , indxa
99001 FORMAT (' UNEXPECTED COLUMN FOUND IN PROCESSING MATRIX A',/,' COLUMN EXPECTED:',I6,/,' COLUND FOUND   :',I6,/,' IAX =',I7,    &
             &' INDXA=',I7)
   CALL mesage(-61,0,0)
99999 END SUBROUTINE mma324