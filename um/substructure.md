
# 2.7  SUBSTRUCTURE CONTROL DECK

   The Substructure Control Deck options provide to you commands needed to
control the execution of NASTRAN for automated multi-stage substructure
analyses. These commands are input on cards with the same format conventions
as are used for the normal NASTRAN Case Control Deck.

   Initiation of a substructure analysis is achieved via the Executive Control
Deck command (see Section 2.2):

   APP DISPLACEMENT,SUBS

This command directs NASTRAN to automatically generate the required sequence
of DMAP ALTERs to the specified Rigid Format necessary to perform the
operations requested in the Substructure Control Deck. Following the
Substructure Control Deck in the NASTRAN input data stream comes the standard
Case Control Deck which specifies the loading conditions, omit sets, method of
eigenvalue extraction, element sets for plotting, plot control, output
requests, etc.

   The Substructure Control Deck commands are summarized in Table 2.7-1 where
they are listed under one of three categories according to whether they:

   1. Specify the phase and mode of execution

   2. Specify the substructuring matrix operations

   3. Define and control the substructure operating file (SOF)

Several commands have associated with them a set of subcommands used to
specify additional control information appropriate to the processing requested
by the primary command. These subcommands are defined together with the
alphabetically sorted descriptions of their primary commands in Section 2.7.3.
Examples utilizing these commands are presented in Section 1.

   The sections that follow discuss the interaction between the substructure
commands and the standard case control commands, the translation of
substructure commands into DMAP ALTER sequences, and the format conventions to
be used. The bulk data cards provided for substructure analyses are included
with the standard bulk data descriptions in Section 2.3 and they are
summarized for convenient reference in Table 2.7-2.

Table 2.7-1. Summary of Substructure Commands

 # Mandatory Control Cards  * Required Subcommand

A. Phase and Mode Control

    #SUBSTRUCTURE      Defines execution phase (1, 2, or 3) (Required)
        NAME*          Specifies Phase 1 substructure name
        SAVEPLOT       Requests plot data be saved in Phase 1
    OPTIONS            Defines matrix options (K, B, K4, M, P, or PA)
    RUN                Limits mode of execution (DRY, GO, DRYGO, STEP)
    #ENDSUBS           Terminates Substructure Control Deck (Required)

B. SOF Controls

    #SOF               Assigns physical files for storage of the SOF (Required)
    #PASSWORD          Protects and ensures access to correct file
    SOFOUT or SOFIN    Copies SOF data to or from an external file
        POSITION       Specifies initial position of input file
        NAMES          Specifies substructure name used for input
        ITEMS          Specifies data items to be copied in or out
    SOFPRINT           Prints selected items from the SOF
    DUMP               Dumps entire SOF to a backup file
    RESTORE            Restores entire SOF from a previous DUMP operation
    CHECK              Checks contents of external file created by SOFOUT
    DELETE             Edits out selected groups of items from the SOF
    EDIT               Edits out selected groups of items from the SOF
    DESTROY            Destroys all data for a named substructure and all the
                       substructures of which it is a component

C. Substructure Operations

    COMBINE            Combines sets of substructures
        NAME*          Names the resulting substructure
        TOLERANCE*     Limits distance between automatically connected grids
        CONNECT        Defines sets for manually connected grids and releases
        OUTPUT         Specifies optional output results
        COMPONENT      Identifies component substructure for special processing
        TRANSFORM      Defines transformations for named component
                       substructures
        SYMTRANSFORM   Specifies symmetry transformation
        SEARCH         Limits search for automatic connects
    EQUIV              Creates a new equivalent substructure
        PREFIX*        Prefix to rename equivalenced lower level substructures
    REDUCE             Reduces substructure matrices
        NAME*          Names the resulting substructure
        BOUNDARY*      Defines set of retained degrees of freedom
        OUTPUT         Specifies optional output requests
        RSAVE          Save REDUCE decomposition product
    MREDUCE            Reduces substructure matrices
        NAME*          Names the resulting substructure
        BOUNDARY*      Defines set of retained degrees of freedom
        FIXED          Defines set of constrained degrees of freedom for modes
                       calculation
        RNAME          Specifies basic substructure to define reference point
                       for inertia relief shapes
        RGRID          Specifies grid point in the basic substructure to define
                       reference point for inertia relief shapes. Defaults to
                       origin of basic substructure coordinate system
        METHOD         Identifies EIGR Bulk Data card
        RANGE          Identifies frequency range for retained modal
                       coordinates
        NMAX           Identifies number of lowest frequency modes for retained
                       modal coordinates
        OLDMODES       Flag to identify re-running problem with previously
                       computed modal data
        OLDBOUND       Flag to identify re-running problem with previously
                       defined boundary set
        USERMODES      Flag to indicate modal data have been input on bulk data
        OUTPUT         Specifies optional output requests

Table 2.7-1. Summary of Substructure Commands (continued)

        RSAVE          Indicates the decomposition product of the interior
                       point stiffness matrix is to be stored on the SOF
    CREDUCE            Reduces substructure matrices using a complex modes
                       transformation
        NAME*          Names the resulting substructure
        BOUNDARY*      Defines set of retained degrees of freedom
        FIXED          Defines set of constrained degrees of freedom for modes
                       calculation
        METHOD         Identifies EIGC Bulk Data card
        RANGE          Identifies frequency range of imaginary part of the root
                       for retained modal coordinates
        NMAX           Identifies number of lowest frequency modes for retained
                       modal coordinates
        OLDMODES       Flag to identify re-running problem with previously
                       computed modal data
        RSAVE          Indicates the decomposition product of the interior
                       point stiffness matrix is to be stored on the SOF
    MRECOVER           Recovers mode shape data from an MREDUCE or CREDUCE
                       operation
        SAVE           Stores modal data on SOF
        PRINT          Stores modal data and prints data requested
    SOLVE              Initiates substructure solution (statics, normal modes,
                       frequency response or transient analysis)
    RECOVER            Recovers Phase 2 solution data
        SAVE           Stores solution data on SOF
        PRINT          Stores solution and prints data requested
             DISP      Displacement output request
             SPCF      Reaction force output request
             OLOAD     Applied load output request
             VELO      Velocity output requests
             ACCE      Acceleration output requests
             BASIC     Basic substructure for output requests
             SORT      Output sort order
             SUBCASES  Subcase output request
             MODES     Modes output request
             RANGE     Mode range output request
             ENERGY    Modal energies output requests
             UIMPROVE  Improved displacement request
             STEPS     Frequency or time step output request
    BRECOVER           Basic Substructure data recovery, Phase 3
    PLOT               Initiates substructure undeformed plots

Table 2.7-2. Substructure Bulk Data Card Summary.

A. Bulk Data Used for Processing Substructure Commands REDUCE, MREDUCE, and
   CREDUCE

   BDYC      Combination of substructure boundary sets of retained degrees of
             freedom or fixed degrees of freedom for modes calculation
   BDYS      Boundary set definition
   BDYS1     Alternate boundary set definition

B. Bulk Data Used for Processing Substructure Command COMBINE

   CONCT     Specifies grid points and degrees of freedom for manually
             specified connectivities - will be overridden by RELES data
   CONCT1    Alternate specification of connectivities
   RELES     Specifies grid point degrees of freedom to be disconnected -
             overrides CONCT and automatic connectivities
   GTRAN     Redefines the output coordinate system grid point displacement
             sets
   TRANS     Specifies coordinate systems for substructure and grid point
             transformations

C. Bulk Data used for Processing Substructure Command SOLVE

   LOADC     Defines loading conditions for static analysis
   MPCS      Specifies multipoint constraints
   SPCS      Specifies single point constraints
   SPCS1     Alternate specification of single point constraints
   SPCSD     Specifies enforced displacements for single point constraints
   DAREAS    Defines dynamic load scale factors
   DELAYS    Defines dynamic load time delays
   DPHASES   Defines dynamic load Phase leads
   TICS      Defines transient initial conditions


## 2.7.1  Commands and Their Execution

   The sequence of operations is controlled by the order in which NASTRAN
encounters the sub-structure commands. A few special data cards are required
in any Substructure Command Deck. These are:

                   �       �
                   � PHASE1�
     SUBSTRUCTURE  � PHASE2�   The first card of the Substructure Command Deck
                   � PHASE3�   and it follows the CEND card of the Executive
                   �       �   Control Deck.

              �
     SOF      �  Required to define the substructure operating file to be
     PASSWORD �  used for this execution.
              �

     ENDSUBS     Signals the end of the Substructure Command Deck.

   The first step of any substructuring analysis is to define the basic
