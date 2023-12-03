!*==ascm01.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE ascm01(Name,Iphase,Isol,Nogo)
   USE c_asdbd
   USE c_phas11
   USE c_phas31
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Name
   INTEGER :: Iphase
   INTEGER :: Isol
   INTEGER :: Nogo
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , DIMENSION(6,3) , SAVE :: comnd
   INTEGER :: i , icomnd , j , k , l
   INTEGER , DIMENSION(21) , SAVE :: isave
   INTEGER , DIMENSION(3,13) :: oct
   INTEGER , DIMENSION(3,13) , SAVE :: oct1
   INTEGER , DIMENSION(7,16) :: ptbs
   INTEGER , DIMENSION(7,16) , SAVE :: ptbs1
   INTEGER , DIMENSION(18,29) :: rdmap
   INTEGER , DIMENSION(18,9) , SAVE :: rdmap1 , rdmap2 , rdmap3
   INTEGER , DIMENSION(18,2) , SAVE :: rdmap4
   REAL , SAVE :: slash
   INTEGER , DIMENSION(2) , SAVE :: subnam
   INTEGER , DIMENSION(3) , SAVE :: xtra
   EXTERNAL khrfn1 , mesage
!
! End of declarations rewritten by SPAG
!
!
!     SUBSTRUCTURE COMMAND DMAP DATA
!
!     COMMENTS FROM G.CHAN/UNISYS   8/1991
!     IN SOME UNIX MACHINES, SUCH AS SiliconGraphics, THE FORTRAN
!     COMPILER IS A SUBSET OF THE C COMPILER. THE SYMBOL /* IS A COMMENT
!     MARKER FOR C, AND ANYTHING AFTER /* IS NOT PASS OVER TO THE
!     FORTRAN COMPILER. THEREFORE, ALL /* SYMBOLS IN RDMAP ARRAY ARE
!     REPLACED BY
!     THE ! WILL BE CHANGED BACK TO / IN THE EXECUTABLE CODE.
!
   !>>>>EQUIVALENCE (rdmap1(1,1),rdmap(1,1)) , (oct1(1,1),oct(1,1)) , (rdmap2(1,1),rdmap(1,10)) , (ptbs1(1,1),ptbs(1,1)) ,               &
!>>>>    & (rdmap3(1,1),rdmap(1,19)) , (rdmap4(1,1),rdmap(1,28))
   DATA comnd/4HSUBS , 29 , 3 , 13 , 16 , 8 , 4HSUBS , 8 , 1 , 0 , 3 , 0 , 4HSUBS , 8 , 1 , 0 , 3 , 2/
   DATA slash/1H//
   DATA isave/3 , 13 , 1 , 19 , 8 , 2 , 26 , 13 , 3 , 26 , 15 , 2 , 26 , 17 , 1 , 27 , 5 , 1 , 28 , 4 , 3/
   DATA rdmap1/4HALTE , 4HR    , 4H  (B , 4HEGIN , 4H) $  , 13*4H     , 4HPARA , 4HM    , 4H  // , 4H*NOP , 4H*/AL , 4HLWAY ,       &
      & 4HS=-1 , 4H $   , 4H     , 4H     , 8*4H     , 4HSGEN , 4H     , 4H  CA , 4HSECC , 4H,,,/ , 4HCASE , 4HSS,C , 4HASEI ,      &
       &4H,,,, , 4H,,,, , 4H/S,N , 4H,DRY , 4H!*XX , 4HXXXX , 4HXX*/ , 4HS,N, , 4HLUSE , 4HT/   , 4H     , 4H     , 4H  S, ,        &
      & 4HN,NO , 4HGPDT , 4H $   , 12*4H     , 4HEQUI , 4HV    , 4H  CA , 4HSEI, , 4HCASE , 4HCC/A , 4HLLWA , 4HYS $ , 4H     ,     &
       &4H     , 8*4H     , 4HALTE , 4HR    , 4H  (A , 4HFTGP , 4H4) $ , 13*4H     , 4HPARA , 4HM    , 4H  // , 4H*ADD , 4H*/DR ,   &
       &4HY/-1 , 4H /0  , 4H$    , 4H     , 4H     , 8*4H     , 4HLABE , 4HL    , 4H  LB , 4HSBEG , 4H $   , 13*4H     , 4HCOND ,   &
       &4H     , 4H  LB , 4HLIS, , 4HDRY  , 4H$    , 12*4H    /
   DATA rdmap2/4HSSG1 , 4H     , 4H  SL , 4HT,BG , 4HPDT, , 4HCSTM , 4H,SIL , 4H,EST , 4H,MPT , 4H,GPT , 4HT,ED , 4HT,MG , 4HG,CA , &
       &4HSECC , 4H,DIT , 4H,/PG , 4H,,,, , 4H/    , 4H     , 4H     , 4H  LU , 4HSET/ , 4HNSKI , 4HP $  , 12*4H     , 4HCHKP ,     &
       &4HNT   , 4H  PG , 4H $   , 14*4H     , 4HALTE , 4HR    , 4H  (S , 4HOLVE , 4H) $  , 13*4H     , 4HSSG2 , 4H     , 4H  US ,  &
       &4HET,G , 4HM,,K , 4HFS,G , 4HO,,P , 4HG/QR , 4H,PO, , 4HPS,P , 4HL $  , 7*4H     , 4HCHKP , 4HNT   , 4H  PO , 4H,PS, ,      &
       &4HPL $ , 13*4H     , 4HLABE , 4HL    , 4H  LB , 4HLIS  , 4H$    , 13*4H     , 4HALTE , 4HR    , 4H  (S , 4HDR)  , 4H$    ,  &
      & 13*4H     , 4HSUBP , 4HH1   , 4H  CA , 4HSECC , 4H,EQE , 4HXIN, , 4HUSET , 4H,BGP , 4HDT,C , 4HSTM, , 4HGPSE , 4HTS,E ,     &
       &4HLSET , 4HS//S , 4H,N,D , 4HRY/  , 4H     , 4H    /
   DATA rdmap3/4H     , 4H     , 4H  *N , 4HAME  , 4H   * , 4H/XPL , 4HOTID , 4H !*P , 4HVEC* , 4H $   , 8*4H     , 4HCOND ,        &
      & 4H     , 4H  LB , 4HSEND , 4H,DRY , 4H $   , 12*4H     , 4HEQUI , 4HV    , 4H  PG , 4H,PL/ , 4HNOSE , 4HT $  , 12*4H     ,  &
       &4HCOND , 4H     , 4H  LB , 4HL10, , 4HNOSE , 4HT $  , 12*4H     , 4HSSG2 , 4H     , 4H  US , 4HET,G , 4HM,YS , 4H,KFS ,     &
       &4H,GO, , 4H,PG/ , 4HQR,P , 4HO,PS , 4H,PL  , 4H$    , 6*4H     , 4HCHKP , 4HNT   , 4H  PO , 4H,PS, , 4HPL $ , 13*4H     ,   &
       &4HLABE , 4HL    , 4H  LB , 4HL10  , 4H$    , 13*4H     , 4HSOFO , 4H     , 4H  ,K , 4HAA,M , 4HAA,P , 4HL,BA , 4HA,K4 ,     &
       &4HAA// , 4HS,N, , 4HDRY/ , 4H*XXX , 4HXXXX , 4HX*!* , 4HKMTX , 4H*!*M , 4HMTX* , 4H!*PV , 4HEC*/ , 4H     , 4H     ,        &
      & 4H  *B , 4HMTX* , 4H!*K4 , 4HMX*  , 4H$    , 4H     , 4H     , 4H     , 8*4H    /
   DATA rdmap4/4HLODA , 4HPP   , 4H  PL , 4H,/!* , 4HNAME , 4H     , 4H*/S, , 4HN,DR , 4HY $  , 4H     , 8*4H     , 4HEQUI ,        &
      & 4HV    , 4H  CA , 4HSESS , 4H,CAS , 4HECC/ , 4HALWA , 4HYS $ , 4H     , 4H     , 8*4H    /
   DATA xtra/4HSAVE , 4HNAME , 4HRUN /
   DATA oct1/9 , 524288 , 0 , 10 , 983040 , 12 , 11 , 983040 , 12 , 12 , 983040 , 12 , 14 , 983040 , 12 , 15 , 983040 , 12 , 16 ,   &
      & 524288 , 0 , 21 , 1572864 , 12 , 22 , 1572864 , 12 , 23 , 1572864 , 12 , 24 , 1572864 , 12 , 25 , 1572864 , 12 , 28 ,       &
      & 524288 , 8/
   DATA ptbs1/1 , 11 , 11 , 7 , 4 , 0 , 0 , 6 , 11 , 11 , 8 , 1 , 0 , 0 , 7 , 22 , 23 , 3 , 4HRUN  , 0 , 0 , 13 , 11 , 11 , 7 , 2 , &
      & 0 , 0 , 17 , 11 , 11 , 5 , 3 , 0 , 0 , 19 , 11 , 12 , 8 , 4HNAME , 0 , 0 , 19 , 21 , 22 , 8 , 4HSAVE , 0 , 0 , 19 , 30 ,    &
      & 32 , 4 , 4HPITM , 524300 , 0 , 26 , 12 , 15 , 0 , 4HNAME , 1 , 0 , 26 , 16 , 19 , 0 , 4HNAME , 2 , 0 , 26 , 20 , 22 , 0 ,   &
       &4HNAME , 12 , 0 , 26 , 23 , 26 , 0 , 4HNAME , 16 , 0 , 26 , 27 , 31 , 0 , 4HNAME , 32 , 0 , 26 , 40 , 42 , 8 , 4HNAME , 0 , &
      & 0 , 26 , 65 , 67 , 4 , 4HPITM , 524288 , 0 , 28 , 15 , 17 , 8 , 4HNAME , 0 , 0/
   DATA subnam/4HASCM , 2H01/
