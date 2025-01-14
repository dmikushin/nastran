program nastran

  ! Environment

  character(len=255) :: nastran_home, nastran_cfg

  ! Command line

  character(len=80) :: basename

  CHARACTER*80    VALUE
  CHARACTER*5     TMP
  INTEGER         SPERLK
  REAL            SYSTM(94)
  COMMON / LSTADD / LASTAD
  COMMON / SYSTEM / ISYSTM(94),SPERLK
  COMMON / SOFDSN / SDSN(10)
  COMMON / LOGOUT / LOUT
  COMMON / RESDIC / IRDICT, IROPEN
  COMMON / ZZZZZZ / IZ(400000000)
  COMMON / DBM    / &
       IDBBAS, IDBFRE, IDBDIR, INDBAS, INDCLR, INDCBP, &
       NBLOCK, LENALC, IOCODE, IFILEX, NAME,   MAXALC, &
       MAXBLK, MAXDSK, IDBLEN, IDBADR, IBASBF, INDDIR, &
       NUMOPN, NUMCLS, NUMWRI, NUMREA, LENOPC

  ! INCLUDE 'NASNAMES.COM'
  character(len=80) :: dirtry, rfdir
  character(len=80) :: input, output, log, punch
  character(len=80) :: plot, nptp, dic, optp, rdic, in12, out11
  character(len=80) :: inp1, inp2
  common /dosnam/ dirtry, rfdir, input, output, log, punch, plot, &
       nptp, dic, optp, rdic, in12, out11, inp1, inp2

  character(len=80), dimension(89) :: dsnames
  common /dsname/ dsnames

  character(len=1) :: pthsep
  common /pthblk/ pthsep
  ! End of NASNAMES.COM

  CHARACTER*80    SDSN
  EQUIVALENCE    ( ISYSTM, SYSTM )

  ! I/O files
  character(len=80) :: inpnm, outnm, lognm, optpnm, nptpnm, pltnm, dictnm, punchnm

  ! Memory namelist
  integer :: dbmem = 12000000
  integer :: ocmem =  2000000
  namelist /memory/ dbmem, ocmem

  ! Directories namelist
  character(len=72) :: rfdircty, dircty
  namelist /directories/ rfdircty, dircty

  ! Fortran units namelist
  character(len=80), dimension(11:21) :: ftn
  namelist /funits/ ftn

  ! SDSN files namelist
  character(len=80), dimension(10) :: sof
  namelist /sdsnfiles/ sof

  ! Parameters
  integer, parameter :: NMLUNIT = 999

  ! Local variables
  integer :: ids, ios

  LENOPC = 400000000

  ! Get the environment

  call nastran_environment()

  ! Process the command line

  call nastran_cmd_line()

  ! SAVE STARTING CPU TIME AND WALL CLOCK TIME IN /SYSTEM/

  ISYSTM(18) = 0
  CALL SECOND (SYSTM(18))
  CALL WALTIM (ISYSTM(32))

  ! EXECUTE NASTRAN SUPER LINK

  LEN = 80
  VALUE = ' '
  CALL BTSTRP

  ! Open the namelist file

  call open_nastran_nml(NMLUNIT)

  ! Read the memory namelist
  read (unit=nmlunit, nml=memory, iostat=ios)
  select case (ios)
  case (0)
     idblen = dbmem
     iocmem = ocmem
     if (lenopc < ocmem) then
        print *, " Largest value for open core allowed is:", lenopc
        call mesage ( -61, 0, 0 )
     end if
     if (idblen /= 0) idblen = lenopc - iocmem
     lastad = locfx(iz(iocmem))
     if (idblen /= 0) idbadr = locfx(iz(iocmem+1))
     lenopc = iocmem
  case default
     print *, "Error reading the memory namelist."
     stop
  end select

  CALL DBMINT
  LOUT   = 3
  IRDICT = 4
  SPERLK = 1
  ISYSTM(11) = 1

  ! Read the directories namelist

  read (unit=nmlunit, nml=directories, iostat=ios)
  select case (ios)
  case (0)
     rfdir = trim(nastran_home) // pthsep // trim(rfdircty)
     dirtry = trim(nastran_home) // pthsep // trim(dircty)
     do i = 1, 9
        write (tmp, '("scr0",I1)') i
        dsnames(i) = trim(dirtry) // pthsep // tmp
     end do
     do i = 10,89
        write (tmp, '("scr",I2)') i
        dsnames(i) = trim(dirtry) // pthsep // tmp
     end do
  case default
     print *, "Error reading the directories namelist."
     stop
  end select

  ! Read the I/O files namelist
  log = trim(lognm)
  optp = trim(optpnm)
  nptp = trim(nptpnm)
  plot = trim(pltnm)
  dic = trim(dictnm)
  punch = trim(punchnm)
  !
  dsnames(1) = trim(punchnm)
  dsnames(3) = trim(lognm)
  dsnames(4) = trim(dictnm)
  dsnames(5) = trim(inpnm)
  dsnames(6) = trim(outnm)
  dsnames(7) = trim(optpnm)
  dsnames(8) = trim(nptpnm)
  dsnames(10) = trim(pltnm)

  ! Read the Fortran units namelist
  read (unit=nmlunit, nml=funits, iostat=ios)
  select case (ios)
  case (0)
     if (ftn(11)(1:4) == 'NONE') then
        out11 = trim(basename) // '.ftn11'
     else
        out11 = trim(ftn(11))
     end if
     dsnames(11) = out11
     !
     if (ftn(12)(1:4) == 'NONE') then
        in12 = trim(basename) // '.ftn12'
     else
        in12 = trim(ftn(12))
     end if
     dsnames(12) = in12
     !
     do ids = 13, 21
        if (ftn(ids)(1:4) == 'NONE') then
           write (dsnames(ids), '(A,".ftn",I2)') trim(basename), ids
        else
           dsnames(ids) = trim(ftn(ids))
        end if
     end do
  case default
     print *, "Error reading the funits namelist."
     stop
  end select

  ! Read the SDSN files namelist
  read (unit=nmlunit, nml=sdsnfiles, iostat=ios)
  select case (ios)
  case (0)
     do ids = 1, 9
        if (sof(ids)(1:4) == 'NONE') then
           write (sdsn(ids), '(A,".sof",I1)') trim(basename), ids
        else
           sdsn(ids) = trim(sof(ids))
        end if
     end do
     if (sof(10)(1:4) == 'NONE') then
        sdsn(10) = trim(basename) // '.sof10'
     else
        sdsn(10) = trim(sof(10))
     end if
  case default
     print *, "Error reading the sdsnfiles namelist."
     stop
  end select

  ! Open basic I/O files
  open (unit=3, file=trim(lognm), status='UNKNOWN')
  open (unit=5, file=trim(inpnm), status="OLD")
  open (unit=6, file=trim(outnm), status="NEW")

  if (punchnm(1:4) /= 'NONE') open (unit=1, file=trim(punchnm), status='UNKNOWN')
  if (dictnm(1:4) /= 'NONE') open (unit=4, file=trim(dictnm), status='UNKNOWN')
  if (pltnm(1:4) /= 'NONE') open (unit=10, file=trim(pltnm), status='UNKNOWN')
  if (ftn(11)(1:4) /= 'NONE') open (unit=11, file=trim(ftn(11)), status='UNKNOWN')
  if (ftn(12)(1:4) /= 'NONE') open (unit=12, file=trim(ftn(12)), status='UNKNOWN')

  call xsem00

  stop

