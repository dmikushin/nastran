!*==/home/marcusmae/nasa/nastran/SPAGged/C_MACHIN.f90  created by SPAG 7.61RG at 01:00 on 21 Mar 2022
MODULE C_MACHIN
!
!     *****  PRINCIPAL BLOCK DATA PROGRAM FOR NASTRAN  *****
!     (NOTE - MACHINE DEPENDENT CONSTANTS ARE INITIALIZED IN BTSTRP)
!
!     REVISED 7/91 BY G.CHAN/UNISYS
!     MAKE SURE THERE IS NO VARIABLES OR ARRAYS NOT INITIALIZED. GAPS
!     OR MISSING INITIALIZED DATA MAY CAUSE PROBLEMS IN SOME MACHINES.
!
   INTEGER, DIMENSION(6) :: Ma
!
!     --------------     /MACHIN/ AND /LHPWX/     ---------------------
!
!     6 MACHINE CONSTANTS IN /MACHIN/ AND 7 IN /LHPWX/ WILL BE
!     INITIALZED BY BTSTRP. THESE CONSTANTS NEED TO BE SAVED IN THE ROOT
!     LEVEL OF ALL LINKS
!
   DATA ma/6*0/
!
END MODULE C_MACHIN