
BLOCKDATA ifx1bd
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Ibd1(100) , Ibd2(100) , Ibd3(100) , Ibd4(100) , Ibd5(100) , Ibd6(100) , Ibd7(100) , Ibd8(100) , Icc1(100) , Icc2(24) ,   &
         & Iparpt , Ipr1(100) , Ipr2(92) , Iwrds(18) , Lbdpr , Lcc , N
   COMMON /ifpx0 / Lbdpr , Lcc , Iwrds , Iparpt
   COMMON /ifpx1 / N , Ibd1 , Ibd2 , Ibd3 , Ibd4 , Ibd5 , Ibd6 , Ibd7 , Ibd8 , Ipr1 , Ipr2 , Icc1 , Icc2
!
! End of declarations
!
!IFX1BD
!     DEFINITION OF VARIABLES IN /IFPX1/ AND /IFPX0/
!*****
!
!     COMMON /IFPX1/
!     --------------
!
!     N          = TOTAL NUMBER OF PAIRED ENTRIES IN THE IBD AND
!                  IPR ARRAYS
!                = (TOTAL DIMENSION OF IBD + ACTIVE IPR ARRAYS)/2
!
!     IBD ARRAYS = ARRAYS CONTAINING PAIRED ENTRIES OF BULK DATA
!                  CARD NAMES
!
!     IPR ARRAYS = ARRAYS CONTAINING PAIRED ENTRIES OF BULK DATA
!                  PARAMETER NAMES
!
!     CAUTION 1 -- THE TOTAL DIMENSION OF THE IBD AND IPR ARRAYS
!                  MUST BE A MULTIPLE OF 62 (OR, IN OTHER WORDS,
!                  AN EVEN MULTIPLE OF 31)
!
!                  SEE NOTES 1 AND 2 BELOW
!
!     ICC ARRAYS = ARRAYS CONTAINING PAIRED ENTRIES OF CASE CONTROL
!                  FLAG NAMES FOR USE IN RESTART RUNS
!
!     CAUTION 2 -- THE TOTAL DIMENSION OF THE ICC ARRAYS MUST BE A
!                  MULTIPLE OF 62 (OR, IN OTHER WORDS, AN EVEN
!                  MULTIPLE OF 31)
!
!                  SEE NOTE 3 BELOW
!
!     NOTES
!     -----
!
!              1.  IF NEW BULK DATA CARD NAMES ARE TO BE ADDED,
!                  USE THE EXISTING PADDING WORDS (OF THE 4H****
!                  TYPE) IN THE IBD ARRAYS.  IF NECESSARY, EXPAND
!                  THE IBD ARRAYS KEEPING CAUTION 1 IN MIND.
!
!              2.  IF NEW BULK DATA PARAMETER NAMES ARE TO BE ADDED,
!                  USE THE EXISTING PADDING WORDS (OF THE 4H****
!                  TYPE) IN THE IPR ARRAYS.  IF NECESSARY, EXPAND
!                  THE IPR ARRAYS KEEPING CAUTION 1 IN MIND.
!
!              3.  IF NEW CASE CONTROL FLAG NAMES ARE TO BE ADDED,
!                  USE THE EXISTING PADDING WORDS (OF THE 4H****
!                  TYPE) IN THE ICC ARRAYS.  IF NECESSARY, EXPAND
!                  THE ICC ARRAYS KEEPING CAUTION 2 IN MIND.
!
!              4.  THE IBD ARRAYS ARE IN SYSCHRONIZTION WITH THE I ARRAY
!                  IN IFX2BD, IFX3BD, IFX4BD, IFX5BD, AND IFX6BD
!                  (E.G. CONM1 POSITIONS IN IBD2, CONTINUATION 3, THE DA
!                  FOR CONM1 IN IFX2BD IS IN I2, CONTINUATION 3 CARD)
!*****
!
!     COMMON /IFPX0/
!     --------------
!
!     LBDPR      = (TOTAL DIMENSION OF THE IBD AND IPR ARRAYS)/62
!
!     LCC        = (TOTAL DIMENSION OF THE ICC ARRAYS)/62
!
!     IWRDS      = ARRAY WHOSE DIMENSION IS EQUAL TO (LBDPR + LCC).
!                  ALL (LBDPR + LCC) WORDS IN THE ARRAY INITIALLY
!                  SET TO ZERO.
!
!     IPARPT     = POINTER THAT POINTS TO THE PAIRED ENTRY IN THE
!                  IBD AND IPR ARRAYS THAT CONTAINS THE FIRST
!                  BULK DATA PARAMETER NAME.  AS PER THE DIFINITIONS
!                  OF THE VARIABLES IN COMMON /IFPX1/, THIS POINTS
!                  TO THE FIRST WORD OF THE IPR1 ARRAY.  HENCE, WE
!                  HAVE --
!
!                  IPARPT = 1 + (TOTAL DIMENSION OF IBD ARRAYS)/2
!
!
!*****
!     INITIALIZATION OF VARIABLES IN COMMON /IFPX1/
!*****
!
   DATA N/496/
