!*==flbelm.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE flbelm
   USE c_blank
   USE c_flbfil
   USE c_flbptr
   USE c_system
   USE c_xmssg
   USE c_zzzzzz
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , DIMENSION(10) :: card
   INTEGER , DIMENSION(2) , SAVE :: cflstr , cfree , name
   INTEGER , DIMENSION(7,3) , SAVE :: elm2d
   INTEGER , DIMENSION(4,3) , SAVE :: elmfl
   INTEGER :: file , i , ids , ielmt , j , jloc , lelmt , lgrid , n , nelm , nelmt , ngrdf , ngrds , ngrdt , ntype , nwds , nz
   INTEGER , DIMENSION(4) :: grid
   INTEGER , DIMENSION(3) :: id
   INTEGER , DIMENSION(7) , SAVE :: mcb
   INTEGER , SAVE :: n2d , nfl
   EXTERNAL bisloc , close , flface , fwdrec , gopen , locate , mesage , preloc , read , rewind , sort , write , wrttrl
!
! End of declarations rewritten by SPAG
!
!
!     READS CFLSTR AND CFREE BULK DATA AND BUILDS INCORE TABLES TO
!     DESCRIBE THE CONNECTIVITY BETWEEN THE STRUCTURE AND FLUID
!
   DATA cflstr/7610 , 76/ , cfree/4810 , 48/ , mcb/7*0/
   DATA name/4HFLBE , 4HLM  /
!
!     TWO DIMENSIONAL STRUCTURAL ELEMENTS DESCRIPTIONS
!
   DATA n2d/7/
!
!                     TRIA1  TRIA2   TRMEM  QUAD1  QUAD2  QDMEM  SHEAR
!     1  IFP CARD NUMBERS
!     2  NUMBER OF GRIDS
!     3  NUMBER OF WORDS IN ECT RECORD
!
   DATA elm2d/52 , 53 , 56 , 57 , 58 , 60 , 61 , 3 , 3 , 3 , 4 , 4 , 4 , 4 , 6 , 6 , 6 , 7 , 7 , 7 , 6/
!
!     FLUID ELEMENT DESCRIPTIONS
!
   DATA nfl/4/
!
!                     FHEX1     FHEX2     FTETRA    FWEDGE
!    1  IFP CARD NUMBERS
!    2  NUMBER OF GRIDS
!    3  NUMBER OF WORDS IN ECT RECORD
!
   DATA elmfl/333 , 334 , 335 , 336 , 8 , 8 , 4 , 6 , 10 , 10 , 6 , 8/
!
!
!     READ BGPDT INTO OPEN CORE
!
   ibgpdt = 1
   file = bgpdt
   CALL gopen(bgpdt,z(ibuf1),0)
   nz = ibuf3 - 1
   CALL read(*1200,*100,bgpdt,z(ibgpdt),nz,1,nbgpdt)
   n = -8
   CALL mesage(n,file,name)
   GOTO 1400
 100  icore = ibgpdt + nbgpdt
   ngrdt = nbgpdt/4
   CALL close(bgpdt,1)
!
!     LOCATE CFLSTR CARDS ON GEOM2 AND READ THEM INTO ELEMENT TABLE
!     IN CORE.   ONE ELEMENT TABLE RECORD WILL LOOK AS FOLLOWS -
!
!                  WORD      DESCRIPTION
!
!                  1         STRUCTURE ELEMENT ID
!                  2         FLUID ELEMENT ID
!                  3-6       ZERO
!                  7         GRAV LOAD ID
!
   file = geom2
   CALL preloc(*1100,z(ibuf1),geom2)
   CALL locate(*1400,z(ibuf1),cflstr,id)
   ielmt = icore
   SPAG_Loop_1_1: DO
      CALL read(*1200,*200,geom2,id,2,0,n)
      DO
         CALL read(*1200,*1300,geom2,ids,1,0,n)
         IF ( ids<0 ) CYCLE SPAG_Loop_1_1
         IF ( icore+7>=ibuf3 ) THEN
            n = -8
            CALL mesage(n,file,name)
            GOTO 1400
         ELSE
            z(icore) = ids
            z(icore+1) = id(1)
            z(icore+2) = 0
            z(icore+3) = 0
            z(icore+4) = 0
            z(icore+5) = 0
            z(icore+6) = id(2)
            icore = icore + 7
         ENDIF
      ENDDO
      EXIT SPAG_Loop_1_1
   ENDDO SPAG_Loop_1_1
!
 200  nelmt = icore - ielmt
   nelm = nelmt/7