substructures to be used. These are prepared by executing one Phase 1 run for
each substructure. Checkpoints may be taken for each Phase 1 execution to save
the files to be used during the Phase 3 data recovery runs. Alternatively, you
may resubmit your entire original data deck for a Phase 3 run, thereby
avoiding a proliferation of checkpoint tapes. During a Phase 2 execution, a
long list of instructions may be specified. This list may be split up and run
in several separate smaller steps. No checkpointing is required during a Phase
2 run in that all pertinent substructure data will be retained on the
substructure operating file (SOF).

   The Case Control Deck submitted following the ENDSUBS card will be used to
direct the processing appropriate to the particular phase being executed.
During a Phase 1 run, the Case Control will be used to define the loading
conditions, single and multipoint constraints (only one set may be used per
basic substructure), omits, and desired plot sets. During a Phase 2 run, the
Case Control will be used to specify the loads and constraint data for the
SOLVE operation, outputting of results, or any plot requests. Finally, for a
Phase 3 execution, the Case Control Deck is used to define the detail output
and plot requests for each basic substructure.

   Normal substructuring analyses will require many steps to be executed under
Phase 2 processing. They may all be submitted for processing at once, or they
may be divided into several shorter sequences and executed separately. If
there is an abnormal termination, several steps may have been successfully
executed. To recover requires simply removing those completed steps from the
Substructure Control Deck and re-submitting the remaining commands. The SOF
will act as the checkpoint/restart file independently of the normal NASTRAN
checkpointing procedures.

   If the solution structure is large, a NASTRAN checkpoint would be
recommended to save intermediate results during the SOLVE operation. If this
is done, however, care must be exercised on restart to insure correct re-entry
into the DMAP sequence. This may be accomplished by removing all substructure
control commands preceding the SOLVE, modifying the Case Control Deck and Bulk
Data Deck to change set identifiers only if any new loads or constraint sets
are to be specified, and re-submitting the job. If no changes are to be made
which would affect the SOLVE operations, a regular restart can be executed
without changing the original Case Control and Bulk Data Decks.

   You may wish to add to or modify the DMAP sequence generated automatically
from the Substructure Control Deck commands. This user interaction with the
DMAP operations is explained in the following section.

## 2.7.2  Interface with NASTRAN DMAP

   Each substructure command card produces a set of DMAP ALTER cards which are
automatically inserted into the Rigid Format called for execution on the SOL
card of the Execution Control Deck (Section 2.2). These automatically
generated ALTERs require no user interfacing unless you wish to exercise the
following options:

   1. You may insert ALTER cards in the Executive Control Deck. However, they
      may not overlap any DMAP cards affected by the substructure ALTERs. The
      DMAP card numbers, modified for each Rigid Format, are given in Sections
      2.1, 2.2, 2.3, 2.8, and 2.9 of Volume II.

   2. You may suppress the DMAP generated by the substructure deck and run
      with either ALTER cards or with approach DMAP. To suppress the automatic
      DMAP, the following forms of the executive control card APP are
      provided.

        APP DISP,SUBS,1 (Retains execution of the substructuring preface
        operations)

      or

        APP DMAP (Standard NASTRAN is executed)

   3. For user information and convenience, the substructure ALTER packages
      may be printed and/or punched on cards. The executive control card, DIAG
      23, will produce the printout. DIAG 24 will produce the punched deck.
      The punched deck may then be altered by you and resubmitted as described
      in (2) above. However, the order of the associated substructure command
      deck must not be changed, to insure proper sequencing of the requested
      operations.

## 2.7.3  Substructure Control Card Descriptions

   The format of the substructure control cards is free-field. Blanks are used
to separate the control words. Either a blank or an equal sign (=) can be used
in an assignment statement. Comment cards, signalled by a dollar sign ($) in
card column 1, can be inserted anywhere in the Substructure Control Deck and
may contain any alphanumeric characters you desire. Only the first four
characters of each control word need be used so long as that option is
uniquely identified. A summary of Substructure Control cards is given in Table
2.7-1.

In presenting general formats for each card embodying all options, the
following conventions are used:

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
   card. All Substructure Control cards are limited to a single physical card.

   The Case Control Deck, which follows the ENDSUBS card of the Substructure
Control Deck, is described in Section 2.3.

BRECOVER - Basic Substructure Data Recovery

Purpose

This operation is performed in Phase 3 to recover detailed output data for a
basic substructure used in Phase 1.

Request Format

BRECOVER name

Subcommands

None.

Definitions

name       Name of structure defined in Phase 1 or structure equivalenced to
           the Phase 1 structure.

Remarks

1. Use of the RECOVER command in Phase 3 has the same effect as BRECOVER. That
   is, RECOVER is an alias for BRECOVER in Phase 3.

2. Phase 3 may be a RESTART of the original Phase 1 run or it may be executed
   from the original input data.

CHECK - Check Contents of External File

Purpose

To list all substructure items on an external file which was generated with
SOFOUT.

Request Format

                 �      �
                 � TAPE �
CHECK filename , � DISK �
                 �      �

Subcommands

None.

Definitions

filename   Name of the external file. One of the following: INPT, INP1,...,
           INP9.

TAPE       File resides on tape.

DISK       File resides on a direct access device.

Remarks

1. The substructure name, item name, and the date and time the item was
   written are listed for each item on the file.

COMBINE - Combine Sets of Substructures

Purpose

This command will perform the operations to combine the matrices and load up
to seven substructures into matrices and loads representing a new
pseudostructure. Each component structure may be translated, rotated, and
reflected before it is connected. You may manually select the points to be
connected or direct the program to connect them automatically.

Request Format

          �      �   �   �
          � AUTO �   � X �
COMBINE ( � MAN  � , � Y � ) name1, name2, etc.
          �      �   � Z �
                     �   �

Subcommands

NAME       new name (required)
TOLERANCE  � (required)
CONNECT    n
OUTPUT     m1, m2,...

Each individual component substructure may have the following added commands:

                                    �
COMPONENT    = name                 �
TRANSFORM    = m                    �
                �     �             �
                �  X  �             �
                �  Y  �             � repeat
                �  Z  �             � for each
SYMTRANSFORM =  � XY  �             � component
                � XZ  �             �
                � YZ  �             �
                � XYZ �             �
                �     �             �
SEARCH       = namej, namek, etc.   �
                                    �

Definitions

AUTO/MAN   Defines method of connecting points. If AUTO is chosen, the
           physical location of grid points is used to automatically
           determine connections. If MAN is chosen, all connections must be
           manually defined on CONCT or CONCT1 bulk data cards.

X, Y, 2    Are used on COMBINE card for searching geometry data for AUTO
           connections. Denotes preferred search direction for processing
           efficiency. See Remark 1.

name1, name2, etc. Unique names of substructures to be combined. Limits are 
           from one to seven component structures. See Remarks 5 and 6.

new name   Defines name of combination structure (required).

�          Defines limit of distance between points which will be
           automatically connected (real > 0).

n          Defines set number of manual connections and releases specified on
           bulk data cards, CONCT, CONCT1, and RELES.

name       On COMPONENT card defines the substructure (name1, etc.) to which
           the subsequent data is applied.

m          Set identification number of TRANS and GTRAN bulk data cards which
           define the orientation of the substructure and/or selected grid
           points relative to new basic coordinates. See Remarks 2 and 3.

X,Y,...XY,...XYZ  Defines axis (or set of axes) normal to the plane(s) of
           symmetry in the new basic coordinate system. The displacement and
           location coordinates in these directions will be reversed in sign.
           See Remarks 2 and 3.

namej      Limits the automatic connection process such that only connections
           between component "name" and these structures are produced.
           Multiple search commands may appear for any one component. See
           Remark 4.

m1, m2, etc.  Optional output requests. See Remark 7.

Remarks

1. The automatic connections are produced by first sorting the grid point
   coordinates in the specified coordinate direction and then searching within
   limited groups of coordinates. If the boundary of a substructure to be
   connected is aligned primarily along one of the coordinate axes, this axis
   should be used as the preferred search direction. If the boundary is
   parallel with, say, the yz plane and all boundary coordinates have a
   constant x value, then the search should be specified along either the y or
   the z axis.

2. The transformation (TRANS) data defines the orientation of the component
   substructure (old basic) in terms of the new basic coordinate system. All
   grid points originally defined in the old basic system will be transformed
   to the new basic system. Points defined in local coordinate systems will
   not be transformed unless otherwise specified on a GTRAN card, and their
   directions will rotate with the substructure.

3. The SYMTRANSFORM (or SYMT) request is primarily used to produce symmetric
   reflections of a structure. This is usually preceded by an EQUIV command to
   produce a new, unique substructure name. Note that the results for the new
   reflected substructure may reference a left-handed coordinate system
   wherever local coordinate systems are retained during the transformation.
   However, those coordinates which are originally in the old basic or are
   newly specified via a GTRAN card are automatically transformed to a
   right-handed coordinate system of the combined structure during the
   combination process. Note that the symmetric reflection occurs first using
   the component's own basic coordinate system before the translational and
   rotational transformation called for by TRANS.

