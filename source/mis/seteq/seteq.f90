!*==seteq.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE seteq(Name1,Name2,Prefx,Dry2,Itest,Imore,Lim)
!
!     SETS THE SUBSTRUCTURE NAME2 EQUIVALENT TO THE SUBSTRUCTURE NAME1.
!     THE OUTPUT VARIABLE ITEST TAKES ON ONE OF THE FOLLOWING VALUES
!
!         4  IF NAME1 DOES NOT EXIST
!         8  IF DRY DOES NOT EQUAL ZERO AND NAME2 OR ONE OF THE NEW
!            NAMES ALREADY EXISTS
!         9  IF DRY IS EQUAL TO ZERO AND NAME2 OR ONE OF THE NEW NAMES
!            DOES NOT EXIST
!         1  OTHERWISE
!
   USE c_itemdt
   USE c_machin
   USE c_output
   USE c_sof
   USE c_sys
   USE c_system
   USE c_xmssg
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER , DIMENSION(2) :: Name1
   INTEGER , DIMENSION(2) :: Name2
   INTEGER :: Prefx
   INTEGER :: Dry2
   INTEGER :: Itest
   INTEGER , DIMENSION(1) :: Imore
   INTEGER :: Lim
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , SAVE :: bb , cs , hl , ib , iempty , indsbr , ird , iwrt , ll , mask , ps , ss
   INTEGER :: dry , first , first2 , i , ibs , ics , idit , ifnd , ihl , ill , image , imdi , inc , ind1 , ind2 , indcs , indll ,   &
            & inxt , ipp , ips , iptr , irdbl , iret , iss , itm , itop , iwant , iwrtbl , j , k , kk , maskbb , maskll , maskss ,  &
            & max , min , newblk , next , numb , rest , rest2
   INTEGER , DIMENSION(50) :: isave
   LOGICAL :: more
   INTEGER , DIMENSION(2) :: namnew
   INTEGER , DIMENSION(2) , SAVE :: nmsbr
   EXTERNAL andf , chkopn , complf , crsub , errmkn , fdit , fdsub , fmdi , fnxt , getblk , khrfn1 , klshft , krshft , lshift ,     &
          & mesage , orf , page , page2 , retblk , rshift , sofcls , sofio
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
   INTEGER :: spag_nextblock_2
   DATA ps , ss , ib , ll , cs , hl , bb , ird , iwrt , indsbr/1 , 1 , 1 , 2 , 2 , 2 , 1 , 1 , 2 , 15/
   DATA iempty , mask , nmsbr/4H     , 4HMASK , 4HSETE , 4HQ   /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
         CALL chkopn(nmsbr(1))
         IF ( nitem+ifrst-1>50 ) THEN
            CALL errmkn(indsbr,10)
            spag_nextblock_1 = 13
            CYCLE SPAG_DispatchLoop_1
         ELSE
            dry = Dry2
            Itest = 1
            CALL fdsub(Name1(1),ind1)
            IF ( ind1==-1 ) THEN
!
!     ERROR CONDITIONS
!
               Itest = 4
               RETURN
            ELSE
               mask = andf(mask,2**(nbpw-4*nbpc)-1)
               maskss = complf(lshift(1023,10))
               maskll = complf(lshift(1023,20))
               maskbb = lshift(1023,20)
!
!     IF NAME2 EXISTS - VERIFY THAT IT IS MARKED EQUIVALENT TO NAME1.
!     NAME2 MAY ALREADY EXIST FOR RUN=GO OR OPTIONS=PA
!
               CALL fdsub(Name2(1),ind2)
               IF ( ind2/=-1 ) THEN
                  dry = 0
!
                  CALL fmdi(ind2,imdi)
                  ips = andf(buf(imdi+ps),1023)
                  IF ( ips==0 ) THEN
                     Itest = 8
                     RETURN
                  ELSEIF ( ips/=ind1 ) THEN
                     CALL fmdi(ind1,imdi)
                     ipp = andf(buf(imdi+ps),1023)
                     IF ( ips/=ipp ) THEN
                        Itest = 8
                        RETURN
                     ENDIF
                  ENDIF
               ENDIF
