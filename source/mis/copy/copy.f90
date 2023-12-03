!*==copy.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE copy
   USE c_blank
   USE c_system
   USE c_xfiat
   USE c_xfist
   USE c_zzzzzz
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER :: ibuf1 , ibuf2 , icount , lcore , nzwd
   INTEGER , DIMENSION(15) :: in , out
   INTEGER , SAVE :: input , output
   INTEGER , DIMENSION(7) :: itrl
   INTEGER , DIMENSION(2) , SAVE :: modnam
   EXTERNAL close , cpyfil , korsz , mesage , open , rdtrl , wrttrl
!
! End of declarations rewritten by SPAG
!
!
!     COPY  INPUT /OUTPUT/ PARAM $
!
!     THIS UTILITY MODULE GENERATES A PHYSICAL COPY OF THE INPUT DATA
!     BLOCK IF THE VALUE OF PARAM IS LESS THAN ZERO (DEFAULT IS -1).
!     THE OUTPUT DATA BLOCK CARRIES THE INPUT DATA BLOCK NAME IN THE
!     HEADER RECORD.
!     IF PARAM IS SET TO ZERO, THE OUTPUT DATA BLOCK WILL HAVE ITS OWN
!     NAME IN THE OUTPUT FILE HEADER RECORD.  (IMPLEMENTED IN JUNE 84)
!
!
   DATA input/101/ , output/201/ , modnam/4HCOPY , 4H    /
!
!     RETURN IF IPARAM NOT GREATER THAN ZERO
!
   IF ( iparam==0 ) iparam = -1111
   IF ( iparam>=0 ) RETURN
!
!     COMPUTE OPEN CORE AND INITIALIZE GINO BUFFERS
!
   nzwd = korsz(z(1))
   IF ( nzwd<=0 ) CALL mesage(-8,0,modnam)
   ibuf1 = nzwd - sysbuf
   ibuf2 = ibuf1 - sysbuf
   lcore = ibuf2 - 1
   IF ( lcore<=0 ) CALL mesage(-8,0,modnam)
!
!     OPEN INPUT AND OUTPUT DATA BLOCKS
!
   in(1) = input
   out(1) = output
   itrl(1) = 101
   CALL rdtrl(itrl)
   CALL open(*100,input,z(ibuf1),0)
   CALL open(*200,output,z(ibuf2),1)
   CALL cpyfil(in,out,z(1),lcore,icount)
   CALL close(output,1)
   CALL close(input,1)
   itrl(1) = 201
   CALL wrttrl(itrl)
   RETURN
!
 100  CALL mesage(-1,input,modnam)
 200  CALL mesage(-1,output,modnam)
END SUBROUTINE copy