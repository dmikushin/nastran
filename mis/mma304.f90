
 
SUBROUTINE mma304(Zi,Zd,Zdc)
   IMPLICIT NONE
   INCLUDE 'MMACOM.COM'
!
! COMMON variable declarations
!
   INTEGER Cls , Clsrew , Filea(7) , Fileb(7) , Filec(7) , Filed(7) , Incrp , Incru , Iprc(2) , Iprow1 , Iprown , Irc(4) , Iurow1 , &
         & Iurown , Iwr , Ksystm(152) , Nac , Nadens , Naform , Nanzwd , Nar , Natype , Nbc , Nbdens , Nbform , Nbnzwd , Nbr ,      &
         & Nbtype , Ncc , Ncdens , Ncform , Ncnzwd , Ncr , Nctype , Ndc , Nddens , Ndform , Ndnzwd , Ndr , Ndtype , Nwords(4) , Nz ,&
         & Rd , Rdrew , Signab , Signc , T , Typei , Typep , Typeu , Wrt , Wrtrew
   REAL Prec1 , Scrtch , Sysbuf , Time
   COMMON /mpyadx/ Filea , Fileb , Filec , Filed , Nz , T , Signab , Signc , Prec1 , Scrtch , Time
   COMMON /names / Rd , Rdrew , Wrt , Wrtrew , Clsrew , Cls
   COMMON /packx / Typei , Typep , Iprow1 , Iprown , Incrp
   COMMON /system/ Ksystm
   COMMON /type  / Iprc , Nwords , Irc
   COMMON /unpakx/ Typeu , Iurow1 , Iurown , Incru
!
! Dummy argument declarations
!
   DOUBLE PRECISION Zd(2)
   DOUBLE COMPLEX Zdc(2)
   INTEGER Zi(2)
!
! Local variable declarations
!
   INTEGER i , ibrow2 , icola , idxx , ii , indxa , indxal , indxav , indxb , irow1 , irowa1 , irowan , irowb1 , irowbn , irown ,   &
         & j , k , kcnt , ntms
!
! End of declarations
!
!
!     MMA304 PERFORMS THE MATRIX OPERATION USING METHOD 30 AND
!       COMPLEX DOUBLE PRECISION
!
!       (+/-)A(T & NT) * B (+/-)C = D
!
!     MMA304 USES METHOD 30 WHICH IS AS FOLLOWS:
!       1.  THIS IS FOR "A" NON-TRANSPOSED AND TRANSPOSED
!       2.  CALL 'MMARM1' TO PACK AS MANY COLUMNS OF "A" INTO MEMORY
!           AS POSSIBLE LEAVING SPACE FOR ONE COLUMN OF "B" AND "D".
!       3.  INITIALIZE EACH COLUMN OF "D" WITH THE DATA FROM "C".
!       4.  USE UNPACK TO READ MATRICES "B" AND "C".
!
   EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(2),Iwr)
   EQUIVALENCE (Filea(2),Nac) , (Filea(3),Nar) , (Filea(4),Naform) , (Filea(5),Natype) , (Filea(6),Nanzwd) , (Filea(7),Nadens)
   EQUIVALENCE (Fileb(2),Nbc) , (Fileb(3),Nbr) , (Fileb(4),Nbform) , (Fileb(5),Nbtype) , (Fileb(6),Nbnzwd) , (Fileb(7),Nbdens)
   EQUIVALENCE (Filec(2),Ncc) , (Filec(3),Ncr) , (Filec(4),Ncform) , (Filec(5),Nctype) , (Filec(6),Ncnzwd) , (Filec(7),Ncdens)
   EQUIVALENCE (Filed(2),Ndc) , (Filed(3),Ndr) , (Filed(4),Ndform) , (Filed(5),Ndtype) , (Filed(6),Ndnzwd) , (Filed(7),Nddens)
