!*==cmckcd.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE cmckcd
   USE c_blank
   USE c_cmb001
   USE c_cmb002
   USE c_cmb003
   USE c_xmssg
   USE c_zzzzzz
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , DIMENSION(2) , SAVE :: aaa
   INTEGER , DIMENSION(9) :: ce
   REAL , DIMENSION(7,3) :: coord
   REAL , DIMENSION(3) :: diff2
   REAL :: dist , sum
   INTEGER :: i , iadd , ierr , ifile , imsg , it , j , jj , kdh , kk , llco , mm , nnn , npt , nptm1 , nrec
   INTEGER , DIMENSION(7) :: ipnum , ist
   EXTERNAL close , fwdrec , mesage , open , read , skpfil
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     THIS SUBROUTINE DETERMINES WHETHER MANUALLY SPECIFIED CONNECTION
!     ENTRIES ARE ALLOWABLE BASED ON THE PRESCRIBED GEOMETRIC TOLERANCE.
!
   DATA aaa/4HCMCK , 4HCD  /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     READ ALL BGSS INTO OPEN CORE
!
         it = 2
         ierr = 0
         llco = lcore
         j = 0
         ifile = scsfil
         CALL open(*60,scsfil,z(buf2),0)
         DO i = 1 , npsub
            nrec = combo(i,5) + 1
            DO jj = 1 , nrec
               CALL fwdrec(*80,scsfil)
            ENDDO
            CALL read(*80,*10,scsfil,z(score+j),llco,1,nnn)
            spag_nextblock_1 = 3
            CYCLE SPAG_DispatchLoop_1
 10         ist(i) = score + j
            j = j + nnn
            llco = llco - nnn
            CALL skpfil(scsfil,1)
         ENDDO
         CALL close(scsfil,1)
!
!     READ CONNECTION ENTRIES AND LOAD INTO COORD ARRAY
!
         ifile = scconn
         CALL open(*60,scconn,z(buf2),0)
         spag_nextblock_1 = 2
      CASE (2)
         CALL read(*40,*20,scconn,ce,10,1,nnn)
!
!     LOAD COORD ARRAY
!     CE(3)... UP TO CE(9) ARE INTERNAL POINT NO.
!     IZ(IADD) IS THE COORD (CSTM) ID OF THE INTERNAL PTS.
!     Z(IADD+1,+2,+3) ARE THE COORD. ORIGINS
!
 20      npt = 0
         DO i = 1 , npsub
            IF ( ce(i+2)>0 ) THEN
               npt = npt + 1
               iadd = 4*(ce(i+2)-1) + ist(i)
               ipnum(npt) = ce(i+2)
               DO j = 1 , 3
                  coord(npt,j) = z(iadd+j)
               ENDDO
            ENDIF
         ENDDO
!
!     COMPARE ALL PAIRS OF COORDINATES AGAINST TOLER.
!
         nptm1 = npt - 1
         DO i = 1 , nptm1
            it = it - 1
            jj = i + 1
            DO j = jj , npt
               DO kk = 1 , 3
                  diff2(kk) = (coord(j,kk)-coord(i,kk))**2
               ENDDO
               sum = 0.0
               DO kk = 1 , 3
                  sum = sum + diff2(kk)
               ENDDO
               dist = sqrt(sum)
               IF ( dist>toler ) THEN
                  IF ( it<=1 ) THEN
                     WRITE (outt,99001) ufm
99001                FORMAT (A23,' 6514, ERRORS HAVE BEEN FOUND IN MANUALLY SPECIFIED',' CONNECTION ENTRIES. SUMMARY FOLLOWS')
                     ierr = 1
                     idry = -2
                     it = 2
                  ENDIF
                  IF ( it<=2 ) THEN
                     WRITE (outt,99002) (ce(kdh),kdh=1,nnn)
99002                FORMAT ('0*** GEOMETRIC ERRORS HAVE BEEN FOUND IN THE FOLLOWING',' CONNECTION ENTRY',/5X,9I10)
                     it = 3
                  ENDIF
                  WRITE (outt,99003) ipnum(i) , (coord(i,mm),mm=1,3) , ipnum(j) , (coord(j,mm),mm=1,3)
99003             FORMAT ('0*** IP NUMBER',I10,13H COORDINATES ,3E16.6,4H AND,/,'     IP NUMBER',I10,13H COORDINATES ,3E16.6,       &
                         &' ARE NOT WITHIN TOLER UNITS.')
               ENDIF
            ENDDO
         ENDDO
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
!
 40      IF ( ierr==0 ) WRITE (outt,99004) uim
99004    FORMAT (A29,' 6516, ALL MANUAL CONNECTIONS SPECIFIED ARE ','ALLOWABLE WITH RESPECT TO TOLERANCE')
         CALL close(scconn,1)
         RETURN
!
 60      imsg = -1
         spag_nextblock_1 = 4
         CYCLE SPAG_DispatchLoop_1
 80      imsg = -2
         spag_nextblock_1 = 4
      CASE (3)
         imsg = -8
         spag_nextblock_1 = 4
      CASE (4)
         CALL mesage(imsg,ifile,aaa)
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
!
END SUBROUTINE cmckcd