
SUBROUTINE fqrw(M,E,Er,A,B,W,P,Q,Xm,Int,Zb,Srfle,Mcbc)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   REAL Cndflg , Eofnrw , Rd , Rdrew , Rew , Timed , Wrt , Wrtrew
   DOUBLE PRECISION Dlamda
   INTEGER Iacc , Ii , Iip , Incr , Incrp , Io , Iprc , Iprec , Iter , Itp1 , Itp2 , Ksystm(65) , L16 , Lhpw(3) , Nn , Nnp , Norew
   CHARACTER*23 Ufm
   CHARACTER*25 Uwm
   COMMON /feerxx/ Dlamda , Cndflg , Iter , Timed , L16
   COMMON /lhpwx / Lhpw , Iacc
   COMMON /names / Rd , Rdrew , Wrt , Wrtrew , Rew , Norew , Eofnrw
   COMMON /packx / Itp1 , Itp2 , Iip , Nnp , Incrp
   COMMON /system/ Ksystm
   COMMON /unpakx/ Iprc , Ii , Nn , Incr
   COMMON /xmssg / Ufm , Uwm
!
! Dummy argument declarations
!
   INTEGER M , Srfle
   REAL A(1) , B(2) , E(1) , Er(1) , P(1) , Q(1) , W(1) , Xm(1) , Zb(1)
   LOGICAL Int(1)
   INTEGER Mcbc(7)
!
! Local variable declarations
!
   REAL base , bmax , c , delta , dim , dimf , e1 , e2 , emax , eps , epx , epx2 , erf , ev , f , gg , hov , lambda , pprc , prc ,  &
      & ratio , s , scale , shift , ss , sum , sumx , t , tmax , tol , x , y , z , zerr
   INTEGER i , icf , iexp , ij , ilim , irp , it , j , jerr , jrp , k , k1 , l , l1 , m1 , mcb(7) , mvec , niter , nrp , nv
!
! End of declarations
!
!
   EQUIVALENCE (Ksystm(2),Io) , (Ksystm(55),Iprec)
   DATA ilim , iexp , base/120 , 60 , 2./
!
!     IACC  =  ACCURACY CONTROL (EPSILON) FOR UNDERFLOW
!
   IF ( M==1 ) RETURN
   lambda = Dlamda
   Iprc = 1
   CALL makmcb(mcb(1),Srfle,M,2,Iprc)
   icf = Mcbc(1)
   Incr = 1
   Incrp = 1
   Itp1 = Iprc
   Itp2 = Iprc
   it = Iacc*Iprec
   prc = 10.**(-it)
   pprc = 10.E-4
   jerr = 0
   epx = 10.**(2-it)
   epx2 = epx**2
   hov = base**iexp
   m1 = M - 1
   DO i = 1 , M
      E(i) = A(i)
   ENDDO
   tol = prc/(10.*float(M))
   bmax = 0.
   tmax = 0.
   W(M+1) = 0.
   DO i = 1 , M
      IF ( bmax<abs(B(i)) ) bmax = abs(B(i))
      IF ( tmax<abs(A(i)) ) tmax = abs(A(i))
   ENDDO
   IF ( tmax<bmax ) tmax = bmax
   scale = 1.
   DO i = 1 , ilim
      IF ( scale*tmax>hov ) EXIT
      scale = scale*2.
   ENDDO
   IF ( bmax/=0. ) THEN
      DO i = 1 , M
         E(i) = A(i)*scale
         W(i) = (B(i)*scale)**2
      ENDDO
      delta = tmax*scale*tol
      eps = delta*delta
      k = M
      DO
         l = k
         IF ( l<=0 ) THEN
            DO i = 1 , M
               E(i) = E(i)/scale
            ENDDO
            DO l = 1 , m1
               k = M - l
               DO i = 1 , k
                  IF ( E(i)<=E(i+1) ) THEN
                     x = E(i)
                     E(i) = E(i+1)
                     E(i+1) = x
                  ENDIF
               ENDDO
            ENDDO
            DO l = 1 , m1
               k = M - l
               DO i = 1 , k
                  IF ( abs(E(i))<=abs(E(i+1)) ) THEN
                     x = E(i)
                     E(i) = E(i+1)
                     E(i+1) = x
                  ENDIF
               ENDDO
            ENDDO
            EXIT
         ELSE
            l1 = l - 1
            DO i = 1 , l
               k1 = k
               k = k - 1
               IF ( W(k1)<eps ) EXIT
            ENDDO
            IF ( k1/=l ) THEN
               t = E(l) - E(l1)
               x = W(l)
               y = .5*t
               s = sqrt(x)
               IF ( abs(t)>delta ) s = (x/y)/(1.+sqrt(1.+x/y**2))
               e1 = E(l) + s
               e2 = E(l1) - s
               IF ( k1/=l1 ) THEN
                  shift = e1
                  IF ( abs(t)<delta .AND. abs(e2)<abs(e1) ) shift = e2
                  s = 0.
                  c = 1.
                  gg = E(k1) - shift
                  DO
                     IF ( abs(gg)<delta ) gg = gg + c*delta*gg/abs(gg)
                     f = gg**2/c
                     k = k1
                     k1 = k + 1
                     x = W(k1)
                     t = x + f
                     W(k) = s*t
                     IF ( k<l ) THEN
                        c = f/t
                        s = x/t
                        x = gg
                        gg = c*(E(k1)-shift) - s*x
                        E(k) = (x-gg) + E(k1)
                     ELSE
                        E(k) = gg + shift
                        EXIT
                     ENDIF
                  ENDDO
               ELSE
                  E(l) = e1
                  E(l1) = e2
                  W(l1) = 0.
               ENDIF
            ELSE
               W(l) = 0.
            ENDIF
         ENDIF
      ENDDO
   ENDIF
   IF ( M==0 ) RETURN
