
SUBROUTINE onetwo(*,Ix,X,Dx,Itermm)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   DOUBLE PRECISION Det , Dz(2) , Mindia
   INTEGER Dum(3) , Eofnrw , Ifila(7) , Ifill(7) , Ifilu(7) , Incrx , Incry , Itype1 , Itype2 , Itypex , Ixy , Iy , Jj , Jxy , Jy , &
         & Ncol , Norew , Nx , Rd , Rdp , Rew , Sr2fil , Sysbuf , Typel , Wrt
   REAL Power , Rdrew , Rsp , Wrtrew
   COMMON /dcompx/ Ifila , Ifill , Ifilu , Dum , Det , Power , Nx , Mindia
   COMMON /names / Rd , Rdrew , Wrt , Wrtrew , Rew , Norew , Eofnrw , Rsp , Rdp
   COMMON /packx / Itype1 , Itype2 , Iy , Jy , Incry
   COMMON /system/ Sysbuf
   COMMON /unpakx/ Itypex , Ixy , Jxy , Incrx
   COMMON /zblpkx/ Dz , Jj
!
! Dummy argument declarations
!
   INTEGER Bbar , Bbbar , Bbbar1 , Cbcnt , I1 , I1sp , I4 , I4sp , I6sp , Ipak , Iterm , Itermm , Jposl , Lcol , R , Scrflg , Sr2fl
   DOUBLE PRECISION Dx(6)
   INTEGER Ix(1)
   REAL X(1)
!
! Local variable declarations
!
   REAL a , sub(2)
   DOUBLE PRECISION da
   INTEGER i , ibuf1 , ibuf2 , ibuf3 , iend , ifile , in1 , in2 , j , k , kk , l , ll , no
!
! End of declarations
!
!*******
!     PROGRAM TO SOLVE A MATRIX OF ORDER ONE OR TWO FOR DECOMP
!*******
!
!
   EQUIVALENCE (Ifila(2),Ncol) , (Ifill(5),Typel) , (Sr2fil,Dum(2))
!
   DATA sub/4HONET , 4HWO  /
!
! ----------------------------------------------------------------------
!
   ibuf1 = Nx - Sysbuf
   ibuf2 = ibuf1 - Sysbuf
   ibuf3 = ibuf2 - Sysbuf
   ifile = Ifilu(1)
   CALL close(Dum(2),Rew)
   IF ( Itermm==1 ) ifile = Dum(2)
   CALL gopen(ifile,Ix(ibuf3),1)
   CALL gopen(Ifila,Ix(ibuf1),0)
   Itypex = Rdp
   Itype1 = Rdp
   Itype2 = Typel
   Incrx = 1
   Incry = 1
   IF ( Ncol==2 ) THEN
      Ixy = 1
!*******
!     SOLVE A (2X2)
!*******
      Jxy = 2
      CALL unpack(*300,Ifila(1),Dx)
      CALL unpack(*300,Ifila(1),Dx(3))
      a = 1.
      IF ( dabs(Dx(1))<dabs(Dx(2)) ) THEN
!*******
!     PERFORM INTERCHANGE
!*******
         Det = Dx(1)
         Dx(1) = Dx(2)
         Dx(2) = Det
         Det = Dx(3)
         Dx(3) = Dx(4)
         Dx(4) = Det
         a = -1.
      ENDIF
      Dx(2) = Dx(2)/Dx(1)
      Dx(4) = Dx(4) - Dx(2)*Dx(3)
      Det = Dx(4)*Dx(1)*a
      IF ( Dx(1)==0.D0 .OR. Dx(4)==0.D0 ) GOTO 300
      Mindia = dmin1(dabs(Dx(1)),dabs(Dx(4)))
      Iy = 1
      Jy = 2
      Dx(5) = 0.0D0
      IF ( a<0.0 ) Dx(5) = 1.0D0
      Dx(6) = Dx(2)
      CALL pack(Dx(5),Ifill(1),Ifill)
      Dx(6) = 0.
      Jy = 1
      CALL pack(Dx(6),Ifill(1),Ifill)
      IF ( Itermm==1 ) THEN
         Jy = 1
         CALL pack(Dx,ifile,Ifilu)
         Jy = 2
         CALL pack(Dx(3),ifile,Ifilu)
         CALL close(ifile,Eofnrw)
      ELSE
         Dx(2) = Dx(3)
         Dx(3) = Dx(4)
         Dx(4) = Dx(2)
         Jy = 2
         CALL pack(Dx(3),ifile,Ifilu)
         Iy = 2
         CALL pack(Dx,ifile,Ifilu)
         CALL close(ifile,Rew)
      ENDIF
   ELSEIF ( Ncol/=1 ) THEN
      no = -8
      CALL mesage(no,0,sub)
      GOTO 99999
   ELSE