!*****
!     THE IBD ARRAYS CONTAIN PAIRED ENTRIES OF BULK DATA CARD NAMES
!*****
   DATA Ibd1/4HGRID , 4H     , 4HGRDS , 4HET   , 4HADUM , 4H1    , 4HSEQG , 4HP    , 4HCORD , 4H1R   , 4HCORD , 4H1C   , 4HCORD ,   &
       &4H1S   , 4HCORD , 4H2R   , 4HCORD , 4H2C   , 4HCORD , 4H2S   , 4HPLOT , 4HEL   , 4HSPC1 , 4H     , 4HSPCA , 4HDD   ,        &
      & 4HSUPO , 4HRT   , 4HOMIT , 4H     , 4HSPC  , 4H     , 4HMPC  , 4H     , 4HFORC , 4HE    , 4HMOME , 4HNT   , 4HFORC ,        &
      & 4HE1   , 4HMOME , 4HNT1  , 4HFORC , 4HE2   , 4HMOME , 4HNT2  , 4HPLOA , 4HD    , 4HSLOA , 4HD    , 4HGRAV , 4H     ,        &
      & 4HTEMP , 4H     , 4HGENE , 4HL    , 4HPROD , 4H     , 4HPTUB , 4HE    , 4HPVIS , 4HC    , 4HADUM , 4H2    , 4HPTRI ,        &
      & 4HA1   , 4HPTRI , 4HA2   , 4HPTRB , 4HSC   , 4HPTRP , 4HLT   , 4HPTRM , 4HEM   , 4HPQUA , 4HD1   , 4HPQUA , 4HD2   ,        &
      & 4HPQDP , 4HLT   , 4HPQDM , 4HEM   , 4HPSHE , 4HAR   , 4HPTWI , 4HST   , 4HPMAS , 4HS    , 4HPDAM , 4HP    , 4HPELA ,        &
      & 4HS    , 4HCONR , 4HOD   , 4HCROD , 4H     , 4HCTUB , 4HE    , 4HCVIS , 4HC   /
   DATA Ibd2/4HADUM , 4H3    , 4HCTRI , 4HA1   , 4HCTRI , 4HA2   , 4HCTRB , 4HSC   , 4HCTRP , 4HLT   , 4HCTRM , 4HEM   , 4HCQUA ,   &
       &4HD1   , 4HCQUA , 4HD2   , 4HCQDP , 4HLT   , 4HCQDM , 4HEM   , 4HCSHE , 4HAR   , 4HCTWI , 4HST   , 4HCONM , 4H1    ,        &
      & 4HCONM , 4H2    , 4HCMAS , 4HS1   , 4HCMAS , 4HS2   , 4HCMAS , 4HS3   , 4HCMAS , 4HS4   , 4HCDAM , 4HP1   , 4HCDAM ,        &
      & 4HP2   , 4HCDAM , 4HP3   , 4HCDAM , 4HP4   , 4HCELA , 4HS1   , 4HCELA , 4HS2   , 4HCELA , 4HS3   , 4HCELA , 4HS4   ,        &
      & 4HMAT1 , 4H     , 4HMAT2 , 4H     , 4HCTRI , 4HARG  , 4HCTRA , 4HPRG  , 4HDEFO , 4HRM   , 4HPARA , 4HM    , 4HMPCA ,        &
      & 4HDD   , 4HLOAD , 4H     , 4HEIGR , 4H     , 4HEIGB , 4H     , 4HEIGC , 4H     , 4HADUM , 4H4    , 4H     , 4H     ,        &
      & 4HMATS , 4H1    , 4HMATT , 4H1    , 4HOMIT , 4H1    , 4HTABL , 4HEM1  , 4HTABL , 4HEM2  , 4HTABL , 4HEM3  , 4HTABL ,        &
      & 4HEM4  , 4HTABL , 4HES1  , 4HTEMP , 4HD    , 4HADUM , 4H5    , 4HADUM , 4H6   /
   DATA Ibd3/4HADUM , 4H7    , 4HMATT , 4H2    , 4HADUM , 4H8    , 4HCTOR , 4HDRG  , 4HSPOI , 4HNT   , 4HADUM , 4H9    , 4HCDUM ,   &
       &4H1    , 4HCDUM , 4H2    , 4HCDUM , 4H3    , 4HCDUM , 4H4    , 4HCDUM , 4H5    , 4HCDUM , 4H6    , 4HCDUM , 4H7    ,        &
      & 4HCDUM , 4H8    , 4HCDUM , 4H9    , 4HPDUM , 4H1    , 4HPDUM , 4H2    , 4HPDUM , 4H3    , 4HDMI  , 4H     , 4HDMIG ,        &
      & 4H     , 4HPTOR , 4HDRG  , 4HMAT3 , 4H     , 4HDLOA , 4HD    , 4HEPOI , 4HNT   , 4HFREQ , 4H1    , 4HFREQ , 4H     ,        &
      & 4HNOLI , 4HN1   , 4HNOLI , 4HN2   , 4HNOLI , 4HN3   , 4HNOLI , 4HN4   , 4HRLOA , 4HD1   , 4HRLOA , 4HD2   , 4HTABL ,        &
      & 4HED1  , 4HTABL , 4HED2  , 4HSEQE , 4HP    , 4HTF   , 4H     , 4HTIC  , 4H     , 4HTLOA , 4HD1   , 4HTLOA , 4HD2   ,        &
      & 4HTABL , 4HED3  , 4HTABL , 4HED4  , 4HTSTE , 4HP    , 4HDSFA , 4HCT   , 4HAXIC , 4H     , 4HRING , 4HAX   , 4HCCON ,        &
      & 4HEAX  , 4HPCON , 4HEAX  , 4HSPCA , 4HX    , 4HMPCA , 4HX    , 4HOMIT , 4HAX  /
   DATA Ibd4/4HSUPA , 4HX    , 4HPOIN , 4HTAX  , 4HSECT , 4HAX   , 4HPRES , 4HAX   , 4HTEMP , 4HAX   , 4HFORC , 4HEAX  , 4HMOMA ,   &
       &4HX    , 4HEIGP , 4H     , 4HPDUM , 4H4    , 4HPDUM , 4H5    , 4HPDUM , 4H6    , 4HTABD , 4HMP1  , 4HPDUM , 4H7    ,        &
      & 4HPDUM , 4H8    , 4HPDUM , 4H9    , 4HFREQ , 4H2    , 4HCONC , 4HT1   , 4HCONC , 4HT    , 4HTRAN , 4HS    , 4HRELE ,        &
      & 4HS    , 4HLOAD , 4HC    , 4HSPCS , 4HD    , 4HSPCS , 4H1    , 4HSPCS , 4H     , 4HBDYC , 4H     , 4HMPCS , 4H     ,        &
      & 4HBDYS , 4H     , 4HBDYS , 4H1    , 4HBARO , 4HR    , 4HCBAR , 4H     , 4HPBAR , 4H     , 4HDARE , 4HA    , 4HDELA ,        &
      & 4HY    , 4HDPHA , 4HSE   , 4HPLFA , 4HCT   , 4HGNEW , 4H     , 4HGTRA , 4HN    , 4HTABR , 4HNDG  , 4HMATT , 4H3    ,        &
      & 4HRFOR , 4HCE   , 4HTABR , 4HND1  , 4HPLOA , 4HD4   , 4HUSET , 4H     , 4HUSET , 4H1    , 4HRAND , 4HPS   , 4HRAND ,        &
      & 4HT1   , 4HRAND , 4HT2*  , 4HPLOA , 4HD1   , 4HPLOA , 4HD2   , 4HDTI  , 4H    /
   DATA Ibd5/4HTEMP , 4HP1   , 4HTEMP , 4HP2   , 4HTEMP , 4HP3   , 4HTEMP , 4HRB   , 4HGRID , 4HB    , 4HFSLI , 4HST   , 4HRING ,   &
       &4HFL   , 4HPRES , 4HPT   , 4HCFLU , 4HID2  , 4HCFLU , 4HID3  , 4HCFLU , 4HID4  , 4HAXIF , 4H     , 4HBDYL , 4HIST  ,        &
      & 4HFREE , 4HPT   , 4HASET , 4H     , 4HASET , 4H1    , 4HCTET , 4HRA   , 4HCWED , 4HGE   , 4HCHEX , 4HA1   , 4HCHEX ,        &
      & 4HA2   , 4HDMIA , 4HX    , 4HFLSY , 4HM    , 4HAXSL , 4HOT   , 4HCAXI , 4HF2   , 4HCAXI , 4HF3   , 4HCAXI , 4HF4   ,        &
      & 4HCSLO , 4HT3   , 4HCSLO , 4HT4   , 4HGRID , 4HF    , 4HGRID , 4HS    , 4HSLBD , 4HY    , 4HCHBD , 4HY    , 4HQHBD ,        &
      & 4HY    , 4HMAT4 , 4H     , 4HMAT5 , 4H     , 4HPHBD , 4HY    , 4HMATT , 4H4    , 4HMATT , 4H5    , 4HQBDY , 4H1    ,        &
      & 4HQBDY , 4H2    , 4HQVEC , 4HT    , 4HQVOL , 4H     , 4HRADL , 4HST   , 4HRADM , 4HTX   , 4HSAME , 4H     , 4HNOSA ,        &
      & 4HME   , 4HINPU , 4HT    , 4HOUTP , 4HUT   , 4HCQDM , 4HEM1  , 4HPQDM , 4HEM1 /
   DATA Ibd6/4HCIHE , 4HX1   , 4HCIHE , 4HX2   , 4HCIHE , 4HX3   , 4HPIHE , 4HX    , 4HPLOA , 4HD3   , 4HSPCD , 4H     , 4HCYJO ,   &
       &4HIN   , 4HCNGR , 4HNT   , 4HCQDM , 4HEM2  , 4HPQDM , 4HEM2  , 4HCQUA , 4HD4   , 4HMAT8 , 4H     , 4HCAER , 4HO1   ,        &
      & 4HPAER , 4HO1   , 4HAERO , 4H     , 4HSPLI , 4HNE1  , 4HSPLI , 4HNE2  , 4HSET1 , 4H     , 4HSET2 , 4H     , 4HMKAE ,        &
      & 4HRO2  , 4HMKAE , 4HRO1  , 4HFLUT , 4HTER  , 4HAEFA , 4HCT   , 4HFLFA , 4HCT   , 4HCBAR , 4HAO   , 4HPLIM , 4HIT   ,        &
      & 4HPOPT , 4H     , 4HPLOA , 4HDX   , 4HCRIG , 4HD1   , 4HPCOM , 4HP    , 4HPCOM , 4HP1   , 4HPCOM , 4HP2   , 4HPSHE ,        &
      & 4HLL   , 4HCRIG , 4HD2   , 4HCTRI , 4HAAX  , 4HPTRI , 4HAAX  , 4HCTRA , 4HPAX  , 4HPTRA , 4HPAX  , 4HVIEW , 4H     ,        &
      & 4HVARI , 4HAN   , 4HCTRI , 4HM6   , 4HPTRI , 4HM6   , 4HCTRP , 4HLT1  , 4HPTRP , 4HLT1  , 4HTEMP , 4HG    , 4HTEMP ,        &
      & 4HP4   , 4HCRIG , 4HDR   , 4HCRIG , 4HD3   , 4HCTRS , 4HHL   , 4HPTRS , 4HHL  /
   DATA Ibd7/4HCAER , 4HO2   , 4HCAER , 4HO3   , 4HCAER , 4HO4   , 4HPAER , 4HO2   , 4HPAER , 4HO3   , 4HPAER , 4HO4   , 4HSPLI ,   &
       &4HNE3  , 4HGUST , 4H     , 4HCAER , 4HO5   , 4HPAER , 4HO5   , 4HDARE , 4HAS   , 4HDELA , 4HYS   , 4HDPHA , 4HSES  ,        &
      & 4HTICS , 4H     , 4HMATP , 4HZ1   , 4HMATP , 4HZ2   , 4HMTTP , 4HZ1   , 4HMTTP , 4HZ2   , 4HMAT6 , 4H     , 4HMATT ,        &
      & 4H6    , 4HCEML , 4HOOP  , 4HSPCF , 4HLD   , 4HCIS2 , 4HD8   , 4HPIS2 , 4HD8   , 4HGEML , 4HOOP  , 4HREMF , 4HLUX  ,        &
      & 4HBFIE , 4HLD   , 4HMDIP , 4HOLE  , 4HPROL , 4HATE  , 4HPERM , 4HBDY  , 4HCFFR , 4HEE   , 4HCFLS , 4HTR   , 4HCFHE ,        &
      & 4HX1   , 4HCFHE , 4HX2   , 4HCFTE , 4HTRA  , 4HCFWE , 4HDGE  , 4HMATF , 4H     , 4HCELB , 4HOW   , 4HPELB , 4HOW   ,        &
      & 4HNOLI , 4HN5   , 4HNOLI , 4HN6   , 4HCFTU , 4HBE   , 4HPFTU , 4HBE   , 4HNFTU , 4HBE   , 4HSTRE , 4HAML1 , 4HSTRE ,        &
      & 4HAML2 , 4HCRRO , 4HD    , 4HCRBA , 4HR    , 4HCRTR , 4HPLT  , 4HCRBE , 4H1   /
   DATA Ibd8/4HCRBE , 4H2    , 4HCRBE , 4H3    , 4HCRSP , 4HLINE , 4HCTRI , 4HA3   , 4HTABL , 4HEM5  , 4HCPSE , 4H2    , 4HCPSE ,   &
       &4H3    , 4HCPSE , 4H4    , 4HPPSE , 4H     , 82*4H****/