!
!     COMPUTE EIGENVECTORS BY INVERSE ITERATION
!
   erf = B(M+1)
   mvec = M
   f = scale/hov
   DO i = 1 , M
      A(i) = A(i)*f
      B(i) = B(i)*f
   ENDDO
   dimf = 10.**(-it/3)
   DO nv = 1 , mvec
      ij = nv
      sumx = 0.
      irp = 0
      IF ( nv==1 ) THEN
         nrp = 0
         DO i = 1 , M
            W(i) = 1.
         ENDDO
         Iip = 1
         Nnp = M
         GOTO 100
      ELSE
         ratio = abs(E(nv)/E(nv-1)-1.)
         dim = .02*abs(1.-lambda*E(nv))
         IF ( ratio<dim .OR. ratio<dimf ) THEN
!
!     MULTIPLE EIGENVALUES
!
            nrp = nrp + 1
         ELSE
            nrp = 0
         ENDIF
         IF ( nv/=2 ) THEN
            CALL gopen(Srfle,Zb(1),Wrt)
         ELSE
            CALL gopen(Srfle,Zb(1),Wrtrew)
            mcb(2) = 0
            mcb(6) = 0
         ENDIF
         Iip = 1
         Nnp = M
         CALL pack(W(1),Srfle,mcb(1))
         CALL close(Srfle,Norew)
         ss = 1.0
         sum = 0.
         DO i = 1 , M
            ss = -ss
            ij = ij + 1
            P(i) = float(mod(ij,3)+1)/(3.0*float((mod(ij,13)+1)*(1+5*i/M)))
            P(i) = P(i)*ss
            sum = sum + P(i)**2
         ENDDO
         sum = 1./sqrt(sum)
         DO i = 1 , M
            P(i) = P(i)*sum
            Q(i) = P(i)
         ENDDO
         CALL gopen(Srfle,Zb(1),Rdrew)
         j = 0
         DO
            sum = 0.
            j = j + 1
            DO i = 1 , M
               sum = sum + W(i)*P(i)
            ENDDO
            DO i = 1 , M
               Q(i) = Q(i) - sum*W(i)
            ENDDO
            IF ( j==nv-1 ) EXIT
            Ii = 1
            Nn = M
            CALL unpack(*50,Srfle,W(1))
         ENDDO
      ENDIF
 50   CALL close(Srfle,Norew)
      sum = 0.
      DO i = 1 , M
         sum = sum + Q(i)**2
      ENDDO
      sum = 1./sqrt(sum)
      DO i = 1 , M
         Q(i) = Q(i)*sum
         W(i) = Q(i)
      ENDDO
 100  ev = E(nv)*f
      x = A(1) - ev
      y = B(2)
      DO i = 1 , m1
         c = A(i+1) - ev
         s = B(i+1)
         IF ( abs(x)>=abs(s) ) THEN
            IF ( abs(x)<tol ) x = tol
            P(i) = x
            Q(i) = y
            Int(i) = .FALSE.
            z = -s/x
            x = c + z*y
            y = B(i+2)
         ELSE
            P(i) = s
            Q(i) = c
            Int(i) = .TRUE.
            z = -x/s
            x = y + z*c
            IF ( i<m1 ) y = z*B(i+2)
         ENDIF
         Xm(i) = z
      ENDDO
      IF ( abs(x)<tol ) x = tol
      niter = 0
      DO
         niter = niter + 1
         W(M) = W(M)/x
         emax = abs(W(M))
         DO l = 1 , m1
            i = M - l
            y = W(i) - Q(i)*W(i+1)
            IF ( Int(i) ) y = y - B(i+2)*W(i+2)
            W(i) = y/P(i)
            IF ( abs(W(i))>emax ) emax = abs(W(i))
         ENDDO
         sum = 0.
         DO i = 1 , M
            W(i) = (W(i)/emax)/epx
            IF ( abs(W(i))<epx2 ) W(i) = epx2
            sum = sum + W(i)**2
         ENDDO
         s = sqrt(sum)
         DO i = 1 , M
            W(i) = W(i)/s
         ENDDO
         IF ( niter>=4 ) THEN
            IF ( nv==1 ) GOTO 200
