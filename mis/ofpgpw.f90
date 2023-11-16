
SUBROUTINE ofpgpw(*,File,Out,From)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL Core(1) , Dummy(10)
   INTEGER Ibuf , L , L1 , L2 , L3 , L4 , L5 , Line , Of(5)
   COMMON /system/ Ibuf , L , Dummy , Line
   COMMON /zzzzzz/ Core
!
! Dummy argument declarations
!
   INTEGER File , From
   DOUBLE PRECISION Out(1)
!
! Local variable declarations
!
   INTEGER flag , i
!
! End of declarations
!
!
!     PRINT GRID POINT WEIGHT GENERATORN TABLE
!     (SOURCE PROGRAM ORIGINALLY CODED IN OFP)
!
   EQUIVALENCE (L1,Of(1),Core(1)) , (L2,Of(2)) , (L3,Of(3)) , (L4,Of(4)) , (L5,Of(5))
!
!     FOR GRIDPOINT WEIGHT OUTPUT ONLY ONE DATA VECTOR OF 78 WORDS
!     IS EXPECTED AND IT IS THUS READ AND OUTPUT EXPLICITLY
!     (CHANGED TO D.P. BY G.CHAN/UNISYS, AND THEREFORE 156 WORDS.
!     THIS RECORD IS SENT OVER BY GPWG1B, WHICH IS NOW A D.P. ROUTINE)
!
   From = 345
   CALL read(*200,*100,File,Out(1),90,0,flag)
   L1 = 0
   L2 = 0
   L3 = 202
   L4 = 0
   L5 = 0
   CALL ofp1
   Line = Line + 44
   WRITE (L,99001) (Out(i),i=1,45)
99001 FORMAT (37X,'MO - RIGID BODY MASS MATRIX IN BASIC COORDINATE SYSTEM',/16X,3H***,93X,3H***,/6(16X,1H*,1P,6D16.8,2H *,/),16X,   &
             &3H***,93X,3H***,/40X,51HS - TRANSFORMATION MATRIX FOR SCALAR MASS PARTITION,/2(40X,3H***,5X),                         &
            & /3(40X,1H*,1P,3D16.8,2H *,/),2(40X,3H***,5X),/25X,9HDIRECTION,/20X,20HMASS AXIS SYSTEM (S),7X,4HMASS,17X,6HX-C.G.,11X,&
             &6HY-C.G.,11X,6HZ-C.G.)
   From = 355
   CALL read(*200,*100,File,Out(1),66,1,flag)
   WRITE (L,99002) (Out(i),i=1,12)
99002 FORMAT (28X,1HX,1P,D27.9,1P,D21.9,1P,2D17.9,/28X,1HY,1P,D27.9,1P,D21.9,1P,2D17.9,/28X,1HZ,1P,D27.9,1P,D21.9,1P,2D17.9)
   WRITE (L,99003) (Out(i),i=13,33)
99003 FORMAT (/49X,33HI(S) - INERTIAS RELATIVE TO C.G. ,/2(38X,3H***,11X),/3(38X,1H*,1P,3D17.9,3H  *,/),2(38X,3H***,11X),/54X,      &
             &25HI(Q) - PRINCIPAL INERTIAS,/2(38X,3H***,11X),/38X,1H*,1P,D17.9,36X,1H*,/38X,1H*,1P,D34.9,19X,1H*,/38X,1H*,1P,D51.9, &
             &3H  *,/2(38X,3H***,11X),/44X,44HQ - TRANSFORMATION MATRIX - I(Q) = QT*I(S)*Q,/2(38X,3H***,11X),                       &
             &/3(38X,1H*,1P,3D17.9,3H  *,/),2(38X,3H***,11X))
 100  RETURN
!
 200  RETURN 1
END SUBROUTINE ofpgpw