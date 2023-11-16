
SUBROUTINE sdcom2(P,Ac,Wa,Wb)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   INTEGER C , Lasti , Lastpl , Row , Start
   REAL Frstpc , Spflg
   COMMON /sdcomx/ Row , C , Spflg , Start , Frstpc , Lastpl , Lasti
!
! Dummy argument declarations
!
   INTEGER Ac(1)
   DOUBLE PRECISION P(1) , Wa(1) , Wb(1)
!
! Local variable declarations
!
   DOUBLE PRECISION epsi , pi
   INTEGER i , iend , ijmk , ilmk , istart , j , k , k1 , l
!
! End of declarations
!
!
   DATA epsi/1.D-36/
!
   j = 1
   l = 1
   k1 = Lastpl + 1
   iend = min0(Lastpl,Lasti)
   istart = max0(k1,Start)
   IF ( C==Lastpl ) THEN
!
      IF ( Start<=Lastpl ) THEN
         DO i = Start , iend
            pi = -P(i)/P(1)
            IF ( dabs(pi)<epsi ) pi = 0.D0
            ijmk = j - i
            ilmk = l - i
            DO k = i , Lastpl
               Wb(k+ijmk) = pi*P(k) + Wa(k+ilmk)
            ENDDO
            j = ijmk + k1
            l = ilmk + k1
            P(i) = pi
         ENDDO
         IF ( Lastpl>=Lasti ) RETURN
      ENDIF
      DO i = istart , Lasti
         pi = -P(i)/P(1)
         IF ( dabs(pi)<epsi ) pi = 0.D0
         ijmk = j - i
         IF ( Ac(i)<0 ) THEN
            DO k = i , C
               Wb(k+ijmk) = pi*P(k)
            ENDDO
         ELSE
            DO k = i , C
               IF ( Ac(k)>0 ) THEN
                  Wb(k+ijmk) = pi*P(k) + Wa(l)
                  l = l + 1
               ELSE
                  Wb(k+ijmk) = pi*P(k)
               ENDIF
            ENDDO
         ENDIF
         j = ijmk + C + 1
         P(i) = pi
      ENDDO
   ELSE
      IF ( Start<=Lastpl ) THEN
         DO i = Start , iend
            pi = -P(i)/P(1)
            IF ( dabs(pi)<epsi ) pi = 0.D0
            ijmk = j - i
            ilmk = l - i
            DO k = i , Lastpl
               Wb(k+ijmk) = pi*P(k) + Wa(k+ilmk)
            ENDDO
            l = ilmk + k1
            DO k = k1 , C
               IF ( Ac(k)>0 ) THEN
                  Wb(k+ijmk) = pi*P(k) + Wa(l)
                  l = l + 1
               ELSE
                  Wb(k+ijmk) = pi*P(k)
               ENDIF
            ENDDO
            j = ijmk + C + 1
            P(i) = pi
         ENDDO
         IF ( Lastpl>=Lasti ) RETURN
      ENDIF
      DO i = istart , Lasti
         pi = -P(i)/P(1)
         IF ( dabs(pi)<epsi ) pi = 0.D0
         ijmk = j - i
         IF ( Ac(i)<0 ) THEN
            DO k = i , C
               Wb(k+ijmk) = pi*P(k)
            ENDDO
         ELSE
            DO k = i , C
               IF ( Ac(k)>0 ) THEN
                  Wb(k+ijmk) = pi*P(k) + Wa(l)
                  l = l + 1
               ELSE
                  Wb(k+ijmk) = pi*P(k)
               ENDIF
            ENDDO
         ENDIF
         j = ijmk + C + 1
         P(i) = pi
      ENDDO
      RETURN
   ENDIF
END SUBROUTINE sdcom2