!
!     SORT ELEMENT TABLE BY STRUCTUREAL ELEMENT ID
!
   CALL sort(0,0,7,1,z(ielmt),nelmt)
!
!     READ ECT AND PROCESS 2D STRUCTURAL ELEMENTS
!
   file = ect
   CALL gopen(ect,z(ibuf2),0)
 300  SPAG_Loop_1_2: DO
      CALL read(*500,*1200,ect,card,3,0,n)
      DO i = 1 , n2d
         IF ( card(3)==elm2d(i,1) ) EXIT SPAG_Loop_1_2
      ENDDO
!
!     SKIP RECORD BECAUSE NOT ACCEPTABLE 2D ELEMENT TYPE
!
      CALL fwdrec(*1100,ect)
   ENDDO SPAG_Loop_1_2
!
!     PROCESS THE 2D ELEMENT
!
   ngrds = elm2d(i,2)
   nwds = elm2d(i,3)
 400  SPAG_Loop_1_3: DO
!
!     READ DATA FOR ONE 2D ELEMENT
!
      CALL read(*1100,*300,ect,card,nwds,0,n)
!
!     CHECK IF STRUCTURAL ELEMENT IS CONNECTED TO ANY FLUID ELEMENT
!     MAKE SURE BISLOC FINDS FIRST OF SEVERAL POSSIBLE ENTRIES
!
      CALL bisloc(*400,card(1),z(ielmt),7,nelm,jloc)
      DO WHILE ( jloc/=1 .AND. z(ielmt+jloc-8)==card(1) )
         jloc = jloc - 7
      ENDDO
      DO
!
!     INSERT ELEMENT GRID POINTS INTO ELEMENT TABLE WORDS 3-6
!
         DO i = 1 , ngrds
            z(ielmt+jloc+i) = card(i+2)
         ENDDO
         IF ( ngrds==3 ) z(ielmt+jloc+4) = -1
!
!     CHECK IF NEXT ENTRY IS FOR THE SAME STRUCTURAL ELEMENT
!
         IF ( jloc+7>=nelmt .OR. z(ielmt+jloc+6)/=card(1) ) CYCLE SPAG_Loop_1_3
         jloc = jloc + 7
      ENDDO
      EXIT SPAG_Loop_1_3
   ENDDO SPAG_Loop_1_3
!
!
!     PASS THROUGH ELEMENT TABLE AND CHECK THAT EACH ENTRY HAS GRIDS.
!     ALSO SWITCH THE STRUCTURE AND FLUID ELEMENTS IN THE TABLE FOR
!     FUTURE WORD WITH FLUID ID.
!
 500  lelmt = ielmt + nelmt - 1
   DO i = ielmt , lelmt , 7
      ids = z(i)
      z(i) = z(i+1)
      IF ( z(i+2)==0 ) THEN
         error = .TRUE.
         WRITE (nout,99001) ufm , ids
99001    FORMAT (A23,' 8002, ELEMENT ID',I9,' ON A CFLSTR CARD DOES NOT ','REFERENCE A VALID 2D STRUCTURAL ELEMENT.')
         ids = 0
      ENDIF
      z(i+1) = ids
   ENDDO
!
!     ALLOCATE AND ZERO THE GRID POINT CONNECTIVE TABLE AT THE BOTTOM
!     OF CORE
!
!     TABLE ENTRIES WILL BE AS FOLLOWS
!
!     POSITIVE LESS THEN 1,000,000  - NUMBER OF STRUCTURAL POINTS
!                                     CONNECTED TO THIS FLUID POINT
!     MULTIPLES OF 1,000,000        - NUMBER OF FREE SURFACE POINTS
!                                     CONNECTED TO THIS FLUID POINT
!     NEGATIVE                      - NUMBER OF STRUCTURAL POINTS
!                                     CONNECTED TO THIS STRUCTURAL
!                                     POINT
!
   igrid = ibuf3 - ngrdt - 1
   IF ( igrid<icore ) THEN
      n = -8
      CALL mesage(n,file,name)
      GOTO 1400
   ELSE
      ngrid = ngrdt
      lgrid = ibuf3 - 1
      DO i = igrid , lgrid
         z(i) = 0
      ENDDO