!
!     RESTORE ORIGINAL DATA BY REPLACING ! BY / IN RDMAP
!
   DO l = 1 , 21 , 3
      i = isave(l+1)
      j = isave(l)
      k = isave(l+2)
      rdmap(i,j) = khrfn1(rdmap(i,j),k,slash,1)
   ENDDO
!
!     VALIDATE COMMAND AND SET POINTERS
!
   IF ( Name/=comnd(1,Iphase) ) THEN
!
!     INPUT ERROR
!
      CALL mesage(7,0,subnam)
      Nogo = 1
      RETURN
   ELSE
      icomnd = Iphase
      irdm = 1
      nrdm = comnd(2,icomnd)
      ixtra = irdm + 18*nrdm
      nxtra = comnd(3,icomnd)
      ioct = ixtra + nxtra
      noct = comnd(4,icomnd)
      iptbs = ioct + 3*noct
      nptbs = comnd(5,icomnd)
      iph = iptbs + 7*nptbs
      nph = comnd(6,icomnd)
!
!     MOVE RDMAP DATA
!
      k = 0
      IF ( nrdm/=0 ) THEN
         DO j = 1 , nrdm
            DO i = 1 , 18
               k = k + 1
               idat(k) = rdmap(i,j)
            ENDDO
         ENDDO
      ENDIF