4. If any search option is present, then all connections between substructures
   must be specified explicitly with SEARCH commands. Only those combinations
   specified will be searched for possible connects. Symmetric connects need
   not be declared (that is, COMPONENT A SEARCH B implies COMPONENT B SEARCH
   A). You are warned that care must be taken to assure all proper connections
   of substructures should any SEARCH commands be utilized.

5. The program automatically processes matrix data for the COMBINE operation
   in the most economical order, that is, the matrices with fewest terms are
   processed first.

6. The bandwidth of the resultant matrices may be controlled by selection of
   substructures, their boundaries, and the order in which the substructures
   are listed in the COMBINE command. The degrees of freedom in the resultant
   matrices are located as defined in the sample problem below:

      COMBINE  A,  B,  C,  D

      A    interior     ABC  boundary
      AB   boundary     C    interior
      B    interior     AD   boundary
      AC   boundary     BD   boundary
      BC   boundary     Etc.

7. The following output requests are available for the COMBINE operation (*
   marks recommended output options):

   CODE OUTPUT

     2* SOF table of contents
     3     CONCT1 bulk data summary
     4     CONCT bulk data summary
     6     GTRAN bulk data summary
     7* TRANS bulk data summary
     9     RELES bulk data summary
    11     Summary of automatically-generated connections (in terms of
           internal point numbers)
    12* Complete connectivity map of final combined pseudostructure defining
        each internal point in terms of the grid point ID and component
        substructure it represents
    13     The EQSS item
    14     The BGSS item
    15     The CSTM item
    16     The PLTS item
    17     The LODS item

      For requests 13-17, output printed is formatted SOF data for the newly
      created pseudostructure (see Section 1.10.2 for definitions).

Examples

1. COMBINE PANEL SPAR

   TOLE = .0001
   NAME = SECTA

2. COMBINE (AUTO,Z) TANK1, TANK2, BULKHD

   NAME = TANKS
   TOLE = .01
   COMPONENT TANK1
   TRAN = 4
   SEARCH = BULKHD
   COMPONENT TANK2
   SEARCH = BULKHD

3. COMBINE (MAN) LWING, RWING

   TOLE = 1.0
   NAME = WING
   COMPONENT LWING
   SYMT = Y

CREDUCE - Reduces Substructure Matrices Using Complex Modes

Purpose

This command performs a complex modal synthesis reduction on a specified
component substructure. The resulting substructure will be defined by boundary
point displacements and modal displacements as degrees of freedom. The
operation is allowed in both Phase 1 and Phase 2 jobs and may be performed at
any level of the substructure process.

Request Format

CREDUCE name

Subcommands

NAME       new name (required)

BOUNDARYb (required)

FIXED      f

METHOD     k

RANGE   f1, f2

NMAX       N

OUTPUT     m1, m2

OLDMODESm

GPARAM     g

RSAVE   (See Remark 4)

Definitions

name       Name of substructure to be reduced

new name   Name of resulting substructure

b          Set identification number of BDYC bulk data cards which define
           sets of boundary degrees of freedom (Integer > 0). See Remark 1.

f          Optionally identifies BDYC data defining degrees of freedom
           temporarily fixed during mode extraction (Integer >= 0,  default =
           0)

k          Identifies EIGC bulk data card for control of the eigenvalue
           extraction (Integer > 0)

f1, f2     Optional frequency range (Hz) for the imaginary part of the root
           defining eigenvectors to be used in the mode synthesis formulation
           (Real, default = ALL)

N          Optional number of lowest modes, measured by magnitude of
           eigenvalue, within frequency range to be used in mode synthesis
           formulation (Integer, default = ALL)

m1, m2     Optional output requests. See Remark 2.

m          Flag for re-running problem with old eigenvectors (YES or NO). See
           Remark 3.

g          Structure damping parameter (real)

Remarks

1. All references to the grid points and components not defined in the
   "boundary set" will be reduced out of the new substructure. Any subsequent
   reference to these omitted degrees of freedom in COMBINE, CREDUCE, or SOLVE
   operations generates an error condition.

2. The following output requests are available for the CREDUCE operation (*
   marks recommended output options):

   CODE OUTPUT

     1* Current problem summary

     2     Boundary set summary

     3     Summary of grid point ID numbers in each boundary set

     4     The EQSS item for the structure being reduced

     5* The EQSS item

     6* The BGSS item

     7     The CSTM item

     8     The PLTS item

     9* The LODS

    10* Modal dof set summary

    11     Fixed set summary

    12     Summary of grid point ID numbers in each fixed set

      Requests 5-8 write formatted SOF items for the new reduced
pseudostructure.

3. The OLDMODES option instructs the program to use the existing modal data
   but create new boundary matrices for a new boundary set. To exercise the
   OLDMODES option, you must use the following sequence of commands to
   eliminate previously calculated boundary point data:

   EDIT(32) new name (previous modal reduction name)
   DELETE name, GIMS, LMTX, HLFT, HORG, UPRT
   DELETE name, POVE, POAP
   CREDUCE name
     :
     :

4. If the RSAVE card is included, the decomposition product of the interior
   point stiffness matrix (LMTX item) is saved on the SOF file. This matrix
   will be used in the data recovery for the omitted points. If it is not
   saved, it will be regenerated when needed.

DELETE - Delete Items from SOF

Purpose

To delete individual substructure items from the SOF.

Request Format

DELETE name, item1, item2, item3, item4, item5

Subcommands

None.

Definitions

name       Substructure name

item1, item2,...  Item names (HORG, KMTR, LODS, SOLN, etc.)

Remarks

1. DELETE may be used to remove from one to five items of any single
   substructure.

2. For primary substructures, items of related secondary substructures are
   removed only if the latter point to the same data (KMTX, MMTX, etc.).

3. For secondary and image substructures, no action is taken on items of
   related substructures, that is, items of equivalenced substructures or
   higher or lower level substructures.

4. See the EDIT and DESTROY commands for other means of removing substructure
   data.

DESTROY - Removes All Data Referencing a Component Substructure

Purpose

To remove data for a substructure and all substructures of which it is a
component from the SOF. In addition to the substructure being DESTROYed
("name"), data for substructures which satisfy one or more of the following
conditions are also removed from the SOF:

   1. All substructures of which "name" is a component

   2. All secondary (or equivalenced) substructures for which "name" is the
      primary substructure

   3. All image substructures which are components of a substructure that is
      destroyed

Request Format

DESTROY name

Subcommands

None.

Definitions

name       Name of substructure

Remarks

1. No action is taken if "name" is an image substructure.

2. See related commands EDIT and DELETE for additional means of removing
   substructure data.

DUMP - Copy SOF to External File

Purpose

To copy the entire SOF to an external file.

Request Format

                 �      �
                 � TAPE �
DUMP filename  , � DISK �
                 �      �

Subcommands

None

Definitions

filename   Name of the external file. Any one of the following:  INPT,
           INP1,..., INP9.

TAPE       File resides on tape.

DISK       File resides on a direct access device.

Remarks

1. DUMP may be used to create a backup copy of the SOF.

2. All system information on the SOF is saved.

3. The RESTORE command will reload a DUMPed SOF.

4. DUMP/RESTORE may not be used to change the size of the SOF.

5. It is more efficient to use operating system utility programs, if
   available, to create back-up copies of the SOF.

EDIT - Selectively Removes Data from SOF File

Purpose

To permanently remove selected substructure data from the SOF.

Request Format

EDIT (opt) name

Subcommands

None.

Definitions

name       Name of substructure.

opt        Integer value reflecting combinations of requests. The sum of the
           following integers defines the combination of data items to be
           removed from the SOF.

           OPT   ITEMS REMOVED

            1    Stiffness matrix (KMTX)
            2    Mass matrix (MMTX)
            4    Load data (LODS, LOAP, PVEC, PAPP)
            8    Solution data (UVEC, QVEC, SOLN)
           16    Transformation matrices defining next level (HORG, UPRT,
                 POVE, POAP, LMTX, GIMS, HLFT)
           32    All items for the substructure
           64    Appended loads data (LOAP, PAPP, POAP)
           128   Damping matrices (K4MX, BMTX)
           256   Modal reduction data (LAMS, PHIS, PHIL)
           512   Total transforms only (HORG, HLFT)

Remarks

1. You are cautioned on the removal of the transformation matrix data. These
   matrices are required for the recovery of the solution results.

2. For primary substructures, items of related secondary substructures are
   removed only if they point to the same data (KMTX, MMTX, etc.).

3. For secondary and image substructures, no action is taken on items of
   related substructures, that is, items of equivalenced or higher or lower
   level substructures.

4. If the EDIT feature is to be employed, you should consider also using
   SOFOUT to ensure the existence of backup data if there is an error.

5. See DELETE and DESTROY for other means of removing substructure data.

