!*==gptabd.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
BLOCKDATA gptabd
   USE c_clstrs
   USE c_gpta1
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , DIMENSION(100) , SAVE :: comp1 , comp2 , comp3 , comp4 , comp5
   INTEGER , DIMENSION(30) , SAVE :: comp6
   INTEGER , DIMENSION(25) , SAVE :: e1 , e10 , e11 , e12 , e13 , e14 , e15 , e16 , e17 , e18 , e19 , e2 , e20 , e21 , e22 , e23 ,  &
                                   & e24 , e25 , e26 , e27 , e28 , e29 , e3 , e30 , e31 , e32 , e33 , e34 , e35 , e36 , e37 , e38 , &
                                   & e39 , e4 , e40 , e41 , e42 , e43 , e44 , e45 , e46 , e47 , e48 , e49 , e5 , e50 , e51 , e52 ,  &
                                   & e53 , e54 , e55 , e56 , e57 , e58 , e59 , e6 , e60 , e61 , e62 , e63 , e64 , e65 , e66 , e67 , &
                                   & e68 , e69 , e7 , e70 , e71 , e72 , e73 , e74 , e75 , e76 , e77 , e78 , e79 , e8 , e80 , e81
   INTEGER , DIMENSION(25) , SAVE :: e82 , e83 , e84 , e85 , e86 , e9
!
! End of declarations rewritten by SPAG
!
!GPTABD
!     BLOCK DATA PROGRAM FOR ALL MODULES HAVING ANYTHING TO DO WITH THE
!     NASTRAN STRUCTURAL ELEMENTS.
!
!     NOTE. ALL MODULES SHOULD BE WRITTEN TO TAKE ADVANTAGE OF THE
!     FLEXIBLE NATURE OF THIS DATA.
!
!     THE ELEMENTS OF NASTRAN ARE ALL REPRESENTED BELOW.  THEY ARE
!     ARRANGED BY ELEMENT TYPE NUMBER.  EACH ELEMENT ENTRY BELOW
!     CONTAINS -INCR- NUMBER OF VALUES.  -INCR- AT SOME FUTURE DATE MAY
!     GROW LARGER THUS MODULE WRITERS SHOULD ALWAYS INCLUDE -INCR- WHEN
!     COMPUTING INDEXES INTO THIS DATA.
!
!     -NELEM- IS SIMPLY THE CURRENT NUMBER OF ELEMENTS IN NASTRAN.
!
!     -LAST- IS SIMPLY THE NUMBER OF THE FIRST WORD OF THE LAST ELEMENT
!     ENTRY SUCH THAT DO LOOPS MAY HAVE THE FOLLOWING FORM.
!
!              DO 100 I = 1,LAST,INCR
!                     . . .
!                     . . .
!                     . . .
!          100 CONTINUE
!
!     THUS IN THE ABOVE LOOP E(I) POINTS TO THE FIRST WORD OF OF AN
!     ELEMENT ENTRY.
!
!     TERMS OF EACH ELEMENT ENTRY.
!     ============================
!      1. AND 2.  = ELEMENT NAME STORED 2A4
!      3. ELEMENT TYPE NUMBER
!      4. AND 5. ELEMENT-CONNECTION-TABLE RECORD ID AND BIT NUMBER
!      6. NUMBER OF ELEMENT CONNECTION TABLE WORDS FOR THIS ELEMENT
!      7. 8. AND 9. SAME AS 4. 5. AND 6. BUT FOR ELEMENT PROPERTY TABLE
!     10. NUMBER OF GRID POINTS FOR THIS ELEMENT
!     11. SCALAR
!     12. NUMBER OF WORDS IN THE ELEMENT-SUMMARY-TABLE FOR THIS ELEMENT
!     13. POSITION IN ECT OF FIRST GRID POINT
!     14. AND 15. TEMPERATURE TYPE AND COUNT AS USED BY THE SSG MODULE
!     16. TWO LETTER SYMBOL FOR PLOTTING.  ELEMENT WILL BE PLOTTED IF
!         WORD 10 IS 2 TO 42 AND WORD 11 IS ZERO AND WORD 16 .NE. 2HXX
!     17. NUMBER OF ESTA WORDS SDR2 WILL PICK UP FROM PHASE-1 ELEMENT
!         ROUTINES AND PASS TO THE PHASE-2 ELEMENT ROUTINES
!     18. AND 19. THE REAL STRESS WORD AND FORCE WORD COUNTS FOR OUT-
!         PUTS FROM THE SDR2 PHASE-2 ROUTINES TO AN OUTPUT FILE FOR OFP
!     20. AND 21. COMPLEX STRESS AND FORCE POINTERS FOR ORDERING OF
!         COMPLEX STRESS AND FORCE OUTPUTS TO A FILE FOR OFP PROCESSING
!     22. 23. AND 24. SMA1, SMA2, AND DS1 ELEMENT OVERLAY TREE POSITION
!     25. MAXIMUM DEGREES OF FREEDOM DEFINED FOR ELEMENT
!
!
!
!
!
!RPKR THE FOLLOWING TWO LINES WERE REPLACED
!RPKR EQUIVALENCE STATEMENT TOO LONG
!RPKR9            (E28(1),E( 676)), (E29(1),E( 701)), (E30(1),E( 726)),
!RPKRO            (E31(1),E( 751)), (E32(1),E( 776)), (E33(1),E( 801)),
   EQUIVALENCE (E1(1),E(1)) , (E2(1),E(26)) , (E3(1),E(51)) , (E4(1),E(76)) , (E5(1),E(101)) , (E6(1),E(126)) , (E7(1),E(151)) ,    &
    & (E8(1),E(176)) , (E9(1),E(201)) , (E10(1),E(226)) , (E11(1),E(251)) , (E12(1),E(276)) , (E13(1),E(301)) , (E14(1),E(326)) ,   &
    & (E15(1),E(351)) , (E16(1),E(376)) , (E17(1),E(401)) , (E18(1),E(426)) , (E19(1),E(451)) , (E20(1),E(476)) , (E21(1),E(501)) , &
    & (E22(1),E(526)) , (E23(1),E(551)) , (E24(1),E(576)) , (E25(1),E(601)) , (E26(1),E(626)) , (E27(1),E(651)) , (E28(1),E(676)) , &
    & (E29(1),E(701)) , (E30(1),E(726))
   EQUIVALENCE (E31(1),E(751)) , (E32(1),E(776)) , (E33(1),E(801)) , (E34(1),E(826)) , (E35(1),E(851)) , (E36(1),E(876)) ,          &
    & (E37(1),E(901)) , (E38(1),E(926)) , (E39(1),E(951)) , (E40(1),E(976)) , (E41(1),E(1001)) , (E42(1),E(1026)) , (E43(1),E(1051))&
    & , (E44(1),E(1076)) , (E45(1),E(1101)) , (E46(1),E(1126)) , (E47(1),E(1151)) , (E48(1),E(1176)) , (E49(1),E(1201)) ,           &
    & (E50(1),E(1226)) , (E51(1),E(1251)) , (E52(1),E(1276)) , (E53(1),E(1301)) , (E54(1),E(1326)) , (E55(1),E(1351)) ,             &
    & (E56(1),E(1376)) , (E57(1),E(1401)) , (E58(1),E(1426)) , (E59(1),E(1451)) , (E60(1),E(1476))
   EQUIVALENCE (E61(1),E(1501)) , (E62(1),E(1526)) , (E63(1),E(1551)) , (E64(1),E(1576)) , (E65(1),E(1601)) , (E66(1),E(1626)) ,    &
    & (E67(1),E(1651)) , (E68(1),E(1676)) , (E69(1),E(1701)) , (E70(1),E(1726)) , (E71(1),E(1751)) , (E72(1),E(1776)) ,             &
    & (E73(1),E(1801)) , (E74(1),E(1826)) , (E75(1),E(1851)) , (E76(1),E(1876)) , (E77(1),E(1901)) , (E78(1),E(1926)) ,             &
    & (E79(1),E(1951)) , (E80(1),E(1976)) , (E81(1),E(2001)) , (E82(1),E(2026)) , (E83(1),E(2051)) , (E84(1),E(2076)) ,             &
    & (E85(1),E(2101)) , (E86(1),E(2126))
