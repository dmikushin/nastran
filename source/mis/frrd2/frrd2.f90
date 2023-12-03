!*==frrd2.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE frrd2
   IMPLICIT NONE
   USE c_blank
   USE c_cdcmpx
   USE c_condas
   USE c_frd2bc
   USE c_frrdst
   USE c_system
   USE c_zzzzzz
!
! Local variable declarations rewritten by SPAG
!
   COMPLEX :: a1 , a2 , a3 , a4 , a5
   INTEGER , SAVE :: bhh , fol , khh , mhh , phf , qhhl , scr1 , scr2 , scr3 , scr4 , scr5 , scr6 , scr7 , scr8 , scr9 , uhvf
   INTEGER :: i , ibuf1 , icor , ihh , k , ncore , nfreq , nload , noncup , nto , nz , pass
   INTEGER , DIMENSION(5) :: itab
   INTEGER , DIMENSION(1) :: iz
   INTEGER , DIMENSION(7) :: mcb
   INTEGER , DIMENSION(2) , SAVE :: name
   REAL :: w
   REAL , DIMENSION(1) :: zzz
!
! End of declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     AEROELASTIC FREQUENCY RESPONSE SOLUTION MODULE
!
!     INPUTS      KHH,BHH,MHH,QHHL,PHF,FOL
!
!     OUTPUT      UHVF
!
!     SCRATCHES   NINE
!
!     PARAMETERS    BOV - REAL - INPUT
!                   Q   - REAL - INPUT
!                   M   - REAL - INPUT
!
!     COMMON FRD2BC WILL BE USED BY ROUTINES FRD2B AND FRD2C.
!
   !>>>>EQUIVALENCE (Zzz(1),Z(1))
   !>>>>EQUIVALENCE (Iz(1),Z(1))
   DATA khh , bhh , mhh , qhhl , phf , fol , uhvf/101 , 102 , 103 , 104 , 105 , 106 , 201/
   DATA scr1 , scr2 , scr3 , scr4 , scr5 , scr6 , scr7 , scr8 , scr9/301 , 302 , 303 , 304 , 305 , 306 , 307 , 308 , 309/
   DATA name/4HFRRD , 4H2   /
!     DATA    PASS  / 0 /
!
!     SETUP
!
   scr9 = 309
   pass = 0
   ib = 0
   ih = 0
   ipfrdc = 0
   nz = korsz(z)
   ibuf1 = nz - sysbuf - 1
   nz = nz - sysbuf
   noncup = 1
   mcb(1) = qhhl
   CALL rdtrl(mcb)
   IF ( mcb(1)<=0 .OR. q==0.0 ) noncup = -1
!
!     IF QHHL IS PURGED AND MACH NUMBER IS NEGATIVE, THE COUPLED EQU.
!     (-M*W**2 + IW*B + K)*U = P IS SOLVED. COMPLEX D.P. IS USED.
!     THE VARIABLE IH WILL BE USED TO CONTROL SOLUTION LOGIC IN
!     ROUTINES FRRD2, FRD2B AND FRD2C.
!
   IF ( mcb(1)<=0 .AND. m<0.0 ) noncup = 1
!
   mcb(1) = phf
   CALL rdtrl(mcb)
   i = phf
   IF ( mcb(1)<0 ) GOTO 900
   i = fol
   CALL open(*900,fol,iz(ibuf1),0)
   CALL read(*800,*100,fol,iz,2,0,nfreq)
   CALL read(*800,*100,fol,iz,nz,0,nfreq)
   CALL mesage(-8,0,name)
 100  CALL close(fol,1)
   nload = mcb(2)/nfreq
   IF ( noncup==-1 ) THEN
!
!     UNCOUPLED MODAL
!
!
!     THE FREQUENCIES FOL (ALREADY IN IZ ARRAY) IS CONVERTED FROM CPS
!     TO RADIAN UNITS (FRL), AND SAVED IN SCR1.  NO TRAILER NEEDED.
!
      CALL gopen(scr1,iz(ibuf1),1)
      DO i = 1 , nfreq
         z(i) = z(i)*twopi
      ENDDO
      CALL write(scr1,z,nfreq,1)
      CALL close(scr1,1)
      CALL frd2f(mhh,bhh,khh,scr1,1,nload,nfreq,phf,uhvf)
      GOTO 700
   ELSE
      IF ( nfreq==1 .OR. nload==1 ) scr9 = uhvf
      icnt = 0
      ifrst = 0
