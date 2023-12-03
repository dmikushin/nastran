!*==fqrw.f90 processed by SPAG 8.01RF 16:19  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE fqrw(M,E,Er,A,B,W,P,Q,Xm,Int,Zb,Srfle,Mcbc)
   USE c_feerxx
   USE c_lhpwx
   USE c_names
   USE c_packx
   USE c_system
   USE c_unpakx
   USE c_xmssg
   USE iso_fortran_env
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: M
   REAL , DIMENSION(1) :: E
   REAL , DIMENSION(1) :: Er
   REAL , DIMENSION(1) :: A
   REAL , DIMENSION(2) :: B
   REAL , DIMENSION(1) :: W
   REAL , DIMENSION(1) :: P
   REAL , DIMENSION(1) :: Q
   REAL , DIMENSION(1) :: Xm
   LOGICAL , DIMENSION(1) :: Int
   REAL , DIMENSION(1) :: Zb
   INTEGER :: Srfle
   INTEGER , DIMENSION(7) :: Mcbc
!
! Local variable declarations rewritten by SPAG
!
   REAL , SAVE :: base
   REAL :: bmax , c , delta , dim , dimf , e1 , e2 , emax , eps , epx , epx2 , erf , ev , f , gg , hov , lambda , pprc , prc ,      &
         & ratio , s , scale , shift , ss , sum , sumx , t , tmax , tol , x , y , z , zerr
   INTEGER :: i , icf , ij , io , iprec , irp , it , j , jerr , jrp , k , k1 , l , l1 , m1 , mvec , niter , nrp , nv
   INTEGER , SAVE :: iexp , ilim
   INTEGER , DIMENSION(7) :: mcb
   EXTERNAL close , gopen , makmcb , pack , unpack
!
! End of declarations rewritten by SPAG
!
   INTEGER :: spag_nextblock_1
!
   !>>>>EQUIVALENCE (Ksystm(2),Io) , (Ksystm(55),Iprec)
   DATA ilim , iexp , base/120 , 60 , 2./
!
!     IACC  =  ACCURACY CONTROL (EPSILON) FOR UNDERFLOW
!
   IF ( M==1 ) RETURN
   lambda = dlamda
   iprc = 1
   CALL makmcb(mcb(1),Srfle,M,2,iprc)
   icf = Mcbc(1)
   incr = 1
   incrp = 1
   itp1 = iprc
   itp2 = iprc
   it = iacc*iprec
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
   SPAG_Loop_1_1: DO i = 1 , ilim
      IF ( scale*tmax>hov ) EXIT SPAG_Loop_1_1
      scale = scale*2.
   ENDDO SPAG_Loop_1_1
   IF ( bmax/=0. ) THEN
      DO i = 1 , M
         E(i) = A(i)*scale
         W(i) = (B(i)*scale)**2
      ENDDO
      delta = tmax*scale*tol
      eps = delta*delta
      k = M
      SPAG_Loop_1_2: DO
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
            EXIT SPAG_Loop_1_2
         ELSE
            l1 = l - 1
            SPAG_Loop_2_3: DO i = 1 , l
               k1 = k
               k = k - 1
               IF ( W(k1)<eps ) EXIT SPAG_Loop_2_3
            ENDDO SPAG_Loop_2_3
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
                  SPAG_Loop_2_4: DO
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
                        EXIT SPAG_Loop_2_4
                     ENDIF
                  ENDDO SPAG_Loop_2_4
               ELSE
                  E(l) = e1
                  E(l1) = e2
                  W(l1) = 0.
               ENDIF
            ELSE
               W(l) = 0.
            ENDIF
         ENDIF
      ENDDO SPAG_Loop_1_2
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
      spag_nextblock_1 = 1
      SPAG_DispatchLoop_1: DO
         SELECT CASE (spag_nextblock_1)
         CASE (1)
            ij = nv
            sumx = 0.
            irp = 0
            IF ( nv==1 ) THEN
               nrp = 0
               DO i = 1 , M
                  W(i) = 1.
               ENDDO
               iip = 1
               nnp = M
               spag_nextblock_1 = 2
               CYCLE SPAG_DispatchLoop_1
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
                  CALL gopen(Srfle,Zb(1),wrt)
               ELSE
                  CALL gopen(Srfle,Zb(1),wrtrew)
                  mcb(2) = 0
                  mcb(6) = 0
               ENDIF
               iip = 1
               nnp = M
               CALL pack(W(1),Srfle,mcb(1))
               CALL close(Srfle,norew)
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
               CALL gopen(Srfle,Zb(1),rdrew)
               j = 0
               SPAG_Loop_2_5: DO
                  sum = 0.
                  j = j + 1
                  DO i = 1 , M
                     sum = sum + W(i)*P(i)
                  ENDDO
                  DO i = 1 , M
                     Q(i) = Q(i) - sum*W(i)
                  ENDDO
                  IF ( j==nv-1 ) EXIT SPAG_Loop_2_5
                  ii = 1
                  nn = M
                  CALL unpack(*10,Srfle,W(1))
               ENDDO SPAG_Loop_2_5
            ENDIF
 10         CALL close(Srfle,norew)
            sum = 0.
            DO i = 1 , M
               sum = sum + Q(i)**2
            ENDDO
            sum = 1./sqrt(sum)
            DO i = 1 , M
               Q(i) = Q(i)*sum
               W(i) = Q(i)
            ENDDO
            spag_nextblock_1 = 2
         CASE (2)
            ev = E(nv)*f
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
            SPAG_Loop_2_6: DO
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
                  IF ( nv==1 ) THEN
                     spag_nextblock_1 = 3
                     CYCLE SPAG_DispatchLoop_1
                  ENDIF
