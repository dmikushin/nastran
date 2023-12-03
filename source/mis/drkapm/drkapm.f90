!*==drkapm.f90 processed by SPAG 8.01RF 16:18  2 Dec 2023
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
!!SPAG Open source Personal, Educational or Academic User  NON-COMMERCIAL USE - Not for use on proprietary or closed source code
 
SUBROUTINE drkapm(Arg,Indx,Reslt)
   USE c_blk1
   USE c_blk2
   USE c_system
   USE c_xmssg
   IMPLICIT NONE
!
! Dummy argument declarations rewritten by SPAG
!
   COMPLEX :: Arg
   INTEGER :: Indx
   COMPLEX :: Reslt
!
! Local variable declarations rewritten by SPAG
!
   REAL :: a1 , a2 , b1 , c2n , c2p , c2q , c3q , csec , gam0 , gamn , gamp , pi2 , r , rindx , s1 , s2 , t1 , t2
   COMPLEX :: aln , alp , alp0 , at2 , at3 , c1 , c2 , c2test
   INTEGER :: i , nn
   EXTERNAL mesage
!
! End of declarations rewritten by SPAG
!
!
!     THIS SUBROUTINE COMPUTES THE DERVIATIVE OF KAPPA MINUS
!
!
   pi2 = 2.0*pi
   a1 = pi2/(sps-sns)
   a2 = -a1
   gam0 = sps*del - sigma
   b1 = gam0/(sps-sns)
   c1 = cexp(-ai*Arg/2.0*(sps-sns))
   c2q = gam0/dstr - scrk
   c3q = gam0/dstr + scrk
   s1 = sps/(dstr**2)
   s2 = sns/dstr
   nn = 0
   csec = c2q*c3q
   IF ( csec<0.0 ) nn = 1
   t1 = gam0*s1
   t2 = s2*sqrt(abs(csec))
   IF ( c2q<0.0 .AND. c3q<0.0 ) t2 = -t2
   IF ( nn==0 ) alp0 = t1 + t2
   IF ( nn==1 ) alp0 = cmplx(t1,t2)
   rindx = Indx
   IF ( Indx==0 ) THEN
      c2 = c1*b1/alp0*csin(pi/a1*(Arg-b1))/((b1-alp0)*sin(pi*b1/a1))*bsycon
   ELSE
      c2 = c1*b1/alp0*csin(pi/a1*(Arg-b1))/(a1*rindx+b1-Arg)*(1.0+(alp0-b1)/(b1-Arg))/(sin(pi*b1/a1))*bsycon
   ENDIF
   c2test = 0.0
   DO i = 1 , 200
      r = i
      IF ( Indx>=0 .OR. abs(rindx)/=r ) THEN
         IF ( Indx<=0 .OR. rindx/=r ) THEN
            gamp = pi2*r + gam0
            gamn = -pi2*r + gam0
            c2p = gamp/dstr - scrk
            c2q = gamp/dstr + scrk
            c2n = gamn/dstr - scrk
            c3q = gamn/dstr + scrk
            nn = 0
            csec = c2p*c2q
            IF ( csec<0.0 ) nn = 1
            t1 = gamp*s1
            t2 = s2*sqrt(abs(csec))
            IF ( c2p<0.0 .AND. c2q<0.0 ) t2 = -t2
            IF ( nn==0 ) alp = t1 + t2
            IF ( nn==1 ) alp = cmplx(t1,t2)
            nn = 0
            csec = c2n*c3q
            IF ( csec<0.0 ) nn = 1
            t1 = gamn*s1
            t2 = s2*sqrt(abs(csec))
            IF ( c2n<0.0 .AND. c3q<0.0 ) t2 = -t2
            IF ( nn==0 ) aln = t1 + t2
            IF ( nn==1 ) aln = cmplx(t1,t2)
            at2 = (alp-a1*r-b1)/(a1*r+b1-Arg)
            at3 = (aln-a2*r-b1)/(a2*r+b1-Arg)
            c2 = c2*(1.0+at2)*(1.0+at3)
            IF ( cabs((c2-c2test)/c2)<0.0009 ) THEN
               CALL spag_block_1
               RETURN
            ENDIF
            c2test = c2
         ENDIF
      ENDIF
   ENDDO
!
   WRITE (ibbout,99001) ufm
99001 FORMAT (A23,' - AMG MODULE -SUBROUTINE DRKAPM')
   CALL mesage(-61,0,0)
   RETURN
CONTAINS
   SUBROUTINE spag_block_1
      Reslt = C2
   END SUBROUTINE spag_block_1
END SUBROUTINE drkapm