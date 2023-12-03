!*==termsd.f90  processed by SPAG 7.61RG at 01:00 on 21 Mar 2022
 
SUBROUTINE termsd(Nnode,Gpth,Epnorm,Egpdt,Iorder,Mmn,Bterms)
   IMPLICIT NONE
   USE c_cjacob
   USE c_comjac
!
! Dummy argument declarations rewritten by SPAG
!
   INTEGER :: Nnode
   REAL*8 , DIMENSION(1) :: Gpth
   REAL , DIMENSION(4,1) :: Epnorm
   REAL , DIMENSION(4,1) :: Egpdt
   INTEGER , DIMENSION(1) :: Iorder
   INTEGER , DIMENSION(1) :: Mmn
   REAL*8 , DIMENSION(1) :: Bterms
!
! Local variable declarations rewritten by SPAG
!
   REAL*8 , DIMENSION(16) :: dshp , tdshp
   REAL*8 :: dum , eps , temp , th
   REAL*8 , DIMENSION(3,8) :: gridc
   INTEGER :: i , ii , ij , ik , io , ising , j , j1 , k , ngp , node3
   INTEGER , DIMENSION(3,3) :: index
   REAL*8 , DIMENSION(3,3) :: jacob , tj
   REAL*8 , DIMENSION(8) :: shp , tshp
   REAL*8 , DIMENSION(9) :: tie
   REAL*8 , DIMENSION(3) :: vn
!
! End of declarations rewritten by SPAG
!
!
! Dummy argument declarations rewritten by SPAG
!
!
! Local variable declarations rewritten by SPAG
!
!
! End of declarations rewritten by SPAG
!
!
!     DOUBLE PRECISION ROUTINE TO CALCULATE B-MATRIX TERMS
!     FOR ELEMENTS  QUAD4, QUAD8 AND TRIA6.
!
!     THE INPUT FLAG LETS THE SUBROUTINE SWITCH BETWEEN QUAD4,
!     QUAD8 AND TRIA6 VERSIONS
!
!     ELEMENT TYPE FLAG (LTYPFL) = 1  FOR QUAD4,
!                                = 2  FOR TRIA6 (NOT AVAILABLE),
!                                = 3  FOR QUAD8 (NOT AVAILABLE).
!
!     THE OUTPUT CONSISTS OF THE DETERMINANT OF THE JACOBIAN
!     (DETJ), SHAPE FUNCTIONS AND THEIR DERIVATIVES. THE OUTPUT
!     PARAMETER, BADJAC, IS AN INTERNAL LOGICAL FLAG TO THE CALLING
!     ROUTINE INDICATING THAT THE JACOBIAN IS NOT CORRECT.
!     PART OF THE INPUT IS PASSED TO THIS SUBROUTINE THROUGH THE
!     INTERNAL COMMON BLOCK  /COMJAC/.
!
   !>>>>EQUIVALENCE (dshpx(1),dshp(1)) , (dshpe(1),dshp(9))
   !>>>>EQUIVALENCE (Vn(1),Cjac(8)) , (Tie(1),Cjac(11))
   !>>>>EQUIVALENCE (Th,Cjac(1))
!
   eps = 1.0D-15
   badjac = .FALSE.
!
   IF ( ltypfl==2 ) THEN
!
!     TRIA6 VERSION
!
      ngp = 6
   ELSEIF ( ltypfl==3 ) THEN
!
!     QUAD8 VERSION
!
      ngp = 8
   ELSE
!
!     QUAD4 VERSION
!
      ngp = 4
      CALL q4shpd(xi,eta,shp,dshp)
   ENDIF
!
   DO i = 1 , ngp
      tshp(i) = shp(i)
      tdshp(i) = dshp(i)
      tdshp(i+8) = dshp(i+ngp)
   ENDDO
   DO i = 1 , ngp
      io = Iorder(i)
      shp(i) = tshp(io)
      dshp(i) = tdshp(io)
      dshp(i+8) = tdshp(io+8)
   ENDDO
