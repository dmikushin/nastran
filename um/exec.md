
# 2.0  GENERAL DESCRIPTION OF DATA DECK

   The input deck begins with the required resident operating system control
cards. The type and number of these cards will vary with the installation.
Instructions for the preparation of these control cards should be obtained
from the programming staff at each installation.

   The operating system control cards reference the NASTRAN primary input
file. This is the file that is assigned to FORTRAN unit 5. The primary input
file may contain the complete NASTRAN Data Deck or it may contain parts of the
NASTRAN Data Deck and include references to secondary input files that contain
the remainder of the NASTRAN Data Deck. Section 2.0.1 describes the setup of
the NASTRAN Data Deck and Section 2.0.2 describes the usage of secondary input
files via the READFILE capability.

## 2.0.1  NASTRAN Data Deck

   The NASTRAN Data Deck is constructed in the following order (depending on
the particular job requirements):

   1. The NASTRAN card (optional)

   2. The Executive Control Deck (required)

   3. The Substructure Control Deck (required only in substructure analyses)

   4. The Case Control Deck (required)

   5. The Bulk Data Deck (required)

   6. The INPUT Module Data card(s) (required only if the INPUT module is
      used)

   The NASTRAN card is used to change the default values for certain
operational parameters, such as the buffer size and the machine configuration.
The NASTRAN card is optional, but, if present, it must be the first card of
the NASTRAN Data Deck. It is described in detail in Section 2.1.

   The Executive Control Deck begins with the NASTRAN ID card and ends with
the CEND card. It identifies the job and the type of solution to be performed.
It also declares the general conditions under which the job is to be executed,
such as, maximum time allowed, type of system diagnostics desired, restart
conditions, and whether or not the job is to be checkpointed. If the job is to
be executed with a rigid format, the number of the rigid format is declared
along with any alterations to the rigid format that may be desired. If Direct
Matrix Abstraction is used, the complete DMAP sequence must appear in the
Executive Control Deck. The executive control cards and examples of their use
are described in Section 2.2.

   The Substructure Control Deck begins with the SUBSTRUCTURE card and
terminates with the ENDSUBS card. It defines the general attributes of the
Automated Multi-stage Substructuring capability and establishes the control of
the Substructure Operating File (SOF). The command cards are described in
Section 2.7.

   When automated multi-stage substructuring is not included, then the Case
Control Deck begins with the first card following CEND and ends with the BEGIN
BULK card. It defines the subcase structure for the problem, makes selections
from the Bulk Data Deck, and makes output requests for printing, punching and
plotting. A general discussion of the functions of the Case Control Deck and a
detailed description of the cards used in this deck are given in Section 2.3.
The special requirements of the Case Control Deck for each rigid format are
discussed in Section 3.

   The Bulk Data Deck begins with the card following BEGIN BULK and ends with
the card preceding ENDDATA. It contains all of the details of the structural
model and the conditions for the solution. A detailed description of all of
the bulk data cards is given in Section 2.4. The BEGIN BULK and ENDDATA cards
must be present even though no new bulk data is being introduced into the
problem or all of the bulk data is coming from an alternate source, such as
User's Master File or user generated input. The format of the BEGIN BULK card
is free field. The ENDDATA card must begin in column 1 or 2. Generally
speaking, only one structural model can be defined in the Bulk Data Deck.
However, some of the bulk data, such as cards associated with loading
conditions, constraints, direct input matrices, transfer functions, and
thermal fields may exist in multiple sets. All types of data that are
available in multiple sets are discussed in Section 2.3.1. Only sets selected
in the Case Control Deck will be used in any particular solution.

   If the INPUT module is employed, one or two additional data cards are
required following the ENDDATA card. For specific cases, see Section 2.6.

   Comment cards may be inserted in any of the parts of the NASTRAN Data Deck.
These cards are identified by a $ in column one. Columns 2-72 may contain any
desired text.

## 2.0.2  Usage of Secondary Input Files Via the READFILE Capability

   The READFILE capability allows you to logically read data from one or more
external, secondary, card-image files by referencing these files from the
NASTRAN primary input file. (The primary input file is the file that is
assigned to FORTRAN unit 5 from which NASTRAN normally reads the input data.)

### 2.0.2.1  Description of the Capability

   The format of the READFILE card is as follows:

      READFILE name

where "name" refers to an external, secondary, card-image file.

   When a READFILE card is encountered in the primary input file, NASTRAN
reads all subsequent input data from the specified secondary file until an
end-of-file condition or an ENDDATA card is encountered on that file,
whichever occurs earlier. If an end-of-file condition is encountered on the
secondary file before an ENDDATA card is detected, the program resumes reading
of the input data from the primary input file and the process continues. If an
ENDDATA card is encountered on the secondary file before an end-of-file
condition is detected, obviously the program will not read any more input data
from either the secondary file or the primary file, unless the INPUT module is
being used, in which case the data required for the INPUT module will be read
from the primary input file (see Item 5 in the following discussion).

   The flexibilities of the READFILE cards are as follows:

   1. The format of the READFILE card is free-field. The only restrictions are
      that there should be at least one space between the word READFILE and
      the "name" of the secondary file and that the card cannot extend beyond
      one card image (80 columns).

   2. Nested READFILE cards are allowed. That is, READFILE cards are permitted
      in both the NASTRAN primary and secondary input files.

   3. If input cards from the READFILE file are not to be echoed, you can add
      the option NOPRINT after READFILE.

   4. READFILE cards may be used anywhere in the Executive Control,
      Substructure Control, Case Control and Bulk Data Decks. (The NASTRAN
      card can also be specified in a secondary file.)

   5. If the INPUT module is used, the data required for that module must
      appear in the primary input file.

   6. On the CDC and DEC VAX versions, "name" may be any valid file name (see
      Examples 1 and 2 below). On the IBM version, "name" may be either a
      sequential file name (see Example 3) or a member name of a PDS (see
      Example 4). On the UNIVAC, "name" may be any file name (see Example 5)
      or file.element name (see Example 6).

### 2.0.2.2  Examples of READFILE Capability Usage

   The following examples illustrate several ways in which the READFILE
capability can be used. These examples also illustrate the usage of this
capability on all four versions of NASTRAN.

#### Example 1

   This example illustrates the usage of the READFILE capability for reading
in the restart dictionary in a checkpoint/restart run on the CDC version.
(This example assumes that the output on the punch file in the checkpoint run
contains only the restart dictionary.)

   /JOB
    .
    .
    .
   COPYBR,INPUT,INPUT1.
   COPYBR,INPUT,INPUT2.
   REWIND,INPUT1,INPUT2.
   * RUN CHECKPOINT JOB
   LINK1,INPUT1,OUTPUT,PUNCH1,UT1.
   * MANIPULATE FILES
   PACK,PUNCH1.
   REWIND,PUNCH1.
   RETURN,POOL.
   RENAME,OPTP=NPTP.
   * RUN RESTART JOB
   LINK1,INPUT2,OUTPUT,PUNCH2,UT1.
   /EOR
   NASTRAN FILES=NPTP
    .
    . (Data for Checkpoint Job)
    .
   /EOR
   NASTRAN FILES=OPTP
    .
   $ READ THE RESTART DICTIONARY
   READFILE PUNCH1
    .
   CEND
    .
    . (Data for Restart Job)
    .
   /EOF

