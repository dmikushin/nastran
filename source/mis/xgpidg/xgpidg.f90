!*==xgpidg.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE xgpidg(Ncode,Ix,Jx,K)
   IMPLICIT NONE
   USE c_moddmp
   USE c_stapid
   USE c_system
   USE c_xgpi2
   USE c_xgpi4
   USE c_xgpic
   USE c_xmssg
   USE c_zzzzzz
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Ncode
   INTEGER , DIMENSION(1) :: Ix
   INTEGER , DIMENSION(1) :: Jx
   INTEGER :: K
!
! Local variable declarations rewritten by SPAG
!
   REAL :: bufsz
   INTEGER :: cppgct , i , icode , iday , imnth , isys77 , iyear , j , jday , jmnth , jyear , kdhcod , l , loscar , lx , m , n ,    &
            & nlines , nlpp , nme1 , nodmap , nogo , op , osbot , ospnt , osprc
   INTEGER , DIMENSION(6) :: ibf
   INTEGER , DIMENSION(1) :: med , oscar
   INTEGER , SAVE :: nlabl1 , nlabl2
   REAL , DIMENSION(5) :: os
!
! End of declarations rewritten by SPAG
!
!
! Dummy argument declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     THE PURPOSE OF XGPIDG IS TO WRITE DIAGNOSTIC MESSAGES FOR EXGPI
!
!     ICODE  = A SIGNED INTEGER WHICH INDICATES DIAGNOSTIC MESSAGE TO
!              OUTPUT.
!     NODMAP = DMAP CARD NUMBER.
!
!                  ** CONTROL CARD NAMES **
!                  ** DMAP CARD NAMES **
   !>>>>EQUIVALENCE (Core(1),Os(1),Loscar) , (Osprc,Os(2)) , (Osbot,Os(3)) , (Ospnt,Os(4)) , (Oscar(1),Med(1),Os(5))
   !>>>>EQUIVALENCE (Zsys(1),Bufsz) , (Zsys(2),Op) , (Zsys(3),Nogo) , (Zsys(9),Nlpp) , (Zsys(12),Nlines) , (Zsys(26),Cppgct) ,           &
!>>>>    & (Zsys(77),Isys77)
   !>>>>EQUIVALENCE (Mpl(1),Ibf(1))
   DATA nlabl1/4HLABE/ , nlabl2/4HL   /
!
!     SET NOGO FLAG IF NCODE IS POSITIVE
!
   IF ( Ncode>0 .AND. nogo<1 ) nogo = 1
   IF ( Ncode/=49 ) THEN
      i = Ix(1)
      j = Jx(1)
   ENDIF
   kdhcod = 0
   icode = iabs(Ncode)
!
!     BRANCH ON ICODE AND WRITE ERROR MESSAGE.
!
   IF ( icode==0 .OR. icode>73 ) GOTO 7800
   nlines = nlines + 3
   IF ( nlines>=nlpp ) CALL page
   IF ( icode==1 ) THEN
!
!     ERROR MESSAGE  1   (XIOFL)
!
      ASSIGN 1000 TO l
   ELSEIF ( icode==2 ) THEN
!
!     ERROR MESSAGE  2   (XOSGEN)
!
      ASSIGN 1100 TO l
   ELSEIF ( icode==3 ) THEN
!
!     ERROR MESSAGE  3   (XPARAM)
!
      ASSIGN 1200 TO l
   ELSEIF ( icode==4 ) THEN
!
!     ERROR MESSAGE  4   (XPARAM)
!
      ASSIGN 1300 TO l
      GOTO 400
   ELSEIF ( icode==5 ) THEN
!
!     ERROR MESSAGE  5   (XPARAM)
!
      ASSIGN 1400 TO lx
      GOTO 100
   ELSEIF ( icode==6 ) THEN
!
!     ERROR MESSAGE  6   (XPARAM)
!
      ASSIGN 1500 TO l
   ELSEIF ( icode==7 ) THEN
!
!     ERROR MESSAGE  7   (XPARAM)
!
      ASSIGN 1600 TO l
   ELSEIF ( icode==8 ) THEN
