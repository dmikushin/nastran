
# 5.1  INTRODUCTION

   In addition to using the rigid formats provided automatically by NASTRAN,
you may wish to execute a series of modules in a different manner than
provided by a rigid format. Or he may wish to perform a series of matrix
operations which are not contained in any existing rigid format. If the
modifications to an existing rigid format are minor, the ALTER feature
described in Section 2 may be employed. Otherwise, a user-written Direct
Matrix Abstraction Program (DMAP) should be used.

   DMAP is the user-oriented language used by NASTRAN to solve problems. A
rigid format is basically a collection of statements in this language. DMAP,
like English or FORTRAN, has many grammatical rules which must be followed to
be interpretable by the NASTRAN DMAP compiler. Section 5.2 provides you with
the rules of DMAP, which will allow him to understand the rigid format DMAP
sequences, write ALTER packages, and construct his own DMAP sequences using
the many modules contained in the NASTRAN DMAP repertoire.

   Section 5.3 is an index of matrix, utility, user, and executive modules
which are contained in Sections 5.4 through 5.7 respectively.

   Sections 5.4 through 5.7 describe individually the many nonstructurally
oriented modules contained in the NASTRAN library. Section 5.8 provides
several examples of DMAP usage.

   User-written modules must conform to the rules and usage conventions
described herein.

   Section 5.8 illustrates the use of DMAP operations in both the standard
method (as rigid formats are written) and in the improved method.

   Section 5.9 describes the automatic ALTERs to a rigid format which result
from each of the automated multi-stage substructuring commands invoked by you.

   Section 5.10 contains descriptions and uses of functional modules which are
of general utility to you but have not been permanently incorporated into the
rigid formats.


5.2  DMAP RULES

   Grammatically, DMAP instructions consist of two types: Executive Operation
Instructions and Functional Module Instructions. Grammatical rules for these
two types of instructions will be discussed separately in following sections.

   Functional modules are arbitrarily classified as structural modules, matrix
operation modules, utility modules, or user-generated modules.

   The DMAP sequence itself consists of a series of DMAP instructions or
statements, the first of which is BEGIN or XDMAP and the last of which is END.
The remaining statements consist of Executive Operation instructions and
Functional Module calls.

## 5.2.1  DMAP Rules for Functional Module Instructions

   The primary characteristic of the Functional Module DMAP instruction is its
prescribed format. The general form of the Functional Module DMAP statement
is:

   MOD    I1,I2,...,Im/01,02,...,0n/a1,b1,p1/a2,b2,p2.../az,bz,pz  $

where MOD is the DMAP Functional Module name,
      Ii (i = 1,m) are the Input Data Block names,
      0i (i = 1,n) are the Output Data Block names, and
      ai,bi,pi (i = 1,z) are the Parameter Sections.

   In the general form shown above, commas (,) are used to separate several
like items while slashes (/) are used to separate sections from one another.
The module name is separated from the rest of the instruction by a blank or a
comma (,). The dollar sign ($) is used to end the instruction and is not
required unless the instruction ends in the delimiter /. A DMAP statement is
restricted to columns 1 through 72. Information beyond column 72 is ignored.
If the entire DMAP instruction does not fit on one card, the last delimiter
(not followed by a $ sign) causes the next card to be read as a continuation.
Thus, one DMAP instruction may occupy several cards. Blanks may be used in
conjunction with any of the above delimiters for ease of reading. If it is
desired to preserve the output alignment of the printed instructions, the
module name is begun in column 1 and the rest of the instruction is begun in
column 10 when supplying alters to a Rigid Format.

   A functional module communicates with other modules and the executive
system entirely through its inputs, outputs, and parameters. The
characteristics or attributes of each functional module are contained in the
Module Properties List (MPL) described in Section 2.4 of the Programmer's
Manual and are reflected in the DMAP Module Descriptions that follow in
Section 5.3 and in the Module Functional Descriptions contained in Chapter 4
of the Programmer's Manual. The module name is a BCD value (which consists of
an alphabetic character followed by up to seven additional alphanumeric
characters) and must correspond to an entry in the MPL. A Data Block name may
be either a BCD value or null. The absence of a BCD value indicates that the
Data Block is not needed for a particular application.

### 5.2.1.1  Functional Module DMAP Statements

   Each Functional Module DMAP statement must conform to the MPL regarding:

   1. Name spelling
   2. Number of input data blocks
   3. Number of output data blocks
   4. Number of parameters
   5. Type of each parameter

   NOTE: See Sections 5.2.1.3 and 5.2.1.4 for allowable exceptions to these
rules.

### 5.2.1.2  Functional Module Names

   The only Functional Module DMAP names allowed are those contained in the
MPL. Therefore, if you want to add a module, you must either use one of the
User Module names provided (see Section 5.6) or add a name to the MPL. The
Programmer's Manual should be consulted when adding a new module to NASTRAN.

### 5.2.1.3  Functional Module Input Data Blocks

   In most cases an input data block should have been previously defined in a
DMAP program before it is used. However, there may be instances in which a
module can handle, or may even expect, a data block that is undefined at the
time the module is initially called. An input data block is previously defined
if it appears as an output data block in a previous DMAP instruction, as
output from the Input File Processor, as any user-input (via Bulk Data Cards)
DMI or DTI data block name, or exists on the Old Problem Tape in a restart
problem. Although the number of data blocks is prescribed, if any number of
final data blocks are null, they may be omitted from the section. For example,
the module TABPT, which uses five input data blocks, may be defined by:

   TABPT   GEOM1,,,, //  $

or

   TABPT   GEOM1 //  $

A potentially fatal error message (see Section 5.2.1.7) will be issued at
compilation time to warn you that a discrepancy in the data block name list
has been detected. This is also true if a previously undefined data block is
used as input. Also, see the "error-level" option on the XDMAP compiler option
card, which you may invoke to terminate execution in the event of such errors.

### 5.2.1.4  Functional Module Output Data Blocks

   In general, a data block name will appear as output only once. However,
there are cases in which an output data block may be of no subsequent use in a
DMAP program. In such a case the name may be used again, but caution should be
used when employing such techniques. Although the number of output data blocks
is prescribed, the data block name list may be abbreviated in the manner of
Section 5.2.1.3. Potentially fatal error messages will warn you if possible
ambiguities may occur from these usages.

### 5.2.1.5  Functional Module Parameters

   Parameters may serve many purposes in a DMAP program. They may pass data
values into and out from a module, or they may be used as flags to control the
computational flow within the module or the DMAP program. There are two
allowable forms of the parameter section of the DMAP instruction. The first
explicitly states the attributes of the parameters, while the second is a
briefer simplified specification. The general form of the formal parameter
section is:

   / ai,bi,pi /

where the allowable parameter specifications are:

   ai = V     Parameter value is variable and may be changed by the module
              during execution.

   ai = C     Parameter value is prescribed initially by you and is an
              unalterable constant.

   ai = S     Parameter is of type V, and will be saved automatically at
              completion of module. (See description of the SAVE
              instruction.)

   bi = Y     Initial parameter value may be specified on a PARAM Bulk Data 
              card. 

   bi = N     Initial parameter value may not be specified on a PARAM Bulk
              Data card.

   pi = PNAME = v or pi = PNAME or pi = v  PNAME is a BCD name selected by you
              to represent a given parameter.

   The default values for ai and bi depend on the value given for pi, as
described below. The three forms available for pi require additional
clarification. The symbol "v" represents an actual numeric value for the
parameter and may be used only when ai = C and bi = N. The other forms will be
clarified by the examples found at the end of this section. Each parameter has
an initial value which is established when the DMAP sequence is compiled
during execution of the NASTRAN preface. The means by which initial values are
established for all DMAP parameters will be explained by the symbolic examples
that follow. The value used at execution time may differ from the initial
value if and only if the module changes the value, if ai = "V", and if the
parameter name appears in a SAVE (see Section 5.7) instruction immediately
following the module.

   The formal parameter specifications defined above can, in frequently
encountered instances, be greatly simplified. Situations where these
simplifications may be used are:

   1. / C,N,v /  can be written as  / v

   The value "v" is written exactly as it would be in the formal specification
   with the exception of BCD constant parameters, in which case the BCD string
   is enclosed by asterisks, that is, / *STRING* /.

   2. / V,N,PNAME /  can be written as  / PNAME /
      / V,N,PNAME=v /  can be written as  / PNAME=v /

   Again, in the case where the value "v" appears, it is written exactly as in
   the case of the formal specification. In this case, BCD strings are not
   delimited by asterisks.

   3. / (default value) /  can be written as  //

   If a particular parameter has a predefined default value specified in the
   Module Properties List (MPL), and you want to choose this value, then it is
   necessary only to code successive slashes. If a parameter does not have a
   default value, an error message will be issued.

   Six parameter types are available and the type of each parameter is given
in the MPL and may not be changed. The types and examples of values as they
would be written in DMAP are given below:

   PARAMETER TYPE                 VALUE Examples
--------
   Integer                        7        -2          0
   Real                          -3.6       2.4+5      0.01-3
   BCD                            VAR01     STRING3    B3R56
   Double Precision               2.5D-3    1.354D7
   Complex Single Precision       (1.0,-3.24)
   Complex Double Precision       (1.23D-2,-3.67D2)

   Many possible forms of the parameter section may be used. The following
examples will help to clarify the possibilities.

//         This is equivalent to  / C,N,v /  where v is the MPL default value
           which must exist.

/ C,Y,v       Constant input parameter

           Examples: / C,N,0 / C,N,BKL0 / C,N,(1.0,-1.0)
                                   or
                     / 0 / *BKL0* / (1.0,-1.0)

           In the examples shown, both in formal and simplified form, the
           values 0 (integer), BKL0 (BCD), and 1.0-i1.0 (complex single
           precision) are defined.

/ C,Y,PNAMEConstant input parameter; MPL default value is used unless a PARAM
           Bulk Data card referencing PNAME is present. Error condition is
           detected if either no PARAM card is present or no MPL default
           value exists.

/ C,Y,PNAME=v  Constant input parameter; the value v is used unless a PARAM 
           Bulk Data card referencing PNAME is present.

/ V,Y,PNAME or V,Y,PNAME=v  Variable parameter; may be input, output, or both;
           initial value is the first of

              1. value from the most recently executed SAVE instruction, if
              any

              2. value from PARAM Bulk Data card referencing PNAME will be
              used if present in Bulk Data Deck

              3. v, if present in DMAP instruction

              4. MPL default value, if any

              5. 0

           If a parameter is output from a functional module and if the
           output value is to be carried forward, a SAVE instruction must
           immediately follow the DMAP instruction in which the parameter is
           generated.

/ V,N,PNAME or / PNAME or / V,N,PNAME=v or /PNAME=v  Variable parameter; may
be input, output, or both; initial value is the first of

              1. value from the most recently executed SAVE instruction, if
              any

              2. v, if present in DMAP instruction

              3. MPL default value, if any

              4. 0

### 5.2.1.6  DMAP Compiler Options - The XDMAP Instruction (see Section 5.7)

   You can elect several options when compiling and executing a DMAP program
by including an XDMAP compiler option instruction in the program. Similarly,
the Rigid Formats may be altered by replacing the BEGIN statement with XDMAP
to invoke the same options. The available options are:

GO (default) or NOGO

The GO option compiles and executes the program, while NOGO terminates the job
at the conclusion of compilation.

LIST or NOLIST

The LIST option produces a DMAP program source listing. See the description of
the XDMAP card in Section 5.7 for the default values for this option.

DECK or NODECK (default)

The DECK option produces a punched card deck of the program.

OSCAR or NOOSCAR (default)

If the OSCAR option is selected, a complete listing of the Operation Sequence
Control Array is produced.

REF or NOREF (default)

The REF option produces a complete cross reference listing of variable
parameters, data block names, and module calls for the DMAP program.

ERR=0 or 1 or 2 (default)

This option specifies the error level at which termination of the job will
occur, 0 for WARNING, 1 for POTENTIALLY FATAL, and 2 for FATAL ERROR MESSAGE.
See Section 5.2.1.7 for further explanation.

The complete description of the XDMAP card may be found in Section 5.7,
dealing with Executive Operation Modules. Note that an XDMAP card need not
appear when all default values are elected, but may be replaced with a BEGIN
instruction.

### 5.2.1.7  Extended Error Handling Facility

   There are three levels of error messages generated during the compilation
of a DMAP sequence. These levels are WARNING MESSAGE, POTENTIALLY FATAL ERROR
MESSAGE, and FATAL ERROR MESSAGE. You have, through available compiler
options, the ability to specify the error level at which the job will be
terminated. (See Section 5.2.1.6 for the manner of specification.) The class
of POTENTIALLY FATAL ERROR MESSAGES is generated by certain compiler
conveniences which, if not fully understood by you, could cause an erroneous
or incorrect execution of the DMAP sequence. The default value for the error
level is that of the FATAL ERROR MESSAGE.

## 5.2.2  DMAP Rules for Executive Operation Instructions

   Each executive operation statement has its own format which is generally
open-ended, meaning the number of inputs, outputs, etc. is not prescribed.
Executive operation instructions or statements are divided into general
categories as follows:

   1. Declarative instructions FILE, BEGIN, LABEL. XDMAP, and PRECHK which aid
      the DMAP compiler and the file allocator as well as provide user
      convenience.

   2. Instructions CHKPNT, EQUIV, PURGE, and SAVE which aid the NASTRAN
      Executive System in allocating files, interfacing between functional
      modules, and in restarting a problem.

   3. Control instructions REPT, JUMP, COND, EXIT, and END which control the
      order in which DMAP instructions are executed.

The rules associated with the executive operation instructions are distinct
for each instruction and are discussed individually in Section 5.7.

## 5.2.3  Techniques and Examples of Executive Module Usage

   Even though the DMAP program may be interpretable by the DMAP compiler this
does not guarantee that the program will yield the desired results. Therefore,
this section is provided to acquaint you with techniques and examples used in
writing DMAP programs. In particular, the instructions REPT, FILE, EQUIV,
PURGE, and CHKPNT will now be discussed in some detail. The DMAP modules
available are listed in Section 5.3.

   The new DMAP user should read Sections 5.4 through 5.7 to obtain the
necessary knowledge of terminology before reading this section.

   The data blocks and functional modules referenced in the following examples
are fictitious and have no relationship to any real data blocks or functional
modules.

   A data block is described as having a status of "not generated",
"generated", or "purged." A status of not generated means that the data block
is available for generation by appearing as output in a functional module. A
status of generated means that the data block contains data which is available
for input to a subsequent module. A status of purged means that the data block
cannot be generated and any functional module attempting to use this data
block as input or output will be informed that the purged data block is not
available for use.

### 5.2.3.1  The REPT and FILE Instructions (see Section 5.7)

   The DMAP instructions bounded by the REPT instruction and the label
referenced by the REPT instruction are referred to as a loop. The location
referenced by the REPT is called the top of the loop. In many respects a DMAP
loop is like a giant functional module since it requires inputs and generates
output data blocks which usually can be handled correctly by the file
allocator (see Section 4.9 of the Programmer's Manual) without any special
action by you. The one exception is a data block that is not referenced
outside the loop (that is, an internal data block with respect to the loop).
The file allocator considers internal data blocks as scratch data blocks to be
used for the present pass through the loop but not to be saved for input at
the top of the loop. To save an internal data block, declare the data block
SAVE in the FILE instruction.

   When the REPT instruction transfers control back to the top of the loop,
the status of all internal data blocks is changed to "not generated" unless
the internal data block is declared SAVE or APPEND in a FILE instruction. It
should also be noted that equivalences established between internal data
blocks (not declared saved) and data blocks referenced outside the loop are
not carried over for the next time through the loop. The equivalence must be
re-established each time through the loop. Data blocks generated by the Input
File Processor are considered referenced outside of all DMAP loops.

Example Using REPT and FILE Instructions

      +
      | BEGIN     $
      | FILE      X=SAVE / Y=APPEND / Z=APPEND $
      | LABEL     L1 $
      | MOD1      B/W,Y $
      | COND      L3,PX $
DMAP  | MOD2      A/X/V,N,PX=0 $
loop  | SAVE      PX $
      | LABEL     L3 $
      | MOD3      W,X,Y/Z $
      | REPT      L1,1 $
      | MOD4      Z// $
      | END       $
      +

   Assume that MOD2 sets PX < 0 when it is executed. Note that Z is declared
APPEND, whereas Y will be saved since it is an internal data block that is to
be appended. X is an internal data block that is to be saved since it will
only be generated the first time through the loop but is needed as input each
time the loop is repeated. W is an internal data block that is generated each
time through the loop; therefore, it is not saved.

   The following table shows what happens when the above DMAP program is
executed. Only modules being executed are shown in the table. Data blocks A
and B are assumed to be generated by the Input File Processor, and hence are
considered referenced outside of all DMAP loops.

Module      Input status                   Output status and comments
being       and comments
executed

  MOD1      B - assumed generated by       W, Y - generated
            the input file processor

  COND      PX is 0                        No transfer occurs since PX >= 0

  MOD2      A - assumed generated by       X - generated
            the input file processor       PX is set < 0

  SAVE      PX < 0                         The value created above is saved for
                                           subsequent use.

  MOD3      W, X, Y are all generated      Z  - generated
            at this point

  REPT      Loop count is                  Transfer to L1 - set loop count to 1-
            initially set to 1             1=0. Status of data blocks at top of
                                           loop will be: A, B, Z - generated
                                           (referenced outsIde loop) X, Y -
                                           generated (internal data blocks
                                           declared saved) W - not generated
                                           (internal data block)

  MOD1      B - generated                  W - generated
                                           Y - generated (appended)

  COND      PX is now < 0 due to           Transfer to L3 occurs
            SAVE

  MOD3      W, X, Y - generated            Z  - generated (appended)

  REPT      Loop count is now 0            No transfer occurs.

  MOD4      Z - generated                  Output to printer (assumed)

  END                                      Normal termination of problem.

### 5.2.3.2  The EQUIV Instruction (see Section 5.7)

   There are no restrictions on the status of data blocks referenced in an
EQUIV instruction. Consider the instruction EQUIV A,B1,...,BN/P $ when P < 0.
Data blocks B1,...,BN take on all the characteristics of data block A
including the status of A. This means the status of some Bj can change from
purged to generated or not generated.

   The EQUIV instruction will unequivalence data blocks when P >= 0. In an
unequivalence operation, the status of all secondary data blocks reverts to
not generated.

   Suppose A, B, and C are all equivalenced and P >= 0. EQUIV A,B/P $ will
break the equivalence between A and B but not between A and C.

   Now consider the following situation. Data block B is to be generated by
repeatedly executing functional module MOD2. The input to MOD2 is the previous
output from MOD2. That is to say, each successive generation of B depends on
the previous B generated. The following example shows how the EQUIV
instruction is used to solve this problem. Assume parameter BREAK >= 0 and
parameter LINK < 0.

Example of EQUIV Instruction

         BEGIN     $
         MOD1      A/B  $
      +  LABEL     L1  $
DMAP  |  EQUIV     B,BB/BREAK  $
loop  |  MOD2      B/BB  $
      |  EQUIV     BB,B/LINK  $
      +  REPT      L1,1  $
         MOD3      BB//  $
         END

   The following table shows what happens when the above DMAP program is
executed. Only modules being executed are shown in the table.

Module      Input status                   Output status and comments
being       and comments
executed

  MOD1      A - assumed generated by       B - generated
            input processor

  EQUIV     B will not be equivalenced     No action taken
            to BB since BREAK >= 0

  MOD2      B - generated                  BB  - generated

  EQUIV     BB and B are not               B is equivalenced to BB. That is,
            equivalenced.                  B assumes all of the characteristics
            B - generated                  of BB. B and BB then both have the
            BB - generated                 status of generated.
            LINK < 0.

  REPT      Loop count is                  Transfer to L1; set loop count to
            initially 1                    1-1=0.

  EQUIV     B and BB are generated         The equivalence is broken;
            and equivalenced.              B - generated, BB - not generated
            BREAK >= 0.

  MOD2      B - generated                  BB - generated

  EQUIV     BB and B are generated         B equivalenced to BB; B, BB
            and not equivalenced.          - generated
            LINK < 0.

  REPT      Loop count is 0                No transfer occurs.

  MOD3      BB - generated                 Output to printer (assumed)

  END                                      Normal termination of problem.

   Since equivalences are automatically broken between internal files (not
declared saved) and files referenced outside the loop, the above DMAP program
could be written as follows and the same results achieved.

         BEGIN     $
         MOD1      A/B  $
      +  LABEL     L1  $
DMAP  |  MOD2      B/BB  $
loop  |  EQUIV     BB,B/LINK  $
      +  REPT      L1,1  $
         MOD3      B//  $
         END

Data block BB is now internal; therefore, the instruction EQUIV B,BB/BREAK $
is not needed.

### 5.2.3.3  The PURGE Instruction (see Section 5.7)

   The status of a data block is changed to purged by explicitly or implicitly
purging it. A data block is explicitly purged through the PURGE instruction,
whereas it is implicitly purged if it is not created by the functional module
in which it appears as an output.

   The primary purpose of the PURGE instruction is to prepurge data blocks.
Prepurging is the explicit purging of a data block prior to its appearance as
output from a functional module. Prepurging data blocks allows the NASTRAN
executive system to allocate available files more efficiently, which decreases
problem execution time. You should look for data blocks that can be prepurged
and purge them as soon as it is recognized that they will not be generated.

   Sometimes during the execution of a problem it is necessary to generate a
data block whose status is purged. This situation can occur both in DMAP
looping and in a modified restart situation. In order to generate a data block
that is purged it is first necessary to unpurge it (that is, change its status
from purged to not generated). Unpurging is achieved by executing a PURGE
instruction which references the purged data block and whose purge parameter
is positive.

   The PURGE instruction thus has two functions, to unpurge as well as purge
data blocks, depending on the value of the purge parameter and the status of
the referenced data block. The following table shows what action is taken by
the PURGE instruction for all combinations of input.

                             PURGE A/P  $

Status of data block   Value of P   Status of Data block
A prior to PURGE                    A after PURGE

Not generated          P >= 0       Not generated (that is, no action taken)
Not generated          P < 0        Purged

Generated              P >= 0       Generated (that is, no action taken)
Generated              P < 0        Purged

Purged                 P >= 0       Not generated (that is, unpurged)
Purged                 P < 0        Purged (that is, no action taken)

   You may wonder why you should not prepurge all data blocks and then unpurge
them when necessary in order to really assist the file allocator. The reason
not to do this is that there is a limited amount of space in the table where
the status of data blocks is kept. This table may overflow if too many data
blocks are purged at one time. Therefore, only prepurge those data blocks that
can truly be prepurged.

Example of Explicit and Implicit Purging and Prepurging

BEGIN     $
MOD1      IP/A/V,Y,PX/V,Y,PY/V,Y,PB  $
SAVE      PX,PY,PB  $
PURGE     X/PX / Y/PY  $
MOD2      A/B,C,D/V,Y,PB/V,Y,PC  $
SAVE      PC  $
PURGE     C/PC  $
MOD3      B,C,D/E  $
MOD4      E/X,Y,Z  $
MOD5      X,Y,Z//  $
END       $

Assume that module MOD1 sets PX < 0, PY >= 0 and PB = 0. Assume that B is not
generated by MOD2 if PB = 0. Assume that MOD2 sets PC < 0, but does not change
PB.

   The following table shows what happens when the above DMAP program is
executed. Only modules being executed are shown in the table.

Module      Input status                   Output status and comments
being       and comments
executed

MOD1        IP - assumed generated         A - generated
            by the input file              PX < 0, PY >= 0, PB = 0
            processor

SAVE        PX < 0, PY >= 0,               Parameter values are saved for use
            PB = 0                         in subsequent modules.

PURGE       X,Y - not generated            X - purged (that is, prepurged)
            PX < 0, PY >= 0                Y - not generated

MOD2        A - generated; PB = 0          B  - purged (that is, implicitly);
                                           C, D - generated; PC  0.

SAVE        PC < 0                         PB value not saved since MOD2 did
                                           not reset it.

PURGE       C - generated                  C - purged
            PC < 0

MOD3        B, C  - purged                 E - generated
            D - generated

MOD4        E - generated                  X - purged; Y - generated;
                                           Z - generated

MOD5        X - purged                     Output to printer (assumed)
            Y, Z - generated

END                                        Normal termination of problem.

Example of Unpurging

         BEGIN    $
         FILE     X=SAVE/Y=SAVE  $
         FILE     Z=APPEND $
         MOD1     IP/A  $
       + LABEL    L1  $
       | COND     L2,NPX  $
       | PURGE    X/NPX  $
       | MOD2     A/X,Y/V,Y,PX=0/V,N,NPX=0 $
DMAP   | SAVE     PX,NPX $
loop   | PURGE    X/PX  $
       | LABEL    L2  $
       | MOD3     X,Y/Z  $
       + REPT     L1,2  $
         MOD4     Z// $
         END      $

Assume that MOD2 sets PX < 0 and NPX >= 0 the first time it is executed.
Assume that MOD2 sets PX >= 0 and NPX < 0 the second time it is executed.

   The following table shows what happens when the above DMAP program is
executed. Only modules being executed are shown in the table.

Module      Input status                   Output status and comments
being       and comments
executed

MOD1        IP - assumed generated by      A - generated
            input file processor.

COND        NPX = 0                        Jump not executed

PURGE       X - not generated              X - not generated (that is, no action
                                           taken)

MOD2        A - generated                  X,  Y - generated; PX < 0, NPX >= 0

SAVE        PX < 0, NPX >= 0

PURGE       X  - generated; PX < 0         X  - purged

MOD3        X - purged;                    Z - generated
            Y - generated

REPT        Loop count = 2                 Transfer to location L1;
                                           loop count = 1

COND        NPX >= 0                       Jump not executed

PURGE       X - purged; NPX >= 0           X - not generated (that is, unpurged)

MOD2        A - generated                  X - generated; Y - generated (note
                                           old data for Y is lost because Y not
                                           Appended); PX >= 0, NPX <0

SAVE        PX >= 0, NPX < 0

PURGE       X - generated; PX >= 0         X - generated (that is, no action
taken)

MOD3        X,Y - generated                Z - generated (note new data appended
                                           to old because Z declared appended)

REPT        Loop count = 1                 Transfer to location L1;
                                           loop count = 0

COND        NPX < 0                        Transfer to location L2

MOD3        X, Y - generated               Z - generated (that is, appended)

REPT        Loop count = 0                 Fall through to next instruction

MOD4        Z - generated                  Output to printer (assumed)

END                                        Normal termination of problem

5.2.3.4  The CHKPNT Instruction (see Section 5.7)

   The CHKPNT instruction provides you with a means for saving data blocks for
subsequent restart of your problem with a minimum amount of redundant
processing. The following rules will assure you of the most efficient restart.

   1. Checkpoint all output data blocks from every functional module.

   2. Checkpoint all data blocks mentioned in a PURGE instruction.

   3. Checkpoint all secondary data blocks in an EQUIV instruction. Never
      checkpoint primary data blocks in an EQUIV instruction.

   4. Checkpoint all data blocks mentioned above as soon as possible.

Example of Checkpointing

BEGIN   $
MOD1    A/B,C/S,Y,P1/S,Y,P2 $
CHKPNT  B,C $
PURGE   X,Y/P1 / Z/P2 $
CHKPNT  X,Y,Z $
EQUIV   B,BB/P1 / C,CC,D/P2 $
CHKPNT  BB,CC,D $
 :
 :
END     $

In the example above, the data blocks were checkpointed as soon as possible,
which is the most straightforward way, but it required three calls to the
checkpoint module, which increases problem execution time. Since checkpointing
usually requires a small fraction of the total execution time, the most
straightforward method is recommended to avoid trouble.

   The rigid format DMAP sequences (see Volume II) do not employ any explicit
CHKPNT instructions. Instead, for the sake of efficiency, each rigid format
includes a single PRECHK ALL instruction towards the beginning of the DMAP
sequence. (See Section 5.7 for the description of the PRECHK DMAP
instruction.) In keeping with the four rules mentioned above, the PRECHK ALL
instruction immediately and automatically CHKPNTs all output data blocks from
each functional module, all data blocks mentioned in each PURGE instruction,
and all secondary data blocks in each EQUIV instruction. The only exceptions
to this are the CASESS, CASEI, and CASECC data blocks appearing as output in
substructure analyses.


# 5.3  INDEX OF DMAP MODULE DESCRIPTIONS

   Descriptions of all nonstructurally oriented modules are contained herein,
arranged alphabetically by category as indicated by the lists below.
Descriptions for the structurally oriented modules are contained in Section 4
of the Programmer's Manual. They are listed here in order to provide a
complete list of all NASTRAN modules. Additional information regarding
nonstructurally oriented modules is also given in Section 4 of the
Programmer's Manual. 

     Matrix Operation Modules (16)          Utility Modules (33)
     (See Section 5.4)                      (See Section 5.5)

     ADD            MPY3                    COPY           OUTPUT4
     ADD5           PARTN                   DATABASE       OUTPUT5
     DECOMP         SDCMPS                  GINOFILE       PARAM  
     DIAGONAL       SMPYAD                  INPUT          PARAMD
     FBS            SOLVE                   INPUTT1        PARAML
     MATGEN         TRNSP                   INPUTT2        PARAMR
     MERGE          UMERGE                  INPUTT3        PRTPARM
     MPYAD          UPARTN                  INPUTT4        SCALAR 
                                            INPUTT5        SEEMAT 
                                            LAMX           SETVAL 
                                            MATGPR         SWITCH 
                                            MATPRN         TABPCH 
                                            MATPRT         TABPRT 
                                            NORM           TABPT  
                                            OUTPUT1        TIMETEST
                                            OUTPUT2        VEC
                                            OUTPUT3

     User Modules (11)                      Executive Operation Modules (16)
     (See Section 5.6)                      (See Section 5.7)

     DDR            MODA                    BEGIN          FILE
     DUMMOD1        MODB                    CHKPNT         JUMP
     DUMMOD2        MODC                    COMPOFF        LABEL
     DUMMOD3        OUTPUT                  COMPON         PRECHK
     DUMMOD4        XYPRNPLT                COND           PURGE
     DUMMOD5                                END            REPT
                                            EOUIV          SAVE
                                            EXIT           XDMAP


     Substructure DMAP ALTERs (22)          Supplementary Functional Modules (2)
     (See Section 5.9)                      (See Section 5.10)

     BRECOVER       PLOT                    EMA1           GPSPC
     CHECK          RECOVER
     COMBINE        REDUCE
     CREDUCE        RENAME
     DELETE         RESTORE
     DESTROY        RUN
     DUMP           SOFIN
     EDIT           SOFOUT
     EQUIV          SOFPRINT
     MRECOVER       SOLVE
     MREDUCE        SUBSTRUCTURE


                 Structurally Oriented Functional Modules (122)
                   (See Section 4 of the Programmer's Manual)

     ADR                 EQMCK               MRED1              SDRHT
     ALG                 EXIO                MRED2              SDR1
     AMG                 FA1                 MTRXIN             SDR2
     AMP                 FA2                 NRLSUM             SDR3
     ANISOP              FLBMG               OFP                SGEN
     APD                 FRLG                OPTPR1             SITEPLOT
     APDB                FRRD                OPTPR2             SMA1
     BMG                 FRRD2               PLA1               SMA2
     CASE                FVRSTR1             PLA2               SMA3
     CASEGEN             FVRSTR2             PLA3               SMP1
     CEAD                GENCOS              PLA4               SMP2
     CMRED2              GENPART             PLOT               SOFI
     COMBUGV             GFSMA               PLTHBDY            SOFO
     COMB1               GI                  PLTMRG             SOFUT
     COMB2               GKAD                PLTSET             SSGHT
     CURV                GKAM                PLTTRAN            SSG1
     CYCT1               GPCYC               PROLATE            SSG2
     CYCT2               GPFDR               PROMPT1            SSG3
     DDAMAT              GPSP                PRTMSG             SSG4
     DDAMPG              GPWG                RANDOM             SUBPH1
     DDRMM               GP1                 RBMG1              TA1
     DDR1                GP2                 RBMG2              TRAILER
     DDR2                GP3                 R8MG3              TRD
     DESVEL              GP4                 RBMG4              TRHT
     DPD                 GUST                RCOVR              TRLG
     DSCHK               IFT                 RCOVR3             VARIAN
     DSMG1               LOADPP              READ               VDR
     DSMG2               MAGBDY              REDUCE             XYPLOT
     EMA                 MCE1                RMG                XYTRAN
     EMFLD               MCE2                SCAN
     EMG                 MODACC              SCE1


   In the examples that accompany each description, the following notation is
used: 

   1. Upper case letters and special symbols in the DMAP calling sequence must
      be punched as shown except for data block names, parameter names, and
      label names, which are symbolic. 

   2. Lower case letters represent constants whose permissible values are
      indicated in the descriptive text. 

   Due to the many possible forms which may be used when writing parameters, a
variety of arbitrarily selected forms will be used in the examples. This does
not imply that the form used in any example is required or that it is the only
acceptable form allowed. 

   The terms "form", "type", and "precision" are used in many functional
module descriptions. By form is meant one of the following: 

   Form    Meaning

   1       Square matrix
   2       Rectangular matrix
   6       Symmetric matrix

By type is meant one of the following:

   Form    Meaning

   1       Real, single precision
   2       Real, double precision
   3       Complex, single precision
   4       Complex, double precision

By precision is meant one of the following:

   Precision IndicatorMeaning

        1        Single precision numbers
        2        Double precision numbers


# 5.4  MATRIX OPERATION MODULES

Module                   Basic Operation                        Page

ADD           [X] = a[A] + b[B]                                5.4-2

ADD5          [X] = a[A] + b[B] + c[C] + d[D] + e[E]           5.4-4

DECOMP        [A] => [L][U]                                    5.4-5


DIAGONAL      Generate a diagonal matrix from a given matrix   5.4-6
              (except rectangular and row vector)

                                -1
FBS           [X] = +/- ([L][U])   [B]                         5.4-7

MATGEN        Generate certain kinds of matrices               5.4-?

                      +           +
                      | A11 | A12 |
MERGE         [A] <=  | ----+---- |                            5.4-8
                      | A21 | A22 |
                      +           +
                                                 T
MPYAD         [X] = +/- [A][B] +/- [C] or +/- [A] [B] +/- C   5.4-10

                       T                 T
MPY3          [X] = [A] [B][A] + [C], [A] [B] + [C] or        5.4-12
              [B][A] + [C]

                      +           +
                      | A11 | A12 |
PARTN         [A] =>  | ----+---- |                           5.4-13
                      | A21 | A22 |
                      +           +

SDCMPS        [A] => [L][U]                                   5.4-17

SMPYAD        [X] = [A][B][C][D][E] +/- [F]                   5.4-20

                           -1
SOLVE         [X] = +/- [A]   [B]                             5.4-22

                       T
TRNSP         [X] = [A]                                       5.4-23
                         +      +
                         | PHIA |
UMERGE        {PHIF} <=  | ---- |                             5.4-24
                         | PHIO |
                         +      +

                        +           +
                        | Kjj | Kjl |
UPARTN        [K  ] =   | ----+---- |                         5.4-26
                ii      | Klj | Kll |
                        +           +

ADD - Matrix Add

Purpose
-------
To compute [X] = a[A] + b[B] where a and b are scale factors.

DMAP Calling Sequence
---------------------
ADD   A,B / X / C,Y, ALPHA=(1.0,2.0)     / C,Y, BETA=(3.0,4.0)
              / C,Y,DALPHA=(5.D+0,6.D-1) / C,Y,DBETA=(7.D+2,8.D-3)  $

Input Data Blocks
-----------------
A       Any GINO matrix.
B       Any GINO matrix.

Output Data Blocks
------------------
X       Matrix.

Parameters
----------
ALPHA   Input-complex-single precision. This is the scalar multiplier for
        [A]. (See Remark 7 for default if DALPHA is purged.)

BETA    Input-complex-single precision. This is the scalar multiplier for
        [B]. (See Remark 7 for default if DBETA is purged.)

DALPHA  Input-complex-double precision. This is the scalar multiplier for
        [A]. (See Remark 7 for default if ALPHA is purged.)

DBETA   Input-complex-double precision. This is the scalar multiplier for
        [B]. (See Remark 7 for default if BETA is purged.)

Subroutines

DADD

Method
------
The parameters are checked. If [A] is not purged, the number of columns, rows,
and form of [X] are set to those of [A]. Otherwise the [B] descriptors are
used. The flags for the type of [X] (see Remark 2) and multiply-add operations
are set before calling subroutine SADD, which performs the actual scalar
multiplication and matrix addition.

Remarks
-------
1.Matrix [A] and/or matrix [B] may be purged, in which case the corresponding
term in the matrix sum will be assumed null. The input data blocks must be
unique.

2.Matrix [X] cannot be purged. The type of [X] is maximum of the types of
[A], [B], a, b. The size and shape of [X] are the size and shape of [A] if
[A] is present. Otherwise they are those of [B].

3.The use of double precision parameters DALPHA and DBETA will force the
matrix multiply-and-add operation to be performed in double precision
unconditionally. The single precision ALPHA and BETA may cause the
multiply-and-add operation to be performed in single precision or in double
precision depending on the matrix original precision types.

4.Either the DALPHA-DBETA pair or the ALPHA-BETA pair is used. They cannot be
mixed; that is, DALPHA-BETA pair is illegal; so is DALPHA-ALPHA.

5.If Im(ALPHA or DALPHA) or Im(BETA or DBETA) is zero, the corresponding
parameter will be considered real.

6.Matrix [X] is put into complex form if any one of the [A], [B], ALPHA,
BETA, DALPHA, or DBETA is complex.

7.The defaults are ALPHA = (1.0,0.0) if DALPHA is purged, and BETA =
(1.0,0.0) if DBETA is purged. ALPHA and DALPHA cannot both be specified;
neither can BETA and DBETA.

ADD5 - Matrix Add
=================

Purpose
-------
To compute [X] = a[A] + b[B] + c[C] + d[D] + e[E] where a, b, c, d, and e are
scale factors.

DMAP Calling Sequence
---------------------
ADD5 A,B,C,D,E / X / C,Y,ALPHA=(1.0,2.0) / C,Y,BETA=(3.O,4.O) /
                     C,Y,GAMMA=(5.0,6.0) / C,Y,DELTA=(7.0,8.0) /
                     C,Y,EPSLN=(9.0,1.0) $

Input Data Blocks
-----------------
A, B, C, D, and E must be distinct matrices.

NOTE: Any of the matrices may be purged, in which case the corresponding term
in the matrix sum will be assumed null. The input data blocks must be unique.

Output Data Blocks
------------------
X       Matrix.

The type of [X] is maximum of the types of A, B, C, D, E, a, b, c, d, e. The
size of [X] is the size of the first nonpurged input.

NOTE: [X] cannot be purged.

Parameters
----------
ALPHA   Input-complex-single precision, default = (1.0, 0.0). This is a,
        the scalar multiplier for [A].

BETA    Input-complex-single precision, default = (1.0, 0.0). This is b,
        the scalar multiplier for [B].

GAMMA   Input-complex-single precision, default = (1.0, 0.0). This is c,
        the scalar multiplier for [C].

DELTA   Input-complex-single precision, default = (1.0, 0.0). This is d,
        the scalar multiplier for [D].

EPSLN   Input-complex-single precision, default = (1.0, 0.0). This is e,
        the scalar multiplier for [E].

NOTE: If Im(ALPHA), Im(BETA), Im(GAMMA), Im(DELTA), or Im(EPSLN) = 0.0, the
corresponding parameter will be considered real.

DECOMP - Matrix Decomposition
=============================

Purpose
-------
To decompose a square matrix [A] into upper and lower triangular factors [U]
and [L].

[A]  =>  [L][U]

DMAP Calling Sequence
---------------------
DECOMP   A / L,U / V,Y,KSYM / V,Y,CHOLSKY / V,N,MINDIAG / V,N,DET /
             V,N,POWER / V,N,SING $

Input Data Blocks
-----------------
A       A square matrix.

Output Data Blocks
------------------
L       Nonstandard lower triangular factor of [A].
U       Nonstandard upper triangular factor of [A].

Parameters
----------
KSYM    Input-Integer, default = 0. 1, use symmetric decomposition. 0, use
        unsymmetric decomposition.

CHOLSKY Input-Integer, default = 0. 1, use Cholesky decomposition - matrix
        must be positive definite. 0, do not use Cholesky decomposition.

MINDIAG Output-Real double precision, default = 0.0D0. The minimum
        diagonal term of [U].

DET     Output-complex single precision, default = 0.0D0. The scaled value
        of the determinant of [A].

POWER   Output-Integer, default = 0. Integer POWER of 10 by which DET
        should be multiplied to obtain the determinant of [A].

SING    Output-Integer, default = 0. SING is set to -1 if [A] Is singular.

Remarks
-------
1.Non-standard triangular factor matrix data blocks are used to improve the
efficiency of the back substitution process in module FBS. The format of
these data blocks is given in Section 2 of the Programmer's Manual.

2.The matrix manipulating utility modules should be cautiously employed when
dealing with non-standard matrix data blocks.

3.If the CHOLSKY option is selected, the resulting factor (which will be
written as [U]) cannot be input to FBS.

4.Variable parameters output from functional modules must be SAVEd if they
are to be subsequently used. See the Executive Module SAVE description.

DIAGONAL - Strip Diagonal From Matrix
=====================================
Purpose
-------
To remove the real part of the diagonal from a matrix, raise each term to a
specified power, and output a column vector, a square symmetric matrix, or a
diagonal matrix.

DMAP Calling Sequence
---------------------
DIAGONAL A/B/C,Y,OPT=COLUMN/V,Y,POWER=1. $

Input Data Blocks
-----------------
A       Can be any square or diagonal matrix.

Output Data Blocks
------------------
B       Either a real column vector, a symmetric matrix, or a diagonal
        matrix containing the diagonal of A.

Parameters
----------
OPT     Input-BCD, default = COLUMN.

        COLUMN     produces column vector output (labeled as a general
                   rectangular matrix)
        SQUARE     produces square matrix (labeled as a symmetric matrix)
        DIAGONAL   produces diagonal matrix (labeled as a diagonal
                   matrix)

POWER   Input-Real single precision, default = 1.0. Exponent to which the
        real part of each diagonal element is raised.

Remarks
-------
1.The module checks for special cases of POWER = 0.0, 0.5, 1.0, and 2.0.

2.The precision of the output matrix matches the precision of the input
matrix.

FBS - Matrix Forward-Backward Substitution
==========================================

Purpose
-------
To solve the matrix equation [L][U][X] = +/- [B] where [L] and [U] are the
lower and upper triangular factors of a matrix previously obtained via
Functional Module DECOMP.

DMAP Calling Sequence
---------------------
FBS  L,U,B / X / V,Y,SYM / V,Y,SIGN / V,Y,PREC / V,Y,TYPE $

Input Data Blocks
-----------------
L       Nonstandard lower triangular factor.
U       Nonstandard upper triangular factor.
B       Rectangular matrix.

Output Data Blocks
------------------
X       Rectangular matrix having the same dimensions as [B].

Parameters
----------
SYM     Input-Integer-default = 0; 1 - matrix [L][U] is symmetric; -1
        -matrix [L][U] is unsymmetric; 0 - reset to 1 or -1 depending upon
        [U] being purged or not respectively.

        Output-Integer - SYM used.

SIGN    Input-Integer-default = 1; 1 - solve [L][U][X] = [B]; -1 - solve
        [L][U][X] = [-B]

PREC    Input-Integer-default = 0; 1 - use single precision arithmetic; 2
        -use double precision arithmetic; 0 - logical choice based on
        input and system precision flag.

        Output-Integer - precision used.

TYPE    Input-Integer-default = 0; 1 - output type of matrix [X] is real
        single precision; 2 - output type of matrix [X] is real double
        precision; 3 - output type of matrix [X] is complex single
        precision; 4 - output type of matrix [X] is complex double
        precision; 0 - logical choice based on input matrices.

        Output-Integer - TYPE used.

Remarks
-------
1.Non-standard triangular factor matrix data blocks are used to improve the
efficiency of the back substitution process. The format of these data
blocks is given in Section 2 of the Programmer's Manual.

2.The matrix manipulating utility modules should be cautiously employed when
dealing with non-standard matrix data blocks.

MATGEN - Matrix Generator
=========================
Purpose
-------
To generate different kinds of matrices for later use in other matrix
operation modules.

DMAP Calling Sequence
---------------------
MATGEN  TABLE/MAT/P1/P2/P3/P4/P5/P6/P7/P8/P9/P10/P11 $

Input Data Blocks
-----------------
TABLE   Optional tabular data for use in generating the matrix. (This data
        may be assumed to be entered by DTI cards.) For P1 = 9, TABLE is
        the EQEXIN table. For P1 = 11, TABLE is the USET table.

Output Data Blocks
------------------
MAT     Standard matrix data block.

Parameters
----------
P1      Input-integer-no default. Option selection parameter as described
        below.

P2 - P11Input-integer-default = 0. Provide parametric data depending on
        P1.

Usage

P1 = 1  Generate a real identity matrix.

        P2 = Order of matrix.
        P3 = Skew flag. If nonzero, generate a skew-diagonal matrix.
        P4 = Precision (1 or 2). If zero, use machine precision.

P1 = 2  Generate an identity matrix trailer.

        P2 = Order of matrix.

        Note: This option differs from P1 = 1 in that only the trailer is
        generated (form = 8) and the matrix is not actually generated.
        Only certain DMAP modules are prepared to accept this form (for
        example, MPYAD, FBS, CEAD).

P1 = 3  Generate a diagonal matrix from input file TABLE.

        P2 = Type of data in TABLE.
        P3 = 0, matrix is form 6, type P2; = 1, matrix is form 3, type P2.

P1 = 4  Generate a pattern matrix.

        P2 = Number of columns.
        P3 = Number of rows.
        P4 = Precision (1 or 2). If 0, use machine precision.
        P5 = Number of terms per string. If 0, use 1.
        P6 = Increment between strings. If 0, use 1.
        P7 = Row number of first string in column 1. If 0, use 1.
        P8 = Increment to first row of subsequent columns.
        P9 = Number of columns before returning to P7.

        Note: The nonzero values in each column will be the column
        numbers.

        Example: To generate a 10 x 10 diagonal matrix with the column
        number in each diagonal position:

           MATGEN  ,/DIAG/4/10/10/0/1/10/1/1/10 $

P1 = 5  Generate a matrix of pseudo-random numbers. The numbers span the
        range 0 to 1.0, with a normal distribution.

        P2 = Number of columns.
        P3 = Number of rows.
        P4 = Precision (1 or 2). If 0, use machine precision.
        P5 = Seed for random number generation. If P5 <= 0, the time of
        day (seconds past midnight) will be used.

P1 = 6  Generate a partitioning vector for use in PARTN or MERGE.

        P2 = Number of rows.
        P3, P5, P7, P9 = Number of rows with zero coefficients.
        P4, P6, P8, P10 = Number of rows with unit coefficients.

        If

          10
           -   Pi < P2
          i=3

        the remaining terms contain zeros.

        If

          10
           -   Pi > P2
          i=3

        the terms are ignored after P2.

        Example: To generate a vector of 5 unit terms followed by 7 zeros 
        followed by 2 unit terms: 

           MATGEN   ,/UPART/6/14/0/5/7/2 $

P1 = 7  Generate a null matrix.

        P2 = Number of rows.
        P3 = Number of columns.
        P4 = Form. If P4 = 0, the form will be 6 (symmetric) if P2 = P3, 
        otherwise form 2. 
        P5 = Type. If P5 = 0, the type will be the machine precision.

P1 = 8  Not available.

P1 = 9  Generate a transformation between external and internal sequence 
        matrices for g-set size matrices. 

        P2 = Output transpose flag. If 0, output non-transposed factor, UEXT = 
        MAT*UINT.  If 1, output transposed factor, UEXT = MAT*UINT. 
        P3 = Number of terms in g-set. The parameter LUSET contains this 
        number in most solution sequences. 

        Example 1: Transform a g-set size vector to external sequence:

           ALTER XX $ AFTER SDR1. ALL SDR1 OUTPUTS ARE IN INTERNAL SEQUENCE.
           MATGEN   EQEXIN/EXTINT/9/LUSET $
           MPYAD    EXTINT,UGV/UGVEXT/1 $

        Example 2: Transform an a-set size matrix to external sequence:

           ALTER XX $ AFTER KAA GENERATED. ALL MATRICES IN INTERNAL SEQUENCE.
           VEC      USET/VATOG/G/A/COMP $
           MERGE    KAA,,,,VATOG,/KAGG/ $ EXPAND TO G-SIZE, INTERNAL SORT
           MATGEN   EQEXIN/INTEXT/9/0/LUSET $
           SMPYAD   INTEXT,KAGG,INTEXT,,/KAAGEXT/3////1////6 $
           $ (KAAGEXT) = TRANSPOSE(INTEXT)*(KAAG)*(INTEXT)
           $ ITS FORM IS 6 (SYMMETRIC)

P1 = 10 Not used.

P1 = 11 Not available.

MERGE - Matrix Merge

Purpose
-------
To form the matrix [A] from its partitions:

                +--- CP ----+
              + +           +
              | | A11 | A12 | = 0
    [A] <=   RP | ----+---- |
              | | A21 | A22 | not equal 0
              + +           +
                  = 0   not equal 0

DMAP Calling Sequence
---------------------
MERGE A11,A21,A12,A22,CP,RP / A / V,Y,SYM / V,Y,TYPE / V,Y,FORM $

Input Data Blocks
-----------------
A11     Matrix.
A21     Matrix.
A12     Matrix.
A22     Matrix.
CP      Column partitioning vector (see below) - Single precision column vector.
RP      Row partitioning vector (see below) - Single precision column vector.

NOTES
-----
1. Any or all of [A11], [A12], [A21], [A22] can be purged. When all are purged 
this implies [A] = [0].
2. {RP} and {CP} may not both be purged.
3. See Remarks for meaning when either of {RP} or {CP} is purged.
4. [A11], [A12], [A21], [A22] must be unique matrices. 

Output Data Blocks
------------------
A       Merged matrix from [A11], [A12], [A21], [A22].

NOTE: [A] cannot be purged.

Parameters
----------
SYM     Input-Integer, default = -1. SYM < 0, {CP} is used for {RP}. SYM >= 0, 
        {CP} and {RP} are distinct. 

TYPE    Input-Integer, default = 0. Type of [A] - see Remark 4.

FORM    Input-Integer, default = 0. Form of [A] - see Remark 3.

Remarks
-------
1. MERGE is the inverse of PARTN in the sense that if [A11], [A12], [A21], 
[A22] were produced by PARTN using {RP}, {CP}, FORM, SYM, and TYPE from [A], 
MERGE will produce [A]. See PARTN for options on {RP}, {CP}, and SYM. 

2. All input data blocks must be distinct.

3. When FORM = 0, a compatible matrix [A] results as shown in the following 
table: 

                       +--------------------------------------------------+
                       |                    FORM OF A22                   |
                       +-----------------+----------------+---------------+
                       |   Square        |  Rectangular   |  Symmetric    |
+------+---------------+-----------------+----------------+---------------+
|      |  Square       |   Square        |  Rectangular   |  Rectangular  |
| FORM +---------------+-----------------+----------------+---------------+
|  OF  |  Rectangular  |   Rectangular   |  Rectangular   |  Rectangular  |
| A11  +---------------+-----------------+----------------+---------------+
|      |  Symmetric    |   Rectangular   |  Rectangular   |  Symmetric    |
+------+---------------+-----------------+----------------+---------------+

4. If TYPE = 0, the type of the output matrix wilt be the maximum type of 
[A11], [A12], [A21], and [A22]. 

MPYAD - Matrix Multiply and Add
===============================
Purpose
-------
MPYAD computes the multiplication of two matrices and, optionally, addition of 
a third matrix to the product. By means of parameters, you may compute +/- 
[A][B] +/- [C] = [X], or +/- [A]T[B] +/- [C] = [X]. 

DMAP Calling Sequence
---------------------
MPYAD  A,B,C / X / V,N,T / V,N,SIGNAB / V,N,SIGNC / V,N,TYPEX $

Input Data Blocks
-----------------
A       Left hand matrix in the matrix product [A][B].
B       Right hand matrix in the matrix product [A][B].
C       Matrix to be added to [A][B].

NOTES
-----
1.If no matrix is to be added, [C] must be purged.
2.[A], [B], [C] must be physically different data blocks.
3.[A] and [B] must not be purged.
4.[A], [B], and [C] must be conformable. This condition is checked by MPYAD.

Output Data Blocks
------------------
X       Matrix resulting from the MPYAD operation.

NOTE: [X] cannot be purged.

Parameters
----------
T       Input-Integer, no default; 1 - compute [A]T[B]; 0 - compute [A][B].

SIGNAB  Input-Integer, default = 1; +1 - compute [A][B]; 0 - omit [A][B]; -1 - 
        compute -[A][B]. 

SIGNC   Input-Integer, default = 1; +1 - add [C]; 0 - omit [C]; -1 - subtract 
        [C]. 

TYPEX   Input-Integer, default = 0; 0 - logical choice based on input; 1 -
        output type of matrix X is real single precision; 2 - output type of 
        matrix X is real double precision; 3 - output type of matrix X is 
        complex single precision; 4 - output type of matrix X is complex 
        double precision. 

        Output-Integer; TYPEX used.

Examples
--------
1. [X] = [A][B]+[C]     ([X] see notes)
   MPYAD  A,B,C / X / C,N,0 $

            T
2. [X] = [A] [B]-[C]    ([X] real single-precision)
   MPYAD  A,B,C / X / C,N,1 / C,N,1 / C,N,-1 / C,N,1 $

3. [X]  =  -[A][B]      ([X] see notes)
   MPYAD  A,B, / X / C,N,0 / C,N,-1 $

NOTES: The precision of [X] is determined from the input matrices in that if 
any one of these matrices is specified as double precision, then [X] will also 
be double precision. If the precision for the input matrices is not specified, 
the precision of the system flag will be used. 

MPY3 - Triple Matrix Multiply
=============================
Purpose
-------
To compute the matrix product [X]=[A]T[B][A]+[C], [X]=[A]T[B]+[C], or 
[X]=[B][A]+[C] for sparse A matrix and dense B matrix. 

DMAP Calling Sequence
---------------------
MPY3 A,B,C /X/ V,N,CODE / V,N,PREC $

Input Data Blocks
-----------------
A       Matrix[A].
B       Matrix[B].
C       Matrix[C].

NOTES
-----
1.If no matrix is to be added, [C] must be purged.
2.[A], [B], and [C] must be physically different data blocks.
3.[A] and [B] must not be purged.
4.[A], [B], and [C] must be conformable.

Output Data Blocks
------------------
X       Matrix resulting from the triple matrix multiplication.

NOTE: [X] cannot be purged.

Parameters
----------
CODE    Input-Integer, default = 0. If CODE = 0, ATBA + C is performed. If 
        CODE = 1, ATB + C is performed via MPYAD. If CODE = 2, BA + C is 
        performed. 

PREC    Input-Integer, default = 0. If PREC = 0, output precision is the 
        logical choice based on input. If PREC = 1, output is in real single 
        precision. If PREC = 2, output is in real double precision. 

Remarks
-------
1. See Section 4.157 of the Programmer's Manual for a detailed description of 
the MPY3 module. 

PARTN - Matrix Partition
========================
Purpose
-------
To partition [A] into [A11], [A12], [A21], and [A22]:

                 +--- CP ----+
               + +           +
               | | A11 | A12 | = 0
     [A] =>   RP | ----+---- |
               | | A21 | A22 | not equal 0
               + +           +
                   = 0   not equal 0

DMAP Calling Sequence
---------------------
PARTN A,CP,RP / A11,A21,A12,A22 / V,Y,SYM / V,Y,TYPE / V,Y,F11 /
                V,Y,F21 / V,Y,F12 / V,Y,F22 $

Input Data Blocks
-----------------
A       Matrix to be partitioned.
CP      Column partitioning vector - single precision column vector.
RP      Row partitioning vector - single precision column vector.

Output Data Blocks
------------------
A11     Upper left partition of [A].
A21     Lower left partition of [A].
A12     Upper right partition of [A].
A22     Lower right partItion of [A].

NOTES
-----
1.Any or all output data blocks may be purged.
2.For size of outputs see Method section below.

Parameters
----------
SYM     Input-Integer, default = -1. SYM chooses between a symmetric partition 
        and one unsymmetric partition. If SYM < 0, {CP} is used as {RP}. If 
        SYM >= 0, {CP} and {RP} are distinct. 

TYPE    Input-Integer, default = 0. Type of output matrices - see Remark 8.

F11     Input-Integer, default = 0. Form of [A11]. See Remark 7.

F21     Input-Integer, default = 0. Form of [A21]. See Remark 7.

F12     Input-Integer, default = 0. Form of [A12]. See Remark 7.

F22     Input-Integer, default = 0. Form of [A22]. See Remark 7.

Method
------
Let NC = number of nonzero terms in {CP}.
Let NR = number of nonzero terms In {RP}.
Let NROWA = number of rows In [A].
Let NCOLA = number of columns In [A].

CASE 1 {CP} purged and SYM >= 0.                           +   +
[A11] is a (NROWA - NR) by NCOLA matrix.                   |A11|
[A21] is a NR by NCOLA matrix.                      [A] -> |---|
[A12] is not written.                                      |A21|
[A22] is not written.                                      +   +

CASE 2 {RP} purged and SYM >= 0.
[A11] is a NROWA by (NCOLA - NC) matrix.
[A21] is not written.                               [A] -> [A11 | A12]
[A12] is a NROWA by NC matrix.
[A22] is not written.

CASE 3 SYM < 0 ({RP} must be purged)                        +           +
[A11] is a (NROWA - NC) by (NCOLA - NC) matrix.             | A11 | A12 |
[A21] is a NC by (NCOLA - NC) matrix.               [A] ->  | ----+---- |
[A12] is a (NROWA - NC) by NC matrix.                       | A21 | A22 |
[A22] is a NC by NC matrix.                                 +           +

CASE 4 neither {CP} nor {RP} purged and SYM >=0             +           +
[A11] is a (NROWA - NR) by (NCOLA - NC) matrix.             | A11 | A12 |
[A21] is a NR by (NCOLA - NC) matrix.               [A] ->  | ----+---- |
[A12] is a (NROWA - NR) by NC matrix.                       | A21 | A22 |
[A22] is a NR by NC matrix.                                 +           +

Remarks
-------
1.If [A] is purged, PARTN will cause all output data blocks to be purged.

2.If {CP} is purged, [A] is partitioned as follows:

       +   +
       |A11|
[A] => |---|
       |A21|
       +   +

3.If {RP} is purged and SYM >= 0, [A] is partitioned as follows:

[A] => [A11 | A12]

4.If {RP} is purged and SYM < 0, [A] is partitioned as follows:

        +           +
        | A11 | A12 |
[A] =>  | ----+---- |
        | A21 | A22 |
        +           +

where {CP} is used as both the row and column partitioner.

5.{RP} and {CP} cannot both be purged.

6.
        +           +
        | A11 | A12 |
[A] =>  | ----+---- |
        | A21 | A22 |
        +           +

Let [A] be a m by n order matrix. Let {CP} be a n order column vector 
containing q zero elements. Let {RP} be a m order column vector containing p 
zero element. 

Partition [A11] will consist of all elements Aij of [A] for which CPj = RPi = 
0 in the same order as they appear in [A]. 

Partition [A12] will consist of all elements Aij of [A] for which CPj not 
equal 0 and RPi = 0 in the same order as they appear in [A]. 

Partition [A21] will consist of all elements Aij or [A] for which CPj = 0 and 
RPi not equal 0 in the same order as they appear in [A]. 

Partition [A22] will consist of all elements Aij of [A] for which CPj not 
equal 0 and RPi not equal 0 in the same order as they appear in [A]. 

7. If the defaults for F11, F21, F12, or F22 are used, the corresponding 
matrix will be output with a compatible form entered in the trailer. 

8. If TYPE = 0, the type of the output matrices will be the type of the input 
matrix [A]. 

Examples
--------
1.Let [A], {CP} and {RP} be defined as follows:

                                           �   �
         +                  +              �1.0�              �   �
         |1.0  2.0  3.0  4.0|              �0.0�              �0.0�
  [A] =  |5.0  6.0  7.0  8.0|  ,  {CP} =   �1.0�   ,  {RP} =  �0.0�
         |9.0 10.0 11.0 12.0|              �1.0�              �1.0�
         +                  +              �   �              �   �

Then, the DMAP instruction

  PARTN A,CP,RP / A11,A21,A12,A22 / C,N,1 $

will create the real double precision matrices

          +   +                            +               +
          |2.0|                            |1.0   3.0   4.0|
  [A11] = |6.0|   ,  F11 = 2       [A12] = |5.0   7.0   8.0|  ,  F12 = 2
          +   +                            +               +

  [A21] = [10.0]  ,  F21 = 1       [A22] = [9.0  11.0  12.0]  ,  F22 = 2

2.If, in Example 1, the DMAP instruction were written as

  PARTN  A,CP, /  A11,A21,A12,A22 / C,N,1 $

the resulting matrices would be

          +    +                            +               +
          |2.0 |                            |1.0   3.0   4.0|
  [A11] = |6.0 |                    [A12] = |5.0   7.0   8.0|
          |10.0|                            |9.0  11.0  12.0|
          +    +                            +               +
  [A21] = purged                    [A22] = purged

3.If, in Example 1, the DMAP instruction were written as

  PARTN  A,,RP / A11,A21,A12,A22 / C,N,1 $

the resulting matrices would be

             +                  +
             |1.0  2.0  3.0  4.0|
    [A11] =  |5.0  6.0  7.0  8.0|     [A12] = purged
             +                  +

    [A21] =  [9.0 10.0 11.0 12.0]     [A22] = purged

SDCMPS - Symmetric Decomposition
================================
Purpose
-------
To decompose a matrix [A] into upper and lower triangular factors [U] and [L].

[A] => [L][U]

Badly conditioned matrix columns for symmetric real matrices are identified in 
external identification numbers. Various user exit controls for error 
conditions are available. 

DMAP Calling Sequence
---------------------
SDCMPS USET,GPL,SIL,A / L,U / V,Y,SYM / V,Y,DIAGCK / V,Y,DIAGET /
                        V,Y,PDEFCK / V,N,SING / V,Y,SET / V,Y,CHOLSKY /
                        V,N,DET / V,N,MINDIA / V,N,POWER / V,Y,SUBNAM $

Input Data Blocks
-----------------
USET    Displacement Set Definition Table.
GPL     Grid Point List.
SIL     Scalar Index List.
A       A real symmetric matrix (may not be purged).

NOTE: Error conditions will be identified by column number if USET, GPL, or 
SIL are purged for non-substructuring problems. 

Output Data Blocks
------------------
L       Lower triangular factor of [A].
U       Upper triangular factor of [A].

Parameters
----------
SYM     Input-Integer, default = 0. 1, use symmetric decomposition. -1, use 
        unsymmetric decomposition. 0, use decomposition based on input matrix 
        form. 

DIAGCK  Input-Integer, default = 0. Diagonal singularity or nonconservative 
        column exit flag. 

        = 0   nonfatal messages for es > Ts (see DIAGET and Remark 6 for 
              definitions). 

        > 0   a maximum of DIAGCK messages for es > Ts before aborting 
              decomposition prior to completion. 

        <  0  no check of es.

DIAGET  Input-Integer, default = 20. Diagonal singularity error tolerance. 
        Used in conjunction with DIAGCK. A message is issued if the error, es 
        > Ts = 2-n, where n = DIAGET. 

PDEFCK  Input-Integer, default = 0. Positive definite exit flag.

        = 0   nonfatal messages are issued for Dii < 0.0 and fatal messages 
              are issued for Dii = 0.0. 

        > 0   a maximum of PDEFCK fatal messages for all Dii <= 0.0 are issued 
              before aborting decomposition prior to completion 

        < 0   no check for Dii < 0.0. If Dii = 0.0, absolute value of PDEFCK 
              messages are issued before aborting decomposition prior to 
              completion. 

SING    Output-Integer, no default. SING is set to -1 if [A] is singular, 0 if 
        not positive definite, and 1 otherwise, in the given order. 

SET     Input-BCD, default = L. The displacement set to which [A] belongs.

CHOLSKY Input-Integer, default = 0. Cholesky decomposition is used if the 
        value is 1 (matrix must be positive definite); Cholesky decomposition 
        is not used for values other than 1. 

DET     Output-Real single precision, default = 0.0. The scaled value of the 
        determinant of [A]. 

MINDIA  Output-double precision, default = 0.0D0. Minimum diagonal of [U].

POWER   Output-Integer, default = 0. Integer power of 10 by which DET should 
        be multiplied to obtain the determinant of [A]. 

SUBNAM  Input-BCD, default = NONE. Name of substructure being solved. Not 
        necessary unless this is a substructuring problem. 

Remarks
-------
1. Non-standard triangular factor matrix data blocks are used to improve the 
efficiency of the back substitution process in module FBS. The format of these 
data blocks is given in Section 2 of the Programmer's Manual. 

2. If the CHOLSKY option is selected, the resulting factor (which will be 
written as [U]) cannot be input to FBS. 

3. Upon finding a zero diagonal (Dii) on the decomposed matrix, a value of 1.0 
is substituted for the diagonal term if decomposition is to proceed. However, 
the fatal error flag is always set in this case. 

4. All zero columns on the input matrix cause fatal messages and decomposition 
is not attempted. If a system error occurs, a null column might result during 
decomposition, in which case the column is labeled as a "Bad Column" and the 
decomposition is aborted. 

5. A nonpositive definite matrix (decomposed diagonal element less than zero) 
causes the absolute value to be substituted only with the Cholesky option and 
if decomposition is to be continued. 

6. The diagonal singularity test is

               1-p
              2
     e   = ----------
      s    |Dii/Aii|

where p is the number of bits in the mantissa (machine dependent), Dii is the 
ith diagonal term of the decomposed matrix, and Aii is the ith diagonal term 
of the input matrix, [A]. 

7. All matrix messages give the input and decomposed diagonal value except for 
situations where the input matrix is in error (for example, the matrix is 
classified as rectangular or has a null column). 

8. Nonconservative columns (identified by Dii > 1.001 * Aii) are identified. 

9. Variable parameters output from functional modules must be SAVEd if they 
are to be subsequently used. See Executive Module SAVE instruction. 

10. Setting MODCOM(1) to -1 on the NASTRAN card (see Section 2.1) allows the 
time and core estimates to be made without actually doing the decomposition. 
Absolute values greater than 1 replace the variable CLOSE documented in 
Section 3.5.14.4 of the Programmer's Manual. 

Examples
--------
1. To use the SDCMPS module in a static analysis (Rigid Format 1), modules 
SMP1 and RBMG2 must be removed. For this case, the required ALTERs are as 
follows: 

ALTER     n1 $ (where n1 = DMAP statement number of LABEL LBL4)
PARAM     //*PREC*/MPREC $
ALTER     n2,n2 $ (where n2 = DMAP statement number of the SMP1 module)
VEC       USET/V/*F*/*O*/*A* $
PARTN     KFF,V,/KOO,,KOA,KAAB $
SDCMPS    USET,GPL,SIL,KOO/LOO,/C,Y,SYM=0/C,Y,DIAGCK=0/C,Y,DIAGET=20/
          C,Y,PDEFCK=0/S,N,SINGO/*O*/0/S,N,DETO/S,N;MINDIAO/
          S,N,POWERO $
COND      LSING,SINGO $
FBS       LOO,,KOA/GO/1/-1 $
MPYAD     KOA,GO,KAAB/KAA/1/1/1/MPREC $
ALTER     n3,n3 $ (where n3 = DMAP statement number of the RBMG2 module)
SDCMPS    USET,GPL,SIL,KL/LLL,/C,Y,SYM=0/C,Y,DIAGCK=0/C,Y,DIAGET=20/
          C,Y,PDEFCK=0/S,N,SINGL/*L*/0/S,N,DETL/S,N,MINDIAL/
          S,N,POWERL $
COND      LSING,SINGL $
ALTER     n4 $ (where n4 = DMAP statement number of COND FINIS, COUNT)
LABEL     LSING $
PRTPARM   //O/*SINGO* $
PRTPARM   //0/*SINGL* $
PRTPARM   //-1/*DMAP* $
ENDALTER  $

The input parameters SYM, DIAGCK, DIAGET, and PDEFCK may be changed from the 
values illustrated above either by using the form /C,N,i/ or by including a 
PARAM bulk data card with a different value. 

2. To use the SDCMPS module in a real eigenvalue analysis (Rigid Format 3), 
modules SMP1 and RBMG2 must be removed. For this case, the required ALTERs are 
as follows: 

ALTER     n1,n1 $ (where n1 = DMAP statement number of the SMP1 module)
VEC       USET/V/*F*/*0*/*A* $
PARTN     KFF,V,/KOO,,KOA,KAAB
SDCMPS    USET,GPL,SIL,KOO/LOO,UOO/C,Y,SYM=0/C,Y,DIAGCK=0/C,Y,DIAGET=20/
          C,Y,PDEFCK=0/S,N,SINGO/*O*/0/S,N,DETO/S,N,MINDIAO/
          S,N,POWERO $
COND      LSING,SINGO $
FBS       LOO,UOO,KOA/GO/1/-1 $
MPYAD     KOA,GO,KAAB/KAA/1 $
ALTER     n2,n2 $ (where n2 = DMAP statement number of the RBMG2 module)
SDCMPS    USET,GPL,SIL,KLL/LLL,/C,Y,SYM=0/C,Y,DIAGCK=O/C,Y,DIAGET=20/
          C,Y,PDEFCK=0/S,N,SINGL/*L*/0/S,N,DETL/S,N,MINDIAL/
          S,N,POWERL $
COND      LSING,SINGL $
ALTER     n3 $ (where n3 = DMAP statement number of LABEL P2)
LABEL     LSING $
PRTPARM   //0/*SINGO* $
PRTPARM   //0/*SINGL* $
PRTPARM   //-1/*DMAP* $
ENDALTER  $

The input parameters SYM, DIAGCK, DIAGET, and PDEFCK may be changed from the 
values illustrated above as indicated under Example 1. 

SMPYAD - Matrix Series Multiply and Add
=======================================
Purpose
-------
To multiply a series of matrices together and, optionally, add another matrix 
to the product: 

    [X]  =  [A][B][C][D][E] +/- [F]

DMAP Calling Sequence
---------------------
SMPYAD   A,B,C,D,E,F / X / C,N,n / V,N,SIGNX / V,N,SIGNF / V,N,PX / V,N,TA /
         V,N,TB / V,N,TC / V,N,TD $

Input Data Blocks
-----------------
A, B, C, D, E Up to 5 matrices to be multiplied together, from left to right.
F             Matrix to be added to the above product.

NOTES
-----
1.  If one of the five multiplication matrices is required in the product (see 
    parameter n below) and is purged, the entire calculation is skipped. 
2.  If the [F] matrix is purged, no matrix will be added to the product.
3.  The input matrices must be conformable. This condition is checked by SMPYAD.

Output Data Blocks
------------------
X             Resultant matrix (may not be pre-purged).

Parameters
----------
n             number of matrices involved in the product, counting from the 
              left (Input-Integer). 

SIGNX         sign of the product matrix (for example, [A][B][C][D][E]); 1 for 
              plus, -1 for minus (Input-Integer). 

SIGNF         sign of the matrix to be added to the product matrix (Input-
              Integer); 1 for plus, -1 for minus 

PX            output precision of the final result (Input-Integer); 1 for 
              single-precision, 2 for double-precision, 0 logical choice based 
              on input matrices. 

TA, TB,TC, TD transpose indicators for the [A],[B],[C], and [D] matrices; (1 
              if transposed matrix to be used in the product; 0 if 
              untransposed) (Input-Integer). 

NOTE
----
All the parameters except n have default values as follows:

    SIGNX  =  1 (sign of product is plus)
    SIGNF  =  1 (sign of added matrix is plus)
    PX  =  0 (logical choice based on input matrices)
    TA, TB, TC, TD  =  0 (use untransposed [A],[B],[C], and [D] matrices in 
    the product) (the number of transpose indicators required is one less than 
    the number of matrices in the product. The last matrix in the product 
    cannot be transposed.) 

Method
------
The method is the same as for the MPYAD module with the following additional remarks:

1.  None of the matrices may be diagonal.

2.  Except for the final product, all intermediate matrix products are 
    generated in double-precision. 

3.  The matrices are post-multiplied together from right-to-left, that is, the 
    first product calculated is the product of matrix n-l and matrix n. 

Examples
--------
1.  To compute [X] = [A][B]T[C]-[F], use

    SMPYAD  A,B,C,,,F / X / C,N,3 / C,N,1 / C,N,-1 / C,N,0 / C,N,0 / C,N,1 $

2.  To compute [Z] = -[U]T[V]T[W]T[X]T[Y], use

    SMPYAD  U,V,W,X,Y, / Z / C,N,5 / C,N,-1 / C,N,0 / C,M,0 / C,N,1 / C,N,1 /
            C,N,1 / C,N,1 $

SOLVE - Linear System Solver
============================
Purpose
-------
To solve the Matrix Equation

    [A][X]  =  +/- [B]

DMAP Calling Sequence
---------------------
SOLVE   A,B / X / V,Y,SYM / V,Y,SIGN / V,Y,PREC / V,Y,TYPE  $

Input Data Blocks
-----------------
A             Square real or complex matrix.
B             Rectangular real or complex matrix (if purged, the identity 
              matrix is assumed). 

Output Data Blocks
------------------
X             A rectangular matrix.

NOTE: A standard matrix trailer will be written, identifying [X] as a rectangular matrix with the same
dimensions as [B] and the type specified.

Parameters
----------
SYM           Input-Integer, default = 0; -1 - use unsymmetric decomposition; 
              1 -use symmetric decomposition; 0 - logical choice based on 
              input matrices. 

              Output-Integer, SYM used.

SIGN          Input-Integer, default = 1;1 - solve [A][X] = [B]; -1 - solve 
              [A][X] = -[B]. 

PREC          Input-Integer, default = 0; 0 - logical choice based on input; 1 
              -use single precision arithmetic; 2 - use double precision 
              arithmetic. 

              Output-Integer, PREC used.

TYPE          Input-Integer, default = 0; 0 - logical choice based on input; 1 
              -output type of matrix [X] is real single precision; 2 - output 
              type of matrix [X] is real double precision; 3 - output type of 
              matrix [X] is complex single precision; 4 - output type of 
              matrix [X] is complex double precision 

              Output-Integer, TYPE used.

Method
------
Depending on the SYM flag and the type of [A], one of subroutines SDCOMP, 
DECOMP, or CDECOMP is called to form [A] = [L][U]. One of FBS or GFBS is then 
called to solve [L][Y] = +/- [B] and [U][X] = [Y], as appropriate. 

TRNSP - Matrix Transpose

Purpose
-------
To form [A]T given [A].

DMAP Calling Sequence
---------------------
TRNSP A/X $

Input Data Blocks
-----------------
A             Any matrix data block.

NOTE: If [A] is purged, TRNSP will cause [X] to be purged.

Output Data Blocks
------------------
X             The matrix transpose of [A].

NOTE: [X] cannot be purged.

Parameters
----------
None.

Remarks
-------
1.  Transposition of large full matrices is very expensive and should be 
    avoided if possible (see Section 2.1.4 of the Theoretical Manual). 

2.  TRNSP uses an algorithm which assumes that the matrix is dense. This 
    algorithm is extremely inefficient for sparse matrices. Sparse matrices 
    should be transposed by using MPYAD. 

UMERGE - Merge Two Matrices

Purpose
-------
To merge two column matrices (such as load vectors or displacement vectors) into a single matrix.

DMAP Calling Sequence
---------------------
UMERGE  USET,PHIA,PHIO / PHIF / V,N,MAJOR=F / V,N,SUB0=A / V,N,SUB1=L $

Input Data Blocks
-----------------
USET          Displacement set definitions.
PHIA, PHIO    Any matrices.

NOTES
-----
1.  The set definitions may be USET (statics), USETD (dynamics), HUSET (heat 
    transfer), or USETA (aeroelastic). 
2.  USET, USETD, HUSET, or USETA may not be purged.
3.  PHIA or PHIO may be purged, in which case their respective elements will 
    be zero. 
4.  PHIA, PHIO, and PHIF must be related by the following matrix equation:

       �       �      �      �
       � PHIA  �      �      �
       � ----  � ==>  � PHIF �
       � PHIO  �      �      �
       �       �      �      �

Output Data Blocks
------------------
PHIF          Matrix.

NOTE: PHIF cannot be purged.

Parameters
----------
MAJOR         BCD value from table below (Input, no default).
SUB0          BCD value from table below (Input, no default).
SUB1          BCD value from table below (Input, no default).

NOTE: The set equation MAJOR = SUB0 + SUB1 should hold.

           Parameter Value              USET Matrix

                   M                       Um
                   S               Us (union of SG and SB)
                   O                       Uo
                   R                       Ur
                   G                       Ug
                   N                       Un
                   F                       Uf
                   A                       Ua
                   L                       Ul
                   SG             Us (specified on Grid card)
                   SB             Us (specified on SPC card)
                   E                       Ue
                   P                       Up
                   NE             Une (union of N and E)
                   FE             Ufe (union of F and E)
                   D                       Ud
                   PS                      Ups
                   SA                      UsA
                   K                       Uk
                   PA                      UpA

UPARTN - Partition a Matrix
===========================
Purpose
-------
To perform symmetric partitioning of matrices (particularly to allow you to 
split long running modules such as SMP1). 

DMAP Calling Sequence
---------------------
UPARTN  USET,KII / KJJ,KLJ,KJL,KLL / V,N,MAJOR=I / V,N,SUB0=J / V,N,SUB1=L $

Input Data Blocks
-----------------
USET          Displacement set definitions.
KII           Any displacement matrix.

NOTES
-----
1.  The set definitions may be USET (statics), USETD (dynamics), HUSET (heat 
    transfer), or USETA (aeroelastic). 
2.  USET may not be purged.
3.  KII may be purged, in which case UPARTN will simply return, causing the 
    output matrices to be purged. 

Output Data Blocks
------------------
KJJ, KLJ, KJL, KII  Matrix partitions

NOTES
-----
1.  Any or all output data block(s) may be purged.
2.  UPARTN forms:

                 +           +
                 | Kjj | Kjl |
       [Kii] =>  | ----+---- |
                 | Klj | Kll |
                 +           +

Parameters
----------
MAJOR         BCD value from table below (Input, no default).
SUB0          BCD value from table below (Input, no default).
SUB1          BCD value from table below (Input, no default).

NOTE: The set equation MAJOR = SUB0 + SUB1 should hold.

           Parameter Value              USET Matrix

                   M                       Um
                   S               Us (union of SG and SB)
                   O                       Uo
                   R                       Ur
                   G                       Ug
                   N                       Un
                   F                       Uf
                   A                       Ua
                   L                       Ul
                   SG             Us (specified on Grid card)
                   SB             Us (specified on SPC card)
                   E                       Ue
                   P                       Up
                   NE             Une (union of N and E)
                   FE             Ufe (union of F and E)
                   D                       Ud
                   PS                      Ups
                   SA                      UsA
                   K                       Uk
                   PA                      UpA

Example
-------
In Rigid Format 2, module SMP1 performs the following calculations. SMP1 
partitions the constrained stiffness and mass matrices 

              + _         +
              | Kaa | Kao |
    [Kff] =>  | ----+---- |
              | Koa | Koo |
              +           +

and

              + _         +
              | Maa | Mao |
    [Mff] =>  | ----+---- |
              | Moa | Moo |
              +           +

solves for transformation matrix

                 -1
    [Go] = -[Koo]  [Koa]

and performs the matrix reductions

             _           T
    [Kaa] = [Kaa] + [Koa] [Go]

and

             _           T           T            T
    [Maa] = [Maa] + [Moa] [Go] + [Go] [Moa] + [Go] [Moo][Go]

Step 1 can be performed by two applications of UPARTN:

    UPARTN USET,KFF / KAAB,KOA,,KOO / *F*/*A*/*O* $

    UPARTN USET,MFF / MAAB,MOA,,MOO / *F*/*A*/*O* $

Step 2 can be performed by SOLVE:

    SOLVE KOO,KOA / GO / 1 / -1 $

KAA and MAA can then be computed by a sequence of applications of the MPYAD 
module. 

Thus, in the above manner, a long running module can be broken down into 
several smaller steps and the intermediate results can be checkpointed. 


5.5  UTILITY MODULES
====================
Module                      Basic Function                         Page

COPY      Generate a physical copy of a data block                5.5-3

DATABASE  Save data on user tape                                  5.5-4

GINOFILE  Copy scratch file data to GINO file                    5.5-13

INPUT     Generate most of bulk data for selected academic       5.5-15
          problems

INPUTT1   Read data blocks from GINO-written user files          5.5-16

INPUTT2   Read data blocks from FORTRAN-written user files       5.5-21

INPUTT3   Read matrix data from special file                     5.5-24

INPUTT4   Read user tape in special format                       5.5-25

INPUTT5   Read data blocks from FORTRAN-written user files       5.5-27

LAMX      Edit or generate data block LAMA                       5.5-30

MATGPR    Displacement set matrix printer                        5.5-32

MATPRN    Print matrices                                         5.5-34

MATPRT    Print matrices associated only with geometric grid     5.5-35
          points

NORM      Generate normalized matrices, or normalized column vector

OUTPUT1   Write data blocks via GINO onto user files             5.5-36

OUTPUT2   Write data blocks via FORTRAN onto user files          5.5-41

OUTPUT3   Punch matrices onto DMI cards                          5.5-44

OUTPUT4   Write data block via FORTRAN onto user files,
          in dense or sparse format, binary

OUTPUT5   Write data blocks via FORTRAN onto user files          5.5-46

PARAM     Manipulate parameter values                            5.5-53

PARAMD    Perform specified arithmetic, logical, and conversion  
          operations on double precision real or double 
          precision complex parameters 

PARAML    Select parameters from a user input matrix or table    5.5-58

PARAMR    Similiar to PARAMD, except operation is on single 
          precision real or single precision complex parameters 

PRTPARM   Print parameter values and DMAP error messages         5.5-63

SCALAR    Convert matrix element to parameter                    5.5-65

SEEMAT    Generate matrix topology displays                      5.5-67

SETVAL    Set parameter values                                   5.5-69

SWITCH    Interchange two data block names                       5.5-70

TABPCH    Punch NASTRAN tables on DTI cards                      5.5-71

TABPRT    Print selected table data blocks using readable format 5.5-72

TABPT     Print table data blocks                                5.5-74

TIMETEST  Provide NASTRAN system timing data                     5.5-75

VEC       Generate partitioning vector                           5.5-76

Utility modules are an arbitrary sub-division of the Functional Modules and 
are used to output matrix and table data blocks and to manipulate parameters. 

The data block names corresponding to the various matrix and table data blocks 
used in the Rigid Format DMAP sequences may be found in Volume II or in the 
NASTRAN mnemonic dictionary, Section 7. 


COPY - Copy Data Block
======================

Purpose
-------
To generate a physical copy of a data block.

DMAP Calling Sequence
---------------------
COPY  DB1 / DB2 / PARAM  $

Input Data Blocks
-----------------
DB1        Any NASTRAN data block.

Output Data Blocks
------------------
DB2        Any valid NASTRAN data block name.

Parameters
----------
PARAM   If PARAM <= 0, the copy will be performed - Input-Integer, default =
        -1.

Method
------
If PARAM > 0, a return is made; otherwise a physical copy of the input data
block is generated. See Remark 2 below.

Remarks
-------
1. The input data block may not be purged.

2. If PARAM <  0, the output data block will have the name of the input data
   block in its header record. If PARAM = 0, the output data block will have
   its own name in its header record.

DATABASE - Save Data on User Tape
=================================
Purpose
-------
To save following data on user tape, formatted, or unformatted for user
external use:

   1. Grid points - external numbers, and their x,y,z coordinates in basic
      rectangular coordinate system.

   2. Connecting elements - element names, GPTABD element types, NASTRAN
      symbols, property IDs (or material IDs if elements have no property
      IDs), number of grid points, connecting grid (external) numbers.

   3. Displacement vectors (including velocity, acceleration vectors, loads,
      grid point forces, eigenvectors, element stresses, and element forces) -
      real or complex data in basic rectangular coordinate system, or in
      NASTRAN global coordinate system, in SORT1 or SORT2 data format,
      single-case or subcases, displacement or mode shape data. In addition,
      the grid point masses.

DMAP Calling Sequence
---------------------
DATABASE  EQEXIN,BGPDT,GEOM2,CSTM,O1,O2,O3//C,N,OUTTP/C,N,FORMAT/C,N,BASIC  $

Input Data Blocks
-----------------
EQEXIN     External-internal grid tables. Must be present.

BGPDT   Basic Grid Point Definition Table. If purged, no grid point data sent
        to OUTTP output tape. If BGPDT is purged, and OUGV is present,
        displacement vector will not be converted to basic coordinates.

GEOM2   Geometry 2 Data Block. If purged, no element connectivity data sent
        to OUTTP.

CSTM       Coordinate System Transformation Matrix Data Block. If purged,
           displacement vectors remain in global coordinate system.

O1,O2,O3   Any three output displacement (velocity, acceleration, load, grid
           point force, eigenvector, element stress, and element force) data
           blocks written for OFP module. If present, the displacement
           vectors are processed and results sent out to user OUTTP tape.
           (See Remark 2 for special input data block MGG.) Oi must be one of
           the following files characterized by a 1, 2, 3, 7, 10, 11, 15, or
           16 on the 2nd word, last 2 digits, of the first header record, and
           an 8 or a 14 on the 10th word:

           OUDV1,  OUDVC1, OUGV1,  OUHV1,  OUHVC1, OUPV1, OUPVC1,
           OUDV2,  OUDVC2, OUGV2,  OUHV2,  OUHVC2, OUPV2, OUPVC2,
           OUBGV1, OPHID,  OPHIG,  OPHIH,  OCPHIP,
           OPG1,   OPP1,   OPPC1,  OQG1,   OQP1,   OQPC1, OQBG1,
           OPG2,   OPP2,   OPPC2,  OQG2,   OQP2,   OQPC2, OBQG1,
           OEF1,   OEFC1,  OES1,   OESC1,  OEFB1,  OBEF1, OEF2,
           OEFC2,  OES2,   OESC2,  OESB1,  OBES1

           If purged, no data are sent out to OUTTP.

Output Data Block

No GINO output data block.

Parameters
----------
OUTTP      User output tape. Must be one of the UT1, UT2, INPT, INP1, ...,
           INP9 files; tape or disc file. (Default INP1, FORTRAN Unit 15)

+------------------+-----------------------+
| FORTRAN LOGICAL  |                       |
|  UNIT, OUTTP     |    USER FILE CODE     |
+------------------+-----------------------+
|      11          |    UT1  (CDC only)    |
|      12          |    UT2  (CDC only)    |
|      14          |    INPT (UNIVAC,VAX)  |
|      15          |    INP1 (All          |
|      16          |    INP2  machines     |
|       :          |      :   except       |
|      23          |    INP9  CDC)         |
|      24          |    INPT (IBM only)    |
+------------------+-----------------------+

FORMAT     = 0, unformatted output to OUTTP tape (default).
           = 1, formatted.

BASIC      = 0, displacement vectors in NASTRAN's global coordinate system
           (default).
           = 1, displacement vectors in basic rectangular coordinate system.

Example
-------
DATABASE   EQEXIN,BGPDT,GEOM2,,,, /C,N,15/C,N,+1    $
DATABASE   EQEXIN,BGPDT,,CSTM,OUGV,,/C,N,16         $

The first example writes the grid points and element connectivity data out to
INP1 tape, formatted. The second example writes the grid points and
displacement vectors in NASTRAN global coordinates out to INP2 tape,
unformatted.

Subroutine

DBASE   Subroutine for DATABASE Module.

Method
------
There are three independent sets of data to be copied out to user tape OUTTP:
grids data, connecting elements data, and displacement vectors (velocities,
accelerations, eigenvectors, stresses, and forces). If BGPDT file is purged
(that is, is not present), the grid point data set is not generated.
Similarly, if GEOM2 file is purged, the element connectivity data is not
generated; and the same with the OUGV file and the displacement vectors. The
exact contents in the output tape OUTTP depend therefore on the input file
assignment.

In all cases, EQEXIN file is opened and the grid point external number vs. the
internal number table is read. If BGPDT file is present, the basic grid point
data is read, and each internal grid point number is converted to its external
ID number. The grid points x, y, z coordinates from BGPDT are already in the
basic rectangular coordinate system. The grid points data are then sorted by
their external grid IDs before they are written out to OUTTP tape, under
FORTRAN control. The following table gives the precise contents of each record
in the OUTTP tape.

FOR UNFORMATTED TAPE - GRID POINT DATA IN ONE LONG RECORD:

+--------+-------+---------------------------------------------------------+
| RECORD | WORD  |             CONTENT (UNFORMATTED)                       |
+--------+-------+---------------------------------------------------------+
|    1   |  1-2  | "GRID PTS--------", a 16-letter identification. (BCD*)  |
|    2   |   1   | No. of words (this first word not included) in this     |
|        |       | record. (Integer)                                       |
|        |   2   | External grid ID. (Sorted, integer)                     |
|        |   3   | 0 (Not used; reserved for future use)                   |
|        | 4,5,6 | x,y,z coordinates in basic rect. coord. system.         |
|        |       | (single precision real)                                 |
|        |   :   | Repeat words 2 thru 6 as many times as there are grids  |
+--------+-------+---------------------------------------------------------+
* Throughout, "BCD" = alphanumeric characters

(Total number of grid points = (WORD 1 of record 2)/5)

To read the second record into array XYZ, one can use

   READ (OUTTP) L,(XYZ(J),J=1,L)

FOR FORMATTED TAPE - GRID POINT DATA IN MULTIPLE SHORT RECORDS:

+--------+---------+---------------------------------------+---------+
| RECORD |  WORD   |            CONTENT                    | FORMAT  |
+--------+---------+---------------------------------------+---------+
|        |         |                                       |         |
|    1   |   1,2   |  "GRID PTS--------" identification    |   4A4   |
|    2   |    1    |  Total number of grid points          |    I8   |
|    3   |    1    |  External grid ID (Sorted)            |    I8   |
|        |    2    |  0 (Not used; reserved for future use)|    I8   |
|        |  3,4,5  |  x,y,z coordinates in basic rect.     |  3E12.6 |
|        |         |  coordinate system.                   |         |
|    :   |   1-5   |  Repeat record 3 as many times as     |         |
|        |         |  there are grids                      |         |
+--------+---------+---------------------------------------+---------+

If GEOM2 file is present, the elements data will be generated next. An element
identification record is written out first.

+--------+-------+------------------------------------------+---------+
| RECORD | WORD  |   CONTENT (FORMATTED or UNFORMATTED)     | FORMAT  |
+--------+-------+------------------------------------------+---------+
|    1   |  1-2  | "ELEMENTS--------", identification. BCD  |   4A4   |
+--------+-------+------------------------------------------+---------+

The element data in GEOM2 file will be written out to the OUTTP file almost in
the same way, and same order as the original data. A header record is written
out for each type of element, then followed by the element data. The element
data will be written out in a long record if the OUTTP is unformatted, and in
multiple short records, one for each element, if OUTTP is formatted. Notice
that the element types are sorted according to the NASTRAN'S GPTABD data block
order; and within each type, the elements are sorted by their element IDs.

ELEMENT HEADER RECORD FOR THE UNFORMATTED OUTPUT TAPE:

+--------+------+-----------------------------------------------------+
| RECORD | WORD |             CONTENT (UNFORMATTED)                   |
+--------+------+-----------------------------------------------------+
|    2   | 1-2  |  Element name. (BCD)                                |
|        |  3   |  Element type number, according to GPTABD order.    |
|        |      |  (Integer)                                          |
|        |  4   |  Element symbol. (2 letters)                        |
|        |  5   |  Number of grid points per element. (Integer)       |
|        |  6   |  Total no. of elements of this current element type.|
|        |      |  (Integer)                                          |
|        |  7   |  No. of words in next record = WORD5 + 2 (Integer)  |
|        |  8   |  No. of 132-column lines needed in next record if   |
|        |      |  OUTTP is written with a format. (Integer)          |
+--------+------+-----------------------------------------------------+

ELEMENT RECORDS; repeat as many times as there are elements not of the same
type (that is, a record for each element type):

+--------+-------+-------------------------------------------------------+
| RECORD | WORD  |             CONTENT (UNFORMATTED)                     |
+--------+-------+-------------------------------------------------------+
|    3   |  1    | Element ID. (Integer)                                 |
|        |  2    | Property ID. (Positive Integer); or                   |
|        |       | 0 (Element has no property ID nor material ID); or    |
|        |       | Material ID. (Element has no property ID, but it has  |
|        |       | a material ID. (Negative Integer)                     |
|        |  3    | 0 (Not used; reserved for future use, integer)        |
|        |4,5,...| Element connecting (external) grid points. (Integers) |
|        |  :    | Repeat words 1,2,3,4... as many times as there are    |
|        |       | elements of this same type.                           |
|        |       | (See WORD 6 in header record)                         |
+--------+-------+-------------------------------------------------------+

FOR FORMATTED TAPE

ELEMENT HEADER RECORD, IN 8-COLUMN FORMAT:

+--------+---------+-----------------------------------------+-----------+
| RECORD | COLUMNS |            CONTENT                      | FORMAT    |
+--------+---------+-----------------------------------------+-----------+
|    2   |  1- 8   | "ELEMENT "                              | 8 letters |
|        |  9-16   | Element name                            |     2A4   |
|        | 17-24   | "  TYPE ="                              | 8 letters |
|        | 25-28   | Elem. type no. according to GPTABD      |      I4   |
|        | 29,30   | Blank                                   |      2X   |
|        | 31-32   | Element symbol                          |      A2   |
|        | 33-40   | " GRIDS ="                              | 8 letters |
|        | 41-48   | No. of grids per element                |      I8   |
|        | 49-56   | " TOTAL ="                              | 8 letters |
|        | 57-64   | Total no. of elements of this elem. type|      I8   |
|        | 65-72   | " WDS/EL="                              | 8 letters |
|        | 73-80   | No. of words per element in next records|      I8   |
|        | 81-88   | " LINES ="                              | 8 letters |
|        | 89-96   | No. of lines (records) needed on next   |      I8   |
|        |         | record for this element type            |           |
+--------+---------+-----------------------------------------+-----------+

A printout of this header record may look like this: (the ---+++ line is for
video aid; it is not part of the record)

--------++++++++--------++++++++--------++++++++--------++++++++--
"ELEMENT CBAR      TYPE =  34  BR GRIDS =       2 TOTAL =      54 etc."

ELEMENT RECORDS (FORMATTED)

There should be (TOTAL X LINES) records in each element type:

+--------+------+--------------------------------------------------+--------+
| RECORD | WORD |                 CONTENT                          | FORMAT |
+--------+------+--------------------------------------------------+--------+
|    3   |  1   |   Element ID.                                    |  I8    |
|        |  2   |   Property ID. (Positive integer); or            |  I8    |
|        |      |   0 (Element has no property nor material ID); or|        |
|        |      |   Material ID. (Element has no property ID,      |        |
|        |      |   but it has a material ID)                      |        |
|        |  3   |   0 (Not used; reserved for future use)          |  I8    |
|        | 4-16 |   First 13 external connecting grid points       | 13I8   |
|    4   |      |   (IF NEEDED, and LINES in header record = 2)    |        |
|        | 1-15 |   Next 15 Grid points                            |8X,15I8 |
|    5   |      |   (IF NEEDED, and LINES in header record = 3)    |        |
|        | 1-15 |   More grid points                               |8X,15I8 |
|    :   |  :   |   Repeat element record 3 (and possible 4 and 5) |        |
|        |      |   as many times as there are elements of the     |        |
|        |      |   same type.                                     |        |
+--------+------+--------------------------------------------------+--------+

Repeat the header record and the element records as many times as there are
different types of elements.

The end of element data records is signaled by an element ENDING record of the
following form, 8 words:

Words 1 and 2 form the word " -END-",
Word  4 holds the symbol "--",
and all other words are zeros

The ENDING ELEMENT RECORD of the FORMATTED tape looks like this:

--------++++++++--------++++++++--------++++++++--------++++++++---
"ELEMENT -END-     TYPE =   0  -- GRIDS =       0 TOTAL =       0 etc."

If the OUGV file is present, the displacement vectors will be processed and
the final results sent out to the OUTTP tape. (In this and the next few
paragraphs, the word "displacement" implies also velocity, acceleration, load,
grid point force, eigenvector, element stresses, and element forces.) The
input OUGV file must be one of the GINO files described in the INPUT DATA
BLOCKS section, which gives the displacements in the g-set or p-set, or the
other data types. The output data are sorted by their external grid ID
numbers. The displacement records in OUTTP also begin with an identification
record:

+--------+------+-------------------------------------------+--------+
| RECORD | WORD |    CONTENT (FORMATTED OR UNFORMATTED)     | FORMAT |
+--------+------+-------------------------------------------+--------+
|    1   |  1-2 |  "DISPLCNT--------" identification*. BCD  |   4A4  |
|        |      |  (* or "VELOCITY--------",                |        |
|        |      |        "ACCELERN--------",                |        |
|        |      |        "LOADINGS--------",                |        |
|        |      |        "G FORCES--------",                |        |
|        |      |        "EIGENVCR--------",                |        |
|        |      |        "E STRESS--------",                |        |
|        |      |        "E FORCES--------")                |        |
+--------+------+-------------------------------------------+--------+

The original displacement data in NASTRAN are always in the global coordinate
system. If the parameter BASIC is zero (default), the displacement vectors
will be passed over to OUTTP without changes. However, if the parameter is set
to +1, the displacement vectors will be converted to the basic rectangular
coordinate system. In this latter case, the coordinate transformation matrices
from CSTM will be brought into the computer, the grid point coordinate CID
will be identified, and proper coordinate transformation will be applied to
the displacements of each grid point. Again, the output OUTTP tape can be
formatted or unformatted. In the unformatted tape, each grid point and its
displacement values will form one logical record of 8 or 14 words (variable
word length if element stresses or element forces). In the formatted tape, one
logical record (8 words) is used if the displacement data is real, and an
additional record (for data words 9 through 14) if the data is complex. In
either case, a formatted record has 128-column of words. Similarly to the grid
and element sets of data, a HEADER record is written out to OUTTP first before
the grid point displacement vectors.

DISPLACEMENT HEADER RECORD FOR UNFORMATTED TAPE

+--------+--------+-------------------------------------------+
| RECORD |  WORD  |          CONTENT (UNFORMATTED)            |
+--------+--------+-------------------------------------------+
|    2   |  1     | Subcase or mode number. (Integer)         |
|        |  2     | Zero or frequency. (Real)                 |
|        |  3     | Number of words per entry in next record. |
|        | 4-5    | Original data file name, 2 BCD words      |
|        | 6-7    | " GLOBAL " if BASIC=0, 2 BCD words        |
|        |        | "  BASIC " if BASIC=1                     |
|        | 8-13   | CODE (See note below; 6 integers)         |
|        | 14-45  | Title,    32 BCD words                    |
|        | 46-77  | Subtitle, 32 BCD words                    |
|        | 78-109 | Label,    32 BCD words                    |
+--------+--------+-------------------------------------------+

NOTE: Each code word holds 8 digits. Therefore there are 48 digits, from
CODE(1) through CODE(6), and from left to right, they describe the data type
of the next displacement record:

   1 for integer
   2 for real, and
   3 for BCD

The first digit points to the first data word; 2nd, 3rd, 4th, etc. point to
2nd, 3rd, 4th data words, etc.

DISPLACEMENT RECORDS IN UNFORMATTED TAPE - IN ONE LONG RECORD:

+--------+-------+--------------------------------------------------+
| RECORD | WORD  |          CONTENT (UNFORMATTED)                   |
+--------+-------+--------------------------------------------------+
|    3   |  1    | No. of words (excluding this first word) in this |
|        |       | record. (Integer)                                |
|        |  2    | External grid point number. (Integer)            |
|        |  3    | Point type (1=grid pt.  2=scalar pt.             |
|        |       |             3=extra pt. 4=modal pt., integer)    |
|        | 4-9   | Displacements. (Real parts,                      |
|        |       | t1,t2,t3,r1,r2,r3, single precision real)        |
|        | 10-15 | (COMPLEX data only)                              |
|        |       | Displacements. (Imaginary parts,                 |
|        |       | t1,t2,t3,r1,r2,r3, single precision real)        |
|        |  :    | Repeat words 2 thru 9 (or 15) as many times as   |
|        |       | there are grid points in OUGV file               |
|    :   |  :    | Repeat record 3 as many times as there are       |
|        |       | subcases or frequencies                          |
+--------+-------+--------------------------------------------------+

DISPLACEMENT HEADER RECORD FOR FORMATTED TAPE

+--------+-------+------------------------------------------+-----------+
| RECORD | WORD  |        CONTENT (FORMATTED)               |  FORMAT   |
+--------+-------+------------------------------------------+-----------+
|    2   |  1-2  | " CASE = " or " MODE = "                 | 8 letters |
|        |    3  | Subcase number                           |     I8    |
|        |    4  | Zero or frequency                        | 1PE12.5   |
|        |  5-6  | " WORDS ="                               | 8 letters |
|        |    7  | NWDS, number of words per entry in next  |     I8    |
|        |       | record (=8 for REAL data, or =14 COMPLEX,|           |
|        |       | for all displacement records)            |           |
|        |  8-9  | " INPUT ="                               | 8 letters |
|        | 10-11 | Original GINO file name                  |    2A4    |
|        | 12-13 | " COORD ="                               | 8 letters |
|        | 14-15 | " BASIC  " or "GLOBAL  "                 |    2A4    |
|        | 16-17 | "  CODE ="                               | 8 letters |
|        | 18-22 | Format code                              |    5I8    |
|        |       | 8 digits per word,  1 for INTEGER        |           |
|        |       |                     2 for REAL           |           |
|        |       | Ex.  13222200       3 for BCD            |           |
|        |       |                     0 not applicable     |           |
|        |   23  | NA4, number of words per entry in next   |     I8    |
|        |       | record, in A4-word count                 |           |
|    3   | 1-32  | Title,    32 BCD words                   |   32A4    |
|    4   | 33-64 | Subtitle, 32 BCD words                   |   32A4    |
|    5   | 65-96 | Label,    32 BCD words                   |   32A4    |
+--------+-------+------------------------------------------+-----------+

DISPLACEMENT RECORDS IN FORMATTED TAPE - IN MULTIPLE SHORT RECORDS:

+--------+------+-----------------------------------------------+-----------+
| RECORD | WORD |                 CONTENT                       |  FORMAT   |
+--------+------+-----------------------------------------------+-----------+
|    6   |  1   |  External grid point number. (Integer)        |   I8      |
|        |  2   |  Point type (1=grid pt.  2=scalar pt.         |   I8      |
|        |      |  3=extra pt. 4=modal pt., integer)            |           |
|        | 3-8  |  Displacements. (Real parts,                  | 6E12.6    |
|        |      |  t1,t2,t3,r1,r2,r3, single precision real)    |           |
|    7   |      |  (COMPLEX DATA only)                          |           |
|        | 1-6  |  Displacements (Imaginary parts,              |16X,6E12.6 |
|        |      |  t1,t2,t3,r1,r2,r3, single precision real)    |           |
|    :   |  :   |  Repeat record 6 (records 6 and 7 if complex  |           |
|        |      |  data) as many times as there are grid points |           |
+--------+------+-----------------------------------------------+-----------+

At the end of each subcase, if the output tape OUTTP is formatted, a ZERO
record (two records if data is complex) is written out to OUTTP tape. This
ZERO record has the same format as a DISPLACEMENT record, and consists of 8 or
14 zeros (first two are integers, minus zeros). This ZERO record is not needed
in the unformatted OUTTP output tape.

Repeat the HEADER record, the DISPLACEMENT records, and the ZERO record
(formatted OUTTP tape only) as many times as there are subcases. At the end of
the last subcase, or end of the input file OUGV, an ENDING record is written
out. It has the same form as the HEADER record:

DISPLACEMENT ENDING RECORD

+--------+------+-------------------------------------------------------+
| RECORD | WORD |   CONTENT (UNFORMATTED)                               |
+--------+------+-------------------------------------------------------+
|  LAST  |   1  |   Zero. (Integer)                                     |
|        |   2  |   Zero. (Real)                                        |
|        |   3  |   Zero. (Integer)                                     |
|        | 4-5  |   " -END-".  (BCD)                                    |
|        |6-101 |   96 Blank words. (BCD)                               |
+--------+------+-------------------------------------------------------+

+--------+------+--------------------------------------+----------------+
| RECORD | WORD |      CONTENT (FORMATTED)             |     FORMAT     |
+--------+------+--------------------------------------+----------------+
|  LAST  | 1-2  |  " CASE = " or " MODE = "            |     8 letters  |
|        |   3  |  Minus 0 (Integer)                   |       I8       |
|        |   4  |  Zero                                |    1PE12.5     |
|        | 5-6  |  " WORDS ="                          |     8 letters  |
|        |   7  |  Minus 0 (Integer)                   |       I8       |
|        | 8-11 |  " INPUT = -END-  "                  |  16 letters    |
|        |12-17 |  Blanks                              |       4A4      |
| LAST+1 | 1-32 |  Blanks                              |      32A4      |
| LAST+2 | 1-32 |  BLANKS                              |      32A4      |
| LAST+3 | 1-32 |  Blanks                              |      32A4      |
+--------+------+--------------------------------------+----------------+

If OUGV is an element stress or an element force file, the stress or force
data have variable length depending on the type of element. The stress or
force records written to the OUTTP tape are therefore different from those of
the displacement records.

The element stress or force record has the following forms:

+--------+--------+------------------------------------------------------+
| RECORD | WORD   |          CONTENT (UNFORMATTED)                       |
+--------+--------+------------------------------------------------------+
|    3   |   1    |  Number of words, excluding this first word,         |
|        |        |  in this record. (Integer)                           |
|        |2-NWDS  |  Element ID, stress or force data                    |
|        |        |  (Variable data types are described in "CODE")       |
|        |   :    |  Repeat (2-NWDS) words as many times as there        |
|        |        |  are elements.                                       |
|    :   |   :    |  Repeat record 3 as many times as there are subcases.|
+--------+--------+------------------------------------------------------+

where NWDS is the number of computer words per entry, and CODE is the 6-word
format code, as described in header record.

or

+--------+--------+------------------------------------------------+------+
| RECORD | WORD   |        CONTENT (FORMATTED)                     |FORMAT|
+--------+--------+------------------------------------------------+------+
|    6   | 1-NA4  |  Element ID, stress or force data              | 33A4 |
|        |        |  (The data types are described in              |      |
|        |        |  "CODE"; all integers in 2A4, real             |      |
|        |        |  numbers in 3A4, and BCD in A4)                |      |
|    :   |   :    |  (Maximum record length is 132 columns (33A4); |      |
|        |        |  continuation into next record(s) if necessary)|      |
|    :   |   :    |  Repeat above record(s) as many times as there |      |
|        |        |  are elements                                  |      |
+--------+--------+------------------------------------------------+------+

where NA4 is the number of words per entry in A4-word count, and CODE is
5-word format code.

Notice that the DATABASE module does not copy out the external-internal grid
points table in EQEXIN file, nor the coordinate transformation matrices in
CSTM. The coordinate systems originally associated with the external grid
points are never mentioned in the OUTTP tape.

If you must copy the EQEXIN and CSTM files (both are in table forms), OUTPUT5
can be used.

Design Requirement

The DATABASE module is mapped in NASTRAN Links 2, 4, and 14. This module is
accessible only through a NASTRAN DMAP Alter. Minimum open core requirement =
10 x (total number of grid points) words.

The formatted outputs are flagged only by the parameter FORMAT. The formatted
output records are designed not to exceed 132 columns in length and include
printer carriage control. In most cases, I8-formats are used for integers and
E12.6 for real data (no double precision words used); and BCD words are in
multiples of 2A4. The entire OUTTP file can be printed, or it can be edited by
a system editor. The formatted OUTTP file, if written on magnetic tape by a
computer, can be used in another computer of a different manufacturer. The
unformatted OUTTP file is more efficient, and the integer and real data are
more accurate. The grid point data and data of each connecting element type
are written out unformatted in long records; that requires large working space
in the computer system. On the other hand, only short records are written to
the formatted OUTTP file, and the working space requirement is less critical.

Remarks
-------
1. Conversion of element stresses or forces to the basic coordinates is not
   allowed.

2. The mass matrix, MGG, can be one of the Oi input data blocks due to its
   special characteristics and application. The mass engineering data will be
   arranged in their external grid point order.

   The formatted and unformatted records of the mass data are arranged
   similarly to the grid point data, except the words 4, 5, 6 (X, Y, Z
   coordinates of the grid point) are replaced by mass-x, mass-y, mass-z,
   moment of inertia-x, moment of inertia-y, moment of inertia-z, words 4
   through 9.

Diagnostic Messages

Message numbers 3001, 3002, and 3008 may be issued by DATABASE.

GINOFILE - GINO File Creation
=============================
Purpose
-------
To capture data from a scratch file of a preceding DMAP module and copy the
data to a NASTRAN GINO file. Type of data can be table or matrix. (Not
available for CDC.)

DMAP Calling Sequence
---------------------
GINOFILE  /FILE/C,N,P1/C,N,P2/C,N,P3   $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
FILE       Any GINO output file name.

Parameters
----------
P1         Any 300-series scratch file number (301,302,303,...), Integer.

P2         Additional records to be skipped on P1 file before data transfer
           from P1 to FILE, Integer. GINOFILE will automatically skip over
           header record if a header record exists in P1, or it will not skip
           if it does not exist. (Default P2 = 0.) Data transfer starts from
           P2+1 record after header (or no header) record on scratch file.

P3         Last record to be copied, or up to an EOF mark on P1 file. Total
           number of records copied is (P3 - P2), Integer. (Default is to
           copy to EOF mark.)

Subroutine

GINOFL     Subroutine in GINOFILE module.

Method
------
At the end of a NASTRAN executable module, all the input files, output files,
and scratch files are closed. The input files are read only and they will
remain untouched. The output files are saved, and their names are preserved.
(The output file names are actually allocated before the beginning of the
module execution). The scratch files are released without any mechanism of
saving them. However, the data of the scratch files are still in the system
disc space, and will remain there until they are over-written by another part
(or another module) of the NASTRAN program. It is at this point that GINOFILE
module accesses a scratch file of the preceding module and copies the data to
a GINO output file, without changing the scratch file data. Tables or matrices
are copied the same way, as they exist in the original form on the scratch
file.

A NASTRAN GINO file always has a header record and a 6 word trailer. However,
the header record and the trailer are not required for a scratch file, and
they may or may not exist. The GINOFILE module will first test the header
record of the scratch file and skip over it, if it exists. A header record is
always generated by GINOFILE for the new GINO file. The beginning record and
the ending record where data are to be transferred are under user control.
Finally, a trailer for the output file is generated and saved. An EOF record
is written to the new GINO file at the completion of the module.

Design Requirement

The GINOFILE module is mapped in all NASTRAN Links, except LINK1. You can
request this module through a regular NASTRAN DMAP Alter.

You must request this module immediately following the DMAP module where the
scratch file was used. It is your responsibility to see that the Executive
Segment File Allocator, XSFA, does not come in between the preceding DMAP
module and this GINOFILE module. If XSFA does intervene before GINOFILE
execution, the FIAT/OSCAR table (see XSFA Module description in section 4.9)
is rearranged, and the scratch files are no longer accessible.

If XSFA does intervene, you can provoke the XSFA operation and FIAT/OSCAR
table rearrangement before the execution of preceding DMAP module so that XSFA
will not come in between this preceding and GINOFILE modules. The technique
here can involve a DMAP alter to PURGE some obsolete files, TABPT to print
some files that have been generated some time ago, and currently are not on
the FIAT/OSCAR table, or any other DMAP module that would disturb the NASTRAN
filing system. You could turn on DIAG 2 and observe the flow of the GINO files
created or allocated by XSFA/FIAT/OSCAR operation.

If the scratch file in the preceding DMAP module was used repeatedly such as
being used in a loop, only the "last-time-used" set of data on the scratch
file can be copied out by GINOFILE.

You should turn on DIAG 8,15,-n (where n is the current LINK number) and see
that the scratch file, FORTRAN unit number, and associated trailers are being
processed correctly.

Diagnostic Messages

Message numbers 3001, 3002, and 3008 may be issued by GINOFILE.

INPUT - Input Generator
=======================
Purpose
-------
Generates the majority of the bulk data cards for selected academic problems.
Used in many of the official NASTRAN Demonstration Problems.

DMAP Calling Sequence
---------------------
INPUT  I1,I2,I3,I4,I5 / 0l,02,03,04,05 / C,N,a / C,N,b / C,N,c $

Input Data Blocks
-----------------
Appropriate preface outputs.

Output Data Blocks
------------------
Appropriate for the problem being generated.

Parameters
----------
The three parameters are used in conjunction with data read by INPUT from the
input stream to define the problem being generated.

Method
------
Since INPUT is intimately related to bulk data card input, a detailed
description of this module has been placed in Section 2.6.

INPUTT1 - Read User Files
=========================
Purpose
-------
Recovers up to five data blocks from a user file (on either tapes or mass
storage devices) and checks your file label where the expected format is that
created by Utility Module OUTPUT1. Also used to position your file (including
handling of multiple reel tapes) prior to reading the data blocks. Multiple
calls are allowed. A message is written for each data block successfully
recovered and after each tape reel switch. (User tape reel switching is
available only on the IBM and UNIVAC versions.) (The companion module is
OUTPUT1.)

DMAP Calling Sequence
---------------------
INPUTT1 / DB1,DB2,DB3,DB4,DB5 / V,N,P1 / V,N,P2 / V,N,P3 / V,N,P4/ $

Input Data Blocks
-----------------
Input data blocks are not used in this module call statement.

Output Data Blocks
------------------
DBi        Data blocks which will be recovered from one of the NASTRAN
           permanent files INPT, INP1, INP2 through INP9. Any or all of the
           output data blocks may be purged. Only nonpurged data blocks will
           be taken from the file. The data blocks will be taken sequentially
           from the file starting from a position determined by the value of
           the first parameter. Note that the output data block sequence
           A,B,,, is equivalent to ,A,,B, or ,,,A,B.

Parameters
----------
Parameters P1 and P2 are integer inputs. P3 and P4 are BCD.

1. The meaning of the first parameter (P1) value is given in the table below.
   (The default value is 0.)

+-----------+----------------------------------------------------------+
|  P1 Value |                  Meaning                                 |
+-----------+----------------------------------------------------------+
|     +n    | Skip forward n data blocks before reading.               |
|           |                                                          |
|      0    | Data blocks are read starting at current position.       |
|           | Current position for first use of a file is at label     |
|           | (P3). Hence P3 counts as one data block.                 |
|           |                                                          |
|     -1    | Rewind before reading, position file past label (P3).    |
|           |                                                          |
|     -2*   | Mount new reel and position new reel past label (P3)     |
|           | before reading.                                          |
|           |                                                          |
|     -3    | Print data block names and then rewind before reading.   |
|           |                                                          |
|     -4*   | Current tape reel will have an end-of-file mark          |
|           | written on it, will be rewound and dismounted, and       |
|           | then a new tape reel will be mounted with ring out       |
|           | and rewound before reading the data blocks. This         |
|           | option should be used when a call to INPUTT1 is          |
|           | preceded by a call to OUTPUT1 using the same User Tape.  |
|           |                                                          |
|     -5    | Search user file for first version of data block         |
|           | (DBi) requested. If any (DBi) are not found, fatal       |
|           | termination occurs.                                      |
|           |                                                          |
|     -6    | Search user file for final version of data block         |
|           | (DBi) requested. If any (DBi) are not found, fatal       |
|           | termination occurs.                                      |
|           |                                                          |
|     -7    | Search user file for first version of data block         |
|           | (DBi) requested. If any (DBi) are not found, a           |
|           | warning message is written on the output file and the    |
|           | run continues.                                           |
|           |                                                          |
|     -8    | Search user file for final version of data block         |
|           | (DBi) requested. If any (DBi) are not found, a           |
|           | warning message is written on the output file and the    |
|           | run continues.                                           |
+-----------+----------------------------------------------------------+
----------
* Valid only for files that reside on physical tape. User tape reel switching is
available only on the IBM and UNIVAC versions.

2. The second parameter (P2) for this module is your File Code shown in the
   table below. (The default value is 0.)

+-----------------+------------------+
|  User File Code |  GINO File Name  |
+-----------------+------------------+
|         0       |        INPT      |
|         1       |        INP1      |
|         2       |        INP2      |
|         3       |        INP3      |
|         4       |        INP4      |
|         5       |        INP5      |
|         6       |        INP6      |
|         7       |        INP7      |
|         8       |        INP8      |
|         9       |        INP9      |
+-----------------+------------------+

3. The third parameter (P3) for this module is used as your File Label for
   NASTRAN identification. The label (P3) is an alphanumeric variable of eight
   characters or less (the first character must be alphabetic). The value of
   P3 must match a corresponding value on your file. The comparison of P3 and
   the value on your file is dependent on the value of P1 as shown in the
   table below. (The default value for P3 is XXXXXXXX).

+-----------+----------------------+
| P1 Value  |  File Label Checked  |
+-----------+----------------------+
|    +n     |          No          |
|     0     |          No          |
|    -1     |          Yes         |
|    -2     |    Yes (On new reel) |
|    -3     |   Yes (Warning Check)|
|    -4     |    Yes (On new reel) |
|    -5     |          Yes         |
|    -6     |          Yes         |
|    -7     |          Yes         |
|    -8     |          Yes         |
+-----------+----------------------+

4. If the fourth parameter, P4, is set to "MSC", the FORTRAN input tape is
   assumed to be written in MSC/INPUTT1 compatible record formats. Default is
   blank.

Examples
--------
(Most examples use the default value for P2 and P3 which means the use of
permanent NASTRAN file INPT and NASTRAN user file label of XXXXXXXX.)

1. INPUTT1  / A,B,,, / $

Read data blocks A and then B from user file INPT starting from wherever INPT
is currently positioned. If this is the first module to manipulate INPT, the
file will automatically be initially positioned at the beginning of your file
label. In this case, the first parameter of INPUTT1 must be set to either one
(1) to skip past the label or minus one (-1) to rewind the file and position
it at the beginning of the first data block (A).

2. INPUTT1  / ,,,, / C,N,-1 / C,N,3 $

Rewind INP3 and check user tape label.

3. INPUTT1  / A,,,, / C,N,-2 $

Mount a new reel of file (without write ring) for INPT and read data block A
from the first file position. The label of the new reel of tape will be
checked.

4. INPUTT1  / ,,,, / C,N,-2 $
   INPUTT1  / A,,,, / C,N,0 $

This is equivalent to example 3.

5. INPUTT1  / A,B,C,D,E / C,N,14 $

Starting from the current position, skip forward 14 data blocks on INPT and
read the next five data blocks into A, B, C, D, and E. Do not check your file
label.

6. INPUTT1  / ,,,, / C,N,-3 $
   INPUTT1 / A,B,C,D,E / C,N,14 $

A complete list of data block names will be provided including a warning check
of your file label. Then, it will be the same as example 5 only if the current
position in that example is at the beginning of the first data block.

7. INPUTT1  /  ,,,, / C,N,-2 $
   INPUTT1  /  ,,,, / C,N,-3 $
   INPUT    /  A,B,,, / C,N,14 $

Mount a new reel of tape for INPT and check the new reel's label. Print the
names of all data blocks on the new tape and give a warning check for tape
label. Read the 15th and 16th data blocks into A and B. INPT will end up
positioned at the beginning of the 17th data block if present.

More Difficult Examples Using Both INPUTT1 and OUTPUT1

Example 1
---------
a. Objectives:

   1. Obtain printout of the names of all data blocks on INPT.

   2. Skip past the first four data blocks, replace the next two with data
      blocks A and B, and retain the next three data blocks.

   3. Obtain printout of the names of all data blocks on INPT after 2 has been
      done.

b. DMAP Sequence:

BEGIN $                                     (1)
INPUTT1  / ,,,, / C,N,-3  $                 (2)
INPUTT1  / ,,T1,T2,T3 / C,N,6 $             (3)
INPUTT1  / ,,,, / C,N,-1  $                 (4)
OUTPUT1  A,B,T1,T2,T3 // C,N,4   $          (5)
OUTPUT1 , ,,,, // C,N,-3   $                (6)
END $                                       (7)

c. Remarks:

   1. DMAP sequence (2) accomplishes objective 1 and rewinds INPT.

   2. DMAP sequence (3) recovers data blocks 7, 8, and 9. This is necessary
      because they would be effectively destroyed by anything written in front
      of them on INPT.

   3. DMAP sequence (4) rewinds INPT.

   4. DMAP sequence (5) accomplishes objective 2.

   5. DMAP sequence (6) accomplishes objective 3 and leaves INPT positioned
      after the ninth file, ready to receive additional data blocks.

   6. Note that INPUTT1 is used whenever possible to avoid the possibility of
      mistakenly writing on INPT prematurely.

Example 2
---------
a. Objectives:

   1. Write data blocks A, B, and C on INPT.

   2. Obtain printout of the names of all data blocks on INPT after step 1.

   3. Make two copies of the file created in 1.

   4. Add data blocks D and E to one of the files.

   5. Obtain the names of all data blocks on INPT after 4.

b. DMAP Sequence:

BEGIN $                                     (1)
OUTPUT1 A,B,C,, // C,N,-1 $                 (2)
OUTPUT1 , ,,,, // C,N,-3 $                  (3)
OUTPUT1 A,B,C,, // C,N,-2  $                (4)
OUTPUT1 A,B,C,, // C,N,-2 $                 (5)
OUTPUT1 D,E,,, // C,N,0 $                   (6)
OUTPUT1 , ,,,, // C,N,-3 $                  (7)
END $                                       (8)

c. Remarks:

   1. DMAP Sequence (2) accomplishes objective 1.

   2. DMAP Sequence (3) accomplishes objective 2. The statement INPUTT1 / ,,,,
      / C,N,-3 $ will do the same thing and add a rewind.

   3. Statements (4) and (5) accomplish objective 3.

   4. Statement (6) accomplishes objective 4 where the third file tape is
      used.

   5. Statement (7) accomplishes objective 5. The statement INPUTT1 / ,,,, /
      C,N,-3 $ will do the same thing and add a rewind.

   6. On machines where tape reel switching is not implemented, the second
      parameter can be used as follows:

      BEGIN $
      OUTPUT1 A,B,C,, // C,N,-1 $
      OUTPUT1 , ,,,, // C,N,-3 $
      OUTPUT1 A,B,C,, // C,N,-1 / C,N,1 $
      OUTPUT1 A,B,C,, // C,N,-1 / C,N,2 $
      OUTPUT1 D,E,,, // C,N,0 / C,N,2 $
      OUTPUT1 , ,,,, // C,N,-3 / C,N,2 $
      END $

INPUTT2 - Read User-Written FORTRAN Files
=========================================
Purpose
-------
Recovers up to five data blocks from a FORTRAN-written user file (either on
tape or mass storage). This file may be written either by a user-written
FORTRAN program or by the companion module OUTPUT2. The Programmer's Manual
describes the format of the file which must be written in order to be readable
by INPUTT2.

DMAP Calling Sequence
---------------------
INPUTT2  / DB1,DB2,DB3,DB4,DB5 / V,N,P1 / V,N,P2 / V,N,P3 /V,N,P4 /
           V,N,P5 / V,N,P6 $

Input Data Blocks
-----------------
Input data blocks are not used in this module call statement.

Output Data Blocks
------------------
DBi        Data blocks which will be recovered from one of the NASTRAN
           FORTRAN tape files UT1, UT2, through UT5. Any or all of the output
           data blocks may be purged. Only non-purged data blocks will be
           taken from the file. The data blocks will be taken sequentially
           from the file starting from a position determined by the value of
           the first parameter. Note that the output data block sequence
           A,B,,, is equivalent to ,A,,B, or ,,,A,B.

Parameters
----------
Parameters P1, P2, P4, and P5 are integer inputs. P3 and P6 are BCD.

1. The meaning of the first parameter (P1) value is given in the table below.
   (The default value is 0.)

+-----------+----------------------------------------------------------+
|  P1 Value |                  Meaning                                 |
+-----------+----------------------------------------------------------+
|     +n    | Skip forward n data blocks before reading.               |
|           |                                                          |
|      0    | Data blocks are read starting at the current             |
|           | position. The current position for the first use of a    |
|           | file is at the label (P3). Hence, P3 counts as one       |
|           | data block.                                              |
|           |                                                          |
|     -1    | Rewind before reading, position file past label (P3).    |
|           |                                                          |
|     -3    | Print data block names and then rewind before            |
|           | reading.                                                 |
|           |                                                          |
|     -5    | Search user file for first version of data block         |
|           | (DBi) requested. If any (DBi) are not found, fatal       |
|           | termination occurs.                                      |
|           |                                                          |
|     -6    | Search user file for final version of data block         |
|           | (DBi) requested. If any (DBi) are not found, fatal       |
|           | termination occurs.                                      |
|           |                                                          |
|     -7    | Search user file for first version of data block         |
|           | (DBi) requested. If any (DBi) are not found, a           |
|           | warning message is written on the output file and the    |
|           | run continues.                                           |
|           |                                                          |
|     -8    | Search user file for final version of data block         |
|           | (DBi) requested. If any (DBi) are not found, a           |
|           | warning message is written on the output file and the    |
|           | run continues.                                           |
+-----------+----------------------------------------------------------+

Important NOTE
----
On the UNIVAC and DEC VAX versions, the FORTRAN files used with the
INPUTT2/OUTPUT2 modules are automatically rewound every time a link change
occurs in the program. In general, a link change can be assumed to occur
whenever a DMAP statement other than an INPUTT2 statement follows an INPUTT2
statement; similarly, whenever a DMAP statement other than an OUTPUT2
statement follows an OUTPUT2 statement. For this reason, the following
cautions should be noted on these versions when using the various values for
the parameter P1 in an INPUTT2 or OUTPUT2 DMAP statement.

+-----------------------------------------------------------------------+
|                 Cautions for UNIVAC and DEC VAX versions              |
+-----------------+-----------------------------------------------------+
|  Parameter P1   |                 Remarks                             |
+-----------------+-----------------------------------------------------+
|    0 or +n      |  You must be certain that this INPUTT2              |
|                 |  statement immediately follows another INPUTT2      |
|                 |  statement; or that this OUTPUT2 statement          |
|                 |  immediately follows another OUTPUT2 statement, to  |
|                 |  avoid a link change that would cause the           |
|                 |  rewinding of the FORTRAN file.                     |
|                 |                                                     |
|  -1 to -8       |  No cautions.                                       |
|                 |                                                     |
|      -9         |  You must be certain that this OUTPUT2              |
|                 |  statement immediately follows another OUTPUT2      |
|                 |  statement, to avoid a link change that would       |
|                 |  cause the rewinding of the FORTRAN file.           |
+-----------------+-----------------------------------------------------+

2. The second parameter (P2) for this module is the FORTRAN unit number from
   which the data blocks will be read. The allowable values for this parameter
   are highly machine- and installation-dependent. Reference should be made to
   Section 4 of the Programmer's Manual for a discussion of this subject.

   For CDC machine (default is 11):

+----------------+--------------------+
| User File Code |  FORTRAN File Name |
+----------------+--------------------+
|        11      |         UT1        |
|        12      |         UT2        |
+----------------+--------------------+

   For all others (default is INPT):

+----------------+--------------------+
| User File Code |  FORTRAN File Name |
+----------------+--------------------+
|        14      |        INPT        |
|        15      |        INP1        |
|        16      |        INP2        |
|        :       |         :          |
|        23      |        INP9        |
+----------------+--------------------+

   IBM/MVS only: INPT is user file code 24.

3. The third parameter (P3) for this module is used as the FORTRAN User File
   Label for NASTRAN identification. The label (P3) is an alphanumeric
   variable of eight characters or less (the first character must be
   alphabetic). The value of P3 must match a corresponding value on the
   FORTRAN user file. The comparison of P3 and the value on your file is
   dependent on the value of P1 as shown in the table below. (The default
   value for P3 is XXXXXXXX.)

+----------------+--------------------+
|     P1 Value   | File Label Checked |
+----------------+--------------------+
|        +n      |         No         |
|         0      |         No         |
|        -1      |         Yes        |
|        -3      | Yes (Warning Check)|
|        -5      |         Yes        |
|        -6      |         Yes        |
|        -7      |         Yes        |
|        -8      |         Yes        |
+----------------+--------------------+

4. The fourth parameter (P4) is not used. P4 is used only in the OUTPUT2
   module to specify the maximum record size.

5. If the fifth parameter (P5) is non-zero, the FORTRAN tape was written with
   sparse matrix format by the OUTPUT2 module. Therefore, the P5 parameters
   for INPUTT2 and OUTPUT2 should be set the same.

   Default P5 is zero.

6. If the sixth parameter (P6) is set to "MSC", INPUTT2 will process the
   FORTRAN input tape as if it were generated previously from an MSC/OUTPUT2
   run.

   Default P6 is blank.

Examples
--------
INPUTT2 is intended to have the same logical action as the GINO User File
module INPUTT1 except for tape reel switching. It is therefore suggested that
the examples shown under module INPUTT1 be used for INPUTT2 as well, excepting
the ones involving tape reel switching.

INPUTT3 - Auxiliary Input File Processor

Purpose
-------
Reads matrix data from a specially formatted file into specified GINO matrix
data blocks.

DMAP Calling Sequence
---------------------
INPUTT3   /01,02,03,04,05/ V,N,UNIT/ V,N,ERRFLG/ V,N,TEST $

Input Data Blocks
-----------------
No GINO data blocks. See parameter UNIT for FORTRAN input unit.

Output Data Blocks
------------------
0i         GINO written matrix data blocks. Any or all of the output data
           blocks may be purged.

Parameters
----------
UNIT       Input, FORTRAN input tape unit number; default is 11. Tape is
           rewound before read if UNIT is negative.

ERRFLG     Input, error control:

           = 1, job terminated if data block on tape not found.
           = 0, no termination if data block not found.

TEST       Input, file name check:

           = 1, will search tape for DMAP 0i tape match.
           = 0, no check of file names on tape and DMAP 0i names.

Remarks
-------
1. Input tape unit must be written according to special format specification,
   including header, end-of-data mark, and matrix data.

INPUTT4 - Read User Tape
========================
Purpose
-------
Reads user tape, as generated by OUTPUT4, MSC/NASTRAN/OUTPUTi, where i = 1, 2,
3, or 4. Recovers up to five matrix data blocks from a user tape and checks
your tape label where the expected format is that created by utility modules
OUTPUT1, OUTPUT2, or OUTPUT4 of the MSC/NASTRAN. (Your tape may reside either
on physical tape or on mass storage devices.) Also used to position your tape
prior to reading the data blocks. Multiple calls to INPUTT4 are allowed. A
message is written for each data block successfully recovered. User tape from
OUTPUT1 and OUTPUT2 is binary. Tape from OUTPUT4 can be binary or ASCII.

DMAP Calling Sequence
---------------------
INPUTT4   / DB1,DB2,DB3,DB4,DB5 / V,N,P1 / V,N,P2 / V,N,P3 / V,N,P4 $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
DBi              Data blocks which will be recovered from one of the NASTRAN
                 permanent files INPT, INP1, INP2 through INP9 (UT1 or UT2
                 for CDC machine). Any or all of the output data blocks may
                 be purged. Only non-purged data blocks will be taken from
                 the file. The data blocks will be taken sequentially from
                 the file starting from a position determined by the value of
                 the first parameter. Note that the output data block
                 sequence A,B,,, is NOT equivalent to ,A,,B. A purged file on
                 the output data block list will cause skipping of one data
                 block on the input tape. (See Example 1.)

Parameters
----------
Parameters P1, P2, and P4 are integer inputs. P3 is BCD.

P1               Tape position control.
                 See P1 of INPUTT1 module if P4 is -1.
                 See P1 of INPUTT2 module if P4 is -2.
                 If P4 is greater then -1, P1 takes on following
                 meanings:
                       P1 = -3, print data block names on tape, then
                       rewind before reading.
                       P1 = -2, rewind tape at end.
                       P1 = -1, rewind tape before reading.
                       P1 =  0, read tape starting from current tape
                       position.
                       P1 =  n, skip forward n records (plus tape
                       header record if it exists) starting at current
                       tape position.

P2               FORTRAN input tape number. P2 is positive if tape was
                 written in binary records, and is negative if in ASCII
                 records.

P3               Tape label. Default is "XXXXXXXX". P3 is used only
                 when P4 = -1 or -2.

P4               Tape module control, Integer.
                 P4 = -1, tape was originally written by MSC/OUTPUT1
                 module.
                 P4 = -2, tape was originally written by MSC/OUTPUT2
                 module.
                 P4 = -4, tape was originally written by MSC/OUTPUT4
                 module.
                 P4 =  0, tape was written by OUTPUT4 module (default).
                 P4 >= 1, see Remarks 6 and 7.

Parameters equivalence for COSMIC/INPUTT4 and MSC/INPUTT4/OUTPUT4:

                 COSMIC/INPUTT4         MSC/INPUTT4/OUTPUT4
                 --------------         -------------------
                 P1                     NMAT (number of matrices on tape)
                 P2                     P2
                 P3                     P1
                 P4                     BCDOPT

Methods
-------
If the input tape was created by MSC/OUTPUT1, INPUTT4 calls COSMIC/INPUTT1
module to read the tape, with additional information that the tape was not
created by COSMIC/OUTPUT1 module. Similarly, INPUTT4 module calls
COSMIC/INPUTT2 to process the MSC/OUTPUT2 tape.

If the input tape was created by COSMIC or MSC OUTPUT4 module, INPUTT4 module
calls a special subroutine, INPUT4, to read the tape, formatted (ASCII), or
binary (unformatted).

Examples
--------
1.    Input tape INP1 (logical unit 15) contains 5 matrices, written by COSMIC
      or MSC/OUTPUT4, binary format. We want to copy file 3 to A, and file 5
      to B.

      INPUTT4   /,,A,,B/-1/15   $ REWIND, READ & ECHO HEADER RECORDS

2.    To copy the first 2 files of a formatted tape INP2 (unit 16), written by
      COSMIC/OUTPUT4, formatted.

      INPUTT4   /A,B,,,/-1/-16  $

3.    Print the data block names on INP3 tape (Tape Code 3), rewind, and copy
      files 2 and 3 of an INP3 tape written by MSC/OUTPUT1. Tape contains a
      header record (record 0), and tape id "MYFILE".

      INPUTT4   /,A,B,,/-3/3/*MYFILE*/-1  $

Remarks
-------
1.    Companion OUTPUT4 module does not generate OUTPUT1 or OUTPUT2 type of
      records.

2.    GINO buffer sizes in COSMIC/NASTRAN and MSC/NASTRAN must be
      synchronized. See NASTRAN BUFFSIZE option.

3.    INPUTT4 module cannot accept mixed output files from MSC/OUTPUT1,
      OUTPUT2 and OUTPUT4 on one input tape.

4.    INPUTT4 module may not process ASCII records correctly from an
      MSC/OUTPUT4 input tape, due to insufficient information in the MSC
      User's Manual.

5.    INPUTT4 module does not handle any table data block, including the six
      special tables KELM, MELM, BELM, KDICT, MDICT, and BDICT, that are
      handled specially in the OUTPUT4 module.

6.    If the input tape is written in ASCII records (P2 < 0 and P4 > 0), the
      following formats are used to read the tape:

           If P4=1, integers are read in I13, and single precision real data
           in 10E13.6, or integers are read in I16, and double precision real
           data in 8D16.9. The selection of formats must agree with the P3
           setting in OUTPUT4 module, or the precision of the matrix on input
           tape.

           If P4=2, integers are read in I16, and single precision real data
           in 8E16.9. This option is available only for machines with long
           word size, 60 bits or more per word.

           The matrix header record is read in by (1X,4I13,5X,2A4).

7.    See OUTPUT4 module for record construction.

8.    The tape label P3 is not used in INPUTT4 and OUTPUT4.

INPUTT5 - Read User-Written FORTRAN File
========================================
Purpose
-------
Recovers up to five data blocks from a FORTRAN-written user file, formatted or
unformatted. (The FORTRAN file may reside either on physical tape or on a mass
storage device.) This file may be written either by a user-written FORTRAN
program or by the companion module OUTPUT5. The Programmers' Manual describes
the format of your tape which must be written in order to be readable by
INPUTT5. The unformatted binary tape can only be read by a computer of the
same manufacturer as the one that created the tape. The formatted tape can be
created and read by different computers (CDC, UNIVAC, IBM, and VAX). The data
blocks to be recovered can be matrices, tables, or both.

DMAP Calling Sequence
---------------------
INPUTT5  /DB1,DB2,DB3,DB4,DB5/C,N,P1/C,N,P2/C,N,P3/C,N,P4 $

INPUTT5 is intended to have the same logical action as the FORTRAN User File
module INPUTT2 and the GINO User File module INPUTT1 except for formatted
tape. It is therefore suggested that the examples shown under modules INPUTT2
and OUTPUT1 be used for OUTPUT5 as well, excepting the addition of the P4
parameter.

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
DBi        Data blocks which will be recovered from one of the NASTRAN tape
           files INP1, INP2 through INP9 (UT1, UT2 for CDC computer). Any or
           all of the output data blocks may be purged. Only non-purged data
           blocks will be taken from your tape. The data blocks will be taken
           sequentially from the tape starting from a position determined by
           the value of the first parameter. Note that any purged output file
           will cause skipping of a corresponding file in your input tape.
           The output data block sequence A,B,,, is not equivalent to ,A,,B,
           or ,,,A,B.

Parameters
----------
1. The meanings of the first three parameter values (P1, P2, P3) are the same
   as those described for INPUTT2 Module, except (1) values -5 through -8 for
   P1 are not available, and a new P1=-9 to rewind input tape; and (2) your
   file code and the FORTRAN file name are given below. (The default value for
   P2 is 16, or 12 for a CDC computer.)

+------------------+------------------------+
| FORTRAN LOGICAL  |                        |
|    UNIT, P2      |     USER FILE CODE     |
+------------------+------------------------+
|       11         |     UT1 (CDC only)     |
|       12         |     UT2 (CDC only)     |
|       14         |     INPT (UNIVAC,VAX)  |
|       15         |     INP1 (All          |
|       16         |     INP2  machines     |
|        :         |       :   except       |
|       23         |     INP9  CDC)         |
|       24         |     INPT (IBM only)    |
+------------------+------------------------+

2. The fourth parameter (P4) for this module is used to specify whether your
   tape was written with formats (P4=1 or 2), or binary tape (P4=0). Default
   is P4=0.

   On the formatted tape, the selection of formats for real data must be
   consistent with the precision of the matrix data block coming from the
   input tape. If P4=1, and the matrix is in single precision, format 10E13.6
   is used.

   If the matrix is in double precision and P4=1, 5D23.17 is selected. Format
   I13 is used for integers in both cases.

   For machines with long words only, 60 bits or more per word, the single
   precision format can be switched to 5E23.17 for numeric accuracy by setting
   P4 to 2.

   A fatal error in reading the input tape may occur if P4 is set erroneously
   with respect to the content of the tape.

Methods
-------
Since INPUTT5 is intended to be a companion module to OUTPUT5, it is therefore
suggested that you should refer to the Methods and Remarks sections of the
OUTPUT5 module for input tape structure.

Subroutine INPTT5 is the main driver for the INPUTT5 module. Its primary
function is to read matrix data blocks from your input tape. When a table data
block is encountered, INPTT5 calls subroutine TABLEV to process the data. Your
input tape always begins with a tape ID record which tells when the tape was
generated, on what machine, tape identification, formatted or unformatted
tape, and NASTRAN system buffer size. This tape ID record can be skipped, or
read by the following FORTRAN code:

       INTEGER TAPEID(2),MACHIN(2),DATE(3),BUFSIZ,P4X
       READ (TAPE   ) TAPEID,MACHIN,DATE,BUFSIZ,P4X   or
       READ (TAPE,10) TAPEID,MACHIN,DATE,BUFSIZ,P4X
   10  FORMAT (2A4,2A4,3I8,I8,I8)

Unformatted Tape

The rest of the unformatted tape can be read by the following FORTRAN code:

   READ (TAPE) L,J,K,(ARRAY(I),I=J,K)

where L is a control word:
   L  = 0, ARRAY contains matrix (or table) header record
      = +n, ARRAY contains data for the nth column of the matrix
      = -1, ARRAY contains end of matrix record.
The ARRAY below J and above K are zeros.

The matrix header record and the table header record (L=0) differ only on the
5th and 6th words of ARRAY. If both words are zeros, it is a table header, and
the entire table data can be read by:

   READ (TAPE) L,(ARRAY(I),I=1,L)

where ARRAY may contain integers, BCD words, and real single and double
precision numbers.

Table data ends with a (1,0.0) record.

Formatted Tape

For matrix data, the rest of the formatted tape can be read by:

       READ (TAPE,20) L,J,K,(ARRAY(I),I=J,K)
   20  FORMAT (3I8,/,(10E13.6))    (for single precision data), or
   20  FORMAT (3I8,/,(5D26.17))    (for double precision data), or
   20  FORMAT (3I8,/,(5E26.17))    (P4 = 2)

where the control words L, J, and K are the same as in the unformatted case,
and the data type, single or double precision, is determined already by the
4th word of the matrix trailer embedded in the matrix header record. (See
Remark 5 of OUTPUT5 module)

For table data, the rest of the formatted tape can be read by:

       CHARACTER*5 ARRAY(500)
       READ (TAPE,30) J,(ARRAY(I),I=1,J)
   30  FORMAT (I10,24A5,/,(26A5))

Notice the formatted record was written in the units of 5-byte character
words, and the first byte of each unit indicates what data type follows. The
following table summarizes the method to decode the character data in ARRAY.

+------------+-------------+-------------+----------+
|            |  DATA TYPE  |             |          |
| FIRST BYTE |  OF ARRAY   | UNITS USED  | FORMAT   |
+------------+-------------+-------------+----------+
|     "/"    |  BCD word   |      1      |   A4     |
|     "I"    |  Integer    |      2      |   I9     |
|     "R"    |  Real, s.p. |      3      |  E14.7   |
|     "D"    |  Real, d.p. |      3      |  D14.7   |
|     "X"    |  Filler     |      1      |   4X     |
+------------+-------------+-------------+----------+

Table data ends with a (1,"0") record.

Examples
--------
$  COPY KJI AND KGG TO INP1 (UNIT 15), SEQUENTIAL FORMATTED TAPE
   OUTPUT5 KJI,KGG,,,//-1/15/*MYTAPE*/1  $

$  RECOVER THE 2 FILES FROM INP1 AND MAKE THEM NASTRAN GINO FILES
   INPUTT5 /OKJI,OKGG,,,/-1/15/*MYTAPE*/1  $

Remarks
-------
1. Since open core is used to receive data from user input tape, INPUTT5 can
   handle all kinds and all sizes of data blocks.

2. UNIVAC and VAX users should read the Important Note at the end of the
   description of the INPUTT2 module.

3. If you assemble your own matrix in INPUTT5 format, and use the INPUTT5
   module to read it into NASTRAN, be sure that the density term (DENS) of the
   matrix trailer is set to nonzero. Otherwise your matrix will be treated as
   a table and everything goes haywire.

4. Since INPUTT5 is a companion module of OUTPUT5, it is recommended that you
   read the Methods and Remarks sections of the OUTPUT5 module.

LAMX - LAMA Data Block Editor or Generator
==========================================
Purpose
-------
Allows modification of mode frequencies, which is useful in dynamics rigid
formats. This can be used, for example, to test the effects of structural
uncertainties. It does not require a new eigensolution.

DMAP Calling Sequence
---------------------
LAMX   EDIT,LAMA/LAMB/C,Y,NLAM $

Input Data Blocks
-----------------
EDIT       The editing instruction in the form of a DMI matrix.
LAMA       An output of the READ module which contains frequencies and
           generalized masses. If purged, the output is generated solely from
           EDIT information.

Output Data Blocks
------------------
LAMB       An edited version of LAMA, which is suitable for input to GKAM and
           OFP modules, or a matrix from LAMA.

Parameters
----------
NLAM       Integer. The maximum number of modes in the output data block. If
           NLAM = 0, the number of modes in LAMB is equal to that of LAMA. If
           NLAM < 0, LAMB will be a matrix.

Method
------
The DMI matrix (named EDIT in the above calling sequence) has one column for
each mode. Each column has, at most, three entries (rows). Let R1n, R2n, and
R3n be the entries in the first through third rows of the nth column. The nth
column will edit the frequency fn and the generalized mass mn of the nth mode.
The rules defined below are such that a null column produces no change, while
either a fixed frequency shift or a percentage change may be specified.

1. If R3n < 0, delete the mode and decrease the mode number of higher modes.

2. If R3n >= 0

   Frequency = Rln + (1 + R2n)fn

                      �
                      � mn   , R3n = 0
   Generalized mass = � R3n  , R3n > 0
                      �

The change for generalized mass is ignored unless data block MI is purged. The
module will generate a LAMB data block if the second input is purged.

   Frequency = R1n

   Generalized mass = R3n

This second option is useful if modes are created external to NASTRAN and are
input into the program via USER modules or DMI Bulk Data cards.

If NLAM is less than zero, a matrix will be built on LAMB. EDIT is ignored,
and columns will be built with eigenvalue, omega, frequency, generalized mass,
and generalized stiffness until the generalized mass is zero. The number of
rows should then match the number of eigenvectors requested.

Remarks
-------
1. LAMA may be purged. If LAMA is purged, than a LAMB is created from the EDIT
   information.

Examples
--------
1. Assume that ten modes were found by READ and it is desired to do the
   following:

   1 - 3  Leave alone
     4    Multiply frequency by .8
     5    Leave alone
     6    Delete
     7    Replace frequency by 173.20
     8    Delete

   The ALTER would be:

   ALTER    XX
   LAMX     LLLL,LAMA/LAMB/C,N,7 $
   EQUIV    LAMB, LAMA/ALWAYS

   This ALTER must be placed after READ and before GKAM. The DMI Bulk Data
   card would be:

    1        2       3       4       5       6       7       8       9     10
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |LLLL   |0      |2      |1      |1      |       |3      |7      |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |LLLL   |4      |1      |0.     |-.2    |       |       |       |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |LLLL   |6      |1      |0.     |0.     |-1.    |       |       |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |LLLL   |7      |1      |173.20 |-1.    |       |       |       |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+

2. Create a LAMA with fi = 10., 20., 30., 40., and mi = 1., 1., 1., 2.

   ALTER   XX
   LAMX    EDIT,/LAMA $ DEFAULT PARAMETER IS ZERO.
   OFP     LAMA,,,,,// $

    1        2       3       4       5       6       7       8       9     10
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |EDIT   |0      |2      |1      |1      |       |3      |4      |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |EDIT   |1      |1      |10.    |0.     |1.     |       |       |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |EDIT   |2      |1      |20.    |0.     |1.     |       |       |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |EDIT   |3      |1      |30.    |0.     |1.     |       |       |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |EDIT   |4      |1      |40.    |0.     |2.     |       |       |     |
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+

MATGPR - Structural Matrix Printer
==================================
Purpose
-------
Prints matrices generated by a Solution Sequence. External grid
point/component identification of each nonzero element is printed.

DMAP Calling Sequence
---------------------
A. For matrices whose degrees of freedom relate to grid or scalar points:

   MATGPR  GPL,USET,SIL,M//C,N,c/C,N,r/V,N,PRNTOPT=ALL/V,N,TINY=1.E-6/V,N,F1 $

B. For matrices whose degrees of freedom relate to grid, scalar, or extra
   points:

   MATGPR  GPLD,USETD,SILD,M//C,N,c/C,N,r/V,N,PRNTOPT=ALL/V,N,TINY=1.E-2/
           V,N,F1 $

Input Data Blocks
-----------------
GPL        Grid Point List

GPLD       Grid Point List (Dynamics)

USET       u-set

USETD      u-set (Dynamics)

SIL        Scalar Index List

SILD       Scalar Index List (Dynamics)

M          Any displacement approach matrix

Output Data Blocks
------------------
None

Parameters
----------
c          row size (number of columns); must be the appropriate BCD value
           from the table in Section 1.4.10. Input, no default. 

r          column size (number of rows); must be the appropriate BCD value
           from the table in Section 1.4.10. If not specified, it will be
           assumed that r=c. Input, default = X, which implies r=c. 

PRNTOPT    Must be one of the following BCD values: 

           NULL  Only null columns will be printed and identified.

           ALL   Standard MATGPR printout (default).

           ALLP  Standard MATGPR printout (complex numbers are converted to
                 magnitude/phase). 

TINY       Real-default = 0.0. If F1 = 0 and TINY > 0, printed output will be
           provided only for those matrix terms, aij, that satisfy the
           relation |aij| > TINY. If F1 = 0 and TINY < 0, printed output will
           be provided only for those matrix terms, aij, that satisfy the
           relation |aij| < |TINY|. If TINY = 1.E37, MATGPR will return. If
           F1 is nonzero, see the following description of F1.

F1         Real-default = 0.0. If F1 is not zero, then printed output will be
           provided for only those matrix terms that satisfy aij > TINY or
           aij < 0.0. 

Remarks
-------
1. When using the form specified in DMAP Calling Sequence A, this module may
   not be scheduled until after GP4 since data blocks generated by GP4 are
   required inputs. When using the form specified in DMAP Calling Sequence B,
   this module may not be scheduled until after DPD since data blocks
   generated by DPD are required inputs. 

2. If [M] is purged, no printing will be done.

3. The nonzero terms of the matrix will be printed along with the external
   grid point and component identification numbers corresponding to the row
   and column position of each term. 

Examples
--------
Display terms of KGG:

   MATGPR     GPL,USET,SIL,KGG//G $

Display null columns of KLL:

   MATGPR     GPL,USET,SIL,KLL//L/L/NULL $

Display small terms on diagonal of LOO:

   DIAGONAL   LOO/LOOD $
   MATGPR     GPL,USET,SIL,LOOD//H/O//-1.E-2 $

Display PHIA, H columns by A rows:

   MATGPR     GPL,USET,SIL,PHIA//H/A $

Also good for any single column

Display all terms of KGG outside the range of 0 through 107: 

   MATGPR     GPL,USET,SIL,KGG//G/G//1.E7/1.E1 $ 

MATPRN - General Matrix Printer

Purpose
-------
To print general matrix data blocks.

DMAP Calling Sequence
---------------------
MATPRN   M1,M2,M3,M4,M5 // C,N,P1/C,N,P2/C,N,P3/C,N,P4/C,N,P5  $

Input Data Blocks
-----------------
Mi         Matrix data blocks, any of which may be purged.

Output Data Blocks
------------------
None.

Parameters
----------
P1 and P2 are print format controls.

P1    = 0, matrices are printed in their original precision (default).
      = 1, matrices are printed in single precision (for example, x.xxxE+xx).
      = 2, matrices are printed in double precision (for example, -x.xxxD+xx).
      = -1, only the diagonal elements of the matrix will be printed in their
      original precision.

P2    number of data values printed per line (132 column print line).
      = 8 to 14 if matrices are printed in single precision (default is 10).
      = 6 to 12 if matrices are printed in double precision (default is 9).

P3, P4, and P5 are printout controls, to allow only a portion of the matrix to
be printed.

P3    = m, matrix columns 1 through m will be printed.
      = 0, all matrix columns will be printed (default).
      = -m, see P4 = -n.

P4    = n, last n matrix columns will be printed. Default = 0.
      = -n, and P3 = -m, every other n matrix columns will be printed,
      starting from column m.

P5    = k, each printed column will not exceed k lines long and the remaining
      data will be omitted. For example, 40 data values will be printed if
      P2=10 and P5=4.

Output
------
The nonzero band of each column of each input matrix data block is unpacked
and printed in single precision.

Remarks
-------
1. Any or all input data blocks can be purged.

2. If any data block is not matrix type, the TABPT routine will be called.

Examples
--------
1. MATPRN   KGG,,,, // $

2. MATPRN   KGG,PL,PG,BGG,UPV // $

MATPRT - Matrix Printer
=======================
Purpose
-------
To print matrix data blocks associated with grid points only.

DMAP Calling Sequence
---------------------
MATPRT   X // C,N,rc / C,N,y $

Input Data Blocks
-----------------
X          Matrix data block to be printed. If [X] is purged, then nothing is
           done.

Output Data Blocks
------------------
None.

Parameters
----------
rc         indicates whether [X] is stored by rows (rc = 1) or by columns (rc
           = 0) (Input-Integer, default value = 0).

y          indicates whether [X] is to be printed even if not purged (y < 0,
           do not print [X]; y >= 0, print [X] (Input-Integer, default value
           = 0).

Method
------
Each column (or row) of the matrix is broken into groups of 6 terms (3 terms
if complex) per printed line. If all the terms in a group = 0, the line is not
printed. If the entire column (or row) = 0, it is not printed. If the entire
matrix = 0, it is not printed.

Remarks
-------
1. MATPRT should not be used if scalar or extra points are present. For this
   case, use MATPRN.

2. Only one matrix data block is printed by this instruction. However, the
   instruction may be repeated as many times as required.

NORM - Normalize a Matrix
=========================
Purpose
-------
To normalize a matrix, each vector by its largest element. To compute the
square root of the sum of the squares for each row of a matrix (SRSS).

DMAP Calling Sequence
---------------------
NORM    PHIG/PHIG1/V,N,NCOL/V,N,NROW/V,N,XNORM/V,N,IOPT $

Input Data Blocks
-----------------
PHIG       Any matrix (real or complex)

Output Data Blocks
------------------
PHIG1      IOPT=1, copy of PHIG such that for any columnj||max(aij)|| for all
           i = 1.0.
           IOPT=2, contains a single column {ai} where

                             NCOL         _
               ai  =  SQRT (  -     (uij * uij) )
                             j=1

           where uij are the terms in the matrix PHIG and ij are the complex
           conjugates.

Parameters
----------
NCOL       Integer-output-default = 0. Number of columns in PHIG.

NROW       Integer-output-default = 0. Number of rows in PHIG.

XNORM   Real-output-default = 0.0. Maximum (absolute value) normalizing value
        over all columns.

IOPT       Integer-input-default = 1. IOPT=1, normalize by largest element;
           IOPT=2, compute SRSS.

Examples
--------
Normalize PHIG so that the maximum deflection is 1.0 (or -1.0):

   EQUIV    PHIG,PHIG1/NEVER $
   NORM     PHIG/PHIG1/ $
   CHKPNT   PHIG1 $
   EQUIV    PHIG1,PHIG/ALWAYS $
   CHKPNT   PHIG $

OUTPUT1 - Create User Files
===========================
Purpose
-------
Writes up to five data blocks and a user file label onto a user file (either
on tape or mass storage) for use at a later date. (See User Module INPUTT1 for
recovery procedures.) OUTPUT1 is also used to position your file (including
handling of multiple reel tapes--user tape reel switching is available only on
IBM and UNIVAC versions) prior to writing the data blocks. Multiple calls are
allowed. A message is written on the output file for each data block
successfully written and after each tape reel switch. You are cautioned to be
careful when positioning a user file with OUTPUT1 since you may inadvertently
destroy information through improper positioning. Even though no data blocks
are written, an EOF will be written at the completion of each call, which has
the effect of destroying anything on the file forward of the current position.

DMAP Calling Sequence
---------------------
OUTPUT1   DB1,DB2,DB3,DB4,DB5 // V,N,P1 / V,N,P2 / V,N,P3 $

Input Data Blocks
-----------------
DBi        Any data block which you desire to be placed on one of the NASTRAN
           permanent files INPT, INP1, INP2 thru INP9. Any or all of the
           input data blocks may be purged. Only nonpurged data blocks will
           be placed on the file.

Output Data Blocks
------------------
None.

Parameters
----------
1. The meaning of the first parameter (P1) value is given in the table below.
   (The default value is O.)

+-----------+----------------------------------------------------------+
|  P1 Value |                  Meaning                                 |
+-----------+----------------------------------------------------------+
|     +n    | Skip forward n data blocks before reading.               |
|           |                                                          |
|      0    | Data blocks are read starting at the current             |
|           | position. The current position for the first use of a    |
|           | file is at the label (P3). Hence, P3 counts as one       |
|           | data block.                                              |
|           |                                                          |
|     -1    | Rewind before writing. (This is dangerous!) An EOF is    |
|           | written at the end of each call to OUTPUT1.              |
|           |                                                          |
|     -2    | Valid only for files residing on physical tape.          |
|           | Mount new reel before writing. An EOF mark is written    |
|           | on the tape to be switched. Be careful when switching    |
|           | from a user tape being read by INPUTT1 to a tape to be   |
|           | written by OUTPUT1.                                      |
|           |                                                          |
|     -3    | Rewind files, print data block names, and then write     |
|           | after the last data block on the file.                   |
|           |                                                          |
|     -4    | Valid only for files residing on physical tape.          |
|           | Current tape reel will be rewound and dismounted and     |
|           | a new tape reel will be mounted with ring in and         |
|           | rewound before writing the data blocks. This option      |
|           | should be used when a call to OUTPUT1 is preceded        |
|           | by a call to INPUTT1 using the same User Tape.           |
+-----------+----------------------------------------------------------+

2. The second parameter (P2) for this module is your File Code shown in the
   table below. (The default value is 0.)

+-----------------+------------------+
|  User File Code |  GINO File Name  |
+-----------------+------------------+
|         0       |        INPT      |
|         1       |        INP1      |
|         2       |        INP2      |
|         3       |        INP3      |
|         4       |        INP4      |
|         5       |        INP5      |
|         6       |        INP6      |
|         7       |        INP7      |
|         8       |        INP8      |
|         9       |        INP9      |
+-----------------+------------------+

3. The third parameter (P3) for this module is used to define your File Label.
   The label is used for NASTRAN identification. The label (P3) is an
   alphanumeric variable of eight or less characters (the first character must
   be alphabetic) which is written on your file. The writing of this label is
   dependent on the value of P1 as follows (The default value for P3 is
   XXXXXXXX).

+-----------+----------------------+
| P1 Value  |  File Label Written  |
+-----------+----------------------+
|    +n     |          No          |
|     0     |          No          |
|    -1     |          Yes         |
|    -2     |    Yes (On new reel) |
|    -3     |    No (Warning Check)|
|    -4     |    Yes (On new reel) |
+-----------+----------------------+

   You may specify the third parameter as V, Y, name. You then must also
   include a PARAM card in the bulk data deck to set a value for name.

Examples
--------
1. OUTPUT1   A,B,,, // C,N,0 / C,N,0 $   or   OUTPUT1   A,B,,, // $

   Write data blocks A and then B onto user file INPT starting wherever INPT
   is currently positioned. If this is the first write operation on INPT, it
   must be preceded by OUTPUT1 ,,,, // C,N,-1 $, which will automatically
   label the file positioned at its beginning.

2. OUTPUT1 , ,,,, // C,N,-1 / C,N,0 $

   Rewind INPT, destroy any data blocks that were on INPT, and write default
   value of P3 on file as a label.

3. OUTPUT1   A,,,, // C,N,-2 / C,N,2 / C,N,USERTPA $

   Mount a new reel of tape (with write ring) for INP2 and write USERTPA for
   user tape label and then data block A as the first file.

4. OUTPUT1 , ,,,, // C,N,-2 / C,N,2 / C,N,USERTPA $
   OUTPUT1 A,,,, // C,N,0 / C,N,2 $

   This is equivalent to example 3.

5. OUTPUT1 A,B,C,D,E // C,N,14 $

   Starting from the current position, skip forward 14 data blocks on INPT and
   write A, B, C, D, and E as the next five data blocks. The skip positioning
   feature cannot be used if the current position of INPT is forward of a just
   previously written data block end-of-file or before the file is labeled.

6. OUTPUT1 , ,,,, // C,N,-3 $                THIS IS AN
   OUTPUT1 A,B,C,D,E // C,N,14 $             INCORRECT EXAMPLE.

   This is an invalid sequence since the first call positions the tape at the
   end of all data blocks on the tape. See example 7.

7. INPUTT1 / ,,,, / C,N,-3 $
   OUTPUT1 A,B,C,D,E // C,N,14 $

   A complete list of data block names will be printed by INPUTT1, which will
   then rewind the file. Then, OUTPUT1 will skip forward 14 data blocks and
   write A, B, C, D, and E. Your file label is given a warning check by
   INPUTT1.

8. OUTPUT1 , ,,,, // C,N,-2 $                THIS IS AN
   OUTPUT1 , ,,,, // C,N,-3 $                INCORRECT EXAMPLE.
   OUTPUT1 , A,B,,, // C,N,14 $

   This is an invalid sequence since the first call effectively destroys
   whatever information is on the tape. See example 9.

9. INPUTT1 / ,,,, / C,N,-2 $
   INPUTT1 / ,,,, / C,N,-3 $
   OUTPUT1 A,B,,, // C,N,14 $

   Mount a new reel of tape previously default labeled for INPT (the operator
   will have to be instructed to ignore the NORING message and put a ring in
   the tape). Print the names of all data blocks on the tape and rewind the
   tape. Skip 14 data blocks on the tape and write A and then B as the 15th
   and 16th data blocks. Any information forward of this current position is
   effectively destroyed. See example 10.

10. INPUTT1 / ,,,, / C,N,-2 $
    OUTPUT1 A,B,,, // C,N,-3 $

   Mount a new reel of tape previously default labeled for INPT (the operator
   will have to be instructed to ignore the NORING message and put a ring in
   the tape). Print the names of all data blocks on the tape and write A and B
   as new data blocks at the end of the tape. If INPT contained 14 data blocks
   at the start of this sequence, it would be more efficient to do it this way
   than by using the sequence of example 9, since a pass on the tape is
   eliminated.

11. INPUTT1 / ,,,, / C,N,-2 / C,N,0 / V,Y,BDSETLAB $
    OUTPUT1 A,B,,, // C,N,-3 / C,N,0 / V,Y,BDSETLAB $

   This is equivalent to example 10 except your tape label is set on a PARAM
   card, which must be included in the BULK DATA deck (that is, PARAM BDSETLAB
   USERTP12).

Difficult Examples Using INPUTT1 and OUTPUT1

Example 1
---------
a. Objectives:

1. Obtain printout of the names of all data blocks on INPT.

2. Skip past the first four data blocks, replace the next two with data blocks
   A and B, and retain the next three data blocks.

3. Obtain printout of the names of all data blocks on INPT after (2) has been
   done.

b. DMAP Sequence:

   BEGIN $                                     (1)
   INPUTT1 / ,,,, / C,N,-3 $                   (2)
   INPUTT1 / ,,T1,T2,T3 / C,N,6   $            (3)
   INPUTT1 / ,,,, / C,N,-1 $                   (4)
   INPUTT1 A,B,T1,T2,T3 // C,N,4 $             (5)
   OUTPUT1 , ,,,, // C,N,-3 $                  (6)
   END $

c. Remarks
----------
1. DMAP sequence (2) accomplishes objective 1 and rewinds INPT.

2. DMAP sequence (3) recovers data blocks 7, 8, and 9. This is necessary
   because they would be effectively destroyed by anything written in front of
   them on INPT.

3. DMAP sequence (4) rewinds INPT.

4. DMAP sequence (5) accomplishes objective 2.

5. DMAP sequence (6) accomplishes objective 3 and leaves INPT positioned after
   the ninth file, ready to receive additional data blocks.

6. Note that INPUTT1 is used whenever possible to avoid the possibility of
   mistakenly writing on INPT prematurely.

Example 2
---------
a. Objectives:

1. Write data blocks A, B, and C on INPT.
2. Obtain printout of the names of all data blocks on INPT after step (1).
3. Make two copies of the file created in (1).
4. Add data blocks D and E to one of the files.
5. Obtain the names of all data blocks on INPT after (4).

b. DMAP Sequence:

   BEGIN $                                     (1)
   OUTPUT1 A,B,C,, // C,N,-1   $               (2)
   OUTPUT1 , ,,,, // C,N,-3 $                  (3)
   OUTPUT1 A,B,C,, // C,N,-2   $               (4)
   OUTPUT1 A,B,C,, // C,N,-2   $               (5)
   OUTPUT1 D,E,,, // $                         (6)
   OUTPUT1 , ,,,, // C,N,-3 $                  (7)
   END $                                       (8)

c. Remarks:

1. DMAP sequence (2) accomplishes objective 1 since the file must initially
   have P3 written on it when first used. The DMAP statement INPUTT1 A,B,C,,
   // C,N,-1 $ will accomplish the same thing.

2. DMAP sequence (3) accomplishes objective 2. The statement INPUTT1 / ,,,, /
   C,N,-3 $ will do the same thing and add a rewind.

3. Statements (4) and (5) accomplish objective 3.

4. Statement (6) accomplishes objective 4 where the third file (tape) is used.

5. Statement (7) accomplishes objective 5. The statement INPUTT1 / ,,,, /
   C,N,-3 $ will do the same thing and add a rewind.

6. On machines where tape reel switching is not implemented, the second
   parameter can be used as follows:

   BEGIN $
   OUTPUT1 A,B,C,, // C,N,-1 $
   OUTPUT1 , ,,,, // C,N,-3 $
   OUTPUT1 A,B,C,, // C,N,-1 / C,N,1 $
   OUTPUT1 A,B,C,, // C,N,-1 / C,N,2 $
   OUTPUT1 D,E,,, // C,N,0 / C,N,2 $
   OUTPUT1 , ,,,, // C,N,-3 / C,N,2 $
   END $

OUTPUT2 - Create User-Written FORTRAN Files
===========================================
Purpose
-------
Writes up to five data blocks and a user file label onto a FORTRAN-written
user file (either on tape or mass storage) for subsequent use at a later date.
OUTPUT2 is also used to position your file prior to writing the data blocks.
Multiple calls are allowed. A message is written on the output file for each
data block successfully written. You are cautioned to be careful when
positioning a user file with OUTPUT2, since you may inadvertently destroy
information through improper positioning. Even though no data blocks are
written, an EOF will be written at the completion of each call, which has the
effect of destroying anything on the tape forward of the current position.
(The companion module is INPUTT2.)

DMAP Calling Sequence
---------------------
OUTPUT2 DB1,DB2,DB3,DB4,DB5 // V,N,P1 / V,N,P2 / V,N,P3 / V,N,P4 /
                               V,N,P5 / V,N,P6 $

Input Data Blocks
-----------------
DBi        Any data block which you desire to be written on one of the
           NASTRAN FORTRAN files INPT, INP1 through INP9. Any or all of the
           input data blocks may be purged. Only nonpurged data blocks will
           be placed on the file.

Output Data Blocks
------------------
None.

Parameters
----------
P1, P2, P4, and P5 are integer inputs. P3 and P6 are BCD.

1. The meaning of the first parameter (P1) value is given in the table below.
   (The default value is 0.)

+-----------+----------------------------------------------------------+
|  P1 Value |                  Meaning                                 |
+-----------+----------------------------------------------------------+
|     +n    | Skip forward n data blocks before writing.               |
|           |                                                          |
|      0    | Data blocks are written starting at the current          |
|           | position. The current position for the first use of a    |
|           | file is at the label (P3). Hence, P3 counts as one       |
|           | data block.                                              |
|           |                                                          |
|     -1    | Rewind before writing.                                   |
|           |                                                          |
|     -3    | Rewind files, print data block names, and then write     |
|           | after the last data block on the file.                   |
|           |                                                          |
|     -9    | Write a final EOF on the file.                           |
+-----------+----------------------------------------------------------+

   Important NOTES
-----
   a. It is a good practice for you to ensure that a sequence of OUTPUT2
      statements always ends with a statement of the form

      OUTPUT2, ,,,, // -9 $

      thereby causing a final (or physical) EOF to be written on the FORTRAN
      file. Otherwise, subsequent use of this file by OUTPUT2, INPUTT2, or an
      external program may fail due to the absence of a physical EOF on the
      file. Notice the presence of an extra comma after the module name.

   b. On the UNIVAC and DEC VAX versions, the FORTRAN files used with the
      INPUTT2/OUTPUT2 modules are automatically rewound every time a link
      change occurs in the program. In general, a link change can be assumed
      to occur whenever a DMAP statement other than an INPUTT2 statement
      follows an INPUTT2 statement; similarly, whenever a DMAP statement other
      than an OUTPUT2 statement follows an OUTPUT2 statement. For this reason,
      the following cautions should be noted on these versions when using the
      various values for the parameter P1 in an INPUTT2 or OUTPUT2 DMAP
      statement.

+-----------------------------------------------------------------------+
|                 Cautions for UNIVAC and DEC VAX versions              |
+-----------------+-----------------------------------------------------+
|  Parameter P1   |                 Remarks                             |
+-----------------+-----------------------------------------------------+
|    0 or +n      |  You must be certain that this INPUTT2              |
|                 |  statement immediately follows another INPUTT2      |
|                 |  statement; or that this OUTPUT2 statement          |
|                 |  immediately follows another OUTPUT2 statement, to  |
|                 |  avoid a link change that would cause the           |
|                 |  rewinding of the FORTRAN file.                     |
|                 |                                                     |
|  -1 to -8       |  No cautions.                                       |
|                 |                                                     |
|      -9         |  You must be certain that this OUTPUT2              |
|                 |  statement immediately follows another OUTPUT2      |
|                 |  statement, to avoid a link change that would       |
|                 |  cause the rewinding of the FORTRAN file.           |
+-----------------+-----------------------------------------------------+

2. The second parameter (P2) for this module is the FORTRAN unit number onto
   which the data blocks will be written. The allowable values for this
   parameter are highly machine- and installation-dependent. Reference should
   be made to Section 4 of the Programmer's Manual for a discussion of this
   subject.

   For CDC machine (default is 11):

+----------------+--------------------+
| User File Code |  FORTRAN File Name |
+----------------+--------------------+
|        11      |         UT1        |
|        12      |         UT2        |
+----------------+--------------------+

   For all others (default is INPT):

+----------------+--------------------+
| User File Code |  FORTRAN File Name |
+----------------+--------------------+
|        14      |        INPT        |
|        15      |        INP1        |
|        16      |        INP2        |
|        :       |         :          |
|        23      |        INP9        |
+----------------+--------------------+

   IBM/MVS only: INPT is user file code 24.

3. The third parameter (P3) for this module is used to define the FORTRAN User
   File Label. The label is used for NASTRAN identification. The label (P3) is
   an alphanumeric variable of eight or less characters (the first character
   must be alphabetic) which is written on your file. The writing of this
   label is dependent on the value of P1 as follows: (The default value for P3
   is XXXXXXXX.)

+-----------+----------------------+
| P1 Value  |  File Label Written  |
+-----------+----------------------+
|    +n     |          No          |
|     0     |          No          |
|    -1     |          Yes         |
|    -3     |    No (Warning Check)|
|    -9     |          No          |
+-----------+----------------------+

   If the label is written, eight additional records are placed at the
   beginning of the FORTRAN file.

   You may specify the third parameter as V,Y,name. You then must also include
   a PARAM card in the bulk data deck to set a value for name.

4. The fourth parameter (P4) controls the maximum FORTRAN record size.

   P4 = 0 (default); record size is unlimited for all machines except IBM/MVS,
   which is set to 1024 words.

   P4 = -n; maximum FORTRAN record size is n times the system buffer. (If P6
   is not blank, n is 2.)

   P4 = +n; maximum FORTRAN record size is n words. If n is less than system
   buffer, n is increased to system buffer size. If n is greater than system
   open core, n is reduced to the size of open core.

5. The fifth parameter (P5) is valid only for matrix DBi input.

   P5 = 0; matrices are written out by columns. This is the normal way using
   one keyword.

   P5 = not 0; matrices are written out by columns in sparse matrix forms,
   that is, from first non-zero row of a column to last non-zero row. The
   keyword record contains two keys:

      First key:
        > 0, defines length of next data record
        = 0, end-of-file
        < 0, end-of-record; more records follow

      Second key:
        = 0, if DBi is a table data block, or P5 = 0
        > 0, row-base for next record

   For example, if keys = 10,200, the next record is 10 words long, for rows
   200+1 through 200+10; that is, (ROW(key2+j),j=1,key1)

6. If the sixth parameter (P6) is set to *MSC*, OUTPUT2 will generate OUTPUT2
   records in MSC/OUTPUT2 compatible formats. The COSMIC/OUTPUT2 and
   MSC/OUTPUT2 generate records slightly differently. The P5 parameter is not
   available when P6 is specified.

   Default P6 is blank.

Examples
--------
OUTPUT2 is intended to have the same logical action as the GINO User File
module OUTPUT1 except for tape reel switching. It is therefore suggested that
the examples shown under module OUTPUT1 be used for OUTPUT2 as well, excepting
the ones involving tape reel switching. All examples should be ended with a
call to OUTPUT2 with P1 = -9.

Remarks
-------
The primary objective of this module is to write files using simple FORTRAN so
that you can read NASTRAN generated data with your own program. Similarly,
matrices can be generated with externally written simple FORTRAN programs and
then read in by module INPUTT2.

In order to do this, the format of the information on these files must be
adhered to. The basic idea is that a two word logical KEY record is written,
which indicates what follows. A zero value in KEY1 indicates an end-of-file
condition. A negative value indicates the end of a record, where the absolute
value is the record number. A positive value indicates that the next record
consists of that many words of data. KEY2 is used only with P5 not equal to
zero, and was explained previously.

The correspondence between FORTRAN records and GINO-written NASTRAN files is
shown in the following sample:

+---------+----------+---------------------+------------+---------------+
| FORTRAN |          |                     |   NASTRAN  |   File        |
| Record  |  Length  |  Contents           |    File    |  Record       |
+---------+----------+---------------------+------------+---------------+
|   1     |   1      |  KEY1 > 0, KEY2     |     1      |     1         |
+---------+----------+---------------------+            |               |
|   2     |   KEY1   | {Data}              |            |               |
+---------+----------+---------------------+            |               |
|   3     |   1      |  KEY1 > 0, KEY2     |            |               |
+---------+----------+---------------------+            |               |
|   4     |   KEY1   | {Data}              |            |               |
+---------+----------+---------------------+            |               |
|   5     |   1      |  KEY1 < 0 (EOR),    |            |               |
|         |          |  KEY2               |            |               |
+---------+----------+---------------------+            +---------------+
|   6     |   1      |  KEY1 > 0, KEY2     |            |     2         |
+---------+----------+---------------------+            |               |
|   7     |   KEY1   | {Data}              |            |               |
+---------+----------+---------------------+            |               |
|   8     |   1      |  KEY1 < 0 (EOR),    |            |               |
|         |          |  KEY2               |            |               |
+---------+----------+---------------------+            +---------------+
|   9     |   1      |  KEY1 = 0 (EOF),    |            |     EOF       |
|         |          |  KEY2               |            |               |
+---------+----------+---------------------+------------+---------------+
|  10     |   1      |  KEY1 > 0, KEY2     |     2      |     1         |
+---------+----------+---------------------+            |               |
|  11     |   KEY1   | {Data}              |            |               |
+---------+----------+---------------------+            |               |
|  12     |   1      |  KEY1 < 0 (EOR),    |            |               |
|         |          |  KEY2               |            |               |
+---------+----------+---------------------+            +---------------+
|  13     |   1      |  KEY1 = 0 (EOF),    |            |     EOF       |
|         |          |  KEY2               |            |               |
+---------+----------+---------------------+------------+---------------+
|  14     |   1      |  KEY1 = 0 (EOF=EOD),|     3      |     EOF       |
|         |          |  KEY2               |            |               |
+---------+----------+---------------------+------------+---------------+


KEY2s are zeros except when parameter P5 is non-zero, and the next records are
data records (KEY1 > 0). When parameter P5 is zero, effectively only one key,
KEY1, is used.

KEY2s are not generated when parameter P6 is *MSC*.

OUTPUT3 - Punch Matrix Data Blocks Onto Cards

Purpose
-------
Punches up to five matrix data blocks onto DMI bulk data cards. These cards
may then read into NASTRAN as ordinary bulk data to reestablish the matrix
data block at a later date.

DMAP Calling Sequence
---------------------
OUTPUT3  M1,M2,M3,M4,M5 // C,N,P1 / C,Y,N1=ABC / C,Y,N2=DEF / C,Y,N3=GHI
                                    C,Y,N4=JKL / C,Y,N5=MNO $

Input Data Blocks
-----------------
Mi         Any matrix data block which you desire to be punched on DMI cards.
           Any or all of the input data blocks may be purged. Only nonpurged
           data blocks will be punched.

Output Data Blocks
------------------
None.

Parameters
----------
The first parameter (P1) controls the writing of the DMI card images on a
FORTRAN unit as follows:

   P1 < 0     write on FORTRAN unit |P1| as well as punch DMi cards
   P1 >= 0 punch DMI cards only

The default value for P1 is 0.

Ni - The values of the five BCD parameters shown above are used to create a
unique continuation field configuration on the DMI cards. Only the first three
characters are used. These three characters must be unique for all matrices
which will be input together during a subsequent run using cards generated by
OUTPUT3. (Input-BCD, default values are N1 = no default, N2 = N3 = N4 = N5 =
XXX).

Method
------
The nonzero elements of each matrix are punched on double-field DMI cards as
shown in the example below. The name of the matrix is obtained from the header
record of the data block. Field 10 contains the three character parameter
value in columns 74-76 and an incremented integer card count in columns 77-80.

Example
-------
Let the data block MAT contain the matrix

                +                                     +
                | 1.0   0.0    6.0   0.0    0.0   0.0 |
                | 0.0   0.0    7.0   0.0    0.0   0.0 |
   [MAT]  =     | 2.0   4.0    0.0   0.0    0.0   0.0 |
                | 0.0   5.0    0.0   0.0    0.0   9.0 |
                | 3.0   0.0    8.0   0.0    0.0   0.0 |
                +                                     +

The DMAP instruction OUTPUT3 MAT,,,, // C,N,0 / C,N,XYZ $ will then punch out
the DMI cards shown below.

    1        2       3       4       5       6       7       8       9     10
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
|DMI     |MAT    |      0|      2|      1|      2|       |      5|      6|+XYZ0|
+--------+-------+-------+-------+-------+-------+-------+-------+-------+-----+
+--------+---------------+---------------+---------------+---------------+-----+
|DMI*    |MAT            |              1|              1| 1.000000E 00  |*XYZ1|
+--------+---------------+---------------+---------------+---------------+-----+
|*XYZ   1|              3| 2.000000E 00  |              5| 3.000000E 00  |*XYZ2|
+--------+---------------+---------------+---------------+---------------+-----+
+--------+---------------+---------------+---------------+---------------+-----+
|DMI*    |MAT            |              2|              3| 4.000000E 00  |*XYZ3|
+--------+---------------+---------------+---------------+---------------+-----+
|*XYZ   3| 5.000000E 00  |               |               |               |*XYZ4|
+--------+---------------+---------------+---------------+---------------+-----+
+--------+---------------+---------------+---------------+---------------+-----+
|DMI*    |MAT            |              3|              1| 6.000000E 00  |*XYZ5|
+--------+---------------+---------------+---------------+---------------+-----+
|*XYZ   5| 7.000000E 00  |              5| 8.000000E 00  |               |*XYZ6|
+--------+---------------+---------------+---------------+---------------+-----+
+--------+---------------+---------------+---------------+---------------+-----+
|DMI*    |MAT            |              6|              4| 9.000000E 00  |*XYZ7|
+--------+---------------+---------------+---------------+---------------+-----+

Remarks
-------
1. Only real single- or double-precision matrices may be output.

2. All matrices are output on double-field cards in single-precision.

3. The maximum number of cards that may be punched is 99,999. If matrices
   larger than this are desired, use module OUTPUT2 and write a program to
   process the resulting FORTRAN file.

4. The auxiliary subroutine PHDMIA used by module OUTPUT3 can be used with
   stand-alone FORTRAN programs. See Section 4 of the Programmer's Manual for
   details.

OUTPUT4 - Write a Matrix to a FORTRAN Readable File
===================================================
Purpose
-------
To write a matrix to an ASCII or FORTRAN binary file so that user processing
can be done.
OUTPUT4 can also handle six special tables: KELM, MELM, BELM, KDICT, MDICT,
and BDICT.

DMAP Calling Sequence
---------------------
OUTPUT4   M1,M2,M3,M4,M5 // V,N,P1 / V,Y,P2 / V,N,P3 $

Input Data Blocks
-----------------
Mi         Up to five matrix data blocks, including any of the six special
           table data blocks.

Output Data Blocks
------------------
None (written to user tape; see Remarks for the format).

Parameters
----------
P1         Input-integer-default = 0. P1 controls the status of the unit
           before OUTPUT4 starts to write any matrices as follows:

           0     No action taken before write.
           -1    Rewind tape before write.
           -2    End file and rewind tape after write.
           -3    Both

P2         Input-integer-default = 14. The absolute value of IUNIT is the
           FORTRAN unit number where the matrices will be written. If P2 is
           negative, the sparse output option will be used.

P3         If P3 = 1 the file is written in FORTRAN binary format (default).
           If P3 = 2 or 3, the file is written in ASCII format; see Remarks
           10 - 13.

Remarks
-------
1. Each matrix will be written on unit P2 as follows:

   Record No. Word Type  Meaning

      1    1     I    Number of columns (NCOL)
   (binary or 2    I     Number of rows (NR)
   ASCII)     3    I     FORM (1-8, negative if P3 is not equal to 1)
           4     I    TYPE (1-4)
           5,6     B     DMAP name (2A4 format)
      On ASCII output tape, record 1 is written in (1X,4I3,5X,2A4) format.

   2,3,etc.   1    I     Column number.
   (nonsparse,2    I     Row position of first nonzero term.
   binary)    3    I     NW, number of words in the column (that is,   
                                      number of elements times number of
                         words per                  element).
        4-NW+3   R/DP Floating point values, either real or double     
                                   precision, depending on the type.

           Words 1 - 4-NW+3 are repeated for each nonzero column.

   2,3,etc.   1    I     Column number.
   (sparse,   2    I     Zero.
   binary)    3    I     Number of words (NW) in the column.
        4-NW+3   R/DP Strings of nonzero terms as follows: [Length of string
                      (L)/Row position of first term]=IS
                      Floating point values either real or double precision,
                      depending on type. If IS is the string header, L =
                      IS/65536
                      IROW = IS-(L*65536)

   2       1     I    Column number (1X,I13 or 1X,I16).
   (nonsparse,2    I     Row position of first nonzero term (I13 or I16).
   ASCII)     3    I     NW, number of words in the column (I13 or I16).
   3,etc.     11   R/DP  Floating point values either real or double
                         precision, depending on the type (1X,10E13.6,
                         1X,8D16.9, or 1X,8E16.9).

   Record 3 is repeated as many times as necessary. Notice that each record
   holds 11 values, and is 132 bytes in length, except the last record, which
   may be shorter.

   2       1     I    Column number (1X,I13 or 1X,I16).
   (sparse,   2    I     Row position of first string element (a negative
                         value, I13 or I16).
   ASCII)     3    I     NW, number or words in string, adjusted for single
                         precision or double precision word count (I13 or
                         I16).
   3,etc.     11   R/DP  Floating point values of string, either real or
                         double precision, depending on the type
                         (1X,10E13.6, 1X,8D16.9, or 1X,8E16.9)

   Records 2, 3, etc. are repeated as many times as needed for the same matrix
   column (therefore same column number). Notice each record 3 holds 10 or 8
   values, and is less than 132 bytes in length, except the last record, which
   may be shorter. Notice that records 1, 2, and 3 always begin with a space
   (1X).

   Repeat records 2 and 3 (etc.) for each nonzero column (therefore different
   column number).

2. A record with the last column number plus +1 and at least one value in the
   next record will by written on unit P2.

3. Number of words per type is as follows:

   Type          NWORDS

   1, Real S.P.       1
   2, Readl D.P.   2
   3, Complex S.P.    2
   4, Complex D.P.    4

4. OUTPUT4 does not handle table data blocks, except the six special tables
   mentioned above.

5. Choosing a correct unit is machine dependent and correct control cards must
   be supplied. See other sections of this User's Manual for descriptions of
   the control cards for each type of computer.

6. If the non-sparse option is selected, zero terms will be explicitly present
   after the first nonzero term in any column until the last nonzero term.

7. Null columns will not be written to the output.

8. An entire column must fit in memory.

9. The FORTRAN binary file option is the preferred method when the file is to
   be used on the same computer. The ASCII format allows use of the file on
   another type of computer.

10.   The output tape, ASCII (formatted) or binary (unformatted), can be read
      by the INPUTT4 module. On ASCII tape, if P4 is 2, the formats for
      integers and real data are selected automatically depending on the
      precision of the incoming matrix data block. If the matrix is in single
      precision, formats I13 and 10E13.6 are used. If the matrix is in double
      precision, I16 and 8D16.9 are used.

11.   If P3 =3, formats I16 and 8E16.9 are used for integers and single
      precision real data to increase numeric accuracy. This option is
      available only for machines with long word size, 60 bits or more per
      word.

12.   A fatal error in reading input tape may occur if P4 is selected
      erroneously with respect to the content of the tape.

13.   On the ASCII tape, and sparse matrix output, each string of non-zero
      data is written as a FORTRAN record. A fatal error could occur for a
      large matrix where the number of records exceeds system I/O limits.

14.   When KDICT, MDICT, or BDICT input table is copied out to an ASCII output
      tape (not to a binary tape), the damping constant, the only real number
      on the table, is pre-multiplied by 10**8, and converted to an integer.
      The whole table therefore is in pure integer form, and is written out by
      a 10I13 format. In rigid format heat analyses, these six special tables,
      prefixed by an "L", work also with OUTPUT4.

OUTPUT5 - Create User-Written FORTRAN File
==========================================
Purpose
-------
Writes up to five NASTRAN GINO data blocks to a user FORTRAN file using a
FORTRAN write, formatted or unformatted. (The FORTRAN file may reside either
on physical tape or on a mass storage device.) If the data block contains
matrix data, each matrix column is first unpacked, then written out to your
file in unpacked form. If the data block contains table data and formatted
records are requested, a dynamic scheme is used to generate the appropriate
format for the FORTRAN write. Coded symbols are also included in the formatted
table data, so that they can be read back into the NASTRAN system by the
INPUTT5 module, or by a user-written FORTRAN program. Mixed matrix and table
data blocks are allowed in one OUTPUT5 operation.

The unformatted (binary) user file is intended to be used later in the same
computer, or a similar computer of the same manufacturer. The formatted file
can be generated in one computer system and used later in another, with
complete freedom in operating systems and computer manufacturers. The
formatted file can be viewed and edited by the use of the system editor. The
records contain 132 characters (or less) per line.

The parameters in OUTPUT5 are modeled after OUTPUT2. They can be used to
direct which user output file (INP1, INP2, UT1 etc.) is to be used, to write
formatted or unformatted records, to position the output file prior to
writing, and to place an End-Of-File mark at the end of the tape. Multiple
calls are allowed. You are cautioned to be careful when positioning your
output file with OUTPUT5, since you may inadvertently destroy information
through improper positioning. Even though no data blocks are written, an EOF
will be written at the completion of each call, which has the effect of
destroying anything on the tape forward of the current position.

DMAP Calling Sequence
---------------------
OUTPUT5  DB1,DB2,DB3,DB4,DB5//C,N,P1/C,N,P2/C,N,P3/C,N,P4/C,N,T1/C,N,T2/
         C,N,T3/...C,N,T10 $

OUTPUT5 is intended to have the same logical action as the FORTRAN User File
module OUTPUT2 and the GINO User File module OUTPUT1, except for formatted
tape. It is therefore suggested that the examples shown under modules OUTPUT2
and OUTPUT1 be used for OUTPUT5 as well, excepting the addition of the P4
parameter. All samples should be ended with a call to OUTPUT5 with P1=-9.

Input Data Blocks
-----------------
DBi        Any data block which you desire to be written on one of the
           NASTRAN FORTRAN user files INPT, INP1, INP2,..., INP9. Any or all
           of the input data blocks may be purged. Only unpurged data blocks
           will be placed on your file.

Output Data Blocks
------------------
None.

Parameters
----------
1. The meanings of the first three parameter values (P1, P2, P3) are the same
   as those described for the OUTPUT2 module, except your file code and the
   FORTRAN file name are given below. (The default value for P2 is 15, or 11
   for a CDC machine.)

+-----------------+-------------------------+
| FORTRAN LOGICAL |                         |
|    UNIT, P2     |      USER FILE CODE     |
+-----------------+-------------------------+
|       11        |      UT1 (CDC only)     |
|       12        |      UT2 (CDC only)     |
|       14        |      INPT (UNIVAC,VAX)  |
|       15        |      INP1 (All          |
|       16        |      INP2  machines     |
|        :        |        :   except       |
|       23        |      INP9  CDC)         |
|       24        |      INPT (IBM only)    |
+-----------------+-------------------------+

2. The fourth parameter (P4) for this module is used to specify whether your
   output tape is to be written formatted (P4=1 or 2), or unformatted  (P4=0,
   default). Unless the tape is to be used later by a different computer or a
   different operating system, the unformatted tape should be used.

   On the formatted tape, with P4=1, the selection of output formats for real
   data is automatic, depending on the precision of the incoming matrix data
   blocks. If the matrix in in single precision, format 10E13.6 is used. If
   the matrix is in double precision, 5D23.17 is used. Format I13 is used for
   integers in both cases.

   For machines with long word only, 60 bits or more per word, the single
   precision format can be switched to 5E23.17 for numeric accuracy by setting
   P4 to 2.

3. The 10 Ti parameters (T1, T2, T3,..., T10) are used only for table data
   blocks. They are used only when a formatted output file is requested
   (P4=1), and you want to override the automatic format generation of the
   OUTPUT5 module. (Default - all Ti are zeros)

The following rules are used to create user-directed output format:

a. 9 digits must be specified on a Ti parameter. Zero fill if necessary.

b. The digits are continued among the Ti parameters; therefore up to 90 digits
   are allowed. The digits are arranged from left to right. First digit
   specifies the format of the first data word. Second, third, fourth, etc.,
   specify the second, third, fourth data words, etc. (See exception below
   using digits 5 through 9)

c. The values of digits and their meanings are:

   0, format not specified; whatever format OUTPUT5 generated will be used,
   1, specifies integer format,
   2, specifies single precision real format,
   3, specifies BCD format,
   4, specifies double precision real format, and
   5-9, specify multiple format of the same type indicated by next digit,
   which must be 0 through 4. For example, 061352000 is same as
   0111111322222000

Methods
-------
The methods used to transfer data from NASTRAN GINO data blocks to your output
tape (or file) depend on whether

a. the data blocks are matrix or table,
b. formatted or unformatted output tape is requested, and
c. data contains single precision real numbers or double precision numbers, or
   both. (Table data block only)

The methods used must also guarantee continuity of mixed matrix and table
types of block data on your output tape. That is, the mixed data must be able
to be read back into the NASTRAN system, or processed by a user's program, by
a common switching mechanism.

OUTPUT5 treats any input data block as matrix if the 5th and the 6th words
(maximum non-zero matrix column length and matrix density) are both non-zero.
Otherwise, the data block is table. This method is, however, not perfect. Most
table data blocks generated by LINK1, such  as GEOM1, GEOM2, EPT, MPT, etc.
may have non-zero 5th and 6th trailer words.

UNFORMATTED TAPE

The data transfer from a GINO file to an unformatted tape is comparatively
simple. The difference in processing matrix data and table data lies in a
single key word of the length of each record.

MATRIX - A matrix header record that includes the original GINO trailer is
written to user tape first. Thus the total number of records (equal number of
columns) and the length of each record (equal number of rows) are known. Each
column of the matrix is unpacked and copied out to your tape, except that the
leading and trailing zeros are not copied out. The data is either single
precision or double precision real numbers. Each output record is also
preceded by three control words. The following FORTRAN code can read one such
column array (the ICOL matrix column):

READ (TAPE) ICOL,JB,JE,(ARRAY(J),JB,JE)

TABLE - A table header record, with the 5th and 6th trailer words set to
zeros, is also written out to indicate the following records are of table
type. Records from the input GINO data block are read and transferred to user
tape directly, except each output record is preceded by one additional word,
which tells the total length of this current record. The following FORTRAN
code can be used to read one such record:

READ (TAPE) LENGTH,(ARRAY(J),J=1,LENGTH)

FORMATTED TAPE

Most of the attributes of unformatted tape apply equally well to the formatted
tape, except tapes are written with FORTRAN formats.

MATRIX - All integers are written in I8 format, BCD in A4 format, single
precision real numbers in E13.6 (or E26.17 if P4 = 2), and double precision
numbers in D26.17. Only the matrix header record can have all mixed data
types; the matrix column records contain only real numbers. The following
FORTRAN code reads the header record and/or a matrix column:

    READ (TAPE,10) I,J,K,(A(L),L=J,K)
10  FORMAT (3I8,/,(10E13.6 ))    (for single precision data), or
10  FORMAT (3I8,/,( 5D26.17))    (for double precision data), or
10  FORMAT (3I8,/,( 5E26.17))    (P4 = 2)

TABLE - All integers are written in ("I",I9) format, BCD in ("/",A4) format,
single precision real numbers in ("R",E14.7) format, and double precision
numbers in ("D",E14.7). Notice that 5 bytes are used for BCD, 10 bytes for
integer, and 15 bytes for real numbers, single or double precision. NASTRAN
table data blocks often contain integers, BCD, and single and double precision
real numbers in a mixed fashion. Each table record may have a different table
length. To write formatted NASTRAN tables and to read them back later present
a real challenge in FORTRAN programming. The OUTPUT5 module calls subroutine
TABLE5 to process table data, and the INPUTT5 module calls subroutine TABLEV
to read them back.

TABLE5 generates dynamically a unit of format - ("I",I9), ("/",A4), etc. - to
match each data type - integer, BCD, etc. When the synthesized format reaches
130 characters (or bytes), a line of data is written out. A table therefore
may require multiple lines (each line physically is a record). In addition,
the first word of the first line contains the total length of this table. The
following FORTRAN code can be used to read back a table from your tape into
5-character ARRAY:

   CHARACTER*5 ARRAY(500)
   READ (TAPE,20) LENGTH,(ARRAY(J),J=1,LENGTH)
20 FORMAT (I10,24A5,/,(26A5))

The first byte of each 5-character ARRAY (which is I, /, R, or D) can be used
to convert the 5-, 10-, or 15-character data back to BCD, integer, or real
numbers (single or double precision). For more details, see INPUTT5 module and
INPTT5 FORTRAN source subroutine.

TABLE5 calls subroutine NUMTYP to determine the data type, then issue the
corresponding format for output. NUMTYP, however, is not one hundred percent
foolproof. One in five or ten thousand times, NUMTYP may err in determining
exactly the data type. Also, when TABLE5 passes a computer word to NUMTYP with
no other information, NUMTYP cannot tell if it is part of a double precision
word, or if it is a single precision word. (In this case, single precision
word is assumed.) Finally, NUMTYP cannot distinguish between integer zero and
real number zero. (A period may be important in the output format). TABLE5
therefore may generate the wrong format due to NUMTYP's internal limitations.

In case that TABLE5 does produce erroneous format, you can override the
automatic format generation by the Ti parameters which supply OUTPUT5 the
exact format to use, in a condensed, coded form. 90 (or more if 5, 6, 7, 8, or
9 are used in the Ti specification) unit formats can be specified.

The following example illustrates the use of the Ti parameter.

Data on table:

3  4  3.4  5.0E-3  TESTING  .6D+7  9  G  3.2  8  0.  0  4
12 13  14  15  28  61   88  14   44 .7D+7

Ti specification:

T1=112233413, T2=212516140  or
T1=604000025, T2=060400000 (7th and 24th words are d.p.
                            and 12th word is real)
NOTE 2 BCD words in "TESTING",
       all others are 1 computer word per data entry.
       T2, the last Ti used here, must fill up with zeros to make up
         a 9-digit word.

When viewed with a system editor, the above example looks like this (first
line):

37I       3I       4R 5.0000000E-3/TEST/ING D 6.0000000D+07 etc.
++---------+++++++++--------------++++++++++---------------
     1st      2nd        3rd          4th          5th data etc.

The first 37 indicates there are 37 5-byte words in this record. the "++----"
line and the "1st,2nd..." line are added here for video purposes.

Since the formatted data line may not end exactly at 130 bytes, one or two
fillers of the form "X" and four blanks may appear at the end of an output
line.

The matrix data blocks are handled by the main routine OUTPT5. OUTPT5 calls
TABLE5 only when the former encounters a table data block input.

Examples
--------
$  Copy KJI, KGG, and CASECC to INP2 (unit 16), sequential formatted tape
   OUTPUT5 KJI,KGG,CASECC,,//-1/16/*MYTAPE*/1  $

$  Recover the files from INP2 (unit 16) and make them NASTRAN GINO files
   INPUTT5 /OKJI,OKGG,OCASECC,,/-1/16/*MYTAPE*/1  $

Remarks
-------
1. Formatted tape (P4 = 1 or 2) takes a longer time and more space to write
   than the unformatted tape. Unless the tape is intended to be used later by
   a different computer, unformatted tape should be selected (P4=0).

2. The OUTPUT5 "records" are written to tape "identically" with both formatted
   and unformatted FORTRAN write commands. The matrix header and the table
   header can be read "identically" without prior knowledge of what type of
   data, matrix or table, is coming up next.

3. All matrix records are written to tape in a standard way, except the first
   matrix header record.

   All table records are written to tape in a standard way, including table
   header record and the last ending record.

4. The first tape header record is composed of 9 words as shown below:

+--------+------+--------------------------------+-------+-------+
| RECORD | WORD |        CONTENTS                |  P4=0 |  P4=1 |
+--------+------+--------------------------------+-------+-------+
|   0    | 1,2  | Tapeid (=P2)                   | 2*BCD |  2A4  |
|        | 3,4  | Machine (CDC,UNIVAC,IBM,VAX)   | 2*BCD |  2A4  |
|        | 5-7  | Date                           | 3*INT |  3I8  |
|        |   8  | System BUFFER SIZE             |   INT |   I8  |
|        |   9  | P4 used in creating tape (0,1) |   INT |   I8  |
+--------+------+--------------------------------+-------+-------+

5. This remark and the next one deal only with matrix data blocks.

   Three types of data records follow the header record, or the EOF record of
   a previous data block. They are:

   a. Matrix header record
   b. Matrix column data record
   c. EOF record

   These records are written to tape in a standard procedure. Three control
   words are written out first, followed by the actual data. Binary FORTRAN
   write is used in unformatted tape (P4=0), and each logical record holds a
   complete set of data. The following FORTRAN statement is used to write the
   entire data record:

   WRITE (TAPE) I,J,K,(A(L),L=J,K)

   For formatted tape, multiple logical records are actually written for each
   complete set of data. The following FORTRAN statements are used to write
   the entire data record:

       WRITE (TAPE,30) I,J,K,(A(L),L=J,K)
   30  FORMAT (3I8,/,(10E13.6))     (for single precision data), or
   30  FORMAT (3I8,/,(5D26.17))     (for double precision data), or
   30  FORMAT (3I8,/,(5E26.17))     (P4 = 2)

   In the above WRITE statements, the value of I is used to indicate the type
   of record just read.

+--------------+----------------------------+
| VALUE OF I   |    TYPE OF RECORD          |
+--------------+----------------------------+
|     0        |    Matrix header record    |
|    +n        |    Nth matrix column data  |
|    -1        |    End-of-matrix           |
+--------------+----------------------------+

   The column data is written to tape from the first non-zero row position (J)
   to the last non-zero row position (K). The following table describes the
   contents of the data records written to tape by the OUTPUT5 module.

+--------+------+---------------------------------+-------+---------+
| RECORD+| WORD |        CONTENTS                 |  P4=0 |  P4=1   |
+--------+------+---------------------------------+-------+---------+
|   1    |      | Matrix header record -          |       |         |
|        |  1   | 0                               |   INT |    I8   |
|        | 2,3  | 1,1                             | 2*INT |   2I8   |
|        |  4   | 0.0                             |   F.P.| E13.6 or|
|        |      |                                 |       | D26.17  |
|        | 5-10 | Matrix trailer                  | 6*INT |   6I8   |
|        |      | (Col,Row,Form,Type,Max,Density) |       |         |
|        | 11,12| DMAP Name of DB1                | 2*BCD |   2A4   |
|        |      |                                 |       |         |
|   2    |  1   | 1 (First matrix column)         |   INT |    I8   |
|        |  2   | Row pos. of first non-zero elem.|   INT |    I8   |
|        |  3   | Row pos. of last  non-zero elem.|   INT |    I8   |
|        | 4-W  | First banded column data        | 6*INT |   (**)  |
|        |      | (W=Word3-Word2)                 |       |         |
|        |      |                                 |       |         |
|   3    |  1   | 2 (Second matrix column)        |   INT |    I8   |
|        |  2   | Row pos. of first non-zero elem.|   INT |    I8   |
|        |  3   | Row pos. of last  non-zero elem.|   INT |    I8   |
|        | 4-W  | Second banded column data       | 6*INT |   (**)  |
|        |      |                                 |       |         |
|   4    |  1   | 3 (Third matrix column)         |   INT |    I8   |
|        |  2   | Row pos. of first non-zero elem.|   INT |    I8   |
|        |  3   | Row pos. of last  non-zero elem.|   INT |    I8   |
|        | 4-W  | Third banded column data        | 6*INT |   (**)  |
|        |      |                                 |       |         |
|   :    |  :   |     :                           |       |         |
|        |      |                                 |       |         |
|   L    |  1   | L-1 (last matrix column)        |   INT |    I8   |
|        |  2   | Row pos. of first non-zero elem.|   INT |    I8   |
|        |  3   | Row pos. of last  non-zero elem.|   INT |    I8   |
|        | 4-W  | Last banded column data         | 6*INT |   (**)  |
|        |      |                                 |       |         |
|  L+1   |  1   | -1                              |   INT |    I8   |
|        | 2,3  | 1,1                             | 2*INT |   2I8   |
|        |  4   | 0.0                             |   F.P.| D26.17  |
+--------+------+---------------------------------+-------+---------+
   (Repeat records 1 through L+1 for next matrix data block.)
    Where (**) is (10E13.6), (5D26.17), or (5E26.17 for long word machines).
   (+ RECORD number does not correspond one to one to the actual
     physical record number.)

6. A record of (n,1,1,0.0) is written out for a null Nth column.

7. This remark deals only with table data blocks. Three types of data record
   follow the header record, or an EOF record of previous data block. They
   are:

   a. Table header record
   b. Record(s) of a table (a table data block can have more than one table
   record)
   c. EOF record.

   The table header record has a general structure as in the standard
   procedure for the matrix records, except that the 5th and 6th words of the
   matrix trailer section are zeros.

   The table record was discussed in great detail in the METHOD section for
   both formatted and unformatted output tape. A table record is created for
   each table in the input data block, and no skipping forward or backward is
   allowed on the input file.

   If double precision data are encountered in a table record, the double
   precision data will be truncated to single precision, but the format of
   ("D",E14.7) will be used. (INPUTT5 will re-generate the data back to their
   double precision status.)

   An End-Of-File record in the form of "-1 1 1 0.0D+0" ends the table record
   output.

8. Since the formatted tape (P4 = 1 or 2) is intended to be used in different
   computers, the OUTPUT5 module appends no system control word(s) to the
   FORTRAN written formatted records. The output tape must be unlabeled, fixed
   block size with record size of 132 characters, and ANSI unpacked character
   data set. The specification of the tape is either internally specified
   (UNIVAC) by a FORTRAN open statement, or uses system default tape
   specification (IBM and VAX). The CDC user must specify the output tape
   externally by the appropriate FILE, LABEL, or REQUEST cards:

   For example:

   LABEL,TAPE,NT,D=1200,CV=AS,F=S,LB=KU,PO=W.
   FILE,TAPE,MRL=132,MBL=132,RT=F,BT=C.

9. Since open core is used in data processing, the OUTPUT5 module is capable
   of handling all kinds and all sizes of input data blocks.

PARAM - Parameter Processor
===========================
Purpose
-------
To perform specified operations on integer DMAP parameters.

DMAP Calling Sequence
---------------------
PARAM // C,N,op / V,N,OUT / V,N,IN1 / V,N,IN2 $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
None.

Parameters
----------
op         a BCD operation code from the table below (Input, no default). op
           is usually specified as a "C,N" parameter.

OUT        the name of the parameter which is being generated by PARAM
           (Output-Integer, default = 1).

IN1        the name of a parameter whose value is used to compute OUT
           according to the table below (Input-Integer, default = 1).

IN2        the name of a parameter whose value is used to compute OUT
           according to the table below (Input-Integer, default = 1).

Remarks
-------
1. The tables below give the results for OUT as a function of op, IN1, and
   IN2.

+--------+-------------------------------------------------+
| Param  |             Arithmetic Operations               |
+--------+---------+---------+---------+---------+---------+
|  op    |  ADD    |  SUB    |  MPY    |  DIV    |  NOT    |
+--------+---------+---------+---------+---------+---------+
|  OUT   | IN1+IN2 | IN1-IN2 | IN1xIN2 | IN1/IN2 | -IN1    |
+--------+---------+---------+---------+---------+---------+

 +--------+-----------------------------------------------+
 | Param  |              Logical Operations               |
 +--------+---------------+---------------+---------------+
 |  op    |     AND       |      OR       |     IMPL      |
 +--------+---+---+---+---+---+---+---+---+---+---+---+---+
 |  IN1   |<0 |<0 |>=0|>=0|<0 |<0 |>=0|>=0|<0 |<0 |>=0|>=0|
 +--------+---+---+---+---+---+---+---+---+---+---+---+---+
 |  IN2   |<0 |>=0|<0 |>=0|<0 |>=0|<0 |>=0|<0 |>=0|<0 |>=0|
 +--------+---+---+---+---+---+---+---+---+---+---+---+---+
 |  OUT   |-1 |+1 |+1 |+1 |-1 |-1 |-1 |+1 |-1 |+1 |-1 |-1 |
 +--------+---+---+---+---+---+---+---+---+---+---+---+---+

+-------+-----------------------------------------------------------------+
| Param |                Arithmetic Relational Operations                 |
+-------+----------+----------+----------+----------+----------+----------+
|  op   |    EQ    |    GE    |    GT    |    LE    |    LT    |    NE    |
+-------+---+---+--+---+---+--+---+---+--+---+---+--+---+---+--+---+---+--+
|IN1-IN2|<0 |=0 |>0|<0 |=0 |>0|<0 |=0 |>0|<0 |=0 |>0|<0 |=0 |>0|<0 |=0 |>0|
+-------+---+---+--+---+---+--+---+---+--+---+---+--+---+---+--+---+---+--+
|  OUT  |+1 |-1 |+1|+1 |-1 |-1|+1 |+1 |-1|-1 |-1 |+1|-1 |+1 |+1|-1 |+1 |-1|
+-------+---+---+--+---+---+--+---+---+--+---+---+--+---+---+--+---+---+--+

+--------+------------------------------------------------------------------+
| Param  |                           Special Operations                     |
+--------+------------------------------------------------------------------+
|  op    |                                  OUT                             |
+--------+------------------------------------------------------------------+
| NOP    |  OUT (unchanged)                                                 |
|        |                                                                  |
| KLOCK  |  Current CPU time in integer seconds from the start of the job.  |
|        |                                                                  |
| TMTOGO |  Remaining CPU time in integer seconds based on the TIME card.   |
|        |                                                                  |
| PREC   |  Returns the currently requested precision; single precision (1) |
|        |  or double precision (2).                                        |
|        |                                                                  |
| DIAG   |  Turn on DIAGs IN1 through IN2.                                  |
|        |    IN1 >= IN2 will turn on DIAG IN1                              |
|        |    IN1 < IN2 will turn on DIAG IN1 through DIAG IN2              |
|        |                                                                  |
| DIAGOFF|  Turn off DIAGs IN1 through IN2 as used for DIAG.                |
|        |                                                                  |
| SSST   |  Turns DIAG OUT on if OUT > 0.                                   |
|        |  Turns DIAG |OUT| off if OUT <= 0.                               |
|        |                                                                  |
| SSSR   |  Saves DIAG IN1 in OUT if IN1 >= 0.                              |
|        |  Restores DIAG |IN1| to OUT if IN1 < 0.                          |
|        |                                                                  |
| STSR   |  Saves SYSTEM(IN1) in OUT if IN1 >= 0.                           |
|        |  Restores SYSTEM(IN1) to OUT if IN1 < 0.                         |
|        |  (SYSTEM(IN1) is the IN1-th word in /SYSTEM/ common block.)      |
|        |                                                                  |
| SYSR   |  Saves SYSTEM(IN1) in OUT.                                       |
|        |                                                                  |
| SYST   |  Sets the value of both SYSTEM(IN1) and OUT to IN2.              |
+--------+------------------------------------------------------------------+

2. PARAM does its own SAVE; therefore, a SAVE is not needed following the
   module.

Examples
--------
1. To change the sense of parameter NOXYZ (which may be useful for the COND or
   EQUIV instructions):

   PARAM // C,N,NOT / V,N,XYZ / V,N,NOXYZ $    or
   PARAM // *NOT* / XYZ / NOXYZ $

   Alternatively, XYZ could have been set in the following way:

   PARAM // C,N,MPY / V,N,XYZ / V,N,NOXYZ / C,N,-1 $   or
   PARAM // *MPY* / XYZ / NOXYZ / -1 $

2. PARAM // C,N,IMPL / V,N,ABC / V,N,DEF / V,N,GHI $

3. To set the value of parameter P1 to 5 and save it for subsequent use:

   PARAM // C,N,NOP / V,N,P1=5 $    or
   PARAM // *NOP* / P1=5 $

4. To set parameter ABC to +1:

   PARAM // C,N,EQ / V,N,ABC / C,N,2 / C,N,-3 $    or
   PARAM // *EQ* / ABC / 2 / -3 $

5. To change the maximum number of lines of printed output:

   PARAM // C,N,SYST / Y,N,DUM / C,N,14 / C,N,150000 $    or
   PARAM // *SYST* // 14 / 150000 $

   The 14th word in /SYSTEM/ common block is MXLINS, whose default value is
   20000, that is, SYSTEM(14) = 20000. The equivalent operations to the PARAM
   examples shown above are to code SYSTEM(14) = 150000 or MXLINS = 150000 on
   the NASTRAN card or to use the Case Control card MAXLINES = 150000.

6. To turn on DIAGs 1 through 6:

   PARAM // C,N,DIAG / C,N, / C,N,1 / C,N,6 $    or
   PARAM // *DIAG* // 1 / 6 $

   This can also be done with the Executive Control card DIAG 1,2,3,4,5,6.

PARAMD - Parameter Processor, Double Precision
==============================================
Purpose
-------
To perform specified arithmetic, logical, and conversion operations on double
precision real or double precision complex parameters.

DMAP Calling Sequence
---------------------
PARAMD  // C,N,OP / V,N,OUTD / V,N,IND1 / V,N,IND2 / V,N,OUTC /
                   V,N,INC1 / V,N,INC2 /  V,N,FLAG   $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
None.

Parameters
----------
OP         Input-BCD operation code from the table below, no default.

OUTD       Output-Double precision, default = 0.0D+0.

IND1       Input-Double precision, default = 0.0D+0.

IND2       Input-Double precision, default = 0.0D+0.

OUTC       Output-Double precision-complex, default = (0.0D+0, 0.0D+0).

INC1       Input-Double precision-complex, default = (0.0D+0, 0.0D+0).

INC2       Input-Double precision-complex, default = (0.0D+0, 0.0D+0).

FLAG       Output-Integer, default = 0 (see Remark 6).

The values of parameters are dependent upon OP as shown in the table described
in PARAMR module. In addition, a new OP operation code is added:

OP         OUTPUTS

ERR        If FLAG is set to 0 (or by default), NASTRAN system NOGO flag (the
           3rd word of /SYSTEM/) is set to integer zero unconditionally. If
           FLAG is set to non-zero by user, NASTRAN job will terminate if any
           preceding PARAMD (or PARAMR) has non-fatal error(s).

Remarks
-------
1. All parameters, except OP, must be "V" type. Default parameter values will
   be used in case of error. Error in input parameter(s) would cause output
   parameter(s) to pick up the original default value(s).

2. All input errors are non-fatal, with error messages printed.

3. PARAMD does its own SAVE; therefore, a SAVE is not needed following the 
   module. 

4. For OP = DIV or OP = DIVC, the output is zero if the denominator is zero,
   and FLAG is set to +1.

5. For OP = SIN, OP = COS or OP = TAN, the input must be expressed in radians.

6. The default value of FLAG is zero as stated in the Programmer's Manual. All
   NASTRAN releases prior to 1989 actually used a +1 instead of 0. The case
   where FLAG = -1 was not affected.

7. Remarks 1, 2, and 6 also apply to the PARAMR module. The new ERR operation
   code is also available in PARAMR.

Examples
--------
PARAMR  //*ERR*  $
PARAMR  //*ADD*     /V,N,R1SP4  /V,N,R1    /V,N,SP4   $
PARAMR  //*SUB*     /V,N,R1SP4  /V,N,R1    /V,N,SP4   $
PARAMR  //*ABS*     /V,N,ABSR1  /V,N,R1               $
PARAMR  //*SQRT*    /V,N,SQTR1  /V,N,ABSR1            $
PARAMR  //*MPYC* ////V,N,CMPY   /V,N,SCPLX /V,N,CS1   $
PARAMR  //*COMPLEX*//V,N,R1     /V,N,SP4   /V,N,OUTC  $
PARAMR  //*LE*     //V,N,R1     /V,N,SP4////V,N,LEFLG $
PARAMD  //*MPY*     /V,N,RDPDP  /V,N,RDPX  /V,N,RDPX  $
PARAMD  //*DIV*     /V,N,DP4X   /V,N,DP4   /V,N,RDPX  $
PARAMD  //*EXP*     /V,N,EXPX   /V,N,DP4   /V,N,RDP   $
PARAMD  //*CONJ* ////V,N,CONJX  /V,N,CDP4             $
PARAMD  //*EQ*     //V,N,EXPX   /V,N,DP4////V,N,EQFLG $
PARAMD  //*DIVC* ////V,N,DIVCX  /C,Y,DCPLX4/V,N,CDP4  $
PARAMD  //*ERR*  ////  //       /C,N,1                $
PRTPARM // 0     $

PARAML - Abstract Parameters From a List
========================================
Purpose
-------
To convert an element from a GINO matrix or table data block to a legitimate
NASTRAN parameter, or parameters.

DMAP Calling Sequence
---------------------
PARAML  DB // C,N,OP / V,N,P1 / V,N,P2 / V,N,RSP/ V,N,INT/ V,N,RDP/
              V,N,BCD/ V,N,CSX/ V,N,CDX   $

Input Data Blocks
-----------------
DB         Any GINO data block file (table or matrix, single precision or
           double precision, real or complex).

Output Data Blocks
------------------
None.

Parameters
----------
OP         One of the following key words, BCD input, no default. "MATRIX",
           "NULL", "PRESENCE", "TRAILER", "TABLE1", "TABLE2", or "TABLE4".

P1,P2      Input-Integer, see Remark 4 below, default = 1,1.

P2         Output-Integer (only in OP=TRAILER).

RSP        Output-Real single precision, default = 0.0.

INT        Output-Integer, default = 0.

RDP        Output-Real double precision, default = 0.D+0.

BCD        Output, two BCD words in 2A4 format, default = (VOID)

CSX        Output, single precision complex number, default = (0.,0.).

CDX        Output, double precision complex, default = (0.D+0,0.D+0).

Remarks
-------
1. RSP, INT, RDP, BCD, CSX and CDX will be set by the module whenever they are
   present and of the "V" type parameters. The parameters will be printed out
   in their respective formats according to their precision types. Warning
   message will be printed if type mismatch occurs or end-of-record is
   encountered.

2. After execution, the parameter value will be delivered to NASTRAN's
   executive VPS table as a numerical value in the form specified by any one
   or some of the parameters RSP, RDP, CSX, CDX, INT, or BCD (4 BCD characters
   per word, the rest of the word blank filled).

3. PARAML does its own SAVE; therefore, a SAVE is not needed following the
   module. Invalid parameter due to type mismatch or EOR encountered, is not
   saved and the default value remains.

4. P1 and P2 control the location in the data block of the element to be
   selected. The meaning of P1 and P2 depend on OP selection as explained in
   Remarks 5 through 9.

5. If OP = TABLEi (where i=1, 2, or 4), P1 is the record number and P2 is the
   word position of the target element in DB. Word position is based on
   computer word count (1 word per integer or single precision real, 2 words
   per double precision real or single precision complex, and 4 words per
   double precision complex). The table data from record P1 and word P2 (or
   word P2 plus more) will be delivered to the VPS table as a numerical value
   in the form specified.

   If OP = TABLE1, one data word from P2 word position, record P1, will be
   used to form the output parameter.

   If OP = TABLE2, two data words from P2 and P2+1, record P1, will be used.

   If OP = TABLE4, four words from P2, P2+1, P2+2, and P2+3, record P1, will
   be used.

   Since table data block DB can contain mixed types of data, you must know
   ahead of time what the original data type is, and select TABLE1, TABLE2, or
   TABLE4 accordingly.

   For example, the data in P2, p2+1, P2+2, and P2+3 are a, b, c, d, and the
   output parameter request is double precision complex CDX,

   TABLE1 gives CDX = (a.D+0, 0.D+0)
   TABLE2 gives CDX = (a.D+0, b.D+0)
   TABLE4 gives CDX = (e.D+0, f.D+0)

   where e is a double precision real number formed by the union of a and b,
   and f, by the union of c and d.

6. If OP = MATRIX, P1 is the row number and P2 is the column number of the
   matrix in [DB] to be read. The matrix element of (ROW,COL) will be
   delivered to VPS as a numerical value in the form specified by one or more
   of the parameters RSP, RDP, CSX, or CDX. Requests for CSX or CDX from a
   real matrix will assign the value of (ROW,COL) to the real part and zero to
   the imaginary part. The requested output parameter(s) are set to zero(s)
   and a warning message is issued if:

   (1) P1 and/or P2 exceed the matrix order,
   (2) requests for RSP and RDP from a complex matrix,
   (3) requests for INT and BCD from [DB], and the invalid output parameter(s)
are not saved.

   (Notice that row first and column second is consistent with SCALAR module
   parameter input, and also with common practice in matrix element
   designation; (row,column)).

7. If OP = NULL and if [DB] is a matrix, INT is set to -1 if the sixth word of
   the matrix trailer, the matrix density, is zero.

8. If OP = PRESENCE, INT will be -1 if input data block is purged.

9. If OP = TRAILER, P2 is output as the value of ith word of the matrix
   trailer where i is set by P1 in accordance with the following table.

+----+-------------------------------------------------------------+
| P1 |             TERM OF MATRIX TRAILER                          |
+----+-------------------------------------------------------------+
|  1 | Numbers of columns                                          |
|  2 | Number of rows                                              |
|  3 | Form of matrix                                              |
|  4 | Precision of matrix                                         |
|  5 | Maximum number of nonzero terms in any column of the matrix |
|  6 | Matrix density                                              |
+----+-------------------------------------------------------------+

10.   One or more of the output parameters can be requested simultaneously.

11.   After execution, a user information message prints out the parameter
      value in the format prescribed by you. The output parameters can also be
      printed by the PRTPRM module which carries normally more digits. (PRTPRM
      may actually print integer zero in a real number format, 0.0)

12.   See SCALAR module for similar capability.

Examples
--------
Obtain the value in column 1, row 4 of a real matrix, and record 2 word 5 of a
table.

PARAML  KGG //*MATRIX*/C,N,4/C,N,1     /V,N,STERM  $
PARAML  KGG //*MATRIX*/C,N,4/C,N,1   ///V,N,DTERM  $
PARAML  KGG //*MATRIX*/C,N,4/C,N,1 /////V,N,CSTERM $
PARAML  KGG //*MATRIX*/C,N,4/C,N,1//////V,N,CDTERM $
PARAML  KGG //*MATRIX*/C,N,4/C,N,1/V,N,TERM1//V,N,TERM2
            //V,N,TERM3/V,N,TERM4 $
PARAML  CASECC //*TABLE1*/C,N,2/C,N,2  //V,N,ATERM $
PARAML  CASECC //*TABLE2*/C,N,2/C,N,5////V,N,BTERM $

The above output parameters yield the following results:

STERM ,TERM1 = KGG(4,1), in single precision,
DTERM ,TERM2 = KGG(4,1), in double precision,
CSTERM,TERM3 = KGG(4,1), in single precision complex expression,
CDTERM,TERM4 = KGG(4,1), in double precision complex expression
ATERM  = 2nd word of the 2nd record of CASECC, integer, and
BTERM  = 5th and 6th words of the 2nd record of CASECC, 2 BCD words.

PARAMR - Parameter Processor, Real
==================================
Purpose
-------
To perform specified arithmetic, logical, and conversion operations on real or
complex parameters.

DMAP Calling Sequence
---------------------
PARAMR  // C,N,OP / V,N,OUTR / V,N,INR1 / V,N,INR2
                    V,N,OUTC / V,N,INC1 / V,N,INC2
                    V,N,FLAG $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
None.

Parameters
----------
OP         Input-BCD operation code from the table below, no default.

OUTR       Output-Real, default = 0.0.

INR1       Input-Real, default = 0.0.

INR2       Input-Real, default =  0.0.

OUTC       Output-Complex, default = (0.0,0.0).

INC1       Input-Complex, default = (0.0,0.0).

INC2       Input-Complex, default = (0.0,0.0).

FLAG       Output-Integer, default = 0.

The values of the parameters are dependent upon OP as shown in the following
table:

OP           OUTPUTS

ADD       OUTR = INR1 + INR2
SUB       OUTR = INR1 - INR2
MPY       OUTR = INR1 * INR2
DIV       OUTR = INR1 / INR2
NOP       RETURN
SQRT      OUTR = square root of INR1
SIN       OUTR = SIN(INR1)
COS       OUTR = COS(INR1)
ABS       OUTR = | INR1 |
EXP       OUTR =  exp (INR1)
TAN       OUTR = TAN(INR1)
NORM      OUTR = || OUTC ||
POWER     OUTR = INR1 ** INR2
ADDC      OUTC = INC1 + INC2
SUBC      OUTC = INC1 - INC2
MPYC      OUTC = INC1 * INC2
DIVC      OUTC = INC1 / INC2
CSQRT     OUTC = square root of INC1
COMPLEX   OUTC = (INRT,INR2)
CONJ      OUTC = INC1
REAL      INR1 = Re (OUTC)
          INR2 = Im (OUTC)
EQ        FLAG = -1 if INR1 = INR2
GT        FLAG = -1 if INR1 > INR2
LT        FLAG = -1 if INR1 < INR2
LE        FLAG = -1 if INR1 <= INR2
GE        FLAG = -1 if INR1 >= INR2
NE        FLAG = -1 if INR1 not equal INR2
LOG       OUTR = LOG   (INR1)
                    10
LN        OUTR = LOG  (INR1)
                    e
FIX       FLAG = FIX (OUTR)
FLOAT     OUTR = FLOAT(FLAG)

Remarks
-------
1. Any output parameter must be "V" type if the parameter is used by "OP" as
   output.

2. For OP = DIV or OP = DIVC, the output is zero if the denominator is zero.

3. PARAMR does its own SAVE; therefore, a SAVE is not needed following the
   module.

4. For OP = SIN, OP = COS, or OP = TAN, the input must be expressed in
   radians.

PRTPARM - Parameter and DMAP Message Printer
============================================
Purpose
-------
A. Prints parameter values.
B. Prints DMAP messages.

DMAP Calling Sequence
---------------------
PRTPARM // C,N,a / C,N,b / C,N,c $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
None.

Parameters
----------
a          Integer value (no default value).

b          BCD value (default value = XXXXXXXX).

c          Integer value (default value = 0).

Method
------
A. As a parameter printer, use a = 0. There are two options:

   1. b = parameter name will cause the printout of the value of that
      parameter.

      Example: PRTPARM  // C,N,0 / C,N,LUSET $

   2. b = XXXXXXXX will cause the printout of the values of all parameters in
      the current variable parameter table. Since this is the default value,
      it need not be specified.

      Example: PRTPARM  // C,N,0 $

B. As a DMAP message printer, use a not equal to 0. There are two options:

   1. a > 0 causes the printout of the jth message of category b where j = |a|
      and b is one of the values shown below. (The number of messages
      available in each category is also given.)

      Example: PRTPARM  // C,N,1 / C,N,DMAP $

   2. a < 0 causes the same action as a 0 with the additional action of
      program termination. Thus, PRTPARM may be used as a fatal message
      printer.

      Example: PRTPARM  // C,N,-2 / C,N,PLA $

Remarks
-------
1. b is always a value.

2. Meaningless values of a and b will result in diagnostic messages from
   PRTPARM.

3. Following is a table of b category values.

+---+----------------------------------------------+-------------+------------+
|   |                                              |             |  Number of |
|   |        DISPLACEMENT Rigid Formats            | Value of b  |  Messages  |
+---+----------------------------------------------+-------------+------------+
| 1 |  Static Analysis                             |  STATICS    |      5     |
| 2 |  Static Analysis with Inertia Relief         |  INERTIA    |      6     |
| 3 |  Normal Mode Analysis                        |  MODES      |      4     |
| 4 |  Static Analysis with Differential Stiffness |  DIFFSTIF   |      5     |
| 5 |  Buckling Analysis                           |  BUCKLING   |      6     |
| 6 |  Piecewise Linear Static Analysis            |  PLA        |      5     |
| 7 |  Direct Complex Eigenvalue Analysis          |  DIRCEAD    |      3     |
| 8 |  Direct Frequency and Random Response        |  DIRFRRD    |      4     |
| 9 |  Direct Transient Response                   |  DIRTRD     |      3     |
|10 |  Modal Complex Eigenvalue Analysis           |  MDLCEAD    |      5     |
|11 |  Modal Frequency and Random Response         |  MDLFRRD    |      7     |
|12 |  Modal Transient Response                    |  MDLTRD     |      6     |
|13 |  Normal Modes Analysis with Differential     |  NMDSTIF    |      6     |
|   |  Stiffness                                   |             |            |
|14 |  Static Analysis with Cyclic Symmetry        |  CYCSTAT    |      6     |
|15 |  Normal Modes Analysis with Cyclic Symmetry  |  CYCMODES   |      6     |
|16 |  Static Aerothermoelastic Design/Analysis    |  ASTAT      |      5     |
|   |  of Axial-Flow Compressors                   |             |            |
+---+----------------------------------------------+-------------+------------+
|   |          HEAT Rigid Formats                  |             |            |
+---+----------------------------------------------+-------------+------------+
| 1 |  Static Heat Transfer                        |  HSTAT      |      4     |
| 3 |  Nonlinear Static Heat Transfer              |  HNLIN      |      3     |
| 9 |  Transient Heat Transfer                     |  HTRD       |      2     |
+---+----------------------------------------------+-------------+------------+
|   |          AERO Rigid Formats                  |             |            |
+---+----------------------------------------------+-------------+------------+
| 9 |  Blade Cyclic Modal Flutter Analysis         |  BLADE      |      7     |
|10 |  Modal Flutter Analysis                      |  FLUTTER    |      5     |
|11 |  Modal Aeroelastic Response                  |  AERORESP   |      4     |
+---+----------------------------------------------+-------------+------------+
|   |  Direct Matrix Abstraction Program           |             |            |
+---+----------------------------------------------+-------------+------------+
|   |  DMAP                                        |  DMAP       |See Remark 5|
+---+----------------------------------------------+-------------+------------+

4. For details on error messages for the ith Displacement Rigid Format, see
   Section 3.(i+1). The Heat and Aero Rigid Formats follow these.

5. The message number, a, may be any integer for DMAP messages.

6. The third parameter is not used.

SCALAR - Convert Matrix Element to Parameter
============================================
Purpose
-------
To extract a specified element from a matrix for use as a parameter.

DMAP Calling Sequence
---------------------
SCALAR  DB // C,N,ROW/C,N,COL/V,N,RSP/V,N,RDP/V,N,CSX/V,N,CDX   $

Input Data Blocks
-----------------
DB         May be any type of matrix (single precision or double precision,
           real or complex).

Output Data Blocks
------------------
None.

Parameters
----------
ROW        Row number of element to be extracted from [DB]. Input-Integer,
           default = 1.

COL        Column identification of element. Input-Integer, default = 1.

RSP        Output, value of element (ROW,COL) in single precision real,
           default = 0.0.

RDP        Output, value of element (ROW,COL) in double precision real,
           default = 0.D+0.

CSX        Output, value of element (ROW,COL) in single precision complex,
           default = (0.,0.).

CDX        Output, value of element (ROW,COL) in single precision complex,
           default = (0.D+0,0.D+0).

Remarks
-------
1. RSP, RDP, CSX, and CDX will be set by the module whenever they are present
   and of the "V" type parameters. The parameters will be printed out in their
   respective formats according to their precision types. Warning message will
   be printed if type mismatch occurs or element specified is out of matrix
   range.

2. After execution, the parameter value will be delivered to NASTRAN's
   executive VPS table as a numerical value in the form specified by any of
   the parameters RSP, RDP, CSX, or CDX. The output parameters can also be
   printed by the PRTPRM module, which carries normally more digits.

3. SCALAR does its own SAVE; therefore, a SAVE is not needed following the
   module. There is no save for any invalid parameter, and the default value
   remains unchanged.

4. If [DB] is purged, all parameter default values remain unchanged.

5. All of the output parameters can be printed out by PRTPRM module.

6. See PARAML for a similar capability.

Examples
--------
Obtain the value of the element in column 8 and row 2 of the matrix KLL.

SCALAR  KLL//C,N,2/C,N,8  /V,N,S1  $
SCALAR  KLL//C,N,2/C,N,8 //V,N,D1/V,N,S2/V,N,D2  $

The output parameters give the following results:

S1 = KLL(2,8), in single precision real,
D1 = KLL(2,8), in double precision real,
S2 = KLL(2,8), in single precision complex expression, and
D2 = KLL(2,8), in double precision complex expression.

SEEMAT - Pictorial Matrix Output
-------
Purpose
-------
To display nonzero elements of a matrix on printer or plotter output
positioned pictorially by row and column within the outlines of the matrix.

DMAP Calling Sequence
---------------------
SEEMAT  M1,M2,M3,M4,M5 // C,N,OPTION/V,N,PFILE/V,N,PACK/
        C,N,MODEL/C,N,TYPING/C,N,PAPERX/C,N,PAPERY $

Input Data Blocks
-----------------
M1,M2,M3,M4,M5  Matrix data blocks, any of which may be purged.

Output Data Blocks
------------------
None.

Parameters
----------
OPTION     Input BCD value, default = PRINT. This parameter specifies the
           output option. PRINT implies the use of the system output file.
           PLOT implies the use of the NASTRAN General Purpose Plotter
           (NASTPLT) (see Section 4.1). (Any value other than PLOT implies
           PRINT.)

           NOTE:  The following parameters are used only if OPTION = PLOT.

PFILE      Input/Output-Integer, default = 0. PFILE represents the frame (or
           sheet) number generated by the plotter. The value of this
           parameter is incremented by one (1) for each frame (or sheet)
           plotted by SEEMAT.

PACK       Input-Integer, default = 100. Reserved for a future modification
           that will allow the representation of a nonzero block of a matrix
           with a single character.

MODEL   Input-BCD value, default = M. This parameter specifies the plotter
        type or model. Permissible values are M for microfilm plotters, T for
        table plotters, and D for drum plotters. The default value of M
        implies a microfilm plotter.

TYPING     Input-Integer, default = 1. This parameter specifies the typing
           capability of the plotter. A value of 1 specifies a plotter
           without typing capability. (In this case, all characters in the
           plot will be drawn.) A value of 0 specifies a plotter with typing
           capability.

PAPERX     Input-Real, default = 0.0. This parameter specifies the horizontal
           size (or X-dimension) in inches of the plot frame. The use of the
           default value of 0.0 actually causes the program to employ a
           horizontal size of 11.0 inches for table plotters and 30.0 inches
           for drum plotters. (PAPERX cannot be greater than 30.0 inches for
           table plotters.) See Remark 5 regarding the frame size for
           microfilm plotters.

PAPERY     Input-Real, default = 0.0. This parameter specifies the vertical
           size (or Y-dimension) in inches of the plot frame. The use of the
           default value of 0.0 actually causes the program to employ a
           vertical size of 8.5 inches for table plotters and 30.0 inches for
           drum plotters. (PAPERY cannot be greater than 30.0 inches for
           either table or drum plotters.) See Remark 5 regarding the frame
           size for microfilm plotters.

Method
------
The matrix is partitioned into blocks which can be printed on a single sheet
of output paper or frame on the plotter selected. Only blocks containing
nonzero elements will be output. Row and column indices are indicated. 
You are cautioned to make sure your line count limit is large enough. A
default of 20,000 lines is provided by NASTRAN. This may be changed by the use
of the MAXLINES card in the Case Control Deck (see Section 2.3). The transpose
of the matrix is output.

Remarks
-------
1. If a plotter is used, the file PLT2 (either on tape or mass storage) must
   be made available to NASTRAN.

2. If a plotter is used, the PFILE parameter updated by SEEMAT must be saved
   either by using a SAVE instruction immediately after the SEEMAT instruction
   or by using the automatic SAVE feature (/S,N,PFILE/) in the SEEMAT
   instruction itself.

3. The nonzero elements are indicated by asterisks (*), except for diagonal
   elements of square matrices, which are indicated by the letter D, and
   elements in the last row or column, which are indicated by dollar signs
   ($).

4. The default plotter model is specified by omitting the last five
   parameters.

5. The plot frame size for microfilm plotters is set at 10.23 inches x 10.23
   inches and is not under user control.

Examples
--------
1. Specify a table plotter with typing capability as follows:

   SEEMAT    M1,M2,M3,M4,M5 //*PLOT*/S,N,PFILE//*T*/0 $

2. Specify a drum plotter without typing capability as follows:

   SEEMAT    M1,M2,M3,M4,M5 //*PLOT*/S,N,PFILE//*D* $

3. Specify the default plotter (a microfilm plotter without typing capability)
   as follows:

   SEEMAT    M1,M2,M3,M4,M5 //*PLOT*/S,N,PFILE $

4. Specify the printer rather than a plotter as follows:

   SEEMAT    M1,M2,M3,M4,M5 // $

5. For additional examples, see Section 5.8.8.

SETVAL - Set Values
===================
Purpose
-------
Set integer DMAP parameter variable values equal to other integer DMAP
parameter variables or integer DMAP parameter constants.

DMAP Calling Sequence
---------------------
SETVAL  // V,N,X1 / V,N,A1 /
           V,N,X2 / V,N,A2 /
           V,N,X3 / V,H,A3 /
           V,N,X4 / V,N,A4 /
           V,N,X5 / V,N,A5 $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
None.

Parameters
----------
X1, X2, X3, X4, X5  Output-Integers, variables (default values = -1, except
for X1, which has no default).

A1, A2, A3, A4, A5  Input-Integers, variables or constants (default values =
-1).

Method
------
This module sets X1 = A1, X2 = A2, X3 = A3, X4 = A4, and X5 = A5. Only two
parameters need be specified in the calling sequence (X1 and A1).

Remarks
-------
1. SETVAL does its own SAVE; therefore, a SAVE is not needed following the
   module.

2. See PARAM for an alternate method of defining parameter values.

3. As an example, the statement

   SETVAL //X1/A1/X2/3 $

   is equivalent to the statements:

   PARAM //*ADD*/X1/A1/0 $
   PARAM //*NOP*/X2 = 3 $

SWITCH - Interchange Data Block Names
=====================================
Purpose
-------
To interchange two data block names.

DMAP Calling Sequence
---------------------
SWITCH DB1,DB2 // PARAM $

Input Data Blocks
-----------------
DB1        Any NASTRAN data block.
DB2        Any NASTRAN data block.

Output Data Blocks
------------------
None.

Parameters
----------
PARAM   If PARAM < 0, the switch will be performed - Input-Integer, default =
        -1.

Method
------
If PARAM >= 0, a return is made; otherwise the names of the data blocks are
interchanged. All attributes of the data within the blocks remains constant;
only the names are changed.

Remarks
-------
1. Neither input data block may be purged.

2. This option is of use in iterative DMAP operations.

TABPCH - Table Punch
====================
Purpose
-------
To punch NASTRAN tables onto DTI cards in order to allow transfer of data from
one NASTRAN run to another, or to allow user postprocessing.

DMAP Calling Sequence
---------------------
TABPCH TAB1,TAB2,TAB3,TAB4,TAB5 // C,N,A1 / C,N,A2 / C,N,A3 / C,N,A4 / C,N,A5 $

Input Data Blocks
-----------------
TAB1, TAB2, TAB3, TAB4, TAB5  Any NASTRAN tables.

Output Data Blocks
------------------
None. All output is punched onto DTI cards.

Parameters
----------
A1, A2, A3, A4, A5  Input-BCD; defaults are AA, AB, AC, AD, AE.  These
parameters are used to form the       first two characters (columns 74,
                                      75) of the continuation field for
                                      each table respectively.

Remarks
-------
1. Any or all tables may be purged.

2. Integer and BCD characters will be punched onto single-field cards. Real
   numbers will be punched onto double-field cards. Their formats are I8, 2A4,
   E16.9.

3. Up to 99,999 cards may be punched per table.

4. Twice the entire record must fit in open core.

5. Tables with 1 word BCD values (ELSETS) cannot be punched correctly.

Examples
--------
TABPCH EST,,,, // C,N,ES $ will punch the EST onto cards with a continuation
mnemonic of +ESbbbbi (where i is the sequence number).

TABPRT - Formatted Table Printer
================================
Purpose
-------
To print selected table data blocks with format for ease of reading.

DMAP Calling Sequence
---------------------
TABPRT     TDB // C,N,KEY / C,N,OPT1 / C,N,OPT2 $

Input Data Blocks
-----------------
TDB        Table Data Block from list given under X.

Output Data Blocks
------------------
None.

Parameters
----------
KEY        Alphanumeric value, no default. Identifies the format to be used
           in printing the table. The allowable list is given under X.

OPT1       Integer, default value = 0. If 0, no blank lines are written
           between entries. If not equal to 0, one blank line will be written
           between each pair of entries.

OPT2       Integer, default value = 0. Not used at present.

Output
------
The contents of the table are formatted and written on the system output file.

Remarks
-------
1. The module returns in the event of any difficulty.

2. The TABPT module can be used to print the contents of any data block.

Examples
--------
1. TABPRT   CSTM // C,N,CSTM $

2. TABPRT   GPL // C,N,GPL / C,N,1 $

Miscellaneous

Following is a list of data blocks recognized by TABPRT. (Rigid Format name is
used here. The actual DMAP name for the same or equivalent information is
acceptable.)

   Data Block           Key (Value)

   BGPDT                BGPDT
   CSTM                 CSTM
   EQDYN                EQDYN
   EQEXIN               EQEXIN
   GPCT                 GPCT
   GPDT                 GPDT
   GPL                  GPL
   GPLD                 GPLD
   GPTT                 GPTT

TABPT - Table Printer
=====================
Purpose
-------
To print table data blocks (may be used for matrix data blocks if desired).

DMAP Calling Sequence
---------------------
TABPT   TAB1,TAB2,TAB3,TAB4,TAB5 // $

Input Data Blocks
-----------------
TAB1, TAB2, TAB3, TAB4, TAB5  Any NASTRAN data block.

NOTE: Any or all input data blocks can be purged.

Output Data Blocks
------------------
None.

Parameters
----------
None.

Remarks
-------
1. Each input data block is treated as a table and its contents are printed on
   the system output file via a prescribed format. Each word of the table is
   identified by the module as to type (Real, BCD, Integer) and an appropriate
   format is used.

2. The trailer data items for the table are also printed.

3. Purged input data blocks are not printed.

Examples
--------
TABPT   GEOM1,,,, // $

TABPT   GEOM1 ,GEOM2 ,GEOM3 ,GEOM4 ,GEOM5 // $

TIMETEST - Timing Data for Unit Operations
==========================================
Purpose
-------
To produce timing data for specific NASTRAN unit operations.

DMAP Calling Sequence
---------------------
TIMETEST   /, / C,N,N / C,N,M / C,N,T / C,N,01 / C,N,02 $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
FILE1, FILE2  Reserved for future implementation

Parameters
----------
N          Outer loop index.

M          Inner loop index.

T          Data type to be processed.

01         TIMTST routine to be processed.

02         Powers-of-two table for TIMTST option selection.

See Section 4.140 of the NASTRAN Programmer's Manual for further description
of the parameters.

Examples
--------
TIMETEST   / , / C,N,100 / C,N,100 / C,N,1 / C,N,2 $

TIMETEST   / , / C,N,10 / C,N,10 / C,N,3 / C,N,1 / C,N,127 $

VEC - Create Partitioning Vector

Purpose
-------
To create a partitioning vector for matrices using USET that may be used by
matrix operation modules MERGE and PARTN. This allows you to split up long
running modules such as SMP1.

DMAP Calling Sequence
---------------------
A. For matrices generated in Rigid Formats 1-6 or prior to module GKAD (or
GKAM) in Rigid Formats 7 - 12:

VEC   USET / V / C,N,SET / C,N,SET0 / C,N,SET1 / V,N,ID $

B. For matrices generated in Rigid Formats 7 - 12 after module GKAD (or GKAM):

VEC   USETD / V / C,N,SET / C,N,SET0 / C,N,SET1 / V,N,ID $

Input Data Blocks
-----------------
USET       Displacement set definition (statics).
USETD      Displacement set definition (dynamics).
HUSET      Displacement set definition (heat transfer).
USETA      Displacement set definition (aeroelastic).

NOTE: The set definition input data block may not be missing and must fit into
open core.

Output Data Blocks
------------------
V          Partitioning vector.

NOTES
-----
1. If all elements are in SET0 or SET1 then V will be purged.
2. V may not be purged prior to execution.

Parameters
----------
SET        Matrix set to be partitioned (Input-BCD, no default).

SET0       Upper partition of SET (Input-BCD, no default).

SET1       Lower partition of SET (Input-BCD, no default).

ID         Identification of bit position (see table below) (Input-Integer,
           default = 0).

NOTES
-----
1. Legal parameter values are given in the table below.
2. See Section 1.4 for a description of set notation.

   Parameter Value     USET Matrix                        Bit Position

         M                  Um                                 32
         S                  Us (union of SG and SB)            31
         0                  Uo                                 30
         R                  Ur                                 29
         G                  Ug                                 28
         N                  Un                                 27
         F                  Uf                                 26
         A                  Ua                                 25
         L                  Ul                                 24
         SG                 Us (specified on Grid card)        23
         SB                 Us (specified on SPC card)         22
         E                  Ue                                 21
         P                  Up                                 20
         NE                 Une (union of N and E)             19
         FE                 Ufe (union of F and E)             18
         D                  Ud                                 17
         PS                 Ups                                16
         SA                 UsA                                15
         K                  Uk                                 14
         PA                 UpA                                13

Remarks
-------
1. Parameters SET0 and SET1 must be a subset of the SET matrix parameter. A
   degree of freedom may not be in both subsets.

2. If desired, one of SET0 or SET1, but not both, may be requested to be the
   complement of the other one by giving it a value of COMP.

3. If SET = BITID, the second and third parameters are ignored and the IDth
   bit position in USET (or USETD) is used. In this case, SET is assumed equal
   to G (or P) and SET0 will correspond to the zeros in the IDth position and
   SET1 will correspond to the non-zeros in the IDth position.

Examples
--------
1. To partition [Kff] into a- and o- set based matrices, use

   VEC   USET / V / C,N,F / C,N,O / C,N,A $
   PARTN KFF,V, / KOO,KAO,KOA,KAA $

   Note that the same thing can be done in one step by

   UPARTN USET,KFF / KOO,KAO,KOA,KAA / C,N,F / C,N,P / C,N,A $

2. Example 1 could be accomplished by

   VEC   USET / V / C,N,F / C,N,O / C,N,COMP $
        or
   VEC   USET / V / C,N,F / C,N,COMP / C,N,A $

3. Example 1 could be accomplished by

   VEC   USET / V / C,N,BITID / C,N,X / C,N,X / C,N,25 $


5.6  USER MODULES
=================
Module                      Basic Function                         Page

DDR            User Dummy Module                                  5.6-2

DUMMOD1        Dummy Module 1                                     5.6-3

DUMMOD2        Dummy Module 2                                     5.6-4

DUMMOD3        Dummy Module 3                                     5.6-5

DUMMOD4        Dummy Module 4                                     5.6-6

DUMMOD5        Dummy Module 5                                     5.6-7

MATGEN         User Dummy Module                                  5.6-9

MODA           User Dummy Module                                 5.6-10

MODB           User Dummy Module                                 5.6-11

MODC           User Dummy Module                                 5.6-12

OUTPUT         Auxiliary Output File Processor                   5.6-13

XYPRNPLT       User Dummy Module                                 5.6-15

   A number of modules have been placed in the NASTRAN system for which only
dummy code exists. These modules are available to you to create your own data
blocks by reading tapes or data cards, generate your own output on the
printer, punch, or plotter, or perform your own matrix computations. The
appropriate MPL (Module Properties List) information is presented for each
such user module in this section. All necessary interfaces with the Executive
System have been completed for these user modules. The procedures for
implementing a user module are described in Section 6.12 of the Programmer's
Manual.

DDR - User Dummy Module
=======================
Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

DDR   A/X/C,N,ABC/C,N,DEF/C,N,GHI $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the constants in the calling sequence shown above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

DUMMOD1 - Dummy Module 1
========================
Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

DUMMOD1  I1,I2,I3,I4,I5,I6,I7,I8 /
         O1,O2,O3,O4,O5,O6,O7,O8 /
         C,N,-1 / V,Y,P2=-1 / V,N,P3=-1 / C,Y,P4=-1 /
         C,Y,P5=-1.0 / C,N,-1.0 /
         C,Y,P7=ABCDEFGH /
         C,Y,P8=-1.0D0 /
         C,Y,P9=(-1 0,-1.0) /
         C,Y,P10=(-l.0D0,-1.0D0) $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

DUMMOD2 - Dummy Module 2
========================
Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

DUMMOD2  I1,I2,I3,I4,I5,I6,I7,I8 /
         O1,O2,O3,O4,O5,O6,O7,O8 /
         C,N,-1 / V,Y,P2=-1 / V,N,P3=-1 / C,Y,P4=-1 /
         C,Y,P5=-1.0 / C,N,-1.0 /
         C,Y,P7=ABCDEFGH /
         C,Y,P8=-1.0D0 /
         C,Y,P9=(-1 0,-1.0) /
         C,Y,P10=(-1.0D0,-1.0D0) $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

DUMMOD3 - Dummy Module 3
========================
Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

DUMMOD3  I1,I2,I3,I4,I5,I6,I7,I8 /
         O1,O2,O3,O4,O5,O6,O7,O8 /
         C,N,-1 / V,Y,P2=-1 / V,N,P3=-1 / C,Y,P4=-1 /
         C,Y,P5=-1.0 / C,N,-1.0 /
         C,Y,P7=ABCDEFGH /
         C,Y,P8=-1.0D0 /
         C,Y,P9=(-1 0,-1.0) /
         C,Y,P10=(-1.0D0,-1.0D0) $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

DUMMOD4 - Dummy Module 4
========================
Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

DUMMOD4  I1,I2,I3,I4,I5,I6,I7,I8 /
         O1,O2,O3,O4,O5,O6,O7,O8 /
         C,N,-1 / V,Y,P2=-1 / V,N,P3=-1 / C,Y,P4=-1 /
         C,Y,P5=-1.0 / C,N,-1.0 /
         C,Y,P7=ABCDEFGH /
         C,Y,P8=-1.0D0 /
         C,Y,P9=(-1 0,-1.0) /
         C,Y,P10=(-1.0D0,-1.0D0) $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

DUMMOD5 - Dummy Module 5
========================
Purpose
-------
Converts certain NASTRAN output tabular data blocks into NASTRAN matrix data
blocks (GINO files) or to a magnetic tape of special matrix form (by column,
unpacked, from first non-zero term to last non-zero term), similar to that
generated by OUTPUT5. The data on the tape can be read into NASTRAN by the
INPUTT5 module. DUMMOD5 handles only single precision data blocks.

DMAP Calling Sequence
---------------------
DUMMOD5  T1,T2,T3,T4,T5 / 01,02,03,04,05 / C,N,P1 / C,N,P2 / C,N,P3 /
         C,N,P4 / C,N,P5 / C,N,Q $

Input Data Blocks
-----------------
Ti         NASTRAN GINO single precision files, such as OEF1, OQG1, or
           similar type of tabular data blocks, whose fixed length records
           can be rearranged into the columns of a matrix. Any or all of the
           input data blocks may be purged. Only non-purged data blocks will
           be processed.

Output Data Blocks
------------------
All output data blocks are written in single precision. See Method below for
more details.

0i         GINO written matrix data blocks. Any or all of the output data
           blocks may be purged.

INP1       Unit 15, FORTRAN written tape, unformatted.

Parameters
----------
Pi         Each Pi parameter corresponds to each Ti-0i conversion process.
           The tabular input data records in Ti are mapped into a Pi by 8
           two-dimensional matrix space. See Method below for more details.

Q          Print-punch control of the element/grid table gathered from the
           input data blocks (Ti):

           =  -1, no print and punch.
           =  0, print only, no punch.
           =  +1, both print and punch.
           =  /2/, print contents of output tape INP1 after it is generated.

Method
------
A record of the input data block (Ti) is read. The first word is saved in an
element/grid table. The next eight words are saved in the Pi by 8 matrix
space, row-wise. If the record has more than nine words, the rest of the
record is discarded. Similarly, the rest of the records in Ti are read, and
the element/grid table and the Pi by 8 matrix space are filled. If the input
data block Ti has more than Pi records, all the records above Pi are skipped.
If the input data block has less than Pi records, the rest of the matrix space
is zero filled. Finally, when all the records in Ti are read, the Pi by 8
matrix is written to output data block (0i) or tape (INP1), column-wise.

If an output data block (0i) exists, and its corresponding data block (Ti) is
not purged, the Pi by 8 matrix is then written out to the output data block by
NASTRAN GINO in packed form. If an input data block (Ti) exists, and the
corresponding output data block (0i) is purged (not present), the Pi by 8
matrix is then written out to INP1 tape (unit 15), column-wise, unpacked, from
first non-zero term to last non-zero term, in binary records. The content of
INP1 tape is written similarly to those written by OUTPUT5, as shown below.

+----------+---------+-------------------------------------------+-----------+
|  RECORD  |   WORD  |   CONTENTS                                |   TYPE    |
+----------+---------+-------------------------------------------+-----------+
|      0   |         |   Tape header record                      |           |
|          |   1,2   |   "xxxxxxxx" (tape ID)                    |  2*BCD    |
|          |   3,4   |   Machine type                            |  2*BCD    |
|          |   5,7   |   Date                                    |  3*INT    |
|          |     8   |   System buffer size                      |    INT    |
|          |     9   |   0, binary tape                          |    INT    |
|          |         |                                           |           |
|      1   |         |   First matrix (01) header                |           |
|          |     1   |   0                                       |    INT    |
|          |   2,3   |   1,1                                     |  2*INT    |
|          |     4   |   0.0D0                                   |   D.P.    |
|          |  5-10   |   6 words from matrix trailer             |  6*INT    |
|          |         |   (col,row,form,type,max,density          |           |
|          |         |    where type=1 or 3)                     |           |
|          |  11,12  |   Matrix DMAP name                        |  2*BCD    |
|          |         |                                           |           |
|      2   |     1   |   1 (first column ID)                     |    INT    |
|          |     2   |   Location of first non-zero element      |    INT    |
|          |     3   |   Location of last non-zero element       |    INT    |
|          |   4-n   |   S.P. data                               |   REAL    |
|          |         |                                           |           |
|      3   |     1   |   2 (second column ID)                    |           |
|          |   2-n   |   Same as record 1                        |           |
|      :   |   1-n   |   Repeat for more columns                 |           |
|          |         |                                           |           |
|     (x   |     1   |   x (x-th column ID, a null column        |    INT    |
|          |   2,3   |   1,1                                     |    INT    |
|          |   4,5   |   0.0, 0.0                                |   REAL    |
|          |         |                                           |           |
|      l   |   1-n   |   l-1, last column, same as record 1      |           |
|    l+1   |     1   |   -1 (element) or -2 (grid)               |    INT    |
|          |     2   |   1                                       |    INT    |
|          |     3   |   Length of element/grid table, T         |    INT    |
|          | 4-(T+4) |   Table of element or grid IDs            |    INT    |
|          |         |                                           |           |
|    l+2   |         |   Second matrix (02) header               |           |
|      :   |     :   |   Repeat above 1 through l+1 for 02       |           |
|          |         |                                           |           |
|      :   |     :   |   Repeat, up to 5 output data blocks      |           |
|          |         |   per tape                                |           |
+----------+---------+-------------------------------------------+-----------+

Remarks
-------
1. This module is very limited in scope. It handles only some special types of
   tabular input data blocks. This module is designed to be used for a
   particular job or jobs.

2. The heading records of the input data blocks are skipped automatically. The
   rest of the records are read in and processed without further intervention.
   If the output data block contains more than one type of data (such as OEF1
   data file with multi-element type data), meaningless data may be included.
   You must know ahead of time what type of data you are gathering for the
   DUMMOD5 module operation. For this reason, you may find the use of SET in
   the Case Control section to your advantage.

3. The INP1 tape generated by DUMMOD5 can be read by the INPUTT5 module. Any
   future changes in the tape format must also appear in the INPUTT5 and
   OUTPUT5 modules.

MATGEN - User Dummy Module
==========================
Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

MATGEN   I01,I02,...,I20,I21 / O1,O2,O3 / V,N,Pl=0 /
         V,N,P2=0 / ... / V,N,P22=0 $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

MODA - User Dummy Module
========================
Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

MODA   / W,X,Y,Z / C,N,0.0 / C,N,0.0 / C,N,0.0 / C,N,0.0 / C,N,0.0 / C,N,0 /
         C,N,0 / C,N,0 / C,N,0 / C,N,0 / C,N,0.0 / C,N,0 / C,N,0 $

Input Data Blocks
-----------------
None.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

MODB - User Dummy Module

Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

MODB   / W,X,Y,Z / C,N,1.0 / C,N,1.0 / C,N,1.0 / C,N,1.0 / C,N,0 / C,N,0 /
         C,N,0 / C,N,1.0 / C,N,0 / C,N,0 / C,N,0  $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
As desired by author of module.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

MODC - User Dummy Module

Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

MODC   A,B // C,N,-l $

Input Data Blocks
-----------------
As desired by author of module.

Output Data Blocks
------------------
None.

Parameters
----------
Parameters may be used as desired by the author of the module. The parameter
types are indicated by the default values shown in the calling sequence above.

Remarks
-------
This module has been provided for those who may want to include a module of
their own design in the system. The number of inputs and outputs, as well as
the number, type, and default values of the parameters, may be changed by
changing the Module Properties List (MPL) in subroutine XMPLDD (see Section 2
of the Programmer's Manual).

OUTPUT - Auxiliary Output File Processor
========================================
Purpose
-------
A user-written module to generate printer, plotter, or punch output.

DMAP Calling Sequence
---------------------
(See Remarks below.)

OUTPUT   IN // C,Y,P=-l $

Input Data Blocks
-----------------
IN         Contains any desired information which the module extracts and
           writes on the system output file, punch, or either of the two
           plotters. May be purged.

Output Data Blocks
------------------
None.

Parameters
----------
Parameters may be used as desired by the author of the module. Type is Integer
with MPL default value of -1 as shown above.

Remarks
-------
This module has been provided for those who may want to process their own
output. The number of inputs as well as the number, type, and default values
of parameters may be changed by changing the Module Properties List (MPL) in
subroutine XMPLDD (see Section 2 of the Programmer's Manual).

XYPRNPLT - User Dummy Module

Purpose
-------
Can be used for any desired purpose.

DMAP Calling Sequence
---------------------
(See Remarks below.)

XYPRNPLT   A // $

Input Data Blocks
-----------------
As desired by the author of module.

Output Data Blocks
------------------
None.

Parameters
----------
None.

Remarks
-------
This module has been provided for those who may want to process their own
output. The number of inputs and outputs as well as the number, type, and
default values of parameters may be changed by changing the Module Properties
List (MPL) in subroutine XMPLDD (see Section 2 of the Programmer's Manual).


5.7  EXECUTIVE OPERATION MODULES
================================
Module                     Basic Function                         Page

BEGIN          Always first in DMAP; begin DMAP program          5.7-2

CHKPNT         Write data blocks on checkpoint tape if           5.7-3
               checkpointing

COMPOFF        Conditional DMAP compilation off                  5.7-4

COMPON         Conditional DMAP compilation on                   5.7-5

COND           Conditional forward jump                          5.7-6

END            Always last in DMAP; terminates DMAP execution    5.7-7

EQUIV          Assign another name to a data block               5.7-8

EXIT           Conditional DMAP termination                      5.7-9

FILE           Defines special data block characteristics       5.7-10
               to DMAP compiler

JUMP           Unconditional forward jump                       5.7-11

LABEL          Defines DMAP location                            5.7-12

PRECHK         Predefined automated checkpoint                  5.7-13

PURGE          Conditional data block elimination               5.7-14

REPT           Repeat a series of DMAP instructions             5.7-15

SAVE           Save value of output parameter                   5.7-16

XDMAP          Controls the DMAP compiler options               5.7-17

  All modules classified as Executive Operation Modules are individually
described in this section. Additional discussions concerning the interaction
of the Executive Modules with themselves and with the NASTRAN Executive System
are contained in Section 5.2.3.


BEGIN - Begin DMAP Program
==========================
Purpose
-------
BEGIN is a declarative DMAP instruction which may be used to denote the
beginning of a DMAP program.

DMAP Calling Sequence
---------------------
BEGIN $

Remarks
-------
1.BEGIN is a non-executable DMAP instruction which is used only by the DMAP
  compiler for information purposes.

2.Either a BEGIN card or an XDMAP card is required when selecting APP DMAP in
  the Executive Control Deck. This is followed by DMAP instructions up to and
  including the END card.

3.The use of BEGIN implicitly elects all compiler defaults. (See XDMAP
  instruction.)

CHKPNT - Checkpoint

Purpose
-------
Causes data blocks to be written on the New Problem Tape (NPTP) to enable the
problem to be restarted with a minimum of redundant processing.

DMAP Calling Sequence
---------------------
CHKPNT D1,D2,...,DN $

where D1,D2,...,DN (N >= 1) are data blocks to be copied onto the problem tape
for use in restarting problem.

Rules

1.A data block to be checkpointed must have been referenced in a previous
  PURGE, EQUIV, or functional module instruction.

2.CHKPNT cannot be the first instruction of a DMAP loop.

3.Data Blocks generated by the Input File Processor (including DMIs and DTIs)
  should not be checkpointed since they are always regenerated on restart.

4.Checkpointing only takes place when a New Problem Tape (NPTP) is set up and
  the Executive Control Card CHKPNT YES appears in the Executive Control
  Deck. Otherwise, the CHKPNT instructions are ignored.

5.For each data block that is successfully checkpointed, a card of the
  restart dictionary is punched which gives the critical data for the data
  block as it exists on the Problem Tape.

6.For data blocks that have been purged or equivalenced, an entry is made in
  the restart dictionary to this effect. In these cases data blocks are not
  written on the Problem Tape.

Remarks
-------
1.See the PRECHK instruction for an automated CHKPNT capability.

COMPOFF - Conditional DMAP Compilation Off
==========================================
Purpose
-------
To allow blocks of DMAP statements to be compiled or skipped depending upon
the value of a bulk data parameter. (The companion module is COMPON.)

DMAP Calling Sequence
---------------------
COMPOFF LBLNAME,PARNAME $
         or
COMPOFF c,PARNAME $

where:

1.LBLNAME is the BCD name of a label which specifies the end of the DMAP
  statement block,

2.c is an integer constant which specifies the number of DMAP statements in
  the block, and

3.PARNAME is the name of a parameter that appears on a PARAM bulk data card.

Method
------
The block of DMAP statements specified by the label or count is skipped if the
value of the parameter is < 0. The block of DMAP statements will be compiled
if the value of the parameter is >= 0.

Example
-------
COMPOFF LBL,NAM1 $
MODULE1 A/B/L $
MODULE2 C/D/M $
MODULE3 E/F/N $
LABEL LBL $
  :
  :
COMPOFF 2,NAM2 $
MODULE4 P/Q/I
MODULE5 X/Y/J $
  :
  :

In the above example, modules MODULE1, MODULE2, and MODULE3 will not be
compiled if the value of parameter NAM1 is < 0 and modules MODULE4 and MODULE5
will not be compiled if the value of parameter NAM2 is < 0.

Remarks
-------
1.If no PARAM bulk data card is provided to define the parameter, a value of
  0 is assumed.

2.If the form of COMPOFF specifying a label is used, the label may not be
  referenced by any other DMAP instructions, including other COMPOFF or
  COMPON instructions.

3.Comment cards are not included in the statement count.

4.COMPOFF and COMPON instructions may be nested up to five levels using the
  same rules as for FORTRAN DO loops.

COMPON - Conditional DMAP Compilation On
========================================
Purpose
-------
To allow blocks of DMAP statements to be compiled or skipped depending upon
the value of a bulk data parameter. (The companion module is COMPOFF.)

DMAP Calling Sequence
---------------------
COMPON LBLNAME,PARNAME $
         or
COMPON c,PARNAME $

where:

1.LBLNAME is the BCD name of a label which specifies the end of the DMAP
  statement block,

2.c is an integer constant which specifies the number of DMAP statements in
  the block, and

3.PARNAME is the name of a parameter that appears on a PARAM bulk data card.

Method
------
The block of DMAP statements specified by the label or count is skipped if the
value of the parameter is >= 0. The block of DMAP statements will be compiled
if the value of the parameter is < 0.

Example
-------
COMPON LBL,NAM1 $
MODULE1 A/B/L $
MODULE2 C/D/M $
MODULE3 E/F/N $
LABEL LBL $
  :
  :
COMPON 2,NAM2 $
MODULE4 P/Q/I
MODULE5 X/Y/J $
  :
  :

In the above example, modules MODULE1, MODULE2, and MODULE3 will not be
compiled if the value of parameter NAM1 is >= 0 and modules MODULE4 and
MODULE5 will not be compiled if the value of parameter NAM2 is >= 0.

Remarks
-------
1.If no PARAM bulk data card is provided to define the parameter, a value of
  0 is assumed.

2.If the form of COMPON specifying a label is used, the label may not be
  referenced by any other DMAP instructions, including other COMPOFF or
  COMPON instructions.

3.Comment cards are not included in the statement count.

4.COMPOFF and COMPON instructions may be nested up to five levels using the
  same rules as for FORTRAN DO loops.

COND - Conditional Transfer
===========================
Purpose
-------
To alter the normal order of execution of DMAP modules by conditionally
transferring program control to a specified location in the DMAP program.

DMAP Calling Sequence
---------------------
COND n,V $

where:

1.n is a BCD label name specifying the location where control is to be
  transferred. (See the LABEL Instruction.)

2.V is a BCD name of a variable parameter whose value indicates whether or
  not to execute the transfer. If V < 0 the transfer is executed.

Example
-------
BEGIN $
  :
  :
COND L1,K $
MODULE1   A/B/V,Y,P1 $
  :
  :
LABEL   L1 $
MODULEN   X/Y $
  :
  :
END $

If K >= 0, MODULE1 is executed. If K < 0 control is transferred to the label
L1 and MODULEN is executed.

Remarks
-------
1.Only forward transfers are allowed. See the REPT instruction for backward
  transfers.

END - End DMAP Program
======================
Purpose
-------
Denotes the end of a DMAP program.

DMAP Calling Sequence
---------------------
END $

Remarks
-------
1.The END instruction also acts as an implied EXIT instruction.

2.The END card is required whenever APP DMAP is selected in the Executive
  Control Deck.

EQUIV - Data Block Name Equivalence
===================================
Purpose
-------
To attach one or more equivalent (alias) data block names to an existing data
block so that the data block can be referenced by several equivalent names.

DMAP Calling Sequence
---------------------
EQUIV DBN1A,DBN2A,DBN3A / PARMA / DBN1B,DBN2B / PARMB $

NOTE: The number of data block names (DBNij) prior to each parameter (PARMj)
and the number of such groups in a particular calling sequence are variable.

Input Data Blocks
-----------------
DBN1A,DBN2A, etc.  Any data block names appearing within the DMAP sequence. 
            The first data block name in each group (DBN1A and DBN1B in the
            examples above) is known as the primary data block and the second,
            etc. data block names become equivalent to the primary (depending
            on the associated parameter value). These equivalenced data blocks
            are known as secondary data blocks.

Output Data Blocks
------------------
None specified or permitted.

Parameters
----------
PARMA, etc. One required for each set of data block names.

Method
------
The data block names in each group are made equivalent if the value of the
associated parameter is < 0. If a number of data blocks are already
equivalenced and the parameter value is >= 0, the equivalence is broken and
the data block names again become unique. If the data blocks are not
equivalenced and the parameter value is >= 0, no action is taken.

Remarks
-------
1. An EQUIV statement may appear at any time as long as the primary data block
   name has been previously defined.

2. If an equivalence is to be performed at all times, that is, the parameter
   value is always negative, it is not necessary to specify a parameter name.
   For example,

   EQUIV DB1,DB2 // DB3,DB4 $

EXIT - Terminate DMAP Program
=============================
Purpose
-------
To conditionally terminate the execution of the DMAP program.

DMAP Calling Sequence
---------------------
EXIT  c $

where c is an integer constant which specifies the number of times the
instruction is to be ignored before terminating the program. If c = 0 the
calling sequence may be shortened to EXIT.

Example
-------
       BEGIN  $
         :
         :
     + LABEL L1 $
     | MODULE1 A/B/V,Y,P1 $
DMAP |   :
loop |   :
     | EXIT 3 $
     + REPT L1,3 $
         :
         :

       END $

Remarks
-------
1. The EXIT instruction will be executed the third time the loop is repeated
   (that is, the instructions within the loop will be executed four times).

2. EXIT may appear anywhere within the DMAP sequence.

FILE - File Allocation Aid
==========================
Purpose
-------
To inform the File Allocator (see Section 4.9 of the Programmer's Manual) of
any special characteristics of a data block.

DMAP Calling Sequence
---------------------
FILE  A=a1,a2...aa / B=b1,b2...bb / ... / Z=z1,z2...zz $

where:

A,B...Z are the names of the data blocks possessing special characteristics.

a1...aa,b1...bb....z1...zz are the special characteristics from the list
below.

The allowable special characteristics are:

SAVE        Indicates data block is to be saved for possible looping in DMAP
            program.

APPEND      Output data blocks which are generated within a DMAP loop are
            rewritten during each pass through the loop, unless the data block
            is declared APPEND in a FILE statement. The APPEND declaration
            allows a module to add information to a data block on successive
            passes through a DMAP loop.

TAPE        Indicates that data block is to be written on a physical tape if a
            physical tape is available.

Remarks
-------
1. Data blocks created by the NASTRAN preface may not appear in FILE
   declarations.

2. Symbolic DMAP sequences which explain the use of the FILE instruction are
   given in Section 5.2.3.1.

3. FILE is a non-executable DMAP instruction which is used only by the DMAP
   compiler for information purposes.

4. A data block name may appear only once in all FILE statements; otherwise
   the first appearance will determine all special characteristics applied to
   the data block.

JUMP - Unconditional Transfer
=============================
Purpose
-------
To alter the normal order of execution of DMAP modules by unconditionally
transferring program control to a specified location in the DMAP program. The
normal order of execution of DMAP modules is the order of occurrence of the
modules as DMAP instructions in the DMAP program.

DMAP Calling Sequence
---------------------
JUMP n $

where n is a BCD name appearing on a LABEL instruction which specifies where
control is to be transferred.

Remarks
-------
1. Jumps must be forward in the DMAP sequence. See the REPT instruction for
   backward jumps.

LABEL - DMAP Location

Purpose
-------
To label a location in the DMAP program so that the location may be referenced
by the DMAP instructions JUMP, COND, and REPT.

DMAP Calling Sequence
---------------------
LABEL n $

where n is a BCD name.

Remarks
-------
1. The LABEL instruction is inserted just ahead of the DMAP instruction to be
   executed when transfer of control is made to the label.

2. LABEL is a non-executable DMAP instruction which is used only by the DMAP
   compiler for information purposes.

PRECHK - Predefined Automated Checkpoint

Purpose
-------
To allow you to specify a single, or limited number, of checkpoint
declarations, thereby removing the need for a large number of individual
CHKPNT instructions to appear in a DMAP program.

DMAP Calling Sequence
---------------------
PRECHK namelist $
PRECHK ALL $
PRECHK ALL EXCEPT namelist $

where namelist is a list of data block names separated by commas and not
exceeding 50 data blocks per command.

Remarks
-------
1. PRECHK is, in itself, a non-executable DMAP instruction which actuates the
   automatic generation of explicit CHKPNT instructions during the DMAP
   compilation.

2. Any number of PRECHK declarations may appear in a DMAP program. Each time a
   new statement is encountered the previous one is invalidated. The PRECHK
   END $ option will negate the current PRECHK status.

3. CHKPNT instructions may be used in conjunction with PRECHK declarations.
   The CHKPNT instruction will override any PRECHK condition. For example, if
   the PRECHK ALL EXCEPT option is in effect, a data block named in the
   excepted list may still be explicitly CHKPNTed.

4. PRECHK ALL immediately and automatically CHKPNTs all output data blocks
   from each functional module, all data blocks mentioned in each PURGE
   instruction, and all secondary data blocks in each EQUIV instruction. The
   only exceptions to this are the CASESS, CASEI, and CASECC data blocks
   appearing as output in substructure analyses.

5. The rigid format DMAP sequences (see Volume II) do not employ any explicit
   CHKPNT instructions. Instead, for the sake of efficiency, each rigid format
   includes a single PRECHK ALL instruction towards the beginning of the DMAP
   sequence.

PURGE - Explicit Data Block Purge
=================================

Purpose
-------
To flag a data block so that it will not be assigned to a physical file.

DMAP Calling Sequence
---------------------
PURGE DBN1A,DBN2A,DBN3A / PARMA / DBN1B,DBN2B / PARMB $

NOTE: The number of data block names (DBNij) prior to each parameter (PARMj)
and the number of groups of data block names and parameters in a particular
calling sequence is variable.

Input Data Blocks
-----------------
DBN1A,DBN2A, etc.  Any data block names appearing within the DMAP sequence.

Output Data Blocks
------------------
None specified or permitted.

Parameters
----------
PARMA, etc. One required for each group of data block names.

Method
------
The data blocks in a group are purged if the value of the associated parameter
is < 0. If a data block is already purged and the parameter value is >= 0, the
purged data block is unpurged so that it may be subsequently reallocated. If
the data block is not purged and the parameter value is >= 0, no action is
taken.

Remarks
-------
1. If a purge is to be made at all times, i.e., the parameter value is always
   negative, it is not necessary to specify a parameter name. For example,

   PURGE DB1,DB2,DB3,DB4 $

REPT - Repeat
=============

Purpose
-------
To repeat a group of DMAP instructions a specified number of times.

DMAP Calling Sequence
---------------------
REPT n,c $ or REPT n,p $

where:

1. n is a BCD name appearing in a LABEL instruction which specifies the
   location of the beginning of a group of DMAP instructions to be repeated.
   (See LABEL instruction.)

2. c is an integer constant hard coded into the DMAP program which specifies
   the number of times to repeat the instructions.

3. p is a variable parameter set by a previously executed module specifying
   the number of times to repeat the instructions.

Example
-------
BEGIN  $                                   BEGIN  $
  :                                          :
  :                                          :
LABEL L1  $                                MODULE1 X/Y/V,Y,NLOOP  $
MODULE1 A/B/V,Y,P1  $                      LABEL L1  $
  :                                        MODULE1 A/B/V,Y,P1  $
  :                           or             :
MODULEN B/C/V,Y,P2  $                        :
REPT L1,3  $                               MODULEN B/C/V,Y,P2  $
  :                                        REPT L1,NLOOP  $
  :                                          :
END $                                        :
                                           END  $

Remarks
-------
1. REPT is placed at the end of the group of instructions to be repeated.

2. When a variable number of loops is to be performed as in the second example
   above, the value of the variable at the first time the REPT instruction is
   encountered will determine the number of loops. This number will not be
   changed after the initial assignment.

3. A COND (conditional jump) instruction may be used to exit from the loop if
   desired.

4. In the first example, the instructions MODULE1 to MODULEN will be repeated
   three times (that is, executed four times).

SAVE - Save Variable Parameter Values
=====================================

Purpose
-------
To specify which variable parameter values are to be saved from the preceding
functional module DMAP instruction for use by subsequent modules.

DMAP Calling Sequence
---------------------
SAVE V1,V2,...,VN $

where the V1,V2,...,VN (N > 0) are the BCD names of some or all of the
variable parameters which appear in the immediately preceding functional
module DMAP instruction.

Remarks
-------
1. A SAVE instruction must immediately follow the functional module
   instruction wherein the parameters being saved are generated.

2. See Section 5.2.1.5 for a description of the alternate method of saving
   parameter values by means of the parameter specification statement.

XDMAP - Execute DMAP Program
============================
Purpose
-------
To control the DMAP compiler options.

DMAP Calling Sequence
---------------------
      �      �    �         �    �        �    �        �    �         �
      � GO   �    � ERR = 2 �    � LIST   �    � NODECK �    � NOOSCAR �
XDMAP � NOGO �  , � ERR = 1 �  , � NOLIST �  , � DECK   �  , � OSCAR   �  ,
      �      �    � ERR = 0 �    �        �    �        �    �         �
      �      �    �         �    �        �    �        �    �         �
                                  See Remark
      �       �                   4 for
      � NOREF �                   defaults
      � REF   �
      �       �
      �       �

where:

GO          compile and execute program (default).

NOGO        compile only and terminate job.

ERR         defines the error level at which suspension of execution will
            occur:

            0  Warning level
            1  Potentially fatal error level
            2  Fatal error level (default)

LIST        a listing of the DMAP program will be printed (see Remark 4 for
            default values).

NOLIST      no listing (see Remark 4 for default values).

DECK        a deck of the DMAP program will be punched.

NODECK      a deck will not be punched (default).

OSCAR       detailed listing of OSCAR (Operation Sequence Control Array), the
            output of the DMAP compiler.

NOOSCAR     no OSCAR listing (default).

REF         a cross reference listing of the DMAP program will be printed.

NOREF       no cross reference listing (default).

Remarks
-------
1. The XDMAP card is optional and may be replaced by a BEGIN instruction.
   However, one or the other must appear in an APP DMAP execution.

2. The XDMAP instruction is non-executable and is used only to control the
   above options by the DMAP compiler.

3. If all defaults are chosen, this instruction need not appear and BEGIN may
   be used instead.

4. The DMAP compiler default is set to LIST for restart runs and for runs
   using the DMAP approach (APP DMAP) and the substructure capability (APP
   DISP,SUBS). The default is also set to LIST when the REF option on the
   XDMAP card is specified. The default is set to NOLIST for all other cases.
   (The NOLIST option can be used in the former cases to suppress the
   automatic listing of the DMAP program.)

5. Multiple XDMAP cards can be used in the DMAP to get subsets of the DMAP
   program to be listed (using the LIST/NOLIST option) or punched (using the
   DECK/NODECK option).

6. The use of DIAGs in the Executive Control Deck (see Section 2.2) will
   always override the corresponding DMAP compiler options whether or not they
   are selected by means of an XDMAP card. Thus, the use of DIAG 4 will give
   the OSCAR listing, DIAG 14 will give the DMAP program listing, DIAG 17 will
   give a punched output of the DMAP program, and DIAG 25 will give the DMAP
   program cross-reference listing, regardless of any other requests made by
   the presence or absence of XDMAP cards. The DMAP compiler option summary,
   printed before the DMAP source listing, reflects the DIAG selections, if
   any.


5.8  DMAP Examples
==================
In order to facilitate the use of DMAP, several examples are provided in this
section. You are urged to study these examples both from the viewpoint of
performing a sequence of matrix operations and from that of a DMAP flow. In
addition, some examples have been written to illustrate the improved DMAP
syntax. 

5.8.1  DMAP to Print Table and Matrix Data Blocks and Parameters
----------------------------------------------------------------
Objective
---------
1. Print the contents of table data block A.

2. Print matrix data blocks B, C, and D.

3. Print values of parameters P1 and P2.

4. Set parameter P3 equal to -7.

BEGIN     $                              XDMAP     $
TABPT     A,,,, // $                     TABPT     A // $
MATPRN    B,C,D,, // $                   MATPRN    B,C,D // $
PRTPARM   // C,N,0 / C,N,P1 $            PRTPARM   // 0 / *P1* $
PRTPARM   // C,N,0 / C,N,P2 $            PRTPARM   // 0 / *P2* $
PARAM     // C,N,NOP / V,N,P3=-7 $       PARAM     // *NOP* / P3=-7 $
END       $                              END       $

Remarks
-------
1. To be a practical example, a restart situation is assumed. You are
   cautioned to remember to reenter at DMAP instruction 2 by changing the last
   reentry point in the restart dictionary. 

2. In the alternate form, the omission of trailing commas in the TABPT and
   MATPRN instructions will generate POTENTIALLY FATAL ERROR messages alerting
   you to possible errors in the data block name list. 

5.8.2  DMAP to Perform Matrix Operations

Let the constrained matrix [Kll] and the load vector [Pl] be defined by means
of DMI bulk data cards. The following DMAP sequence will perform the series of
matrix operations. 

                   -1
     {u }  =  [K  ]  {P }
       1        ll     l

      {r}  =  [K  ]{u } - {P }
                ll   1      l

                   -1
     {�u}  =  [K  ]  {r}
                ll

     {u }  =  {u } + {�u}
       2        1

           Print {u }
                   2

BEGIN   $                                       XDMAP   $
SOLVE   KLL,PL/U1/C,N,1/C,N,1/C,N,1/C,N,1 $     SOLVE   KLL,PL/U1/1/1/1/1 $
MPYAD   KLL,U1,PL/R/C,N,0/C,N,1/C,N,-1 $        MPYAD   KLL,U1,PL/R/0/1/-1 $
SOLVE   KLL,R/DU/C,N,1 $                   or   SOLVE   KLL,R/DU/1 $
ADD     U1,DU/U2 $                              ADD     U1,DU/U2 $
MATPRN  U2,,,, // $                             MATPRN  U2// $
END     $                                       END     $

Remarks
-------
1. [Kll] is assumed symmetric.

2. In the example above, KLL will be decomposed twice. A more efficient DMAP
   sequence, which requires only a single decomposition for this problem, is
   given below. 

BEGIN   $                                      XDMAP   $
DECOMP  KLL/LLL,ULL $                          DECOMP  KLL/LLL,ULL $
FBS     LLL,ULL,PL/U1/C,N,1/C,N,1/             FBS     LLL,ULL,PL/U1/1/1/1/1  $
        C,N,1/C,N,1 $
MPYAD   KLL,U1,PL/R/C,N,0/C,N,1/C,N,-1 $       MPYAD   KLL,U1,PL/R/0/1/-1 $
FBS     LLL,ULL,R/DU $                    or   FBS     LLL,ULL,R/DU $
ADD     U1,DU/U2 $                             ADD     U1,DU/U2 $
MATPRN  U2,,,, // $                            MATPRN  U2// $
END     $                                      END     $

5.8.3  DMAP to Use the Structure Plotter to Generate Undeformed Plots of the 
Structural Model 

BEGIN     $

GP1       GEOM1,GEOM2, / GPL,EQEXIN,GPDT,CSTM,BGPDT,SIL / V,N,LUSET /
          V,N,NOCSTM / V,N,NOGPDT $
SAVE      LUSET $
GP2       GEOM1,EQEXIN / ECT $
PLTSET    PCDB,EQEXIN,ECT / PLTSETX,PLTPAR,GPSETS,ELSETS / V,N,NSIL /
          V,N,NPSET $
SAVE      NPSET,NSIL $
PRTMSG    PLTSETX // $
PARAM     // C,N,NOP / V,N,PLTFLG=1 $
PARAM     // C,N,NOP / V,N,PFILE=0 $
COND      P1,NPSET $
PLOT      PLTPAR,GPSETS,ELSETS,CASECC,BGPDT,EQEXIN,SIL,, / PLOTX1 /
          V,N,NSIL / V,N,LUSET / V,N,NPSET / V,N,PLTFLG / V,N,PFILE $
SAVE      NPSET,PLTFLG,PFILE $
PRTMSG    PLOTX1 // $
LABEL     P1 $
PRTPARM   // C,N,0 $
END       $

Remarks
-------
1. GEOM1, GEOM2, PCDB, and CASECC are generated by the Input File Processor.

2. PRTPARM is used to print all current variable parameter values.

3. This DMAP sequence contains several structurally oriented modules. This
   sequence of DMAP instructions is essentially identical with the section of
   each rigid format associated with the operation of the Structure Plot
   Request Packet of the Case Control Deck (contained in data block PCDB). 

5.8.4  DMAP to Print Eigenvectors Associated with any of the Modal Formulation 
Rigid Formats 

BEGIN     $
OFP       LAMA,OEIGS,,,, // $
SDR1      USET,,PHIA,,,GO,GM,,KFS,, / PHIG,,QG / C,N,1 / C,N,REIG $
SDR2      CASECC,CSTM,MPT,DIT,EQEXIN,SIL,,,BGPDT,LAMA,QG,PHIG,EST, /
          , OQG1,OPHIG,OES1,OEF1, / C,N,REIG $
OFP       OPHIG,OQG1,OEF1,OES1,, // $
END       $

Remarks
-------
1. A restart from a successfully executed modal formulation is assumed.

2. This DMAP sequence contains several structurally oriented modules.

5.8.5  DMAP Using a User-Written Module
---------------------------------------
As an example of how you might perform matrix operations of your own design,
the following DMAP is provided. Functional modules MODA, MODB, and MODC are
assumed to be written by you and added to the NASTRAN system, replacing dummy
modules with the same names. A brief explanation of a problem for which this
DMAP is applicable is given. 

 1   BEGIN    $
 2   PARAM    // C,N,NOP / V,N,TRUE=-1 $
 3   PARAM    // C,N,NOP / V,N,FALSE=+l $
 4   MODA     / X,Y,DB,A / V,N,BETA=0.0 / V,N,SIGMA=1.0 / V,N,FW=0.0 /
              V,N,SW=0.0 / V,N,ETAINF=5.0 / V,N,M=100 / C,N,0 /
              C,N,0 / C,N,0 / V,N,ICONV=0 / V,N,ZCONV=1.0E-4 /
              V,N,ITMAX=10 / C,N,0 $
 5   SAVE     BETA,SIDMA,FW,SW,ETAINF,M,ICONV,ZCONV,ITMAX $
 6   LABEL    TOP $
 7   FILE     A=SAVE / DB=SAVE $
 8   SOLVE    A,DB / DY / C,N,0 / C,N,1 / C,N,1 / C,N,1 $
 9   EQUIV    X,XX / FALSE / Y,YY / FALSE $
10   MODB     X,Y,DY / XX,YY,DBB,AA / V,N,BETA / V,N,SIGMA / V,N,FW /
              V,N,SW / V,N,M / C,N,0 / V,N,ICONV / V,N,ZCONV / C,N,0 /
              V,N,DONE=1 / V,N,DIVERGED=1 $
11   SAVE     DONE,DIVERGED $
12   COND     QUIT,DIVERGED $
13   COND     OUT,DONE $
14   EQUIV    XX,X / TRUE / YY,Y / TRUE / DBB,DB / TRUE / AA,A / TRUE $
15   COND     QUIT,ITMAX $
16   REPT     TOP,1000 $
17   PRTPARM  // C,N,-1 / C,N,DMAP $
18   EXIT     $
19   LABEL    OUT $
20   MODC     X,Y // $
21   EXIT     $
22   LABEL    QUIT $
23   PRTPARM  // C,N,-2 / C,N,DMAP $
24   EXIT     $
25   END      $

The above DMAP sequence is designed to solve an iteration problem where {x} is
the set of independent variable values on which the discretized solution
{y(x)} is defined. Let the discrete values of {y(x)} measured at {x} be called
{y}. An iteration sequence 

        i+1       i         i      -1       i
     {y}     = {y}  + [A({y} ,{x})]  {�b({y} ,{x})}

is to be performed where [A] and �b are computable functions of {y} and {x}. A
convergence-divergence criterion is assumed known. It is also assumed that the
independent variable distribution {x} may be modified as the solution
proceeds. A brief description of the significant DMAP instructions is given
below: 

4  Initialization of all parameters and output data blocks. This module is
   assumed to be written by you. 

7  Prevents file allocator from dropping A and DB.

8  Compute {�b} = [A]-1{�b}

9  Break equivalences.

10 Iterate to obtain new {x}, {y}, {�b}, [A]; test convergence and set
   parameters DONE and DIVERGED. This module is assumed to be written by you. 

14 The new {x}, {y}, {�b}, [A] are established as current by replacing the old
   values. 

20 Prints out the converged solutions {x} and {y}. This module is assumed to
   be written by you. 

5.8.6  DMAP ALTER Package for Using a User-Written Auxiliary Input File Processor 
---------------------------------------------------------------------------------
ALTER       1
INPUT       GEOM1,,,, / G1,,,G4, / C,N,3 $
PARAM       // C,N,NOP / V,N,TRUE=-1 $
EQUIV       G1,GEOM1 / TRUE / G4,GEOM4 / TRUE $
COND        LBLXXX,TRUE $
TABPT       G1,G4,,, // $
LABEL       LBLXXX $
ENDALTER

Remarks
-------
1. This is an ALTER package that could be used by any Rigid Format.

2. The last three instructions are needed to avoid violating the equivalence
   rule that a primary data block name must be referenced in a subsequent
   functional module. A way to avoid using these three instructions is to move
   the PARAM ahead of INPUT, in which case the EQUIV immediately follows the
   module in which the primary data blocks are output. In this case the ALTER
   package becomes 

   ALTER       1
   PARAM       // C,N,NOP / V,N,TRUE=-1 $
   INPUT       GEOM1,,,, / G1,,,G4, / C,N,3 $
   EQUIV       G1,GEOM1 / TRUE / G4,GEOM4 / TRUE $
   ENDALTER

3. It is assumed that a user-written module INPUT exists which reads data
   block GEOM1 (created by the Input File Processor of the NASTRAN Preface)
   and creates data blocks G1 and G4. It is then desired to use G1 and G4 in
   place of GEOM1 and GEOM4, the data blocks normally created by the NASTRAN
   Preface. 

4. ALTER is described in Section 2.1.

5.8.7  DMAP to Perform Real Eigenvalue Analysis Using Direct Input Matrices

BEGIN      $
READ       KTEST,MTEST,,,DYNAMICS,,CASECC / LAMA,PHIA,MI,OEIGS /
           C,N,MODES / V,N,NE $
OFP        LAMA,OEIGS,,,, // $
MATPRN     PHIA,,,, // $
END        $

Remarks
-------
1. The echo of a test problem bulk data deck for the preceding DMAP sequence
   follows. 

   .  1  ..  2  ..  3  ..  4  ..  5  ..  6  ..  7  ..  8  ..  9  .. 10  .
   DMI    KTEST  0      6      1      2             4      4
   DMI    KTEST  1      1      200.0  -100.0
   DMI    KTEST  2      1      -100.0 200.0  -100.0
   DMI    KTEST  3      2      -100.0 200.0  -100.0
   DMI    KTEST  4      3      -100.0 200.0
   DMI    MTEST  0      6      1      2             4      4
   DMI    MTEST  1      1      1.0
   DMI    MTEST  2      2      1.0
   DMI    MTEST  3      3      1.0
   DMI    MTEST  4      4      1.0
   EIGR   1      INV    .0     2.5    2      2                    +1
   +1     MAX

2. Data blocks DYNAMICS and CASECC are generated by the NASTRAN Preface (Input
   File Processor) and contain the eigenvalue extraction data from the EIGR
   card and the eigenvalue method selection data extracted from the METHOD
   card in the Case Control Deck. 

3. Data blocks KTEST and MTEST are generated by the NASTRAN Preface (Input
   File Processor) from the DMI bulk data cards. 

4. Data block MI is the modal mass matrix, which is not used in this DMAP
   subsequent to READ, but which must appear as an output in READ. Parameter
   NE is an output parameter whose value is the number of eigenvalues
   extracted. If none are found NE will be set to -1. 

An alternate DMAP to perform real eigenvalue analysis using Direct Input
Matrices, where the degrees of freedom are associated with grid points, is
shown below. 

BEGIN     $
GP1       GEOM1,GEOM2, / GPL,EQEXIN,GPDT,CSTM,BGPDT,SIL / V,N,LUSET /
          C,N,0 / C,N,0 $
SAVE      LUSET $
GP4       CASECC,,EQEXIN,SIL,GPDT,BGPDT,CSTM / ,,USET, / V,N,LUSET /
          C,N,0 / C,N,0 / C,N,0 / C,N,0 / C,N,0 / C,N,0 / C,N,0 /
          C,N,0 / C,N,0 / C,N,0 $
DPD       DYNAMICS,GPL,SIL,USET / GPLD,SILD,USETD,,,,,,,EED,EQDYN /
          V,N,LUSET / C,N,0 / C,N,0 / C,N,0 / C,N,0 / C,N,0 /
          C,N,0 / C,N,0 / V,N,NOEED / C,N,0 / C,N,0 $
SAVE      NOEED $
COND      E1,NOEED $
READ      KTEST,MTEST,,,EED,,CASECC / LAMA,PHIA,MI,OEIGS /
          C,N,MODES / V,N,NEIGV $
SAVE      NEIGV $
OFP       LAMA,OEIGS,,,, // $
COND      FINIS,NEIGV $
SDR1      USET,,PHIA,,,,,,,, / PHIG,, / C,N,1 / C,N,REIG $
SDR1      CASECC,,,,EQEXIN,SIL,,,BGPDT,LAMA,,PHIG,,, / ,,OPHIG,,, / C,N,REIG $
OFP       OPHIG,,,,, // $
JUMP      FINIS $
LABEL     E1 $
PRTPARM   // C,N,-2 / C,N,MODES $
LABEL     FINIS $
END       $

Remarks
-------
1. The echo of a test problem bulk data deck for the preceding DMAP sequence
   follows. 

   .  1  ..  2  ..  3  ..  4  ..  5  ..  6  ..  7  ..  8  ..  9  .. 10  .
   DMI    KTEST  0      6      1      2             4      4
   DMI    KTEST  1      1      200.0, -100.0
   DMI    KTEST  2      1      -100.0 200.0  -100.0
   DMI    KTEST  3      2      -100.0 200.0  -100.0
   DMI    KTEST  4      3      -100.0 200.0
   DMI    MTEST  0      6      1      2             4      4
   DMI    MTEST  1      1      1.0
   DMI    MTEST  2      2      1.0
   DMI    MTEST  3      3      1.0
   DMI    MTEST  4      4      1.0
   EIGR   1      DET    .0     2.5    2      2                    +1
   +1     MAX
   SPOINT 1      THRU   4

2. Data block EED is generated by DPD, which copies the EIGR or EIGB cards
   from data block DYNAMICS. The actual card used is selected in case control
   by METHOD = SID. 

3. Each degree-of-freedom defined by the DMI matrices must be associated with
   some grid or scalar point in this version. In the example above, this is
   done by defining four scalar points. 

4. The EIGR card selected in the Case Control Deck will be used as explained
   in Remark 2. 

5. The use of module MTRXIN and DMIG bulk data cards will allow you to input
   matrices via grid point identification numbers. 

5.8.8  DMAP to Print and Plot a Topological Picture of Two Matrices

1.  BEGIN      $
2.  SEEMAT     KGG,KLL,,, // $
3.  SEEMAT     KGG,KLL,,, //*PLOT*/S,N,P=0 $
4.  PRTPARM    // 0 /*P* $
5.  PARAM      // *MPY* /P/0/1 $
6.  SEEMAT     KGG,KLL,,, //*PL0T*/S,N,P//*D*/0 $
7.  PRTPARM    //0/*P* $
8.  END        $

Remarks
-------
1. Instruction number 2 causes the picture to be generated on the printer.

2. Instruction number 3 causes the picture to be generated on a microfilm
   plotter without typing capability (the default). 

3. The parameter P is initialized to zero by instruction number 3. The form
   S,N,P would also have accomplished the same thing, since the MPL default
   value is zero. 

4. Instruction number 4 prints the current value of parameter P. Since P was
   initially set to zero and instruction number 3 is the first instruction
   executed which has P as an input, then P will have a zero value on input to
   instruction number 3. P is incremented by one (1) for every frame generated
   on the microfilm plotter. Since the value of the output parameter P was
   automatically saved, the value printed by instruction number 4 will be the
   number of frames generated by the execution of instruction number 3. 

5. Instruction number 5 causes the value of P to be reset to zero (0), the
   product of zero (0) and one (1). Since PARAM is the only module which does
   its own SAVE, the parameter P need not be saved explicitly. This
   illustrates a commonly used technique for setting parameter values in DMAP
   programs. 

6. Instructions 6 and 7 essentially repeat instructions 3 and 4 using a drum
   plotter with typing capability in place of a microfilm plotter without
   typing capability. 

7. The END instruction, which is required, also acts as an EXIT instruction.

8. NASTRAN file PLT2 must be set up in order to execute this DMAP
   successfully.

9. Matrix data blocks KGG and KLL are assumed to exist on the POOL file. This
   will be the case if either DMI input is used or if a restart is being made
   from a run in which KGG and KLL were generated and checkpointed. 

5.8.9  DMAP to Compute the r-th Power of a Matrix [Q]
-----------------------------------------------------
BEGIN      $
MATPRN     Q,,,, // $
PARAM      // C,N,NOP / V,N,TRUE=-1 $
PARAM      // C,N,SUB / V,N,RR / V,Y,R=-1 / C,N,2  $
PARAM      // C,N,NOP / V,N,FALSE=+1 $
ADD        Q, / QQ $
LABEL      DOIT $
EQUIV      QQ,P / FALSE $
MPYAD      Q,QQ, / P / C,N,0 $
EQUIV      P,QQ / TRUE $
PARAM      // C,N,SUB / V,N,RR / V,N,RR / C,N,1 $
COND       STOP,RR $
REPT       DOIT,1000000 $
LABEL      STOP $
MATPRN     P,,,, // $
END        $

  or

BEGIN      $
MATPRN     Q // $
PARAM      // *SUB* / RR / V,Y,R=-1 / 2 $
COPY       Q / P $
LABEL      TOP $
MPYAD      Q,P / PP / 0 $
SWITCH     P,PP // $
REPT       TOP,RR $
MATPRN     P // $
END        $

Remarks
-------
1. The matrix [Q] is assumed input via DMI bulk data cards.

2. The parameter R is assumed input on a PARAM bulk data card.

3. [DELETED]
     
4. The improved DMAP to perform the same operation can be done with
   substantially fewer commands. 


5.8.10  Usage of UPARTN, VEC, and PARTN
---------------------------------------
In Rigid Format No. 7, the functional modules SMP1 and SMP2 (the latter used
three times) together perform the following matrix operations: 

               + _         +
               | Kaa | Kao |
     [Kff] =>  | ----+---- |
               | Koa | Koo |
               +           +

                   -1
     [Go]  = -[Koo]   [Koa]

               + _         +
               | Maa | Mao |
     [Mff] =>  | ----+---- |
               | Moa | Moo |
               +           +

     [A]   = [Moo] [Go] + [Moa]

                  T         _
     [B]   = [Moa]  [Go] + [Maa]

                 T
     [Maa] = [Go]  [A] + [B]

               + _4  |  4  +
       4       | Kaa | Kao |
     [Kff] =>  | ----+---- |
               |  4  |  4  |
               | Koa | Koo |
               +           +

               4            4
     [A]   = [Koo] [Go] + [Koa]

               4  T         _4
     [B]   = [Koa]  [Go] + [Kaa]

       4         T
     [Kaa] = [Go]  [A] + [B]

               + _         +
               | Baa | Bao |
     [Bff] =>  | ----+---- |
               | Boa | Boo |
               +           +

     [A]   = [Boo] [Go] + [Boa]

                  T         _
     [B]   = [Boa]  [Go] + [Baa]

                 T
     [Baa] = [Go]  [A] + [B]

This is far too many time-consuming matrix operations to perform within single
modules when the a-set and o-set are large. (Remember, checkpoint only occurs
after the module has done all its work.) 

In order to subdivide the matrix operations, the partitions of the matrices
[Kff] etc. must be obtained. The following ALTER packet accomplishes this
objective by the use of the UPARTN nodule. 

SMP1 and SMP2 using UPARTN for Rigid Format No. 7

ALTER     n1,n2 $ (where n1 = DMAP statement number of the SMP1 module and n2 =
          DMAP statement number of the third use of the SMP2 module)
$
UPARTN    USET,KFF / KOO, ,KOA,KAAB / *F*/*O*/*A* $
SOLVE     KOO,KOA / GO / 1 / -1 $
MPYAD     KOA,GO,KAAB / KAA / 1 $
$
UPARTN    USET,MFF / MOO, ,MOA,MAAB / *F*/*O*/*A* $
MPYAD     MOO,GO,MOA / MAATEMP1 / O $
MPYAD     MOA,GO,MAAB / MAATEMP2 / 1 $
MPYAD     GO,MAATEMP1,MAATEMP2 / MAA / 1 $
$
UPARTN    USET,K4FF / K4OO, ,K4OA,K4AAB / *F*/*O*/*A* $
MPYAD     K4OO,GO,K4OA / K4AATMP1 / 0 $
MPYAD     K4OA,GO,K4AAB / K4AATMP2 / 1 $
MPYAD     GO,K4AATMP1,K4AATMP2 / K4AA / 1 $
$
UPARTN    USET,BFF / BOO, ,BOA,BAAB / *F*/*O*/*A* $
MPYAD     BOO,GO,BOA / BAATEMP1 / 0 $
MPYAD     BOA,GO,BAAB / BAATEMP2 / 1 $
MPYAD     GO,BAATEMP1,BAATEMP2 / BAA / 1 $
$
ENDALTER  $

The matrix operations can be further subdivided by making the partitioning
information contained in USET available to the PARTN module. The following
ALTER packet accomplishes this by the use of the VEC and PARTN modules. 

SMP1 and SMP2 using VEC and PARTN for Rigid Format No. 7

ALTER     n1,n2 $ (where n1 = DMAP statement number of the SMP1 module and n2 =
          DMAP statement number of the third use of the SMP2 module)
$
VEC       USET / V / *F*/*O*/*A* $
$
PARTN     KFF,V / KOO, ,KOA,KAAB / $
DECOMP    KOO / LOO,UOO / 1 / 0 / S,N,MIND / S,N,DET / S,N,NDET / S,N,SING $
COND      LSING,SING $
FBS       LOO,UOO,KOA / GO / 1 / -1 $
MPYAD     KOA,GO,KAAB / KAA / 1 $
$
PARTN     MFF,V, / MOO, ,MOA,MAAB $
MPYAD     MOO,GO,MOA / MAATEMP1 / 0 $
MPYAD     MOA,GO,MAAB / MAATEMP2 / 1 $
MPYAD     GO,MAATEMP1,MAATEMP2 / MAA / 1 $
$
PARTN     K4FF,V, / K4OO, ,K4OA,K4AAB / $
MPYAD     K4OO,GO,K4OA / K4AATMP1 / 0 $
MPYAD     K4OA,GO,K4AAB / K4AATMP2 / 1 $
MPYAD     GO,K4AATMP1,K4AATMP2 / K4AA / I $
$
PARTN     BFF,V, / BOO, ,BOA,BAAB $
MPYAD     BOO,GO,BOA / BAATEMP1 / 0 $
MPYAD     BOA,GO,BAAB / BAATEMP2 / 1 $
MPYAD     GO,BAATEMP1,BAATEMP2 / BAA / 1 $
$
ALTER     n3 $ ADD ERROR TRAP FOR SINGULAR KOO MATRIX IN R.F. 7
          (n3 = DMAP statement number of JUMP FINIS)
$
LABEL     LSING $
PRTPARM   // 0 / *SING* $
PRTPARM   //  -1 / *DMAP* $
EXIT      $
$
ENDALTER $

5.8.11  DMAP to Perform Matrix Operations Using Conditional Logic
-----------------------------------------------------------------
Let A, B, and C be matrices whose values are to be defined at execution time.
Let + be a real constant whose value is to be defined at execution time. Let +
be an integer constant whose value (defined at execution time) determines the
operations to be performed to compute matrix X as follows: 

              +
              | [A][B] + [C]     , + < 0
              |             T
   [X]    =   | [+[A] + [B]]     , + = 0
              |    2   -1
              | [A] [C]          , + > O
              +

Write a DMAP to accomplish the above, assuming A, B, and C will be defined by
DMI bulk data cards and that + and + will be defined on PARAM bulk data cards.
Print the inputs and outputs using the DMAP Utility Functional Modules MATPRN
and PRTPARM. Use the DMAP Utility Module SEEMAT to print a topology display of
[A] and [X]. 

A solution to this problem is given below along with data for an actual
example.

ID A,B
TIME 5
APP DMAP
BEGIN $
JUMP START $
PARAM // C,N,NOP / V,N,TRUE=-1 $ SET TRUE TO -1 (=.TRUE.)
LABEL START $
MATPRN A,B,C,, // $
COND ONE,ALPHA $
PARAM // C,N,NOT / V,N,CHOOSE / V,Y,ALPHA $
COND THREE,CHOOSE $
JUMP TWO $
LABEL ONE $                                                       ALPHA .LT. 0
MPYAD A,B,C / X / C,N,0 $
JUMP FINIS $
LABEL TWO $                                                       ALPHA .EQ. 0
ADD A,B / Y / C,Y,BETA=(0.0,0.0) $
TRNSP Y / X2 $
EQUIV X2,X / TRUE $
JUMP FINIS $
LABEL THREE $                                                     ALPHA .GT. 0
SOLVE C, / Z $
MPYAD A,Z, / W / C,N,0 $
MPYAD A,W, / X3 / C,N,0 $
EQUIV X3,X / TRUE $
LABEL FINIS $
MATPRN X,,,, // $
SEEMAT A,X,,, // C,N,PRINT $
PRTPARM // C,N,0 $
END $
CEND
TITLE = TEST MPYAD
BEGIN BULK

DMI     A       0       6       1       2                2       2
DMI     A       1       1       1.01
DMI     A       2       2       1.01
DMI     B       0       6       1       2                2       2
DMI     B       1       1       1.01
DMI     B       2       2       1.01
DMI     C       0       6       1       2                2       2
DMI     C       1       1       1.01
DMI     C       2       2       1.01
PARAM   ALPHA   -1
PARAM   BETA    1.0      .0
ENDDATA

5.9  AUTOMATIC SUBSTRUCTURE DMAP ALTERS
=======================================
  In the automated substructure process, your commands (described in Section
2.7) are converted to the form of DMAP instructions via ALTER card
equivalents. This section describes the resulting DMAP data for each command.

  The raw DMAP data, stored in the program and modified according to your
input data, is listed by command type. The subcommand control cards are
identified by parentheses on the right side. For example, the (P only) for the
SUBSTRUCTURE command item 12, implies that this DMAP instruction is included
only if the OPTION request includes P (loads).

  The ALTER card images are not true DMAP instructions but are used to locate
positions in the existing DMAP Rigid Format for replacement by or insertion of
the new DMAP instructions. The locations to be specified depend on the Rigid
Format selected by the SOL Executive Control Card and are listed in Volume II
for each Rigid Format. The relevant section of the Rigid Format for each ALTER
is indicated by the note in parentheses. For instance, "After GP4" in Rigid
Format 1 (statics) implies "ALTER nn" (where nn is the DMAP instruction number
of the GP4 module) for insertion of the corresponding DMAP instructions
following Rigid Format 1 DMAP instruction number nn. If an existing set of
DMAP instructions is to be removed, the parenthetical note may indicate
"Remove DECOMP", where DECOMP may be a set of NASTRAN modules related to the
entire decomposition process.

  The descriptions given below are highly dependent on your input commands
and the Rigid Format selected. For an exact listing of all DMAP data generated
for the current set of substructure commands, the DIAG 23 Executive Control
Card may be input. Adding DIAG 24 will produce a punched deck of the actual
ALTER cards generated. This feature allows you to modify these ALTERs and
execute under APP DMAP,SUBS.

5.9.1  Index of Substructure DMAP ALTERs
----------------------------------------
ALTER               Basic Function                                Page

BRECOVER            Convert Phase 2 results to solution vectors  5.9-2
COMBINE             Combine several substructures                5.9-3
CREDUCE             Complex modal reduction of a substructure    5.9-4
DELETE           +
DESTROY          |
EDIT             |  Internal utility commands                    5.9-5
EQUIV            |
RENAME           |
SOFPRINT         +
MREDUCE             Real modal reduction of a substructure       5.9-6
PLOT                Plot substructures                           5.9-7
RECOVER, MRECOVER   Recover and output Phase 2 solution data or  5.9-8
                    Phase 1, 2 modal reduction data
REDUCE              Initiate matrix partitioning operations      5.9-9
RUN                 Define the DRY parameter                    5.9-10
SOFIN            +
SOFOUT           |
RESTORE          |  File operators                              5.9-11
DUMP             |
CHECK            +
SOLVE               Provide data for execution of the solution phase5.9-12
SUBSTRUCTURE        Initiate the automatic DMAP process         5.9-14

DMAP for Command BRECOVER (Phase 3)
===================================
  The BRECOVER command converts the results of a Phase 2 substructure
analysis to NASTRAN solution vectors for the detailed calculation of basic
structure (or an equivalent basic substructure) displacements, forces, loads,
and stresses. The same structure model of the primary substructure defined in
Phase 1 must be used in Phase 3. It is possible to perform the Phase 3
execution either as a restart of the Phase 1 run or as an independent run,
which recalculates the necessary data blocks.

Raw DMAP
--------
 1   ALTER     (Remove solution)
 2   PARAM     //*NOP*/ALWAYS=-1 $
 3   SSG1      SLT,BGPDT,CSTM,SIL,EST,MPT,GPTT,EDT,MGG,CASECC,DIT/   +
 4             PG/LUSET/NSKIP $   (R.F. 9 only)                      | (P or PA
 5   SSG2      USET,GM,YS,KFS,GO,,PG/                                |  only)
               QR,PO,PS,PL $ (R.F. 1,2,3 or 9 only)                  +
 6   RCOVR3    ,PG,PS,PO,YS/UAS,QAS,PGS,PSS,POS,YSS,LAMA/SOLN/
 7             *NAME*/NDUE $
 8   EQUIV     PGS,PG/ALWAYS $                          +
 9   EQUIV     PSS,PS/ALWAYS $                          |
10   EQUIV     POS,PO/ALWAYS $                          |
11   EQUIV     YSS,YS/ALWAYS $  (R.F. 1 or 2 only)      | (P or PA only)
12   COND      LBSSTP,OMIT $                            |
13   FBS       LOO,,POS/UOOV/1/1/PREC/0 $               |
14   LABEL     LBSSTP $                                 +
15   OFP       LAMA,,,,,//CARDNO $  (R.F. 3 only)
16   ALTER     (After SDRI)
17   UMERGE    USET,QAS,/QGS/*G*/*A*/*O* $
18   ADD       QG,QGS/QGT $
19   EQUIV     QGT,QG/ALWAYS $
20   EQUIV     CASECC,CASEXX/ALWAYS $  + (R.F. 8 or 9 only)
21   ALTER     (Remove repeat logic)   +

Variables
---------
YS,PO                Remove if not P or PA, or if not R.F. 1 or 2.
PG,PS                Remove if not P or PA, or if not R.F. 1, 2, or 9.

                     R.F. 1     2    3     8    9
UAS                       ULV   ULV  PHIA  UDVF UDVT
PGS                       PGS   PGS             PPT
PSS                       PSS   PSS             PST
LAMA                                 LAMA  PPF  TOL
QG                        QG    QG   QG    QPC  QP

POS                  Remove if not P or PA. or if not R.F. 1, 2, or 3.
SOLN                 Rigid Format solution number.
NAME                 Name of basic Phase 1 substructure, corresponding to
                     input data.
NOUE                 Remove if not R.F. 8 or 9.
STP                  Step number.
PREC                 Precision.

DMAP for Command COMBINE
========================
  The COMBINE command initiates the process for combining several
substructures defined on the SOF files. The COMB1 module reads the control
deck and the bulk data cards and builds the tables and transformation matrices
for the combination structure. The COMB2 module performs the matrix
transformations using the matrices stored on the SOF file or currently defined
as NASTRAN data blocks. The resultant matrices are stored on the SOF file and
retained as NASTRAN data blocks.

Raw DMAP
--------
 1   COMB1     CASECC,GEOM4//STP/S,N,DRY/*PVEC* $
 2   COND      LBSTP,DRY $
 3   COMB2     ,KN0l,KN02,KN03,KN04,KN05,KN06,KN07/KNSC/S,N,DRY      +
 4             /*K*/*     */*NAME0001*/*NAME0002*/*NAME0003*/        | (K only)
 5             *NAME0004*/*NAME0005*/*NAME0006*/*NAME0007* $         |
 6   SOFO      ,KNSC,,,,//S,N,DRY/*NAMEC   */*KMTX* $                +
 7   COMB2     ,MN01,MN02,MN03,MN04,MN05,MN06,MN07/MNSC/S,N,DRY/     +
 8             *M*/*     */*NAME000l*/*NAME0002*/*NAME0003*/         | (M only)
 9             *NAME0004*/*NAME0005*/*NAME0006*/*NAME0007* $         |
10   SOFO      ,MNSC,,,,//S,N,DRY/*NAMEC   */*MMTX* $                +
11   COMB2     ,PN01,PN02,PN03,PN04,PN05,PN06,PN07/PNSC/S,N.DRY/     +
12             *P*/*PVEC*/*NAME0001*/*NAME0002*/*NAME0003*/          | (P or PA
13             *NAME0004*/*NAME0005*/*NAME0006*/*NAME0007* $         |  only)
14   SOFO      ,PNSC,,,,//S,N,DRY/*NAMEC   */*PVEC $                 +
15   COMB2     ,BN0l,BN02,BN03,BN04,BN05,BN06,BN07/BNSC/S,N,DRY/     +
16             *B*/*     */*NAME0001*/*NAME0002*/*NAME0003*/         | (B only)
17             *NAME0004*/*NAME0005*/*NAME0006*/*NAME0007* $         |
18   SOFO      ,BNSC,,,,//S,N,DRY/*NAMEC   */*BMTX* $                +
19   COMB2     ,K4N01,K4N02,K4N03,K4N04,K4N05,K4N06,K4N07/K4NSC/     +
20             S,N,DRY/*K4*/*    */*NAME000l*/*NAME0002*/*NAME0003*/ | (K4 only)
21             *NAME0004*/*NAME0005*/*NAME0006*/*NAME0007* $         |
22   SOFO      ,K4NSC,,,,//S,N,DRY/*NAMEC   */*K4MX* $               +
23   LABEL     LBSTP $
24   LODAPP    PNSC,//*NAMEC   */S,N,DRY $   (PA only)

Variables
---------
STP                     Step number.
PVEC                    PVEC for P option, PAPP for PA option.
N01,N02,...etc.               Internal numbers for structures to be combined.
NSC                     Internal number of combined structure.
NAME000l,NAME0002,...,etc. Names of pseudostructures to be combined.
NAMEC                Name of combined structure.

DMAP for Command CREDUCE
========================
   The CREDUCE command performs a complex modal synthesis reduction for a
component substructure. The resulting generalized coordinates for the reduced
substructure will consist of selected boundary point displacements and
generalized displacements of the eigenvectors. The MRED1 module produces dummy
USET and EED data blocks for the execution of the eigenvector extraction
procedure. The EQST data block is created for use by the CMRED2 module. The
CMRED2 module performs the actual matrix reduction. Note that, because the
number of modal degrees of freedom is a calculated value, the RUN = DRY option
is not allowed for complex modal reduction.

Raw DMAP
--------
 1   PARAM     //*NOP*/ALWAYS=-1 $
 2   MRED1     CASECC,GEOM4,DYNAMICS,CSTM/USETR,EEDR,EQST,DMR/*NAMEA   */
 3             S,N,DRY/STP/S,N,NOFIX/S,N,SKIPM/*COMPLEX* $
 4   COND      LBM3STP,DRY $
 5   SOFI      /KNOA,MNOA,PNOA,BNOA,K4NOA/S,N,DRY/*NAMEA   */*KMTX*/*MNTX*/
 6             *PVEC*/*BMTX*/*K4MX* $
 7   COND      LBM2STP,SKIPM $                                  +
 8   EQUIV     KNOA,KFFX/NOFIX $     (K only)                   |
 9   EQUIV     MNOA,MFFX/NOFIX $     (M only)                   |
10   EQUIV     BNOA,BFFX/NOFIX $     (B only)                   |
11   EQUIV     K4NOA,K4FFX/NOFIX $   (K4 only)                  |
12   COND      LBM1STP,NOF1X $                                  |
13   SCE1      USETR,KNOA,MNOA,BNOA,K4NOA/KFFX,KFSX,KSSX,MFFX,  |
14             BFFX,K4FFX $                                     | (Remove for
15   LABEL     LBM1STP $                                        |  option PA)
16   PARAMR    //*COMPLEX*//1,0/GPARAM  /G $                    |
17   ADD       KFFX,K4FFX/KDD/G/(0,0,1,0) $                     |
18   EQUIV     KDD,KFFX/ALWAYS $                                |
19   CEAD      KFFX,BFFX,MFFX,EEDR,/PHIDR,CLAMA,OCEIGS,PHIDL    |
20             /NEIGVS $                                        |
21   OFP       CLAMA,OCEIGS,,,,// $                             |
22   EQUIV     PHIDR,PHIFR/NOFIX $                              |
23   EQUIV     PHIDL,PHIFL/NOFIX $                              |
24   COND      LBM2STP,NOFIX $                                  |
25   UMERGE    USETR,PHIDR,/PHIFR/*N*/*F*/*S* $                 |
26   UMERGE    USETR,PHIDL,/PHIFL/*N*/*F*/*S* $                 +
27   LABEL     LBM2STP $
28   CMRED2    CASECC,CLAMA,PHIFR,PHIFL,EQST,USETR,KNOA,MNOA,BNOA,K4NOA,PNOA/
29             KNOB,MNOB,BNOB,K4NOB,PNOB,PONOB/STP/S,N,DRY/*PVEC* $
30   LABEL     LBM3STP $
31   LODAPP    PNOB,PONOB//*NAMEB___*/S,N,DRY $   (PA only)
32   COND      FINIS,DRY $

Variables
---------
STP                     Step number.
PVEC                    PVEC for option P, PAPP for option PA.
NAMEA                Name of input substructure, A.
NAMEB                Name of output substructure, B.
NOA                     Internal number of substructure A.
NOB                     Internal number of substructure B.
KFFX,KFSX,KSSX          K only.
MFFX                    M only.
BFFX                    B only.
K4FFX                   K4 only.
CLAMA,PHIFR,PHIFL       Remove for option PA.

DMAP for Utility Commands DELETE, DESTROY, EDIT, EQUIV, RENAME, SOFPRINT

   Several internal operations of the SOF may be performed with the utility
commands which create various calls to the SOFUT module. Each of the commands
and associated data are inserted as parameters.

Raw DMAP
--------
1    SOFUT     //DRY/*NAME    */*OPER*/OPT/*NAME0002*/*PREF*/*ITM1*/*ITM2*/
2              *ITM3*/*ITM4*/*ITM5* $

Variables
---------
NAME                    Name of substructure.
OPER                    Operation to be performed (first four characters of
                        command, for example, EDIT).
OPT                     Integer option code.
NAME0002                Second substructure name for EQUIV and RENAME.
PREF                    Prefix for EQUIV operation.
ITM1,ITM2, etc.         SOF data item names.

The following table describes the variables used for each command.

+--------------------------------------------------------------+
| Command     NAME   OPER   OPT   NAME0002   PREF   ITM1, etc. |
+--------------------------------------------------------------+
| DELETE       X      X                                 X      |
|                                                              |
| DESTROY      X      X                                        |
|                                                              |
| EDIT         X      X      X                                 |
|                                                              |
| EQUIV        X      X              X        X                |
|                                                              |
| RENAME       X      X              X                         |
|                                                              |
| SOFPRINT     X      X      X                          X      |
+--------------------------------------------------------------+

DMAP for Command MREDUCE
------------------------
   The MREDUCE command performs a modal synthesis reduction for a component
substructure. The resulting generalized coordinates for the reduced
substructure will consist of selected boundary point displacements and
generalized displacements of the modal coordinates. The MRED1 module produces
dummy USET and EED data blocks for the execution of the mode extraction
procedure. The EQST and DMR data blocks are created for use by the MRED2
module. The MRED2 module performs the actual matrix reduction. Note that,
because the number of modal degrees of freedom is a calculated value, the RUN
= DRY option is not allowed for modal reduction.

Raw DMAP
--------
 1   MRED1     CASECC,GEOM4,DYNAMICS,CSTM/USETR,EEDR,EQST,DMR/*NAMEA   */
 2             S,N,DRY/STP/S,N,NOFIX/S,N,SKIPM/*REAL* $
 3   COND      LBM3STP,DRY $
 4   SOFI      /KNOA,MNOA,PNOA,BNOA,K4NOA/S,N,DRY/*NAMEA   */*KMTX*/*MMTX*/
 5             *PVEC*/*BMTX*/*K4MX* $
 6   COND      LBM2STP,SKIPM $                               +
 7   EQUIV     KNOA,KFFX/NOFIX $     (K only)                |
 8   EQUIV     MNOA,MFFX/NOFIX $     (M only)                |
 9   EQUIV     BN0A,BFFX/NOFIX $     (B only)                |
10   EQUIV     K4NOA,K4FFX/NOFIX $   (K4 only)               |
11   COND      LBM1STP,NOFIX $                               |
12   SCE1      USETR,KNOA,MNOA,BNOA,K4NOA/KFFX,KFSX,KSSX,    |  (Remove for
13             MFFX,BFFX,K4FFX $                             |   PA)
14   LABEL     LBM1STP $                                     |
15   READ      KFFX,MFFX,BFFX,K4FFX,EEDR,USETR,/LAMAR,PHIR,  |
16             MIR,OEIGR/*MODES*/NEIGVS $                    |
17   OFP       LAMAR,OEIGR,,,,// $                           |
18   EQUIV     PHIR,PHIS/NOFIX $                             |
19   COND      LBM2STP,NOFIX $                               |
20   UMERGE    USETR,PHIR,/PHIS/*N*/*F*/*S* $                +
21   LABEL     LBM2STP $
22   MRED2     CASECC,LAMAR,PHIS,EQST,USETR,KNOA,MNOA,BNOA,K4NOA,PNOA,DMR,
23             QSM/KNOB,MNOB,BNOB,K4NOB,PNOB,PONOB/STP/S,N,DRY/*PVEC* $
24   LABEL     LBM3STP $
25   LODAPP    PNOB,PONOB//*NAMEB   */S,N,DRY $   (PA only)
26   COND      FINIS,DRY $

Variables
---------
STP                     Step number.
PVEC                    PVEC for option P, PAPP for option PA.
NAMEA                Name of input substructure, A.
NAMEB                Name of output substructure, B.
NOA                     Internal number of substructure A.
NOB                     Internal number of substructure B.
KFFX,KFSX,KSSX          K only.
MFFX                    M only.
BFFX                    B only.
K4FFX                   K4 only.
LAMAR,PHIS              Remove for option PA.
QSM                     Remove for R.F. 9.

DMAP for Substructure Plots: PLOT
---------------------------------
   Any level of substructure may be plotted as an undeformed shape using the
existing NASTRAN plot logic. The plot sets generated in Phase 1 are combined
and transformed for that plotting.

Raw DMAP
--------
1    PLTMRG    CASECC,PCDB/PLTSTP,GPSTP,ELSTP,BGSTP,CASSTP,EQSTP/*NAME   */
2              S,N,NGP/S,N,LSIL/S,N,NPSET $
3    SETVAL    //S,N,PLTFLG/1/S,N,PFIL/0 $
4    PLOT      PLTSTP,GPSTP,ELSTP,CASSTP,BGSTP,EQSTP,,,,,/PMSTP/NGP/LSIL/
5              S,N,NPSET/S,N,PLTFLG/S,N,PFIL $
6    PRTMSG    PMSTP// $

Variables
---------
NAME                    Name of substructure to be plotted.
STP                     Step number.

DMAP for Commands RECOVER (Phase 2), MRECOVER (Phase 1, 2)
----------------------------------------------------------
   RECOVER performs the recovery and output of the Phase 2 solution data.
MRECOVER performs the recovery and output subsequent to a Phase 1 or 2 MREDUCE
or CREDUCE operation. The NASTRAN solution displacement vector (either
displacement vectors or eigenvectors) is transformed and expanded to
correspond to the degrees of freedom of the selected component substructures.
Each pass through the DMAP loop corresponds to a requested structure to be
processed. The RCOVR module selects the substructure to be processed with the
loop counter, ILOOP.

Raw DMAP
--------
1    FILE      U1=APPEND/U2=APPEND/U3=APPEND/U4=APPEND/U5=APPEND $
2    PARAM     //*ADD*/ILOOP/0/0 $
3    LABEL     LBSTP $
4    RCOVR     CASESS,GEOM4,KGG,MGG,PGG,UGV,DIT,DLT,BGG,K4GG,PPF/OUGV1,
5              OPG1,OQG1,U1,U2,U3,U4,U5/S,N,DRY/S,N,ILOOP/STP/*NAMEFSS */
6              NSOL/NEIGV/S,N,LUI/S,N,U1N/S,N,U2N/S,N,U3N/S,N,U4N/S,N,U5N/
7              S,N,NOSORT2/V,Y,UTHRESH/V,Y,PTHRESH/V,Y,QTHRESH $
8    EQUIV     OUGV1 ,OUGV /NOSORT2/OQG1,OQG/NOSORT2 $
9    EQUIV     OPG1,OPG/NOSORT2 $   (R.F. 1, 2, 8, or 9 only)
1O   COND      NST2STP,NOSORT2 $
11   SDR3      OUGV1 ,OPG1,OQG1,,,/OUGV ,OPG,OQG,,, $
12   LABEL     NST2STP $
13   OFP       OUGV ,OPG,OQG,,,//S.N,CARDNO $
14   COND      LBBSTP,ILOOP $
15   REPT      LBSTP,100 $
16   LABEL     LBBSTP $
17   SOFO      ,U1,U2,U3,U4,U5//-1/*xxxxxxxx* $

Variables
---------
KGG                     K option only.
MGG                     M option only.
BGG                     B option only.
K4GG                    K4 option only.

                        R.F.     1       2        3        8        9
GEOM4                         GEOM4 GEOM4LAMA     GEOM4 GEOM4
PGG                              PGG     PGG               PPF      PPT
UGV                              UGV     UGV      PHIG     UGV      UGV
PPF                                                        PPF      TOL
OUGV1                         OUGV1 OUGV1OPHIG1   OUGV1 OUGV1
OUGV                             OUGV    OUGV     OPHIG    OUGV     OUGV

SS                      SS or CC (if after SOLVE step).
DIT, DLT                Remove if not R.F. 1, 2, or 3.
OPG1, OPG               Remove if R.F. 3.
NSOL                    Rigid Format solution number.
NEIGV                   R.F. 3 only.
NAMEFSS                 Name of solution structure.

DMAP for Command REDUCE
-----------------------
   The REDUCE command initiates the matrix partitioning operations to be
performed on the stiffness, mass, damping, and load vectors in order to
produce a set of matrices defined by a subset of the original degrees of
freedom. The REDUCE module generates the partitioning vector PV, a USET data
block US, and an identity matrix IN from the bulk data and the corresponding
substructure tables stored on the SOF. The remainder of the DMAP sequence
directs the actual matrix operations.

Raw DMAP
--------
 1   REDUCE    CASECC,GEOM4/PVNOA,USSTP,INSTP/STP/S,N,DRY/*PVEC* $
 2   COND      LBRSTP,DRY $
 3   SOFI      /KNOA,MNOA,PNOA,BNOA,K4NOA/S,N,DRY/*NAME000A*/*KMTX*/*MMTX*/
 4             *PVEC*/*BMTX*/*K4MX* $
 5   COND      LBRSTP,DRY $
 6   SMP1      USSTP,KNOA,,,/GONOA,KNOB,KONOA,LONOA,,,,, $     +
 7   MERGE     GONOA,INSTP,,,,PVNOA/GNOA/1/TYP/2 $             |  (K only)
 8   SOFO      ,GNOA,LONOA,,,//DRY/*NAME000A*/*HORG*/*LMTX* $  +
 9   SOFO      ,KNOB,,,,//DRY/*NAME000B*/*KMTX* $
10   SOF1      /GNOA,,,,/S,N,DRY/*NAME000A*/*HORG* $   (all except K)
11   MPY3      GNOA,MNOA,/MNOB/0/0 $                           +  (M only)
12   SOFO      `MNOB,,,,//DRY/*NAME000B*/*MMTX* $              +
13   MPY3      GNOA,BNOA,/BNOB/0/0 $                           +  (B only)
14   SOFO      ,BNOB,,,,//DRY/*NAME000B*/*BMTX* $              +
15   MPY3      GNOA,K4NOA,/K4NOB/0/0 $                         +  (K4 only)
16   SOFO      ,K4NOB,,,,//DRY/*NAME000B*/*K4MX* $             +
17   PARTN     PNOA,,PVNOA/PONOA,,,/1/1/2 $                    +  (P or PA
18   MPYAD     GNOA,PNOA,/PNOB/1/1/0/1 $                       |   only)
19   SOFO      ,PONOA,,,,//DRY/*NAME000A*/*POVE* $             +
20   SOFO      ,PVNOA,,,,//DRY/*NAME000A*/*UPRT* $
21   S9F9      ,PNOB,,,,//DRY/*NAME000B*/*PVEC* $   (P or PA only)
22   LABEL     LBRSTP $
23   LODAPP    PNOB,PONOA//*NAME000B*/S,N,DRY $      (PA only)

Variables
---------
STP                     Step number.
NAME000A             Name of input structure, A.
NAME000B             Name of output structure, B.
NOA,NOB                 Internal numbers of substructures A and B.
TYP                     Matrix precision flag (1 = single).
PVEC                    PVEC for P option, PAPP for PA option.
POVE                    POVE for P option, POAP for PA option.

DMAP for Command RUN
--------------------
   The RUN command defines the DRY parameter for use by the subsequent DMAP
instructions. If you specify RUN = DRY, a special set of DMAP instructions is
placed at the end of the entire command sequence.

Raw DMAP
--------
 PARAM         //*ADD*/DRY/I  /0$

Variables
---------
I                       Integer code for RUN option (DRY = -1, GO = 0, STEP =
                        1).

                        If RUN = DRYGO, I is set to (DRY) initially and the
                        following DMAP is inserted at the end of the complete
                        ALTER stream:

                        LABEL          LBSEND $
                        PARAM          //*ADD*/DRY/DRY/1 $
                        COND           FINIS,DRY $
                        REPT           LBSBEG,1 $
                        JUMP           FINIS $

DMAP for External I/O Commands SOFIN, SOFOUT, RESTORE, DUMP, CHECK
------------------------------------------------------------------
   Several operations may be performed on the NASTRAN user files and the SOF
file using the EXIO module. The various input parameters are set by the
Substructure Commands.

Raw DMAP
--------
EXIO           //S,N,DRY/MACH/*DEVI*/*UNITNAME*/*FORM*/*MODE*/*POSI*/*ITEM*/
               *NAME0001*/*NAME0002*/*NAME0003*/*NAME0004*/*NAME0005* $

Variables
---------
MODE                    First four characters of command name (that is,
                        "SOFI", "REST").
DEVI                    Device used for I/O file ("TAPE" or "DISK").
UNITNAME             Name of NASTRAN user file assigned to I/O file (that is,
                     INPT, INP1, etc.).
FORM                    Format of data ("EXTE" or "INTE").
POSI                    Position of file on device ("REWI", "NORE", or "EOF").
ITEM                    Name of SOF item or "ALL", "MATR", "TABL", or "PHAS".
NAME0001, etc.          Names of substructures to be copied.

The following table describes the variables used for each command:

+------------------------------------------------------------------+
| Command   MODE   DEVI   UNITNAME   FORM   POSI   ITEM   NAME000i |
+------------------------------------------------------------------+
| SOFlN      X       X        X        X      X      X       X     |
|                                                                  |
| SOFOUT     X       X        X        X      X      X       X     |
|                                                                  |
| RESTORE    X       X        X                                    |
|                                                                  |
| DUMP       X       X        X                                    |
|                                                                  |
| CHECK      X       X        X                                    |
+------------------------------------------------------------------+

DMAP for Command SOLVE
----------------------
   The SOLVE command provides the necessary data for execution of the solution
phase of NASTRAN. Module SGEN replaces the NASTRAN GP1 module for the purpose
of defining an equivalent pseudostructure from data blocks. The new data
blocks GE3S and GE4S contain the load and constraint data in the form of
converted bulk data card images. The stiffness, mass, viscous damping, and
structural damping matrices are obtained from the SOF files and added to any
user matrix terms. The static and dynamic analysis rigid formats require
separate raw DMAP. Both sets of raw DMAP are shown below.

Raw DMAP, Rigid Formats 1-3
---------------------------
 1   ALTER     (Remove GP1)
 2   PARAM     //*NOP*/ALWAYS=-1 $
 3   SGEN      CASECC,GEOM3,GEOM4,DYNAMICS/CASESS,CASEI,GPL,EQUEXIN,GPDT,
 4             BGPDT,SIL,GE3S,GE4S,DYNS/S,N,DRY/*NAMESOLS*/S,N,LUSET/
 5             S,N,NOGPDT $
 6   PURGE     CSTM $
 7   EQUIV     GE3S,GEOM3/ALWAYS/GE4S,GEOM4/ALWAYS/CASEI,CASECC/ALWAYS/
 8             DYNS,DYNAMICS/ALWAYS $
 9   COND      LBSTP,DRY $
10   ALTER     (Remove PLOT)
11   ALTER     (Remove NOSIMP COND)
12   COND      LBSOL,NOSIMP $
13   ALTER     (Remove Property Optimization EQUIV or NOMGG COND)
14   COND      LBSOL,NOMGG $
15   ALTER     (Remove SMA3)
16   LABEL     LBSOL $
17   SOFI      /KNOS,MNOS,,,/DRY/*NAMESOLS*/*KMTX*/*MMTX* $
18   EQUIV     KNOS,KGG/NOSIMP $   (K only)
19   EQUIV     MNOS,MGG/NOSIMP $   (M only)
20   COND      LBSTP,NOSIMP $
21   ADD       KGGX,KNOS/KGG $   (K only)
22   ADD       MGG,MNOS/MGGX $   (M only)
23   EQUIV     MGGX,MGG/ALWAYS $
24   LABEL     LBSTP $
25   CHKPNT    MGG $
26   ALTER     (After GP4)
27   COND      LBSEND,DRY $
28   ALTER     (Remove SDR2 - PLOT)

Variables
---------
NAMESOLS             Name of solution structure.
NOS                     Internal number of solution structure.
STP                     Step number.

Raw DMAP, Rigid Formats 8, 9
----------------------------
 1   ALTER     (Remove GP1)
 2   PARAM     //*NOP*/ALWAYS=-1 $
 3   SGEN      CASECC,GEOM3,GEOM4,DYNAMICS/CASESS,CASEI,GPL,EQEXIN,GPDT,
 4             BGPDT,SIL,GE3S,GE4S,DYNS/S,N,DRY/*NAMESOLS*/S,N,LUSET/
 5             S,N,NOGPDT $
 6   PURGE     CSTM $
 7   EQUIV     GE3S,GEOM3/ALWAYS/GE4S,GEOM4/ALWAYS/CASEI,CASECC/ALWAYS
 8             DYNS,DYNAMICS/ALWAYS $
 9   COND      LBSTP,DRY $
10   ALTER     (Remove PLOT)
11   ALTER     (Remove NOSIMP PURGE and COND)
12   ALTER     (Remove GPWG and SMA3)
13   SOFI      /KNOS,MNOS,BNOS,K4NOS,/DRY/*NAMESOLS*/*KMTX*/*MMTX*/*BMTX*/
14             *K4MX* $
15   EQUIV     KNOS,KGG/NOKGGX $   +
16   COND      LB2K,NOKGGX $       |  (K only)
17   ADD       KGGX,KNOS/KGG $     |
18   LABEL     LB2K $              +
19   EQUIV     MNOS,MGG/NOMGG $    +
20   COND      LB2M,NOMGG $        |
21   ADD       MGG,MNOS/MGGX $     |  (M only)
22   EQUIV     MGGX,MGG/ALWAYS $   |
23   LABEL     LB2M $              +
24   EQUIV     BN0S,BGG/NOBGG $    +
25   COND      LB2B,NOBGG $        |
26   ADD       BGG,BNOS/BGGX $     |  (B only)
27   EQUIV     BGGX,BGG/ALWAYS $   |
28   LABEL     LB2B $              +
29   EQUIV     K4NOS,K4GG/NOK4GG $ +
30   COND      LB2K4,NOK4GG $      |
31   ADD       K4GG,K4NOS/K4GGX $  |  (K4 only)
32   EQUIV     K4GGX,K4GG/ALWAYS $ |
33   LABEL     LB2K4 $             +
34             LBSTP $
35   CHKPNT    MGG,BGG,K4GG $
36   ALTER     (Remove MDEMA, KDEK2 PARAM)
37   PARAM     //*AND*/MDEMA/NQUE/NOM2PP $
3B   PARAM     //*ADD*/KDEK2/1/0 $   (K only)
39   PARAM     //*ADD*/NOMGG/1/0 $   (M only)
40   PARAM     //*ADD*/NOBGG/1/0 $   (B only)
41   PARAM     //*ADD*/NOK4GG/1/0 $  (K4 only)
42   ALTER     (Remove NOSIMP, NOGPDT EQUIV)
43   EQUIV     K2DD,KDD/KDEK2 $
44   EQUIV     M2DD,MDD/NOMGG $
45   EQUIV     B2DD,BDD/NOBGG $
45   ALTER     (Remove SDR2 and PLOT)
47   EQUIV     UPVF,UPVC/NOA $
48   COND      LBL19,NOA $
49   SDR1      USETD,,UDVF,,,GOD,GMD,,,,/UPVC,,/1/DYNAMICS $
50   LABEL     LBL19 $
51   CMKPNT    UPVC $
52   EQUIV     UPVC,UGV/NOUE $
53   COND      LBUE,NOUE $
54   UPARTN    USET,UPVC/UGV,UEV,,/*P*/*G*/*E* $
55   LABEL     LBUE $

Variables
---------
NAMESOLS             Name of solution structure.
NOS                     Internal number of solution structure.
STP                     Step number.
UDVF                    UDVF for R.F. 8, UDVT for R.F. 9.

DMAP for Command SUBSTRUCTURE
-----------------------------
   The SUBSTRUCTURE command is necessary to initiate the automatic DMAP
process. In Phase 1, the SUBPH1 module is used to build the substructure
tables on the SOF from the NASTRAN grid point tables and the SOFO module is
used to copy the matrices onto the SOF. In Phase 2 and Phase 3, the initial
value of the DRY parameter is set and the DMAP sequence is initiated.

Raw DMAP
--------
                                    PHASE 1

 1   ALTER     2,0
 2   PARAM     //*NOP*/ALWAYS=-1 $
 3   SGEN      CASECC,,,/CASESS,CASEI,,,,,,,,/S,N,DRY/*XXXXXXXX*/S,N,LUSET/
 4             S,N,NOGPDT $
 5   EQUIV     CASEI,CASECC/ALWAYS $
 6   ALTER     (After GP4)
 7   PARAM     //*ADD*/DRY-1 /0 $
 8   LABEL     LBSBEG $
 9   COND      LBLIS,DRY $   (R.F. 1, 2, 3, and 9 only)
10   SSG1      SLT,BGPDT,CSTM,SIL,EST,MPT,GPTT,EDT,MGG,CASECC,DIT/   + (R.F.
11             PG/LUSET/NSKIP $                                      | 9 & P
12   CHKPNT    PG $                                                  + or PA
13   ALTER     (Remove DECOMP)                                         only)
14   SSG2      USET,GM,,KFS,GO,,PG/QR,PO,PS,PL $                     + (R.F.
15   CHKPNT    PO,PS,PL $                                            + 9 & P
16   LABEL     LBLIS $   (R.F. 1, 2, 3, and 9 only)                    or PA
17   ALTER     (Remove solution)                                       only)
18   SUBPH1    CASECC,EQEXIN,USET,BGPDT,CSTM,GPSETS,ELSETS//S,N,DRY/
19             *NAME    */PLOTID /*PVEC* $
20   COND      LBSEND,DRY $
21   EQUIV     PG,PL/NOSET $                                         + R.F. 1,
22   COND      LBL10,NOSET $                                         | 2, or 3
23   SSG2      USET,GM,YS,KFS,GO,,PG/QR,PO,PS,PL  $                  | & P or
24   CHKPNT    PO,PS,PL $                                            + PA only)
25   LABEL     LBL10 R
26   SOFO      ,KAA,MAA,PL,BAA,K4AA//S,N,DRY/*NAME*/*KMTX*/*MMTX*/PVEC*/
27             *BMTX*/*K4MX* $
28   LODAPP    PL,//*NAME   */S,N,DRY $    (R.F. 1, 2, 3, or 9 and PA only)
29   EQUIV     CASESS,CASECC/ALWAYS $

                                    PHASE 2

 1   ALTER     2,0
 2   PARAM     //*ADD*/DRY/I/0 $
 3   LABEL     LBSBEG $

                                    PHASE 3

 1   ALTER     (Remove DECOMP or before dynamic solution)
 2   PARAM     //*ADD*/DRY/I/0 $
 3   LABEL     LBSBEG $

Variables
---------
I                       Integer RUN option code (see RUN command).
NAME                    Phase 1 substructure name.
PLOTID                  Phase 1 Plot Set ID.
KAA, MAA, PL, BAA, K4AA Data blocks dependent on OPTION.
PVEC                    PVEC for option P, PAPP for option PA.


5.10  SUPPLEMENTARY FUNCTIONAL MODULES
======================================
   Module  Basic Function                                          Page

   EMA1    Alternative Element Matrix Generator                  5.10-2

   GPSPC   Automatically constrain potential stiffness
           matrix singularities                                  5.10-3

   These modules are fully described in Section 4 of the Programmer's Manual.
However, since they are not incorporated in any of the Rigid Formats, they are
included here for reference purposes. These modules must be ALTERed into Rigid
Formats.

EMA1 - Element Matrix Assembler
===============================
Purpose
-------
This module superimposes matrices corresponding to elements into a structural
matrix corresponding to all degrees of freedom at all grid points.

DMAP Calling Sequence
---------------------
              �       �   �      �            �      �
EMA1   GPECT, � KDICT � , � KELM � , SIL,ECT/ � KGGX � ,
              � MDICT �   � MELM �            � MGG  �
              �       �   �      �            �      �

       GPST/C,N,NOK4/C,N,WTMASS   $

Input Data Blocks
-----------------
GPECT      Grid Point Element Connection Table.
KDICT, MDICT  Element Matrix Dictionaries.
KELM, MELM Element Matrix Partitions.
SIL        Scalar Index List.
ECT        Element Connection Table.

Output Data Blocks
------------------
KGGX       Assembled Structural Matrix.
MGG        Assembled Mass Matrix.
GPST       Grid Point Singularity Table.

NOTE: GPST may be purged.

Parameters
----------
NOK4       Input-Integer, default = -1. Flag which specifies whether damping
           factor is to be used in assembling matrix (-1 ignores factor).

WTMASS     Input-Real, default = 1.0. Constant by which all element matrix
           terms are multiplied.

Example
-------
To replace the current module EMA with module EMA1 in DISP Static Analysis
(DISP Rigid Format 1), the following ALTERs must be made:

ALTER n1,n1 $ STRUCTURAL MATRIX (where n1 = DMAP statement number of the EMA
                                 module corresponding to the stiffness matrix)
EMA1    GPECT,KDICT,KELM,SIL,ECT/KGGX,GPST $
ALTER  n2,n2 $ MASS MATRIX (where n2 = DMAP statement number of the EMA module
                            corresponding to the mass matrix)
EMA1    GPECT,MDICT,MELM,SIL,ECT/MGG,/-1/C,Y,WTMASS=1.0 $
ENDALTER $

GPSPC - Constrain Stiffness Matrix Singularities
================================================
Purpose
-------
The GPST data block contains data on potential stiffness matrix singularities.
These singularities may have been removed through the application of single or
multipoint constraints. The GPSPC module checks each singularity against the
list of constraints, and if the singularity is not thereby removed, writes a
warning for you and on your option automatically constrains the singularity.
This module will not be used if GENELs are present.

DMAP Calling Sequence
---------------------
GPSPC  GPL,GPST,USET,SIL / OGPST,USETC / V,N,NOGPST / V,Y,SINCON / V,N,SINGLE /
       V,N,OMIT / V,N,REACT / V,N,NOSET / V,N,NOL / V,N,NOA $

Input Data Blocks
-----------------
GPL        Grid Point List.
GPST       Grid Point Singularity Table.
USET       Displacement Set Definitions Table.
SIL        Scalar Index List.

NOTE: No input data block can be purged.

Output Data Blocks
------------------
OGPST      Tabular list of grid point singularities not removed by you. This
           data block will be processed by the OFP (Output File Processor)
           module.
USETC      Displacement Set Definition Table with singularities constrained.

Parameters
----------
NOGPST     Output-Integer, default = 1. If positive, OGPST was created.

SINCON     Input and Output-Integer, default = -1. If SINCON is negative on
           input, remaining singularities are automatically constrained. On
           output, same negative value if singularities existed, zero
           otherwise.

SINGLE     Input and Output-Integer, no default. See description of GP4
           parameters of the same name in Programmer's Manual Section 4.31.
           Values are corrected only if singularities were constrained.  

OMIT       Input and Output-Integer, no default. See description of GP4
           parameters of the same name in Programmer's Manual Section 4.31.
           Values are corrected only if singularities were constrained.  

REACT      Input and Output-Integer, no default. See description of GP4
           parameters of the same name in Programmer's Manual Section 4.31.
           Values are corrected only if singularities were constrained.  

NOSET      Input and Output-Integer, no default. See description of GP4
           parameters of the same name in Programmer's Manual Section 4.31.
           Values are corrected only if singularities were constrained.  

NOL        Input and Output-Integer, no default. See description of GP4
           parameters of the same name in Programmer's Manual Section 4.31.
           Values are corrected only if singularities were constrained.  

NOA        Input and Output-Integer, no default. See description of GP4
           parameters of the same name in Programmer's Manual Section 4.31.
           Values are corrected only if singularities were constrained.  
Examples
--------
1. To use the GPSPC module instead of the standard GPSP module in a static
   analysis (DISP Rigid Format 1), module GPSP is replaced by module GPSPC and
   the USET data block is replaced by the USETC data block. In this case, the
   following ALTERs are required:

   ALTER    n1,n2 $ (where n1 and n2 are the DMAP statement numbers of the PARAM
            and PURGE statements following the GP4 module)
   ALTER    n3,n3 $ (where n3 = DMAP statement number of the GPSP module)
   GPSPC    GPL,GPST,USET,SIL/OGPST,USETC/S,N,NOGPST/S,Y,SINCON=-1/
            S,N,SINGLE/S,N,OMIT/S,N,REACT/S,N,NOSET/S,N,NOL/S,N,NOA $
   EQUIV    USETC,USET/SINCON $
   ALTER    n4 $ (where n4 = DMAP statement number of the OFP module immediately
            following the GPSP module)
   PARAM    //*ADD*/SING/V,Y,SINCON/1 $
   COND     ERROR3,NOL $
   COND     ERROR,SING $
   ALTER    n5 $ (where n5 = DMAP statement number of LABEL LBL4)
   PARAM    //*AND*/NOSR/SINGLE/REACT $
   PURGE    KRR,KLR,QR,DM/REACT /GM/MPCF1 /GO,KOO,LOO,PO,UOOV,RUOV/OMIT
            PS,KFS,KSS/SINGLE /QG/NOSR $
   LABEL    ERROR $
   PRTPARM  //0/*SINCON* $
   ENDALTER $

   The input parameter SINCON can be changed from the initial value
   illustrated for the general case, either by using the form C,N,i or by
   using a PARAM bulk data card with a different value. When SINCON = -1, the
   strongest combination of possible singularities is automatically
   constrained and noted in the GPST output.

2. To use the GPSPC module instead of the standard GPSP module in a real
   eigenvalue analysis (DISP Rigid Format 3), module GPSP is replaced by
   module GPSPC and the USET data block is replaced by the USETC data block.
   In this case, the following ALTERs are required:

   ALTER    n1,n1 $ (where n1 = DMAP statement number of the PURGE module
            following the GP4 module)
   ALTER    n2,n2 $ (where n2 = DMAP statement number of the GPSP module)
   GPSPC    GPL,GPST,USET,SIL/OGPST,USETC/S,N,NOGPST/S,Y,SINCON=-1/
            S,N,SINGLE/S,N,OMIT/S,N,REACT/S,N,NOSET/S,N,NOL/S,N,NOA $
   COND     ERROR3,NOL $
   EQUIV    USETC,USET/SINCON $
   ALTER    n3 $ (where n3 = DMAP statement number of LABEL LBL4)
   PARAM    //*ADD*/SING/V,Y,SINCON/1 $
   COND     ERROR,SING $
   PURGE    KRR,KLR,DM,MLR,MR/REACT /GM/MPCF1 /GO/OMIT /KFS/SINGLE /
            QG/NOSET $
   LABEL    ERROR $
   PRTPARM  //0/*SINCON* $
   ENDALTER $

   The input parameter SINCON can be changed from the initial value
   illustrated for the general case, either by using the form C,N,i or by
   using a PARAM bulk data card with a different value. When SINCON = -1, the
   strongest combination of possible singularities is automatically
   constrained and noted in the GPST output.