!
   EQUIVALENCE (Complx(1),Comp1(1)) , (Complx(101),Comp2(1)) , (Complx(201),Comp3(1)) , (Complx(301),Comp4(1)) ,                    &
    & (Complx(401),Comp5(1)) , (Complx(501),Comp6(1))
!
   DATA nelem/86/ , last/2150/ , incr/25/
!
!     CURRENTLY ECTBIT USES 1 THRU 96, EXCEPT
!        76-77, 82, 88-90, 94-96
!     (50 IS USED BY CONGRUENT ELEMENT, CNGRNT, WITH ECT-ID 5008)
!
!     CURRENTLY EPTBIT USES 1 THRU 96, EXCEPT
!        26-48, 50, 52, 54-55, 57, 59-60, 71-81, 83, 86-94 AND 96
!
!                ------,------,------,------,------,------,------,
!     DATA  Exx/ NAME1 ,NAME2 ,ELTYPE,ECT-ID,ECTBIT,ECTWDS,EPT-ID,
!                EPTBIT,EPTWDS,GRDPTS,SCALAR,ESTWDS,GRID1 ,TEMTYP,
!                TEMCT ,SYMBOL,ESTAWD,STRESS,FORCE ,STRSPT,FORCPT,
!                SMA1OV,SMA2OV,DS1OV ,MAXDOF/
!                ------,------,------,------,------,------,------,
   DATA e1/4HROD  , 4H     , 1 , 3001 , 30 , 4 , 902 , 9 , 6 , 2 , 0 , 17 , 3 , 1 , 2 , 2HRD , 23 , 5 , 3 , 41 , 13 , 1 , 1 , 1 , 6/