ENDSUBS - Defines the End of the Substructure Control Deck.

Purpose

This command terminates the processing of automated substructuring controls
and directives.

Request Format

ENDSUBS

Subcommands

None.

EQUIV - Create a New Equivalent Substructure

Purpose

To assign an alias to an existing substructure and thereby create a new
equivalent substructure. The new secondary substructure may be referenced
independently of the original primary substructure in subsequent substructure
commands. However, the data actually used in substructuring operations is that
of the primary substructure.

Request Format

EQUIV name1, name2

Subcommands

PREFIX = p (required)

Definitions

p          Single BCD character.

name1      Existing primary substructure name.

name2      New equivalent substructure name.

Remarks

1. A substructure created by this command is referred to as a secondary
   substructure.

2. All substructures which were used to produce the primary substructure will
   produce equivalent image substructures. The new image substructure names
   will have the prefix p.

3. A DESTROY operation on the primary substructure data will also destroy the
   secondary substructure data and all image substructures.

4. An EDIT or DELETE operation on the primary substructure will not remove
   data of the secondary substructure and vice versa.

MRECOVER - Eigenvector Recovery for Modal Synthesis Operations

Purpose

This command recovers modal displacements and boundary forces for
substructures reduced to modal coordinates. The results are saved on the SOF
file and they may be printed upon your request. This command may be input
after the MREDUCE or CREDUCE commands or at a later time as desired.

Request Format

MRECOVER s-name

Subcommands

(see Remark 12)

SAVE          cname1

PRINT         cname2
             �    �
             �NONE�
DISP         � n  �
             �ALL �
             �    �
             �    �
             �NONE�
SPCF         � n  �          (see Remark 4)
             �ALL �
             �    �
BASIC         b-name
             �    �
             �NONE�
ENERGY       � n  �          (see Remark 10)
             �ALL �
             �    �
             �            �
             �MODES       �
SORT         �SUBSTRUCTURE�  (see Remark 6)
             �            �
             �    �
             �ALL �
MODES        � n  �          (see Remark 7)
             �NONE�
             �    �
RANGE         fl, f2         (see Remark 7)

UIMPROVE                     (see Remark 9)

Definitions

s-name     Name of the substructure that was reduced in a prior MREDUCE or
           CREDUCE command for which the solution results are to be
           recovered.

cname1     Name of the component substructure for which the results are to be
           recovered and saved on the SOF. May be the same as "s-name". See
           Remarks 1, 2, and 3.

cname2     Name of the component substructure for which the results are to be
           recovered and printed on the SOF. May be the same as "s-name". See
           Remarks 1, 2, 3, 8, and 11.

b-name     Name of the component basic substructure for which the subsequent
           output requests are to apply.

ALL        Output for all points will be produced. See Remark 8.

NONE       No output is to be produced.

n          Set identification number of a SET card appearing in Case Control.
           Only output for those points whose identification numbers appear
           on this SET card will be produced. See Remark 5.

f1, f2     Range of frequencies for which output will be produced. If only f1
           is present, the range is assumed to be 0 - f1. See Remark 7.

Output Requests

Printed output produced by the MRECOVER PRINT command can be controlled by
requests present in either Case Control or the MRECOVER command in the
Substructure Control Deck. If no output requests are present, the PRINT
command is equivalent to SAVE and no output will be printed.

The output options described above may appear after any PRINT command. These
output requests will then override any Case Control requests. The output
requests for any PRINT command can also be specified for any or all basic
component substructures of the results being recovered. These requests will
then override any requests in Case Control or after the PRINT command.

Example of output control:

  MRECOVER SOLSTRCT
     PRINT ABDC
          SORT = SUBSTRUCTURE  �
          DISP = ALL           �  basic defaults for ABDC output
          BASIC   A            �
              DISP = 5         �  override requests for BASIC A
          BASIC   C            �
              SPCF = 20        �  override requests for BASIC C
     SAVE ABC

Remarks

1. SAVE will save the solution for substructure "name" on the SOF. PRINT will
   save and print the solution.

2. If the solution data already exists on the SOF, the existing data can be
   printed without costs of regeneration with the PRINT command.

3. For efficiency, you should order multiple SAVE and/or PRINT commands so as
   to trace one branch at a time starting from your solution structure.

4. Reaction forces are computed for a substructure only if (1) the
   substructure is named on a PRINT subcommand and (2) an output request for
   SPCFORCE or modal energies exists in the Case Control or the RECOVER
   command.

5. All set definitions should appear in Case Control to ensure their
   availability to the MRECOVER module.

6. The SORT output option should only appear after a PRINT command. Any SORT
   commands appearing after a BASIC command will be ignored.

   SORT = MODES (the default) will cause all output requests for each mode to
   appear together. SORT = SUBSTRUCTURE will cause all output requests for
   each basic substructure to appear together.

7. If both a MODES request and a RANGE request appear for dynamic analysis,
   both requests must be satisfied for any output to be produced.

8. The media, print or punch, where output is produced is controlled through
   Case Control requests. If no Case Control requests are present, the default
   of print is used.

9. If the UIMPROVE request is present for a substructure that was input to a
   REDUCE, MREDUCE, or CREDUCE, an improved displacement vector will be
   generated. This vector will contain the effects of inertia and damping
   forces.

10.   The ENERGY request will cause the calculation of modal energies on all
      included and excluded modal dof for a modal reduced substructure. This
      request should appear for the substructure that was input to the modal
      reduce operation so that required data needed for the excluded mode
      calculations exists. This request requires that the UVEC item exist for
      the next higher level structure.

11.   You can specify print thresholds for all printout. If the absolute value
      is less than the threshold, the value will be set to zero. The following
      thresholds can be input on PARAM bulk data cards.

   UTHRESH displacement, velocity, and acceleration threshold
   PTHRESH load threshold
   QTHRESH reaction force threshold

12.   Since the subcommands of the MRECOVER command are all associated with a
      component structure, multiple use of these subcommands is permitted.

MREDUCE - Reduces Substructure Matrices Using Real, Normal Modes

Purpose

This command performs a modal synthesis reduction on a specified component
substructure. The resulting substructure will be defined by boundary
coordinate displacements and modal coordinate displacements as degrees of
freedom. The operation is allowed in both Phase 1 and Phase 2 jobs and may be
performed at any level of the substructure process.

Request Format

MREDUCE name

Subcommands

NAME       new name (required)

BOUNDARYb (required)

FIXED      f

METHOD     k

RANGE   f1, f2

NMAX       N

RGRID      i (see Remark 12)

RNAME   c-name

RSAVE   (see Remark 7)

OLDMODESm

OLDBOUNDn

USERMODES  j

OUTPUT     m1, m2

Definitions

name       Name of substructure to be reduced

new name   Name of resulting substructure. See Remarks 2 and 3.

b          Set identification number of BDYC Bulk Data cards which define
           sets of boundary degrees of freedom (Integer). See Remark 1.

f          Optionally identifies BDYC data defining degrees of freedom
           temporarily fixed during mode extraction (Integer, default = 0).

k          Identifies EIR,R Bulk Data card for control of the mode extraction
           (Integer > 0).

i          Grid point number for defining origin of free body motion. Used
           with RNAME to define substructure component containing grid point
           i (Integer >= 0, default = 0). (See Remark 12.)

c-name     Name of basic substructure which contains grid point i. If RGRID =
           0 or is missing, the origin of the overall basic coordinate system
           is used to define the six rigid body motions. These motions define
           the inertia relief deflection shapes which are used as generalized
           coordinates in addition to the modal coordinates.

m          Flag for re-running problem with old mode shapes (YES or NO). See
           Remarks 5, 8, and 10.

n          Flag for re-running problem with old boundaries for different
           eigenvalue method (YES or NO). See Remarks 5, 9, and 10.

f1, f2     Optional frequency range (in cycles per unit time) defining modes
           to be used in the mode synthesis formulation (Real, default =
           ALL).

N          Optional number of lowest modes within elastic frequency range to
           be used in mode synthesis formulation (Integer, default = ALL).
           Rigid body modes are automatically included, in addition to the
           selected number of NMAX of elastic modes.

j          Option used in Phase 1 when METHOD data is missing and user-input
           modes are used directly. See Remark 6.

m1, m2     Optional output requests. See Remark 4.

Remarks

1. All references to the grid points and components not defined in the
   "boundary set" will be reduced out of the new substructure. Any subsequent
   reference to these omitted degrees of freedom in COMBINE, MREDUCE, REDUCE,
   or SOLVE operations generates an error condition.

2. The resulting substructure will be defined in terms of the following
   degrees of freedom:

   ub boundary grid point displacements.

   �j modal displacements relative to static deflection shapes induced by
      boundary inertia.

   �o inertia relief generalized coordinates defined by inertia relief
      deflection shapes occurring from boundary point rigid body accelerations
      (zero frequency modes).

   Note that a new substructure will be automatically created to define
   coordinates �o and �j. The name will be the same as given by NAME and the
   point identification numbers are 1-6 for �o and 101, 102,... for �j.

