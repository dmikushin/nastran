!*==combin.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE combin(Pg,Ilist,Nlist)
   USE c_blank
   USE c_loads
   USE c_loadx
   USE c_packx
   USE c_system
   USE c_xmssg
   USE c_zntpkx
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Pg
   INTEGER , DIMENSION(1) :: Ilist
   INTEGER :: Nlist
!
! Local variable declarations rewritten by SPAG
!
   REAL , DIMENSION(360) :: alpha , alpha1
   REAL , DIMENSION(1) :: ary
   INTEGER , SAVE :: hccen , hccens , hcfld , hcflds , remfl , remfls
   REAL , DIMENSION(2) :: head
   INTEGER :: i , ibuf1 , inull , ip1 , j , k , kk , kl , lcore , nhc , nl1 , nlj , nperms , ns
   INTEGER , DIMENSION(1) :: iary
   INTEGER , DIMENSION(360) :: loadn , loadnn
   INTEGER , DIMENSION(7) :: lodc1 , mcb
   INTEGER , DIMENSION(2) , SAVE :: name
   EXTERNAL close , fname , intpk , makmcb , mesage , open , pack , rdtrl , rewind , skprec , write , wrttrl , zntpki
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
   INTEGER :: spag_nextblock_3
   INTEGER :: spag_nextblock_4
!
   !>>>>EQUIVALENCE (Core(1),Iary(1),Ary(1))
!
!     ALSO COMBINE HCFLD AND REMFL IN MAGNETOSTATIC PROBLEMS
!
   DATA hcflds , hcfld/304 , 202/
   DATA remfls , remfl/305 , 203/
   DATA hccens , hccen/307 , 204/
   DATA name/4HCOMB , 4HIN  /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!
         ita = 1
         itb = iprec
         ii = 1
