
SUBROUTINE ectloc(*,Ect,Buf,Ielem)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Elem(1) , Incr , Last , Nelem
   COMMON /gpta1 / Nelem , Last , Incr , Elem
!
! Dummy argument declarations
!
   INTEGER Ect , Ielem
   INTEGER Buf(3)
!
! Local variable declarations
!
   INTEGER i , nread , plotel
!
! End of declarations
!
!*****
! ECTLOC IS A SPECIAL PURPOSE VERSION OF SUBROUTINE LOCATE.  ITS
! PURPOSE IS TO PASS THE ECT FILE SEQUENTIALLY POSITIONING EACH LOGICAL
! RECORD AFTER THE 3-WORD HEADER AND PROVIDING A POINTER TO THE
! APPROPRIATE ENTRY IN THE ELEM TABLE IN /GPTA1/. PLOTEL
! ELEMENTS ARE IGNORED.
!     NOTE---THE ECT FILE MUST BE OPEN ON EACH CALL.
!
!  ARGUMENTS
!
!     ECT   ---INPUT ---EINO FILE NAME OF THE ECT
!     BUF   ---IN/OUT---ADDRESS OF A 3-WORD ARRAY INTO WHICH
!                       THE FIRST 3 WORDS OF THE RECORD ARE READ
!     IELEM ---OUTPUT---POINTER TO 1ST WORD OF ENTRY IN ELEM
!                       TABLE IN /GPTA1/
!
! NON-STANDARD RETURN---GIVEN WHEN EOF HIT. ECT IS CLOSED BEFORE RETURN.
!*****
!
!
   DATA plotel/4HPLOT/
!
! READ A 3-WORD RECORD HEADER. IF NOT 3 WORDS, TRY NEXT RECORD
!
 100  CALL read(*400,*100,Ect,Buf,3,0,nread)
!
! SEARCH FOR MATCH OF FIRST WORD OF RECORD WITH ECT-ID WORD IN /GPTA1/
! IF FOUND AND NOT PLOTEL, RETURN POINTER.
!
   DO i = 1 , Last , Incr
      IF ( Buf(1)==Elem(i+3) ) GOTO 300
   ENDDO
 200  CALL fwdrec(*400,Ect)
   GOTO 100
 300  IF ( Elem(i)==plotel ) GOTO 200
   Ielem = i
   RETURN
!
! EOF ENCOUNTERED--CLOSE FILE AND RETURN.
!
 400  CALL close(Ect,1)
   Ielem = 0
   RETURN 1
END SUBROUTINE ectloc