!
!     BUILD INTERPOLATION MATRIX - ON SCR1
!
      CALL frd2i(iz(1),nfreq,nz+sysbuf,qhhl,scr1,scr2,scr3,scr4,ih)
      nto = 0
      ihh = mcb(3)
      icor = korsz(zzz) - 6*sysbuf - 3
      ncore = 2*(ih*ih+2*(ihh*nload)) + 50
      icor = icor - ncore
!
!     IF IH = 0, COMPLEX D.P. COMPUTATION WILL BE USED.  NOTICE THAT THE
!     ROUTINE INCORE IS WRITTEN ONLY FOR COMPLEX S.P. OPERATION.
!
      IF ( ih==0 .OR. icor<500 ) GOTO 600
      nto = 1
      itab(1) = mhh
      itab(2) = bhh
      itab(3) = khh
      itab(4) = phf
      itab(5) = scr1
      ihh = 4
      IF ( ih/=0 ) ihh = 5
      CALL open(*200,mhh,iz(ibuf1),0)
   ENDIF
 200  CALL close(mhh,1)
   CALL open(*300,bhh,iz(ibuf1),0)
 300  CALL close(bhh,1)
   CALL open(*400,khh,iz(ibuf1),0)
 400  CALL close(khh,1)
   CALL open(*500,phf,iz(ibuf1),0)
 500  CALL close(phf,1)
!
!     LOOP ON FREQUENCY
!
 600  DO i = 1 , nfreq
!
!     PICK UP FREQUENCY
!
      IF ( i>icnt+ifrst-1 ) THEN
         CALL gopen(fol,iz(ibuf1),0)
         CALL bckrec(fol)
         CALL fread(fol,ovf,-(i-1)-2,0)
         icnt = min0(150,nfreq-i+1)
         CALL fread(fol,ovf,icnt,0)
         ifrst = i
         CALL close(fol,1)
      ENDIF
      k = i - ifrst + 1
      w = ovf(k)*twopi
      IF ( ih==0 ) THEN
!
!     CREATE NULL TRAILERS FOR SCR2 (QHR) AND SCR3 (QHI) IF IH = 0.
!     (THESE DATA BLOCKS ARE NORMALLY GENERATED BY FRD2A IF IH .NE. 0.
!     SINCE FRD2A IS NOT EXECUTED WHEN IH = 0, AND SINCE SCR2 AND SCR3
!     ARE ALSO USED BY FRD2C, WE NEED TO CLEAR THE TRAILERS.)
!
         CALL makmcb(mcb,scr2,0,0,0)
         CALL wrttrl(mcb)
         mcb(1) = scr3
         CALL wrttrl(mcb)
      ELSE
!
!     INTERPOLATE QHHL
!
         CALL frd2a(scr1,scr2,scr3,ih,i)
      ENDIF
!
!
!     FOR DYNAMIC MATRIX
!
      a1 = cmplx(-w*w,0.0)
      a2 = cmplx(0.0,w)
      a3 = cmplx(0.0,-w*q*bov)
      a4 = cmplx(1.0,0.0)
      a5 = cmplx(-q,0.0)
      CALL frd2b(mhh,a1,bhh,a2,scr3,a3,khh,a4,scr2,a5,scr4)
!
!     DECOMPOSE SCR4 AND SOLVE
!
      CALL frd2c(scr4,phf,scr7,scr2,scr3,scr5,scr6,scr8,nload,i)
!
!     COPY TO TEMPORARY UHVF
!
      CALL frd2d(scr7,scr9,pass)
      pass = pass + 1
   ENDDO
   IF ( nfreq/=1 .AND. nload/=1 ) CALL frd2e(scr9,uhvf,nload,nfreq)
!
!     FORM FINAL ANSWER
!
 700  RETURN
 800  CALL mesage(-3,fol,name)
 900  CALL mesage(-1,i,name)
END SUBROUTINE frrd2