!
!     STEP 1.  MAKE A LIST OF ALL THE SUBSTRUCTURES CONTRIBUTING TO THE
!     SUBSTRUCTURE NAME1, AND STORE IT IN THE ARRAY IMORE
!
               itop = 1
               Imore(itop) = ind1
               iptr = 1
            ENDIF
         ENDIF
         spag_nextblock_1 = 2
      CASE (2)
         CALL fmdi(ind1,imdi)
         i = buf(imdi+ll)
         indll = rshift(andf(i,1073741823),20)
         indcs = rshift(andf(i,1048575),10)
         IF ( indll/=0 ) THEN
            DO j = 1 , itop
               IF ( Imore(j)==indll ) THEN
                  spag_nextblock_1 = 3
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDDO
            itop = itop + 1
            IF ( itop>Lim ) THEN
               k = -8
               spag_nextblock_1 = 13
               CYCLE SPAG_DispatchLoop_1
            ELSE
               Imore(itop) = indll
            ENDIF
         ENDIF
         spag_nextblock_1 = 3
      CASE (3)
         IF ( indcs/=0 .AND. iptr/=1 ) THEN
            DO j = 1 , itop
               IF ( Imore(j)==indcs ) THEN
                  spag_nextblock_1 = 4
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
            ENDDO
            itop = itop + 1
            IF ( itop>Lim ) THEN
               k = -8
               spag_nextblock_1 = 13
               CYCLE SPAG_DispatchLoop_1
            ELSE
               Imore(itop) = indcs
            ENDIF
         ENDIF
         spag_nextblock_1 = 4
      CASE (4)
         IF ( iptr/=itop ) THEN
            iptr = iptr + 1
            ind1 = Imore(iptr)
            spag_nextblock_1 = 2
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         SPAG_Loop_1_1: DO
!
!     STEP 2.  CREATE AN IMAGE SUBSTRUCTURE FOR EACH SUBSTRUCTURE IN THE
!     ARRAY IMORE, AND STORE ITS INDEX IN THE ARRAY IMAGE.  NOTE THAT
!     SINCE IMORE(1) CONTAINS THE INDEX OF NAME1, IMAGE(1) WILL CONTAIN
!     THE INDEX OF NAME2
!     FOR EACH NEW NAME CHECK THAT MAKING ROOM FOR THE PREFIX DOES NOT
!     TRUNCATE THE NAME
!
            IF ( iptr/=1 ) THEN
               CALL fdit(ind1,idit)
               first = klshft(krshft(Prefx,ncpw-1),ncpw-1)
               rest = klshft(krshft(buf(idit),ncpw-3),ncpw-4)
               namnew(1) = orf(orf(first,rest),mask)
               first = klshft(krshft(buf(idit),ncpw-4),ncpw-1)
               rest = klshft(krshft(buf(idit+1),ncpw-3),ncpw-4)
               namnew(2) = orf(orf(first,rest),mask)
               IF ( khrfn1(iempty,4,buf(idit+1),4)/=iempty ) WRITE (nout,99001) uwm , namnew , buf(idit) , buf(idit+1)
99001          FORMAT (A25,' 6236, DURING THE CREATION OF A NEW IMAGE SUBSTRUC','TURE NAMED ',2A4,' THE LAST CHARACTER ',/5X,       &
                      &'OF SUBSTRUCTURE NAMED ',2A4,' WAS TRUNCATED TO MAKE ROOM',' FOR THE PREFIX.')
               CALL fdsub(namnew(1),i)
            ELSE
               CALL fdsub(Name2(1),i)
            ENDIF
            IF ( dry/=0 ) THEN
               IF ( i/=-1 ) THEN
                  iptr = iptr + 1
                  IF ( iptr<=itop ) THEN
                     DO i = iptr , itop
                        image = Imore(Lim+i)
                        CALL fdit(image,idit)
                        buf(idit) = iempty
                        buf(idit+1) = iempty
                        ditup = .TRUE.
                     ENDDO
                  ENDIF
                  Itest = 8
                  RETURN
               ELSEIF ( iptr/=1 ) THEN
                  CALL crsub(namnew(1),i)
               ELSE
                  CALL crsub(Name2(1),i)
               ENDIF
            ELSEIF ( i==-1 ) THEN
               Itest = 9
               RETURN
            ENDIF
            Imore(iptr+Lim) = i
            IF ( iptr==1 ) THEN
!
!     STEP 3.  BUILD THE MDI OF NAME2, AND OF ALL IMAGE SUBSTRUCTURES
!
               ind2 = i
            ELSE
               iptr = iptr - 1
               ind1 = Imore(iptr)
               CYCLE
            ENDIF
            EXIT SPAG_Loop_1_1
         ENDDO SPAG_Loop_1_1
         spag_nextblock_1 = 5
      CASE (5)
         CALL fmdi(ind1,imdi)
         DO j = 1 , dirsiz
            isave(j) = buf(imdi+j)
         ENDDO