!
!     NOTE FROM G.CHAN/UNISYS  9/91
!     THE NEXT ELEMENT IS NOT AVAILABLE IN COSMIC/NASTRAN. BUT ELEMENT
!     TYPE 2 IS USED LOCALLY IN DS1 SUBROUTINE. CHECK WITH DS1 FIRST IF
!     BEAM ELEMENT IS TO BE USED. MAKE SURE THERE IS NO CONFLICT ABOUT
!     ELEMENT TYPE 2
!
   DATA e2/4HBEAM , 4H     , 2 , 101 , 1 , 20 , 102 , 1 , 20 , 2 , 0 , 47 , 3 , 0 , 0 , 2HBM , 88 , 14 , 9 , 0 , 0 , 1 , 1 , 1 , 6/
   DATA e3/4HTUBE , 4H     , 3 , 3701 , 37 , 4 , 1602 , 16 , 5 , 2 , 0 , 16 , 3 , 1 , 2 , 2HTU , 23 , 5 , 3 , 41 , 13 , 1 , 1 , 1 , &
      & 6/
   DATA e4/4HSHEA , 4HR    , 4 , 3101 , 31 , 6 , 1002 , 10 , 4 , 4 , 0 , 25 , 3 , 2 , 7 , 2HSH , 33 , 4 , 17 , 47 , 156 , 1 , 1 ,   &
      & 1 , 6/
   DATA e5/4HTWIS , 4HT    , 5 , 3801 , 38 , 6 , 1702 , 17 , 4 , 4 , 0 , 25 , 3 , 2 , 7 , 2HTW , 25 , 4 , 3 , 47 , 13 , 1 , 1 , 0 , &
      & 6/
   DATA e6/4HTRIA , 4H1    , 6 , 3301 , 33 , 6 , 1202 , 12 , 10 , 3 , 0 , 27 , 3 , 2 , 7 , 2HT1 , 137 , 17 , 6 , 73 , 1 , 1 , 1 ,   &
      & 2 , 6/
   DATA e7/4HTRBS , 4HC    , 7 , 3201 , 32 , 6 , 1102 , 11 , 8 , 3 , 0 , 25 , 3 , 2 , 7 , 2HTB , 101 , 17 , 6 , 73 , 1 , 1 , 1 , 0 ,&
      & 6/
   DATA e8/4HTRPL , 4HT    , 8 , 3601 , 36 , 6 , 1502 , 15 , 8 , 3 , 0 , 25 , 3 , 2 , 7 , 2HTP , 101 , 17 , 6 , 73 , 1 , 1 , 1 , 0 ,&
      & 6/
   DATA e9/4HTRME , 4HM    , 9 , 3501 , 35 , 6 , 1402 , 14 , 4 , 3 , 0 , 21 , 3 , 2 , 2 , 2HTM , 36 , 8 , 0 , 89 , 0 , 1 , 1 , 2 ,  &
      & 6/
   DATA e10/4HCONR , 4HOD   , 10 , 1601 , 16 , 8 , 0 , 0 , 0 , 2 , 0 , 17 , 2 , 1 , 2 , 2HCR , 23 , 5 , 3 , 41 , 13 , 1 , 1 , 1 , 6/
   DATA e11/4HELAS , 4H1    , 11 , 601 , 6 , 6 , 302 , 3 , 4 , 2 , 1 , 8 , 3 , 0 , 0 , 2H   , 5 , 2 , 2 , 19 , 19 , 1 , 1 , 0 , 1/
   DATA e12/4HELAS , 4H2    , 12 , 701 , 7 , 8 , 0 , 0 , 0 , 2 , 1 , 8 , 3 , 0 , 0 , 2H   , 5 , 2 , 2 , 19 , 19 , 1 , 1 , 0 , 1/
   DATA e13/4HELAS , 4H3    , 13 , 801 , 8 , 4 , 302 , 3 , 4 , 2 , -1 , 6 , 3 , 0 , 0 , 2H   , 5 , 2 , 2 , 19 , 19 , 1 , 1 , 0 , 1/
   DATA e14/4HELAS , 4H4    , 14 , 901 , 9 , 4 , 0 , 0 , 0 , 2 , -1 , 4 , 3 , 0 , 0 , 2H   , 5 , 0 , 2 , 19 , 19 , 1 , 1 , 0 , 1/
   DATA e15/4HQDPL , 4HT    , 15 , 2701 , 27 , 7 , 602 , 6 , 8 , 4 , 0 , 30 , 3 , 2 , 7 , 2HQP , 131 , 17 , 6 , 73 , 1 , 1 , 1 , 0 ,&
      & 6/
   DATA e16/4HQDME , 4HM    , 16 , 2601 , 26 , 7 , 502 , 5 , 4 , 4 , 0 , 26 , 3 , 2 , 2 , 2HQM , 45 , 8 , 0 , 89 , 0 , 1 , 1 , 2 ,  &
      & 6/
   DATA e17/4HTRIA , 4H2    , 17 , 3401 , 34 , 6 , 1302 , 13 , 4 , 3 , 0 , 21 , 3 , 2 , 7 , 2HT2 , 137 , 17 , 6 , 73 , 1 , 1 , 1 ,  &
      & 2 , 6/
   DATA e18/4HQUAD , 4H2    , 18 , 2901 , 29 , 7 , 802 , 8 , 4 , 4 , 0 , 26 , 3 , 2 , 7 , 2HQ2 , 176 , 17 , 6 , 73 , 1 , 1 , 1 , 2 ,&
      & 6/
   DATA e19/4HQUAD , 4H1    , 19 , 2801 , 28 , 7 , 702 , 7 , 10 , 4 , 0 , 32 , 3 , 2 , 7 , 2HQ1 , 176 , 17 , 6 , 73 , 1 , 1 , 1 ,   &
      & 2 , 6/
   DATA e20/4HDAMP , 4H1    , 20 , 201 , 2 , 6 , 202 , 2 , 2 , 2 , 1 , 6 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e21/4HDAMP , 4H2    , 21 , 301 , 3 , 6 , 0 , 0 , 0 , 2 , 1 , 6 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e22/4HDAMP , 4H3    , 22 , 401 , 4 , 4 , 202 , 2 , 2 , 2 , -1 , 4 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e23/4HDAMP , 4H4    , 23 , 501 , 5 , 4 , 0 , 0 , 0 , 2 , -1 , 4 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e24/4HVISC , 4H     , 24 , 3901 , 39 , 4 , 1802 , 18 , 3 , 2 , 0 , 14 , 3 , 0 , 0 , 2HVS , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 ,  &
      & 6/
   DATA e25/4HMASS , 4H1    , 25 , 1001 , 10 , 6 , 402 , 4 , 2 , 2 , 1 , 6 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e26/4HMASS , 4H2    , 26 , 1101 , 11 , 6 , 0 , 0 , 0 , 2 , 1 , 6 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e27/4HMASS , 4H3    , 27 , 1201 , 12 , 4 , 402 , 4 , 2 , 2 , -1 , 4 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e28/4HMASS , 4H4    , 28 , 1301 , 13 , 4 , 0 , 0 , 0 , 2 , -1 , 4 , 3 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e29/4HCONM , 4H1    , 29 , 1401 , 14 , 24 , 0 , 0 , 0 , 1 , 0 , 29 , 2 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 6/
   DATA e30/4HCONM , 4H2    , 30 , 1501 , 15 , 13 , 0 , 0 , 0 , 1 , 0 , 18 , 2 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 6/
   DATA e31/4HPLOT , 4HEL   , 31 , 5201 , 52 , 3 , 0 , 0 , 0 , 2 , 0 , 12 , 2 , 0 , 0 , 2HPL , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 6/
   DATA e32/4HREAC , 4HT    , 32 , 5251 , 60 , 19 , 0 , 0 , 0 , 1 , 0 , 24 , 2 , 0 , 0 , 2H   , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 6/
   DATA e33/4HQUAD , 4H3    , 33 , 2958 , 40 , 7 , 852 , 49 , 62 , 4 , 0 , 24 , 3 , 0 , 0 , 2HQ3 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 ,  &
      & 6/
   DATA e34/4HBAR  , 4H     , 34 , 2408 , 24 , 16 , 52 , 20 , 19 , 2 , 0 , 42 , 3 , 1 , 15 , 2HBR , 124 , 16 , 9 , 53 , 23 , 1 , 1 ,&
      & 1 , 6/
   DATA e35/4HCONE , 4HAX   , 35 , 8515 , 85 , 4 , 152 , 19 , 24 , 2 , 0 , 35 , 3 , 3 , 4 , 2HCN , 118 , 18 , 7 , 0 , 0 , 2 , 2 ,   &
      & 2 , 6/
   DATA e36/4HTRIA , 4HRG   , 36 , 1708 , 17 , 6 , 0 , 0 , 0 , 3 , 0 , 19 , 2 , 3 , 5 , 2HTI , 126 , 5 , 10 , 0 , 0 , 2 , 2 , 0 , 6/
   DATA e37/4HTRAP , 4HRG   , 37 , 1808 , 18 , 7 , 0 , 0 , 0 , 4 , 0 , 24 , 2 , 3 , 6 , 2HTA , 394 , 21 , 13 , 0 , 0 , 2 , 2 , 0 ,  &
      & 6/
   DATA e38/4HTORD , 4HRG   , 38 , 1908 , 19 , 7 , 2102 , 21 , 4 , 2 , 0 , 18 , 3 , 3 , 4 , 2HTR , 358 , 16 , 13 , 0 , 0 , 2 , 2 ,  &
      & 0 , 6/
   DATA e39/4HTETR , 4HA    , 39 , 5508 , 55 , 6 , 0 , 0 , 0 , 4 , 0 , 23 , 3 , 3 , 6 , 2HTE , 88 , 9 , 0 , 97 , 0 , 3 , 1 , 0 , 6/
   DATA e40/4HWEDG , 4HE    , 40 , 5608 , 56 , 8 , 0 , 0 , 0 , 6 , 0 , 33 , 3 , 3 , 8 , 2HWG , 128 , 9 , 0 , 97 , 0 , 3 , 1 , 0 , 6/
   DATA e41/4HHEXA , 4H1    , 41 , 5708 , 57 , 10 , 0 , 0 , 0 , 8 , 0 , 43 , 3 , 3 , 10 , 2HH1 , 168 , 9 , 0 , 97 , 0 , 3 , 1 , 0 , &
      & 6/
   DATA e42/4HHEXA , 4H2    , 42 , 5808 , 58 , 10 , 0 , 0 , 0 , 8 , 0 , 43 , 3 , 3 , 10 , 2HH2 , 168 , 9 , 0 , 97 , 0 , 3 , 1 , 0 , &
      & 6/
   DATA e43/4HFLUI , 4HD2   , 43 , 7815 , 78 , 6 , 0 , 0 , 0 , 2 , 0 , 15 , 2 , 0 , 0 , 2HF2 , 0 , 0 , 0 , 0 , 0 , 3 , 1 , 0 , 6/
   DATA e44/4HFLUI , 4HD3   , 44 , 7915 , 79 , 7 , 0 , 0 , 0 , 3 , 0 , 20 , 2 , 0 , 0 , 2HF3 , 0 , 0 , 0 , 0 , 0 , 3 , 1 , 0 , 1/
   DATA e45/4HFLUI , 4HD4   , 45 , 8015 , 80 , 8 , 0 , 0 , 0 , 4 , 0 , 25 , 2 , 0 , 0 , 2HF4 , 0 , 0 , 0 , 0 , 0 , 3 , 1 , 0 , 1/
   DATA e46/4HFLMA , 4HSS   , 46 , 2508 , 25 , 5 , 0 , 0 , 0 , 2 , 0 , 14 , 2 , 0 , 0 , 2HFM , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 , 1/
   DATA e47/4HAXIF , 4H2    , 47 , 2108 , 21 , 6 , 0 , 0 , 0 , 2 , 0 , 15 , 2 , 0 , 0 , 2HA2 , 13 , 5 , 0 , 111 , 0 , 1 , 1 , 0 , 1/
   DATA e48/4HAXIF , 4H3    , 48 , 2208 , 22 , 7 , 0 , 0 , 0 , 3 , 0 , 20 , 2 , 0 , 0 , 2HA3 , 32 , 10 , 0 , 122 , 0 , 1 , 1 , 0 ,  &
      & 1/
   DATA e49/4HAXIF , 4H4    , 49 , 2308 , 23 , 8 , 0 , 0 , 0 , 4 , 0 , 25 , 2 , 0 , 0 , 2HA4 , 49 , 12 , 0 , 122 , 0 , 1 , 1 , 0 ,  &
      & 1/
   DATA e50/4HSLOT , 4H3    , 50 , 4408 , 44 , 8 , 0 , 0 , 0 , 3 , 0 , 21 , 2 , 0 , 0 , 2HS3 , 20 , 6 , 0 , 1 , 0 , 1 , 1 , 0 , 1/
   DATA e51/4HSLOT , 4H4    , 51 , 4508 , 45 , 9 , 0 , 0 , 0 , 4 , 0 , 26 , 2 , 0 , 0 , 2HS4 , 29 , 7 , 0 , 142 , 0 , 1 , 1 , 0 , 1/
   DATA e52/4HHBDY , 4H     , 52 , 4208 , 42 , 15 , 2502 , 25 , 7 , 8 , 0 , 53 , 4 , 3 , 10 , 2HHB , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 0 ,&
      & 1/
   DATA e53/4HDUM1 , 4H     , 53 , 6108 , 61 , 0 , 6102 , 61 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD1 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e54/4HDUM2 , 4H     , 54 , 6208 , 62 , 0 , 6202 , 62 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD2 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e55/4HDUM3 , 4H     , 55 , 6308 , 63 , 0 , 6302 , 63 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD3 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e56/4HDUM4 , 4H     , 56 , 6408 , 64 , 0 , 6402 , 64 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD4 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e57/4HDUM5 , 4H     , 57 , 6508 , 65 , 0 , 6502 , 65 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD5 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e58/4HDUM6 , 4H     , 58 , 6608 , 66 , 0 , 6602 , 66 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD6 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e59/4HDUM7 , 4H     , 59 , 6708 , 67 , 0 , 6702 , 67 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD7 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e60/4HDUM8 , 4H     , 60 , 6808 , 68 , 0 , 6802 , 68 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD8 , 100 , 10 , 10 , 3 , 3 , 4 , 2 ,   &
      & 3 , 6/
   DATA e61/4HDUM9 , 4H     , 61 , 6908 , 69 , 0 , 6902 , 69 , 0 , 0 , 0 , 0 , 3 , 3 , 0 , 2HD9 , 100 , 10 , 10 , 3 , 3 , 4 , 1 ,   &
      & 3 , 6/
   DATA e62/4HQDME , 4HM1   , 62 , 2008 , 20 , 7 , 2202 , 22 , 4 , 4 , 0 , 26 , 3 , 2 , 2 , 2HM1 , 45 , 8 , 0 , 89 , 0 , 5 , 1 , 0 ,&
      & 6/
   DATA e63/4HQDME , 4HM2   , 63 , 5308 , 53 , 7 , 5302 , 53 , 4 , 4 , 0 , 26 , 3 , 2 , 5 , 2HM2 , 250 , 8 , 17 , 89 , 156 , 5 , 1 ,&
      & 0 , 6/
   DATA e64/4HQUAD , 4H4    , 64 , 5408 , 54 , 13 , 5802 , 58 , 17 , 4 , 0 , 45 , 3 , 2 , 7 , 2HQ4 , 2395 , 17 , 9 , 73 , 23 , 1 ,  &
      & 1 , 2 , 6/
   DATA e65/4HIHEX , 4H1    , 65 , 7108 , 71 , 10 , 7002 , 70 , 7 , 8 , 0 , 55 , 3 , 4 , 9 , 2HXL , 649 , 22 , 0 , 191 , 0 , 6 , 1 ,&
      & 4 , 6/
   DATA e66/4HIHEX , 4H2    , 66 , 7208 , 72 , 22 , 7002 , 70 , 7 , 20 , 0 , 127 , 3 , 4 , 21 , 2HXQ , 649 , 22 , 0 , 191 , 0 , 6 , &
      & 1 , 4 , 6/
   DATA e67/4HIHEX , 4H3    , 67 , 7308 , 73 , 34 , 7002 , 70 , 7 , 32 , 0 , 199 , 3 , 4 , 33 , 2HXC , 649 , 23 , 0 , 206 , 0 , 6 , &
      & 1 , 4 , 6/
   DATA e68/4HQUAD , 4HTS   , 68 , 4108 , 41 , 23 , 2402 , 24 , 8 , 8 , 0 , 62 , 3 , 3 , 10 , 2HQS , 4276 , 41 , 49 , 0 , 0 , 2 ,   &
      & 2 , 0 , 6/
   DATA e69/4HTRIA , 4HTS   , 69 , 5908 , 59 , 21 , 2302 , 23 , 8 , 6 , 0 , 52 , 3 , 3 , 8 , 2HTS , 2490 , 33 , 37 , 0 , 0 , 2 , 2 ,&
      & 0 , 6/
   DATA e70/4HTRIA , 4HAX   , 70 , 7012 , 70 , 6 , 7032 , 85 , 17 , 3 , 0 , 34 , 3 , 3 , 5 , 2HTX , 250 , 11 , 14 , 231 , 252 , 2 , &
      & 2 , 0 , 6/
   DATA e71/4HTRAP , 4HAX   , 71 , 7042 , 74 , 7 , 7052 , 95 , 17 , 4 , 0 , 39 , 3 , 3 , 6 , 2HT4 , 954 , 47 , 18 , 279 , 372 , 2 , &
      & 2 , 0 , 6/
   DATA e72/4HAERO , 4H1    , 72 , 3002 , 46 , 6 , 0 , 0 , 0 , 5 , 0 , 0 , 2 , 0 , 0 , 2HAE , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 6/
   DATA e73/4HTRIM , 4H6    , 73 , 6101 , 81 , 9 , 6201 , 82 , 6 , 6 , 0 , 43 , 3 , 4 , 7 , 2HT6 , 233 , 29 , 0 , 73 , 0 , 1 , 1 ,  &
      & 0 , 6/
   DATA e74/4HTRPL , 4HT1   , 74 , 6301 , 83 , 9 , 6401 , 84 , 16 , 6 , 0 , 48 , 3 , 2 , 7 , 2HP6 , 990 , 65 , 16 , 73 , 0 , 1 , 1 ,&
      & 0 , 6/
   DATA e75/4HTRSH , 4HL    , 75 , 7501 , 75 , 9 , 7601 , 76 , 20 , 6 , 0 , 52 , 3 , 2 , 7 , 2HSL , 1200 , 65 , 16 , 73 , 0 , 1 ,   &
      & 1 , 2 , 6/
   DATA e76/4HFHEX , 4H1    , 76 , 9210 , 92 , 10 , 0 , 0 , 0 , 8 , 0 , 43 , 3 , 0 , 0 , 2HFA , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1/
   DATA e77/4HFHEX , 4H2    , 77 , 9310 , 93 , 10 , 0 , 0 , 0 , 8 , 0 , 43 , 3 , 0 , 0 , 2HFB , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1/
   DATA e78/4HFTET , 4HRA   , 78 , 8610 , 86 , 6 , 0 , 0 , 0 , 4 , 0 , 23 , 3 , 0 , 0 , 2HFT , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1/
   DATA e79/4HFWED , 4HGE   , 79 , 8710 , 87 , 8 , 0 , 0 , 0 , 6 , 0 , 33 , 3 , 0 , 0 , 2HFW , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 1/
   DATA e80/4HIS2D , 4H8    , 80 , 2001 , 47 , 12 , 2002 , 56 , 3 , 8 , 0 , 46 , 3 , 3 , 10 , 2HD8 , 215 , 43 , 0 , 411 , 0 , 7 ,   &
      & 7 , 6 , 6/
   DATA e81/4HELBO , 4HW    , 81 , 5101 , 51 , 8 , 5102 , 51 , 24 , 2 , 0 , 39 , 3 , 1 , 15 , 2HEB , 126 , 17 , 12 , 505 , 481 , 1 ,&
      & 1 , 1 , 6/
   DATA e82/4HFTUB , 4HE    , 73 , 8408 , 84 , 4 , 8402 , 84 , 5 , 2 , 0 , 16 , 3 , 1 , 2 , 2HFT , 5 , 0 , 2 , 0 , 0 , 1 , 1 , 0 ,  &
      & 1/
   DATA e83/4HTRIA , 4H3    , 83 , 9108 , 91 , 11 , 5802 , 58 , 17 , 3 , 0 , 39 , 3 , 2 , 7 , 2HT3 , 713 , 17 , 9 , 73 , 23 , 1 ,   &
      & 1 , 2 , 6/
   DATA e84/4HPSE2 , 4H     , 84 , 4302 , 77 , 4 , 4303 , 43 , 5 , 2 , 0 , 16 , 3 , 0 , 0 , 2HP1 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 ,  &
      & 6/
   DATA e85/4HPSE3 , 4H     , 85 , 4802 , 48 , 5 , 4303 , 43 , 5 , 3 , 0 , 21 , 3 , 0 , 0 , 2HP2 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 ,  &
      & 6/
   DATA e86/4HPSE4 , 4H     , 86 , 4902 , 94 , 6 , 4303 , 43 , 5 , 4 , 0 , 26 , 3 , 0 , 0 , 2HP3 , 0 , 0 , 0 , 0 , 0 , 1 , 1 , 1 ,  &
      & 6/