!
!     PERFORM CHECKS IN E AND M PROBLEM
!     IN E AND M PROBLEM, REMFLS AND HCFLDS MUST HAVE THE SAME NUMBER
!     OF COLUMNS AS PG
!
         mcb(1) = remfls
         CALL rdtrl(mcb)
         nperms = 0
         IF ( mcb(1)>0 ) nperms = mcb(2)
         mcb(1) = hcflds
         CALL rdtrl(mcb)
         nhc = 0
         IF ( mcb(1)>0 ) nhc = mcb(2)
         IF ( nhc/=nperms ) THEN
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( nhc/=0 ) THEN
            mcb(1) = Pg
            CALL rdtrl(mcb)
            IF ( nhc/=mcb(2) ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         DO
            mcb(1) = hccens
            CALL rdtrl(mcb)
            ns = 0
            IF ( mcb(1)>0 ) ns = mcb(2)
            IF ( ns/=nhc ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            jj = nrowsp
            incur = 1
            lcore = lc
            ibuf1 = lcore
            lcore = lcore - sysbuf
            CALL open(*40,lodc,core(lcore+1),1)
            CALL fname(lodc,head)
            CALL write(lodc,head,2,1)
            lcore = lcore - sysbuf
            CALL open(*20,Pg,core(lcore+1),0)
            CALL makmcb(lodc1,lodc,nrowsp,2,iprec)
            nlj = iptr
            nl1 = 0
            DO i = 1 , nload
               spag_nextblock_2 = 1
               SPAG_DispatchLoop_2: DO
                  SELECT CASE (spag_nextblock_2)
                  CASE (1)
                     DO j = 1 , nrowsp
                        core(j) = 0.0
                     ENDDO
                     nlj = nlj + nl1*2 + 1
                     nl1 = iary(nlj)
                     DO k = 1 , nl1
                        kk = nlj + (k-1)*2 + 1
                        loadn(k) = iary(kk)
                        IF ( loadn(k)<0 ) THEN
                           spag_nextblock_2 = 2
                           CYCLE SPAG_DispatchLoop_2
                        ENDIF
                        alpha(k) = ary(kk+1)
                     ENDDO
                     kk = 1
                     kl = 0
                     DO k = 1 , Nlist
                        spag_nextblock_3 = 1
                        SPAG_DispatchLoop_3: DO
                           SELECT CASE (spag_nextblock_3)
                           CASE (1)
                              IF ( Ilist(k)/=0 ) THEN
                                 kl = kl + 1
                                 SPAG_Loop_7_1: DO j = 1 , nl1
                                    IF ( loadn(j)==Ilist(k) ) THEN
                                       spag_nextblock_3 = 2
                                       EXIT SPAG_Loop_7_1
                                    ENDIF
                                 ENDDO SPAG_Loop_7_1
                              ENDIF
                           CASE (2)
                              loadnn(kk) = kl
                              alpha1(kk) = alpha(j)
                              kk = kk + 1
                              EXIT SPAG_DispatchLoop_3
                           END SELECT
                        ENDDO SPAG_DispatchLoop_3
                     ENDDO
                     kk = 1
                     DO j = 1 , nl1
                        spag_nextblock_4 = 1
                        SPAG_DispatchLoop_4: DO
                           SELECT CASE (spag_nextblock_4)
                           CASE (1)
                              inull = 0
                              IF ( j==1 ) CALL skprec(Pg,1)
                              CALL intpk(*2,Pg,0,1,0)
                              spag_nextblock_4 = 2
                           CASE (2)
                              DO WHILE ( loadnn(j)/=kk )
                                 IF ( inull/=1 ) THEN
                                    IF ( ieor==0 ) CALL skprec(Pg,1)
                                 ENDIF
                                 kk = kk + 1
                                 inull = 0
                                 CALL intpk(*2,Pg,0,1,0)
                              ENDDO
                              SPAG_Loop_4_1: DO WHILE ( inull/=1 )
                                 IF ( ieol/=0 ) EXIT SPAG_Loop_4_1
                                 CALL zntpki
                                 core(ll) = core(ll) + a(1)*alpha1(j)
                              ENDDO SPAG_Loop_4_1
                              kk = kk + 1
                              CYCLE
 2                            inull = 1
                              spag_nextblock_4 = 2
                           END SELECT
                        ENDDO SPAG_DispatchLoop_4
                     ENDDO
                     spag_nextblock_2 = 2
                  CASE (2)
                     CALL pack(core,lodc1(1),lodc1)
                     CALL rewind(Pg)
                     EXIT SPAG_DispatchLoop_2
                  END SELECT
               ENDDO SPAG_DispatchLoop_2
            ENDDO
            CALL wrttrl(lodc1(1))
            CALL close(lodc1(1),1)
            CALL close(Pg,1)
            IF ( Pg==hcflds ) THEN
!
!     DO REMFLS
!
               lodc1(1) = remfls
               CALL rdtrl(lodc1)
               IF ( lodc1(2)<=0 ) RETURN
               Pg = remfls
               lodc = remfl
               nrowsp = lodc1(3)
            ELSEIF ( Pg==remfls ) THEN
!
!     HCCENS
!
               lodc1(1) = hccens
               CALL rdtrl(lodc1)
               IF ( lodc1(2)<=0 ) RETURN
               Pg = hccens
               lodc = hccen
               nrowsp = lodc1(3)
            ELSE
               IF ( Pg==hccens ) RETURN
!
!     DO MAGNETOSTATIC FIELDS FOR USE IN EMFLD
!
               lodc1(1) = hcflds
               CALL rdtrl(lodc1)
!
!     IF HCFLD IS PURGED, SO MUST REMFLS
!
               IF ( lodc1(2)<=0 ) RETURN
               Pg = hcflds
               lodc = hcfld
               nrowsp = 3*nrowsp
            ENDIF
         ENDDO
 20      ip1 = Pg
         spag_nextblock_1 = 2
      CASE (2)
         CALL mesage(-1,ip1,name)
 40      IF ( lodc==hcfld ) RETURN
         ip1 = lodc
         spag_nextblock_1 = 2
      CASE (3)
         WRITE (otpe,99001) ufm
99001    FORMAT (A23,', IN AN E AND M PROBLEM, SCRATCH DATA BLOCKS HCFLDS',' AND REMFLS HAVE DIFFERENT NUMBERS OF COLUMNS.',/10X,   &
                &' THIS MAY RESULT FROM SPCFLD AND REMFLU CARDS HAVING THE',' SAME LOAD SET ID')
         CALL mesage(-61,0,0)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE combin