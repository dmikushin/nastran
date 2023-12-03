!*==mma324.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE mma324(Zi,Zd)
   USE i_mmacom
   USE c_mpyadx
   USE c_names
   USE c_packx
   USE c_system
   USE c_type
   USE c_unpakx
   USE c_zblpkx
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER , DIMENSION(2) :: Zi
   REAL*8 , DIMENSION(2) :: Zd
!
! Local variable declarations rewritten by SPAG
!
   COMPLEX*16 :: cd , cdtemp
   INTEGER :: i , icola , icrows , idrow , ii , indxa , indxal , indxav , indxb , indxbs , indxbv , indxc , indxcv , irow1 ,        &
            & irowa1 , irowan , irowb1 , irowbn , irowc1 , irowcn , irown , irows , iwr , k , kcnt , lasindb , lasindc , nac ,      &
            & nadens , naform , nanzwd , nar , natype , nbc , nbdens , nbform , nbnzwd , nbr , nbtype , ncc , ncdens , ncform ,     &
            & ncnzwd , ncr , nctype , ndc , nddens , ndform , ndnzwd , ndr , ndtype , nrows , ntms
   REAL :: sysbuf
!
! End of declarations rewritten by SPAG
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
   !>>>>EQUIVALENCE (D(1),Cd)
   !>>>>EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(2),Iwr)
   !>>>>EQUIVALENCE (Filea(2),Nac) , (Filea(3),Nar) , (Filea(4),Naform) , (Filea(5),Natype) , (Filea(6),Nanzwd) , (Filea(7),Nadens)
   !>>>>EQUIVALENCE (Fileb(2),Nbc) , (Fileb(3),Nbr) , (Fileb(4),Nbform) , (Fileb(5),Nbtype) , (Fileb(6),Nbnzwd) , (Fileb(7),Nbdens)
   !>>>>EQUIVALENCE (Filec(2),Ncc) , (Filec(3),Ncr) , (Filec(4),Ncform) , (Filec(5),Nctype) , (Filec(6),Ncnzwd) , (Filec(7),Ncdens)
   !>>>>EQUIVALENCE (Filed(2),Ndc) , (Filed(3),Ndr) , (Filed(4),Ndform) , (Filed(5),Ndtype) , (Filed(6),Ndnzwd) , (Filed(7),Nddens)
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
   filed(2) = 0
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
   INTEGER :: spag_nextblock_3
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
         filed(6) = 0
         filed(7) = 0
         idrow = ibrow
         DO ii = 1 , nbc
            spag_nextblock_2 = 1
            SPAG_DispatchLoop_2: DO
               SELECT CASE (spag_nextblock_2)
               CASE (1)
                  CALL bldpk(ndtype,ndtype,ofile,0,0)
!      PRINT *,' PROCESSING B MATRIX COLUMN, II=',II
!
! READ A COLUMN FROM THE "B" MATRIX
!
                  sign = 1
                  irfile = fileb(1)
                  CALL mmarc4(Zi,Zd)
                  lasindb = lasind
!
! NOW READ "C", OR SCRATCH FILE WITH INTERMEDIATE RESULTS.
! IF NO "C" FILE AND THIS IS THE FIRST PASS, INITIALIZE "D" COLUMN TO ZERO.
!
                  IF ( ifile/=0 ) THEN
                     IF ( ipass==1 ) sign = signc
                     irfile = ifile
!
! READ A COLUMN FROM THE "C" MATRIX
!
                     CALL mmarc4(Zi(idx),Zd(idx2+1))
                     lasindc = lasind + idx - 1
                  ENDIF
!
! CHECK IF COLUMN OF "B" IS NULL
!
                  IF ( Zi(1)/=0 ) THEN
                     irowb1 = Zi(1)
                     irows = Zi(2)
                     irowbn = irowb1 + irows - 1
                     indxb = 1
                     indxa = iax
                     indxc = idx
                     IF ( ifile/=0 .AND. indxc<lasindc ) THEN
                        irowc1 = Zi(indxc)
                        icrows = Zi(indxc+1)
                        irowcn = irowc1 + icrows - 1