!
!     MULTIPLE EIGENVALUES AND ORTHOGONALIZATION
!
            irp = irp + 1
            CALL gopen(Srfle,Zb(1),Rdrew)
            DO i = 1 , M
               Q(i) = W(i)
            ENDDO
            sumx = 0.
            jrp = nv - 1
            DO i = 1 , jrp
               Ii = 1
               Nn = M
               CALL unpack(*150,Srfle,P(1))
               sum = 0.
               DO j = 1 , M
                  sum = sum + P(j)*Q(j)
               ENDDO
               IF ( abs(sum)>sumx ) sumx = abs(sum)
               DO j = 1 , M
                  W(j) = W(j) - sum*P(j)
               ENDDO
            ENDDO
            EXIT
         ELSE
            DO i = 1 , m1
               IF ( Int(i) ) THEN
                  y = W(i)
                  W(i) = W(i+1)
                  W(i+1) = y + Xm(i)*W(i)
               ELSE
                  W(i+1) = W(i+1) + Xm(i)*W(i)
               ENDIF
            ENDDO
         ENDIF
      ENDDO
 150  CALL close(Srfle,Norew)
!
!     LOGIC SETTING SUM (BY G.CHAN/UNISYS  7/92)
!
!     SUM = PRC*PREC COULD PRODUCE UNDERFLOW
!     SUM = ZERO, COULD CAUSE DIVIDED BY ZERO AFTER 420 FOR NULL VECTOR
!     SO, WE CHOOSE SUM A LITTLE SMALLER THAN PRC
!
!     SUM = PRC*PRC
!     SUM = 0.0
 200  sum = prc*1.0E-4
!
      DO i = 1 , M
         sum = sum + W(i)*W(i)
      ENDDO
      sum = 1./sqrt(sum)
      DO i = 1 , M
         W(i) = W(i)*sum
      ENDDO
      IF ( sumx>0.9 .AND. irp<3 ) GOTO 100
      IF ( L16/=0 ) WRITE (Io,99001) nv , niter , irp , sumx
99001 FORMAT (10X,18H FEER QRW ELEMENT ,I5,6H ITER ,2I3,6H PROJ ,E16.8)
      IF ( jerr<=0 ) THEN
         zerr = abs(W(1))
         DO i = 2 , M
            IF ( abs(W(i))>zerr ) zerr = abs(W(i))
         ENDDO
         zerr = (abs(W(M)))/zerr
         IF ( zerr>pprc ) jerr = nv - 1
         IF ( jerr/=0 ) WRITE (Io,99002) Uwm , jerr
99002    FORMAT (A25,' 2399',/5X,'ONLY THE FIRST',I6,' EIGENSOLUTIONS ','CLOSEST TO THE SHIFT POINT (F1 OR ZERO) PASS THE FEER ',   &
                &'ACCURACY TEST FOR EIGENVECTORS.')
      ENDIF
      CALL pack(W(1),icf,Mcbc(1))
      Er(nv) = abs(W(M)*erf/E(nv))
   ENDDO
END SUBROUTINE fqrw