!*****
!     THE IPR ARRAYS CONTAIN PAIRED ENTRIES OF BULK DATA PARAMETER NAMES
!*****
   DATA Ipr1/4HGRDP , 4HNT   , 4HWTMA , 4HSS   , 4HIRES , 4H     , 4HLFRE , 4HQ    , 4HHFRE , 4HQ    , 4HLMOD , 4HES   , 4HG    ,   &
       &4H     , 4HW3   , 4H     , 4HW4   , 4H     , 4HMODA , 4HCC   , 4HCOUP , 4HMASS , 4HCPBA , 4HR    , 4HCPRO , 4HD    ,        &
      & 4HCPQU , 4HAD1  , 4HCPQU , 4HAD2  , 4HCPTR , 4HIA1  , 4HCPTR , 4HIA2  , 4HCPTU , 4HBE   , 4HCPQD , 4HPLT  , 4HCPTR ,        &
      & 4HPLT  , 4HCPTR , 4HBSC  , 4HMAXI , 4HT    , 4HEPSH , 4HT    , 4HTABS , 4H     , 4HSIGM , 4HA    , 4HBETA , 4H     ,        &
      & 4HRADL , 4HIN   , 4HBETA , 4HD    , 4HNT   , 4H     , 4HEPSI , 4HO    , 4HCTYP , 4HE    , 4HNSEQ , 4HS    , 4HNLOA ,        &
      & 4HD    , 4HCYCI , 4HO    , 4HCYCS , 4HEQ   , 4HKMAX , 4H     , 4HKIND , 4HEX   , 4HNODJ , 4HE    , 4HP1   , 4H     ,        &
      & 4HP2   , 4H     , 4HP3   , 4H     , 4HVREF , 4H     , 4HPRIN , 4HT    , 4HISTA , 4HRT   , 4HKDAM , 4HP    , 4HGUST ,        &
      & 4HAERO , 4HIFTM , 4H     , 4HMACH , 4H     , 4HQ    , 4H     , 4HHOPT , 4H    /
   DATA Ipr2/4HGRDE , 4HQ    , 4HSTRE , 4HSS   , 4HSTRA , 4HIN   , 4HNINT , 4HPTS  , 4HASET , 4HOUT  , 4HAUTO , 4HSPC  , 4HVOLU ,   &
       &4HME   , 4HSURF , 4HACE  , 4HKTOU , 4HT    , 4HAPRE , 4HSS   , 4HATEM , 4HP    , 4HSTRE , 4HAML  , 4HPGEO , 4HM    ,        &
      & 4HSIGN , 4H     , 4HZORI , 4HGN   , 4HFXCO , 4HOR   , 4HFYCO , 4HOR   , 4HFZCO , 4HOR   , 4HKGGI , 4HN    , 4HIREF ,        &
      & 4H     , 4HMINM , 4HACH  , 4HMAXM , 4HACH  , 4HMTYP , 4HE    , 4H**** , 4H**** , 44*4H****/
