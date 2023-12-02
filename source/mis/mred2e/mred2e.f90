!*==mred2e.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE mred2e
   USE c_bitpos
   USE c_blank
   USE c_mpyadx
   USE c_packx
   USE c_parmeg
   USE c_patx
   USE c_system
   USE c_unpakx
   USE c_xmssg
   USE c_zzzzzz
   USE iso_fortran_env
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: dblkor , dicore , gib , him , himprt , himscr , himtyp , i , icore , ifile , iform , ihim , ii , imsg , ipartn ,      &
            & iprc , iter , itest , itphis , ityp , itype , j , jhim , k , kore , l , lamamr , lamlen , modal , modext , ncore ,    &
            & nnmax , nrows , nwds , phiam , phibm , phiim , phiss , pprtn , sglkor , usetmr
   REAL(REAL64) :: dhimag , dhimsm
   REAL(REAL64) , DIMENSION(1) :: dz
   REAL , SAVE :: epslon
   INTEGER , SAVE :: fbmods , iscr4 , item
   REAL :: himmag , himsum , phimsm , pmsm
   INTEGER , DIMENSION(7) :: itrlr
   INTEGER , DIMENSION(2) , SAVE :: modnam
   REAL , DIMENSION(1) :: rz
   EXTERNAL calcv , close , fwdrec , gmprtn , gopen , makmcb , mesage , mpyad , mtrxi , pack , rdtrl , read , smsg , smsg1 ,        &
          & sofcls , sofopn , softrl , unpack , wrttrl
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
!
!     THIS SUBROUTINE CALCULATES THE MODAL TRANSFORMATION MATRIX FOR THE
!     MRED2 MODULE.
!
!     INPUT DATA
!     GINO   - LAMAMR - EIGENVALUE TABLE FOR SUBSTRUCTURE BEING REDUCED
!              PHISS  - EIGENVECTOR MATRIX FOR SUBSTRUCTURE BEING REDUCE
!     SOF    - GIMS   - G TRANSFORMATION MATRIX FOR ORIGINAL SUBSTRUCTUR
!
!     OUTPUT DATA
!     GINO   - HIM    - HIM MATRIX PARTITION
!
!     PARAMETERS
!     INPUT  - GBUF   - GINO BUFFERS
!              INFILE - INPUT FILE NUMBERS
!              OTFILE - OUTPUT FILE NUMBERS
!              ISCR   - SCRATCH FILE NUMBERS
!              KORLEN - LENGTH OF OPEN CORE
!              KORBGN - BEGINNING ADDRESS OF OPEN CORE
!              OLDNAM - NAME OF SUBSTRUCTURE BEING REDUCED
!              NMAX   - MAXIMUM NUMBER OF FREQUENCIES TO BE USED
!     OUTPUT - MODUSE - BEGINNING ADDRESS OF MODE USE DESCRIPTION ARRAY
!              MODLEN - LENGTH OF MODE USE ARRAY
!              NFOUND - NUMBER OF MODAL POINTS FOUND
!     OTHERS - HIMPRT - HIM PARTITION VECTOR
!              PPRTN  - PHISS MATRIX PARTITION VECTOR
!              PHIAM  - PHIAM MATRIX PARTITION
!              PHIBM  - PHIBM MATRIX PARTITION
!              PHIIM  - PHIIM MATRIX PARTITION
!              IPARTN - BEGINNING ADDRESS OF PHISS PARTITION VECTOR
!              LAMAMR - LAMAMR INPUT FILE NUMBER
!              PHISS  - PHISS INPUT FILE NUMBER
!              PPRTN  - PARTITION VECTOR FILE NUMBER
!              HIMPRT - HIM PARTITION VECTOR FILE NUMBER
!              GIB    - GIB INPUT FILE NUMBER
!              PHIAM  - PHIAM PARTITION MATRIX FILE NUMBER
!              PHIBM  - PHIBM PARTITION MATRIX FILE NUMBER
!              PHIIM  - PHIIM PARTITION MATRIX FILE NUMBER
!              HIM    - HIM INPUT FILE NUMBER
!              HIMSCR - HIM SCRATCH INPUT FILE NUMBER
!
   !>>>>EQUIVALENCE (Lamamr,Infile(2)) , (Phiss,Infile(3)) , (Usetmr,Infile(5))
   !>>>>EQUIVALENCE (Gib,Iscr(8)) , (Pprtn,Iscr(5)) , (Him,Iscr(8)) , (Himprt,Iscr(9)) , (Phibm,Iscr(9))
   !>>>>EQUIVALENCE (Rz(1),Z(1)) , (Dz(1),Z(1))
   DATA modnam/4HMRED , 4H2E  /
   DATA epslon , iscr4 , fbmods/1.0E-03 , 304 , 6/
   DATA item/4HGIMS/
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     READ LAMAMR FILE
!
         IF ( dry==-2 ) RETURN
         kore = korbgn
         ifile = lamamr
         CALL gopen(lamamr,z(gbuf1),0)
         CALL fwdrec(*80,lamamr)
         iter = 0
         DO
            CALL read(*60,*20,lamamr,z(korbgn),7,0,nwds)