!
!
!     COMPLX DESCRIBES THE MANNER IN WHICH THE TWO PARTS OF COMPLEX
!     STRESSES AND FORCES ARE RELATED TO EACH OTHER.  ANY ELEMENT WHICH
!     HAS COMPLEX STRESS OR FORCE OUTPUT POINTS TO  A STRING WITH WORDS
!     20 AND 21 OF ITS ELEMENT ENTRY.  THE COMPLX TABLE IS USED IN SDR2
!     AND DDRMM, WHICH ARE IN LINKS 13 AND 12 RESPECTIVELY
!
!     EACH STRING IS DEFINDED AS FOLLOWS
!      0  TERMINATES THE FORMAT STRING
!     -N  PUT INTO PRINT BUFFER THE REAL PART OF PAIR
!     +N  (AND  N.LE.I)  PUT BOTH REAL AND IMAGINARY PARTS INTO BUFFER
!     +N  (AND  N.GT.I)  PUT IMAGINARY PART ONLY INTO PRINT BUFFER
!         WHERE    I  =  THE LENGTH OF STRING IN WORD 18 (REAL-STRESS)
!                        OR 19 (REAL-FORCE) PLUS 1
!
   DATA comp1/1 , -2 , -3 , -4 , -5 , -6 , 8 , 9 , 10 , 11 , 12 , 0 , 1 , -2 , 5 , -3 , 6 , 0 , 1 , -2 , 4 , 0 , 1 , -2 , -3 , -4 , &
      & -5 , -6 , -7 , -8 , -9 , 11 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 0 , 1 , -2 , 7 , -4 , 9 , 0 , 1 , -2 , -3 , 6 , 7 , 0 , 1 ,&
      & -2 , -3 , -4 , -5 , -6 , 18 , 19 , 20 , 21 , 22 , -10 , -11 , -12 , -13 , 26 , 27 , 28 , 29 , 0 , 1 , 2 , -3 , 20 , -4 ,    &
      & 21 , -5 , 22 , 10 , -11 , 28 , -12 , 29 , -13 , 30 , 0 , 1 , -2 , -3 , -4 , 10 , 11 , 12 , 0 , 1 , -2 , -3 , -4/
   DATA comp2/ - 5 , -6 , -7 , 11 , 12 , 13 , 14 , 15 , 16 , 0 , 1 , -2 , -3 , -4 , -5 , 7 , 8 , 9 , 10 , 0 , 0 , 1 , -2 , -3 , -4 ,&
      & -5 , -6 , -7 , -8 , -9 , -10 , 12 , 13 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 0 , 1 , -2 , -3 , -4 , -5 , -6 , -7 , 9 , 10 ,  &
      & 11 , 12 , 13 , 14 , 0 , 1 , -2 , -3 , -4 , -5 , -6 , -7 , -8 , -9 , 19 , 20 , 21 , 22 , 23 , 24 , 25 , 26 , -10 , -11 ,     &
      & -12 , -13 , -14 , -15 , -16 , -17 , 27 , 28 , 29 , 30 , 31 , 32 , 33 , 34 , 0 , 0 , 1 , 2 , -3 , -11 , -17 , -4 , -12 ,     &
      & -18 , 25 , 33/
   DATA comp3/39 , 26 , 34 , 40 , 0 , 1 , 2 , -3 , -12 , -18 , -4 , -13 , -19 , 11 , 26 , 35 , 41 , 27 , 36 , 42 , 0 , 0 , 0 , 0 ,  &
      & 0 , 0 , 0 , 0 , 0 , 0 , 1 , 2 , -3 , -4 , -5 , -6 , -7 , -8 , -9 , -10 , -11 , 14 , 15 , 16 , 17 , 18 , 19 , 20 , 21 , 22 , &
      & 0 , 1 , 2 , -3 , -4 , -5 , -6 , 17 , 18 , 19 , 20 , -7 , -8 , -9 , -10 , 21 , 22 , 23 , 24 , -11 , -12 , -13 , -14 , 25 ,   &
      & 26 , 27 , 28 , 0 , 1 , 2 , -3 , -4 , -5 , -6 , -7 , -8 , -9 , -10 , -11 , 50 , 51 , 52 , 53 , 54 , 55 , 56 , 57 , 58 , -12 ,&
      & -13/
   DATA comp4/ - 14 , -15 , -16 , -17 , -18 , -19 , -20 , 59 , 60 , 61 , 62 , 63 , 64 , 65 , 66 , 67 , -21 , -22 , -23 , -24 , -25 ,&
      & -26 , -27 , -28 , -29 , 68 , 69 , 70 , 71 , 72 , 73 , 74 , 75 , 76 , -30 , -31 , -32 , -33 , -34 , -35 , -36 , -37 , -38 ,  &
      & 77 , 78 , 79 , 80 , 81 , 82 , 83 , 84 , 85 , -39 , -40 , -41 , -42 , -43 , -44 , -45 , -46 , -47 , 86 , 87 , 88 , 89 , 90 , &
      & 91 , 92 , 93 , 94 , 0 , 1 , 2 , -3 , -4 , -5 , -6 , 21 , 22 , 23 , 24 , -7 , -8 , -9 , -10 , 25 , 26 , 27 , 28 , -11 , -12 ,&
      & -13 , -14 , 29 , 30 , 31 , 32 , -15 , -16 , -17/
   DATA comp5/ - 18 , 33 , 34 , 35 , 36 , 0 , 0 , 0 , 0 , 0 , 1 , 2 , 3 , 4 , 5 , -6 , 49 , -7 , 50 , -8 , 51 , 9 , 10 , -11 , 54 , &
      & -12 , 55 , -13 , 56 , 14 , 15 , -16 , 59 , -17 , 60 , -18 , 61 , 19 , 20 , -21 , 64 , -22 , 65 , -23 , 66 , 24 , 25 , -26 , &
      & 69 , -27 , 70 , -28 , 71 , 29 , 30 , -31 , 74 , -32 , 75 , -33 , 76 , 34 , 35 , -36 , 79 , -37 , 80 , -38 , 81 , 39 , 40 ,  &
      & -41 , 84 , -42 , 85 , -43 , 86 , 0 , 0 , 0 , 1 , -2 , -3 , -4 , -5 , -6 , -7 , 14 , 15 , 16 , 17 , 18 , 19 , -8 , -9 , -10 ,&
      & -11 , -12 , 20 , 21/
   DATA comp6/22 , 23 , 24 , 0 , 1 , -2 , -3 , -4 , -5 , -6 , 19 , 20 , 21 , 22 , 23 , -10 , -11 , -12 , -13 , -14 , 27 , 28 , 29 , &
      & 30 , 31 , 0 , 0 , 0 , 0 , 0/
END BLOCKDATA gptabd