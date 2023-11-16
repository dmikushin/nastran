
SUBROUTINE shxtrs(Nrow,Ncol,Array)
   IMPLICIT NONE
!
! Dummy argument declarations
!
   INTEGER Ncol , Nrow
   REAL Array(Nrow,1)
!
! Local variable declarations
!
   REAL const , eta , qpoint(2,4) , shp(4) , temp(4,4) , tpoint(2,3) , xsi
   INTEGER i , j , k
   LOGICAL tria
!
! End of declarations
!
!
!     TO EXTRAPOLATE VALUES IN ARRAY FROM A SET OF EVALUATION POINTS TO
!     THE GRID POINTS OF SPECIFIC SHELL ELEMENTS.
!     THE EXTRAPOLATION IS IN TWO DIMENSIONS.
!
!     INPUT :
!           NROW   - SIZE OF THE SET OF VALUES
!           NCOL   - NUMBER OF EVALUATION POINTS
!           ARRAY  - ARRAY OF DATA TO BE EXTRAPOLATED
!
!     OUTPUT:
!           ARRAY  - ARRAY OF EXTRAPOLATED DATA
!
!
!
!
!
   DATA tpoint/0.0 , 0.0 , 1.0 , 0.0 , 0.0 , 1.0/
   DATA qpoint/ - 1.0 , -1.0 , 1.0 , -1.0 , 1.0 , 1.0 , -1.0 , 1.0/
!
!     INITIALIZE
!
   tria = Ncol==3
!
   DO i = 1 , Nrow
      DO j = 1 , Ncol
         temp(i,j) = 0.0
      ENDDO
   ENDDO
!
!     BEGIN LOOP ON DESTINATION POINTS
!
   DO i = 1 , Ncol
!
!     EVALUATE PSEUDO-SHAPE FUNCTIONS
!
      IF ( .NOT.tria ) THEN
!
         xsi = qpoint(1,i)
         eta = qpoint(2,i)
         const = 0.577350269
         shp(1) = 0.75*(const-xsi)*(const-eta)
         shp(2) = 0.75*(const-xsi)*(const+eta)
         shp(3) = 0.75*(const+xsi)*(const-eta)
         shp(4) = 0.75*(const+xsi)*(const+eta)
      ELSE
!
         xsi = tpoint(1,i)
         eta = tpoint(2,i)
         shp(1) = 1.66666667 - 2.0*xsi - 2.0*eta
         shp(2) = 2.0*xsi - 0.33333333
         shp(3) = 2.0*eta - 0.33333333
      ENDIF
!
!     EXTRAPOLATE
!
      DO j = 1 , Nrow
         DO k = 1 , Ncol
            temp(j,i) = temp(j,i) + shp(k)*Array(j,k)
         ENDDO
      ENDDO
!
   ENDDO
!
!     COPY THE EXTRAPOLATED DATA BACK INTO ARRAY
!
   DO j = 1 , Ncol
      DO i = 1 , Nrow
         Array(i,j) = temp(i,j)
      ENDDO
   ENDDO
!
END SUBROUTINE shxtrs