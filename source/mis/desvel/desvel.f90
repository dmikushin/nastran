!*==desvel.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE desvel
   USE c_blank
   USE c_packx
   USE c_system
   USE c_unpakx
   USE c_xmssg
   USE c_zzzzzz
   IMPLICIT NONE
!
! Local variable declarations rewritten by SPAG
!
   INTEGER , SAVE :: acc , effw , minac , minow2 , omega , ssdv , vwg
   REAL :: acce , acci , efwt , omeg , vel , veli , vwog
   INTEGER :: buf1 , buf2 , buf3 , buf4 , buf5 , i , ipt , j , jj , lcore , nall , ncol , ndir , nmodes , nrow , ntot
   INTEGER , DIMENSION(7) :: mcb1 , mcb2 , mcb3 , mcb4 , mcb5
   INTEGER , DIMENSION(2) , SAVE :: nam
   LOGICAL :: zero
   EXTERNAL close , gopen , korsz , mesage , pack , rdtrl , unpack , wrttrl
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
!     DESVAL COMPUTES DESIGN VELOCITY AND ACCELERATION SPECTRA FOR
!     DDAM. THE ASSUMUED FORM FOR VELOCITY IS
!
!                            VELB + W
!        VEL = VELI * VELA * --------
!                            VELC + W
!
!     WHERE VELI IS VEL1,VEL2,OR VEL3 FOR TH 1,2,3, DIRECTIONS
!         W IS THE EFFECTIVE WEIGHT = MATRIX EFFW/1000.
!         VEL,VELA ARE IN LENGTH/SECOND
!     MATRIX SSDV WILL BE OUTPUT
!     DESIGN ACCELERATIONS HAVE THE SAME FORM AS VELOCITY EXCEPT FOR
!     ONE CASE WHERE
!         ACC = ACCI*ACCA*(ACCB+W)*(ACCC+W)/(ACCD+W)**2
!
!     WHERE ACC IS IN G-S AND W IS AS ABOVE
!     IF ACCD IA ZERO, ACC HAS THE SAME FORM AS VEL
!     MATRICES ACC AND VEL*OMEGA/G WILL BE OUTPUT FOR COMPARISON
!     PURPOSES
!     IN ADDITION, DATA BLOCK MINAC WILL CONTAIN THE MINIMUM
!     OF ACCE*GG VS. VEL*OMEGA FOR USE IN COMPUTING STATIC LOADS
! *** ALL VELOCITY PARAMETERS MUST BE PUT ON PARAM BULK DATA CARDS,
!                             ----
!     I.E.,VEL1,VEL2,VEL3,VELA,VELB,VELC. ACCELERATION PARAMETERS ARE
!     DEFAULTED TO ZERO AND NEED NOT BE ON PARAM CARDS IF NOT WANTED.
!
!     DESVEL   EFFW,OMEGA / SSDV,ACC,VWG,MINAC,MINOW2 / C,Y,GG=386.4/
!              C,Y,VEL1/C,Y,VEL2/C,Y,VEL3/C,Y,VELA/C,Y,VELB/C,Y,VELC/
!              C,Y,ACC1=0./C,Y,ACC2=0./C,Y,ACC3=0./C,Y,ACCA=0./
!              C,Y,ACCB=0./C,Y,ACCC=0./C,Y,ACCD=0.
!
   !>>>>EQUIVALENCE (Z(1),Iz(1))
   DATA effw , omega , ssdv , acc , vwg , minac , minow2/101 , 102 , 201 , 202 , 203 , 204 , 205/
   DATA nam/4HDESV , 4HEL  /
   spag_nextblock_1 = 1
   SPAG_DispatchLoop_1: DO
      SELECT CASE (spag_nextblock_1)
      CASE (1)
!
         zero = .FALSE.
         lcore = korsz(z)
         buf1 = lcore - sysbuf + 1
         buf2 = buf1 - sysbuf
         buf3 = buf2 - sysbuf
         buf4 = buf3 - sysbuf
         buf5 = buf4 - sysbuf
         lcore = buf5 - 1
         IF ( lcore<=0 ) CALL mesage(-8,0,nam)
!
         jout = 1
         iin = 1
         iout = 1
         incr = 1
         jncr = 1
         ii = 1
         iii = 1
!
!     UNPACK AND STORE EFFW AND OMEGA
!
         mcb1(1) = effw
         CALL rdtrl(mcb1)
         ncol = mcb1(2)
         nrow = mcb1(3)
         nnn = nrow
         nn = nnn
         ntot = ncol*nrow
         nall = ntot + nnn
!
         IF ( lcore<(ncol+6)*nnn ) CALL mesage(-8,0,nam)
         CALL gopen(effw,z(buf1),0)
         DO i = 1 , ncol
            jj = (i-1)*nnn
            CALL unpack(*10,effw,z(jj+1))
            CYCLE
 10         DO j = 1 , nnn
               z(jj+j) = 0.
            ENDDO