!
!     LOCATE CFREE CARDS ON GEOM2 AND ADD THEM TO THE ELEMENT TABLE.
!     THESE ELEMENT RECORDS WILL APPEAR AS FOLLOWS
!
!                  WORD      DESCRIPTION
!
!                  1         FLUID ELEMENT ID
!                  2         -1
!                  3         FACE ID
!                  4-6       ZERO
!                  7         GRAV ID
!
      file = geom2
      CALL locate(*600,z(ibuf1),cfree,id)
      nofree = 1
      DO
         CALL read(*1200,*700,geom2,id,3,0,n)
         IF ( icore+7>=igrid ) THEN
            n = -8
            CALL mesage(n,file,name)
            GOTO 1400
         ELSE
            z(icore) = id(1)
            z(icore+1) = -1
            z(icore+2) = id(3)
            z(icore+3) = 0
            z(icore+4) = 0
            z(icore+5) = 0
            z(icore+6) = id(2)
            icore = icore + 7
         ENDIF
      ENDDO
   ENDIF
!
!     NO CFREE CARDS - THIS IMPLIES THAT THERE WILL BE NO FREE SURFACE
!
 600  nofree = -1
!
!     COMPLETE CORE ALLOCATION FOR THIS PHASE
!
 700  nelmt = icore - ielmt
   nelm = nelmt/7
   CALL close(geom2,1)
!
!     SORT ELEMENT TABLE BY FLUID ID
!
   CALL sort(0,0,7,1,z(ielmt),nelmt)
!
!     OPEN FBELM AND FRELM SCRATCH FILES
!
   CALL gopen(fbelm,z(ibuf1),1)
   CALL gopen(frelm,z(ibuf3),1)
!
!     READ ECT AND PROCESS FLUID ELEMENTS
!
   file = ect
   CALL rewind(ect)
   CALL fwdrec(*1200,ect)
 800  SPAG_Loop_1_4: DO
      CALL read(*1000,*1300,ect,card,3,0,n)
      DO i = 1 , nfl
         IF ( card(3)==elmfl(i,1) ) EXIT SPAG_Loop_1_4
      ENDDO
!
!     SKIP RECORD BECAUSE NOT FLUID ELEMENT TYPE
!
      CALL fwdrec(*1100,ect)
   ENDDO SPAG_Loop_1_4
!
!     PRECESS FLUID ELEMENT
!
   ntype = elmfl(i,1)
   nwds = elmfl(i,3)
 900  SPAG_Loop_1_5: DO
!
!     READ DATA FOR ONE FLUID ELEMENT
!
      CALL read(*1100,*800,ect,card,nwds,0,n)
!
!     FIND IF FLUID ELEMENT IS ON FREE SURFACE OR STRUCTURAL BOUNDARY.
!     MAKE SURE BISLOC FINDS THE FIRST OF SEVERAL POSSIBLE ENTRIES.
!
      CALL bisloc(*900,card(1),z(ielmt),7,nelm,jloc)
      DO WHILE ( jloc/=1 .AND. z(ielmt+jloc-8)==card(1) )
         jloc = jloc - 7
      ENDDO
      DO
!
!     DETERMINE IF ENTRY IS EITHER A BOUNDARY OR FREE SURFACE
!     DESCRIPTION - IGNORE ENTRY IF IT WAS IN ERROR DURING STRUCTURAL
!     ELEMENT PROCESSING
!
         IF ( z(ielmt+jloc)>0 ) THEN
!
!     THIS ENTRY DESCRIBES THE FLUID / STRUCTURE BOUNDARY - FIND THE
!     FLUID GRID POINTS WHICH COINCIDE WITH THE STRUCTURAL POINTS
!
            CALL flface(ntype,card,z(ielmt+jloc-1),grid)
            IF ( .NOT.(error) ) THEN
!
!     INCLUDE CONNECTIONS IN GRID POINT CONNECTIVITY TABLE
!        1) NUMBER OF STRUCTURE GRID POINTS CONNECTED TO EACH FLUID
!        2) NUMBER OF STRUCTURAL GRID POINTS CONNECTED TO EACH
!           STRUCTURE POINT
!
               ngrdf = 4
               IF ( grid(4)<0 ) ngrdf = 3
               ngrds = 4
               IF ( z(ielmt+jloc+4)<0 ) ngrds = 3
               DO i = 1 , ngrdf
                  j = grid(i) - 1
                  z(igrid+j) = z(igrid+j) + ngrds
               ENDDO
               DO i = 1 , ngrds
                  j = z(ielmt+jloc+i) - 1
                  z(igrid+j) = z(igrid+j) - ngrds
               ENDDO
