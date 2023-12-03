!*==ascm13.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE ascm13(Name,Iphase,Isol,Nogo)
   USE c_asdbd
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
   INTEGER , DIMENSION(6,1) , SAVE :: comnd
   INTEGER :: i , icomnd , j , k , l
   INTEGER , DIMENSION(39) , SAVE :: isave
   INTEGER , DIMENSION(3,20) :: oct
   INTEGER , DIMENSION(3,18) , SAVE :: oct1
   INTEGER , DIMENSION(3,2) , SAVE :: oct2
   INTEGER , DIMENSION(7,53) :: ptbs
   INTEGER , DIMENSION(7,18) , SAVE :: ptbs1 , ptbs2
   INTEGER , DIMENSION(7,17) , SAVE :: ptbs3
   INTEGER , DIMENSION(18,30) :: rdmap
   INTEGER , DIMENSION(18,9) , SAVE :: rdmap1 , rdmap2 , rdmap3
   INTEGER , DIMENSION(18,3) , SAVE :: rdmap4
   REAL , SAVE :: slash
   INTEGER , DIMENSION(2) , SAVE :: subnam
   INTEGER , DIMENSION(11) , SAVE :: xtra
   EXTERNAL khrfn1 , mesage
!
! End of declarations rewritten by SPAG
!
!
!     CREDUCE COMMAND DMAP DATA
!
   !>>>>EQUIVALENCE (rdmap1(1,1),rdmap(1,1)) , (oct1(1,1),oct(1,1)) , (rdmap2(1,1),rdmap(1,10)) , (oct2(1,1),oct(1,19)) ,                &
