
SUBROUTINE rcovr
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL Dry , Fss(2) , Pa , Pthres , Qa , Qthres , Range(2) , Rfno , Rss(2) , Step , Ua , Uimpro , Uinms(2,5) , Uthres
   INTEGER Energy , Iopt , Ireq , Lbasic , Loop , Lreq , Lui , Mrecvr , Neigv , Nosort
   COMMON /blank / Dry , Loop , Step , Fss , Rfno , Neigv , Lui , Uinms , Nosort , Uthres , Pthres , Qthres
   COMMON /rcovcm/ Mrecvr , Ua , Pa , Qa , Iopt , Rss , Energy , Uimpro , Range , Ireq , Lreq , Lbasic
!
! End of declarations
!
!
!     MAIN DRIVER FOR PHASE 2 SUBSTRUCTURING RECOVER OPERATION
!
!     THIS MODULE WILL CALCULATE THE DISPLACEMENT AND REACTION MATRICES
!     FOR ANY OF THE SUBSTRUCTURES COMPOSING THE FINAL SOLUTION STRUC-
!     TURE.  OUTPUT DATA MAY BE PLACED ON OFP PRINT FILES OR SAVED ON
!     THE SOF FOR SUBSEQUENT PROCESSING.
!
!     DMAP CALLING SEQUENCES
!
!     RIGID FORMATS 1 AND 2  (STATIC ANALYSIS)
!
!     RCOVR   CASESS,GEOM4,KGG,MGG,PG,UGV,,,,,/OUGV1,OPG1,OQG1,U1,
!             U2,U3,U4,U5/DRY/ILOOP/STEP/FSS/RFNO/0/LUI/U1NM/U2NM/
!             U3NM/U4NM/U5NM/S,N,NOSORT2/V,Y,UTHRESH/V,Y,PTHRESH/
!             V,Y,QTHRESH $
!
!     RIGID FORMAT 3  (MODAL ANALYSIS)
!
!     RCOVR   CASESS,LAMA,KGG,MGG,,PHIG,,,,,/OPHIG,,OQG1,U1,U2,U3,
!             U4,U5/DRY/ILOOP/STEP/FSS/RFNO/NEIGV/LUI/U1NM/U2NM/
!             U3NM/U4NM/U5NM/S,N,NOSORT2/V,Y,UTHRESH/V,Y,PTHRESH/
!             V,Y,QTHRESH $
!
!     RIGID FORMAT 8  (FREQUENCY ANALYSIS)
!
!     RCOVR   CASESS,GEOM4,KGG,MGG,PPF,UPVC,DIT,DLT,BGG,K4GG,PPF/
!             OUGV1,OPG1,OQG1,U1,U2,U3,U4,U5/DRY/ILOOP/STEP/FSS/
!             RFNO/0/LUI/U1NM/U2NM/U3NM/U4UN/U5NM/S,N,NOSORT2/
!             V,Y,UTHRESH/V,Y,PTHRESH/V,Y,QTHRESH $
!
!     RIGID FORMAT 9  (TRANSIENT ANALYSIS)
!
!     RCOVR   CASESS,GEOM4,KGG,MGG,PPT,UPV,DIT,DLT,BGG,K4GG,TOL/
!             OUGV1,OPG1,OQG1,U1,U2,U3,U4,U5/DRY/ILOOP/STEP/FSS/
!             RFNO/0/LUI/U1NM/U2NM/U3NM/U4UN/U5NM/S,N,NOSORT2/
!             V,Y,UTHRESH/V,Y,PTHRESH/V,Y,QTHRESH $
!
!     MRECOVER  (ANY RIGID FORMAT)
!
!     RCOVR   ,,,,,,,,,,/OPHIG,,OQG1,U1,U2,U3,U4,U5/DRY/ILOOP/
!             STEP/FSS/3/NEIGV/LUI/U1NM/U2NM/U3NM/U4NM/U5NM/
!             S,N,NOSORT2/V,Y,UTHRESH/V,Y,PTHRESH/V,Y,QTHRESH $
!
!     MAJOR SUBROUTINES FOR RCOVR ARE -
!
!     RCOVA - COMPUTES THE SOLN ITEM FOR THE FINAL SOLUTION STRUCTURE
!     RCOVB - PERFORMS BACK-SUBSTITUTION TO RECOVER DISPLACEMENTS OF
!             LOWER LEVEL SUBSTRUCTURES FROM THOSE OF THE FINAL SOLUTION
!             STRUCTURE
!     RCOVC - COMPUTES REACTION MATRICES AND WRITES OUTPUT DATA BLOCKS
!             FOR THE OFP
!     RCOVO - PROCESS CASESS FOR THE RCOVER COMMAND AND ANY OUTPUT
!             REQUESTS SPECIFIED
!     RCOVE - COMPUTES MODAL ENERGIES AND ERRORS FOR A MODAL REDUCED
!             SUBSTRUCTURE
!
!     JUNE 1977
!
!
   Nosort = -1
   CALL rcovo
   CALL rcova
   IF ( Iopt>=0 ) THEN
      CALL rcovb
      IF ( Iopt>0 ) THEN
         CALL rcovc
         IF ( Energy/=0 ) CALL rcove
      ENDIF
   ENDIF
END SUBROUTINE rcovr
