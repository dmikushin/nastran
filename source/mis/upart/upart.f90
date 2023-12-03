!*==upart.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE upart(Uset,Scr1,Major,Sub0,Sub1)
   USE c_parmeg
   USE c_patx
   USE c_zzzzzz
   USE C_PARMEG
   USE C_PATX
   USE C_ZZZZZZ
   IMPLICIT NONE
   REAL Core(1)
   INTEGER Ia(7) , Ia11(7) , Ia12(7) , Ia21(7) , Ia22(7) , Lc , Lcore , N1 , N2 , N3 , Pvect(7) , Rule , Uset1
   COMMON /parmeg/ Ia , Ia11 , Ia12 , Ia21 , Ia22 , Lcore , Rule
   COMMON /patx  / Lc , N1 , N2 , N3 , Uset1 , Pvect
   COMMON /zzzzzz/ Core
   INTEGER ia1 , ia111 , ia121 , ia211 , ia221 , Major , Scr1 , Sub0 , Sub1 , Uset
   INTEGER i , j , n4
   INTEGER korsz
!
!     UPART ALONG WITH MPART WILL PERFORM A SYMMETRIC PARTITION OF A
!     MATRIX
!
!
!
!
   Uset1 = Uset
!
!     TRANSFER OF PVECT TRAILER AS LOADED BY CALCV IS NOW BY /PATX/
!
   Rule = 0
   Lc = korsz(Core)
   Lcore = Lc
   CALL calcv(Scr1,Major,Sub0,Sub1,Core)
   n4 = N2 + N3
   Ia11(2) = N1
   Ia11(3) = N1
   Ia21(2) = n4
   Ia21(3) = N1
   Ia21(4) = 2
   Ia12(2) = N1
   Ia12(3) = n4
   Ia12(4) = 2
   Ia22(2) = n4
   Ia22(3) = n4
   CALL spag_block_1
CONTAINS
   SUBROUTINE spag_block_1
      USE C_PARMEG
      USE C_PATX
      USE C_ZZZZZZ
      RETURN
!
!
      ENTRY mpart(Ia1,Ia111,Ia121,Ia211,Ia221)
!     =========================================
!
      Ia(1) = Ia1
      CALL rdtrl(Ia)
      IF ( Ia(1)>=0 ) THEN
         Ia11(1) = Ia111
         Ia12(1) = Ia121
         Ia21(1) = Ia211
         Ia22(1) = Ia221
         Ia11(4) = Ia(4)
         Ia11(5) = Ia(5)
         Ia21(5) = Ia(5)
         Ia12(5) = Ia(5)
         Ia22(4) = Ia(4)
         Ia22(5) = Ia(5)
         CALL partn(Pvect,Pvect,Core)
         DO I = 1 , 4
            J = (I-1)*7 + 1
            IF ( Ia11(J)/=0 ) CALL wrttrl(Ia11(J))
         ENDDO
      ENDIF
      CALL spag_block_1
   END SUBROUTINE spag_block_1
END SUBROUTINE upart