      SUBROUTINE TUBES
C
C***
C  THE TUBE BEING SO SIMILAR TO THE ROD, WE ALTER THE EST FOR THE TUBE
C  SO THAT IT IS IDENTICAL TO THE ONE FOR THE ROD AND THEN CALL RODS
C SINGLE PRECISION VERSION
C SINGLE AND DOUBLE PRECISION VERSIONS OF THIS ROUTINE ARE IDENTICAL
C APART FROM THE NAME AND THE CALL TO RODD (RODS)
C***
C
C
C EST( 1) - ELEMENT ID.
C EST( 2) - SCALAR INDEX NUMBER FOR GRID POINT A
C EST( 3) - SCALAR INDEX NUMBER FOR GRID POINT B
C EST( 4) - MATERIAL ID.
C EST( 5) - OUTSIDE DIAMETER
C EST( 6) - THICKNESS
C EST( 7) - NON-STRUCTURAL MASS
C EST( 8) - COOR. SYS. ID. FOR GRID POINT A
C EST( 9) - BASIC COORDINATES OF GRID POINT A
C EST(10) -                ...
C EST(11) -                ...
C EST(12) - COOR. SYS. ID. FOR GRID POINT B
C EST(13) - BASIC COORDINATES OF GRID POINT B
C EST(14) -               ...
C EST(15) -               ...
C EST(16) - ELEMENT TEMPERATURE
C
      COMMON   /EMGEST/  EST(100)
      COMMON   /CONDAS/  PI
C
C ----------------------------------------------------------------------
C
      TEMP = EST(5) - EST(6)
      A = TEMP * EST(6) * PI
      FJ = .25 * A * ( TEMP**2 + EST(6)**2 )
      C = .5 * EST(5)
      M = 18
      DO 10 I = 1,10
      M = M - 1
   10 EST(M) = EST(M-1)
      EST(5) = A
      EST(6) = FJ
      EST(7) = C
      CALL RODS
      RETURN
      END