!
!     ERROR MESSAGE  8   (XPARAM)
!
      ASSIGN 1700 TO lx
      GOTO 100
   ELSEIF ( icode==9 ) THEN
!
!     ERROR MESSAGE  9   (XPARAM)
!
      ASSIGN 1800 TO l
   ELSEIF ( icode==10 ) THEN
!
!     ERROR MESSAGE 10   (XOSGEN)
!
      ASSIGN 1900 TO l
      kdhcod = 1
   ELSEIF ( icode==11 ) THEN
!
!     ERROR MESSAGE 11   (XOSGEN)
!
      ASSIGN 2000 TO l
      kdhcod = 1
   ELSEIF ( icode==12 ) THEN
!
!     ERROR MESSAGE 12   (XOSGEN)
!
      ASSIGN 2100 TO lx
      GOTO 100
   ELSEIF ( icode==13 ) THEN
!
!     ERROR MESSAGE 13   (XOSGEN)
!
      ASSIGN 2200 TO lx
      GOTO 100
   ELSEIF ( icode==14 ) THEN
!
!     ERROR MESSAGE 14   (XOSGEN,XPARAM,XFLORD,XGPI,XSCNDM)
!
      ASSIGN 2300 TO lx
      GOTO 800
   ELSEIF ( icode==15 ) THEN
!
!     ERROR MESSAGE 15   (XPARAM)
!
      ASSIGN 2400 TO l
   ELSEIF ( icode==16 ) THEN
!
!     ERROR MESSAGE 16   (XOSGEN)
!
      ASSIGN 2500 TO l
   ELSEIF ( icode==17 ) THEN
!
!     ERROR MESSAGE 17   (XOSGEN)
!
      ASSIGN 2600 TO l
   ELSEIF ( icode==18 ) THEN
!
!     ERROR MESSAGE 18   (XPARAM)
!
      ASSIGN 2700 TO l
   ELSEIF ( icode==19 ) THEN
!
!     ERROR MESSAGE 19   (XOSGEN)
!
      ASSIGN 2800 TO lx
      GOTO 100
   ELSEIF ( icode==20 ) THEN
!
!     ERROR MESSAGE 20   (XOSGEN)
!
      ASSIGN 2900 TO l
   ELSEIF ( icode==21 ) THEN
!
!     ERROR MESSAGE 21   (XOSGEN)
!
      ASSIGN 3000 TO l
   ELSEIF ( icode==22 ) THEN
!
!     ERROR MESSAGE 22   (XFLORD)
!
      ASSIGN 3100 TO l
      kdhcod = 1
   ELSEIF ( icode==23 ) THEN
!
!     ERROR MESSAGE 23   (XFLORD)
!
      ASSIGN 3200 TO l
   ELSEIF ( icode==24 ) THEN
!
!     ERROR MESSAGE 24   (XGPI)
!
      ASSIGN 3300 TO l
      GOTO 400
   ELSEIF ( icode==25 ) THEN
!
!     ERROR MESSAGE 25   (XOSGEN)
!
      ASSIGN 3400 TO l
   ELSEIF ( icode==26 ) THEN
!
!     ERROR MESSAGE 26   (XOSGEN)
!
      ASSIGN 3500 TO l
   ELSEIF ( icode==27 ) THEN
!
!     ERROR MESSAGE 27   (XOSGEN)
!
      ASSIGN 3600 TO lx
      GOTO 100
   ELSEIF ( icode==28 ) THEN
!
!     ERROR MESSAGE 28   (XGPI)
!
      ASSIGN 3700 TO l
!
      ASSIGN 500 TO lx
      GOTO 800
   ELSEIF ( icode==29 ) THEN
!
!     ERROR MESSAGE 29   (XGPI)
!
      ASSIGN 3800 TO l
      ASSIGN 500 TO lx
      GOTO 800
   ELSEIF ( icode==30 ) THEN
!
!     ERROR MESSAGE 30   (XGPI)
!
      ASSIGN 3900 TO l
      ASSIGN 500 TO lx
      GOTO 800
   ELSEIF ( icode==31 ) THEN