!
! CHECK TO ADD TERMS FROM "C" OR INTERIM SCRATCH FILE BEFORE CURRENT ROW
!
                        IF ( idrow/=0 .AND. irowc1<=idrow ) THEN
                           SPAG_Loop_2_1: DO
                              irown = idrow
                              IF ( irowcn<idrow ) irown = irowcn
                              indxcv = (indxc+3)/2
                              nrows = irown - irowc1 + 1
                              DO i = 1 , nrows
                                 kdrow = irowc1 + i - 1
                                 cd = dcmplx(Zd(indxcv),Zd(indxcv+1))
                                 indxcv = indxcv + 2
                                 CALL zblpki
                              ENDDO
                              IF ( irowcn>=idrow ) EXIT SPAG_Loop_2_1
                              indxc = indxc + 2 + icrows*nwdd
                              IF ( indxc>=lasindc ) EXIT SPAG_Loop_2_1
                              irowc1 = Zi(indxc)
                              icrows = Zi(indxc+1)
                              irowcn = irowc1 + icrows - 1
                           ENDDO SPAG_Loop_2_1
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
                        DO i = 1 , ncolpp
                           spag_nextblock_3 = 1
                           SPAG_DispatchLoop_3: DO
                              SELECT CASE (spag_nextblock_3)
                              CASE (1)
                                 cd = (0.0D0,0.0D0)
                                 kdrow = idrow + i
                                 icola = ibrow + i
                                 IF ( icola/=iabs(Zi(indxa)) ) THEN
                                    spag_nextblock_1 = 2
                                    CYCLE SPAG_DispatchLoop_1
                                 ENDIF
                                 indxal = Zi(indxa+1) + iax - 1
                                 indxa = indxa + 2
                                 indxb = 1
                                 SPAG_Loop_3_2: DO WHILE ( indxb<lasindb )
                                    irowb1 = Zi(indxb)
                                    irows = Zi(indxb+1)
                                    irowbn = irowb1 + irows - 1
                                    indxbs = indxb
                                    indxb = indxb + 2 + irows*nwdd
                                    DO WHILE ( indxa<indxal )
                                       irowa1 = Zi(indxa)
                                       ntms = Zi(indxa+1)
                                       irowan = irowa1 + ntms - 1
                                       IF ( irowbn<irowa1 ) CYCLE SPAG_Loop_3_2
                                       IF ( irowan<irowb1 ) THEN
                                         indxa = indxa + 2 + ntms*nwdd
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
                                         cd = cd + cdtemp
                                         IF ( irowan>irowbn ) CYCLE SPAG_Loop_3_2
                                         indxa = indxa + 2 + ntms*nwdd
                                       ENDIF
                                    ENDDO
                                    indxa = indxal
                                    spag_nextblock_3 = 2
                                    CYCLE SPAG_DispatchLoop_3
                                 ENDDO SPAG_Loop_3_2
                                 indxa = indxal
                                 spag_nextblock_3 = 2
                              CASE (2)
                                 SPAG_Loop_3_3: DO WHILE ( indxc<lasindc .AND. ifile/=0 )
                                    IF ( kdrow<irowc1 ) EXIT SPAG_Loop_3_3
                                    IF ( kdrow>irowcn ) THEN
                                       indxc = indxc + 2 + icrows*nwdd
                                       IF ( indxc>=lasindc ) EXIT SPAG_Loop_3_3
                                       irowc1 = Zi(indxc)
                                       icrows = Zi(indxc+1)
                                       irowcn = irowc1 + icrows - 1
                                    ELSE
                                       indxcv = (indxc+3)/2 + 2*(kdrow-irowc1)
                                       cd = cd + dcmplx(Zd(indxcv),Zd(indxcv+1))
                                       EXIT SPAG_Loop_3_3
                                    ENDIF
                                 ENDDO SPAG_Loop_3_3
                                 CALL zblpki
                                 EXIT SPAG_DispatchLoop_3
                              END SELECT
                           ENDDO SPAG_DispatchLoop_3
                        ENDDO
                     ENDIF
                     IF ( kdrow/=ndr .AND. ifile/=0 .AND. indxc<lasindc ) THEN
