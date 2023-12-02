!*==cyct2.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE cyct2
   USE c_blank
   USE c_condad
   USE c_packx
   USE c_system
   USE c_unpakx
   USE c_zblpkx
   USE c_zzzzzz
   USE iso_fortran_env
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   REAL(REAL64) :: arg , cos , pi , sin
   INTEGER , SAVE :: cycd , fore , kaa , kxx , lama , lamx , maa , mxx , scr1 , scr2 , scr3 , scr4 , scr5 , scr6 , v1i , v1o , v2i ,&
                   & v2o
   INTEGER :: file , i , ibuf1 , ibuf2 , ibuf3 , ibuf4 , ibuf5 , ics , idir , iflag , igc , iks , ilama , ip , ip1 , ipass , iprec ,&
            & ityp , j , kindex , l , lua , mm , ncopy , nlps , nskip , nx , nz , sysbuf
   INTEGER , DIMENSION(1) :: iz
   INTEGER , DIMENSION(14) :: mcb
   INTEGER , DIMENSION(7) :: mcb1 , mcb2
   INTEGER , DIMENSION(2) , SAVE :: name
   EXTERNAL bldpk , bldpkn , close , cyct2a , cyct2b , fread , fwdrec , gopen , korsz , makmcb , mesage , rdtrl , read , rewind ,   &
          & skpfil , ssg2b , write , wrttrl , zblpki
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     CYCT2 TRANSFORMS CYCLIC PROBLEMS BETWEEN SOLUTION VARIABLES AND
!     THE CYCLIC COMPONENTS
!
!     INPUT DATA BLOCKS - CYCD    CYCLIC COMPONENT CONSTRAINT DATA
!     INPUT DATA BLOCKS - KAA     MATRIX - STIFFNESS    MAY BE PURGED
!     INPUT DATA BLOCKS - MAA     MATRIX - MASS         MAY BE PURGED
!     INPUT DATA BLOCKS - V1I     MATRIX - LOAD OR DISP MAY BE PURGED
!     INPUT DATA BLOCKS - V2I     MATRIX - EIGENVECTORS MAY BE PURGED
!     INPUT DATA BLOCKS - LAMX    TABLE  - EIGENVALUES MUST EXIS IF V2I
!
!     OUTPUT DATA BLOCKS- KXX,MXX,V1O,V2O,LAMA
!
!     PARAMETERS - CDIR           INPUT,  BCD, (FORE OR BACK)
!     PARAMETERS - NSEG           INPUT,  INTEGER,NUMBER OF SEGS
!     PARAMETERS - KSEG           INPUT,  INTEGER,CYCLIC INDEX
!     PARAMETERS - CYCSEQ         INPUT,  INTEGER,ALTERNATE=-1
!     PARAMETERS - NLOAD          INPUT,  INTEGER,NUMBER OF LOAD COND
!     PARAMETERS - NOGO           OUTPUT, INTEGER,-1 = ERROR
!
!     SCRATCH FILES (6)
!
!     DEFINITION OF VARIABLES
!     LUA       LENGT OF A SET
!     ITYP      TYPE (0=ROT, 1=DIH)
!     IDIR      DIRECTION (0=FORE, 1=BACK)
!     IFLAG     1 IMPLIES KSEG = 0 OR 2*KSEG = NSEG
!     IPASS     1 IMPLIES SECOND PASS TRROUGH CYCD
!     IGC       1 IMPLIES FIRST MATRIX TYPE (GC FOR ROT)
!     ICS       1 IMPLIES FIRST COLUMN TYPE (COSINE FOR ROT)
!
!
   !>>>>EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(55),Iprec) , (Constd(1),Pi) , (Kseg,Kindex) , (Z(1),Iz(1)) , (mcb(1),mcb1(1)) ,         &