!
!     ERROR MESSAGE 31   (XGPI)
!
      ASSIGN 4000 TO l
      GOTO 400
   ELSEIF ( icode==32 ) THEN
!
!     ERROR MESSAGE 32   (XFLORD)
!
      ASSIGN 4100 TO l
   ELSEIF ( icode==33 ) THEN
!
!     ERROR MESSAGE 33   (XGPI)
!
      ASSIGN 4200 TO l
      GOTO 400
   ELSEIF ( icode==34 ) THEN
!
!     ERROR MESSAGE 34   (XSCNDM)
!
      ASSIGN 4300 TO l
      GOTO 400
   ELSEIF ( icode==35 ) THEN
!
!     ERROR MESSAGE 35   (XGPI)
!
      ASSIGN 4400 TO lx
      GOTO 100
   ELSEIF ( icode==36 ) THEN
!
!     ERROR MESSAGE 36   (XGPI)
!
      ASSIGN 4500 TO l
      GOTO 400
   ELSEIF ( icode==37 ) THEN
!
!     ERROR MESSAGE 37   (XGPI)
!
      IF ( isys77<=-1 ) GOTO 99999
      ASSIGN 4600 TO l
   ELSEIF ( icode==38 ) THEN
!
!     ERROR MESSAGE 38   (XGPI)
!
      ASSIGN 4700 TO lx
      GOTO 800
   ELSEIF ( icode==39 ) THEN
!
!     ERROR MESSAGE 39   (XOSGEN)
!
      ASSIGN 4800 TO l
      GOTO 400
   ELSEIF ( icode==40 ) THEN
!
!     ERROR MESSAGE 40   (XSCNDM)
!
      ASSIGN 4900 TO lx
      GOTO 100
   ELSEIF ( icode==41 ) THEN
!
!     ERROR MESSAGE 41   (XFLDEF)
!
      ASSIGN 5000 TO l
      GOTO 400
   ELSEIF ( icode==42 ) THEN
!
!     ERROR MESSAGE 42   (XPARAM)
!
      ASSIGN 5100 TO l
   ELSEIF ( icode==43 ) THEN
!
!     ERROR MESSAGE 43   (XOSGEN)
!
      ASSIGN 5200 TO l
   ELSEIF ( icode==44 ) THEN
!
!     ERROR MESSAGE 44   (XSCNDM)
!
      ASSIGN 5300 TO l
   ELSEIF ( icode==45 ) THEN
!
!     ERROR MESSAGE 45   (XFLORD)
!
      ASSIGN 5400 TO l
      kdhcod = 1
   ELSEIF ( icode==46 ) THEN
!
!     ERROR MESSAGE 46   (XGPI)
!
      ASSIGN 5500 TO lx
      GOTO 100
   ELSEIF ( icode==47 ) THEN
!
!     ERROR MESSAGE 47   (XFLORD)
!
      ASSIGN 5600 TO l
   ELSEIF ( icode==48 ) THEN
!
!     ERROR MESSAGE 48   (XOSGEN)
!
      ASSIGN 5700 TO l
   ELSEIF ( icode==49 ) THEN
!
!     ERROR MESSAGE 49   (XGPIBS,XOSGEN)
!
      ASSIGN 5800 TO l
      GOTO 400
   ELSEIF ( icode==50 ) THEN
!
!     ERROR MESSAGE 50   (XGPI)
!
      ASSIGN 5900 TO l
      GOTO 400
   ELSEIF ( icode==51 ) THEN
!
!     ERROR MESSAGE 51   (XGPIBS)
!
      ASSIGN 6000 TO lx
      GOTO 800
   ELSEIF ( icode==52 ) THEN
!
!     ERROR MESSAGE 52   (XGPIBS)
!
      ASSIGN 6100 TO lx
      GOTO 800
   ELSEIF ( icode==53 ) THEN
!
!     ERROR MESSAGE 53   (XGPIBS)
!
      ASSIGN 6200 TO lx
      GOTO 700
   ELSEIF ( icode==54 ) THEN
