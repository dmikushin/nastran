
SUBROUTINE decode(Code,List,N)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER Two(32)
   COMMON /two   / Two
!
! Dummy argument declarations
!
   INTEGER Code , N
   INTEGER List(1)
!
! Local variable declarations
!
   INTEGER andf
   INTEGER i
   EXTERNAL andf
!
! End of declarations
!
!
!     DECODE DECODES THE BITS IN A WORD AND RETURNS A LIST OF INTEGERS
!     CORRESPONDING TO THE BIT POSITIONS WHICH ARE ON. NUMBERING
!     CONVENTION IS RIGHT (LOW ORDER) TO LEFT (HIGH ORDER) 00 THRU 31.
!
!     ARGUMENTS
!
!     CODE - INPUT  - THE WORD TO BE DECODED
!     LIST - OUTPUT - AN ARRAY OF DIMENSION .GE. 32 WHERE THE INTEGERS
!                     CORRESPONDING TO BIT POSITIONS ARE STORED
!     N    - OUTPUT - THE NUMBER OF ENTRIES IN THE LIST  I.E. THE NO.
!                     OF 1-BITS IN THE WORD
!
!
!
   N = 0
   DO i = 1 , 32
      IF ( andf(Two(33-i),Code)/=0 ) THEN
         N = N + 1
         List(N) = i - 1
      ENDIF
   ENDDO
!
END SUBROUTINE decode
