!*==frrd1f.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE frrd1f(Mhh,Bhh,Khh,Frl,Frqset,Nload,Nfreq,Ph,Uhv)
   USE c_system
   USE c_zblpkx
   USE c_zntpkx
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Mhh
   INTEGER :: Bhh
   INTEGER :: Khh
   INTEGER :: Frl
   INTEGER :: Frqset
   INTEGER :: Nload
   INTEGER :: Nfreq
   INTEGER :: Ph
   INTEGER :: Uhv
!
! Local variable declarations rewritten by SPAG
!
   REAL :: cdem , factr , ratio , rdem , w , w2
   INTEGER :: file , i , ib , ibhh , ibuf1 , ibuf2 , ik , ikhh , im , imhh , ip1 , ipnt , iret , j , lhset , matnam
   INTEGER , DIMENSION(7) :: mcb
   INTEGER , DIMENSION(2) , SAVE :: name
   EXTERNAL bldpk , bldpkn , close , fread , gopen , intpk , korsz , makmcb , mesage , open , rdtrl , skprec , wrttrl , zblpki ,    &
          & zntpki
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     ROUTINE  SOLVES DIRECTLY FOR UNCOUPLED MODAL FORMULATION
!
   DATA name/4HFRRD , 4H1F  /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!
         ibuf1 = korsz(core) - sysbuf + 1
!
!     PICK UP FREQUENCY LIST
!
         CALL gopen(Frl,core(ibuf1),0)
         CALL skprec(Frl,Frqset-1)
         IF ( ibuf1-1<Nfreq ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         CALL fread(Frl,core,Nfreq,1)
         CALL close(Frl,1)
!
!     BRING IN  MODAL MATRICES
!
         imhh = Nfreq
         mcb(1) = Mhh
         CALL rdtrl(mcb)
         lhset = mcb(2)
         IF ( ibuf1-1<Nfreq+3*lhset ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DispatchLoop_1
         ENDIF
         ibhh = imhh + lhset
         ikhh = ibhh + lhset
!
!     BRING IN MHH
!
         matnam = Mhh
         ASSIGN 20 TO iret
         ipnt = imhh
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
!
!     BRING  IN  BHH
!
 20      matnam = Bhh
         ASSIGN 40 TO iret
         ipnt = ibhh
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
!
!     BRING IN KHH
!
 40      matnam = Khh
         ASSIGN 60 TO iret
         ipnt = ikhh
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
!
!     READY LOADS
!
 60      CALL gopen(Ph,core(ibuf1),0)
!
!     READY SOLUTIONS
!
         ibuf2 = ibuf1 - sysbuf
         CALL gopen(Uhv,core(ibuf2),1)
         CALL makmcb(mcb,Uhv,lhset,2,3)
!
!     COMPUTE  SOLUTIONS
!
         DO i = 1 , Nload
            DO j = 1 , Nfreq
!
!     PICK  UP  FREQ
!
               w = core(j)
               w2 = -w*w
               CALL bldpk(3,3,Uhv,0,0)
               CALL intpk(*65,Ph,0,3,0)
               DO WHILE ( ieol==0 )
                  CALL zntpki
!
!     COMPUTE  REAL AND COMPLEX PARTS OF DENOMINATOR
!
                  ik = ikhh + ii
                  ib = ibhh + ii
                  im = imhh + ii
                  rdem = w2*core(im) + core(ik)
                  cdem = core(ib)*w
!IBMD DEM  = RDEM*RDEM + CDEM*CDEM
!IBMR IF (DEM .NE. 0.0) GO TO 71
                  IF ( rdem==0.0 .AND. cdem==0.0 ) THEN
                     CALL mesage(5,j,name)
                     b(1) = 0.0
                     b(2) = 0.0
!
!     COMPUTE REAL AND COMPLEX PHI-S
!
!IBMD B(1) = (A(1)*RDEM + A(2)*CDEM)/DEM
!IBMD B(2) = (A(2)*RDEM - A(1)*CDEM)/DEM
!IBMNB
                  ELSEIF ( rdem==0.0 ) THEN
                     ratio = rdem/cdem
                     factr = 1.0/(ratio*rdem+cdem)
                     b(1) = (a(1)*ratio+a(2))*factr
                     b(2) = (a(2)*ratio-a(1))*factr
                  ELSE
                     ratio = cdem/rdem
                     factr = 1.0/(rdem+ratio*cdem)
                     b(1) = (a(1)+a(2)*ratio)*factr
                     b(2) = (a(2)-a(1)*ratio)*factr
                  ENDIF
!IBMNE
                  jj = ii
                  CALL zblpki
               ENDDO
!
!     END  COLUMN
!
 65            CALL bldpkn(Uhv,0,mcb)
            ENDDO
         ENDDO
         CALL close(Uhv,1)
         CALL close(Ph,1)
         CALL wrttrl(mcb)
         RETURN
      CASE (2)
!
!     INTERNAL SUBROUTINE TO BRING IN  H MATRICES
!
         file = matnam
         CALL open(*80,matnam,core(ibuf1),0)
         CALL skprec(matnam,1)
         DO i = 1 , lhset
            ipnt = ipnt + 1
            CALL intpk(*70,matnam,0,1,0)
            CALL zntpki
            IF ( ii/=i .OR. ieol/=1 ) THEN
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            core(ipnt) = a(1)
            CYCLE
!
!     NULL COLUMN
!
 70         core(ipnt) = 0.0
         ENDDO
         CALL close(matnam,1)
         spag_nextblock_1 = 3
      CASE (3)
         GOTO iret
!
!     ZERO CORE FOR PURGED MATRIX
!
 80      DO i = 1 , lhset
            ipnt = ipnt + 1
            core(ipnt) = 0.0
         ENDDO
         spag_nextblock_1 = 3
      CASE (4)
         DO
            ip1 = -8
!
!     ERROR MESAGES
!
            CALL mesage(ip1,file,name)
         ENDDO
         spag_nextblock_1 = 5
      CASE (5)
         ip1 = -7
         CALL mesage(ip1,file,name)
         spag_nextblock_1 = 4
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE frrd1f