!
!     MULTIPLE EIGENVALUES AND ORTHOGONALIZATION
!
                  irp = irp + 1
                  CALL gopen(Srfle,Zb(1),rdrew)
                  DO i = 1 , M
                     Q(i) = W(i)
                  ENDDO
                  sumx = 0.
                  jrp = nv - 1
                  DO i = 1 , jrp
                     ii = 1
                     nn = M
                     CALL unpack(*20,Srfle,P(1))
                     sum = 0.
                     DO j = 1 , M
                        sum = sum + P(j)*Q(j)
                     ENDDO
                     IF ( abs(sum)>sumx ) sumx = abs(sum)
                     DO j = 1 , M
                        W(j) = W(j) - sum*P(j)
                     ENDDO
                  ENDDO
                  EXIT SPAG_Loop_2_6
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
            ENDDO SPAG_Loop_2_6
 20         CALL close(Srfle,norew)
            spag_nextblock_1 = 3
         CASE (3)
!
!     LOGIC SETTING SUM (BY G.CHAN/UNISYS  7/92)
!
!     SUM = PRC*PREC COULD PRODUCE UNDERFLOW
!     SUM = ZERO, COULD CAUSE DIVIDED BY ZERO AFTER 420 FOR NULL VECTOR
!     SO, WE CHOOSE SUM A LITTLE SMALLER THAN PRC
!
!     SUM = PRC*PRC
!     SUM = 0.0
            sum = prc*1.0E-4
!
            DO i = 1 , M
               sum = sum + W(i)*W(i)
            ENDDO
            sum = 1./sqrt(sum)
            DO i = 1 , M
               W(i) = W(i)*sum
            ENDDO
            IF ( sumx>0.9 .AND. irp<3 ) THEN
               spag_nextblock_1 = 2
               CYCLE SPAG_DispatchLoop_1
            ENDIF
            IF ( l16/=0 ) WRITE (io,99001) nv , niter , irp , sumx
99001       FORMAT (10X,18H FEER QRW ELEMENT ,I5,6H ITER ,2I3,6H PROJ ,E16.8)
            IF ( jerr<=0 ) THEN
               zerr = abs(W(1))
               DO i = 2 , M
                  IF ( abs(W(i))>zerr ) zerr = abs(W(i))
               ENDDO
               zerr = (abs(W(M)))/zerr
               IF ( zerr>pprc ) jerr = nv - 1
               IF ( jerr/=0 ) WRITE (io,99002) uwm , jerr
99002          FORMAT (A25,' 2399',/5X,'ONLY THE FIRST',I6,' EIGENSOLUTIONS ',                                                      &
                      &'CLOSEST TO THE SHIFT POINT (F1 OR ZERO) PASS THE FEER ','ACCURACY TEST FOR EIGENVECTORS.')
            ENDIF
            CALL pack(W(1),icf,Mcbc(1))
            Er(nv) = abs(W(M)*erf/E(nv))
            EXIT SPAG_DispatchLoop_1
         END SELECT
      ENDDO SPAG_DispatchLoop_1
   ENDDO
END SUBROUTINE fqrw