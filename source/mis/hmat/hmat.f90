!*==hmat.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE hmat(Id)
USE c_hmatdd
USE c_hmtout
USE c_matin
USE c_names
USE c_system
USE c_xmssg
USE c_zzzzzz
USE C_HMATDD
USE C_HMTOUT
USE C_MATIN
USE C_NAMES
USE C_SYSTEM
USE C_XMSSG
USE C_ZZZZZZ
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Id
   *0() :: 
!
! Local variable declarations rewritten by SPAG
!
   LOGICAL :: any4 , any5 , anyt4 , anyt5
   REAL , DIMENSION(10) :: card
   INTEGER :: core , flag , i , icheck , idit , igbuf , ihmat , imat , imat4 , imat5 , imatt4 , imatt5 , itabno , itemp , itherm ,  &
            & iwords , j , j1 , j2 , j4 , j5 , jpoint , k , kk , lbuf , lused , lz , mat4s , mat5s , mats , matt4s , matt5s , n4 ,  &
            & n5 , ndit , nhmat , nmat4 , nmat5 , nmatt4 , nmatt5 , ntabno , ntemp , offset , oldflg , oldmid , outpt ,             &
            & spag_nextblock_1 , sysbuf , tset , type
   REAL :: cs , cs2kxy , csq , f4 , f5 , factor , oldcos , oldsin , oldstp , oldtem , ssq , x
   INTEGER , DIMENSION(2) , SAVE :: mat4 , mat5 , matt4 , matt5 , name
   INTEGER , SAVE :: noeor
   REAL , DIMENSION(1) :: Rz
   INTEGER , DIMENSION(16) , SAVE :: tablst
!
! End of declarations rewritten by SPAG
!
!
!     MAT ROUTINE FOR USE IN -HEAT- FORMULATIONS ONLY.
!
!         CALL PREHMA (Z)  SETUP CALL MADE BY SMA1A, EMGTAB, ETC.
!
!         CALL HMAT (ELID)  ELEMENT ROUTINE CALLS
!
!
!     REVISED BY G.CHAN/UNISYS
!     5/90 - THE THERMAL CONDUCTIVITY OR CONVECTIVE FILM COEFFICIENT K,
!            IS TIME DEPENDENT IF MATT4 REFERS TO TABLEM5. TIME STEP IS
!            DEFINED VIA TSTEP IN /HMATDD/. IF TIME STEP IS NOT USED,
!            TSTEP SHOULD BE -999.
!            (TSTEP IS INITIALIZED TO -999. WHEN PREHMA IS CALLED)
!     7/92 - NEW REFERENCE TO OPEN CORE ARRAY SUCH THAT THE SOURCE CODE
!            IS UP TO ANSI FORTRAN 77 STANDARD.
!
   !>>>>EQUIVALENCE (Ksystm(1),Sysbuf) , (Ksystm(2),Outpt) , (Ksystm(10),Tset) , (Ksystm(56),Itherm) , (f4,n4) , (f5,n5)
   DATA name/4HHMAT , 4H    / , noeor/0/
   DATA mat4/2103 , 21/
   DATA mat5/2203 , 22/
   DATA matt4/2303 , 23/
   DATA matt5/2403 , 24/
   DATA tablst/5 , 105 , 1 , 1 , 205 , 2 , 2 , 305 , 3 , 3 , 405 , 4 , 4 , 505 , 5 , 5/
   spag_nextblock_1 = 1
   SPAG_DISPATCHLOOP_1:DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
!     CALL BUG (4HHMTI,0,MATID,6)
!
         IF ( icheck/=123456789 ) CALL errtrc('HMAT    ',0)