!
!
!   OPEN CORE ALLOCATION AS FOLLOWS:
!     Z( 1        ) = ARRAY FOR ONE COLUMN OF "B" MATRIX
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
! PROCESS ALL OF THE COLUMNS OF "B";  ADD "C" DATA ON FIRST PASS
   DO ii = 1 , Nbc
      Iurow1 = -1
      Typeu = Ndtype
      CALL unpack(*50,Fileb,Zdc(1))
      irowb1 = Iurow1
      irowbn = Iurown
      GOTO 100
 50   irowb1 = 0
      irowbn = 0
 100  IF ( Ifile/=0 ) THEN
         Iurow1 = 1
         Iurown = Ndr
         Typeu = Ndtype
         IF ( Ipass==1 ) Typeu = Ndtype*Signc
         CALL unpack(*150,Ifile,Zdc(Idx4+1))
         GOTO 200
      ENDIF
 150  DO j = 1 , Ndr
         Zdc(Idx4+j) = (0.0,0.0)
      ENDDO
!
! CHECK IF COLUMN OF "B" IS NULL
!
 200  indxa = Iax
      IF ( irowb1/=0 ) THEN
         IF ( T/=0 ) THEN
!
!  TRANSPOSE CASE ( A(T) * B + C )
!
! COMPLEX DOUBLE PRECISION
            indxb = 1 - irowb1
            idxx = Idx4 + Ibrow
            DO i = 1 , Ncolpp
               icola = Ibrow + i
               IF ( icola/=iabs(Zi(indxa)) ) GOTO 300
               indxal = Zi(indxa+1) + Iax - 1
               indxa = indxa + 2
               DO WHILE ( indxa<indxal )
                  irowa1 = Zi(indxa)
                  ntms = Zi(indxa+1)
                  irowan = irowa1 + ntms - 1
                  irow1 = max0(irowa1,irowb1)
                  irown = min0(irowan,irowbn)
                  IF ( irown>=irow1 ) THEN
                     indxav = ((indxa+3)/2) + 2*(irow1-irowa1) - 1
                     indxb = 2*(irow1-irowb1)
!
!         D = C + A*B
!
                     kcnt = (irown-irow1)*2 + 1
                     DO k = 1 , kcnt , 2
                        Zdc(idxx+i) = Zdc(idxx+i) + dcmplx(Zd(indxav+k),Zd(indxav+k+1))*dcmplx(Zd(indxb+k),Zd(indxb+k+1))
                     ENDDO
                  ENDIF
                  indxa = indxa + 2 + ntms*4
               ENDDO
               indxa = indxal
            ENDDO
         ELSE
!
! "A" NON-TRANSPOSE CASE    ( A * B  +  C )
!
! COMPLEX DOUBLE PRECISION
            DO i = 1 , Ncolpp
               indxal = Zi(indxa+1) + Iax - 1
               icola = Ibrow + i
               IF ( icola>=irowb1 .AND. icola<=irowbn ) THEN
                  ibrow2 = 2*(Ibrow+i-irowb1) + 1
                  IF ( Zd(ibrow2)/=0.D0 .OR. Zd(ibrow2+1)/=0.D0 ) THEN
                     IF ( icola/=iabs(Zi(indxa)) ) GOTO 300
                     indxa = indxa + 2
                     DO WHILE ( indxa<indxal )
                        irowa1 = Zi(indxa)
                        ntms = Zi(indxa+1)
                        irowan = irowa1 + ntms - 1
                        indxav = ((indxa+3)/2) - 2
                        DO k = irowa1 , irowan
!
!         D = C + A*B
!
                           indxav = indxav + 2
                           Zdc(Idx4+k) = Zdc(Idx4+k) + dcmplx(Zd(indxav),Zd(indxav+1))*dcmplx(Zd(ibrow2),Zd(ibrow2+1))
                        ENDDO
                        indxa = indxa + 2 + ntms*4
                     ENDDO
                  ENDIF
               ENDIF
               indxa = indxal
            ENDDO
         ENDIF
      ENDIF
! END OF PROCESSING THIS COLUMN FOR THIS PASS
!  NOW SAVE COLUMN
      CALL pack(Zdc(Idx4+1),Ofile,Filed)
   ENDDO
   GOTO 99999
 300  WRITE (Iwr,99001) icola , Zi(indxa) , Iax , indxa
99001 FORMAT (' UNEXPECTED COLUMN FOUND IN PROCESSING MATRIX A',/,' COLUMN EXPECTED:',I6,/,' COLUMN FOUND   :',I6,/,' IAX =',I7,    &
             &'  INDXA=',I7)
   CALL mesage(-61,0,0)
99999 END SUBROUTINE mma304