contains

  subroutine nastran_environment()
    use iso_fortran_env
    implicit none

    ! Local variables
    integer :: length, status

    ! NASTRAN home directory

    call get_environment_variable("NASTRANHOME", nastran_home, length, status)
    select case(status)
    case (-1)
       write (error_unit, '(A)') &
            "ERROR: NASTRANHOME exceeds 255 characters."
       stop
    case (0)
       continue
    case (1)
       write (error_unit, '(A)') &
            "ERROR: NASTRANHOME does not exist."
       stop
    case (2)
       write (error_unit, '(A)') &
            "ERROR: Processor does not support environment variables."
       stop
    case default
       write (error_unit, '(A,1X,I2)') &
            "ERROR: Unknown environment variable status:", status
       stop
    end select

    ! NASTRAN namelist file.

    call get_environment_variable("NASTRANCFG", nastran_cfg, length, status)
    select case(status)
    case (-1)
       write (error_unit, '(A)') &
            "ERROR: NASTRANCFG exceeds 255 characters."
       stop
    case (0)
       continue
    case (1)
       write (error_unit, '(A)') &
            "ERROR: NASTRANCFG does not exist."
       stop
    case (2)
       write (error_unit, '(A)') &
            "ERROR: Processor does not support environment variables."
       stop
    case default
       write (error_unit, '(A,1X,I2)') &
            "ERROR: Unknown environment variable status:", status
       stop
    end select

    return
  end subroutine nastran_environment

  subroutine nastran_cmd_line()
    use iso_fortran_env
    implicit none

    ! Argument flags
    logical :: setoutnm, setlognm

    ! Local variables
    integer :: i, count, endbase, length, status
    character(len=80) :: theArg

    setoutnm = .false.
    setlognm = .false.
    count = 0
    do
       ! Get the next argument
       count = count + 1
       call get_command_argument(count, theArg, length, status)
       select case (status)
       case (1:)
          stop 'ERROR: Command line read failure.'
       case (:-1)
          write (error_unit, '(A,A)') 'Argument: ', trim(theArg)
          stop 'ERROR: Truncated command line argument.'
       case default
          continue
       end select

       ! Process the argument
       select case (trim(theArg))
       case ('-o') ! Output file name
          if (setoutnm) stop 'ERROR: Multiple output file options.'
          count = count + 1
          call get_command_argument(count, outnm, length, status)
          select case (status)
          case (1:)
             stop 'ERROR: Output name read failure.'
          case (:-1)
             write (error_unit, '(A,A)') 'Output name: ', trim(outnm)
             stop 'ERROR: Truncated output name.'
          case default
             setoutnm = .true.
          end select
       case ('-l') ! Log file name
          if (setlognm) stop 'ERROR: Multiple log file options.'
          count = count + 1
          call get_command_argument(count, lognm, length, status)
          select case (status)
          case (1:)
             stop 'ERROR: Log file read failure.'
          case (:-1)
             write (error_unit, '(A,A)') 'Log name: ', trim(lognm)
             stop 'ERROR: Truncated log file name.'
          case default
             setlognm = .true.
          end select
       case default ! Input file name
          if (0 < length) then
             inpnm = trim(theArg)
             endbase = index(inpnm,'.inp',.true.) - 1
             basename = inpnm(1:endbase)
             exit
          else
             stop 'ERROR: Must provide an input file name.'
          end if
       end select

    end do

    ! Set the arguments
    if (.NOT.setoutnm) outnm = trim(basename) // '.out'
    if (.NOT.setlognm) lognm = trim(basename) // '.log'

    optpnm = trim(basename) // '.optp'
    nptpnm = trim(basename) // '.nptp'
    pltnm = trim(basename) // '.plt'
    dictnm = trim(basename) // '.dic'
    punchnm = trim(basename) // '.punch'

    return
  end subroutine nastran_cmd_line

  subroutine open_nastran_nml(nml_unit)
    use iso_fortran_env

    ! Arguments
    integer, intent(in) :: nml_unit

    ! Local variables
    logical :: local_nml
    character(len=255) :: nastran_nml_file

    ! Test for a project local namelist file
    inquire(file="nastran.nml", exist=local_nml)

    if (local_nml) then
       nastran_nml_file = "nastran.nml"
    else
       nastran_nml_file = trim(nastran_cfg)
    end if

    open (unit=nml_unit, file=nastran_nml_file, iostat=ios)
    select case (ios)
    case (0)
       continue
    case default
       write (error_unit, '(A,1X,A)') "ERROR: Unable to open", &
            trim(nastran_nml_file)
       stop
    end select

    return
  end subroutine open_nastran_nml

end program nastran