!
!     REJECT MODES WITH NO ASSOCIATED VECTORS
!
            IF ( rz(korbgn+5)>0.0 ) THEN
               korbgn = korbgn + 7
               IF ( korbgn>=korlen ) THEN
                  spag_nextblock_1 = 2
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               iter = iter + 1
            ENDIF
         ENDDO
 20      CALL close(lamamr,1)
!
!     ZERO OUT PARTITIONING VECTOR AND SET UP MODE USE DESCRIPTION
!     RECORD
!
         modext = korbgn
         itrlr(1) = phiss
         CALL rdtrl(itrlr)
         itphis = itrlr(2)
         nrows = itrlr(3)
         IF ( (3*itphis)+modext>=korlen ) THEN
            spag_nextblock_1 = 2
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         lamlen = 7*itphis
         nnmax = min0(nmax,itphis)
         moduse = modext + itphis
         ipartn = modext + 2*itphis
         modlen = itphis
         DO i = 1 , itphis
            z(modext+i-1) = 0
            z(moduse+i-1) = 3
            rz(ipartn+i-1) = 0.0
         ENDDO
!
!     SELECT DESIRED MODES
!
         korbgn = modext + 3*itphis
         IF ( korbgn>=korlen ) THEN
            spag_nextblock_1 = 2
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         nfound = 0
         DO i = 1 , itphis
            j = 4 + 7*(i-1)
            IF ( rz(kore+j)>range(1) .AND. rz(kore+j)<range(2) ) THEN
!
!     REMOVE MODES WITH NEGATIVE EIGENVALUES
!
               IF ( rz(kore+j-2)>=0.0 ) THEN
                  z(modext+nfound) = i
                  nfound = nfound + 1
                  z(moduse+i-1) = 1
                  rz(ipartn+i-1) = 1.0
               ENDIF
            ENDIF
         ENDDO
!
!     PACK OUT PARTITIONING VECTOR
!
         typin = 1
         typep = 1
         irowp = 1
         nrowp = itrlr(2)
         incrp = 1
         iform = 2
         CALL makmcb(itrlr,pprtn,nrowp,iform,typin)
         CALL gopen(pprtn,z(gbuf1),1)
         CALL pack(rz(ipartn),pprtn,itrlr)
         CALL close(pprtn,1)
         CALL wrttrl(itrlr)
!
!     PARTITION PHISS MATRIX
!
!        **     **   **         **
!        *       *   *   .       *
!        * PHISS * = * 0 . PHIAM *
!        *       *   *   .       *
!        **     **   **         **
!
         nsub(1) = itphis - nfound
         nsub(2) = nfound
         nsub(3) = 0
         lcore = korlen - korbgn
         icore = lcore
!
!     TEST FOR ALL MODES
!
         IF ( nsub(1)==0 ) THEN
            phiam = phiss
         ELSE
            phiam = iscr(8)
!
!     PARTITION PHIAM MATRIX
!
!                    **     **
!                    *       *
!        **     **   * PHIBM *
!        *       *   *       *
!        * PHIAM * = *.......*
!        *       *   *       *
!        **     **   * PHIIM *
!                    *       *
!                    **     **
!
            CALL gmprtn(phiss,0,0,phiam,0,pprtn,0,nsub(1),nsub(2),z(korbgn),icore)
         ENDIF
!
!     CALCULATE THE VECTOR MAGNITUDE
!
         IF ( korbgn+nrows>=korlen ) THEN
            spag_nextblock_1 = 2
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         CALL gopen(phiam,z(gbuf1),0)
         typeu = 1
         irowu = 1
         nrowu = nrows
         incru = 1
         DO i = 1 , nfound
            l = ipartn + i - 1
            rz(l) = 0.0
            CALL unpack(*40,phiam,rz(korbgn))
            DO j = 1 , nrows
               k = korbgn + j - 1
               rz(l) = rz(l) + rz(k)**2
            ENDDO
 40      ENDDO
         CALL close(phiam,1)
         fuset = usetmr
         CALL calcv(pprtn,un,ui,ub,z(korbgn))