!>>>>    & (rdmap3(1,1),rdmap(1,19)) , (ptbs1(1,1),ptbs(1,1)) , (rdmap4(1,1),rdmap(1,28)) , (ptbs2(1,1),ptbs(1,19)) ,                    &
!>>>>    & (ptbs3(1,1),ptbs(1,37))
   DATA comnd/4HCRED , 30 , 11 , 20 , 53 , 0/
   DATA slash/1H//
   DATA isave/2 , 15 , 1 , 3 , 11 , 2 , 5 , 12 , 1 , 5 , 16 , 3 , 6 , 5 , 1 , 23 , 8 , 1 , 23 , 9 , 1 , 23 , 10 , 1 , 24 , 8 , 1 ,  &
      & 24 , 9 , 1 , 24 , 10 , 1 , 27 , 14 , 2 , 29 , 6 , 2/
   DATA rdmap1/4HPARA , 4HM    , 4H  // , 4H*NOP , 4H*/AL , 4HWAYS , 4H=-1  , 4H$    , 4H     , 4H     , 8*4H     , 4HMRED ,        &
      & 4H1    , 4H  CA , 4HSECC , 4H,GEO , 4HM4,D , 4HYNAM , 4HICS, , 4HCSTM , 4H/USE , 4HTR,E , 4HEDR, , 4HEQST , 4H,DMR ,        &
      & 4H!*NA , 4HMEA  , 4H  */ , 4H     , 4H     , 4H     , 4H  S, , 4HN,DR , 4HY/ST , 4HP/S, , 4HN,NO , 4HFIX/ , 4HS,N, ,        &
      & 4HSKIP , 4HM!*C , 4HOMPL , 4HEX*  , 4H$    , 4*4H     , 4HCOND , 4H     , 4H  LB , 4HM3ST , 4HP,DR , 4HY $  , 12*4H     ,   &
       &4HSOFI , 4H     , 4H  /K , 4HNOA, , 4HMNOA , 4H,PNO , 4HA,BN , 4HOA,K , 4H4NOA , 4H/S,N , 4H,DRY , 4H!*NA , 4HMEA  ,        &
      & 4H  */ , 4H*KMT , 4HX*!* , 4HMMTX , 4H*/   , 4H     , 4H     , 4H  *P , 4HVEC* , 4H!*BM , 4HTX*/ , 4H*K4M , 4HX* $ ,        &
      & 4H     , 4H     , 8*4H     , 4HCOND , 4H     , 4H  LB , 4HM2ST , 4HP,SK , 4HIPM  , 4H$    , 4H     , 4H     , 4H     ,      &
       &8*4H     , 4HEQUI , 4HV    , 4H  KN , 4HOA,K , 4HFFX/ , 4HNOFI , 4HX $  , 4H     , 4H     , 4H     , 8*4H     , 4HEQUI ,    &
       &4HV    , 4H  MN , 4HOA,M , 4HFFX/ , 4HNOFI , 4HX $  , 4H     , 4H     , 4H     , 8*4H    /
   DATA rdmap2/4HEQUI , 4HV    , 4H  BN , 4HOA,B , 4HFFX/ , 4HNOFI , 4HX $  , 4H     , 4H     , 4H     , 8*4H     , 4HEQUI ,        &
      & 4HV    , 4H  K4 , 4HNOA, , 4HK4FF , 4HX/NO , 4HFIX  , 4H$    , 4H     , 4H     , 8*4H     , 4HCOND , 4H     , 4H  LB ,      &
       &4HM1ST , 4HP,NO , 4HFIX  , 4H$    , 4H     , 4H     , 4H     , 8*4H     , 4HSCE1 , 4H     , 4H  US , 4HETR, , 4HKNOA ,      &
       &4H,MNO , 4HA,BN , 4HOA,K , 4H4NOA , 4H/KFF , 4HX,KF , 4HSX,K , 4HSSX, , 4HMFFX , 4H,BFF , 4HX,K4 , 4HFFX  , 4H$    ,        &
      & 4HLABE , 4HL    , 4H  LB , 4HM1ST , 4HP $  , 13*4H     , 4HPARA , 4HMR   , 4H  // , 4H*COM , 4HPLEX , 4H*//1 , 4H.0/G ,     &
       &4HPARA , 4HM  / , 4HG $  , 8*4H     , 4HADD  , 4H     , 4H  KF , 4HFX,K , 4H4FFX , 4H/KDD , 4H/G/( , 4H0.0, , 4H1.0) ,      &
       &4H/(1. , 4H0,0. , 4H0)   , 4H$    , 5*4H     , 4HEQUI , 4HV    , 4H  KD , 4HD,KF , 4HFX/A , 4HLWAY , 4HS $  , 4H     ,      &
       &4H     , 4H     , 8*4H     , 4HCEAD , 4H     , 4H  KF , 4HFX,B , 4HFFX, , 4HMFFX , 4H,EED , 4HR,/P , 4HHIDR , 4H,CLA ,      &
       &4HMA,O , 4HCEIG , 4HS,PH , 4HIDL/ , 4HNEIG , 4HVS $ , 4H     , 4H    /
   DATA rdmap3/4HOFP  , 4H     , 4H  CL , 4HAMA, , 4HOCEI , 4HGS,, , 4H,,// , 4H $   , 4H     , 4H     , 8*4H     , 4HEQUI ,        &
      & 4HV    , 4H  PH , 4HIDR, , 4HPHIF , 4HR/NO , 4HFIX  , 4H$    , 4H     , 4H     , 8*4H     , 4HEQUI , 4HV    , 4H  PH ,      &
       &4HIDL, , 4HPHIF , 4HL/NO , 4HFIX  , 4H$    , 4H     , 4H     , 8*4H     , 4HCOND , 4H     , 4H  LB , 4HM2ST , 4HP,NO ,      &
       &4HFIX  , 4H$    , 4H     , 4H     , 4H     , 8*4H     , 4HUMER , 4HGE   , 4H  US , 4HETR, , 4HPHID , 4HR,/P , 4HHIFR ,      &
       &4H!*N* , 4H!*F* , 4H!*S* , 4H $   , 7*4H     , 4HUMER , 4HGE   , 4H  US , 4HETR, , 4HPHID , 4HL,/P , 4HHIFL , 4H!*N* ,      &
       &4H!*F* , 4H!*S* , 4H $   , 7*4H     , 4HLABE , 4HL    , 4H  LB , 4HM2ST , 4HP $  , 13*4H     , 4HCMRE , 4HD2   , 4H  CA ,   &
       &4HSECC , 4H,CLA , 4HMA,P , 4HHIFR , 4H,PHI , 4HFL,E , 4HQST, , 4HUSET , 4HR,KN , 4HOA,M , 4HNOA, , 4HBNOA , 4H,K4N ,        &
      & 4HOA,P , 4HNOA/ , 4H     , 4H     , 4H  KN , 4HOB,M , 4HNOB, , 4HBNOB , 4H,K4N , 4HOB,P , 4HNOB, , 4HPONO , 4HB/ST ,        &
      & 4HP/S, , 4HN,DR , 4HY!*P , 4HVEC* , 4H $   , 4H     , 4H    /
   DATA rdmap4/4HLABE , 4HL    , 4H  LB , 4HM3ST , 4HP $  , 13*4H     , 4HLODA , 4HPP   , 4H  PN , 4HOB,P , 4HONOB , 4H/!*N ,       &
      & 4HAMEB , 4H   * , 4H/S,N , 4H,DRY , 4H $   , 7*4H     , 4HCOND , 4H     , 4H  FI , 4HNIS, , 4HDRY  , 4H$    , 12*4H    /
   DATA xtra/4HNAME , 4HBOUN , 4HFIXE , 4HMETH , 4HRANG , 4HNMAX , 4HUSER , 4HOUTP , 4HOLDM , 4HGPAR , 4HRSAV/
   DATA oct1/7 , 8 , 0 , 8 , 8 , 1 , 9 , 8 , 2 , 10 , 8 , 16 , 11 , 8 , 32 , 12 , 8 , 0 , 13 , 8 , 0 , 14 , 8 , 0 , 15 , 8 , 0 ,    &
      & 16 , 8 , 0 , 17 , 8 , 0 , 18 , 8 , 0 , 19 , 8 , 0 , 20 , 8 , 0 , 21 , 8 , 0 , 22 , 8 , 0 , 23 , 8 , 0 , 24 , 8 , 0/
   DATA oct2/25 , 8 , 0 , 29 , 0 , 8/
   DATA ptbs1/2 , 59 , 59 , 8 , 4HNAMA , 0 , 0 , 3 , 19 , 19 , 3 , 4HSTEP , 0 , 0 , 4 , 15 , 15 , 3 , 4HSTEP , 0 , 0 , 5 , 12 , 13 ,&
      & 3 , 4HNONA , 1 , -1 , 5 , 17 , 18 , 3 , 4HNONA , 2 , -1 , 5 , 22 , 23 , 3 , 4HNONA , 12 , -1 , 5 , 27 , 28 , 3 , 4HNONA ,   &
      & 16 , -1 , 5 , 32 , 34 , 3 , 4HNONA , 32 , -1 , 5 , 47 , 47 , 8 , 4HNAMA , 0 , 0 , 6 , 12 , 12 , 4 , 4HPITM , 0 , 0 , 7 ,    &
      & 15 , 15 , 3 , 4HSTEP , 0 , 0 , 8 , 11 , 12 , 3 , 4HNONA , 0 , 0 , 9 , 11 , 12 , 3 , 4HNONA , 0 , 0 , 10 , 11 , 12 , 3 ,     &
       &4HNONA , 0 , 0 , 11 , 11 , 13 , 3 , 4HNONA , 0 , 0 , 12 , 15 , 15 , 3 , 4HSTEP , 0 , 0 , 13 , 17 , 18 , 3 , 4HNONA , 1 , 0 ,&
      & 13 , 22 , 23 , 3 , 4HNONA , 2 , 0/
   DATA ptbs2/13 , 27 , 28 , 3 , 4HNONA , 16 , 0 , 13 , 32 , 34 , 3 , 4HNONA , 32 , 0 , 13 , 38 , 42 , 0 , 4HNAMA , 1 , 0 , 13 ,    &
      & 43 , 47 , 0 , 4HNAMA , 1 , 0 , 13 , 48 , 52 , 0 , 4HNAMA , 1 , 0 , 13 , 53 , 57 , 0 , 4HNAMA , 2 , 0 , 13 , 58 , 62 , 0 ,   &
       &4HNAMA , 16 , 0 , 13 , 63 , 68 , 0 , 4HNAMA , 32 , 0 , 14 , 15 , 15 , 3 , 4HSTEP , 0 , 0 , 15 , 28 , 28 , 8 , 4HGPAR , 0 ,  &
      & 0 , 18 , 11 , 15 , 0 , 4HNAMA , 1 , 0 , 18 , 16 , 20 , 0 , 4HNAMA , 16 , 0 , 18 , 21 , 25 , 0 , 4HNAMA , 2 , 0 , 22 , 15 ,  &
      & 15 , 3 , 4HSTEP , 0 , 0 , 25 , 15 , 15 , 3 , 4HSTEP , 0 , 0 , 26 , 18 , 23 , 0 , 4HNAMA , 55 , 0 , 26 , 24 , 29 , 0 ,       &
      & 4HNAMA , 55 , 0 , 26 , 30 , 35 , 0 , 4HNAMA , 55 , 0/
   DATA ptbs3/26 , 47 , 48 , 3 , 4HNONA , 1 , 0 , 26 , 52 , 53 , 3 , 4HNONA , 2 , 0 , 26 , 57 , 58 , 3 , 4HNONA , 16 , 0 , 26 , 62 ,&
      & 64 , 3 , 4HNONA , 32 , 0 , 26 , 68 , 69 , 3 , 4HNONA , 12 , 0 , 27 , 11 , 12 , 3 , 4HNONB , 1 , -1 , 27 , 16 , 17 , 3 ,     &
       &4HNONB , 2 , -1 , 27 , 21 , 22 , 3 , 4HNONB , 16 , -1 , 27 , 26 , 28 , 3 , 4HNONB , 32 , -1 , 27 , 32 , 33 , 3 , 4HNONB ,   &
      & 12 , -1 , 27 , 37 , 39 , 3 , 4HNONB , 12 , -1 , 27 , 43 , 43 , 3 , 4HSTEP , 0 , 0 , 27 , 56 , 56 , 4 , 4HPITM , 12 , 0 ,    &
      & 28 , 15 , 15 , 3 , 4HSTEP , 0 , 0 , 29 , 11 , 12 , 3 , 4HNONB , 0 , 0 , 29 , 16 , 18 , 3 , 4HNONB , 0 , 0 , 29 , 24 , 24 ,  &
      & 8 , 4HNAMB , 0 , 0/
   DATA subnam/4HASCM , 2H13/
!
!     RESTORE TO ORIGINAL DATA BY REPLACEING ! BY / IN RDMAP ARRAY
!     (SEE ASCM01 FOR EXPLANATION))
!
   DO l = 1 , 111 , 3
      i = isave(l+1)
      j = isave(l)
      k = isave(l+2)
      rdmap(i,j) = khrfn1(rdmap(i,j),k,slash,1)
   ENDDO
!
!     VALIDATE COMMAND AND SET POINTERS
!
   IF ( Name/=comnd(1,1) ) THEN
!
!     INPUT ERROR
!
      CALL mesage(7,0,subnam)
      Nogo = 1
      RETURN
   ELSE
      icomnd = 1
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
!     MOVE XTRA DATA
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
   ENDIF
!
!
END SUBROUTINE ascm13