!*******
!     SOLVE A (1X1)
!*******
      Ixy = 1
      Jxy = 1
      CALL unpack(*300,Ifila(1),Dx)
      Det = Dx(1)
      Mindia = dabs(Dx(1))
      Iy = 1
      Jy = 1
      CALL pack(Dx,ifile,Ifilu)
      Dx(1) = 0.D0
      CALL pack(Dx,Ifill(1),Ifill)
      IF ( Itermm==0 ) THEN
         CALL close(ifile,Rew)
      ELSE
         CALL close(ifile,Eofnrw)
      ENDIF
   ENDIF
   CALL close(Ifila(1),Rew)
   CALL close(Ifill(1),Rew)
   RETURN
   ENTRY finwrt(Iterm,Scrflg,Sr2fl,Jposl,I1sp,Bbar,I1,Cbcnt,Ipak,R,Bbbar1,Bbbar,I6sp,I4,I4sp,Ix,Dx,X,Lcol)
   ibuf1 = Nx - Sysbuf
   ibuf2 = ibuf1 - Sysbuf
   ibuf3 = ibuf2 - Sysbuf
   CALL close(Ifila(1),Rew)
   CALL gopen(Sr2fil,Ix(ibuf1),Wrt)
   CALL close(Sr2fil,Eofnrw)
   k = 0
   CALL gopen(Ifill,Ix(ibuf2),Wrt)
   IF ( Scrflg/=0 ) CALL gopen(Sr2fl,Ix(ibuf3),Rd)
   ll = 0
 100  Jposl = Jposl + 1
   CALL bldpk(Rdp,Typel,Ifill(1),0,0)
   in1 = I1sp + k
   Jj = Jposl
   Dz(1) = Ix(in1)
   CALL zblpki
   kk = 0
   iend = min0(Bbar,Ncol-Jj)
   IF ( iend/=0 ) THEN
      in1 = I1 + ll*Bbar
      DO
         Jj = Jj + 1
         in2 = in1 + kk
         Dz(1) = Dx(in2)
         CALL zblpki
         kk = kk + 1
         IF ( kk<iend ) THEN
         ELSEIF ( kk==iend ) THEN
            EXIT
         ELSE
            no = -25
            CALL mesage(no,0,sub)
            GOTO 99999
         ENDIF
      ENDDO
   ENDIF
   IF ( Cbcnt==0 ) GOTO 200
!*******
!     PACK ACTIVE ROW ELEMENTS ALSO
!*******
   kk = 0
   DO
      in1 = I6sp + kk
      in2 = I4 + Ix(in1)*Bbbar + k
      Dz(1) = Dx(in2)
      IF ( Dz(1)/=0.D0 ) THEN
         in1 = I4sp + Ix(in1)
         Jj = Ix(in1)
         CALL zblpki
      ENDIF
      kk = kk + 1
      IF ( kk>=Cbcnt ) EXIT
   ENDDO
 200  CALL bldpkn(Ifill(1),0,Ifill)
   ll = ll + 1
   k = k + 1
   IF ( k==Lcol ) THEN
      CALL close(Ifill(1),Rew)
      IF ( Scrflg>0 ) CALL close(Sr2fl,Rew)
      IF ( Iterm/=0 ) RETURN
!*******
!     RE-WRITE THE UPPER TRIANGLE WITH THE RECORDS IN THE REVERSE ORDER
!*******
      Incrx = 1
      Incry = 1
      Itype1 = Typel
      Itype2 = Typel
      Itypex = Typel
      Ifilu(2) = 0
      Ifilu(6) = 0
      Ifilu(7) = 0
      CALL gopen(Sr2fil,Ix(ibuf1),Rd)
      CALL gopen(Ifilu,Ix(ibuf2),1)
      DO i = 1 , Ncol
         Ixy = 0
         CALL bckrec(Sr2fil)
         CALL unpack(*300,Sr2fil,Ix)
         CALL bckrec(Sr2fil)
         kk = Jxy - Ixy + 1
         k = kk/2
         kk = kk + 1
         IF ( Typel==1 ) THEN
            DO j = 1 , k
               l = kk - j
               a = X(j)
               X(j) = X(l)
               X(l) = a
            ENDDO
         ELSE
            DO j = 1 , k
               l = kk - j
               da = Dx(j)
               Dx(j) = Dx(l)
               Dx(l) = da
            ENDDO
         ENDIF
         Iy = Ncol - Jxy + 1
         Jy = Ncol - Ixy + 1
         CALL pack(Ix,Ifilu(1),Ifilu)
      ENDDO
      CALL close(Ifilu(1),Rew)
      CALL close(Sr2fil,Rew)
      RETURN
   ELSE
      IF ( k-R+1<0 ) GOTO 100
      IF ( k-R+1==0 ) THEN
         IF ( R<Bbbar1 ) THEN
         ELSEIF ( R==Bbbar1 ) THEN
            GOTO 100
         ELSE
            no = -25
            CALL mesage(no,0,sub)
            GOTO 99999
         ENDIF
      ENDIF
      ll = ll - 1
      in1 = I1 + ll*Bbar
      CALL fread(Sr2fl,Dx(in1),2*Bbar,0)
      GOTO 100
   ENDIF
 300  RETURN 1
99999 END SUBROUTINE onetwo