!
!     TEST FOR NULL B SET
!
         itrlr(1) = pprtn
         CALL rdtrl(itrlr)
         IF ( itrlr(6)>0 ) THEN
            phiim = iscr(7)
            CALL gmprtn(phiam,phiim,phibm,0,0,0,pprtn,nsub(1),nsub(2),z(korbgn),icore)
            jhim = 0
!
!     COMPUTE MODAL TRANSFORMATION MATRIX
!
!        **   **   **     **   **   ** **     **
!        *     *   *       *   *     * *       *
!        * HIM * = * PHIIM * - * GIB * * PHIBM *
!        *     *   *       *   *     * *       *
!        **   **   **     **   **   ** **     **
!
            CALL mtrxi(gib,oldnam,item,0,itest)
            IF ( itest/=1 ) THEN
               spag_nextblock_1 = 4
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            CALL softrl(oldnam,item,itrlr)
            itest = itrlr(1)
            IF ( itest/=1 ) THEN
               spag_nextblock_1 = 4
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            DO i = 1 , 7
               itrlra(i) = itrlr(i)
               itrlrb(i) = ia21(i)
               itrlrc(i) = ia11(i)
            ENDDO
            itrlra(1) = gib
            himscr = iscr(4)
            iform = 2
            iprc = 1
            ityp = 0
            IF ( itrlra(5)==2 .OR. itrlra(5)==4 ) iprc = 2
            IF ( itrlrb(5)==2 .OR. itrlrb(5)==4 ) iprc = 2
            IF ( itrlrc(5)==2 .OR. itrlrc(5)==4 ) iprc = 2
            IF ( itrlra(5)>=3 ) ityp = 2
            IF ( itrlrb(5)>=3 ) ityp = 2
            IF ( itrlrc(5)>=3 ) ityp = 2
            itype = iprc + ityp
            CALL makmcb(itrlrd,himscr,itrlr(3),iform,itype)
            CALL sofcls
            t = 0
            signab = -1
            signc = 1
            prec = 0
            scr = iscr(6)
            dblkor = korbgn/2 + 1
            nz = lstzwd - ((2*dblkor)-1)
            CALL mpyad(dz(dblkor),dz(dblkor),dz(dblkor))
            CALL wrttrl(itrlrd)
            CALL sofopn(z(sbuf1),z(sbuf2),z(sbuf3))
            i = itrlrd(2)
            ii = itrlrd(3)
            iform = itrlrd(4)
            himtyp = itrlrd(5)
         ELSE
            phiim = phiam
            ia11(1) = phiam
            CALL rdtrl(ia11)
            DO i = 1 , 7
               ia21(i) = 0
            ENDDO
!
!     PHIBM IS NULL, HIM = PHIIM
!
            himscr = phiim
            i = ia11(2)
            ii = ia11(3)
            iform = ia11(4)
            himtyp = ia11(5)
            jhim = 1
         ENDIF
!
!     TEST SELECTED MODES
!
         ncore = i
         IF ( korbgn+ncore>=korlen ) THEN
            spag_nextblock_1 = 2
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         typin = himtyp
         typep = himtyp
         irowp = 1
         nrowp = ii
         incrp = 1
         irowu = 1
         CALL gopen(himscr,z(gbuf1),0)
         CALL makmcb(itrlr,him,ii,iform,himtyp)
         CALL gopen(him,z(gbuf3),1)
         nfound = 0
         iter = i
         dblkor = korbgn/2 + 1
         sglkor = 2*dblkor - 1
         IF ( himtyp==1 ) dicore = (sglkor+ii)/2 + 1
         IF ( himtyp==2 ) dicore = dblkor + ii
         icore = 2*dicore - 1
!
!     UNPACK HIM COLUMN
!
         DO i = 1 , iter
            spag_nextblock_2 = 1
            SPAG_DispatchLoop_2: DO
               SELECT CASE (spag_nextblock_2)
               CASE (1)
!
!     LIMIT VECTORS TO NMAX
!
                  IF ( nfound<nnmax ) THEN
                     typeu = himtyp
                     incru = 1
                     nrowu = ii
                     ihim = nrowu
                     CALL unpack(*42,himscr,dz(dblkor))
