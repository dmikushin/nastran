
SUBROUTINE copy
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Ifiat(1) , Ifist(1) , Iparam , Sysbuf
   REAL Z(1)
   COMMON /blank / Iparam
   COMMON /system/ Sysbuf
   COMMON /xfiat / Ifiat
   COMMON /xfist / Ifist
   COMMON /zzzzzz/ Z
!
! Local variable declarations
!
   INTEGER ibuf1 , ibuf2 , icount , in(15) , input , itrl(7) , lcore , modnam(2) , nzwd , out(15) , output
   INTEGER korsz
!
! End of declarations
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
   IF ( Iparam==0 ) Iparam = -1111
   IF ( Iparam>=0 ) RETURN
!
!     COMPUTE OPEN CORE AND INITIALIZE GINO BUFFERS
!
   nzwd = korsz(Z(1))
   IF ( nzwd<=0 ) CALL mesage(-8,0,modnam)
   ibuf1 = nzwd - Sysbuf
   ibuf2 = ibuf1 - Sysbuf
   lcore = ibuf2 - 1
   IF ( lcore<=0 ) CALL mesage(-8,0,modnam)
!
!     OPEN INPUT AND OUTPUT DATA BLOCKS
!
   in(1) = input
   out(1) = output
   itrl(1) = 101
   CALL rdtrl(itrl)
   CALL open(*100,input,Z(ibuf1),0)
   CALL open(*200,output,Z(ibuf2),1)
   CALL cpyfil(in,out,Z(1),lcore,icount)
   CALL close(output,1)
   CALL close(input,1)
   itrl(1) = 201
   CALL wrttrl(itrl)
   RETURN
!
 100  CALL mesage(-1,input,modnam)
 200  CALL mesage(-1,output,modnam)
END SUBROUTINE copy