3. The same transformations applied to the stiffness matrix will be applied to
   the loads, mass, and damping matrices for the new substructure. See the
   NASTRAN Theoretical Manual for a discussion of this effect.

4. The following output requests are available for the MREDUCE operation (*
   marks recommended options):

   CODE OUTPUT

     1* Current problem summary

     2     Boundary set summary

     3     Summary of grid point ID numbers in each boundary set

     4     The EQSS item for the structure being reduced

     5* The EQSS item

     6* The BGSS item

     7     The CSTM item

     8     The PLTS item

     9* The LODS item

    10* Modal dof set summary (see Remark 11)

    11     Fixed set summary

    12     Summary of grid point ID numbers in each fixed set

      Requests 5-9 write formatted SOF items for the new reduced
      pseudostructure.

5. The options OLDMODES and OLDBOUND allow you to re-run the reduction and:

   a. Change the boundary without recalculating modes.

   b. Change the modes without the boundary condensation calculations.

   c. Select a different mode range from the existing vectors and avoid
      recalculating modes and boundary matrices.

6. You must provide the actual mode data in Phase 1 when USERMODES = j is
   given. Two options are provided:

   a. If j = 1, the structure must be entirely defined by a finite element
      model and the eigenvectors for the NASTRAN ua set provided in data block
      PHIS input using DMI cards.

   b. If j = 2, the entire structure need not be defined. You provide
      eigenvectors and forces of constraint only at the selected boundary
      points as well as eigenvalues and modal masses. Residual stiffness and
      mass matrices may also be provided to define properties at the boundary
      points. Use DMI and DTI cards for these data.

7. If the RSAVE card is included, the decomposition product of the interior
   point stiffness matrix (LMTX item) is saved on the SOF file. This matrix
   will be used in the data recovery for the omitted points. If it is not
   saved it will be regenerated when needed.

8. Exercising the OLDMODES option, you must use the following sequence of
   commands:

   EDIT(32)new name (previous modal reduction name)
   EDIT(16)name
   MREDUCE name
   NAME =  new name

9. Exercising the OLDBOUND option, you must use the following sequence of
   commands:

   EDIT(32)new name (previous modal reduction name)
   EDIT(768)  name
   MREDUCE name
   NAME =  new name

10.   Exercising both the OLDMODES and OLDBOUND options concurrently you must
      use the following sequence of commands:

   EDIT(32)new name (previous modal reduction name)
   EDIT(512)  name
   MREDUCE name
   NAME =  new name

11.   You are strongly urged to select code 10 for your output request. The
      modal dof set summary gives a good breakdown between the assignments of
      rigid body modes and elastic modes. The MREDUCE module sometimes
      overrides your specification of NMAX. This occurs when the nature of the
      mode is such that the 2-3 term of Hgh (as defined by Equation 27 on page
      4.7-7 of the Thereotical Manual) is zero; that is, when �i - Gib�b
      approximately equals zero. When this occurs NASTRAN automatically
      deletes the ineffective mode from the solution set. Any such omission
      can be verified from the printout triggered by code 10.

12.   Note on RGRID: Your choice of one grid point or another for inertia
      relief modes does not in any way determine the net reaction forces, but
      operates solely as a convenience as to choice of reference origin.

OPTIONS - Defines Matrix Types

Purpose

This allows you to selectively control the type of matrices being processed.

Request Format

OPTIONS m1,m2,m3

Subcommands

None.

Definitions

m1,m2,m3   Any combination of the characters K, M, B, K4, and either P or PA,
           where:

           K  =  Stiffness Matrices
           M  =  Mass Matrices
           P  =  Load Matrices
           PA =  Appended Load Vectors
           B  =  Viscous Damping Matrices
           K4 =  Structure Damping Matrices

Remarks

1. The default depends on the NASTRAN rigid format:

   RIGID FORMAT    DEFAULT

   1 - Statics        K,P
   2 - Inertia Relief    K,M,P
   3 - Normal Modes   K,M
   8 - Frequency ResponseK,M,P,B,K4
   9 - Transient ResponseK,M,P,B,K4

2. In a Phase 1 execution, Rigid Formats 1 and 3 will provide only two of the
   matrices, as shown above. In Rigid Format 1, the mass matrix is not
   generated. In Rigid Format 3, the loads matrix is not generated. An error
   condition will result unless you add the required DMAP alters to provide
   the requested data.

3. Stiffness, mass, load, or damping matrices must exist if the corresponding
   K, M, P, PA, B, or K4 option is requested in the subsequent Phase 2 run.

4. Matrices or loads may be modified by re-running the substructure sequence
   for only the desired type. However, the old data must be deleted first with
   the EDIT or DELETE command. See Section 1.10.2 for the actual item names.

5. The append load option, PA, is used when additional load sets are required
   for solution, and it is not desired to regenerate existing loads. To
   generate these new load vectors, re-execute all required Phase 1 runs with
   the new load sets and OPTION = PA. Then, repeat the Phase 2 operations with
   OPTION = PA. At each step, the new vectors are appended to the existing
   loads so that all load vectors will be available in the SOLVE stage.

6. Each OPTION command overrides the preceding command to control subsequent
   steps of the substructure process.

7. When executing the SOLVE command, the option selected must provide the
   matrices required for the rigid format being executed.

PASSWORD - Substructure Operating File Declaration

Purpose

This declaration is required in the substructure command deck. The password is
written on the SOF file and is used to protect the file and ensure that the
correct file is assigned for the current run.

Request Format

PASSWORD password

Subcommands

None.

Definitions

password   BCD password for the SOF (8 characters maximum).

PLOT - Substructure Plot Command

Purpose

This command is used to plot the undeformed shape of a substructure which may
be composed of several component substructures. This command initiates the
execution of a plot at any stage of the substructure process. The actual plot
commands -- origin data, etc.-- must be included in the normal case control
data.

Request Format

PLOT name

Subcommands

None.

Definitions

name       Name of component substructure to be plotted.

Remarks

1. This PLOT command can be used in any of the three phases. However, it is
   suggested that it be used only in Phase 2. In the case of Phase 1 and Phase
   3 runs, any desired plots can be obtained in the usual manner by
   appropriate requests in the structure plotter output request packet in the
   Case Control Deck.

2. The set of elements to be plotted in Phase 2 consists of all the elements
   and grid points saved in Phase 1 for each basic substructure comprising the
   substructures named in the PLOT command. The set definition given in the
   structure plotter output request packet in the Case control Deck in Phase 2
   is ignored. (Only one plot set from each basic substructure is saved in
   Phase 1.)

3. The structure plotter output request packet, while part of the standard
   Case Control Deck, is treated separately in Sections 4.1 and 4.2.

RECOVER - Phase 2 Solution Data Recovery

Purpose

This command recovers displacements and boundary forces on specified
substructures in the Phase 2 execution. The results are saved on the SOF file
and they may be printed upon your request. This command should be input after
the SOLVE command to store the solution results on the SOF file.

Request Format

RECOVER s-name

Subcommands

SAVE          cname1

PRINT         cname2
             �    �
             �NONE�
DISP         � n  �
             �ALL �
             �    �
             �    �
             �NONE�
SPCF         � n  �          (see Remark 4)
             �ALL �
             �    �
             �    �
             �NONE�
OLOAD        � n  �          (see Remark 11)
             �ALL �
             �    �
BASIC         b-name
             �    �
             �NONE�
ENERGY       � n  �          (see Remark 10)
             �ALL �
             �    �

for static analysis only:

             �            �
             �SUBCASE     �
SORT         �SUBSTRUCTURE�  (see Remark 6)
             �            �
             �    �
             �ALL �
SUBCASES     � n  �
             �NONE�
             �    �

for normal modes analysis only:

             �            �
             �MODES       �
SORT         �SUBSTRUCTURE�  (see Remark 6)
             �            �
             �    �
             �ALL �
MODES        � n  �          (see Remark 7)
             �NONE�
             �    �
RANGE         f1, f2         (see Remark 7)

for dynamic analysis only:

             �            �
             �FREQ        �
SORT         �TIME        �  (see Remark 6)
             �SUBSTRUCTURE�
             �            �
             �    �
             �ALL �
STEPS        � n  �
             �NONE�
             �    �
RANGE         fl, f2         (see Remark 7)

UIMPROVE                      (see Remark 9)

Definitions

s-name     Name of the substructure named in a prior SOLVE command for which
           the solution results are to be recovered.

cname1     Name of the component substructure for which the results are to be
           recovered and saved on the SOF. May be the same as "s-name". See
           Remarks 1, 2, and 3.