!>>>>    & (mcb(8),mcb2(1))
   DATA cycd , kaa , maa , v1i , v2i , lamx , kxx , mxx , v1o , v2o , lama/101 , 102 , 103 , 104 , 105 , 106 , 201 , 202 , 203 ,    &
      & 204 , 205/
   DATA scr1 , scr2 , scr3 , scr4 , scr5 , scr6/301 , 302 , 303 , 304 , 305 , 306/
   DATA name , fore/4HCYCT , 4H2    , 4HFORE/
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!
!IBMNB 6/93
         cycd = 101
         kaa = 102
         maa = 103
         v1i = 104
         v2i = 105
         lamx = 106
         kxx = 201
         mxx = 202
         v1o = 203
         v2o = 204
         lama = 205
         scr1 = 301
         scr2 = 302
         scr3 = 303
         scr4 = 304
         scr5 = 305
         scr6 = 306
!IBMNE
         nz = korsz(iz)
         nogo = 1
         v1i = 104
         v1o = 203
         scr3 = 303
         mcb(1) = cycd
         CALL rdtrl(mcb)
         lua = mcb(3)
         ityp = mcb(2) - 1
         idir = 1
         IF ( cdir(1)==fore ) idir = 0
         nx = nz
         ibuf1 = nz - sysbuf + 1
         ibuf2 = ibuf1 - sysbuf
         ibuf3 = ibuf2 - sysbuf
         nz = ibuf3 - 1
         IF ( 2*kseg>nseg .OR. kseg<0 .OR. nseg<=0 ) THEN
            spag_nextblock_1 = 15
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         j = 2
         IF ( mcb(5)==4 ) j = 4
         IF ( nz<j*lua ) CALL mesage(-8,0,name)
!
!     PRODUCE GC AND GS MATRICES (ON SCR1 AND SCR2)
!
         arg = float(kseg)/float(nseg)
         arg = arg*pi
         IF ( ityp==0 ) arg = 2.0D0*arg
!
!     BRING IN CYCD
!
         CALL gopen(cycd,iz(ibuf1),0)
         CALL fread(cycd,iz(1),lua,1)
         CALL close(cycd,1)
         CALL gopen(scr1,iz(ibuf1),1)
!
!     COMPUTE COS AND SIN
!
         IF ( ityp==0 ) THEN
            IF ( kseg/=0 ) THEN
               IF ( 2*kseg/=nseg ) THEN
                  spag_nextblock_1 = 2
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
               cos = -1.0
               sin = 0.0
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ELSEIF ( kseg/=0 ) THEN
            IF ( 2*kseg/=nseg ) THEN
               spag_nextblock_1 = 2
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            cos = 0.0
            sin = 1.0
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         cos = 1.0
         sin = 0.0
         spag_nextblock_1 = 3
      CASE (2)
         cos = dcos(arg)
         sin = dsin(arg)
         spag_nextblock_1 = 3
      CASE (3)
         iflag = 0
         IF ( kseg==0 .OR. 2*kseg==nseg ) iflag = 1
         IF ( ityp/=0 .OR. iflag==0 ) CALL gopen(scr2,iz(ibuf2),1)
         ita = 2
         itb = 1
         incr = 1
         ii = 1
         jj = lua
         CALL makmcb(mcb1,scr1,lua,2,iprec)
         CALL makmcb(mcb2,scr2,lua,2,iprec)
         CALL wrttrl(mcb1)
         CALL wrttrl(mcb2)
         ipass = 0
         IF ( ityp/=0 ) THEN
!
!     BUILD DIHEDRAL MATRICES
!
            ipass = 0
            l = 1
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ELSE
!
!     BUILD ROTATIONAL MATRICES
!
            l = 1
         ENDIF
         spag_nextblock_1 = 4
      CASE (4)
         IF ( iz(l)>=0 ) THEN
            mm = iz(l)
            ip = 1
!
!     FIRST BUILD GC
!
            igc = 1
            file = scr1
!
!     FIRST DO COSINE
!
            ics = 1
            IF ( ipass/=0 ) ics = 0
            SPAG_Loop_1_1: DO