!
   th = 0.0D0
   DO i = 1 , Nnode
      th = th + Gpth(i)*shp(i)
      DO j = 1 , 3
         j1 = j + 1
         gridc(j,i) = Egpdt(j1,i) + zeta*Gpth(i)*Epnorm(j1,i)*0.5D0
      ENDDO
   ENDDO
!
   DO i = 1 , 2
      ii = (i-1)*8
      DO j = 1 , 3
         tj(i,j) = 0.0D0
         DO k = 1 , Nnode
            tj(i,j) = tj(i,j) + dshp(k+ii)*gridc(j,k)
         ENDDO
      ENDDO
   ENDDO
!
   DO i = 1 , 3
      tj(3,i) = 0.0D0
      DO j = 1 , Nnode
         tj(3,i) = tj(3,i) + 0.5D0*Gpth(j)*shp(j)*Epnorm(i+1,j)
      ENDDO
   ENDDO
!
   DO i = 1 , 3
      DO j = 1 , 3
         IF ( dabs(tj(i,j))<eps ) tj(i,j) = 0.0D0
      ENDDO
   ENDDO
!
!     SET UP THE TRANSFORMATION FROM THIS INTEGRATION POINT C.S.
!     TO THE ELEMENT C.S.  TIE
!
   vn(1) = tj(1,2)*tj(2,3) - tj(2,2)*tj(1,3)
   vn(2) = tj(2,1)*tj(1,3) - tj(1,1)*tj(2,3)
   vn(3) = tj(1,1)*tj(2,2) - tj(2,1)*tj(1,2)
!
   temp = dsqrt(vn(1)*vn(1)+vn(2)*vn(2)+vn(3)*vn(3))
!
   tie(7) = vn(1)/temp
   tie(8) = vn(2)/temp
   tie(9) = vn(3)/temp
!
   temp = dsqrt(tie(8)*tie(8)+tie(9)*tie(9))
!
   tie(1) = tie(9)/temp
   tie(2) = 0.0D0
   tie(3) = -tie(7)/temp
!
   tie(4) = tie(8)*tie(3)
   tie(5) = temp
   tie(6) = -tie(1)*tie(8)
!
   CALL inverd(3,tj,3,dum,0,detj,ising,index)
!
!
!     NOTE - THE INVERSE OF JACOBIAN HAS BEEN STORED IN TJ
!            UPON RETURN FROM INVERD.
!
   IF ( ising==1 .AND. detj>0.0D0 ) THEN
!
!
      DO i = 1 , 3
         ii = (i-1)*3
         DO j = 1 , 3
            jacob(i,j) = 0.0D0
            DO k = 1 , 3
               ik = ii + k
               jacob(i,j) = jacob(i,j) + tie(ik)*tj(k,j)
            ENDDO
         ENDDO
      ENDDO
!
!     MULTIPLY THE INVERSE OF THE JACOBIAN BY THE TRANSPOSE
!     OF THE ARRAY CONTAINING DERIVATIVES OF THE SHAPE FUNCTIONS
!     TO GET THE TERMS USED IN THE ASSEMBLY OF THE B MATRIX.
!     NOTE THAT THE LAST ROW CONTAINS THE SHAPE FUNCTION VALUES.
!
      node3 = Nnode*3
      DO i = 1 , Nnode
         Bterms(node3+i) = shp(i)*jacob(3,3)
      ENDDO
!
      DO i = 1 , 3
         ii = (i-1)*Nnode
         DO j = 1 , Nnode
            ij = ii + j
            Bterms(ij) = 0.0D0
            DO k = 1 , 2
               ik = (k-1)*8
               Bterms(ij) = Bterms(ij) + jacob(i,k)*dshp(ik+j)
            ENDDO
         ENDDO
      ENDDO
   ELSE
      badjac = .TRUE.
   ENDIF
END SUBROUTINE termsd