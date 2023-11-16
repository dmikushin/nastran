
SUBROUTINE ta1etd(Elid,Ti,Grids)
   IMPLICIT NONE
!
! COMMON variable declarations
!
   LOGICAL Bufflg , Endid , Eorflg , Record
   INTEGER Defalt , Eltype , Gptt , Iback , Iout , Itemp , Oldeid , Oldel
   REAL Dum , Dummy(5)
   CHARACTER*23 Ufm
   COMMON /system/ Dum , Iout
   COMMON /ta1com/ Dummy , Gptt
   COMMON /ta1ett/ Eltype , Oldel , Eorflg , Endid , Bufflg , Itemp , Defalt , Iback , Record , Oldeid
   COMMON /xmssg / Ufm
!
! Dummy argument declarations
!
   INTEGER Elid , Grids
   INTEGER Ti(2)
!
! Local variable declarations
!
   REAL flag
   INTEGER i , id , maxwds , name(2) , nwords
!
! End of declarations
!
!
!     THIS ROUTINE (CALLED BY -TA1A- AND -TA1B-) READS ELEMENT
!     TEMPERATURE DATA FROM A PRE-POSITIONED RECORD
!
!     ELID   = ID OF ELEMENT FOR WHICH DATA IS DESIRED
!     TI     = BUFFER DATA IS TO BE RETURNED IN
!     GRIDS  = 0 IF EL-TEMP FORMAT DATA IS TO BE RETURNED
!            = NO. OF GRID POINTS IF GRID POINT DATA IS TO BE RETURNED.
!     ELTYPE = ELEMENT TYPE TO WHICH -ELID- BELONGS
!     OLDEL  = ELEMENT TYPE CURRENTLY BEING WORKED ON (INITIALLY 0)
!     OLDEID = ELEMENT ID FROM LAST CALL
!     EORFLG = .TRUE. WHEN ALL DATA HAS BEEN EXHAUSTED IN RECORD
!     ENDID  = .TRUE. WHEN ALL DATA HAS BEEN EXHAUSTED WITHIN AN ELEMENT
!              TYPE.
!     BUFFLG = NOT USED
!     ITEMP  = TEMPERATURE LOAD SET ID
!     IDEFT  = NOT USED
!     IDEFM  = NOT USED
!     RECORD = .TRUE. IF A RECORD OF DATA IS INITIALLY AVAILABLE
!     DEFALT = THE DEFALT TEMPERATURE VALUE OR -1 IF IT DOES NOT EXIST
!     AVRAGE = THE AVERAGE ELEMENT TEMPERATURE
!
   DATA name/4HTA1E , 4HTD  / , maxwds/33/
!
   IF ( Oldeid==Elid ) RETURN
   Oldeid = Elid
!
   IF ( Itemp==0 ) THEN
      DO i = 1 , maxwds
         Ti(i) = 0.0
      ENDDO
      RETURN
!
   ELSEIF ( .NOT.Record .OR. Eorflg ) THEN
!
!     NO MORE DATA FOR THIS ELEMENT TYPE
!
      Endid = .TRUE.
      GOTO 200
   ENDIF
 100  IF ( Eltype/=Oldel ) GOTO 300
   IF ( Endid ) THEN
      Endid = .TRUE.
   ELSE
      DO
!
!     HERE WHEN ELTYPE IS AT HAND AND END OF THIS TYPE DATA
!     HAS NOT YET BEEN REACHED.  READ AN ELEMENT ID
!
         CALL read(*500,*600,Gptt,id,1,0,flag)
         IF ( id==0 ) THEN
            Endid = .TRUE.
            EXIT
         ELSEIF ( iabs(id)==Elid ) THEN
            IF ( id<=0 ) EXIT
!
!     MATCH ON ELEMNT ID MADE AND IT WAS WITH DATA
!
            CALL read(*500,*600,Gptt,Ti,nwords,0,flag)
            RETURN
         ELSEIF ( id>0 ) THEN
            CALL read(*500,*600,Gptt,Ti,nwords,0,flag)
         ENDIF
      ENDDO
   ENDIF
!
!     NO DATA FOR ELEMENT ID DESIRED, THUS USE DEFALT
!
 200  IF ( Defalt==-1 ) THEN
!
!     NO TEMP DATA OR DEFALT
!
      WRITE (Iout,99001) Ufm , Elid , Itemp
99001 FORMAT (A23,' 4016, THERE IS NO TEMPERATURE DATA FOR ELEMENT',I9,' IN SET',I9)
      CALL mesage(-61,0,0)
   ELSEIF ( Grids>0 ) THEN
!
      DO i = 1 , Grids
         Ti(i) = Defalt
      ENDDO
      Ti(Grids+1) = Defalt
      RETURN
   ELSE
      DO i = 2 , maxwds
         Ti(i) = 0
      ENDDO
      Ti(1) = Defalt
      IF ( Eltype==34 ) Ti(2) = Defalt
      RETURN
   ENDIF
!
!     LOOK FOR MATCH ON ELTYPE (FIRST SKIP ANY UNUSED ELEMENT DATA)
!
 300  IF ( .NOT.(Endid) ) THEN
      DO
         CALL read(*500,*600,Gptt,id,1,0,flag)
         IF ( id<0 ) THEN
         ELSEIF ( id==0 ) THEN
            EXIT
         ELSE
            CALL read(*500,*600,Gptt,Ti,nwords,0,flag)
         ENDIF
      ENDDO
   ENDIF
!
!     READ ELTYPE AND COUNT
!
   CALL read(*500,*400,Gptt,Ti,2,0,flag)
   Oldel = Ti(1)
   nwords = Ti(2)
   Endid = .FALSE.
   Iback = 1
   GOTO 100
!
!     END OF RECORD HIT
!
 400  Eorflg = .TRUE.
   Endid = .TRUE.
   GOTO 200
 500  CALL mesage(-2,Gptt,name)
 600  CALL mesage(-3,Gptt,name)
END SUBROUTINE ta1etd