!
! ADD REMAINING TERMS FROM EITHER THE "C" MATRIX OR INTERIM SCRATCH MATRIX
!
                        irow1 = kdrow + 1
                        SPAG_Loop_2_4: DO
                           indxcv = (indxc+3)/2
                           IF ( irow1<irowc1 ) EXIT SPAG_Loop_2_4
                           IF ( irow1<=irowcn ) THEN
                              indxcv = (indxc+3)/2 + 2*(irow1-irowc1)
                              irowc1 = irow1
                              EXIT SPAG_Loop_2_4
                           ELSE
                              indxc = indxc + 2 + icrows*nwdd
                              IF ( indxc>=lasindc ) THEN
                                 spag_nextblock_2 = 2
                                 CYCLE SPAG_DispatchLoop_2
                              ENDIF
                              irowc1 = Zi(indxc)
                              icrows = Zi(indxc+1)
                              irowcn = irowc1 + icrows - 1
                           ENDIF
                        ENDDO SPAG_Loop_2_4
                        SPAG_Loop_2_5: DO
                           nrows = irowcn - irowc1 + 1
                           DO k = 1 , nrows
                              kdrow = irowc1 + k - 1
                              cd = dcmplx(Zd(indxcv),Zd(indxcv+1))
                              indxcv = indxcv + 2
                              CALL zblpki
                           ENDDO
                           indxc = indxc + 2 + icrows*nwdd
                           IF ( indxc>=lasindc ) EXIT SPAG_Loop_2_5
                           irowc1 = Zi(indxc)
                           icrows = Zi(indxc+1)
                           irowcn = irowc1 + icrows - 1
                           indxcv = (indxc+3)/2
                        ENDDO SPAG_Loop_2_5
                     ENDIF
                  ELSE
                     IF ( ifile/=0 ) THEN
                        IF ( Zi(idx)/=0 ) THEN
                           indxc = idx
                           DO WHILE ( indxc<lasindc )
                              irowc1 = Zi(indxc)
                              icrows = Zi(indxc+1)
                              irowcn = irowc1 + icrows - 1
                              indxcv = (indxc+3)/2
                              DO i = irowc1 , irowcn
                                 cd = dcmplx(Zd(indxcv),Zd(indxcv+1))
                                 kdrow = i
                                 CALL zblpki
                                 indxcv = indxcv + 2
                              ENDDO
                              indxc = indxc + 2 + icrows*nwdd
                           ENDDO
                           spag_nextblock_2 = 2
                           CYCLE SPAG_DispatchLoop_2
                        ENDIF
                     ENDIF
                     cd = (0.0D0,0.0D0)
                     kdrow = 1
                     CALL zblpki
                  ENDIF
                  spag_nextblock_2 = 2
               CASE (2)
                  CALL bldpkn(ofile,0,filed)
                  EXIT SPAG_DispatchLoop_2
               END SELECT
            ENDDO SPAG_DispatchLoop_2
! END OF PROCESSING THIS COLUMN FOR THIS PASS
         ENDDO
         RETURN
      CASE (2)
         WRITE (iwr,99001) icola , Zi(indxa) , iax , indxa
99001    FORMAT (' UNEXPECTED COLUMN FOUND IN PROCESSING MATRIX A',/,' COLUMN EXPECTED:',I6,/,' COLUND FOUND   :',I6,/,' IAX =',I7, &
                &' INDXA=',I7)
         CALL mesage(-61,0,0)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE mma324