!
!     WRITE 12 WORD RECORD FOR THIS ENTRY ON FBELM
!
!                  WORD      DESCRIPTION
!
!                  1         FLUID ELEMENT ID
!                  2         STRUCTURAL ELEMENT ID
!                  3-6       STRUCTURE GRID POINTS
!                  7         GRAVITY LOAD ID
!                  8         MATERIAL ID
!                  9-12      FLUID GRID POINTS
!
               CALL write(fbelm,z(ielmt+jloc-1),7,0)
               CALL write(fbelm,card(2),1,0)
               CALL write(fbelm,grid,4,0)
            ENDIF
         ELSEIF ( z(ielmt+jloc)==-1 ) THEN
!
!     THIS ENTRY DESCRIBES THE FREE SURFACE - FIND THE FLUIDS GRID
!     POINTS WHICH DEFINE THE FACE ID GIVEN
!
            CALL flface(ntype,card,z(ielmt+jloc-1),grid)
            IF ( .NOT.(error) ) THEN
!
!     INCLUDE CONNECTIONS IN GRID POINT CONNECTIVITY TABLE
!        1) NUMBER OF FREE SURFACE POINTS CONNECTED TO THIS FREE
!           SURFACE POINT
!
               ngrdf = 4
               IF ( grid(4)<0 ) ngrdf = 3
               DO i = 1 , ngrdf
                  j = grid(i) - 1
                  z(igrid+j) = z(igrid+j) + ngrdf*1000000
               ENDDO
!
!     WRITE 7 WORD RECORD ON FRELM FILE
!
!                  WORD      DESCRIPTION
!
!                  1         FLUID ELEMENT ID
!                  2         MATERIAL FLAG
!                  3-6       FLUID GRID POINTS
!                  7         GRAVITY LOAD ID
!
               z(ielmt+jloc) = card(2)
               CALL write(frelm,z(ielmt+jloc-1),2,0)
               CALL write(frelm,grid,4,0)
               CALL write(frelm,z(ielmt+jloc+5),1,0)
            ENDIF
         ENDIF
!
!     FLAG THE ELEMENT TABLE ENTRY AS BEEN PROCESSED AND CHECK IF
!     THE NEXT ENTRY IS FOR THE SAME FLUID ELEMENT
!
         z(ielmt+jloc) = -2
         IF ( jloc+7>=nelmt .OR. z(ielmt+jloc+6)/=card(1) ) CYCLE SPAG_Loop_1_5
         jloc = jloc + 7
      ENDDO
      EXIT SPAG_Loop_1_5
   ENDDO SPAG_Loop_1_5
!
 1000 CALL close(ect,1)
   CALL close(fbelm,1)
   CALL close(frelm,1)
   mcb(1) = fbelm
   mcb(2) = ngrdt
   mcb(3) = nelm
   CALL wrttrl(mcb)
   mcb(1) = frelm
   CALL wrttrl(mcb)
!
!     MAKE ONE FINAL PASS THROUGH ELEMENT TABLE AND VERIFY THAT
!     EVERY FLUID ELEMENT WAS PROCESSED
!
   lelmt = ielmt + nelmt - 1
   DO i = ielmt , lelmt , 7
      IF ( z(i+1)/=-2 ) THEN
         IF ( z(i+1)==-1 ) THEN
!
            error = .TRUE.
            WRITE (nout,99002) ufm , z(i)
99002       FORMAT (A23,' 8004. ELEMENT ID',I9,' ON A CFFREE CARD DOES NOT ','REFERENCE A VALID FLUID ELEMENT.')
         ELSE
            error = .TRUE.
            WRITE (nout,99003) ufm , z(i)
99003       FORMAT (A23,' 8003. ELEMENT ID',I9,' ON A CFLSTR CARD DOES NOT ','REFERENCE A VALID FLUID ELEMENT.')
         ENDIF
      ENDIF
!
   ENDDO
!
!     ELEMENT TABLE IS NO LONGER NEEDED SO DELETE IT AND RETURN
!
   icore = ielmt
   RETURN
!
!     ERROR CONDITIONS
!
 1100 n = -1
   CALL mesage(n,file,name)
   GOTO 1400
 1200 n = -2
   CALL mesage(n,file,name)
   GOTO 1400
 1300 n = -3
   CALL mesage(n,file,name)
!
!     NO FLUID / STRUCTURE BOUNDARY DEFINED.  FATAL ERROR BECAUSE DMAP
!     CANNOT HANDLE THIS CONDITION
!
 1400 error = .TRUE.
   WRITE (nout,99004) ufm
!
!     ERROR FORMATS
!
99004 FORMAT (A23,' 8001. THERE MUST BE A FLUID/STRUCTURE BOUNDARY IN ','HYDROELASTIC ANALYSIS.')
END SUBROUTINE flbelm