!
!     BUILD COLUMN
!
               CALL bldpk(2,iprec,file,0,0)
               IF ( mm>=0 ) THEN
                  IF ( mm/=0 ) THEN
!
!     SIDE 1 POINTS
!
                     IF ( ics/=0 ) THEN
!
!     COSINE COLUMN
!
                        IF ( igc==0 ) THEN
!
!     MATRIX IS GS
!
                           iii = mm
                           dz(1) = -sin
                           CALL zblpki
!
!     MATRIX IS GC
!
                           GOTO 2
                        ENDIF
!
!     SINE COLUMN
!
                     ELSEIF ( igc/=0 ) THEN
!
!     MATRIX IS GC
!
                        iii = mm
                        dz(1) = sin
                        CALL zblpki
                        GOTO 2
                     ENDIF
!
!     MATRIX IS GS
!
                     IF ( l>mm ) THEN
                        iii = mm
                        dz(1) = cos
                        CALL zblpki
                        iii = l
                        dz(1) = 1.0
                        CALL zblpki
                     ELSE
                        dz(1) = 1.0
                        iii = l
                        CALL zblpki
                        dz(1) = cos
                        iii = mm
                        CALL zblpki
                     ENDIF
!
!     INTERIOR POINT
!
                  ELSEIF ( .NOT.((ics==0 .AND. igc==1) .OR. (ics==1 .AND. igc==0)) ) THEN
                     iii = l
                     dz(1) = 1.0
                     CALL zblpki
                  ENDIF
 2                CALL bldpkn(file,0,mcb(ip))
                  IF ( cycseq/=1 ) THEN
!
!     NOW DO SINE COLUMN
!
                     IF ( ics/=0 ) THEN
                        IF ( iflag==1 ) EXIT SPAG_Loop_1_1
                        ics = 0
                        CYCLE
                     ENDIF
                  ENDIF
!
!     NOW DO GS
!
                  IF ( iflag/=1 .AND. ip/=8 ) THEN
                     ip = 8
                     igc = 0
                     ics = 1
                     file = scr2
                     CYCLE
                  ENDIF
               ENDIF
               EXIT SPAG_Loop_1_1
            ENDDO SPAG_Loop_1_1
         ENDIF