#### Example 2

   This example illustrates the use of multiple READFILE cards on the DEC VAX
version.

   ID ....
    .
    .
    .
   BEGIN BULK
   READFILE DDB1:[NASDIR]FUSELAGE.DT
   READFILE DDB1:[NASDIR]WINGS.DT
   READFILE,NOPRINT,DDB1:[NASDIR]TAIL.DT
   ENDDATA

The directory and device names need not be specified if default values are to
be used.

#### Example 3

   In this example, the READFILE capability is used to access a sequential
file on the IBM version. The format for reading a sequential file is to
include the DDname of the file on the READFILE card as shown below.

   //  EXEC NASTRAN
   //NS.CARDS DD    DSN=USER.JOB1EXEC.DATA,DISP=SHR
   //NS.SYSIN DD    *
   ID ....
    .
    .
    .
   READFILE CARDS
   /*

An ENDDATA card is not used in the Bulk Data Deck here as it is assumed to be
included in the data on the sequential file.

#### Example 4

   In this example, the READFILE capability is used to read a member of a PDS
on the IBM version. The format for reading a member of a PDS is to include the
DDname of the PDS with the member name in parentheses immediately following it
as shown below.

   //  EXEC NASTRAN
   //NS.CARDS DD    DSN=USER.PDS.DATA,DISP=SHR
   //NS.SYSIN DD    *
   ID ....
    .
    .
    .
   READFILE CARDS(JOB2EXEC)
    .
    .
    .
   /*

The member JOB2EXEC is read from the PDS USER.PDS.DATA.

#### Example 5

   In this example, a file name on the UNIVAC is referenced by a READFILE
card, and the input cards are not to be printed.

   @ASG,A CARDS*UN1EXEC.
   @XQT   *NASTRAN.L1NK1
   ID ....
   READFILE(NOPRINT)CARDS*UN1EXEC.
    .
    .
    .

The file UN1EXEC with the qualifier CARDS will be read immediately after the
ID card.

#### Example 6

   In this example, a file.element name on the UNIVAC is referenced by a
READFILE card.

   @ASG,A CARDS*UN2.
   @XQT *NASTRAN.L1NK1
   ID ....
   READFILE CARDS*UN2.EXEC
    .
    .
    .

The element EXEC of file UN2 with the qualifier CARDS is read immediately
after the ID card.

# 2.1  THE NASTRAN CARD

    Many of the important operational parameters used in NASTRAN, such as the
buffer size and the machine configuration, are contained in the /SYSTEM/
COMMON block. These and other operational parameters are initially assigned
values by the program. However, the program does provide a means by which the
default values initially set for some of these operational parameters can be
redefined by you at execution time. The card that provides this capability is
called the NASTRAN card.

    The NASTRAN card is optional, but, if used, it must be the first card of
the NASTRAN data deck; that is, it must precede the Executive Control Deck.
The NASTRAN card is a free-field card (similar to the cards in the Executive
and Case Control Decks). The format of the card is as follows:

    NASTRAN keyword1 = value,  keyword2 = value, ...

The list of applicable and acceptable keywords is as follows:

    1.  BANDIT - Changes the 77th word in /SYSTEM/. This parameter specifies
	whether the BANDIT operations in NASTRAN are to be performed or not. If
	BANDIT = 0 (the default), the BANDIT operations are performed if there
	are no input data errors. If BANDIT = -1, the BANDIT operations are
	skipped unconditionally.

    2.  BANDTCRI - Manipulates the 77th word in /SYSTEM/. This parameter
	specifies the criterion for evaluation in the BANDIT operations.
	Acceptable values and their meanings are shown below. (See Reference 1
	for the definitions of the terms used here.)

	BANDTCRI value            Criterion for evaluation (characteristic of 
				  matrix selected for reduction) 

	   1 (default)            RMS (root mean square) wavefront
	   2                      Bandwidth
	   3                      Profile
	   4                      Maximum wavefront

    3.  BANDTDEP - Manipulates the 77th word in /SYSTEM/. This parameter is
	meaningful only when the BANDTMPC parameter is set to 1 or 2. It
	indicates whether the dependent grid points specified by multipoint
	constraints (MPCs) and/or rigid elements are to be included (BANDTDEP =
	0, the default) or are to be excluded (BANDTDEP = 1) from consideration
	in the BANDIT computations.

    4.  BANDTDIM - Manipulates the 77th word in /SYSTEM/. This parameter defines
	the dimension (in number of words) of a scratch array used in the BANDIT
	computations with the GPS method. Any one of the integers 1 to 9 may be
	specified, resulting in a dimension of words for the scratch array equal
	to m*10 percent of the total number of grid points used in the problem
	(where m = the value specified for this parameter). The default of m is
	1, or 150 words, whichever gives the larger number.

    5.  BANDTMPC - Manipulates the 77th word in /SYSTEM/. This parameter
	indicates whether multipoint constraints (MPCs) and/or rigid elements
	are to be considered in the BANDIT computations. Acceptable values and
	their meanings are shown below.

	BANDTMPC value            Meaning

	   0 (default)            Do not consider MPCs or rigid elements in 
				  the BANDIT computations. 

	   1                      Consider only rigid elements in the BANDIT
				  computations.

	   2                      Consider both MPCs and rigid elements in the 
				  BANDIT computations. 

	As noted in Reference 1, it should be emphasized here that only in rare
	cases would it make sense to let BANDIT process MPCs and rigid elements.
	The main reasons for this are that the BANDIT computations do not
	consider individual degrees of freedom and, in addition, cannot
	distinguish one MPC set from another.

    6.  BANDTMTH - Manipulates the 77th word in /SYSTEM/. This parameter
	specifies the method to be used by the BANDIT operations for the
	resequencing of grid points. (See Reference 1 for details of these
	methods.) Acceptable values and their meanings are shown below.

	BANDTMTH value            Method(s) to be used in the BANDIT operations

	   1                      Cuthill-McKee method
	   2                      Cuthill-McKee method and Gibbs-Poole-
				  Stockmeyer method 
	   3 (default)            Gibbs-Poole-Stockmeyer method

    7.  BANDTPCH - Manipulates the 77th word in /SYSTEM/. This parameter
	specifies the punching of the SEQGP cards generated by the BANDIT
	procedure. Acceptable values and their meanings are given below.

	BANDTPCH value            Meaning

	   0 (default)            Do not punch the SEQGP cards generated by 
				  BANDIT and let the NASTRAN job continue 
				  normally. 

	   1                      Punch out the SEQGP cards generated by 
				  BANDIT and terminate the NASTRAN job. 

    8.  BANDTRUN - Manipulates the 77th word in /SYSTEM/. This parameter
	specifies the conditions under which the BANDIT operations in NASTRAN
	are to be performed. A value of 0 (the default) indicates that the
	BANDIT computations are to be performed if there are no input data
	errors and you have not already included one or more SEQGP cards in the
	Bulk Data Deck. A value of 1 specifies that the BANDIT operations are to
	be performed if there are no input data errors and new SEQGP cards are
	to be generated unconditionally to replace any old SEQGP cards that may
	have been initially included in your input.

    9.  BUFFSIZE - Changes the first word in /SYSTEM/. This word defines the
	number of words in a GINO (general purpose input/output routines used in
	NASTRAN) buffer. The default values are as follows:

	Machine           GINO Buffer Size (words)

	CDC               1042
	IBM               1604
	UNIVAC            871
	DEC VAX           1408

	The desired value at a particular installation may be different from the
	default value. In any event, related runs such as restarts must use the
	same BUFFSIZE for all parts of the run.

    10.    BULKDATA - Changes the 77th word in /SYSTEM/. This parameter
	   specifies whether NASTRAN is to run normally (BULKDATA = 0, the
	   default) or if NASTRAN is to terminate after the Preface (or Link 1)
	   operations (BULKDATA not equal to 0).

	   BULKDATA = -3 (a special option) indicates the NASTRAN 15 GINO timing
	   constants are to be calculated, printed, and the NASTRAN job
	   terminated.

	   Important note about the BANDIT, BANDTxxx, and BULKDATA Parameters

	   Note that the BANDIT parameter, the BANDTxxx parameters (as a group)
	   and the BULKDATA parameter all correspond to the same word (the 77th
	   word) in the /SYSTEM/ COMMON block. Hence, these parameters are
	   mutually exclusive. That is, you can specify either the BANDIT
	   parameter, any one or more of the BANDTxxx parameters, or the
	   BULKDATA parameter, but you cannot specify more than one of these
	   three parameters.

    11.    CONFIG - This keyword is no longer applicable. The constants required
	   for use in the timing equations are now automatically computed in
	   every NASTRAN run.

    12.    DRUM - Changes the 34th word in /SYSTEM/. This word defines the drum
	   allocation of dynamic assigns on the UNIVAC version. The default is
	   DRUM = 1. This causes dynamic assigns for all units not assigned by
	   you to be of the following form:

	   @ASG,T XX,F/2/POS/30.

	   This assign card allows a maximum of 1,920 tracks, or approximately
	   3,500,000 words for each file. The F refers to a mass storage device.
	   POS requests that 64 contiguous tracks be assigned at once. The value
	   30 causes the run to be terminated if more than 30 x 64 tracks of
	   data are written on any one file.

	   The drum allocation of dynamic assigns can be changed from POS
	   (positions) to TRK (tracks) by setting DRUM = 2. This results in
	   files being assigned in the following form:

	       @ASG,T XX,F//TRK/1360.

	   TRK requests that 64 sectors (28 words/sector) be assigned at one
	   time.

    13.    FILES - Establishes the specified NASTRAN files as executive files.
	   The files that may be specified are POOL, NPTP, OPTP, NUMF, PLT1,
	   PLT2, INPT, INP1, INP2,...INP9. Multiple file names must be specified
	   by enclosing them in parentheses, such as FILES = (PLT1, NPTP). If an
	   executive file is assigned to tape rather than disk, then it need not
	   be specified with the FILES parameter. The FILES parameter, if used,
	   must be the last keyword on the NASTRAN card.

    14.    HICORE - Changes the 31st word in /SYSTEM/. This word defines the
	   amount of core (in decimal words) available to you on the UNIVAC 1100
	   series machines. The default is 85K decimal words. The ability to
	   increase this value may be installation limited.

    15.    LOGFL - Changes the 7th word in /SYSTEM/. Default is 95 (UNIVAC
	   only).

    16.    MAXFILES - Changes the 29th word in /SYSTEM/. This word defines the
	   maximum number of files to be placed in COMMON /XFIAT/ by subroutine
	   GNFIAT. The default value is 35.

    17.    MAXOPEN - Changes the 30th word in /SYSTEM/. This word defines the
	   maximum number of files that may be open at any one time in the
	   program. The default value is 16.

    18.    MODCOM(I) - Changes the (56 + I)th word (1 <= I < 9) in /SYSTEM/.
	   Defines one of the words in a nine-word array. Only MODCOM(1) is
	   supported. If MODCOM(1) = 1, diagnostic statistics from subroutine
	   SDCOMP are printed. The default is MODCOM(1) = 0, resulting in no
	   diagnostic prints from SDCOMP.

    19.    NLINES - Changes the 9th word in /SYSTEM/. This word defines the
	   number of data lines per printed page. The smallest acceptable value
	   is 10. The default value is 42 for the CDC version, 55 for the IBM
	   version, 55 for the DEC VAX version, and 55 for the UNIVAC version.
	   Alternatively, the number of data lines per printed page can also be
	   defined by means of the LINE card in the Case Control Deck (see
	   Section 2.3).

    20.    PLOTOPT - Defines the action to be taken by NASTRAN in the case where
	   plots are requested and error(s) exists in the Bulk Data Deck. The
	   default is zero (PLOTOPT = 0) if the PLT2 file is not assigned in a
	   NASTRAN job and one (PLOTOPT = 1) if the PLT2 file has been assigned.
	   The plot options (0 through 5) are listed below:

	   PLOTOPT     BULK DATA     PLOT COMMANDS    NASTRAN ACTION

	       0       no error      no error         executes all links, no 
						      plots 
		       no error      error            stops after link1 data 
						      check 
		       error         err or no err    stops after link1 data 
						      check 

	       1       no error      no error         executes all links, and 
						      plots 
		       no error      error            stops after link1 data 
						      check 
		       error         err or no err    stops after link1 data 
						      check 

	       2       err/no err    no error         stops after undef. plots 
						      in link2 
		       err/no err    error            stops after link1 data 
						      check 

	       3       err/no err    err or no err    attempts to plot; stops 
						      in link2 

	       4       no error      no error         executes all links, and 
						      plots 
		       no error      error            attempts to plot; stops 
						      in link2 
		       error         no error         stops after undef. plots 
						      in link2 
		       error         error            stops after link1 data 
						      check 

	       5       no error      no error         executes all links, and 
						      plots 
		       no error      error            executes all links, but 
						      no plots 
		       error         no error         stops after undef. plots 
						      in link2 
		       error         error            stops after link1 data 
						      check 

    21.    STST - Changes the 70th word in /SYSTEM/. This word defines the
	   singularity tolerance for use in the EMA module. The default value is
	   0.01. The singularities remaining are written onto the GPST data
	   block output from the EMA module.

    22.    SYSTEM(J) - Changes the Jth word (1 <= J <= 100) in /SYSTEM/. This is
	   the general form of defining any word in /SYSTEM/. For some values of
	   J, SYSTEM(J) has equivalent keywords. For instance, SYSTEM(1) and
	   BUFFSIZE are equivalent and SYSTEM(9) and NLINES are equivalent. The
	   contents of /SYSTEM/ are described fully in Section 2.4.1.8 of the
	   Programmer's Manual.

    23.    TITLEOPT - Defines the option for obtaining the title page in the
	   NASTRAN output. The values of this keyword and their meaning are as
	   follows:

	   TITLEOPT       Meaning

	       <0         Print a short title page.

	       0          Do not print any title page.

	       1          Print one copy of the full title page.

	       2 (default) Print two copies of the full title page.

	       3          Print a one-line comment (which you can modify by 
			  updating subroutine TTLPGE) followed by the short 
			  title items on the same page. 

	       4          Read another card immediately following the NASTRAN 
			  card, print its contents on one line and follow it 
			  by the short title items on the same page. 

	       >4         Do not print any title page (same as TITLEOPT = 0).

	       -2         (UNIVAC only) Print a short title page and suppress 
			  the alternate logfile assignment which is not 
			  allowed in real-time environment. 

	   As can be seen, when TITLEOPT = 4 is specified on the NASTRAN card,
	   you must supply another card immediately following the NASTRAN card
	   to be read by the program. You can therefore use this feature to
	   print one-line individual comments (along with the short title) for
	   individual runs.

Examples

    Following are some examples of the use of the NASTRAN card.

#### Example 1

NASTRAN BUFFSIZE = 900

The above card changes the 1st word of /SYSTEM/.

#### Example 2

NASTRAN NLINES = 40

The above card changes the 9th word of /SYSTEM/.

#### Example 3

NASTRAN TITLEOPT = -1, FILES = (PLT1, NPTP)

The above card requests a short title page and establishes the PLT1 and NPTP
files as executive files.

#### Example 4

NASTRAN SYSTEM(14) = 30000, SYSTEM(79) = 16384

The above card changes the 14th and 79th words in /SYSTEM/. SYSTEM(14) = 30000
changes the maximum number of output lines from 20000 (default) to 30000. (See
the description of the MAXLINES card in Section 2.3.) SYSTEM(79) = 16384 turns
on DIAG 5 thereby requesting the tracing of GINO OPEN/CLOSE operations. (See
the description of the DIAG card in Section 2.2.)

#### Example 5

NASTRAN BANDTPCH = 1, BANDTRUN = 1

The above card requests the punching of the new SEQGP cards unconditionally
generated by the BANDIT procedure and the subsequent termination of the
NASTRAN job.

#### Example 6

NASTRAN BANDIT = -1

The above card requests the unconditional skipping of the BANDIT operations.

#### Example 7

NASTRAN SYSTEM(93) = 1

The above card requests that sweep aerodynamic effects are to be included In
the modal flutter analysis of an axial-flow turbomachine or an advanced
turbopropeller. (See Section 1.20.)

REFERENCE

1.  Everstine, G. C., BANDIT User's Guide, COSMIC Program No. DOD-00033, May
    1978.


# 2.2  EXECUTIVE CONTROL DECK
## 2.2.1  Control Selection

   The format of the Executive Control cards is free field. The name of the
operation (for example, CHKPNT) is separated from the operand by one or more
blanks. The fields in the operand are separated by commas, and may be up to 8
integers or alphanumeric as indicated in the control card descriptions. The
first character of an alphanumeric field must be alphabetic, followed by up to
7 additional alphanumeric characters. Blank characters may be placed adjacent
to separating commas if desired. The individual cards are described in Section
2.3.3 and examples follow in Section 2.2.2.

   The following Executive Control cards are mandatory:

   1. APP - selects a Rigid Format approach or a user provided Direct Matrix
      Abstraction Program (DMAP).

   2. CEND - defines the end of the Executive Control deck.

   3. ID - defines the beginning of the Executive Control deck.

   4. TIME - defines the maximum time in minutes allotted to the execution of
      the NASTRAN program.

   The following Executive Control cards are required under certain
circumstances:

   1. BEGIN$ - defines the beginning of user provided DMAP statements.

   2. END$ - defines the end of user provided DMAP statements.

   3. ENDALTER - defines the end of user provided changes to a Rigid Format.

   4. RESTART - defines the beginning of a restart dictionary.

   5. SOL - selects the solution number of a Rigid Format.

   6. UMF - selects a data deck from a User Master File.

   7. UMFEDIT - controls execution as a UMF editor.

   The following Executive Control cards are optional:

   1. ALTER - defines the Rigid Format statement(s) at which you make
      alterations.

   2. CHKPNT - requests the execution to be checkpointed.

   3. DIAG - requests diagnostic output to be provided or operations to be
      effected.

   4. NUMF - requests a User Master File to be created.

   5. $ - defines a non-executable comment.

## 2.2.2  Executive Control Deck Examples

1. Cold start, no checkpoint, rigid format, diagnostic output.

   ID          MYNAME, BRIDGE23
   APP         DISPLACEMENT
   SOL         2,0
   TIME        5
   DIAG        1,2
   CEND

2. Cold start, checkpoint, rigid format.

   ID          PERSONZZ, SPACECFT
   CHKPNT      YES
   APP         DISPLACEMENT
   SOL         1,3
   TIME        15
   CEND

3. Restart, no checkpoint, rigid format. The restart dictionary indicated by
the double line bracket is automatically punched on previous run in which the
CHKPNT option was selected by you.

     ID JOESHMOE, PROJECTX
   �
   � RESTART  PERSONZZ, SPACECFT, 05/13/67, 18936,
   �      1, XVPS, FLAGS=0, REEL=l, FILE=6
   �      2, REENTER AT DMAP SEQUENCE NUMBER 7
   �      3, GPL, FLAGS=0, REEL=1, FILE=7
   �                  .
   �                  .
   �                  .
   �  $ END OF CHECKPOINT DICTIONARY
   �
      APP         DISPLACEMENT
      SOL         3,3
      TIME        10
      CEND

4. Cold start, no checkpoint, DMAP. User-written DMAP program is indicated by
double line brackets.

     ID          IAM007, TRYIT
     APP         DMAP
     BEGIN $
   �                         �
   � DMAP statements go here �
   �                         �
     END $
     TIME       8
     CEND

5. Restart, checkpoint, altered rigid format, diagnostic output.

   ID BEAM, FIXED
   RESTART BEAM, FREE, 05/09/68, 77400,
	1, XVPS, FLAGS=0, REEL=1, FILE=6
	2, REENTER AT DMAP SEQUENCE NUMBER 7
	3, GPL, FLAGS=0, REEL=1, FILE=7
	      .
	      .
	      .
   $ END OF CHECKPOINT DICTIONARY
   CHKPNT      YES
   DIAG        2,4
   APP         DISPLACEMENT
   SOL         3,3
   TIME        15
   ALTER       20 $
   MATPRN      KGGX,,,,// $
   TABPT       GPST,,,,// $
   ENDALTER
   CEND

## 2.2.3  Executive Control Card Descriptions

   The format of the Executive Control cards is free-field. In presenting
general formats for each card embodying all options, the following conventions
are used:

1. Upper-case letters and parentheses must be punched as shown.

2. Lower-case letters indicate that a substitution must be made.

		   � �
3. Double brackets � � indicate that a choice of contents is mandatory.
		   � �
	    � �
4. Brackets � � contain an option that may be omitted or included by you.
	    � �

5. First listed options or values are the default values.

6. Physical card consists of information punched in columns 1 through 72 of a
   card. Most Executive Control cards are limited to a single physical
   card.

7. Logical card may have more than 72 columns with the use of continuation
   cards. A continuation card is honored by ending the preceding card with
   a comma.

ALTER - DMAP Sequence Alteration Request

Description

Requests Direct Matrix Abstraction Program (DMAP) sequence of a Rigid Format
to be changed by additions, deletions, or substitutions.

Format and Example(s)

      �        �
ALTER �K1 [,K2]� $
      �        �

ALTER 22 $

ALTER 5,5 $

ALTER 38,45 $

ALTER 25,19 $

Option     Meaning

K1 only    DMAP statement number (Integer > 0) after which DMAP instructions
	   following the ALTER card to be inserted.

K1 and K2  DMAP statement numbers (Integer > 0) identifying a single DMAP
	   statement or a range of DMAP statements to be deleted and replaced  
	   by any DMAP instructions that may follow the ALTER card.  See remark
	   5.

Remarks

1. See the descriptions of the INSERT and DELETE cards for alternateways of 
   specifying DMAP sequence alteration requests.

2. The DMAP statements referenced on ALTER, INSERT and DELETE cards (either 
   explicitly or implicitly, when a range is specified) must be referenced in 
   ascending order of their occurrence in the rigid format DMAP.

3. See Volume 2, Sections 2, 3 and 4 for the listings of all rigid format DMAP
   sequences.

4. See Volume 2, Section 1.1.5 for the manner in which DMAP alters are handled
   restarts.

5. If both K1 and K2 are specified and K1 is not equal to K2, a range of DMAP
   statements is implied and either of them can be less than the other.  If 
   K1 = K2, a single DMAP statement is implied.

APP - Rigid Format or DMAP Declaration

Description

Selects a Rigid Format approach or a user provided Direct Matrix Abstraction
Program (DMAP).

Format and Example(s)

     �                    �
     � DISPLACEMENT       �   (Default)
     � DISPLACEMENT, SUBS �
APP  � HEAT               �
     � AERO               �
     � DMAP               �
     � DMAP, SUBS         �
     �                    �

APP HEAT

APP DMAP

Option     Meaning

DISPLACEMENT  Indicates one of the Displacement Approach rigid formats.

DISPLACEMENT, SUBS  Indicates automated multi-stage substructuring with one of
	   the Displacement Approach rigid formats.

HEAT       Indicates one of the heat transfer approach rigid formats.

AERO       Indicates one of the aeroelastic approach rigid formats.

DMAP       Indicates Direct Matrix Abstraction Program (DMAP) approach.

DMAP, SUBS Indicates Direct Matrix Abstraction Program (DMAP) approach which
	   includes automated multi-stage substructuring modules.

Remarks

1. Use of this card is recommended. Default is DISPLACEMENT.

BEGIN - DMAP Sequence Initiation

Description

Defines the beginning of a Direct Matrix Abstraction Program (DMAP) sequence.

Format and Example(s)

BEGIN $

BEGIN OPTIONAL NAME OF DMAP SEQUENCE $

Remarks

1. This card is required at the beginning of a DMAP sequence. It must be the
   first card. The statement is included at the beginning of the DMAP sequence
   defining a Rigid Format. You must provide the card as part of a user
   supplied DMAP sequence when using the DMAP approach.

2. This statement, like all DMAP statements, is terminated with the $
   character delimiter.

3. This statement is a non-executable instruction for the DMAP compiler. (See
   Section 5.7 for an alternate module XDMAP.)

4. For specific instructions related to DMAP usage, see Section 5.2.

CEND - Executive Control Deck Terminator

Description

Defines the end of the Executive Control Deck.

Format and Example(s)

CEND

Remarks

1. This card is mandatory and must be last in the Executive Control Deck.

CHKPNT - Checkpoint File Request

Description

Requests data blocks to be written to a checkpoint file for a later restart.

Format and Example(s)

       �     �
       � NO  �
CHKPNT � YES �
       �     �

CHKPNT YES

Remarks

1. This card is optional but when it is used, the checkpoint file must be made
   available by you via operating system control cards.

2. The restart dictionary deck is automatically punched for use in a later
   restart execution.

DELETE - DMAP SEQUENCE ALTERATION REQUEST

Description

Requests the Direct Matrix Abstraction Program (DMAP) sequence of a rigid 
format to be changed by deletions or substitutions.


Format and Example(s)

DELETE specmod  [ , specmod  ] $
	      1            2

    where specmod  has the following general form:
		 i

	    nommod  [ ( r  ) ] [ , n  ]
		  i      i          i

DELETE SSG1 $

DELETE EMA(2) $

DELETE READ,1 $

DELETE SDR2(2),-1 $

DELETE SSG3,REPT $

DELETE GP2,GP3,-1 $

DELETE SMA3,1,TA1,-1 $

DELETE REPT,2,REPT,3 $


Option

nommod          Nominal module (Alphanumeric value, no default). See Remark 5.
      i

.                                                                 th
r               Occurrence flag (Integer > 0, default = 1).  The r
 i                                                                i
		occurrence of the nominal module in the rigid format DMAP
		sequence (counting from the beginning of the DMAP sequence)
		defines the reference module.  See Remark 6.

n               Offset flag (Integer, default = 0).  The DMAP module that is 
 i
		offset from the reference module by n  DMAP statements in the
.                                                    i
		rigid format DMAP sequence defines the specified module.  See
		Remark 7.

specmod  only   Specified module defined as per the above scheme that is to be 
       1
		deleted and replaced by any DMAP instructions that may follow
		the DELETE card.

specmod  and    Range of specified modules defined as per the above scheme 
       1
specmod         that are to be deleted and replaced by any DMAP instructions 
       2
		that may follow the DELETE card.  See Remark 8.


Remarks

1. See the description of the ALTER card for an alternate way of specifying 
   DMAP sequence deletions and substitutions.

2. The DMAP statements referenced on ALTER, INSERT and DELETE cards (either 
   explicitly or implicitly, when a range is specified) must be referenced in 
   ascending order of their occurrence in the rigid format DMAP.

3. See Volume 2, Sections 2, 3 and 4 for the listings of all rigid format DMAP 
   sequences.

4. See Volume 2, Section 1.1.5 for the manner in which DMAP alters are handled 
   in restarts.

5. The nominal module nommod  must be a valid name of a DMAP module in the 
			    i
   rigid format DMAP sequence.

6. The default value of 1 for the occurrence flag r  implies that the 
.                                                  i
   reference module is the first occurrence of the nominal module in the rigid 
   format DMAP sequence.

7. The value of the offset flag n  may be positive, negative or 0.  A positive 
				 i
   value means that the specified module follows the reference module by n  
.                                                                         i
   DMAP statements in the rigid format DMAP sequence.  A negative value 
   indicates that the specified module precedes the reference module by n  
.                                                                        i
   DMAP statements in the DMAP sequence.  A value of 0 (the default) implies 
   that the reference module is the specified module.

8. If both specmod  and specmod  are specified, it implies a range of DMAP 
		  1            2
   statements and either of them can precede the other in the rigid format 
   DMAP sequence.

DIAG - Diagnostic Output and Operation Request

Description

Requests additional information to be printed out or requests executive
operations to be performed.

Format and Example(s)

     �   �   � �  � �
DIAG � n � , �-� L� �
     �   �   � �  � �

DIAG 14

DIAG 8,11,13,-6,-11

Option     Meaning

n          Type of diagnostic requested (Integer > 0). Allowable values and
	   their meanings are given in the following table. See Remarks 1 and
	   2.

L          Link number in which specified types of diagnostics are requested
	   (1 <= Integer <= 15). See Remarks 2 and 7.

-L         See Remark 7 below.

	   n     Diagnostic

	   1     Dump memory when fatal message is generated.

	   2     Print File Allocation Table (FIAT) following each call to
		 the File Allocator.

	   3     Print status of the Data Pool Dictionary (DPD) following
		 each call to the Data Pool Housekeeper.

	   4     Print the Operation Sequence Control Array (OSCAR). See
		 Remarks 3 and 7.

	   5     Print BEGIN time on-line for each functional module.

	   6     Print END time on-line for each functional module.

	   7     Print eigenvalue extraction diagnostics for real and complex
		 determinant methods.

	   8     Print matrix and table data block trailers as they are
		 generated.

	   9     Suppress echo of checkpoint dictionary. See Remark 7.

	   10    Use alternate nonlinear loading in TRD. Replace N(n+1) by
		 1/3 (N(n+1) + N(n) + N(n-1)). See Section 11.4 of the
		 Theoretical Manual.

	   11    Print all active row and column possibilities for
		 decomposition algorithms.

	   12    Print eigenvalue extraction diagnostics for complex inverse
		 power or FEER methods.

	   13    Print open core length.

	   14*   Print the DMAP sequence that is compiled (NASTRAN SOURCE
		 PROGRAM COMPILATION). See Remarks 3, 4, 5, and 7.

	   15    Trace GINO OPEN/CLOSE operations.

	   16    Trace real inverse power eigenvalue extraction operations or
		 eigensolution diagnostics for FEER tridiagonalization.

	   17*   Punch the DMAP sequence that is compiled. See Remarks 3, 6,
		 and 7.

	   18    Trace Heat Transfer iterations (APP HEAT) or print grid
		 point ID conversions from SET2 card (APP AERO).

	   19    Print data for MPYAD method selection.

	   20    Generate debug printout (for NASTRAN programmers who include
		 CALL BUG in their subroutines) or set job termination flag.
		 See Remark 6.

	   21*   Print a list of degrees of freedom. For each degree of
		 freedom, the displacement sets to which it belongs are
		 identified. See Remark 6.

	   22*   Print the contents of various displacement sets. For each
		 set, a list of degrees of freedom belonging to that set is
		 given. See Remark 6.

	   23    Print the DMAP ALTERs generated during Automated Multi-stage
		 Substructuring. See Remark 7.

	   24*   Punch the DMAP ALTERs generated during Automated Multi-stage
		 Substructuring. See Remarks 6 and 7.

	   25*   Print a cross reference listing of the DMAP program that is
		 compiled. See Remarks 3, 4, 6, and 7.

	   26    Do not limit eigensolutions to number requested on the EIGR
		 bulk data card (for real inverse power and FEER methods
		 only), and revert plot FIND default to APR 1984 version.

	   27    Dump the Input File Processor (IFP) table.

	   28*   Punch the FORTRAN code for the link specification table
		 (subroutine XLNKDD). See Remarks 6, 7, and 8.

	   29    Process the link specification table update deck. See
		 Remarks 7 and 8.

	   30*   Punch FORTRAN alters to the XSEMi decks (i set via DIAG
		 1-15). See Remarks 6, 7, and 8.

	   31    Print the link specification table and the module properties
		 list data. See Remarks 7 and 8.

	   32    Print a list of degrees of freedom (including fluid point
		 definitions). For each degree of freedom, the displacements
		 sets to which it belongs are identified.

	   33    Print the contents of various displacement sets. For each
		 set, a list of degrees of freedom (including fluid point
		 definitions) belonging to that set is given.

	   34    Skip property ID, material ID, and coordinate ID cross
		 reference checking in the Preface of Link 1.

	   35    Print machine hardware timing constants. (See NASTRAN
		 BULKDATA = -3 option.)

	   36*   Print internal and SIL (Scalar Index List) numbers for grid
		 and scalar points vs. their external numbers. See Remark 6.

	   37    Suppress eigenvalue lower roots message (for real inverse
		 power and FEER methods only).

	   38    Print element processing information during element matrix
		 generation phase.

	   39    Print trace of eigenvalues for the PK method in flutter
		 analysis.

	   40    Turn on diagnostic when layer composite material is used in
		 PCOMP or PCOMPi cards.

	   41    Reserved for future use.

	   42    Invoke NASTRAN former input card processors, XSORT and
		 RCARD, to process bulk data cards. (Much slower processors.)

	   43    Use FEER method from previous 1994 Release.

	   44    Use Symmetric Decomposition from previous 1994 Release.

	   45    Request diagnostic information in LOG file for Symmetric
		 Decomposition installed in 1995 Release.

	   46    Use Forward/Backward Substitution from previous 1994 Release.

	   47    Request diagnostic information in LOG file for Forward/
		 Backward Substitution installed in 1995 Release.

	   48*   Print NASTRAN release news and the DIAG table. See Remark 6.

	   49    Use Matrix Multiply/Add methods from previous 1994 Release.

	   50    Eliminate the use of the Vector Facility (IBM MVS only)

Remarks

1. One or more diagnostics may be chosen from the above table.

2. Multiple options may be selected by using multiple integers separated by
   commas or by using multiple DIAG cards.

3. See the description of the XDMAP card in Section 5.7 for alternate means of
   controlling the DMAP compiler options.

4. DIAG 14 is automatically turned on when DIAG 25 is requested.

5. The DMAP compiler default is set to LIST for restart runs and for runs
   using the DMAP approach (APP DMAP) or the substructure capability (APP
   DISP,SUBS). The default is also set to LIST when the REF option on the
   XDMAP card is specified. The default is set to NOLIST for all other cases.
   (See the description of the XDMAP card in Section 5.7.) There is,
   therefore, no need to use the DIAG 14 option in the former cases where LIST
   is the default; instead, the NOLIST option on the XDMAP card can be used in
   these cases to suppress the automatic listing of the compiled DMAP program.

6. Use of any one or more of DIAGs 17, 21, 22, 24, 25, 28, 30, 36 and 48,
   (marked by *) in conjunction with DIAG 20, will result in job termination.

7. Use of DIAGs of the form

   DIAG -L, n1, n2, n3

   will cause the specified n1, n2, and n3 DIAGs to be turned on only in Link
   L (L = 1, 2, ..., 15). (DIAGs 4, 9, 14, 17, 23-25, and 28-31 are valid and
   meaningful only in the Preface (Link 1) and are not affected by this
   usage.)

   Thus, for example, the use of

   DIAG 4, 8, 15, -2, -11

   will cause DIAG 4 to be turned on normally (for use in Link 1), and DIAGs 8
   and 15 to be turned on only in Links 2 and 11.

   Similarly, the use of

   DIAG -1, 2, 8, -6

   will cause DIAGs 2 and 8 to be turned on only in Links 1 and 6.

8. Refer to Section 6.11.3 of the Programmer's Manual for the description and
   usage of DIAGs 28 through 31.

END - DMAP Sequence Terminator

Description

Defines the end of a Direct Matrix Abstraction Program (DMAP) sequence.

Format and Example(s)

END$

Remarks

1. This card is required at the end of a DMAP sequence. It must be the last
   card. The statement is included at the end of the DMAP sequence defining a
   Rigid Format. You must provide the card as part of a user supplied DMAP
   sequence when using the DMAP approach.

2. This statement, like all DMAP statements, is terminated with the $
   character delimiter.

3. For specific instructions related to DMAP usage, see Section 5.2.

4. The END $ statement cannot be altered into a Rigid Format at intermediate
   steps. To schedule an early termination, use either the EXIT $ statement or
   the JUMP, FINIS $ statement.

ENDALTER - Rigid Format DMAP Alter Terminator

Description

Defines the end of a user supplied alter to a Rigid Format Direct Matrix
Abstraction Program (DMAP) sequence.

Format and Example(s)

ENDALTER

Remarks

1. This card is required when an alter to a Rigid Format DMAP sequence is
   supplied.

2. The card is required only once but must be the last card for all alters.

3. For specific instructions related to DMAP usage, see Section 5.2.

ID - Job Identification

Description

Provides an alphanumeric identification of the job and establishes the
beginning of the Executive Control Deck.

Format and Example(s)

    �     �
ID  �A1,A2�
    �     �

ID   A1234567,B7654321

Option     Meaning

A1         Any alphanumeric field chosen by you for identification.

A2         Any alphanumeric field chosen by you for identification.

Remarks

1. This card is mandatory and must be first in the Executive Control Deck.

2. The ID used during a checkpoint is automatically written to the checkpoint
   file and is placed on the restart card.

3. The first character of each field must be alphabetic and may be followed by
   up to seven alphanumeric characters.

INSERT - DMAP SEQUENCE ALTERATION REQUEST

Description

Requests the Direct Matrix Abstraction Program (DMAP) sequence of a rigid 
format to be changed by additions.


Format and Example(s)

INSERT specmod $

	where specmod has the following general form:

		nommod [ ( r ) ] [ , n ]

INSERT GP4 $

INSERT EMA(2) $

INSERT READ,1 $

INSERT SDR2(2),-1 $


Option

nommod          Nominal module (Alphanumeric value, no default). See Remark 5.

.                                                                 th
r               Occurrence flag (Integer > 0, default = 1).  The r   
		occurrence of the nominal module in the rigid format DMAP
		sequence (counting from the beginning of the DMAP sequence)
		defines the reference module.  See Remark 6.

n               Offset flag (Integer, default = 0).  The DMAP module that is 
		offset from the reference module by n DMAP statements in the
		rigid format DMAP sequence defines the specified module.  See
		Remark 7.

specmod         Specified module defined as per the above scheme after which 
		DMAP statements following the INSERT card are to be inserted.


Remarks

1. See the description of the ALTER card for an alternate way of specifying 
   DMAP sequence additions.

2. The DMAP statements referenced on ALTER, INSERT and DELETE cards (either 
   explicitly or implicitly, when a range is specified) must be referenced in 
   ascending order of their occurrence in the rigid format DMAP.

3. See Volume 2, Sections 2, 3 and 4 for the listings of all rigid format DMAP 
   sequences.

4. See Volume 2, Section 1.1.5 for the manner in which DMAP alters are handled 
   in restarts.

5. The nominal module nommod must be a valid name of a DMAP module in the 
   rigid format DMAP sequence.

6. The default value of 1 for the occurrence flag r implies that the reference 
   module is the first occurrence of the nominal module in the rigid format 
   DMAP sequence.

7. The value of the offset flag n may be positive, negative or 0.  A positive 
   value means that the specified module follows the reference module by n 
   DMAP statements in the rigid format DMAP sequence.  A negative value 
   indicates that the specified module precedes the reference module by n DMAP 
   statements in the DMAP sequence.  A value of 0 (the default) implies that 
   the reference module is the specified module.

NUMF - New User Master File Declaration

Description

Defines a bulk data deck to be placed on a User Master File.

Format and Example(s)

     �        �
NUMF �tid, pid�
     �        �

NUMF 20012,6

NUMF 150,0

Option     Meaning

tid        User specified tape identification number assigned during the
	   creation of a User's Master File.

pid        User specified problem identification number assigned during the
	   creation of a User's Master File.

Remarks

1. This card is required when the UMF Editor is in the write mode.

2. For specific instructions related to the UMF, see Section 2.5.

3. A DIAG 42 card is needed for UMF operation.

READFILE - Directive to Read Input Cards

Description

Defines a file that contains the input cards.

Format and Example(s)

	  ��         Ŀ
	  �           �
	  � ,NOPRINT, �
READFILE  � ,NOPRINT  �  [ = ]  filename
	  � (NOPRINT) �
	  ��         ��

READFILE  ABC
READFILE  NOPRINT  ABC
READFILE, NOPRINT  ABC
READFILE, NOPRINT, ABC
READFILE (NOPRINT) ABC
READFILE  = ABC
READFILE  NOPRINT  = ABC
READFILE, NOPRINT  = ABC
READFILE (NOPRINT) = ABC

Remarks

1. This card can be used in Executive, Case Control, and Bulk Data Decks.

2. Input cards are saved in the file named filename.

3. Comma, equal sign, and parentheses are not allowed in filename.

4. NOPRINT allows reading in the input cards, such as the DMAP alters or
   restart dictionary, without printing them out. The default is to print
   them.

5. Since this card can also be used in the Case Control Deck, an equal sign is
   also allowed.

6. Nested READFILE is allowed.

7. See Sections 2.0.2.1 and 2.0.2.2 for more information.

RESTART - Restart Dictionary Initiator

Description

Defines the beginning of a restart dictionary deck when reading data blocks
from the previously checkpointed file.

Format and Example(s)

	�                  �
RESTART �A1,A2,K1/K2/K3,K4,�
	�                  �

RESTART A1234567,B7654321,03/01/76,32400,

Option     Meaning

A1, A2     Fields taken from ID card of previously checkpointed problem.

K1/K2/K3   Month/day/year that problem tape was generated.

K4         Number of seconds after midnight at which XCSA begins execution.

Remarks

1. The complete restart dictionary consists of this card followed by one card
   for each file checkpointed. The restart dictionary is automatically punched
   when operating in the checkpoint mode. All subsequent cards are
   continuations of this logical card. The entire dictionary deck is required
   for a restart.

2. Each continuation card begins with a sequence number. There are two types
   of continuation cards which are required and one that is not.

   Basic continuation card:

   NO,DATABLOCK,FLAG=Y,REEL=Z,FILE=W

   where:

   NO is the sequence number of the card. The entire dictionary must be in
   sequence by this number.

   DATABLOCK is the name of the data block referenced by this card.

   FLAG=Y defines the status of the data block where Y = 0 is the normal case
   and Y = 4 implies this data block is equivalenced to another data block. In
   this case (FLAG=4) the file number points to a previous data block which is
   the 'actual' copy of the data.

   REEL=Z specifies the reel number as the Problem Tape can be a multi-reel
   tape. Z = 1 is the normal case.

   FILE=W specifies the GINO (internal) file number of the data block on the
   Problem Tape. A zero value indicates the data block is purged. For example:

      1,GPL,FLAGS=0,REEL=1,FILE=7 says data block GPL occupies file 7 of reel
      1.

      2,KGG,FLAGS=4,REEL=1,FILE=20 says KGG is equivalenced to the data block
      which occupies file 20. (Note that FLAGS=4 cards usually occur in at
      least pairs as the equivalenced operation is at least binary).

      3,USETD,FLAGS=0,REEL=1,FILE=0 implies USETD is purged.

   Reentry point card:

   NO,REENTER AT DMAP SEQUENCE NUMBER N

   where:

   NO is the sequence number of the card.

   N is the sequence number associated with the DMAP instruction at which an
   unmodified restart will resume execution. There may be (generally, there
   are) several reentry cards in a restart dictionary, but only the last such
   card is operative. (See Sections 2.1.3 and 2.1.4 in Volume II.)

   End of dictionary card:

   $ END OF CHECKPOINT DICTIONARY

   This card is simply a comment card but is punched to signal the end of the
   dictionary for your convenience. The program does not need such a card.
   Terminations associated with non-NASTRAN failures (operator intervention,
   maximum time, etc.) will not have a card punched.

3. The previously checkpointed file must be made available by you via
   operating system control cards.

4. A restart card of the form

   RESTART A1,A2, 0/0/0, 0

   can be used to read and process the Old Problem Tape (OPTP) of any
   previously checkpointed problem whose ID card fields match the A1,A2 fields
   on this card.

5. A restart using the checkpointed file and dictionary created on a previous
   release of NASTRAN may not always be successful. First, the BUFFSIZE (the
   number of words in a GINO buffer; see Section 2.1) used on the later
   release may be different from that used on the earlier release. Second, any
   changes that might have been made to the rigid formats may effectively
   destroy the validity of the restart dictionary.

6. See Sections 1.1.3, 1.1.4, and 1.1.5 in Volume II for a detailed discussion
   of restarts.

SOL - Solution Number Selection

Description

Selects the solution number which defines the Rigid Format.

Format and Example(s)

    �     �     ��
SOL � K1  �, 0  ��
    � A   �  K2 ��
    �     �     ټ

SOL 5
SOL 1,6
SOL 1,6,7,8,9
SOL STEADY STATE

Option     Meaning

K1         Solution number of Rigid Format (see Remarks below and Volume II).

K2         Subset numbers for solution K1, default value = 0.

A          Name of Rigid Format (see Remarks below).

Remarks

1. When a Direct Matrix Abstraction Program (DMAP) is not used, the solution
   is recommended and the subset associated with a solution is optional.
   (Default is 1,0.)

2. For Displacement Approach Rigid Formats, the integer value for K1 or the
   alphabetic characters for A must be selected from the following table:

   K1   A

    1   STATICS (Default)
    2   INERTIA RELIEF
    3   MODES or NORMAL MODES or REAL EIGENVALUES
    4   DIFFERENTIAL STIFFNESS
    5   BUCKLING
    6   PIECEWISE LINEAR
    7   DIRECT COMPLEX EIGENVALUES
    8   DIRECT FREQUENCY RESPONSE
    9   DIRECT TRANSIENT RESPONSE
   10   MODAL COMPLEX EIGENVALUES
   11   MODAL FREQUENCY RESPONSE
   12   MODAL TRANSIENT RESPONSE
   13   NORMAL MODES ANALYSIS WITH DIFFERENTIAL STIFFNESS
   14   STATICS CYCLIC SYMMETRY
   15   MODES CYCLIC SYMMETRY
   16   STATIC AEROTHERMOELASTIC DESIGN/ANALYSIS
   17   DYNAMIC DESIGN ANALYSIS METHOD
   18   DIRECT FORCED VIBRATION ANALYSIS
   19   MODAL FORCED VIBRATION ANALYSIS

3. For Heat Approach Rigid Formats, the integer value for K1 or the alphabetic
   characters for A must be selected from the following table:

   K1   A

    1   STATICS
    3   STEADY STATE
    9   TRANSIENT

4. For Aero Approach Rigid Formats, the integer value for K1 or the alphabetic
   characters for A must be selected from the following table:

   K1   A

    9   BLADE CYCLIC MODAL FLUTTER ANALYSIS
   10   MODAL FLUTTER ANALYSIS
   11   MODAL AEROELASTIC RESPONSE

5. Subsets cause a reduction in the number of statements in a Rigid Format.
   The use of a subset is optional. The integer value(s) may be selected from
   the following table:

   K2   Subset Numbers

    1   Delete loop control.
    2   Delete mode acceleration method of data recovery (modal transient and
	modal frequency response).
    3   Combine subsets 1 and 2.
    4   Check all structural and aerodynamic data without execution of the
	aeroelastic problem.
    5   Check only the aerodynamic data without execution of the aeroelastic
	problem.
    6   Not used.
    7   Delete structure plotting and X-Y plotting.
    8   Delete Grid Point Weight Generator.
    9   Delete fully stressed design (static analysis).

   Multiple subsets may be selected by using multiple integers separated by
   commas.

TIME - Maximum Execution Time Declaration

Description

Establishes the maximum time in minutes allotted to the execution of the
NASTRAN program.

Format and Example(s)

     �   �
TIME � n �
     �   �

TIME 5
TIME 60

Option     Meaning

n          Integer number of minutes for execution.

Remarks

1. Use of this card is recommended. (Default is 5.)

2. The time allotted via this card should be less than the time allotted the
   entire execution via operating system declaration.

UMF - User Master File Selection

Description

Selects a bulk data deck stored on a User Master File.

Format and Example(s)

    �        �
UMF �tid, pid�
    �        �

UMF 20012,6
UMF 150,0

Option     Meaning

tid        Previously assigned tape identification number to access a Bulk
	   Data Deck when using a User's Master File.

pid        Previously assigned problem identification number to access a Bulk
	   Data Deck when using a User's Master File.

Remarks

1. This card is required when the UMF Editor is in the read mode.

2. For specific instructions related to the UMF, see Section 2.5.

3. You must include a DIAG 42 card when UMF operation is requested.

UMFEDIT - User Master File Editor Selection

Description

Selects the UMF Editor and limits execution to the Preface only.

Format and Example(s)

UMFEDIT

Remarks

1. This card is required to use the UMF Editor in a read or write mode.

2. Selection of the UMF Editor automatically limits execution to the Preface
   only; that is, no computations may be performed when the Editor is used.

3. For specific instructions related to the UMF, see Section 2.5.

4. You must include a DIAG 42 card when UMF operation is requested.

$ - Comment Indicator

Description

Declares the character string is a non-executable comment.

Format and Example(s)

  �                �
$ � any BCD string �
  �                �

$ COMMENTS MAY APPEAR IN ANY COLUMNS

$ SPECIAL CHARACTERS MAY BE INCLUDED ( ) + . /

Remarks

1. The $ character is a delimiter which allows comments to be written on the
   same physical card.