!*****
!     THE ICC ARRAYS CONTAIN PAIRED ENTRIES OF CASE CONTROL FLAG NAMES
!     FOR USE IN RESTART RUNS
!*****
   DATA Icc1/4HMPC$ , 4H     , 4HSPC$ , 4H     , 4HLOAD , 4H$    , 4HMETH , 4HOD$  , 4HDEFO , 4HRM$  , 4HTEMP , 4HLD$  , 4HTEMP ,   &
       &4HMT$  , 4HIC$  , 4H     , 4HAOUT , 4H$    , 4HLOOP , 4H$    , 4HLOOP , 4H1$   , 4HDLOA , 4HD$   , 4HFREQ , 4H$    ,        &
      & 4HTF$  , 4H     , 4HPLOT , 4H$    , 4HTSTE , 4HP$   , 4HPOUT , 4H$    , 4HTEMP , 4HMX$  , 4HDSCO , 4H$    , 4HK2PP ,        &
      & 4H$    , 4HM2PP , 4H$    , 4HB2PP , 4H$    , 4HCMET , 4HHOD$ , 4HSDAM , 4HP$   , 4HPLCO , 4H$    , 4HNLFO , 4HRCE$ ,        &
      & 4HXYOU , 4HT$   , 4HFMET , 4HHOD$ , 4HRAND , 4HOM$  , 4HAXYO , 4HUT$  , 4HNOLO , 4HOP$  , 4HGUST , 4H$    , 4HQOUT ,        &
      & 4H$    , 4HBOUT , 4H$    , 32*4H****/
   DATA Icc2/24*4H****/
!
!*****
!     INITIALIZATION OF VARIABLES IN COMMON /IFPX0/
!*****
!
!     THE VALUES ASSIGNED BELOW TO THE VARIABLES IN COMMON /IFPX0/
!     ARE AS PER THEIR DEFINITIONS GIVEN EARLIER IN THE COMMENTS
!     AND ARE DERIVED FROM THE COMMON /IFPX1/ INFORMATION
!*****
   DATA Lbdpr , Lcc , Iwrds , Iparpt/16 , 2 , 18*0 , 401/
!
END BLOCKDATA ifx1bd
