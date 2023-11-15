
 
SUBROUTINE mma404(Zi,Zd,Zdc)
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
   INTEGER i , icolb , ii , indx , indxa , indxb , indxbl , indxbv , indxdv , irow1 , irowa1 , irowan , irowb1 , irowbn , irown ,   &
         & irows , k
!
! End of declarations
!
!
!     MMA404 PERFORMS THE MATRIX OPERATION USING METHOD 40
!       IN COMPLEX DOUBLE PRECISION
!       (+/-)A(T & NT) * B (+/-)C = D
!
!     MMA404 USES METHOD 40 WHICH IS AS FOLLOWS:
!       1.  THIS IS FOR "A" NON-TRANSPOSED AND TRANSPOSED
!       2.  READ AS MANY COLUMNS OF "B" INTO MEMORY AS POSSIBLE
!           INTO MEMORY IN COMPACT FORM LEAVING SPACE FOR A FULL
!           COLUMN OF "D" FOR EVERY COLUMN "B" READ.  SEE SUBROUTINES
!           MMARM1,2,3,4 FOR FORMAT OF COMPACT FORM.
!       3.  INITIALIZE EACH COLUMN OF "D" WITH THE DATA FROM "C".
!       4.  CALL UNPACK TO READ MATRICES "A" AND "C".
!
   EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(2),Iwr)
   EQUIVALENCE (Filea(2),Nac) , (Filea(3),Nar) , (Filea(4),Naform) , (Filea(5),Natype) , (Filea(6),Nanzwd) , (Filea(7),Nadens)
   EQUIVALENCE (Fileb(2),Nbc) , (Fileb(3),Nbr) , (Fileb(4),Nbform) , (Fileb(5),Nbtype) , (Fileb(6),Nbnzwd) , (Fileb(7),Nbdens)
   EQUIVALENCE (Filec(2),Ncc) , (Filec(3),Ncr) , (Filec(4),Ncform) , (Filec(5),Nctype) , (Filec(6),Ncnzwd) , (Filec(7),Ncdens)
   EQUIVALENCE (Filed(2),Ndc) , (Filed(3),Ndr) , (Filed(4),Ndform) , (Filed(5),Ndtype) , (Filed(6),Ndnzwd) , (Filed(7),Nddens)
!
!
!   OPEN CORE ALLOCATION AS FOLLOWS:
!     Z( 1        ) = ARRAY FOR ONE COLUMN OF "A" MATRIX
!     Z( IBX      ) = ARRAY FOR MULTIPLE COLUMNS OF "B" MATRIX
!                     (STORED IN COMPACT FORM)
!     Z( IDX      ) = ARRAY FOR MULTIPLE COLUMNS OF "D" MATRIX
!                     (FULL COLUMN SPACE ALLOCATION)
!        THROUGH
!     Z( LASMEM   )
!     Z( IBUF4    ) = BUFFER FOR "D" FILE
!     Z( IBUF3    ) = BUFFER FOR "C" FILE
!     Z( IBUF2    ) = BUFFER FOR "B" FILE
!     Z( IBUF1    ) = BUFFER FOR "A" FILE
!     Z( NZ       ) = END OF OPEN CORE THAT IS AVAILABLE
!
!
! PROCESS ALL OF THE COLUMNS OF "A"
!
   DO ii = 1 , Nac
!      print *,' processing column of a, ii=',ii
      Iurow1 = -1
      Typeu = Ndtype
      CALL unpack(*100,Filea,Zdc(1))
      irowa1 = Iurow1
      irowan = Iurown
      indxa = 1 - irowa1
      IF ( T/=0 ) THEN
!
!  TRANSPOSE CASE ( A(T) * B + C )
!
! DOUBLE PRECISION
         indxb = Ibx
         DO i = 1 , Ncolpp
            icolb = Ibrow + i
            IF ( icolb/=iabs(Zi(indxb)) ) GOTO 200
            indxbl = Zi(indxb+1) + Ibx - 1
            indxb = indxb + 2
            indxdv = Idx4 + (i-1)*Ndr + ii
            DO WHILE ( indxb<indxbl )
               irowb1 = Zi(indxb)
               irows = Zi(indxb+1)
               irowbn = irowb1 + irows - 1
               irow1 = max0(irowa1,irowb1)
               irown = min0(irowan,irowbn)
               IF ( irown>=irow1 ) THEN
                  indxbv = ((indxb+3)/2) + 2*(irow1-irowb1)
                  DO k = irow1 , irown
                     Zdc(indxdv) = Zdc(indxdv) + Zdc(indxa+k)*dcmplx(Zd(indxbv),Zd(indxbv+1))
                     indxbv = indxbv + 2
                  ENDDO
               ENDIF
               indxb = indxb + 2 + irows*Nwdd
            ENDDO
            indxb = indxbl
         ENDDO
      ELSE
!
! "A" NON-TRANSPOSE CASE    ( A*B + C )
!
! DOUBLE PRECISION
!
         indxb = Ibx
         DO i = 1 , Ncolpp
            icolb = Ibrow + i
            IF ( icolb/=iabs(Zi(indxb)) ) GOTO 200
            indxbl = Zi(indxb+1) + Ibx - 1
            indxb = indxb + 2
            indxdv = Idx4 + (i-1)*Ndr
            DO WHILE ( indxb<indxbl )
               irowb1 = Zi(indxb)
               irows = Zi(indxb+1)
               irowbn = irowb1 + irows - 1
               IF ( ii>irowbn ) THEN
                  indxb = indxb + 2 + irows*Nwdd
               ELSE
                  IF ( ii>=irowb1 ) THEN
                     indxbv = ((indxb+3)/2) + 2*(ii-irowb1)
                     IF ( Zd(indxbv)/=0.0D0 .OR. Zd(indxbv+1)/=0.0D0 ) THEN
                        DO k = irowa1 , irowan
                           Zdc(indxdv+k) = Zdc(indxdv+k) + Zdc(indxa+k)*dcmplx(Zd(indxbv),Zd(indxbv+1))
                        ENDDO
                     ENDIF
                  ENDIF
                  EXIT
               ENDIF
            ENDDO
            indxb = indxbl
         ENDDO
      ENDIF
! END OF PROCESSING THIS COLUMN OF "A" FOR THIS PASS
 100  ENDDO
!  NOW SAVE COLUMNS COMPLETED
   DO k = 1 , Ncolpp
      indx = Idx4 + (k-1)*Ndr + 1
      CALL pack(Zdc(indx),Filed,Filed)
   ENDDO
   GOTO 99999
 200  WRITE (Iwr,99001) icolb , Zi(indxb) , Ibx , indxb
99001 FORMAT (' UNEXPECTED COLUMN FOUND IN PROCESSING MATRIX B',/,' COLUMN EXPECTED:',I6,/,' COLUMN FOUND   :',I6,/,' IBX =',I7,    &
             &'  INDXB =',I7)
   CALL mesage(-61,0,0)
99999 END SUBROUTINE mma404