cname2     Name of the component substructure for which the results are to be
           recovered and printed on the SOF. May be the same as "s-name". See
           Remarks 1, 2, 3, 8, and 12.

b-name     Name of the component basic substructure for which the subsequent
           output requests are to apply.

ALL        Output for all points will be produced. See Remark 8.

NONE       No output is to be produced.

n          Set identification number of a SET card appearing in Case Control.
           Only output for those points, subcases, modes, frequencies, or
           time steps whose identification numbers appear on this SET card
           will be produced. See Remark 5.

f1, f2     Range of frequencies for which output will be produced. If only f1
           is present, the range is assumed to be 0 - f1. See Remark 7.

Output Requests

Printed output produced by the RECOVER PRINT command can be controlled by
requests present in either Case Control or the RECOVER command in the
Substructure Control Deck. If no output requests are present, the PRINT
command is equivalent to SAVE and no output will be printed.

The RECOVER output options described above may appear after any PRINT command.
These output requests will then override any Case Control requests. The output
requests for any PRINT command can also be specified for any or all basic
component substructures of the results being recovered. These requests will
then override any requests in Case Control or after the PRINT command.

Example of output control:

     RECOVER SOLSTRCT
         PRINT   ABDC
             SORT = SUBSTRUCTURE  �
             DISP = ALL           �  basic defaults for ABDC output
             OLOAD = 10           �
             BASIC   A            �
                 DISP = 5         �  override requests for BASIC A
             BASIC   C            �
                 OLOAD = NONE     �  override requests for BASIC C
                 SUBCASES = 20    �
         SAVE   ABC

Remarks

1. SAVE will save the solution for substructure "name" on the SOF. PRINT will
   save and print the solution.

2. If the solution data already exists on the SOF, the existing data can be
   printed without costs of regeneration with the PRINT command.

3. For efficiency, you should issue multiple SAVE and/or PRINT commands so as
   to trace one branch at a time starting from your solution structure.

4. Reaction forces are computed for a substructure only if (1) the
   substructure is named on a PRINT subcommand and (2) an output request for
   SPCFORCE or modal energies exists in the Case Control or the RECOVER
   command.

5. All set definitions should appear in Case Control to ensure their
   availability to the RECOVER module.

6. The SORT output option should only appear after a PRINT command. Any SORT
   commands appearing after a BASIC command will be ignored.

   For static analysis, SORT = SUBCASE (the default) will cause all output
   requests for each subcase to appear together. For normal modes analysis,
   SORT = MODES (the default) will cause all output requests for each mode to
   appear together. For dynamic analysis, SORT = FREQ (the default for
   frequency response) or SORT = TIME (the default for transient response)
   will cause all output requests for each frequency or time step, as the case
   may be, to appear together. In all these analyses, SORT = SUBSTRUCTURE will
   cause all output requests for each basic substructure to appear together.

7. If both a MODES (or STEPS) request and a RANGE request appear for dynamic
   analysis, both requests must be satisfied for any output to be produced.

8. The medium, print or punch, where output is produced is controlled through
   Case Control requests. If no Case Control requests are present, the default
   of print is used.

9. If the UIMPROVE request is present for a substructure that was input to a
   REDUCE, MREDUCE, or CREDUCE, an improved displacement vector will be
   generated. This vector will contain the effects of inertia and damping
   forces.

10.   The ENERGY request will cause the calculation of modal energies on all
      included and excluded modal dof for a modal reduced substructure. This
      request should appear for the substructure that was input to the modal
      reduce operation so that required data needed for the excluded mode
      calculations exists. This request requires that the UVEC item exists for
      the next highest level structure.

11.   For dynamic analysis, the printed loads output will include dynamic
      loads only for the solution substructure in the same run where the
      solution was obtained. For any lower level substructures or on any run
      after the solution, only static loads will be printed.

12.   You can specify print thresholds for all printout. If the absolute value
      is less than the threshold, the value will be set to zero. The following
      thresholds can be input on PARAM bulk data cards.

   UTHRESH displacement, velocity, and acceleration
   PTHRESH load threshold
   QTHRESH reaction force threshold

REDUCE - Phase 2 Reduction to Retained Degrees of Freedom

Purpose

This command performs a Guyan matrix reduction process for a specified
component substructure, otherwise known as matrix condensation. It produces
the same result as obtained by the specification of NASTRAN OMIT  or ASET
data. The purpose is to reduce the size of the matrices. In static analysis
only points on the boundary need be retained. In dynamics, the boundary points
and selected interior points are retained.

Request Format

REDUCE name

Subcommands

NAME       new name (required)

BOUNDARYb (required)

OUTPUT     m1, m2,...

RSAVE   (See Remark 4)

Definitions

name       Name of substructure to be reduced.

new name   Name of resulting substructure.

b          Set identification number of BDYC bulk data cards which define
           sets of retained degrees of freedom for the resulting
           reduced substructure matrices. See Remarks 1 and 2.

m1, m2, etc.  Optional output requests. See Remark 3.

Remarks

1. All references to the grid points and components not defined in the
   "boundary set" will be reduced out of the new substructure. Any subsequent
   reference to these omitted degrees of freedom in COMBINE, REDUCE, or SOLVE
   operations generates an error condition.

2. The same transformations will be applied to the reduced mass matrix for the
   new substructure. See the NASTRAN Theoretical Manual for a discussion of
   this effect.

3. The following output requests are available for the REDUCE operation (*
   marks recommended output options):

   CODE OUTPUT

   1*   Current problem summary
   2    Boundary set summary
   3    Summary of grid point ID numbers in each boundary set
   4    The EQSS item for the structure being reduced
   5*   The EQSS item
   6*   The BGSS item
   7    The CSTM item
   8    The PLTS item
   9*   The LODS item

      Requests 5-9 write formatted SOF items for the new reduced
pseudostructure.

4. If the RSAVE card is included, the decomposition product of the interior
   point stiffness matrix (LMTX item) is saved on the SOF file. This matrix
   will be used in the data recovery for the omitted points. If it is not
   saved, it will be regenerated when needed.

RESTORE - Reload SOF

Purpose

To reload the SOF from an external file created with the DUMP command.

Request Format

                    �      �
                    � TAPE �
RESTORE filename  , � DISK �
                    �      �

Subcommands

None

Definitions

filename   Name of the external file. Any one of the following: INPT,
           INP1,..., INP9.

TAPE       File resides on tape.

DISK       File resides on a direct access device.

Remarks

1. The external file must have been created with the DUMP command.

2. The SOF must be declared as NEW on the SOF command.

3. RESTORE must be the very first substructure command following the SOF and
   PASSWORD declarations.

4. The SOF size declarations for the RESTORE command must be exactly the same
   as for the SOF which was DUMPed. The DUMP/RESTORE commands cannot be used
   to increase the size of the SOF.

RUN - Specifies Run Options

Purpose

This command is used to limit the substructure execution for the purpose of
checking the validity of the input data. It allows for the processing of input
data separately from the actual execution of the matrix operations.

Request Format

     �       �
     � STEP  �
     � DRY   �
RUN  � GO    �
     � DRYGO �
     �       �

Subcommands

None.

Definitions

STEP       Will cause the execution of both DRY and GO operations one step at
           a time.

DRY        Limits the execution to table and transformation matrix
           generation. Matrix operations are skipped.

GO         Limits the execution to matrix generation only. This mode must
           have been preceded by a successful RUN=DRY or RUN=STEP execution.

DRYGO      Will cause execution of a complete dry run for the entire job,
           followed by a RUN=GO execution if no fatal errors were detected.

Remarks

1. The DRY, GO, and STEP options may be changed at any step in the input
   substructure command sequence. If the DRYGO option is used, the RUN card
   must appear only once at the beginning.

2. If a fatal error occurs during the first pass of the DRYGO option, the
   program exits at the completion of all DRY operations.

3. The RUN = DRY option is handled differently for MREDUCE and CREDUCE because
   the matrix operations must be performed in order to generate the table and
   transformation matrix data. Input data only will be checked and no
   subsequent commands will be executed.

4. The RUN = GO and OPTIONS = K combination is illegal for any of the reduce
   operations, REDUCE, MREDUCE, or CREDUCE.

SOF - Assigns Physical Files for Storage of the SOF

Purpose

This declaration defines the names and sizes of the physical NASTRAN files you
assign for storage of the SOF file. At least one of these declarations must be
present in each substructure command deck. As many SOF declarations are
required in the substructure command deck on each run as there are physical
files assigned for the storage of the SOF file.

Request Format

SOF(no.) = filename, filesize,   OLD
                                 NEW

Definitions

no.        Integer index of SOF file (1, 2, etc.) in ascending order of files
           required for storage of the SOF. The maximum index is 10. See
           Remarks 1, 2, and 3.

filename   User name for an SOF physical file. See Remarks 2, 3, and 7.

filesize   Size of allocated file space in kilowords, default = 100. See
           Remarks 1 and 4.