!
!     ERROR MESSAGE 54   (XGPI)
!
      ASSIGN 6300 TO lx
      GOTO 600
   ELSEIF ( icode==55 ) THEN
!
!     ERROR MESSAGE 55   (XOSGEN)
!
      ASSIGN 6400 TO lx
      GOTO 700
   ELSEIF ( icode==56 ) THEN
!
!     ERROR MESSAGE 56   (XOSGEN)
!
      ASSIGN 6500 TO lx
      GOTO 600
   ELSEIF ( icode==57 ) THEN
!
!     ERROR MESSAGE 57   (XOSGEN)
!
      ASSIGN 6600 TO lx
      GOTO 700
   ELSEIF ( icode==58 ) THEN
!
!     ERROR MESSAGE 58   (XOSGEN)
!
      ASSIGN 6700 TO lx
      GOTO 700
   ELSEIF ( icode==59 ) THEN
!
!     ERROR MESSAGE 59   (OSCXRF)
!
      ASSIGN 6800 TO lx
      kdhcod = 1
      GOTO 600
   ELSEIF ( icode==60 ) THEN
!
!     ERROR MESSAGE 60   (OSCXRF)
!
      ASSIGN 6900 TO lx
      kdhcod = 1
      GOTO 600
   ELSEIF ( icode==61 ) THEN
!
!     ERROR MESSAGE 61   (XOSGEN)
!
      ASSIGN 7000 TO l
   ELSEIF ( icode==62 ) THEN
!
!     ERROR MESSAGE 62   (XIPFL)
!
      ASSIGN 7100 TO l
   ELSEIF ( icode==63 ) THEN
!
!     ERROR MESSAGE 63   (XIPFL)
!
      ASSIGN 7200 TO l
   ELSEIF ( icode==64 .OR. icode==65 .OR. icode==66 .OR. icode==67 .OR. icode==68 ) THEN
      GOTO 7800
   ELSEIF ( icode==69 ) THEN
!
!     ERROR MESSAGE 69   (XGPI)
!
      ASSIGN 7300 TO lx
      GOTO 800
   ELSEIF ( icode==70 ) THEN
!
!     ERROR MESSAGE 70   (XGPI)
!
      ASSIGN 7400 TO lx
      GOTO 800
   ELSEIF ( icode==71 ) THEN
!
!     ERROR MESSAGE 71   (XGPI)
!
      ASSIGN 7500 TO lx
      GOTO 800
   ELSEIF ( icode==72 ) THEN
!
!     ERROR MESSAGE 72   (XGPI)
!
      ASSIGN 7600 TO lx
      GOTO 800
   ELSEIF ( icode==73 ) THEN
!
!     ERROR MESSAGE 73   (XGPI)
!
      ASSIGN 7700 TO lx
      GOTO 800
   ENDIF
!
!     STANDARD ERROR MESSAGES
!
   nodmap = andf(oscar(i+5),nosgn)
   ASSIGN 200 TO lx
 100  IF ( Ncode<0 ) GOTO 600
   IF ( Ncode==0 ) GOTO 7800
   GOTO 700
 200  nme1 = oscar(i+3)
   IF ( Ncode<0 ) THEN
      WRITE (op,99001) nme1 , oscar(i+4) , nodmap
99001 FORMAT (30X,'POSSIBLE ERROR IN DMAP INSTRUCTION ',2A4,3X,'INSTRUCTION NO.',I4)
   ELSE
      WRITE (op,99079) nme1 , oscar(i+4) , nodmap
   ENDIF
 300  GOTO l
!
 400  ASSIGN 300 TO lx
   IF ( Ncode<0 ) THEN
      WRITE (op,99002) swm , icode
99002 FORMAT (A27,I4,1H,)
      GOTO 900
   ELSEIF ( Ncode==0 ) THEN
      GOTO 7800
   ELSE
      GOTO 800
   ENDIF
 500  WRITE (op,99003)
99003 FORMAT (30X,'UNEXPECTED END OF TAPE.')
   GOTO l