!
!     SET THE SS ENTRY FOR THE SUBSTRUCTURE WITH INDEX IND1
!
         IF ( dry/=0 ) THEN
            buf(imdi+ss) = orf(andf(buf(imdi+ss),maskss),lshift(ind2,10))
            mdiup = .TRUE.
         ENDIF
         CALL fmdi(ind2,imdi)
         IF ( dry==0 ) THEN
            spag_nextblock_1 = 10
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         i = isave(ps)
!
!     SET THE PS ENTRY FOR THE SUBSTRUCTURE WITH INDEX IND2
!
         ips = andf(i,1023)
         IF ( ips==0 ) THEN
            buf(imdi+ps) = ind1
         ELSE
            buf(imdi+ps) = ips
         ENDIF
!
!     SET THE SS ENTRY FOR THE SUBSTRUCTURE WITH INDEX IND2
!
         iss = rshift(andf(i,1048575),10)
         IF ( iss/=0 ) buf(imdi+ss) = orf(andf(buf(imdi+ss),maskss),lshift(iss,10))
!
!     SET THE BB ENTRY FOR THE SUBSTRUCTURE WITH INDEX IND2
!
         ibs = andf(i,maskbb)
         buf(imdi+bb) = orf(andf(buf(imdi+bb),maskll),ibs)
         i = isave(ll)