OLD        SOF data is assumed to already exist on the file.

NEW        The SOF is new. In this case, the SOF will be initialized. See
           Remark 5.

Remarks

1. If more space is required for storage of the SOF file, additional physical
   files may be declared. Alternatively, the file size parameter on a
   previously declared file may be increased, but only on the last physical
   file if more than one is used (on IBM the size of an existing file may not
   be increased).

2. Once an SOF declaration is made, the index of the SOF file must always be
   associated with the same file name. File names may not be changed from run
   to run.

3. The file name of each physical SOF file must be unique.

4. The declared size of the SOF may be reduced by the amount of contiguous
   free space at the end of the logical SOF file. This may be accomplished by
   removing the physical file declaration for those unused files which have
   the highest sequence numbers. An attempt to eliminate a portion of the SOF
   which contains valid data will result in a fatal error.

5. If the NEW parameter is present on any one of the SOF declarations, the
   entire logical SOF is considered new. Therefore, if an additional physical
   file is added to an existing SOF, the NEW parameter should not be included
   on any declarations.

6. You should insure that the correct SOF file is assigned for the current
   run. See the PASSWORD description.

7. The following conventions should be used for the file name declarations on
   each of the NASTRAN computers:

   CDC/CYBER

   Must be a 4-character alphanumeric name with no special characters or
   blanks allowed. The file name used on the SOF declaration must correspond
   to ones used on the system REQUEST or ATTACH card. Note that after a
   NASTRAN execution, the SOF files should be catalogued or extended.

   Examples

   1. Create a new SOF file with a filename of SOF1 and catalogue it.

      REQUEST(SOF1,*PF)
      NASTRAN.
      CATALOG(SOF1,username)
      789
       :
       :
      NASTRAN data cards including the SOF declaration
      SOF(1)=SOF1,1000,NEW
       :
       :
      6789

   2. Use of an existing SOF file with a filename of ABCD.

      ATTACH(ABCD,username)
      NASTRAN.
      EXTEND(ABCD)
      789
       :
       :
      NASTRAN data cards including the SOF declaration
      SOF(1)=ABCD,1000
       :
       :
      6789

   UNIVAC 1108/1110

   The filename used on the SOF declaration must specify one of the NASTRAN
   user files INPT, INP1,..., INP9.

   Examples

   1. Create a new SOF file named INPT.

      @ASG.U INPT.,F///1000
      @HDG,N
      @XQT *NASTRAN.LINK1
       .
      NASTRAN FILES=INPT
       .
      NASTRAN data cards including the SOF declaration
      SOF(1)=INPT,400,NEW
       :
       :
      @FIN

   2. Use of an existing SOF file with a filename of INP7.

      @ASG,AX INP7.
      @HDG,N
      @XQT *NASTRAN.LINK1
       .
      NASTRAN FILES=INP7
       .
      NASTRAN data cards including the SOF declaration
      SOF(1)=INP7,250
       :
       :
      @FIN

   IBM 360/370

   The file name used on the SOF declaration must specify a FORTRAN unit by
   using the form FTxx from the table of allowable file names shown below
   which correspond to the direct access devices that are supported under the
   SOF implementation. The allocation of space for the direct access FORTRAN
   data sets can be made in terms of blocks, tracks, or cylinder. If the
   allocation is in blocks, the block size in the space allocation corresponds
   to (BUFFSIZE-4)*4 bytes where BUFFSIZE is the GINO buffer size found in
   SYSTEM(1).

   In order to use the SOF on IBM computers, it is necessary to specify the
   PARM on the EXEC PGM=NASTRAN card. This PARM sets the amount of core (in
   bytes) NASTRAN releases to the operating system for system use and FORTRAN
   buffers. The following formula should be used to determine the value for
   the PARM:

   PARM =  (4096 + m*((BUFFSIZE-4) + 64))*4 single buffering, BUFNO=1
           (4096 + m*(2*(BUFFSIZE-4) + 96))*4 double buffering, BUFNO=2

   where m = number of physical datasets comprising the SOF.

   Examples

   1. Create a new SOF data set with a filename of FT11.

      //NSGO EXEC NASTRAN,PARM.NS='CORE=(,60K)'
      //NS.FT11F001 DD DSN = User Name, UNIT=2314, VOL=SER=User No.,
      //   DISP=(NEW,KEEP), SPACE=TRK,(1000)), DCB=BUFNO=1
      //NS.SYSIN DD *
      NASTRAN BUFFSIZE=1826
       :
       :
      NASTRAN data cards including the SOF declaration
      SOF(1)=FT11,,NEW
       :
       :
      /*

      Remarks

      1.The SOF parameters - filename, filesize, and (OLD/NEW) - are
        positional parameters. The filesize parameter is not required for IBM
        360/370 computers, but its position must be noted if NEW is coded for
        the SOF file.

      2.The dataset disposition must be DISP=(NEW,KEEP) when the SOF dataset
        is created. However, an existing SOF dataset may be reinitialized by
        coding NEW on the SOF declaration in the  NASTRAN data deck. In this
        case, the disposition on the DD card must be coded DISP=OLD.

   2. Use of an existing SOF dataset with a filename of FT23.

      //NS EXEC NASTRAN,PARM.NS='CORE=(,72K)'
      //NS.FT23F00l DD DSN = User Name, UNIT=3330, VOL=SER=User No.,
      // DCB=BUFNO=1, DISP=OLD
      //NS.SYSIN DD *
      NASTRAN BUFFSIZE=3260
      SOF (1)=FT23
       :
       :
      /*

   SOF File      FORTRAN Unit           SOF File     FORTRAN Unit
    Name            DDName                Name          DDName

    FT02            FT02F001              FT16         FT16F001
    FT03            FT03F001              FT17         FT17F001
    FT08            FT08F001              FT18         FT18F001
    FT09            FT09F001              FT19         FT19F001
    FT10            FT10F00l              FT20         FT20F001
    FT11            FT11F001              FT21         FT21F001
    FT12            FT12F001              FT22         FT22F001
    FT15            FT15F001              FT23         FT23F001

   Note: A maximum of 10 SOF file names is allowed in any NASTRAN substructuring
   run.

   DEC VAX

   The filename used on the SOF declaration must be of the form FTxx thereby
   implying the use of the FORTRAN logical unit FOR0xx for the SOF. Any of the
   FORTRAN logical units FOR014 through FOR023 may be used for the SOF,
   provided they are not otherwise assigned.

   Examples

   1. Create a new SOF with the file name TEST.SOF

      $ CREATE TEST1.COM
            $ASSIGN TEST.SOF FOR022
            $@NASTRAN TEST1.DT
            $EXIT

      $ SUBMIT/QUEUE=NASTRAN TEST1.COM

        The file NASTRAN.COM contains the command procedure for executing
        NASTRAN and the file TEST1.DT contains the NASTRAN data including the
        SOF declaration--SOF(1) = FT22,1000,NEW
   2. Use an existing SOF with the file name TEST.SOF

      $ CREATE TEST2.COM
            $ASSIGN TEST.SOF FOR022
            $@NASTRAN TEST2.DT
            $EXIT

      $ SUBMIT/QUEUE=NASTRAN TEST2.COM

      The file NASTRAN.COM contains the command procedure for executing
      NASTRAN and the file TEST2.DT contains the NASTRAN data including the
      SOF declaration--SOF(1) = FT22,1000

SOFIN - Copy Items from File to SOF

Purpose

To copy substructure items from an external file to the SOF.

Request Format

         �          �                  �       �
SOFIN  ( � INTERNAL � )   filename  ,  � TAPE  �
         � EXTERNAL �                  � DISK  �
         �          �                  �       �

Subcommands

            �          �
POSITION =  � NOREWIND �
            � REWIND   �
            �          �
            �                   �
NAMES    =  � WHOLESOF          �
            � substructure name �
            �                   �
            �           �
            � ALL       �
            � MATRICES  �
ITEMS    =  � PHASE3    �
            � TABLES    �
            � item name �
            �           �

Definitions

EXTERNAL   File was written on a different computer type.

INTERNAL   File was written with GINO on the same computer type.

filename   Name of the external file. If the file is in INTERNAL format,
           filename must specify INPT, INP1,...,INP9. If the file is in
           EXTERNAL format, filename must specify a FORTRAN unit by using the
           form FORT1, FORT2,...,FORT32.

DISK       File is located on a direct access device.

TAPE       File is located on a tape.

POSITION   Specifies initial file position.

           REWIND:    file is rewound
           NOREWIND:  input begins at the current position

NAMES      Identifies a substructure for which data will be read. If
           NAMES=WHOLESOF is coded, and no other NAMES subcommands appear for
           the current SOFIN command, all substructure items found on the
           external file from the point specified by the POSITION subcommand
           to the end-of-file are copied to the SOF.

ITEMS      Identifies the data items which are to be copied to the SOF for
           each substructure specified by the NAMES subcommands.

           ALL: all items
           MATRICES: all matrix items
           PHASE3: the UVEC, QVEC, and SOLN items
           TABLES: all table items
           item name: name of an individual item

Remarks

1. Filename is required. The other SOFIN operands are optional.

2. All subcommands are optional.

3. The NAMES subcommand may appear up to five times for each SOFIN command.

4. If a substructure name of an item which is to be copied to the SOF does not
   exist on the SOF, it is added to the SOF. MDI pointers for higher level,
   combined substructures, and lower level substructures arc restored.

5. For the EXTERNAL form of this command all the items on the file are read in
   and added to the SOF. The POSITION subcommand should be specified as REWIND
   and user specifications for all other subcommands are ignored.

6. SOFOUT is the companion substructure command.

7. When an internal-formatted file is located on tape and extends over
   multiple reels, care should be taken when using the SOFIN command. The
   commands should be ordered so that all the desired data is retrieved on a
   single pass through the tape. The following suggestions are helpful:

   a. Order the SOFIN command to obtain data in the order they exist on the
      tape. If this order is not known, the CHECK command will list the
      contents of the tape.

   b. The first SOFIN command should specify POSITION = REWIND and all
      subsequent commands should use POSITION = NOREWIND.

   c. The individual items should be requested by name. The ALL, MATRICES,
      TABLES, or PHASE3 specification should not be used for the ITEMS
      subcommand unless all the appropriate items are on the tape. If some are
      not present, the tape will be searched to the end of the last reel and
      subsequent commands will not be executable because they will attempt to
      rewind back to the first tape.

8. On IBM computers and for the EXTERNAL form of this command, the following
   DD card should be used:

   //NS.FTxxF001 DD DSN=username,UNIT=2400-1,DISP=(,KEEP),
   //    LABEL=(,NL),DCB=(RECFM=FB,LRECL=132,BLKSIZE=3960,
   //    TRTCH=T,DEN=2)

9. Only one item may appear as an ITEMS subcommand per NAMES subcommand.
   Selective items may be referenced by repeating the NAMES subcommand.

SOFOUT - Copy Items from SOF to File

Purpose

To copy substructure items from the SOF to an external file.

Request Format

          �          �                  �       �
SOFOUT  ( � INTERNAL � )   filename  ,  � TAPE  �
          � EXTERNAL �                  � DISK  �
          �          �                  �       �

Subcommands

            �          �
POSITION =  � NOREWIND �
            � REWIND   �
            � EOF      �
            �          �
            �                   �
NAMES    =  � WHOLESOF          �
            � substructure name �
            �                   �
            �           �
            � ALL       �
            � MATRICES  �
ITEMS    =  � PHASE3    �
            � TABLES    �
            � item name �
            �           �

Definitions

EXTERNAL   File will be written so that it may be read on a different
           computer type.

INTERNAL   File will be written with GINO.

filename   Name of the external file. If the file is in INTERNAL format,
           filename must specify INPT, INP1,...,INP9. If the file is in
           EXTERNAL format, filename must specify a FORTRAN unit by using the
           form FORT1, FORT2,...,FORT32.

DISK       File is located on a direct access device.

TAPE       File is located on a tape.

POSITION   Specifies initial file position. (See Remark 6.)

           REWIND:    file is rewound
           NOREWIND:  output begins at the current position
           EOF:       file is positioned to the point immediately preceding
                      the end-of-file mark

NAMES      Identifies a substructure for which data will be read. If
           NAMES=WHOLESOF is coded, and no other NAMES subcommands appear for
           the current SOFOUT command, all substructure items found on the
           SOF are copied to the external file.

ITEMS      Identifies the data items which are to be copied to the external
           file for each substructure specified by the NAMES subcommands.

           ALL: all items
           MATRICES: all matrix items
           PHASE3: the UVEC, QVEC, and SOLN items
           TABLES: all table items
           item name: name of an individual item

Remarks

1. Filename is required. The other SOFOUT operands are optional.

2. All subcommands are optional.

3. The NAMES subcommand may appear up to five times for each SOFOUT command.

4. PLTS items of pseudostructures reference the PLTS items of the component
   basic substructures. Therefore, in order to save all data necessary to plot
   a pseudostructure, the PLTS items of its component basic substructures must
   be saved as well as the PLTS item of the pseudostructure.

5. For the external form of this command, POSITION = NOREWIND has the effect
   of positioning the file to the end-of-file.

6. POSITION = REWIND should be coded for the first write to a new file.

7. SOFIN is the companion substructure command.

8. On IBM computers and for the EXTERNAL form of this command, the following
   DD card should be used:

   //NS.FTxxF001 DD DSN=username,UNIT=2400-1,DISP=(,KEEP),
   //    LABEL=(,NL),DCB=(RECFM=FB,LRECL=132,BLKSIZE=3960,
   //    TRTCH=T,DEN=2)

9. Only one item may appear as an ITEMS subcommand per NAMES subcommand.
   Selective items may be referenced by repeating the NAMES subcommand.

SOFPRINT - Requests SOF File Verification

Purpose

To print selected contents of the SOF file for data checking purposes.

Request Format

SOFPRINT (opt) name, item1, item2, etc.

Subcommands

None.

Definitions

opt        Integer, control option, default = 0.

           opt =  1: prints data items only
           opt =  0: prints table of contents
           opt = -1: prints both

name       Name of substructure for which data is to be printed.

item1, item2  SOF item name, used only when opt not equal 0, limit = 5. (See 
           Table 1.10-19 in Section 1.10.2 for the list of item names.)

Remarks

1. If only the table of contents is desired (opt = 0) this command may be
   coded:

   SOFPRINT TOC

   On the page heading for the table of contents, the labels are defined as
   follows:

   SS   Secondary substructure number (successor)
   PS   Primary substructure number (predecessor)
   LL   Lower level substructure number
   CS   Combined substructure number
   HL   Higher level substructure number
   TYPE Substructure type
        B     basic substructure
        C     combined substructure
        R     Guyan reduced substructure
        M     real modal reduced substructure
        CM complex modal reduced substructure

   Any of the above types will have a prefix "I" if it is an image
   substructure resulting from an EQUIV operation.

SOLVE - Substructure Solution

Purpose

This command initiates the substructure solution phase. The tables and
matrices for the pseudostructure are converted to their equivalent NASTRAN
data blocks. The substructure grid points referenced on bulk data cards SPCS.
MPCS, etc., are converted to pseudostructure scalar point identification
numbers. The NASTRAN execution then proceeds as though a normal structure were
being processed.

Request Format

SOLVE name

Subcommands

None. (Case Control and bulk data decks control the operations.)

Definitions

name       Name of pseudostructure to be analyzed with NASTRAN.

Remarks

1. The allowable NASTRAN Rigid Formats are 1, 2, 3, 8, and 9.

2. Before requesting a SOLVE, you should check to be sure that all necessary
   matrices are available on the SOF file. For instance, loads and stiffness
   matrices are necessary in statics analysis. Mass and stiffness matrices are
   necessary in eigenvalue analysis, etc.

3. If the OPTIONS command has been used, an additional OPTIONS command may be
   necessary to ensure that the matrices required are available for the SOLVE
   operation.

4. Static load combinations of the original Phase 1 load vectors may be
   defined by the bulk data card LOADC. Loads of this type may be used in
   Rigid Format 9 (Direct Transient Analysis) in lieu of DAREA dynamic load
   data.

5. The SOLVE name command should always be followed by RECOVER name to assure
   the solution data are saved on the SOF.

6. The SOLVE command may only be used in Phase 2 executions.

SUBSTRUCTURE - Initiates the Substructure Control Data Deck

Purpose

This command initiates the processing for automated substructuring and defines
the phase of the analysis. It must be the first card in the Substructure
Control Deck.

Request Format

              �        �
              � PHASE1 �
SUBSTRUCTURE  � PHASE2 �
              � PHASE3 �
              �        �

Subcommands

NAME       name (required and valid only in PHASE1)

SAVEPLOTn (used only in PHASE1)

Definitions

name       The name assigned to the basic substructure which is being created
           in PHASE1.

n          The plot set identification used to define the set of elements and
           grid points to be saved in PHASE1 for subsequent plotting in
           PHASE2. Only one set may be defined for any basic substructure.

Remarks

1. The mode command RUN = STEP is assumed initially if the explicit command is
   not given immediately following the SUBSTRUCTURE command.

2. No further substructure commands are required for PHASE1.

3. Additional substructure commands are required for PHASE2.

4. For PHASE3 operations, RECOVER and BRECOVER are equivalent commands and one
   of them must be present.

5. Imbedded blanks within the individual elements of this card are not
   allowed. An unrecognizable command causes the program to automatically
   assume a PHASE2 solution.
