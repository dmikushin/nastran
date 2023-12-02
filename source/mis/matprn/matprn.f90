!*==matprn.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE matprn
   USE c_blank
   USE c_system
   USE c_xmssg
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: i , iout , iprec , ityp , ndpl , npl
   INTEGER , DIMENSION(7) :: mcb
   EXTERNAL matdum , rdtrl
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     MATRIX PRINT MODULE
!     WILL PRINT UP TO 5 DBi INPUT MATRICES
!     INPUT MATRICES CAN BE IN S.P, D.P, S.P.COMPLEX, OR D.P.COMPLEX
!
!     MATPRN  DB1,DB2,DB3,DB4,DB5//C,N,P1/C,N,P2/C,N,P3/C,N,P4/C,N,P5/
!                                  C,N,P6
!
!     WHERE   P1 AND P2 ARE PRINT FORMAT CONTROLS
!             P1 = 0, MATRICES PRINTED IN THEIR ORIG. PREC. (DEFAULT),
!                = 1, MATRICES PRINTED IN S.P. PREC. (e.g.  x.xxxE+xx)
!                = 2, MATRICES PRINTED IN D.P. PREC. (e.g. -x.xxxD+xx)
!                =-1, ONLY THE DIAGONAL ELEMENTS OF THE MATRIX WILL BE
!                     PRINTED IN THEIR ORIG. PRECISON
!             P2 = NO. OF DATA VALUES PRINTED PER LINE (132 DIGITS/LINE)
!                = 8 TO 14 IF MATRICES ARE PRINTED IN S.P. (DEFAULT=10)
!                = 6 TO 12 IF MATRICES ARE PRINTED IN D.P. (DEFAULT= 9)
!
!             P3, P4, P5 ARE PRINTOUT CONTROLS
!             P3 = m, MATRIX COLUMNS, 1 THRU m, WILL BE PRINTED.
!                  DEFAULT = 0, ALL MATRIX COLUMNS WILL BE PRINTED.
!                =-m, SEE P4 = -n
!             P4 = n, LAST n MATRIX COLUMNS ARE PRINTED. DEFAULT = 0
!                =-n, AND P3 = -m, EVERY OTHER n MATRIX COLUMNS WILL BE
!                  PRINTED, STARTIN FROM COLUMN m.
!             P5 = k, EACH PRINTED COLUMN WILL NOT EXCEED k LINES LONG
!                  AND THE REMAINING DATA WILL BE OMITTED.
!             P6 = LU, WHERE LU LOGICAL FILE NUMBER = 11(UT1), 12(UT2),
!                  14(INPT), 15(INT1),...,23(INT9), 24(IBM'S INPT).
!                  DEFAULT IS ZERO, SYSTEM PRINTER.
!                  IF LU IS 11 THRU 24, THE MATRIX PRINTOUT IS SAVED IN
!                  FORTRAN UNIT LU.
!
!
!     LAST REVISED BY G.CHAN/UNISYS
!     12/91, NEW MODULE PARAMETERS TO ALLOW USER SOME CONTROL OVER
!            POSSIBLY MASSIVE MATRIX PRINTOUT
!     8/92,  TO PRINT ONLY THE DIAGONAL ELEMENTS FOR POSSIBLY MATRIX
!            SINGULARITY CHECK, AND PARAMETER P6
!
!
   IF ( p1>2 .OR. p2>14 ) THEN
      WRITE (nout,99001) uwm , p1 , p2 , p3 , p4 , p5 , p6
99001 FORMAT (A25,', MATPRN PARAMETERS APPEAR IN ERROR.  P1,P2,P3,P4,','P5,P6 =',6I5,/5X,'P1 IS RESET TO ZERO, AND P2 TO 6 TO',     &
             &' 14 DEPENDING ON TYPE OF DATA')
!
!     CHECK THAT USER REALY WANTS TO SET P3,P4,P5, AND INSTEAD HE SETS
!     THEM TO P1,P2,P3
!
      IF ( p4==0 .AND. p5==0 .AND. p3<=50 ) THEN
         p3 = p1
         p4 = p2
         p5 = p3
         WRITE (nout,99002) p3 , p4 , p5
99002    FORMAT (5X,'P3,P4,P5 ARE SET TO ',3I5)
      ENDIF
   ENDIF
   DO i = 1 , 5
      spag_nextblock_1 = 1
      SPAG_DispatchLoop_1: DO
         SELECT CASE (spag_nextblock_1)
         CASE (1)
            mcb(1) = 100 + i
            CALL rdtrl(mcb(1))
            IF ( mcb(1)<0 ) CYCLE
            IF ( p1==-1 ) THEN
               spag_nextblock_1 = 5
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            ityp = mcb(5)
            ndpl = p2
            IF ( ndpl==0 ) THEN
               ndpl = 9
               IF ( mod(ityp,2)==1 ) ndpl = 10
            ENDIF
            npl = ndpl
            IF ( ityp==2 ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            IF ( ityp==3 ) THEN
               ndpl = (ndpl/2)*2
               npl = ndpl
               IF ( p1>0 .AND. p1<=2 ) THEN
                  IF ( p1==1 ) THEN
                  ELSEIF ( p1==2 ) THEN
                     spag_nextblock_1 = 3
                     CYCLE SPAG_DispatchLoop_1
                  ELSE
                     spag_nextblock_1 = 4
                     CYCLE SPAG_DispatchLoop_1
                  ENDIF
               ENDIF
            ELSEIF ( ityp==4 ) THEN
               spag_nextblock_1 = 4
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            spag_nextblock_1 = 2
         CASE (2)
            IF ( ndpl<8 ) npl = 8
            IF ( ndpl>14 ) npl = 14
            spag_nextblock_1 = 5
         CASE (3)
            IF ( ndpl<6 ) npl = 6
            IF ( ndpl>12 ) npl = 12
            spag_nextblock_1 = 5
         CASE (4)
            ndpl = (ndpl/2)*2
            npl = ndpl
            IF ( p1<=0 .OR. p1>2 ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            IF ( p1==1 ) THEN
               spag_nextblock_1 = 2
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            IF ( p1==2 ) THEN
               spag_nextblock_1 = 3
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            spag_nextblock_1 = 5
         CASE (5)
            iprec = p1
            IF ( iprec/=1 .AND. iprec/=2 .AND. p1/=-1 ) THEN
               iprec = 2
               IF ( mod(ityp,2)==1 ) iprec = 1
            ENDIF
            iout = nout
            IF ( p6>=11 .AND. p6<=24 ) iout = p6
            CALL matdum(mcb(1),iprec,npl,iout)
            EXIT SPAG_DispatchLoop_1
         END SELECT
      ENDDO SPAG_DispatchLoop_1
   ENDDO
END SUBROUTINE matprn