!
 600  IF ( kdhcod==1 ) THEN
      WRITE (op,99004) icode
99004 FORMAT (/,' *** USER POTENTIALLY FATAL MESSAGE',I4,1H,)
      IF ( iflg(2)<2 ) nogo = 1
   ELSE
      WRITE (op,99005) uwm , icode
99005 FORMAT (A25,I5,1H,)
   ENDIF
   GOTO 900
 700  WRITE (op,99006) ufm , icode
99006 FORMAT (A23,I4,1H,)
   GOTO 900
 800  WRITE (op,99007) sfm , icode
99007 FORMAT (A25,I4,1H,)
!
 900  GOTO lx
 1000 WRITE (op,99008)
99008 FORMAT (5X,'ASSUMED FIRST INPUT DATA BLOCK IS NULL')
   GOTO 99999
 1100 WRITE (op,99009) j , K
99009 FORMAT (5X,'PARAMETER NAMED ',2A4,' IS DUPLICATED')
   GOTO 99999
 1200 WRITE (op,99010) j
99010 FORMAT (5X,'FORMAT ERROR IN PARAMETER NO.',I3)
   GOTO 99999
 1300 WRITE (op,99011) oscar(i+3) , oscar(i+4) , j
99011 FORMAT (5X,'MPL PARAMETER ERROR,MODULE NAME = ',2A4,3X,'PARAMETER NO.',I3)
   GOTO 99999
 1400 WRITE (op,99012) j , K
99012 FORMAT (30X,'PARAMETER INPUT DATA ERROR, ILLEGAL TYPE FOR ','PARAMETER NAMED ',2A4,1H.)
   GOTO 99999
 1500 WRITE (op,99013) j
99013 FORMAT (5X,'ILLEGAL TYPE FOR PARAMETER NO.',I3)
   GOTO 99999
 1600 WRITE (op,99014) j
99014 FORMAT (5X,'PARAMETER NO.',I3,' NEEDS PARAMETER NAME')
   GOTO 99999
 1700 WRITE (op,99015) j , K
99015 FORMAT (30X,'BULK DATA PARAM CARD ERROR - MUST NOT DEFINE ','PARAMETER NAMED ',2A4,1H.)
   GOTO 99999
 1800 WRITE (op,99016) j
99016 FORMAT (5X,'VALUE NEEDED FOR PARAMETER NO.',I3)
   GOTO 99999
 1900 WRITE (op,99017)
99017 FORMAT (5X,'DEFAULT OPTION FOR INPUT DATA BLOCKS - MAKE SURE ','MISSING BLOCKS ARE NOT REQUIRED.')
   GOTO 99999
 2000 WRITE (op,99018)
99018 FORMAT (5X,'DEFAULT OPTION FOR OUTPUT DATA BLOCKS - MAKE SURE ','MISSING BLOCKS ARE NOT REQUIRED.')
   GOTO 99999
 2100 WRITE (op,99019) j
99019 FORMAT (30X,'ERROR IN DMAP INSTRUCTION NO.',I4,', ILLEGAL CHARACTER IN DMAP INSTRUCTION NAME.')
   GOTO 99999
 2200 WRITE (op,99079) dmap(j) , dmap(j+1) , K
   WRITE (op,99020)
99020 FORMAT (30X,'DMAP INSTRUCTION NOT IN MODULE LIBRARY.')
   GOTO 99999
 2300 WRITE (op,99021) i , j
99021 FORMAT (5X,'ARRAY NAMED ',2A4,' OVERFLOWED')
   IF ( K/=0 ) THEN
      WRITE (op,99022) K
99022 FORMAT (50X,'AT DMAP INSTRUCTION NO. ',I4,1H.)
   ENDIF
   GOTO 99999
 2400 WRITE (op,99023) j , K
99023 FORMAT (5X,'INCONSISTENT TYPE USED FOR PARAMETER NAMED ',2A4)
   GOTO 99999
 2500 WRITE (op,99024)
99024 FORMAT (5X,'ILLEGAL FORMAT')
   GOTO 99999
 2600 WRITE (op,99025)