!
!     SAVE LARGEST HIM COLUMN VALUE AND CALCULATE MAGNITUDE OF HIM,
!     COLUMN
!
                     IF ( himtyp==2 ) THEN
                        itype = 2
                        dhimsm = 0.0D0
                        dhimag = 0.0D0
                        DO j = 1 , ihim
                           IF ( dabs(dz(dblkor+j-1))>=dabs(dhimag) ) dhimag = dz(dblkor+j-1)
                           dhimsm = dhimsm + dz(dblkor+j-1)**2
                        ENDDO
                        himsum = dhimsm
                     ELSE
                        itype = 0
                        himsum = 0.0
                        himmag = 0.0
                        DO j = 1 , ihim
                           IF ( abs(rz(sglkor+j-1))>=abs(himmag) ) himmag = rz(sglkor+j-1)
                           himsum = himsum + (rz(sglkor+j-1)**2)
                        ENDDO
                     ENDIF
                     IF ( jhim==1 ) THEN
                        spag_nextblock_2 = 2
                        CYCLE SPAG_DispatchLoop_2
                     ENDIF
                     phimsm = rz(ipartn+i-1)
                     IF ( phimsm>0.0 ) THEN
                        pmsm = phimsm*epslon*epslon
                        IF ( himsum>=pmsm ) THEN
                           spag_nextblock_2 = 2
                           CYCLE SPAG_DispatchLoop_2
                        ENDIF
                     ENDIF
                  ELSE
                     j = z(modext+i-1) + moduse - 1
                     z(j) = 3
                     CYCLE
                  ENDIF
!
!     REJECT MODE
!
 42               j = z(modext+i-1)
                  z(moduse+j-1) = 2
               CASE (2)
!
!     USE MODE
!
                  nfound = nfound + 1
!
!     SCALE HIM COLUMN
!
                  IF ( himtyp==2 ) THEN
                     DO j = 1 , ihim
                        dz(dblkor+j-1) = dz(dblkor+j-1)/dhimag
                     ENDDO
                  ELSE
                     DO j = 1 , ihim
                        rz(sglkor+j-1) = rz(sglkor+j-1)/himmag
                     ENDDO
                  ENDIF
!
!     PACK HIM COLUMN
!
                  nrowp = nrowu
                  CALL pack(dz(dblkor),him,itrlr)
                  EXIT SPAG_DispatchLoop_2
               END SELECT
            ENDDO SPAG_DispatchLoop_2
         ENDDO
         CALL close(him,1)
         IF ( jhim==0 ) CALL close(phiim,1)
         CALL close(himscr,1)
         CALL wrttrl(itrlr)
         korbgn = kore
         IF ( jhim==1 ) himscr = iscr4
!
!     TEST NUMBER OF MODAL POINTS
!
         modal = itrlr(2)
         IF ( frebdy ) modal = modal + fbmods
         IF ( modal>itrlr(3) ) THEN
            WRITE (iprntr,99001) ufm , oldnam , modal , itrlr(3)
99001       FORMAT (A23,' 6633, FOR SUBSTRUCTURE ',2A4,' THE TOTAL NUMBER OF',' MODAL COORDINATES (',I8,1H),/30X,                   &
                   &'IS LARGER THAN THE NUMBER OF INTERNAL DOF (',I8,2H).)
            dry = -2
         ENDIF
         RETURN
!
!     PROCESS SYSTEM FATAL ERRORS
!
 60      imsg = -2
         spag_nextblock_1 = 3
         CYCLE SPAG_DispatchLoop_1
 80      imsg = -3
         spag_nextblock_1 = 3
      CASE (2)
         imsg = -8
         ifile = 0
         spag_nextblock_1 = 3
      CASE (3)
         CALL sofcls
         CALL mesage(imsg,ifile,modnam)
         RETURN
      CASE (4)
!
!     PROCESS MODULE FATAL ERRORS
!
         IF ( itest==3 ) THEN
            imsg = -1
         ELSEIF ( itest==4 ) THEN
            imsg = -2
         ELSEIF ( itest==5 ) THEN
            imsg = -3
         ELSEIF ( itest==6 ) THEN
            imsg = -10
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ELSE
            imsg = -11
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         CALL smsg(imsg,item,oldnam)
         RETURN
      CASE (5)
         CALL smsg1(imsg,item,oldnam,modnam)
         dry = -2
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE mred2e