!
!     CONSIDER NEXT CYCD VALUE
!
         l = l + 1
         IF ( l<=lua ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     GONE THRU CYCD ONCE. DONE IF CYCSEQ = -1
!
         IF ( cycseq==-1 ) THEN
            spag_nextblock_1 = 9
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     MUST NOW DO SINE COLUMNS UNLESS IFLAG = 1
!
         IF ( ipass==1 ) THEN
            spag_nextblock_1 = 9
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         IF ( iflag==1 ) THEN
            spag_nextblock_1 = 9
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ipass = 1
         l = 1
         spag_nextblock_1 = 4
      CASE (5)
         ip = 1
         igc = 1
         file = scr1
!
!     FIRST DO S COLUMN
!
         ics = 1
         IF ( ipass/=0 ) ics = 0
         mm = iz(l)
         IF ( mm>0 .AND. ipass==1 ) THEN
            spag_nextblock_1 = 8
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         spag_nextblock_1 = 6
      CASE (6)
         CALL bldpk(2,iprec,file,0,0)
         IF ( mm>0 ) THEN
!
!     SIDE POINT
!
            IF ( igc==0 ) THEN
!
!     MATRIX IS GA
!
               iii = l
               IF ( mm==2 ) THEN
                  dz(1) = cos
                  CALL zblpki
               ELSEIF ( mm==3 ) THEN
               ELSEIF ( mm==4 ) THEN
                  GOTO 10
               ELSE
                  dz(1) = sin
                  CALL zblpki
               ENDIF
!
!     MATRIX IS GS
!
            ELSEIF ( mm==2 ) THEN
               iii = l
               dz(1) = -sin
               CALL zblpki
            ELSEIF ( mm==3 ) THEN
               iii = l
               GOTO 10
            ELSEIF ( mm/=4 ) THEN
               iii = l
               dz(1) = cos
               CALL zblpki
            ENDIF
            spag_nextblock_1 = 7
            CYCLE SPAG_DispatchLoop_1
 10         dz(1) = 1.0
            CALL zblpki
         ELSE
!
!     INTERIOR POINT
!
            IF ( ics/=0 ) THEN
!
!     SCOLUMN
!
!
!     MATRIX IS GA - S COLUMN
!
!
!     MATRIX IS GS - COLUMN IS S
!
               IF ( igc==0 ) THEN
                  spag_nextblock_1 = 7
                  CYCLE SPAG_DispatchLoop_1
               ENDIF
!
!     A COLUMN
!
            ELSEIF ( igc/=0 ) THEN
               spag_nextblock_1 = 7
               CYCLE SPAG_DispatchLoop_1
            ENDIF
!
!     MATRIX IS GA  - COLUMN IS A
!
            dz(1) = 1.0
            iii = l
!
!     MATRIX IS GS - COLUMN IS A
!
            CALL zblpki
         ENDIF
         spag_nextblock_1 = 7
      CASE (7)
         CALL bldpkn(file,0,mcb(ip))
         IF ( cycseq/=1 .AND. mm<=0 ) THEN
!
!     NOW DO A COLUMN
!
            IF ( ics/=0 ) THEN
               ics = 0
               spag_nextblock_1 = 6
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
!
!     NOW DO GA
!
         IF ( ip/=8 ) THEN
            ip = 8
            igc = 0
            file = scr2
            ics = 1
            spag_nextblock_1 = 6
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         spag_nextblock_1 = 8
      CASE (8)
!
!     CONSIDER NEXT CYCD VALUE
!
         l = l + 1
         IF ( l<=lua ) THEN
            spag_nextblock_1 = 5
            CYCLE SPAG_DispatchLoop_1
         ENDIF
!
!     GONE THRU CYCD ONCE - DONE IF CYCSEQ = -1
!
         IF ( cycseq/=-1 ) THEN
!
!     NOW DO A COLUMNS
!
            IF ( ipass/=1 ) THEN
               ipass = 1
               l = 1
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ENDIF
         ENDIF
         spag_nextblock_1 = 9
      CASE (9)
!
!     CLOSE UP SHOP
!
         CALL close(scr1,1)
         CALL close(scr2,1)
         CALL wrttrl(mcb1)
         IF ( iflag==0 .OR. ityp/=0 ) CALL wrttrl(mcb2)
         itc = 1
         iik = 1
         jjk = lua
         incr1 = 1
         IF ( idir/=0 ) THEN
!
!     DIRECTION IS BACK
!
            mcb(1) = v1i
            CALL rdtrl(mcb)
            IF ( mcb(1)<=0 ) THEN
               spag_nextblock_1 = 14
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            iks = mcb(3)
            itc = mcb(5)
            IF ( itc==4 .AND. nz<4*lua ) CALL mesage(-8,0,name)
!
!     POSITION V1O
!
            mcb(1) = v1o
            IF ( kindex==0 ) THEN
               spag_nextblock_1 = 12
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            CALL rdtrl(mcb)
            IF ( mcb(2)<=0 ) THEN
               spag_nextblock_1 = 12
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            CALL gopen(v1o,iz(ibuf1),0)
            CALL skpfil(v1o,+1)
            CALL skpfil(v1o,-1)
            CALL close(v1o,2)
            spag_nextblock_1 = 13
            CYCLE SPAG_DispatchLoop_1
         ELSE
!
!     FORWARD TRANSFORMATIONS
!
!
!     TRANSFORM MATRICES
!
            CALL cyct2a(kaa,kxx,scr1,scr2,scr3,scr4,scr5)
            CALL cyct2a(maa,mxx,scr1,scr2,scr3,scr4,scr5)
!
            mcb1(1) = kaa
            mcb2(1) = maa
            CALL rdtrl(mcb1(1))
            CALL rdtrl(mcb2(1))
            IF ( mcb1(5)<=2 .AND. mcb2(5)<=2 ) THEN
               IF ( mcb1(4)==6 .OR. mcb2(4)==6 ) THEN
                  mcb1(1) = kxx
                  mcb2(1) = mxx
                  CALL rdtrl(mcb1(1))
                  CALL rdtrl(mcb2(1))
                  mcb1(4) = 6
                  mcb2(4) = 6
                  IF ( mcb1(1)>0 ) CALL wrttrl(mcb1(1))
                  IF ( mcb2(1)>0 ) CALL wrttrl(mcb2(1))
               ENDIF
            ENDIF
!
!     TRANSFORM LOADS
!
            mcb(1) = v1i
            CALL rdtrl(mcb(1))
            IF ( mcb(1)<=0 ) THEN
               spag_nextblock_1 = 11
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            itc = mcb(5)
            IF ( itc==4 .AND. nz<4*lua ) CALL mesage(-8,0,name)
            CALL gopen(v1i,iz(ibuf1),0)
            CALL gopen(scr3,iz(ibuf2),1)
            CALL gopen(scr4,iz(ibuf3),1)
!
!     COMPUTE NUMBER OF RECORDS TO SKIP
!
            CALL makmcb(mcb1,scr3,lua,2,mcb(5))
            CALL makmcb(mcb2,scr4,lua,2,mcb(5))
            IF ( kseg/=0 ) THEN
               nskip = nload*kseg*(ityp+1)*2 - nload*(ityp+1)
               file = v1i
               DO i = 1 , nskip
                  CALL fwdrec(*20,v1i)
               ENDDO
            ENDIF
            CALL cyct2b(v1i,scr3,nload,iz,mcb1)
            IF ( ityp/=0 ) THEN
               IF ( iflag==0 ) THEN
!
!     COPY - PCA
!
                  DO j = 1 , nload
                     CALL fwdrec(*20,v1i)
                  ENDDO
                  CALL cyct2b(v1i,scr3,nload,iz,mcb1)
               ENDIF
            ENDIF
!
!     NOW COPY ONTO PS
!
            IF ( ityp/=0 .OR. iflag==0 ) THEN
               CALL cyct2b(v1i,scr4,nload,iz,mcb2)
               IF ( iflag==0 ) THEN
                  IF ( ityp/=0 ) THEN
                     CALL rewind(v1i)
                     CALL fwdrec(*20,v1i)
                     nlps = nskip + nload
                     DO j = 1 , nlps
                        CALL fwdrec(*20,v1i)
                     ENDDO
                     itc = -mcb(5)
                     CALL cyct2b(v1i,scr4,nload,iz,mcb2)
                     itc = mcb(5)
                  ENDIF
               ENDIF
            ENDIF
         ENDIF
         spag_nextblock_1 = 10
      CASE (10)
!
!     DONE WITH COPY
!
         CALL close(v1i,1)
         CALL close(scr3,1)
         CALL close(scr4,1)
         CALL wrttrl(mcb1)
         CALL wrttrl(mcb2)
         IF ( iflag/=0 .AND. ityp==0 ) THEN
!
!     NO GS
!
            CALL ssg2b(scr1,scr3,0,v1o,1,iprec,1,scr5)
         ELSE
            CALL ssg2b(scr1,scr3,0,scr5,1,iprec,1,v1o)
            CALL ssg2b(scr2,scr4,scr5,v1o,1,iprec,1,scr3)
         ENDIF
         spag_nextblock_1 = 11
      CASE (11)
         DO
!
!     TRANSFORM EIGENVECTORS FORWARD
!
            IF ( v1o==v2o ) RETURN
            mcb(1) = v2i
            CALL rdtrl(mcb)
            IF ( mcb(1)<=0 ) RETURN
            itc = mcb(5)
            IF ( itc==4 .AND. nz<4*lua ) CALL mesage(-8,0,name)
            IF ( mod(mcb(2),2)/=2 ) CALL mesage(-7,0,name)
            IF ( iflag/=1 .OR. ityp/=0 ) THEN
               CALL gopen(v2i,iz(ibuf1),0)
               CALL gopen(scr3,iz(ibuf2),1)
               CALL gopen(scr4,iz(ibuf3),1)
               ncopy = mcb(2)
               CALL makmcb(mcb1,scr3,lua,2,mcb(5))
               CALL makmcb(mcb2,scr4,lua,2,mcb(5))
               DO i = 1 , ncopy
                  file = scr3
                  ip = 1
                  IF ( mod(i,2)==0 ) ip = 8
                  IF ( mod(i,2)==0 ) file = scr4
                  CALL cyct2b(v2i,file,1,iz,mcb(ip))
               ENDDO
               v1o = v2o
               v1i = v2i
               spag_nextblock_1 = 10
               CYCLE SPAG_DispatchLoop_1
            ELSE
!
!     IN = OUT
!
               v1o = v2o
               scr3 = v1i
               CALL ssg2b(scr1,scr3,0,v1o,1,iprec,1,scr5)
            ENDIF
         ENDDO
         spag_nextblock_1 = 12
      CASE (12)
         CALL gopen(v1o,iz(ibuf1),1)
         CALL close(v1o,2)
         CALL makmcb(mcb,v1o,lua,2,mcb(5))
         CALL wrttrl(mcb)
         spag_nextblock_1 = 13
      CASE (13)
         IF ( ityp==0 ) THEN
!
!     DO ROTATIONAL OR SPECIAL CASE DIH
!
            scr3 = v1i
!
!     DISTRIBUTE UX1 AND UX2 FOR MULTIPLYS
!
         ELSEIF ( iflag==1 ) THEN
            scr3 = v1i
         ELSE
            CALL makmcb(mcb1,scr3,iks,2,mcb(5))
            CALL makmcb(mcb2,scr4,iks,2,mcb(5))
            CALL gopen(v1i,iz(ibuf1),0)
            CALL gopen(scr3,iz(ibuf2),1)
            CALL gopen(scr4,iz(ibuf3),1)
            CALL cyct2b(v1i,scr3,nload,iz(1),mcb1)
            CALL cyct2b(v1i,scr4,nload,iz(1),mcb2)
            CALL close(scr3,1)
            CALL wrttrl(mcb1)
            CALL close(scr4,1)
            CALL wrttrl(mcb2)
            CALL close(v1i,1)
         ENDIF
!
!     COMPUTE UCS
!
         CALL ssg2b(scr1,scr3,0,scr5,0,iprec,1,scr6)
         CALL gopen(v1o,iz(ibuf1),3)
         CALL gopen(scr5,iz(ibuf2),0)
         mcb(1) = v1o
         CALL rdtrl(mcb(1))
         CALL cyct2b(scr5,v1o,nload,iz(1),mcb)
         IF ( ityp/=0 .OR. iflag==0 ) THEN
            CALL close(v1o,2)
            CALL close(scr5,1)
            IF ( ityp/=0 .AND. iflag==0 ) THEN
!
!     COMPUTE UCA
!
               CALL ssg2b(scr2,scr4,0,scr5,0,iprec,0,scr6)
               CALL gopen(v1o,iz(ibuf1),3)
               CALL gopen(scr5,iz(ibuf2),0)
               CALL cyct2b(scr5,v1o,nload,iz(1),mcb)
               CALL close(v1o,2)
               CALL close(scr5,1)
!
!     COMPUTE USS
!
               CALL ssg2b(scr1,scr4,0,scr5,0,iprec,1,scr6)
               CALL gopen(v1o,iz(ibuf1),3)
               CALL gopen(scr5,iz(ibuf2),0)
               CALL cyct2b(scr5,v1o,nload,iz(1),mcb)
               CALL close(scr5,1)
               CALL close(v1o,2)
            ENDIF
!
!     COMPUTE USA
!
            CALL ssg2b(scr2,scr3,0,scr5,0,iprec,1,scr6)
            CALL gopen(v1o,iz(ibuf1),3)
            CALL gopen(scr5,iz(ibuf2),0)
            CALL cyct2b(scr5,v1o,nload,iz(1),mcb)
         ENDIF
         CALL close(scr5,1)
         CALL close(v1o,1)
         CALL wrttrl(mcb)
         spag_nextblock_1 = 14
      CASE (14)
!
!     SEE IF DONE
!
         mcb(1) = v2i
         CALL rdtrl(mcb)
         IF ( mcb(1)<=0 ) RETURN
         scr3 = 303
         itc = mcb(5)
         IF ( itc==4 .AND. nz<4*lua ) CALL mesage(-8,0,name)
!
!     NOW DO EIGENVECTORS
!
!
!     COMPUTE NEW VECTORS
!
         CALL ssg2b(scr1,v2i,0,scr3,0,iprec,1,scr5)
         IF ( ityp/=0 .OR. iflag/=1 ) CALL ssg2b(scr2,v2i,0,scr4,0,iprec,1,scr5)
!
!     POSITION FILES
!
!
!      SET LAMA FLAG
!
         mcb(1) = lamx
         CALL rdtrl(mcb)
         ilama = 0
         IF ( mcb(1)<=0 ) ilama = 1
         CALL gopen(v2o,iz(ibuf1),1)
         IF ( ilama==0 ) THEN
            CALL gopen(lama,iz(ibuf2),1)
            file = lamx
            CALL gopen(lamx,iz(ibuf3),0)
            CALL read(*20,*40,lamx,iz(1),146,1,iflag)
            CALL write(lama,iz(1),146,1)
         ENDIF
         mcb(1) = v2i
         CALL rdtrl(mcb)
         nload = mcb(2)
         CALL makmcb(mcb,v2o,lua,2,mcb(5))
         ibuf4 = ibuf3 - sysbuf
         CALL gopen(scr3,iz(ibuf4),0)
         IF ( ityp/=0 .OR. iflag/=1 ) THEN
            ibuf5 = ibuf4 - sysbuf
            CALL gopen(scr4,iz(ibuf5),0)
         ENDIF
         DO i = 1 , nload
            CALL cyct2b(scr3,v2o,1,iz(1),mcb)
            IF ( ilama==0 ) THEN
               CALL read(*20,*40,lamx,iz(1),7,0,iflag)
               CALL write(lama,iz(1),7,0)
            ENDIF
            IF ( ityp/=0 .OR. iflag/=1 ) THEN
               IF ( ilama==0 ) CALL write(lama,iz(1),7,0)
               CALL cyct2b(scr4,v2o,1,iz(1),mcb)
            ENDIF
         ENDDO
         CALL wrttrl(mcb)
         CALL close(v2o,1)
         CALL close(scr3,1)
         CALL close(scr4,1)
         IF ( ilama==0 ) THEN
            CALL close(lama,1)
            CALL close(lamx,1)
            mcb(1) = lama
            CALL wrttrl(mcb)
         ENDIF
!
!     DONE
!
         RETURN
 20      ip1 = -2
!
!     ERROR MESSAGES
!
! 600 IP1 = -1
         CALL mesage(ip1,file,name)
         spag_nextblock_1 = 15
         CYCLE SPAG_DispatchLoop_1
 40      ip1 = -3
         CALL mesage(ip1,file,name)
         spag_nextblock_1 = 15
      CASE (15)
         CALL mesage(7,0,name)
         nogo = -1
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE cyct2