99025 FORMAT (5X,'ILLEGAL TIME SEGMENT NAME - NO TIME ESTIMATES MADE',' FOR THIS TIME SEGMENT (WARNING ONLY)')
   GOTO 99999
 2700 WRITE (op,99026)
99026 FORMAT (5X,'TOO MANY PARAMETERS IN DMAP PARAMETER LIST')
   GOTO 99999
 2800 WRITE (op,99079) nlabl1 , nlabl2 , i
   WRITE (op,99027) dmap(j) , dmap(j+1)
99027 FORMAT (30X,'LABEL NAMED ',2A4,' IS MULTIPLY DEFINED.')
   GOTO 99999
 2900 WRITE (op,99028) j
99028 FORMAT (5X,'ILLEGAL CHARACTERS IN PARAMETER NO.',I3)
   GOTO 99999
 3000 WRITE (op,99029) j , K
99029 FORMAT (5X,'PARAMETER NAMED ',2A4,' IS NOT IN PRECEDING DMAP ','INSTRUCTION PARAMETER LIST')
   GOTO 99999
 3100 WRITE (op,99030) j , K
99030 FORMAT (5X,'DATA BLOCK NAMED ',2A4,' APPEARS AS INPUT BEFORE ','BEING DEFINED')
   GOTO 99999
 3200 WRITE (op,99031) j , K
99031 FORMAT (5X,'DATA BLOCK NAMED ',2A4,' IS NOT REFERENCED IN ','SUBSEQUENT FUNCTIONAL MODULE')
   GOTO 99999
 3300 WRITE (op,99032) i , j
99032 FORMAT (5X,'CANNOT FIND DATA BLOCK NAMED ',2A4,' ON DATA POOL ','TABLE ')
   GOTO 99999
 3400 WRITE (op,99033) j , K
99033 FORMAT (5X,'PARAMETER NAMED ',2A4,' NOT DEFINED')
   GOTO 99999
 3500 WRITE (op,99034) j , K
99034 FORMAT (5X,'LABEL NAMED ',2A4,' NOT DEFINED')
   GOTO 99999
 3600 WRITE (op,99035) j , K
99035 FORMAT (5X,'LABEL NAMED ',2A4,' NOT REFERENCED')
   GOTO 99999
 3700 WRITE (op,99036)
99036 FORMAT (61X,'ON NEW PROBLEM TAPE.')
   GOTO 99999
 3800 WRITE (op,99037)
99037 FORMAT (61X,'ON OLD PROBLEM TAPE.')
   GOTO 99999
 3900 WRITE (op,99038)
99038 FORMAT (61X,'ON DATA POOL FILE.')
   GOTO 99999
 4000 WRITE (op,99039) i , j
99039 FORMAT (5X,'CONTROL FILE ',2A4,' INCOMPLETE OR MISSING ON NEW ','PROBLEM TAPE')
   GOTO 99999
 4100 WRITE (op,99040) j , K
99040 FORMAT (5X,'DATA BLOCK NAMED ',2A4,' MUST BE DEFINED PRIOR TO ','THIS INSTRUCTION')
   GOTO 99999
 4200 WRITE (op,99041) i , j
99041 FORMAT (5X,'SCRATCH FILE CONTAINING DMAP DATA COULD NOT BE ','OPENED IN SUBROUTINE ',2A4)
   GOTO 99999
 4300 WRITE (op,99042) j
99042 FORMAT (5X,'CANNOT TRANSLATE DMAP INSTRUCTION NO.',I3)
   GOTO 99999
 4400 m = lshift(ibf(5),7)
   iyear = rshift(andf(m,maskhi),7)
   m = rshift(m,6)
   iday = rshift(andf(m,maskhi),9)
   m = rshift(m,5)
   imnth = rshift(andf(m,maskhi),10)
   n = lshift(otapid(5),7)
   jyear = rshift(andf(n,maskhi),7)
   n = rshift(n,6)
   jday = rshift(andf(n,maskhi),9)
   n = rshift(n,5)
   jmnth = rshift(andf(n,maskhi),10)
   WRITE (op,99043) (ibf(i),m=1,4) , imnth , iday , iyear , ibf(6) , (otapid(j),n=1,4) , jmnth , jday , jyear , otapid(6)