!
!      MOVE XTRA DATA
!
      IF ( nxtra/=0 ) THEN
         DO i = 1 , nxtra
            k = k + 1
            idat(k) = xtra(i)
         ENDDO
      ENDIF
!
!     MOVE OCT DATA
!
      IF ( noct/=0 ) THEN
         DO j = 1 , noct
            DO i = 1 , 3
               k = k + 1
               idat(k) = oct(i,j)
            ENDDO
         ENDDO
      ENDIF
!
!     MOVE PTBS DATA
!
      IF ( nptbs/=0 ) THEN
         DO j = 1 , nptbs
            DO i = 1 , 7
               k = k + 1
               idat(k) = ptbs(i,j)
            ENDDO
         ENDDO
      ENDIF
!
!     MOVE PHASE 1 DATA
!
      IF ( Iphase==1 .AND. nph/=0 ) THEN
         DO i = 3 , 8
            k = k + 1
            idat(k) = ipas11(i)
         ENDDO
         DO i = 1 , 2
            k = k + 1
            idat(k) = ipas11(i)
         ENDDO
!
!     MOVE PHASE 3 DATA
!
      ELSEIF ( Iphase==3 .AND. nph/=0 ) THEN
         DO i = 1 , nph
            k = k + 1
            idat(k) = ipas31(i)
         ENDDO
      ENDIF
   ENDIF
!
!
END SUBROUTINE ascm01