!
!                 DATA RETURNED IF MAT-ID       DATA RETURNED IF MAT-ID
!     INFLAG      IS ON A MAT4 CARD             IS ON A MAT5 CARD.
!     =================================================================
!
!       1           1- K                               1- KXX
!                   2- CP                              2- CP
!
!       2           1- K                               1- KXXB
!                   2- 0.0                             2- KXYB
!                   3- K                               3- KYYB
!                   4- CP                              4- CP
!
!       3           1- K                               1- KXX
!                   2- 0.0                             2- KXY
!                   3- 0.0                             3- KXZ
!                   4- K                               4- KYY
!                   5- 0.0                             5- KYZ
!                   6- K                               6- KZZ
!                   7- CP                              7- CP
!
!       4           1- CP                              1- CP
!
!
!
!
!     DATA LOOK UP SECTION.  FIND MAT-ID IN CARD IMAGES.
!
!
         IF ( Inflag/=oldflg ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         IF ( Matid/=oldmid ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         IF ( Eltemp/=oldtem ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         IF ( Tstep/=oldstp ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         IF ( type==4 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         IF ( S/=oldsin ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
!
!     ALL INPUTS SEEM TO BE SAME THUS RETURN IS MADE.
!
         IF ( C/=oldcos ) THEN
            spag_nextblock_1 = 4
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         spag_nextblock_1 = 6
         CYCLE SPAG_DISPATCHLOOP_1
!
!
         ENTRY prehma(Rz)
!     =================
!
         IF ( itherm<=0 ) THEN
!
!     ERROR - HMAT CALLED IN NON-THERMAL PROBLEM.
!
            WRITE (outpt,99001) Sfm
99001       FORMAT (A25,' 3062, HMAT MATERIAL ROUTINE CALLED IN A NON-HEAT-','TRANSFER PROBLEM.')
            CALL mesage(-61,0,0)
            RETURN
         ELSE
            icheck = 123456789
            offset = locfx(Rz(1)) - locfx(Z(1))
            IF ( offset<0 ) CALL errtrc('HMAT    ',10)
            Tstep = -999.
            ihmat = Ihmatx + offset
            nhmat = Nhmatx + offset
            lbuf = nhmat - sysbuf
            core = lbuf - ihmat
            IF ( core<10 ) CALL mesage(-8,0,name)
            CALL preloc(*180,Z(lbuf),Mpt)
!
!     LOCATE MAT4 CARDS AND BLAST THEM INTO CORE.
!
            Anytab = .FALSE.
            any4 = .FALSE.
            imat4 = ihmat + 1
            nmat4 = ihmat
            CALL locate(*40,Z(lbuf),mat4,flag)
            CALL read(*260,*20,Mpt,Z(imat4),core,noeor,iwords)
            CALL mesage(-8,0,name)
         ENDIF
 20      nmat4 = nmat4 + iwords
 40      mat4s = (nmat4-imat4+1)/3
         IF ( mat4s>0 ) any4 = .TRUE.
!
!     LOCATE MATT4 CARDS AND BLAST THEM INTO CORE IF THERE WERE ANY MAT4
!
         anyt4 = .FALSE.
         imatt4 = nmat4 + 1
         nmatt4 = nmat4
         IF ( .NOT.any4 .OR. (tset==0 .AND. Tstep<0.) ) GOTO 80
         CALL locate(*80,Z(lbuf),matt4,flag)
         CALL read(*260,*60,Mpt,Z(imatt4),core,noeor,iwords)
         CALL mesage(-8,0,name)
 60      nmatt4 = nmatt4 + iwords
 80      matt4s = (nmatt4-imatt4+1)/2
         IF ( matt4s>0 ) anyt4 = .TRUE.
!
!     LOCATE MAT5 CARDS AND BLAST THEM INTO CORE.
!
         any5 = .FALSE.
         imat5 = nmatt4 + 1
         nmat5 = nmatt4
         CALL locate(*120,Z(lbuf),mat5,flag)
         CALL read(*260,*100,Mpt,Z(imat5),core,noeor,iwords)
         CALL mesage(-8,0,name)
 100     nmat5 = nmat5 + iwords
 120     mat5s = (nmat5-imat5+1)/8
         IF ( mat5s>0 ) any5 = .TRUE.
!
!     LOCATE MATT5 CARDS AND BLAST THEM INTO CORE IF THERE WERE ANY MAT5
!
         anyt5 = .FALSE.
         imatt5 = nmat5 + 1
         nmatt5 = nmat5
         IF ( .NOT.any5 .OR. (tset==0 .AND. Tstep<0.) ) GOTO 160
         CALL locate(*160,Z(lbuf),matt5,flag)
         CALL read(*260,*140,Mpt,Z(imatt5),core,noeor,iwords)
         CALL mesage(-8,0,name)
 140     nmatt5 = nmatt5 + iwords
 160     matt5s = (nmatt5-imatt5+1)/7
         IF ( matt5s>0 ) anyt5 = .TRUE.
         CALL close(Mpt,Clsrew)
!
!     IF A TEMPERATURE SET IS SPECIFIED -DIT- IS NOW READ INTO CORE,
!     PROVIDING ANY MATT4 OR MATT5 CARDS WERE PLACED INTO CORE.
!
         IF ( (tset==0 .AND. Tstep<0.) .OR. (.NOT.anyt4 .AND. .NOT.anyt5) ) THEN
            nhmat = nmatt5
         ELSE
!
!     BUILD LIST OF TABLE NUMBERS POSSIBLE FOR REFERENCE
!
            kk = 0
            itabno = nmatt5 + 1
            ntabno = itabno
!
            IF ( matt4s>0 ) THEN
               SPAG_LOOP_1_1:DO i = imatt4 , nmatt4 , 2
                  f4 = Z(i+1)
                  IF ( n4>0 ) THEN
                     IF ( kk>0 ) THEN
                        DO j = itabno , ntabno
                           f5 = Z(j)
                           IF ( n4==n5 ) GOTO 165
                        ENDDO
                     ENDIF
!
!     ADD NEW TABLE ID TO LIST
!
                     ntabno = ntabno + 1
                     Z(ntabno) = Z(i+1)
                     kk = 1
                  ENDIF
 165           ENDDO SPAG_LOOP_1_1
            ENDIF
!
            IF ( matt5s>0 ) THEN
               DO i = imatt5 , nmatt5 , 7
                  j1 = i + 1
                  j2 = i + 6
                  SPAG_LOOP_2_2:DO j = j1 , j2
                     f4 = Z(j)
                     IF ( n4>0 ) THEN
                        IF ( kk>0 ) THEN
                           DO k = itabno , ntabno
                              f5 = Z(k)
                              IF ( n4==n5 ) GOTO 166
                           ENDDO
                        ENDIF
!
!     ADD NEW TABLE ID TO LIST
!
                        ntabno = ntabno + 1
                        Z(ntabno) = Z(j)
                        kk = 1
                     ENDIF
 166              ENDDO SPAG_LOOP_2_2
               ENDDO
            ENDIF
!
            n4 = ntabno - itabno
            Z(itabno) = f4
!
!     CALL BUG (4HTABL,120,Z(ITABNO),NTABNO-ITABNO+1)
!
            IF ( n4<=0 ) THEN
               nhmat = nmatt5
            ELSE
               CALL sort(0,0,1,1,Z(itabno+1),n4)
!
!     OK READ IN DIRECT-INPUT-TABLE (DIT)
!
               idit = ntabno + 1
               igbuf = nhmat - sysbuf - 2
               lz = igbuf - idit - 1
               IF ( lz<10 ) CALL mesage(-8,0,name)
               CALL pretab(Dit,Z(idit),Z(idit),Z(igbuf),lz,lused,Z(itabno),tablst)
               ndit = idit + lused
!
!     CALL BUG (4HDITS,123,Z(IDIT),NDIT-IDIT+1)
!
               nhmat = ndit + 1
            ENDIF
         ENDIF
         spag_nextblock_1 = 2
         CYCLE SPAG_DISPATCHLOOP_1
!
!     WRAP UP THE PRE-HMAT SECTION
!
 180     nhmat = ihmat - 1
         any4 = .FALSE.
         any5 = .FALSE.
         spag_nextblock_1 = 2
      CASE (2)
         oldmid = 0
         oldflg = 0
         oldsin = 0.0
         oldcos = 0.0
         oldtem = 0.0
         oldstp = 0.0
         S = 0.0
         C = 0.0
         Dum(1) = 0.0
         Eltemp = 0.0
         Nhmatx = nhmat - offset
!
!     CHECK FOR DUPLICATE MATID-S ON BOTH MAT4 AND MAT5 CARDS.
!
         IF ( .NOT.any4 .OR. .NOT.any5 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         j4 = imat4
         j5 = imat5
         f4 = Z(j4)
         f5 = Z(j5)
         spag_nextblock_1 = 3
      CASE (3)
         SPAG_LOOP_1_3:DO
            IF ( n4<n5 ) THEN
!
!     MAT4 ID IS LESS THAN MAT5 ID
!
               j4 = j4 + 3
               IF ( j4>nmat4 ) THEN
                  spag_nextblock_1 = 6
                  GOTO 300
               ENDIF
               f4 = Z(j4)
            ELSEIF ( n4==n5 ) THEN
!
!     ID OF MAT4 IS SAME AS THAT OF MAT5
!
               WRITE (outpt,99002) Uwm , n4
99002          FORMAT (A25,' 2155, MAT4 AND MAT5 MATERIAL DATA CARDS HAVE SAME ','ID =',I14,/5X,                                    &
                      &'MAT4 DATA WILL BE SUPPLIED WHEN CALLED ','FOR THIS ID.')
               EXIT SPAG_LOOP_1_3
            ELSE
               EXIT SPAG_LOOP_1_3
            ENDIF
         ENDDO SPAG_LOOP_1_3
!
!     MAT5 ID IS LESS THAN MAT4 ID.
!
         j5 = j5 + 8
         IF ( j5>nmat5 ) THEN
            spag_nextblock_1 = 6
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
         f5 = Z(j5)
         spag_nextblock_1 = 3
      CASE (4)
!
!     FIND POINTER TO SECOND WORD OF CARD IMAGE WITH MAT-ID DESIRED.
!     AMONG EITHER MAT4S OR MAT5S.
!
         oldflg = Inflag
         oldmid = Matid
         oldcos = C
         oldsin = S
         oldtem = Eltemp
         oldstp = Tstep
         Linear = .TRUE.
         IF ( any4 ) THEN
            CALL bisloc(*200,Matid,Z(imat4),3,mat4s,jpoint)
            j = imat4 + jpoint
            type = 4
            spag_nextblock_1 = 5
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
 200     IF ( .NOT.any5 ) GOTO 240
         CALL bisloc(*240,Matid,Z(imat5),8,mat5s,jpoint)
         j = imat5 + jpoint
         type = 5
         spag_nextblock_1 = 5
      CASE (5)
!
!     IF A THERMAL SET IS REQUESTED (TSET.NE.0) THEN A FACTOR, WHICH IS
!     A FUNCTION OF THE AVERAGE ELEMENT TEMPERATURE, ELTEMP, (OR TIME
!     STEP, TSTEP) AND THE TABULATED VALUE IN TABLEMI, IS USED AS A
!     MULTIPLIER TO THE K-TERMS IN MAT4 OR MATT5
!
!     IF THE MATERIAL ID IS FOUND ON A -MAT4- AN ATTEMPT IS MADE TO FIND
!     A CORRESPONDING -MATT4- CARD.  LIKEWISE THIS IS DONE IF THE
!     MATERIAL ID IS FOUND ON A -MAT5- CARD WITH RESPECT TO A -MATT5-
!     CARD. IF THE -MAT4- OR -MAT5- HAS A RESPECTIVE -MATT4- OR -MATT5-
!     CARD, THEN THE THERMAL CONDUCTIVITY OR THE CONVECTIVE FILM COEFF.
!     K, IS TEMPERATURE DEPENDENT IF TABLEM1, TABLEM2, TABLEM3 AND
!     TABLEM4 ARE REFERENECED. K IS TIME DEPENDENT IF TABLEM5 IS USED.
!     THE K-TERMS OF THE -MAT4- OR -MAT5- CARDS WILL BE MODIFIED BY
!     USING -ELTEMP- AND THE -DIT- AS SPECIFIED IN THE RESPECTIVE FIELDS
!     OF THE RESPECTIVE -MATT4- OR -MATT5- CARD.  A ZERO T(K) IN A
!     PARTICULAR FIELD OF THE RESPECTIVE -MATT4- OR -MATT5- CARD IMPLIES
!     NO TEMPERATURE DEPENDENCE FOR THAT RESPECTIVE K VALUE.
!     -DIT- TABLES TABLEM1, TABLEM2, TABLEM3, TABLEM4 AND TABLEM5 MAY BE
!     USED.
!
!
!     MOVE MAT CARD INTO SPECIAL BUF WHERE IT CAN BE MODIFIED IF
!     NECESSARY
!
         DO i = 1 , 10
            card(i) = Z(j)
            j = j + 1
         ENDDO
!
!     CHECK FOR EXISTENCE OF A THERMAL SET REQUEST OR TIME STEP.
!
         IF ( .NOT.((tset==0 .AND. Tstep<0.) .OR. Inflag==4) ) THEN
!
!     IF -MAT4- CARD, FIND THE -MATT4- CARD
!     (IF NO MATT4 ASSUME NO TEMPERATURE OR TIME DEPENDENCE)
!
            IF ( type==5 ) THEN
               iwords = 7
               imat = imatt5
               mats = matt5s
            ELSE
               iwords = 2
               imat = imatt4
               mats = matt4s
            ENDIF
            IF ( mats>0 ) THEN
               CALL bisloc(*220,Matid,Z(imat),iwords,mats,jpoint)
               itemp = imat + jpoint
               ntemp = itemp + iwords - 2
!
!     Z(I) FIELDS SPECIFYING A NON-ZERO TABLE IMPLY TEMPERATURE (OR
!     TIME) DEPENDENCE ON CORRESPONDING FIELDS OF THE MAT4 OR MAT5
!     STORED IN THE ARRAY -CARD-.
!
               kk = 0
               DO i = itemp , ntemp
                  kk = kk + 1
                  f4 = Z(i)
                  IF ( n4>0 ) THEN
!
!     OK TEMPERATURE (OR TIME) DEPENDENCE.
!
                     IF ( tset>0 ) x = Eltemp
                     IF ( Tstep>=0. ) x = Tstep
                     CALL tab(n4,x,factor)
                     card(kk) = card(kk)*factor
                     Linear = .FALSE.
                  ENDIF
               ENDDO
            ENDIF
         ENDIF
!
!     BRANCH ON INFLAG.
!
 220     IF ( Inflag<1 .OR. Inflag>4 ) THEN
!
!     ERROR CONDITIONS
!
            WRITE (outpt,99003) Sfm , Inflag
99003       FORMAT (A25,' 2156, ILLEGAL INFLAG =',I14,' RECEIVED BY HMAT.')
            CALL mesage(-61,0,0)
            RETURN
         ELSE
            IF ( Inflag==2 ) THEN
!
!     INFLAG = 2
!
               IF ( type==5 ) THEN
                  csq = C*C
                  ssq = S*S
                  cs = C*S
                  cs2kxy = cs*2.0*card(2)
                  Buf(1) = csq*card(1) - cs2kxy + ssq*card(4)
                  Buf(2) = cs*(card(1)-card(4)) + (csq-ssq)*card(2)
                  Buf(3) = ssq*card(1) + cs2kxy + csq*card(4)
                  Buf(4) = card(7)
               ELSE
                  Buf(1) = card(1)
                  Buf(2) = 0.0
                  Buf(3) = Buf(1)
                  Buf(4) = card(2)
               ENDIF
            ELSEIF ( Inflag==3 ) THEN
!
!     INFLAG = 3
!
               IF ( type==5 ) THEN
                  Buf(1) = card(1)
                  Buf(2) = card(2)
                  Buf(3) = card(3)
                  Buf(4) = card(4)
                  Buf(5) = card(5)
                  Buf(6) = card(6)
                  Buf(7) = card(7)
               ELSE
                  Buf(1) = card(1)
                  Buf(2) = 0.0
                  Buf(3) = 0.0
                  Buf(4) = Buf(1)
                  Buf(5) = 0.0
                  Buf(6) = Buf(1)
                  Buf(7) = card(2)
               ENDIF
            ELSEIF ( Inflag==4 ) THEN
!
!     INFLAG = 4.  RETURN ONLY CP.
!
               IF ( type==5 ) THEN
                  Buf(1) = card(7)
               ELSE
                  Buf(1) = card(2)
               ENDIF
!
!     INFLAG = 1
!
            ELSEIF ( type==5 ) THEN
               Buf(1) = card(1)
               Buf(2) = card(7)
            ELSE
               Buf(1) = card(1)
               Buf(2) = card(2)
            ENDIF
            spag_nextblock_1 = 6
            CYCLE SPAG_DISPATCHLOOP_1
         ENDIF
 240     WRITE (outpt,99004) Ufm , Matid
99004    FORMAT (A23,' 2157, MATERIAL ID =',I14,' DOES NOT APPEAR ON ANY MAT4 OR MAT5 MATERIAL DATA CARD.')
         CALL mesage(-61,0,0)
         RETURN
 260     CALL mesage(-2,Mpt,name)
         CALL mesage(-61,0,0)
         RETURN
      CASE (6)
!
!     RETURN LOGIC
!
!
!     CALL BUG (4HHMAT,490,BUF,7)
!
         RETURN
      END SELECT
 300  ENDDO SPAG_DISPATCHLOOP_1
END SUBROUTINE hmat