99043 FORMAT (30X,'INCORRECT OLD PROBLEM TAPE MOUNTED -',/5X,'ID OF TAPE MOUNTED= ',2A4,1H,,2A4,1H,,I3,1H/,I2,1H/,I2,'REEL=',I2,/5X,&
             &'ID OF TAPE DESIRED= ',2A4,1H,,2A4,1H,,I3,1H/,I2,1H/,I2,'REEL=',I2)
   GOTO 99999
 4500 WRITE (op,99044) i , j
99044 FORMAT (5X,'CANNOT FIND DATA BLOCK NAMED ',2A4,' ON OLD PROBLEM',' TAPE')
   GOTO 99999
 4600 WRITE (op,99045) j , K
99045 FORMAT (5X,'WARNING ONLY - MAY NOT BE ENOUGH FILES AVAILABLE FOR','MODULE REQUIREMENTS',/5X,'FILES NEEDED =',I4,5X,           &
             &'FILES AVAILABLE =',I4)
   GOTO 99999
 4700 WRITE (op,99046)
99046 FORMAT (5X,'NOT ENOUGH CORE FOR GPI TABLES.')
   WRITE (op,99080) i
   GOTO 99999
 4800 WRITE (op,99047)
99047 FORMAT (5X,'RIGID FORMAT DMAP SEQUENCE DOES NOT CORRESPOND TO ','MED TABLE')
   GOTO 99999
 4900 WRITE (op,99048)
99048 FORMAT (5X,'ERROR IN ALTER DECK - CANNOT FIND END OF DMAP ','INSTRUCTION')
   GOTO 99999
 5000 WRITE (op,99049) i , j
99049 FORMAT (5X,'TABLES INCORRECT FOR REGENERATING DATA BLOCK ',2A4)
   GOTO 99999
 5100 WRITE (op,99050) j , K
99050 FORMAT (5X,'PARAMETER NAMED ',2A4,' ALREADY HAD VALUE ASSIGNED ','PREVIOUSLY')
   GOTO 99999
 5200 WRITE (op,99051)
99051 FORMAT (5X,'ILLEGAL TYPE FOR CONSTANT VALUE')
   GOTO 99999
 5300 WRITE (op,99052)
99052 FORMAT (5X,'UNABLE TO FIND END DMAP INSTRUCTION')
   GOTO 99999
 5400 WRITE (op,99053) j , K
99053 FORMAT (5X,'DATA BLOCK NAMED ',2A4,' ALREADY APPEARED AS OUTPUT')
   GOTO 99999
 5500 WRITE (op,99054)
99054 FORMAT (5X,'INCORRECT REENTRY POINT')
   GOTO 99999
 5600 WRITE (op,99055)
99055 FORMAT (5X,'THIS INSTRUCTION CANNOT BE FIRST INSTRUCTION OF LOOP')
   GOTO 99999
 5700 WRITE (op,99056) j , K
99056 FORMAT (5X,'DATA SET ',2A4,' IS ALWAYS REGENERATED, THEREFORE IT','WILL NOT BE CHECKPOINTED')
   GOTO 99999
 5800 WRITE (op,99057)
99057 FORMAT (5X,'MPL TABLE (MODULE PROPERTIES LIST) IS INCORRECT')
   IF ( i/=0 ) THEN
      nlines = nlines + 1
      WRITE (op,99058) i , j , K
99058 FORMAT (5X,'DECIMAL LOCATION RELATIVE TO MPL(1) = ',I10,',MODULE NAME = ',2A4)
   ENDIF
   GOTO 99999
 5900 WRITE (op,99059)
99059 FORMAT (5X,'CANNOT FIND JUMP OSCAR ENTRY NEEDED FOR THIS RESTART')
   GOTO 99999
 6000 WRITE (op,99060)
