!*==mred2j.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE mred2j(Nuf,N2)
   USE c_blank
   USE c_packx
   USE c_zzzzzz
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Nuf
   INTEGER :: N2
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: i , ifile , iform , imsg , kolumn , phiss , rprtn
   INTEGER , DIMENSION(7) :: itrlr1
   INTEGER , DIMENSION(2) , SAVE :: modnam
   REAL :: phiss1 , phiss2
   EXTERNAL close , gmprtn , gopen , makmcb , mesage , pack , rdtrl , sofcls , wrttrl
!
! End of declarations rewritten by SPAG
!
!
!     THIS SUBROUTINE PARTITIONS THE PHISS MATRIX FOR THE MRED2 MODULE.
!
   !>>>>EQUIVALENCE (Phiss,Infile(3)) , (Phiss1,Iscr(8)) , (Phiss2,Iscr(9)) , (Rprtn,Iscr(10))
   DATA modnam/4HMRED , 4H2J  /
!
!     SET UP PARTITIONING VECTOR
!
   IF ( dry==-2 ) RETURN
   typin = 1
   typout = 1
   irow = 1
   incr = 1
!
!     COMMENTS FROM G.CHAN/UNISYS    4/92
!     ORIGINALLY AT THIS POINT, THE FOLLOWING DO 20 LOOP IS IN ERROR
!       1. KOLUMN AND J ARE NOT DEFINED
!       2. NROW AND ITRLR1 ARE ALSO NOT YET DEFINED
!
!     MY BEST GUESS IS THE NEXT 10 LINES THAT FOLLOW
!
   ifile = phiss
   itrlr1(1) = phiss
   CALL rdtrl(itrlr1)
   IF ( itrlr1(1)<0 ) THEN
!
!     PROCESS SYSTEM FATAL ERRORS
!
      imsg = -1
      CALL sofcls
      CALL mesage(imsg,ifile,modnam)
      RETURN
   ENDIF
   kolumn = itrlr1(2)
   nrow = itrlr1(3)
   DO i = 1 , kolumn
      rz(korbgn+i-1) = 0.0
      IF ( i>Nuf ) rz(korbgn+i-1) = 1.0
   ENDDO
!
   iform = 7
   CALL makmcb(itrlr1,rprtn,nrow,iform,itrlr1(5))
   CALL gopen(rprtn,rz(gbuf1),1)
   CALL pack(rz(korbgn),rprtn,itrlr1)
   CALL close(rprtn,1)
   CALL wrttrl(itrlr1)
!
!     PARTITION PHISS MATRIX
!
!        **     **   **               **
!        *       *   *        .        *
!        * PHISS * = * PHISS1 . PHISS2 *
!        *       *   *        .        *
!        **     **   **               **
!
   itrlr1(1) = phiss
   CALL rdtrl(itrlr1)
   N2 = nmodes - Nuf
   CALL gmprtn(phiss,phiss1,0,phiss2,0,rprtn,0,Nuf,N2,rz(korbgn),korlen)
END SUBROUTINE mred2j