!
!     SET THE HL ENTRY FOR THE SUBSTRUCTURE WITH INDEX IND2
!
         IF ( iptr==1 ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ihl = andf(i,1023)
         IF ( ihl==0 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ASSIGN 20 TO iret
         iwant = ihl
         spag_nextblock_1 = 8
         CYCLE SPAG_DispatchLoop_1
 20      buf(imdi+hl) = ifnd
         spag_nextblock_1 = 6
      CASE (6)
!
!     SET THE CS ENTRY FOR THE SUBSTRUCTURE WITH INDEX IND2
!
         ics = rshift(andf(i,1048575),10)
         IF ( ics==0 ) THEN
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ASSIGN 40 TO iret
         iwant = ics
         spag_nextblock_1 = 8
         CYCLE SPAG_DispatchLoop_1
 40      buf(imdi+cs) = orf(andf(buf(imdi+cs),maskss),lshift(ifnd,10))
         spag_nextblock_1 = 7
      CASE (7)
!
!     SET THE LL ENTRY FOR THE SUBSTRUCTURE WITH INDEX IND2
!
         ill = rshift(andf(i,1073741823),20)
         IF ( ill==0 ) THEN
            spag_nextblock_1 = 9
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ASSIGN 60 TO iret
         iwant = ill
         spag_nextblock_1 = 8
         CYCLE SPAG_DispatchLoop_1
 60      buf(imdi+ll) = orf(andf(buf(imdi+ll),maskll),lshift(ifnd,20))
         spag_nextblock_1 = 9
      CASE (8)
!
!     FIND THE INDEX OF THE IMAGE SUBSTRUCTURE TO THE SUBSTRUCTURE WITH
!     INDEX IWANT.  STORE THE FOUND INDEX IN IFND
!
         DO k = 1 , itop
            IF ( Imore(k)==iwant ) THEN
               ifnd = Imore(Lim+k)
               GOTO iret
            ENDIF
         ENDDO
         CALL errmkn(indsbr,3)
         spag_nextblock_1 = 12
      CASE (9)
!
!     SET THE POINTERS OF THE ITEMS BELONGING TO THE SUBSTRUCTURE WITH
!     INDEX IND2
!
         DO j = ifrst , dirsiz
            buf(imdi+j) = 0
         ENDDO
         spag_nextblock_1 = 10
      CASE (10)
         IF ( iptr==1 ) THEN
!
!     SECONDARY SUBSTRUCTURE - SET POINTERS TO SHARED ITEMS
!
            DO j = 1 , nitem
               IF ( item(5,j)==0 ) THEN
                  itm = j + ifrst - 1
                  IF ( buf(imdi+itm)==0 ) buf(imdi+itm) = isave(itm)
               ENDIF
            ENDDO
         ELSE
!
!     IMAGE SUBSTRUCTURE - SET POINTERS TO SHARED ITEMS AND SET IB BIT
!
            DO j = 1 , nitem
               IF ( item(4,j)==0 ) THEN
                  itm = j + ifrst - 1
                  IF ( buf(imdi+itm)==0 ) buf(imdi+itm) = isave(itm)
               ENDIF
            ENDDO
            buf(imdi+ib) = orf(buf(imdi+ib),lshift(1,30))
         ENDIF
!
!     COPY APPROPRIATE ITEMS OF NAME1 AND WRITE THEM FOR
!     NAME2 AFTER CHANGING NAME1 TO NAME2 AND INSERTING THE NEW PREFIX
!     TO THE NAMES OF ALL CONTRIBUTING SUBSTRUCTURES
!
         DO j = 1 , nitem
            spag_nextblock_2 = 1
            SPAG_DispatchLoop_2: DO
               SELECT CASE (spag_nextblock_2)
               CASE (1)
                  IF ( item(3,j)==0 ) CYCLE
                  kk = j + ifrst - 1
                  IF ( buf(imdi+kk)/=0 ) CYCLE
                  irdbl = andf(isave(kk),jhalf)
                  IF ( irdbl/=0 .AND. irdbl/=jhalf ) THEN
                     CALL sofio(ird,irdbl,buf(io-2))
                     CALL fdit(ind2,idit)
                     buf(io+1) = buf(idit)
                     buf(io+2) = buf(idit+1)
                     CALL getblk(0,iwrtbl)
                     IF ( iwrtbl==-1 ) THEN
                        spag_nextblock_1 = 12
                        CYCLE SPAG_DispatchLoop_1
                     ENDIF
                     newblk = iwrtbl
                     numb = item(3,j)/1000000
                     min = (item(3,j)-numb*1000000)/1000
                     inc = item(3,j) - numb*1000000 - min*1000
                     numb = buf(io+numb)
                     IF ( numb<=1 .AND. ill==0 .AND. iptr==1 ) THEN
!
!     BASIC SUBSTRUCTURE
!
                        buf(io+min) = Name2(1)
                        buf(io+min+1) = Name2(2)
                        more = .FALSE.
                        spag_nextblock_2 = 3
                        CYCLE SPAG_DispatchLoop_2
                     ENDIF
                  ELSE
                     buf(imdi+kk) = isave(kk)
                     CYCLE
                  ENDIF
                  spag_nextblock_2 = 2
               CASE (2)
!
!     NOT A BASIC SUBSTRUCTURE
!
                  IF ( numb<=(blksiz-min+1)/inc ) THEN
                     max = min + inc*numb - 1
                     more = .FALSE.
                  ELSE
                     numb = numb - (blksiz-min+1)/inc
                     max = blksiz
                     more = .TRUE.
                  ENDIF
!
!     INSERT THE NEW PREFIX TO THE NAMES OF ALL CONTRIBUTING SUBSTRUC-
!     TURES
!     IF THE COMPONENT IS FOR MODAL DOF ON THE SECONDARY SUBSTRUCTURE,
!     USE THE ACTUAL NAME INSTEAD OF ADDING A PREFIX
!
                  DO k = min , max , inc
                     IF ( buf(io+k)==Name1(1) .AND. buf(io+k+1)==Name1(2) ) THEN
!
                        buf(io+k) = Name2(1)
                        buf(io+k+1) = Name2(2)
                     ELSE
                        first = klshft(krshft(Prefx,ncpw-1),ncpw-1)
                        rest = klshft(krshft(buf(io+k),ncpw-3),ncpw-4)
                        first2 = klshft(krshft(buf(io+k),ncpw-4),ncpw-1)
                        rest2 = klshft(krshft(buf(io+k+1),ncpw-3),ncpw-4)
                        buf(io+k) = orf(orf(first,rest),mask)
                        buf(io+k+1) = orf(orf(first2,rest2),mask)
                     ENDIF
                  ENDDO
                  spag_nextblock_2 = 3
               CASE (3)
                  SPAG_Loop_2_2: DO
!
!     WRITE OUT UPDATED DATA BLOCK
!
                     CALL sofio(iwrt,iwrtbl,buf(io-2))
                     CALL fnxt(irdbl,inxt)
                     IF ( mod(irdbl,2)==1 ) THEN
                        next = andf(buf(inxt),jhalf)
                     ELSE
                        next = andf(rshift(buf(inxt),ihalf),jhalf)
                     ENDIF
                     IF ( next==0 ) THEN
!
!     NO MORE BLOCKS TO COPY.  UPDATE MDI OF NAME2
!
                        buf(imdi+kk) = orf(lshift(rshift(isave(kk),ihalf),ihalf),newblk)
                        EXIT SPAG_Loop_2_2
                     ELSE
!
!     MORE BLOCKS TO COPY
!
                        irdbl = next
                        CALL getblk(iwrtbl,next)
                        IF ( next/=-1 ) THEN
                           iwrtbl = next
                           CALL sofio(ird,irdbl,buf(io-2))
                           min = 1
                           IF ( more ) THEN
                              spag_nextblock_2 = 2
                              CYCLE SPAG_DispatchLoop_2
                           ENDIF
                        ELSE
                           CALL retblk(newblk)
                           spag_nextblock_1 = 12
                           CYCLE SPAG_DispatchLoop_1
                        ENDIF
                     ENDIF
                  ENDDO SPAG_Loop_2_2
                  EXIT SPAG_DispatchLoop_2
               END SELECT
            ENDDO SPAG_DispatchLoop_2
         ENDDO
!
         mdiup = .TRUE.
         IF ( iptr/=itop ) THEN
            iptr = iptr + 1
            ind1 = Imore(iptr)
            ind2 = Imore(iptr+Lim)
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
!
!     WRITE USER MESSAGES
!
         ELSEIF ( dry==0 ) THEN
!
!     DRY RUN - PRINT MESSAGE INDICATING ONLY ADDITIONS MADE
!
            CALL page2(-3)
            WRITE (nout,99002) uim , Name2 , Name1 , Name2
99002       FORMAT (A29,' 6228, SUBSTRUCTURE ',2A4,' IS ALREADY AN EQUIVALENT',' SUBSTRUCTURE TO ',2A4,/36X,                        &
                   &'ONLY ITEMS NOT PREVIOUSLY ','EXISTING FOR ',2A4,' HAVE BEEN MADE EQUIVALENT.')
            RETURN
         ELSE
            DO i = 1 , 96
               subtit(i) = iempty
            ENDDO
            CALL page
            CALL page2(-4)
            WRITE (nout,99003) Name2 , Name1
!
99003       FORMAT (32X,67HS U B S T R U C T U R E   E Q U I V A L E N C E   O P E R A T I O N,///23X,13HSUBSTRUCTURE ,2A4,         &
                   &56H HAS BEEN CREATED AND MARKED EQUIVALENT TO SUBSTRUCTURE ,2A4)
            image = Imore(Lim+1)
            CALL fmdi(image,imdi)
            ips = andf(buf(imdi+1),1023)
            CALL fdit(ips,i)
            CALL page2(-2)
            WRITE (nout,99004) Name2 , buf(i) , buf(i+1)
99004       FORMAT (1H0,22X,28HTHE PRIMARY SUBSTRUCTURE OF ,2A4,4H IS ,2A4)
            iptr = 2
            IF ( iptr>itop ) RETURN
            CALL page2(-2)
            WRITE (nout,99005)
99005       FORMAT (1H0,22X,56HTHE FOLLOWING IMAGE SUBSTRUCTURES HAVE BEEN GENERATED --)
         ENDIF
         spag_nextblock_1 = 11
      CASE (11)
         DO i = 1 , 16
            Imore(i) = iempty
         ENDDO
         j = 1
         SPAG_Loop_1_3: DO
            image = Imore(iptr+Lim)
            CALL fdit(image,i)
            Imore(j) = buf(i)
            Imore(j+1) = buf(i+1)
            iptr = iptr + 1
            IF ( iptr>itop ) EXIT SPAG_Loop_1_3
            j = j + 2
            IF ( j>=16 ) EXIT SPAG_Loop_1_3
         ENDDO SPAG_Loop_1_3
         CALL page2(-2)
         WRITE (nout,99006) (Imore(j),j=1,16)
99006    FORMAT (1H0,22X,10(2A4,2X))
         IF ( iptr<=itop ) THEN
            spag_nextblock_1 = 11
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         RETURN
      CASE (12)
         WRITE (nout,99007) ufm
99007    FORMAT (A23,' 6223, SUBROUTINE SETEQ - THERE ARE NO MORE FREE ','BLOCKS AVAILABLE ON THE SOF.')
         k = -37
         spag_nextblock_1 = 13
      CASE (13)
         CALL sofcls
         CALL mesage(k,0,nmsbr)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
!
END SUBROUTINE seteq