!
         ENDDO
         CALL close(effw,1)
         CALL gopen(omega,z(buf1),0)
         CALL unpack(*20,omega,z(ntot+1))
         spag_nextblock_1 = 2
         CYCLE SPAG_DispatchLoop_1
 20      DO i = 1 , nnn
            z(ntot+i) = 0.
         ENDDO
         spag_nextblock_1 = 2
      CASE (2)
!
         CALL close(omega,1)
         nmodes = nrow
         ndir = ncol
!
         CALL gopen(ssdv,z(buf1),1)
         CALL gopen(acc,z(buf2),1)
         CALL gopen(vwg,z(buf3),1)
         CALL gopen(minac,z(buf4),1)
         CALL gopen(minow2,z(buf5),1)
!
         mcb1(1) = ssdv
         mcb1(2) = 0
         mcb1(3) = nrow
         mcb1(4) = 2
         mcb1(5) = 1
         mcb1(6) = 0
         mcb1(7) = 0
         mcb2(1) = acc
         mcb2(2) = 0
         mcb2(3) = nrow
         mcb2(4) = 2
         mcb2(5) = 1
         mcb2(6) = 0
         mcb2(7) = 0
         mcb3(1) = vwg
         mcb3(2) = 0
         mcb3(3) = nrow
         mcb3(4) = 2
         mcb3(5) = 1
         mcb3(6) = 0
         mcb3(7) = 0
         mcb4(1) = minac
         mcb4(2) = 0
         mcb4(3) = nrow
         mcb4(4) = 2
         mcb4(5) = 1
         mcb4(6) = 0
         mcb4(7) = 0
         mcb5(1) = minow2
         mcb5(2) = 0
         mcb5(3) = nrow
         mcb5(4) = 2
         mcb5(5) = 1
         mcb5(6) = 0
         mcb5(7) = 0
!
         DO i = 1 , ndir
            ipt = (i-1)*nnn
            DO j = 1 , nmodes
!
!     EFFECTIVE WEIGHT FOR JTH MODE IN ITH DIRECTION (IN 1000-S)
!
               efwt = z(ipt+j)/1000.
               IF ( i==2 ) THEN
                  veli = vel2
                  acci = acc2
               ELSEIF ( i==3 ) THEN
                  veli = vel3
                  acci = acc3
               ELSE
                  veli = vel1
                  acci = acc1
               ENDIF
!
               vel = veli*vela*(velb+efwt)/(velc+efwt)
               IF ( accd/=0. ) THEN
!
                  acce = acci*acca*(accb+efwt)*(accc+efwt)/(accd+efwt)**2
               ELSE
                  acce = acci*acca*(accb+efwt)/(accc+efwt)
               ENDIF
!
               omeg = z(ntot+j)
               vwog = vel*omeg/gg
!
!     VELOCITIES FOR ITH DIRECTION ARE IN Z(NALL+1)-Z(NALL+NNN)
!     ACCELERATIONS ARE IN NEXT NNN LOCATIONS, VWOG IN 3RD NNN
!     MAXIMUM OF VEL*OMEG OR ACCE*GG IS IN 4TH NNN
!
               z(nall+j) = vel
               z(nall+nnn+j) = acce
               z(nall+2*nnn+j) = vwog
               z(nall+3*nnn+j) = gg*amin1(acce,vwog)
               IF ( abs(omeg)<0.01 ) THEN
!
!     IN DDAM, THERE SHOULD BE NO RIGID BODY MODES.ZERO THE RESPONSE.
!
                  z(nall+4*nnn+j) = 0.
                  zero = .TRUE.
               ELSE
                  z(nall+4*nnn+j) = z(nall+3*nnn+j)/omeg**2
               ENDIF
!
!     GET ANOTHER MODE FOR THIS DIRECTION
!
            ENDDO
!
!     PACK RESULTS FOR THIS DIRECTION
!
            CALL pack(z(nall+1),ssdv,mcb1)
            CALL pack(z(nall+nnn+1),acc,mcb2)
            CALL pack(z(nall+2*nnn+1),vwg,mcb3)
            CALL pack(z(nall+3*nnn+1),minac,mcb4)
            CALL pack(z(nall+4*nnn+1),minow2,mcb5)
!
!     GET ANOTHER DIRECTION
!
         ENDDO
!
!     DONE
!
         CALL close(ssdv,1)
         CALL close(acc,1)
         CALL close(vwg,1)
         CALL close(minac,1)
         CALL close(minow2,1)
         CALL wrttrl(mcb1)
         CALL wrttrl(mcb2)
         CALL wrttrl(mcb3)
         CALL wrttrl(mcb4)
         CALL wrttrl(mcb5)
!
         IF ( .NOT.zero ) RETURN
         WRITE (iprint,99001) uim
99001    FORMAT (A29,', CIRCULAR FREQUENCY LESS THAN .01 IS ENCOUNTERED ','IN DDAM.',/5X,'MAXIMUM RESPONSE FOR THAT MODE IS SET TO',&
                &' ZERO. DDAM SHOULD HAVE NO RIGID BODY MODES.')
         EXIT SPAG_DispatchLoop_1
      END SELECT
   ENDDO SPAG_DispatchLoop_1
END SUBROUTINE desvel