99060 FORMAT (5X,'NOT ENOUGH OPEN CORE FOR XGPIBS ROUTINE')
   WRITE (op,99080) i
   GOTO 99999
 6100 WRITE (op,99061)
99061 FORMAT (5X,'NAMED COMMON /XLINK/ IS TOO SMALL')
   GOTO 99999
 6200 WRITE (op,99062)
99062 FORMAT (5X,'INCORRECT FORMAT IN ABOVE CARD')
   GOTO 99999
 6300 WRITE (op,99063) j , K
99063 FORMAT (5X,'PARAMETER NAMED ',2A4,' NOT REFERENCED')
   GOTO 99999
 6400 WRITE (op,99064)
99064 FORMAT (5X,'PRECHK NAME LIST EXCEEDS MAXIMUM LIMIT (50)')
   GOTO 99999
 6500 WRITE (op,99065)
99065 FORMAT (5X,'ILLEGAL OPTION ON XDMAP CARD - IGNORED')
   GOTO 99999
 6600 WRITE (op,99066)
99066 FORMAT (5X,'VARIABLE REPT PARAMETER MUST BE AN INTEGER')
   GOTO 99999
 6700 WRITE (op,99067)
99067 FORMAT (5X,'VARIABLE REPT PARAMETER MUST BE DEFINED PRIOR TO ','INSTRUCTION')
   GOTO 99999
 6800 WRITE (op,99068)
99068 FORMAT (5X,'POOL FILE ERROR - DMAP CROSS-REF TERMINATED.')
   GOTO 99999
 6900 WRITE (op,99069)
99069 FORMAT (5X,'INSUFFICIENT OPEN CORE FOR DMAP CROSS-REF - ','TERMINATED.')
   WRITE (op,99080) i
   GOTO 99999
 7000 WRITE (op,99070)
99070 FORMAT (5X,'SAVE INSTRUCTION OUT OF SEQUENCE')
   GOTO 99999
 7100 WRITE (op,99071)
99071 FORMAT (5X,'INCORRECT NUMBER OF INPUT DATA BLOCKS ENCOUNTERED')
   GOTO 99999
 7200 WRITE (op,99072)
99072 FORMAT (5X,'INCORRECT NUMBER OF OUTPUT DATA BLOCKS ENCOUNTERED')
   GOTO 99999
 7300 WRITE (op,99073) i , j
99073 FORMAT (5X,'SUBROUTINE ',2A4,' FINDS RIGID FORMAT OR MED TABLE ','RECORD MISSING ON SCRATCH FILE',/5X,                        &
             &'MOST LIKELY DUE TO INSUFFECIENT CORE')
!
!   * NOTE - DATA ON SCRATCH FILE MAY BE DESTROYED BY XSORT2 *
   GOTO 99999
 7400 WRITE (op,99074) i , j , K
99074 FORMAT (5X,'SUBROUTINE ',2A4,' FINDS ',A4,' NAME TABLE RECORD ','MISSING ON SCRATCH FILE')
   GOTO 99999
 7500 WRITE (op,99075) i
99075 FORMAT (5X,'ILLEGAL NUMBER OF WORDS (',I8,') IN MED TABLE RECORD',' ON SCRATCH FILE')
   GOTO 99999
 7600 WRITE (op,99076) i , j
99076 FORMAT (5X,'ILLEGAL NUMBER OF WORDS (',I8,') IN ',A4,' NAME TABLE RECORD ON SCRATCH FILE')
   GOTO 99999
 7700 WRITE (op,99077) i
99077 FORMAT (5X,'ONE OR MORE ILLEGAL BIT NUMBERS SPECIFIED IN ',A4,' NAME TABLE')
   GOTO 99999
!
 7800 WRITE (op,99078) icode
99078 FORMAT (//5X,'NO MESSAGE AVAILABLE FOR ERROR CODE =',I4)
99079 FORMAT (30X,'ERROR IN DMAP INSTRUCTION ',2A4,3X,'INSTRUCTION NO.',I4)
99080 FORMAT (5X,'ADDITIONAL CORE NEEDED =',I8,' WORDS.')
!
!
99999 END SUBROUTINE xgpidg
