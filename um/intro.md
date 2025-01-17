
   The User's Manual is one of four manuals that constitute the documentation
for NASTRAN, the other three being the Theoretical Manual, the Programmer's
Manual, and the Demonstration Problem Manual. Although the User's Manual
contains all of the information that is directly associated with the solution
of problems with NASTRAN, you will find it desirable to refer to the other
manuals for assistance in the solution of specific  problems.

   The Theoretical Manual gives an excellent introduction to NASTRAN and
presents developments of the analytical and numerical procedures that underlie
the program. The User's Manual is instructive and encyclopedic in nature, but
is restricted to those items related to the use of NASTRAN that are generally
independent of the computing system being used. Computer-dependent topics and
information that is required for the maintenance and modification of the
program are treated in the Programmer's Manual. The Programmer's Manual also
provides a complete description of the program, including the mathematical
equations implemented in the code. The Demonstration Problem Manual presents a
discussion of the sample problems delivered with NASTRAN, thereby illustrating
the formulation of the different types of problems that can be solved with
NASTRAN. 

   In addition to the four manuals described above, there is also a NASTRAN
User's Guide that serves as a handbook for users. It describes all of the
NASTRAN features and options and illustrates them by examples. Other excellent
sources for NASTRAN-related topics are the proceedings of the NASTRAN Users'
Colloquia (held normally every year) which provide a large body of information
based on user experiences with NASTRAN. 

   The User's Manual has recently been completely revised and updated. The
material on rigid formats that was in Volume II has moved to the rigid format
source files as comments or, in the case of general information, back into
this single volume User's Manual as Section 3.

   NASTRAN uses the finite element approach to structural modeling, wherein
the distributed physical properties of a structure are represented by a finite
number of structural elements which are interconnected at a finite number of
grid points, to which loads are applied and for which displacements are
calculated. The procedures for defining and loading a structural model are
described in Section 1. This section contains a functional reference for every
card that is used for structural modeling. 

   The NASTRAN Data Deck, including the details for each of the data cards, is
described in Section 2. This section also discusses the NASTRAN control cards
that are associated with the use of the program. 

   Section 3 contains a general description of rigid format procedures.
Specific instructions and information for the use of each rigid format are
given in comments included in each source file.

   The procedures for using the NASTRAN plotting capability are described in
Section 4. Both deformed and undeformed plots of the structural model are
available. Response curves are also available for static, transient response,
frequency response, modal flutter,and modal aeroelastic response analyses. 

   NASTRAN contains problem solution sequences, called rigid formats. Each of
these rigid formats is associated with the solution of problems for a
particular type of static or dynamic analysis. In addition to the rigid format
procedures, you may choose to write your own Direct Matrix Abstraction Program
(DMAP). This procedure permits you to execute a series of matrix operations of
his choice along with any utility modules or executive operations that he may
need. The rules governing the creation of DMAP programs are described in
Section 5. 

   The NASTRAN diagnostic messages are documented and explained in Section 6.
The NASTRAN Dictionary, in Section 7, contains descriptions of mnemonics,
acronyms, phrases, and other commonly used NASTRAN terms. 

   There is a limited number of sample problems included in the User's Manual.
However, a more comprehensive set of demonstration problems, at least one for
each of the rigid formats, is described in the NASTRAN Demonstration Problem
Manual. The data decks are available on tape for each of the computer systems
on which NASTRAN has been implemented. Samples of the printer output and of
structure plots and response plots can be obtained by executing these
demonstration problems. The printer output for these problems is also
available on microfiche. 

1. STRUCTURAL MODELING

1.1 INTRODUCTION

1.2 GRID POINTS

   1.2.1 Grid Point Definition

   1.2.2 Grid Point Sequencing

       1.2.2.1 Manual Grid Point Resequencing

       1.2.2.2 Automatic Grid Point Resequencing Using the BANDIT Procedure

           1.2.2.2.1 BANDIT Options

           1.2.2.2.2 Cases for Which BANDIT Computations are Skipped

           1.2.2.2.3 BANDIT in Restarts

   1.2.3 Grid Point Properties

1.3 STRUCTURAL ELEMENTS

   1.3.1 Element Definition

   1.3.2 Beam Elements

       1.3.2.1 Simple Beam or Bar Element

       1.3.2.2 Curved Beam or Elbow Element

   1.3.3 Rod Element

   1.3.4 Shear Panels and Twist Panels

   1.3.5 Plate and Membrane Elements

   1.3.6 Axisymmetric Shell Elements

       1.3.6.1 Conical Shell (CONEAX) Element

       1.3.6.2 Toroidal Ring (TORDRG) Element

   1.3.7 Axisymmetric Solid Elements

       1.3.7.1 TRIARG and TRAPRG Elements

       1.3.7.2 TRIAAX and TRAPAX Elements

       1.3.7.3 Data Processing for the CONEAX, TRAPAX, and TRIAAX
               Axisymmetric Elements

   1.3.8 Scalar Elements

   1.3.9 Mass

       1.3.9.1 Lumped Mass

       1.3.9.2 Coupled Mass

       1.3.9.3 Mass Input

       1.3.9.4 Output from the Grid Point Weight Generator

       1.3.9.5 Bulk Data Cards for Mass

   1.3.10 Solid Polyhedron Elements

   1.3.11 Isoparametric Solid Hexahedron Elements

   1.3.12 Shallow Shell Element

1.4 CONSTRAINTS AND PARTITIONING

   1.4.1 Single-Point Constraints

   1.4.2 Multipoint Constraints and Rigid Elements

       1.4.2.1 Multipoint Constraints

       1.4.2.2 Rigid Elements

   1.4.3 Free Body Supports

   1.4.4 Partitioning

   1.4.5 The Nested Vector Set Concept Used to Represent Components of
         Displacement

1.5 APPLIED LOADS

   1.5.1 Static Loads

   1.5.2 Frequency-Dependent Loads

   1.5.3 Time-Dependent Loads

1.6 DYNAMIC MATRICES

   1.6.1 Direct Formulation

   1.6.2 Modal Formulation

1.7 HYDROELASTIC MODELING

   1.7.1 Axisymmetric Hydroelastic Modeling

       1.7.1.1 Solution of the NASTRAN Fluid Model

       1.7.1.2 Hydroelastic Input Data

       1.7.1.3 Rigid Formats

       1.7.1.4 Hydroelastic Data Processing

   1.7.2 Three-Dimensional Hydroelastic Modeling

       1.7.2.1 Solution Approach

       1.7.2.2 Executive Control Deck

       1.7.2.3 Case Control Deck

       1.7.2.4 Bulk Data Deck

1.8 HEAT TRANSFER PROBLEMS

   1.8.1 Introduction to NASTRAN Heat Transfer

   1.8.2 Heat Transfer Elements

   1.8.3 Constraints and Partitioning

   1.8.4 Thermal Loads

   1.8.5 Linear Static Analysis

   1.8.6 Nonlinear Static Analysis

   1.8.7 Transient Analysis

   1.8.8 Compatibility with Structural Analysis

1.9 ACOUSTIC CAVITY MODELING

   1.9.1 Data Card Functions

   1.9.2 Assumptions and Limitations

1.10 SUBSTRUCTURING

   1.10.1 Manual Single-Stage Substructuring

       1.10.1.1 Basic Manual Substructure Analysis

       1.10.1.2 Loads and Boundary Conditions

       1.10.1.3 Normal Modes Analysis

       1.10.1.4 Dynamic Analysis

       1.10.1.5 DMAP Loops for Phase 2

       1.10.1.6 Identical Substructures

   1.10.2 Automated Multi-Stage Substructuring

       1.10.2.1 Basic Concepts

       1.10.2.2 Substructure Operations and Control Functions

       1.10.2.3 Input Data Checking and Interpretation of Output

       1.10.2.4 Substructure Operating File (SOF)

       1.10.2.5 The Case Control Deck for Automated Substructure Analyses

       1.10.2.6 User Aids for Automated Substructure Analyses

1.11 AEROELASTIC MODELING

   1.11.1 Introduction

   1.11.2 Aerodynamic Modeling

       1.11.2.1 Doublet-Lattice Panels

       1.11.2.2 Slender and Interference Bodies

       1.11.2.3 Mach Box Theory

       1.11.2.4 Strip Theory

       1.11.2.5 Piston Theory

   1.11.3 The Interconnection Between Structure and Aerodynamic Models

   1.11.4 Modal Flutter Analysis

   1.11.5 Modal Aeroelastic Response Analysis

1.12 CYCLIC SYMMETRY

1.13 FULLY STRESSED DESIGN

1.14 THE CONGRUENT FEATURE

   1.14.1 Introduction

   1.14.2 Congruent Feature Usage

   1.14.3 Factors Affecting Congruent Feature Efficiency

   1.14.4 Examples of Congruent Feature Usage

1.15 MAGNETIC FIELD PROBLEMS

   1.15.1 Introduction

   1.15.2 Theory

   1.15.3 Prolate Spheroidal Harmonic Expansion

   1.15.4 Input Data for Magnetostatic Analysis

       1.15.4.1 NASTRAN Card

       1.15.4.2 Executive Control Deck

       1.15.4.3 Case Control Deck

       1.15.4.4 Bulk Data Deck

       1.15.4.5 Data Cards with Different Meanings

       1.15.4.6 Output

1.16 DYNAMIC DESIGN-ANALYSIS

   1.16.1 Introduction

   1.16.2 Theory

   1.16.3 DDAM Implementation in NASTRAN

       1.16.3.1 GENCOS

       1.16.3.2 DDAMAT

       1.16.3.3 GENPART

       1.16.3.4 DESVEL

       1.16.3.5 DDAMPG

       1.16.3.6 CASEGEN

       1.16.3.7 NRLSUM

       1.16.3.8 COMBUGV

   1.16.4 Input Data for DDAM

       1.16.4.1 Executive Control Deck

       1.16.4.2 Case Control Deck

       1.16.4.3 Bulk Data Deck

1.17 PIEZOELECTRIC MODELING

   1.17.1 Introduction

   1.17.2 Theory

   1.17.3 Input Data for Piezoelectric Modeling

       1.17.3.1 NASTRAN Card

       1.17.3.2 Bulk Data Deck

   1.17.4 Notes on Piezoelectric Modeling

1.18 FORCED VIBRATION ANALYSIS OF ROTATING CYCLIC STRUCTURES AND TURBOSYSTEMS

   1.18.1 Introduction

   1.18.2 Problem Formulation

   1.18.3 Coordinate Systems

   1.18.4 Structural Modeling of Rotating Cyclic Structures and Turbosystems

   1.18.5 Direct Forced Vibration Analysis of Rotating Cyclic Structures

       1.18.5.1 Modeling Features

       1.18.5.2 Executive Control Deck

       1.18.5.3 Case Control Deck

           1.18.5.3.1 Subcase Definitions

           1.18.5.3.2 Other Data Selection Items

       1.18.5.4 Bulk Data Deck

           1.18.5.4.1 Bulk Data Parameters

           1.18.5.4.2 Usage of Certain Bulk Data Cards

   1.18.6 Modal Forced Vibration Analysis of Aerodynamically Excited
          Turbosystems

       1.18.6.1 Modeling Features

       1.18.6.2 Executive Control Deck

       1.18.6.3 Case Control Deck

           1.18.6.3.1 Subcase Definitions

           1.18.6.3.2 Other Data Selection Items

       1.18.6.4 Bulk Data Deck

           1.18.6.4.1 Bulk Data Parameters

           1.18.6.4.2 Usage of Certain Bulk Data Cards

1.19 STATIC AEROTHERMOELASTIC DESIGN/ANALYSIS OF AXIAL-FLOW COMPRESSORS

   1.19.1 Introduction

   1.19.2 Description of the Capability

       1.19.2.1 Problem Definition

       1.19.2.2 Problem Formulation

       1.19.2.3 NASTRAN Implementation

   1.19.3 Aerodynamic Modeling

   1.19.4 Aerodynamic Input Data

       1.19.4.1 Aerodynamic DTI Data Setup

           1.19.4.1.1 Initial Directives

           1.19.4.1.2 Analytic Meanline Blade Section

           1.19.4.1.3 Aerodynamic Section

       1.19.4.2 Aerodynamic DTI Data Item Definitions

           1.19.4.2.1 Initial Directives

           1.19.4.2.2 Analytic Meanline Blade Section

           1.19.4.2.3 Aerodynamic Section

   1.19.5 Aerodynamic Output Data

       1.19.5.1 Analytic Meanline Blade Section

       1.19.5.2 Aerodynamic Section

           1.19.5.2.1 Normal Output

           1.19.5.2.2 Diagnostic Output

           1.19.5.2.3 Aerodynamic Load and Temperature Output

1.20 MODAL FLUTTER ANALYSIS OF AXIAL-FLOW TURBOMACHINES AND ADVANCED
     TURBOPROPELLERS

   1.20.1 Introduction

   1.20.2 Problem Formulation

   1.20.3 NASTRAN Implementation

   1.20.4 Usage of the Capability

2. NASTRAN DATA DECK

2.0 GENERAL DESCRIPTION OF DATA DECK

   2.0.1 NASTRAN Data Deck

   2.0.2 Usage of Secondary Input Files via the READFILE Capability

       2.0.2.1 Description of the Capability

       2.0.2.2 Examples of READFILE Capability Usage

2.1 THE NASTRAN CARD

2.2 EXECUTIVE CONTROL DECK

   2.2.1 Control Selection

   2.2.2 Executive Control Deck Examples

   2.2.3 Executive Control Card Descriptions

2.3 CASE CONTROL DECK

   2.3.1 Data Selection

   2.3.2 Output Selection

   2.3.3 Subcase Definition

   2.3.4 Case Control Card Descriptions

2.4 BULK DATA DECK

   2.4.1 Format of Bulk Data Cards

       2.4.1.1 Fixed-Field Input

       2.4.1.2 Free-Field Input

           2.4.1.2.1 Free-Field Input Examples

   2.4.2 Bulk Data Card Descriptions

2.5 USER'S MASTER FILE

   2.5.1 Use of User's Master File

   2.5.2 Using the User's Master File Editor

   2.5.3 Rules for the User's Master File Editor

   2.5.4 Examples of User's Master File Editor Usage

2.6 USER GENERATED INPUT

   2.6.1 Utility Module INPUT Usage

       2.6.1.1 Laplace Circuit

       2.6.1.2 Rectangular Frame Made from BARs or RODs

       2.6.1.3 Rectangular Plate Made from QUAD1s

       2.6.1.4 Rectangular Plate Made from TRIA1s

       2.6.1.5 N-Segment String

       2.6.1.6 N-Cell Bar

       2.6.1.7 Full Matrix with Optional Unit Load

       2.6.1.8 N-Spoked Wheel Made from BAR Elements

2.7 SUBSTRUCTURE CONTROL DECK

   2.7.1 Commands and Their Execution

   2.7.2 Interface with NASTRAN DMAP

   2.7.3 Substructure Control Card Descriptions

3. RIGID FORMATS

3.1 GENERAL DESCRIPTION OF RIGID FORMATS

   3.1.1 Input File Processor

   3.1.2 Functional Modules and Supporting DMAP Operations

   3.1.3 Checkpoint/Restart Procedures

   3.1.4 Types of Restarts

       3.1.4.1 Unmodified Restart

       3.1.4.2 Modified Restart

       3.1.4.3 Modified Restart with Rigid Format Switch

   3.1.5 Use of DMAP ALTERs in Restarts

   3.1.6 Rigid Format Output

   3.1.7 Rigid Format Data Base

       3.1.7.1 Design of the Data Base

       3.1.7.2 Implementation of the Data Base

       3.1.7.3 Usage of the Data Base

       3.1.7.4 Development of User Rigid Formats

       3.1.7.5 Usage of User-Developed Rigid Formats

4. PLOTTING

4.1 PLOTTING IN NASTRAN

   4.1.1 Plot Frame Size and Character Size

4.2 STRUCTURE PLOTTING

   4.2.1 Structure Plotter Projections and Coordinate System

       4.2.1.1 Orthographic Projection

       4.2.1.2 Perspective Projection

       4.2.1.3 Stereoscopic Projection

   4.2.2 Structure Plot Request Packet Data

       4.2.2.1 Summary of Data Cards

       4.2.2.2 Plot Titles

       4.2.2.3 Data Card Specification Rules and Format

       4.2.2.4 Data Card Descriptions

   4.2.3 Error Messages

4.3 X-Y OUTPUT

   4.3.1 X-Y Plotter Terminology

   4.3.2 X-Y Output Request Packet Data

       4.3.2.1 Summary of Data Cards

       4.3.2.2 Tic Marks in Plots

       4.3.2.3 Plot Titles

       4.3.2.4 Data Card Specification Rules and Format

       4.3.2.5 Data Card Descriptions

4.4 NASTRAN GENERAL PURPOSE PLOTTER (NASTPLT) FILE

   4.4.1 Description of the NASTPLT File

   4.4.2 Description of the Plot Commands on the NASTPLT File

5. DIRECT MATRIX ABSTRACTION

5.1 INTRODUCTION

5.2 DMAP RULES

   5.2.1 DMAP Rules for Functional Module Instructions

       5.2.1.1 Functional Module DMAP Statements

       5.2.1.2 Functional Module Names

       5.2.1.3 Functional Module Input Data Blocks

       5.2.1.4 Functional Module Output Data Blocks

       5.2.1.5 Functional Module Parameters

       5.2.1.6 DMAP Compiler Options - The XDMAP Instruction

       5.2.1.7 Extended Error Handling Facility

   5.2.2 DMAP Rules for Executive Operation Instructions

   5.2.3 Techniques and Examples of Executive Module Usage

       5.2.3.1 The REPT and FILE Instructions

       5.2.3.2 The EQUIV Instruction

       5.2.3.3 The PURGE Instruction

       5.2.3.4 The CHKPNT Instruction

5.3 INDEX OF DMAP MODULE DESCRIPTIONS

5.4 DMAP MATRIX OPERATION MODULES

5.5 DMAP UTILITY MODULES

5.6 DMAP USER MODULES

5.7 DMAP EXECUTIVE OPERATION MODULES

5.8 DMAP EXAMPLES

   5.8.1 DMAP to Print Table and Matrix Data Blocks and Parameters

   5.8.2 DMAP to Perform Matrix Operations

   5.8.3 DMAP to Use the Structure Plotter to Generate Undeformed Plots of the
         Structural Model

   5.8.4 DMAP to Print Eigenvectors Associated with any of the Modal
         Formulation Rigid Formats

   5.8.5 DMAP Using a User-Written Module

   5.8.6 DMAP ALTER Package for Using a User-Written Auxiliary Input File
         Processor

   5.8.7 DMAP to Perform Real Eigenvalue Analysis Using Direct Input Matrices

   5.8.8 DMAP to Print and Plot a Topological Picture of Two Matrices

   5.8.9 DMAP to Compute the r-th Power of a Matrix [Q]

   5.8.10 Usage of UPARTN, VEC, and PARTN

   5.8.11 DMAP to Perform Matrix Operations Using Conditional Logic

5.9 AUTOMATIC SUBSTRUCTURE DMAP ALTERS

   5.9.1 Index of Substructure DMAP ALTERs

5.10 SUPPLEMENTARY FUNCTIONAL MODULES

6. DIAGNOSTIC MESSAGES

6.1 NASTRAN MESSAGES

6.2 PREFACE MESSAGES

6.3 EXECUTIVE MODULE MESSAGES

6.4 FUNCTIONAL MODULE MESSAGES (2001 THROUGH 3000)

6.5 FUNCTIONAL MODULE MESSAGES (3001 THROUGH 4000)

6.6 FUNCTIONAL MODULE MESSAGES (4001 THROUGH 5000)

6.7 FUNCTIONAL MODULE MESSAGES (5001 THROUGH 6000)

6.8 FUNCTIONAL MODULE MESSAGES (6001 THROUGH 7000)

6.9 FUNCTIONAL MODULE MESSAGES (7001 THROUGH 8000)

6.10 FUNCTIONAL MODULE MESSAGES (8001 THROUGH 9000)

7. NASTRAN DICTIONARY

7.1 NASTRAN DICTIONARY


1.1  INTRODUCTION
=================
   NASTRAN embodies a lumped element approach, wherein the distributed 
physical properties of a structure are represented by a model consisting of a 
finite number of idealized substructures or elements that are interconnected 
at a finite number of grid points, to which loads are applied. All input and 
output data pertain to the idealized structural model. The major components in 
the definition and loading of a structural model are indicated in Figure 1.1-
1. 

   As indicated in Figure 1.1-1, the grid point definition forms the basic 
framework for the structural model. All other parts of the structural model 
are referenced either directly or indirectly to the grid points. 

   Two general types of grid points are used in defining the structural model. 
They are: 

   1. Geometric grid point - a point in three-dimensional space at which three 
      components of translation and three components of rotation are defined. 
      The coordinates of each grid point are specified by you. 

   2. Scalar point - a point in vector space at which one degree of freedom is 
      defined. Scalar points can be coupled to geometric grid points by means 
      of scalar elements and by constraint relationships. 

   The structural element is a convenient means for specifying many of the 
properties of the structure, including material properties, mass distribution, 
and some types of applied loads. In static analysis by the displacement 
method, stiffness properties are input exclusively by means of structural 
elements. Mass properties (used in the generation of gravity and inertia 
loads) are input either as properties of structural elements or as properties 
of grid points. In dynamic analysis, mass, damping, and stiffness properties 
may be input either as the properties of structural elements or as the 
properties of grid points (direct input matrices). 

   Structural elements are defined on connection cards by referencing grid 
points, as indicated on Figure 1.1-1. In a few cases, all of the information 
required to generate the structural matrices for the element is given on the 
connection card. In most cases the connection card refers to a property card, 
on which the cross-sectional properties of the element are given. The property 
card in turn refers to a material card which gives the material properties. If 
some of the material properties are stress dependent or temperature dependent, 
a further reference is made to tables for this information. 

   Various kinds of constraints can be applied to the grid points. Single-
point constraints are used to specify boundary conditions, including enforced 
displacements of grid points. Multipoint constraints and rigid elements are 
used to specify linear relationships among selected degrees of freedom. 
Omitted points are used as a tool in matrix partitioning and for reducing the 
number of degrees of freedom used in dynamic analysis. Free-body supports are 
used to remove stress-free motions in static analysis and to evaluate the 
free-body inertia properties of the structural model. 

   Static loads may be applied to the structural model by concentrated loads 
at grid points, pressure loads on surfaces, or indirectly, by means of the 
mass and thermal expansion properties of structural elements or enforced 
deformations of one-dimensional structural elements. Due to the great variety 
of possible sources for dynamic loading, only general forms of loads are 
provided for use in dynamic analysis. 

   The following sections describe the general procedures for defining 
structural models. Detailed instructions for each of the bulk data cards and 
case control cards are given in Section 2. Additional information on the case 
control cards and use of parameters is given for each rigid format in Section 
3. 


+--------------------+         +-----------------+         +-------------------+
|       SEQGP        |         |      CORDi      |         |                   |
|    Grid Point      |         |   Coordinate    |         |     Grid Point    |
|     Sequence       +----+    |     System      |    +----+     Properties    |
|                    |    |    |   Definition    |    |    |                   |
+--------------------+    |    +-------+---------+    |    +-------------------+
                          |            |              |
+--------------------+    |    +-------+---------+    |    +-------------------+
|    CONSTRAINTS     |    +----+      GRID       +----+    |       Cxxx        |
|    Single Point    +---------+   Grid Point    +---------+      Element      |
|     Multipoint     |    +----+   Definition    |         |     Definition    |
|   Rigid Elements   |    |    |                 |         |                   |
|   Omitted Points   |    |    +-------+---------+         +---------+---------+
|     Free Body      |    |            |                             |
|     Supports       |    |            |                             |
+--------------------+    |            |                             |
                          |            |                             |
+--------------------+    |    +-------+---------+         +---------+---------+
|      DPHASE        |    |    |  STATIC LOADS   |         |      Pxxx         |
|      DELAY         |    |    |  Concentrated   |         |     Property      |
|      DAREA         +----+    |    Pressure     |         |    Definition     |
|                    |         |     Gravity     |         +---------+---------+
+---------+----------+         |   Centrifugal   |                   |
          |                    |     Thermal     |                   |
          |                    |   Deformation   |                   |
          |                    |  Displacement   |                   |
          |                    +-----------------+                   |
+---------+----------+                                     +---------+---------+
|    DYNAMIC LOADS   |                                     |      MATxx        |
|    Time Dependent  |                                     |     Material      |
|      Frequency     |                                     |    Definition     |
|      Dependent     |                                     +---------+---------+
+---------+----------+                                               |
          |                                                          |
+---------+----------+                                     +---------+---------+
|                    |                                     |     TABLEMi       |
|     TABLEDi        |                                     |     TABLES1       |
|                    |                                     |                   |
+--------------------+                                     +-------------------+



                        Figure 1.1-1. Structural model


1.2  GRID POINTS
================
1.2.1  Grid Point Definition
----------------------------
   Geometric grid points are defined on GRID bulk data cards by specifying
their coordinates in either the basic or a local coordinate system. The
implicitly defined basic coordinate system is rectangular, except when using
axisymmetric elements. Local coordinate systems may be rectangular,
cylindrical, or spherical. Each local system must be related directly or
indirectly to the basic coordinate system. The CORD1C, CORD1R, and CORD1S
cards are used to define cylindrical, rectangular, and spherical local
coordinate systems, respectively, in terms of three geometric grid points
which have been previously defined. The CORD2C, CORD2R, and CORD2S cards are
used to define cylindrical, rectangular, and spherical local coordinate
systems, respectively, in terms of the coordinates of three points in a
previously defined coordinate system.

   Six rectangular displacement components (3 translations and 3 rotations)
are defined at each grid point. The local coordinate system used to define the
directions of motion may be different from the local coordinate system used to
locate the grid point. Both the location coordinate system and the
displacement coordinate system are specified on the GRID card for each
geometric grid point. The orientation of displacement components depends on
the type of local coordinate system used to define the displacement
components. If the defining local system is rectangular, the displacement
system is parallel to the local system and is independent of the grid point
location as indicated in Figure 1.2-1a. If the local system is cylindrical,
the displacement components are in the radial, tangential, and axial
directions as indicated in Figure 1.2-1b. If the local system is spherical,
the displacement components are in the radial, meridional, and azimuthal
directions as indicated in Figure 1.2-1c. Each geometric grid point may have a
unique displacement coordinate system associated with it. The collection of
all displacement coordinate systems is known as the global coordinate system.
All matrices are formed and all displacements are output in the global
coordinate system. The symbols T1, T2, and T3 on the printed output indicate
translations in the 1, 2, and 3-directions, respectively, for each grid point.
The symbols R1, R2, and R3 indicate rotations (in radians) about the three
axes.

   Provision is also made on the GRID card to apply single-point constraints
to any of the displacement components. Any constraints specified on the GRID
card will be automatically used for all solutions. Constraints specified on
the GRID card are usually restricted to those degrees of freedom that will not
be elastically constrained and hence must be removed from the model in order
to avoid singularities in the stiffness matrix.

   The GRDSET card is provided to avoid the necessity of repeating the
specification of location coordinate systems, displacement coordinate systems,
and single-point constraints, when all, or many, of the GRID cards have the
same entries for these items. When any of the three items are specified on the
GRDSET card, the entries are used to replace blank fields on the GRID card for
these items. This feature is useful in the case of such problems as space
trusses where one wishes to remove all of the rotational degrees of freedom or
in the case of plane structures where one wishes to remove all of the
out-of-plane or all of the in-plane motions.

   Scalar points are defined either on an SPOINT card or by reference on a
connection card for a scalar element. SPOINT cards are used primarily to
define scalar points appearing in constraint equations, but to which no
structural elements are connected. A scalar point is implicitly defined if it
is used as a connection point for any scalar element. Special scalar points,
called "extra points", may be introduced for dynamic analyses. Extra points
are used in connection with transfer functions and other forms of direct
matrix input used in dynamic analyses and are defined on EPOINT cards.

   GRIDB is a variation of the GRID card that is used to define a point on a
fluid-structure interface (see Section 1.7).

1.2.2  Grid Point Sequencing
----------------------------
   The external identification numbers used for grid points may be selected in
any manner you desire. However, in order to reduce the number of active
columns, and, hence, to substantially reduce computing times when using the
displacement method, the internal sequencing of the grid points must not be
arbitrary. The best decomposition and equation solution times are obtained if
the grid points are sequenced in such a manner as to create matrices having
small numbers of active columns (see Section 2.2 of the Theoretical Manual for
a discussion of active columns and the decomposition algorithm). The
decomposition time is proportional to the sum of the squares of the number of
active columns in each row of the triangular factor. The equation solution
time (forward/backward substitution) is proportional to the number of nonzero
terms in the triangular factor.

1.2.2.1  Manual Grid Point Resequencing
---------------------------------------
   In order to allow arbitrary grid point numbers and still preserve sparsity
in the triangular decomposition factor to the greatest extent possible,
provision is made for you to resequence the grid point numbers for internal
operations. This feature also makes it possible to easily change the sequence
if a poor initial choice is made. All output associated with grid points is
identified with the external grid point numbers. The SEQGP card is used to
resequence geometric grid points and scalar points. The SEQEP card is used to
sequence the extra points in with the previously sequenced grid points and
scalar points.

   In selecting the grid point sequencing, it is not important to find the
best sequence; rather it is usually quite satisfactory to find a good
sequence, and to avoid bad sequences that create unreasonably large numbers of
active columns. For many problems a sequence which will result in a band
matrix is a reasonably good choice, but not necessarily the best. Also,
sequences which result in small numbers of columns with nonzero terms are
usually good but not necessarily the best. A sequence with a larger number of
nonzero columns will frequently have a smaller number of nonzero operations in
the decomposition when significant passive regions exist within the active
columns (see Section 2.2 of the Theoretical Manual).

   Examples of proper grid point sequencing for one-dimensional systems are
shown in Figure 1.2-2. For open loops, a consecutive numbering system should
be used as shown in Figure 1.2-2a. This sequencing will result in a narrow
band matrix with no new nonzero terms created during the triangular
decomposition. Generally, there is an improvement in the accumulated round off
error if the grid points are sequenced from the flexible end to the stiff end.

   For closed loops, the grid points may be sequenced either as shown in
Figure 1.2-2b or as shown in Figure 1.2-2c. If the sequencing is as shown in
Figure 1.2-2b, the semiband will be twice that of the model shown in Figure
1.2-2a. The matrix will initially contain a number of zeroes within the band
which will become nonzero as the decomposition proceeds. If the sequencing is
as shown in Figure 1.2-2c, the band portion of the matrix will be the same as
that for Figure 1.2-2a. However, the connection between grid points 1 and 8
will create a number of active columns on the right hand side of the matrix.
The solution times will be the same for the sequence shown in Figure 1.2-2b or
1.2-2c, because the number of active columns in each sequence is the same.

   Examples of grid point sequencing for surfaces are shown in Figure 1.2-3.
For plain or curved surfaces with a pattern of grid points that tends to be
rectangular, the sequencing shown in Figure 1.2-3a will result in a band
matrix having good solution times. The semiband will be proportional to the
number of grid points along the short direction of the pattern. If the pattern
of grid points shown in Figure 1.2-3a is made into a closed surface by
connecting grid points 1 and 17, 2 and 18, etc., a number of active columns
equal to the semiband will be created. If the number of grid points in the
circumferential direction is greater than twice the number in the axial
direction, the sequencing indicated in Figure 1.2-3a is a good one. However,
if the number of grid points in the circumferential direction is less than
twice the number in the axial direction, the use of consecutive numbering in
the circumferential direction is more efficient. An alternate sequencing for a
closed loop is shown in Figure 1.2-3b, where the semiband is proportional to
twice the number of grid points in a row. For cylindrical or similar closed
surfaces, the sequencing shown in Figure 1.2-3b has no advantage over that
shown in Figure 1.2-3a, as the total number of active columns will be the same
in either case.

   With the exception of the central point, sequencing considerations for the
radial pattern shown in Figure 1.2-3c are similar to those for the rectangular
patterns shown in Figures 3a and 3b. The central point must be sequenced last
in order to limit the number of active columns associated with this point to
the number of degrees of freedom at the central point. If the central point is
sequenced first, the number of active columns associated with the central
point will be proportional to the number of radial lines. If there are more
grid points on a radial line than on a circumferential line, the consecutive
numbering should extend in the circumferential direction beginning with the
outermost circumferential ring. In this case, the semiband is proportional to
the number of grid points on a circumferential line and there will be no
active columns on the right hand side of the matrix. If the grid points form a
full circular pattern, the closure will create a number of active columns
proportional to the number of grid points on a radial line if the grid points
are numbered as shown in Figure 1.2-3c. Proper sequencing for a full circular
pattern is similar to that discussed for the rectangular arrays shown in
Figures 3a and 3b for closed surfaces.

   Sequencing problems for actual structural models can frequently be handled
by considering the model as consisting of several substructures. Each
substructure is first numbered in the most efficient manner. The substructures
are then connected so as to create the minimum number of active columns. The
grid points at the interface between two substructures are usually given
numbers near the end of the sequence for the first substructure and as near
the beginning of the sequence for the second substructure as is convenient.

   Figure 1.2-4 shows a good sequence for the substructure approach. Grid
points 1 through 9 are associated with the first substructure, and grid points
10 through 30 are associated with the second substructure. In the example,
each of the substructures was sequenced for band matrices. However, other
schemes could also be considered for sequencing the individual substructures.
Figure 1.2-5 shows the nonzero terms in the triangular factor. The X's
indicate terms which are nonzero in the original matrix. The zeros indicate
nonzero terms created during the decomposition. The maximum number of active
columns for any pivotal row is only five, and this occurs in only three rows
near the middle of the matrix for the second substructure. All other pivotal
rows have four or less active columns.

   Figure 1.2-6 indicates the grid point sequencing using substructuring
techniques for a square model, and Figure 1.2-7 shows the nonzero terms in the
triangular factor. If the square model were sequenced for a band matrix, the
number of nonzero terms in the triangular factor would be 129, whereas Figure
1.2-7 contains only 102 nonzero terms. The time for the forward/backward
substitution operation is directly proportional to the number of nonzero terms
in the triangular factor. Consequently, the time for the forward/backward
substitution operation when the square array is ordered as shown in Figure
1.2-7 is only about 80% of that when the array is ordered for a band matrix.
The number of multiplications for a decomposition when ordered for a band is
294, whereas the number indicated in Figure 1.2-7 is only 177. This indicates
that the time for the decomposition when ordered as shown in Figure 1.2-6 is
only 60% of that when ordered for a band.

   Although scalar points are defined only in vector space, the pattern of the
connections is used in a manner similar to that of geometric grid points for
sequencing scalar points among themselves or with geometric grid points. Since
scalar points introduced for dynamic analysis (extra points) are defined in
connection with direct input matrices, the sequencing of these points is
determined by direct reference to the positions of the added terms in the
dynamic matrices.

1.2.2.2  Automatic Grid Point Resequencing Using the BANDIT Procedure
---------------------------------------------------------------------
   If you want reduced matrix reduction and equation solution times, you can
manually resequence your grid points by the use of SEQGP cards as per the
guidelines outlined in the previous section. However, in order to relieve you
of the burden of having to do so, an automatic resequencing capability has
been provided in NASTRAN. This capability involves the use of the BANDIT
procedure in NASTRAN. (See Reference 1 for details of the BANDIT procedure and
Reference 2 for details of the manner in which it has been implemented in
NASTRAN.)

   The BANDIT procedure in automatically invoked in NASTRAN for all runs
(except those indicated in Sections 1.2.2.2.2 and 1.2.2.2.3), unless
specifically suppressed by you. (See the description of the BANDIT options in
the next section.) The result of the BANDIT operations is a set of SEQGP cards
that are automatically generated by the program. These SEQGP cards are added
to your input data (replacing any SEQGP cards already input, if so specified)
for subsequent processing by the program.

1.2.2.2.1  BANDIT Options
-------------------------
   The execution of the BANDIT operations in NASTRAN is controlled by several
parameters. These parameters can be specified by means of the NASTRAN card and
are fully described in Section 2.1. All of these parameters have default
values selected so that you normally do not have to explicitly specify any of
them.

   NASTRAN provides two methods to skip over the BANDIT operations. First, the
NASTRAN BANDIT = -1 option can be used. The second method is to include one or
more SEQGP cards in the Bulk Data Deck. In this second method, BANDIT would
terminate since you have already stated your choice of SEQGP resequencing
cards. However, the NASTRAN BANDTRUN = 1 option can be used to force BANDIT to
generate new SEQGP cards to replace the old SEQGP set already in the input
Bulk Data Deck. In all instances when BANDIT is executed, NASTRAN will issue a
page of summary to keep you informed of the basic resequencing computations.
You may refer to Reference 1 for the definition of the technical terms used.

   The BANDIT procedure automatically counts the number of grid points used in
a NASTRAN job and sets up the exact array dimensions needed for its internal
computations. However, if your structural model uses more grid points in the
connecting elements than the total number of grid points as defined on the
GRID cards, BANDIT will issue a fatal message and terminate the job. In the
case where non-active grid points (that is, grid points defined on the GRID
cards but nowhere used in the model) do exist, BANDIT will add them to the end
of the SEQGP cards, and their presence will not cause termination of a job.
(If necessary, the NASTRAN HICORE parameter can be used on the UNIVAC version
to increase the amount of open core available for the BANDIT operations.)

   Multipoint constraints (MPCs) and rigid elements are included in the BANDIT
computations only when the BANDTMPC = 1 (or 2) option is selected. (The use of
the dependent grid points of MPCs and/or rigid elements is controlled by the
BANDTDEP option.) However, as noted in Reference 1, it should be emphasized
here that only in rare cases would it make sense to let BANDIT process MPCs
and rigid elements. The main reasons for this are that BANDIT does not
consider individual degrees of freedom and, in addition, cannot distinguish
one MPC set from another.

1.2.2.2.2  Cases for Which BANDIT Computations are Skipped
----------------------------------------------------------
   The BANDIT computations in NASTRAN are unconditionally skipped over if any
of the following conditions exists:

   1. There are errors in input data.

   2. The Bulk Data Deck contains any of the following types of input:

      a.Axisymmetric (CONEAX, TRAPAX, or TRIAAX) elements

      b.Fluid (FLUID2, FLUID3, or FLUID4) elements

      c.DMI (Direct Matrix Input) data

   3. It is a substructure Phase 2 run.

1.2.2.2.3  BANDIT in Restarts
-----------------------------
   At the beginning of a NASTRAN job, the Preface (or Link 1) modules read and
process the Executive, Case Control, and Bulk Data decks. The SEQGP cards
generated by BANDIT are added directly to the NASTRAN data base (specifically,
the GEOM1 file) at a later stage. Since these SEQGP cards are not part of the
original Bulk Data Deck, they are not directly written on to the NPTP (New
Problem Tape) in a checkpoint run and, therefore, are not available as such
for use on the OPTP (Old Problem Tape) in a restart.

   In the light of the above comments, the following points about the use of
BANDIT in NASTRAN restarts should be noted:

   1. BANDIT is automatically skipped if the restart job has no input data
      changes with respect to the checkpoint job. However, the previously
      generated SEQGP cards, if any, are already absorbed into the NASTRAN
      data base (data blocks such as EQEXIN, SIL, etc.). A message is printed
      to inform you that the BANDIT computations are not performed. (BANDIT
      can be executed if the restart job contains one or more of the
      appropriate BANDIT options on the NASTRAN card, for example, NASTRAN
      BANDMTH = 2.)

   2. BANDIT is executed (except for the cases indicated in Section 1.2.2.2.2)
      if the restart job has input data changes with respect to the checkpoint
      job, unless specifically suppressed by you. (The BANDIT = -1 option on
      the NASTRAN card can be used to stop BANDIT execution unconditionally.)

1.2.3  Grid Point Properties

   Some of the characteristics of the structural model are introduced as
properties of grid points, rather than as properties of structural elements.
Any of the various forms of direct matrix input are considered as describing
the structural model in terms of properties of grid points.

   Thermal fields are defined by specifying the temperatures at grid points.
The TEMP card is used to specify the temperature at grid points for use in
connection with thermal loading and temperature-dependent material properties.
The TEMPD card is used to specify a default temperature, in order to avoid a
large number of duplicate entries on a TEMP card when the temperature is
uniform over a large portion of the structure. The TEMPAX card is used for
conical shell problems.

   Mass properties may be input as properties of grid points by using the
concentrated mass element (see Section 5.5 of the Theoretical Manual). The
CONM1 card is used to define a 6x6 matrix of mass coefficients at a geometric
grid point in any selected coordinate system. The CONM2 card is used to define
a concentrated mass at a geometric grid point in terms of its mass, the three
coordinates of its center of gravity, the three moments of inertia about its
center of gravity, and its three products of inertia, referred to any selected
coordinate system.

   In dynamic analysis, mass, damping and stiffness properties may be
provided, in part or entirely, as properties of grid points through the use of
direct input matrices. The DMIG card is used to define direct input matrices
for use in dynamic analysis. These matrices may be associated with components
of geometric grid points, scalar points, or extra points introduced for
dynamic analysis. The TF card is used to define transfer functions that are
internally converted to direct matrix input. The DMIAX card is an alternate
form of direct matrix input that is used for hydroelastic problems (see
Section 1.7).

REFERENCES

1. Everstine, G. C., "BANDIT User's Guide", COSMIC Program No. DOD-00033, May
   1978.

2. Chan, G. C., "BANDIT in NASTRAN," Eleventh NASTRAN Users' Colloquium, NASA
   Conference Publication, May 1983, San Francisco, California, pp. 1-5.

                                     z
                                     |     u3
                                     |     |
                                     |     | P
                                   G2*     *-------- u2
                                     |    /|
(a) Rectangular                     /|   / |
                                   / |  /  | Z
                                  /  | u1  |
                               G3*   |     |
                                 | G1*----------*---------- y
                                 |  /      |   /
                                 | /       |  /
                                 |/        | / X
                                 /         |/
                                /----------*
                               /     Y
                              x



                                     z     u3 - z direction
                                     |     |  u2 - � direction
                                     |     | /
                                     |     |/
                                   G2*   p |\
                                     |     | \
(b) Cylindrical                     /|     |  \
                                   / |     |   u1 - r direction
                                  /  |     |Z
                               G3*   |     |
                                 | G1*---------------------y
                                 |  / \    |
                                 | / � \R  |
                                 |/     \  |
                                 /       \ |
                                /         \|
                               /
                              *



                                              u1 - p direction
                                     z        /     .u3 - � direction
                                     |       /   .
                                     |      / .
                                     |    P*
                                   G2*    /| \
                                    /| � / |  \
(c) Spherical                      / |  /  |   u2 - � direction
                                  /  | /R  |
                               G3*   |/    |
                                 | G1*---------------------y
                                 |  / \    |
                                 | / � \   |
                                 |/     \  |
                                 /       \ |
                                /         \|
                               /
                              x


                 Figure 1.2-1. Displacement coordinate systems

                            6
                           /|    5    4    3    2    1
(a)                        /+----+----+----+----+----+
                           /|
                           /



                             3           1            2
                             +-----------+------------+
                             |                        |
                             |                        |
                             |                        |
(b)                         5+                        +4
                             |                        |
                             |                        |
                             |                        |
                             +-----------+------------+
                             7           8            6



                             8           1            2
                             +-----------+------------+
                             |                        |
                             |                        |
                             |                        |
(c)                         7+                        +3
                             |                        |
                             |                        |
                             |                        |
                             +-----------+------------+
                             6           5            4


        Figure 1.2-2. Grid point sequencing for one-dimensional systems

                    4           8        12       16       20
                      +--------+--------+--------+--------+
                      |        |        |        |        |
                    3 |        |7       |11      |15      |19
                      +--------+--------+--------+--------+
(a)                   |        |        |        |        |
                    2 |        |6       |10      |14      |18
                      +--------+--------+--------+--------+
                      |        |        |        |        |
                      |        |        |        |        |
                      +--------+--------+--------+--------+
                    1           5        9        13       17



                   20           12       4        8        16
                      +--------+--------+--------+--------+
                      |        |        |        |        |
                   19 |        |11      |3       |7       |15
                      +--------+--------+--------+--------+
(b)                   |        |        |        |        |
                   18 |        |10      |2       |6       |14
                      +--------+--------+--------+--------+
                      |        |        |        |        |
                      |        |        |        |        |
                      +--------+--------+--------+--------+
                   17           9        1        5        13



                       12               9               6
                       +----------------+---------------+
                       | \  11          |8         5   /|
                       |   \+-----------+----------+ /  |
                       |    |\          |          |    |
                       |    |  \ 10     |7    4  / |    |
                       |    |    +------+-----+/   |    |
(c)                    |    |    | \    |    /|    |    |
                       |    |    |   \  |  /  |    |    |
                       |    |    |     \|/    |    |    |
                       +----+----+------+-----+----+----+
                      15    14   13     16    1    2    3


               Figure 1.2-3. Grid point sequencing for surfaces

                              +--------+--------+
                              |3       |2       |1
                              |        |        |
                              +--------+--------+
                              |6       |5       |4
                              |        |        |
                              +--------+--------+
                              |9       |8       |7
                              |        |        |
            +--------+--------+--------+--------+--------+--------+
            |28      |25      |22      |19      |16      |13      |10
            |        |        |        |        |        |        |
            +--------+--------+--------+--------+--------+--------+
            |29      |26      |23      |20      |17      |14      |11
            |        |        |        |        |        |        |
            +--------+--------+--------+--------+--------+--------+
             30       27       24       21       18       15       12


             Figure 1.2-4. Grid point sequencing for substructures



     X X   X
       X X 0 X
         X 0 0 X
           X X 0 X
             X X 0 X
               X 0 0 X
                 X X 0             X
                   X X             0     X
                     X             0     0     X
                       X X   X
                         X X 0 X
                           X 0 0 X
                             X X 0 X
                               X X 0 X
                                 X 0 0 X
                                   X X 0 X     0
                                     X X 0 X   0
                                       X 0 0 X 0
                                         X X 0 X
                                           X X 0 X
          (Symmetric)                        X 0 0 X
                                               X X 0 X
                                                 X X 0 X
                                                   X 0 0 X
                                                     X X 0 X
                                                       X X 0 X
                                                         X 0 0 X
                                                           X X 0
                                                             X X
                                                               X


             Figure 1.2-5. Matrix for substructure example

                                      |
                                      |
                                      |
                    +--------+--------+--------+--------+
                    |13      |14      |23      |10      |9
                    |        |        |        |        |
                    +--------+--------+--------+--------+
                    |15      |16      |24      |12      |11
                    |        |        |        |        |
              ------+--------+--------+--------+--------+------
                    |17      |18      |25      |22      |21
                    |        |        |        |        |
                    +--------+--------+--------+--------+
                    |3       |4       |20      |8       |7
                    |        |        |        |        |
                    +--------+--------+--------+--------+
                     1        2       |19       6        5
                                      |
                                      |


             Figure 1.2-6. Grid point sequencing for square model


          X X X
            X 0 X                             X
              X X                         X   0
                X                         0 X 0 X
                  X X X
                    X 0 X                     X
                      X X                     0   X
                        X                     0 X 0 X
                          X X X
                            X 0 X                     X
                              X X                 X   0
                                X                 0 X 0 X
                                  X X X
                                    X 0 X             X
                                      X X X           0
                                        X 0 X         0 X
               (Symmetric)                X X 0 0
                                            X 0 0     0 0 X
                                              X X 0 0 0 0 0
                                                X 0 0 0 0 X
                                                  X X 0 0 0
                                                    X 0 0 X
                                                      X X 0
                                                        X X
                                                          X



             Figure 1.2-7. Matrix for square model example


# 1.3  STRUCTURAL ELEMENTS
## 1.3.1  Element Definition

   Structural elements are defined on connection cards that identify the grid
points to which the elements are connected. The mnemonics for all such cards
have a prefix of the letter "C", followed by an indication of the type of
element, such as CBAR and CROD. The order of the grid point identification
defines the positive direction of the axis of a one-dimensional element and
the positive surface of a plate element. The connection cards include
additional orientation information when required. Except for the simplest
elements, each connection card references a property definition card. If many
elements have the same properties, this system of referencing eliminates a
large number of duplicate entries.

   The property definition cards define geometric properties such as
thicknesses, cross-sectional areas, and moments of inertia. The mnemonics for
all such cards have a prefix of the letter "P", followed by some, or all, of
the characters used on the associated connection card, such as PBAR and PROD.
Other included items are the nonstructural mass and the location of points
where stresses will be calculated. Except for the simplest elements, each
property definition card will reference a material property card.

   In some cases, the same finite element can be defined by using different
bulk data cards. These alternate cards have been provided for your
convenience. In the case of a rod element, the normal definition is
accomplished with a connection card (CROD) which references a property card
(PROD). However, an alternate definition uses a CONROD card which combines
connection and property information on a single card. This is more convenient
if a large number of rod elements all have different properties.

   In the case of plate elements, a different property card is provided for
each type of element, such as membrane or sandwich plates. Thus, each property
card contains only the information required for a single type of plate
element, and in most cases, a single card has sufficient space for all of the
property information. In order to maintain uniformity in the relationship
between connection cards and property cards, a number of connection card types
contain the same information, such as the connection cards for the various
types of triangular elements. Also, the property cards for triangular and
quadrilateral elements of the same type contain the same information.

   The material property definition cards are used to define the properties
for each of the materials used in the structural model. The MAT1 card is used
to define the properties for isotropic materials. The MAT1 card may be
referenced by any of the structural elements. The MATS1 card specifies table
references for isotropic material properties that are stress dependent. The
TABLES1 card defines a tabular stress-strain function for use in piecewise
linear analysis. The MATT1 card specifies table references for isotropic
material properties that are temperature dependent. The TABLEM1, TABLEM2,
TABLEM3, and TABLEM4 cards define four different types of tabular functions
for use in generating temperature-dependent material properties.

   The MAT2 card is used to define the properties for anisotropic materials.
The MAT2 card may only be referenced by triangular or quadrilateral membrane
and bending elements. The MAT2 card specifies the relationship between the
inplane stresses and strains. The material is assumed to be infinitely rigid
in transverse shear. The angle between the material coordinate system and the
element coordinate system is specified on the connection cards. The MATT2 card
specifies table references for anisotropic material properties that are
temperature dependent. This card may reference any of the TABLEM1, TABLEM2,
TABLEM3, or TABLEM4 cards.

   The MAT3 card is used to define the properties for orthotropic materials
used in the modeling of axisymmetric shells. This card may only be referenced
by CTRIARG, CTRIAAX, CTRAPRG, CTRAPAX, and PTORDRG cards. The MATT3 card
specifies table references for use in generating temperature-dependent
properties for this type of material.

   The GENEL card is used to define general elements whose properties are
defined in terms of deflection influence coefficients or stiffness matrices,
and which can be connected between any number of grid points. One of the
important uses of the general element is the representation of part of a
structure by means of experimentally measured data. No output data is prepared
for the general element. Detail information on the general element is given in
Section 5.7 of the Theoretical Manual.

   Dummy elements are provided in order to allow you to investigate new
structural elements with a minimum expenditure of time and money. A dummy
element is defined with a CDUMi (i = index of element type, 1 <= i <= 9) card
and its properties are defined with the PDUMi card. The ADUMi card is used to
define the items on the connection and property cards. Detailed instructions
for coding dummy element routines are given in Section 6.8.5 of the
Programmer's Manual.

# 1.3.2  Beam Elements
## 1.3.2.1  Simple Beam or Bar Element

   The simple beam or bar element is defined with a CBAR card and its
properties (constant over the length) are defined with a PBAR card. The bar
element includes extension, torsion, bending in two perpendicular planes, and
the associated shears. The shear center is assumed to coincide with the
elastic axis. Any five of the six forces at either end of the element may be
set equal to zero by using the pin flags on the CBAR card. The integers 1 to 6
represent the axial force, shearing force in Plane 1, shearing force in Plane
2, axial torque, moment in Plane 2, and moment in Plane 1, respectively. The
structural and nonstructural mass of the bar are lumped at the ends of the
element, unless coupled mass is requested with a PARAM COUPMASS card (see
PARAM bulk data card). Theoretical aspects of the bar element are treated in
Section 5.2 of the Theoretical Manual.

   The element coordinate system is shown in Figure 1.3-1a. End a is offset
from grid point a an amount measured by vector wa and end b is offset from
grid point b an amount measured by vector wb. The vectors wa and wb are
measured in the global coordinates of the connected grid point. The x-axis of
the element coordinate system is defined by a line connecting end a to end b
of the bar element. The orientation of the bar element is described in terms
of two reference planes. The reference planes are defined with the aid of
vector v. This vector may be defined directly with three components in the
global system at end a of the bar or by a line drawn from end a to a third
referenced grid point. The first reference plane (Plane 1) is defined by the
x-axis and the vector v. The second reference plane (Plane 2) is defined by
the vector cross product (x x v) and the x-axis. The subscripts 1 and 2 refer
to forces and geometric properties associated with bending in planes 1 and 2,
respectively. The reference planes are not necessarily principal planes. The
coincidence of the reference planes and the principal planes is indicated by a
zero product of inertia (I12) on the PBAR card. If shearing deformations are
included, the reference axes and the principal axes must coincide. When pin
flags and offsets are used, the effect of the pin is to free the force at the
end of the element x-axis of the beam, not at the grid point. The positive
directions for element forces are shown in Figure 1.3-1b. The following
element forces, either real or complex (depending on the rigid format), are
output on request:

   -  Bending moments at both ends in the two reference planes.

   -  Shears in the two reference planes.

   -  Average axial force.

   -  Torque about the bar axis.

   The following real element stresses are output on request:

   -  Average axial stress.

   -  Extensional stress due to bending at four points on the cross-section at
      both ends. (Optional; calculated only if you enter stress recovery
      points on PBAR card.)

   -  Maximum and minimum extensional stresses at both ends.

   -  Margins of safety in tension and compression for the whole element.
      (Optional; calculated only if you enter stress limits on MAT1 card.)

   Tensile stresses are given a positive sign and compressive stresses a
negative sign. Only the average axial stress and the extensional stresses due
to bending are available as complex stresses. The stress recovery coefficients
on the PBAR card are used to locate points on the cross-section for stress
recovery. The subscript 1 is associated with the distance of a stress recovery
point from plane 2. The subscript 2 is associated with the distance from plane
1.

   The use of the BAROR card avoids unnecessary repetition of input when a
large number of bar elements either have the same property identification
number or have their reference axes oriented in the same manner. This card is
used to define default values on the CBAR card for the property identification
number and the orientation vector for the reference axes. The default values
are used only when the corresponding fields on the CBAR card are blank.

### 1.3.2.2  Curved Beam or Elbow Element

   The curved beam or elbow element is a three-dimensional element with
extension, torsion, and bending capabilities and the associated shears. No
offset of the elastic axis is allowed nor are pin releases permitted to
eliminate the connection between motions at the ends of the element and the
adjacent grid points.

   The elbow element was initially developed to facilitate the analysis of
pipe networks by using it as a curved pipe element. However, the input format
is general enough to allow application to beams of general cross section. An
important assumption in the development of the element is that the radius of
curvature is much larger than the cross section depth.

   The element is defined with a CELBOW card and its properties (constant over
the length) are defined with a PELBOW card. There are six degrees of freedom
at each end of the element: translations in the local x, y, z directions and
rotations about the local x, y, z axes. The structural and nonstructural mass
of the element are lumped at the ends of the element.

   The specified properties of the elbow element are its area; its moments of
inertia, I1 and I2 (the product of inertia is assumed to be zero); its
torsional constant, J; the radius of curvature; the angle between end-a and
end-b; the factors K1 and K2 for computing transverse shear stiffness; the
nonstructural mass per unit length, NSM; the stress intensification factor, C;
and the flexibility correction factors, Kx, Ky, and Kz. The stress
intensification factor C is applied to the bending stress only. The
flexibility correction factors Kx, Ky, and Kz are generally greater than 1.0
and are used as divisors to reduce the respective moments of inertia. These
are discussed further towards the end of this section.

   The material properties, obtained by reference to a materials properties
table, include the elastic moduli, E and G, density, rho, and the thermal
expansion coefficient, +, determined at the average temperature of the
element.

   The plane of the element is defined by two grid points, A and B, and a
vector v from grid point A directed toward the center of curvature. Plane 1 of
the element cross section lies in this plane. Plane 2 is normal to Plane 1 and
contains the vector v. The area moments of inertia, I1 and I2, are defined as
for the BAR element. The cross product of inertia, I12, is neglected. This
assumption requires that at least one axis of the element cross section be an
axis of symmetry.

   The following element forces are output on request:

   -  Bending moments at both ends in the two reference planes

   -  Transverse shear force at both ends in the two reference planes

   -  Axial force at both ends

   -  Torque at both ends

   The following element stresses are output on request:

   -  Average axial stress at both ends

   -  Bending stresses at four points on the cross section at both ends. The
      points are specified by you.

   -  Maximum and minimum extensional stresses at both ends.

   -  Margins of safety in tension and compression (Optional, output only if
      you enter stress limits on MAT1 card)

Stress Intensification Factor and Flexibility Correction Factors
----------------------------------------------------------------
   When a plane pipe network, consisting of both straight and curved sections,
is analyzed by simple beam theory as an indeterminate system, the computed
support reactions are greater than actually would be measured in an
experiment. The apparent decrease in stiffness in such a case is due to an
ovalization of the pipe in the curved sections. The ovalization also yields a
stress distribution different from that computed by simple beam theory.

   When a curved beam or elbow element is used as a curved pipe element, there
are two factors available that can be specified to account for the differences
in its behavior compared to curved beams. These are the stress intensification
factor and the flexibility correction factors.

   The maximum stress, +max, in a curved pipe element is given by

                  Mc
      +max  =  C ----
                   I

where C is a stress intensification factor,

      M = bending moment,

      c = fiber distance, and

      I = plane (area) moment of inertia of the cross section.

   In general, the factor C mentioned above may be regarded as a stress
correction factor in curved beam analysis.

   The effect of the ovalization of the pipe in curved sections is to reduce
the stiffness parameter EI (E:  modulus of elasticity) of the curved pipe to a
fictitious value. Thus, for the elbow element,

              EI1
   (EI1)'  =  ---   ,   (Ky > 1.0), and
              Ky

              EI2
   (EI2)'  =  ---   ,   (Kz > 1.0)
              Kz

where Ky and Kz are the stiffness correction factors corresponding to planes 1
and 2, respectively. The stiffness correction factor, Kz, corresponds to the
torsional behavior and is generally taken to be 1.0.

1.3.3  Rod Element

   The rod element is defined with a CROD card and its properties with a PROD
card. The rod element includes extensional and torsional properties. The
CONROD card is an alternate form that includes both the connection and
property information on a single card. The tube element is a specialized form
that is assumed to have a circular cross-section. The tube element is defined
with a CTUBE card and its properties with a PTUBE card. The structural and
nonstructural mass of the rod are lumped at the adjacent grid points unless
coupled mass is requested with the PARAM COUPMASS card (see PARAM bulk data
card). Theoretical aspects of the rod element are treated in Section 5.2 of
the Theoretical Manual.

   The x-axis of the element coordinate system is defined by a line connecting
end a to end b as shown in Figure 1.3-2. The axial force and torque are output
on request in either the real or complex form. The positive directions for
these forces are indicated in Figure 1.3-2. The following real element
stresses are output on request:

   -  Axial stress

   -  Torsional stress

   -  Margin of safety for axial stress

   -  Margin of safety for torsional stress.

   Positive directions are the same as those indicated in Figure 1.3-2 for
element forces. Only the axial stress and the torsional stress are available
as complex stresses.

   Another kind of rod element is the viscous damper, which has extensional
and torsional viscous damping properties rather than stiffness properties. The
viscous damper element is defined with a CVISC card and its properties with a
PVISC card. This element is used in the direct formulation of dynamic
matrices.

1.3.4 Shear Panels and Twist Panels

   The shear panel is defined with a CSHEAR card and its properties with a
PSHEAR card. A shear panel is a two-dimensional structural element that
resists the action of tangential forces applied to its edges, but does not
resist the action of normal forces. The structural and nonstructural mass of
the shear panel are lumped at the connected grid points. Details of the shear
panel element are discussed in Section 5.3 of the Theoretical Manual.

   The element coordinate system for a shear panel is shown in Figure 1.3-3a.
The integers 1, 2, 3, and 4 refer to the order of the connected grid points on
the CSHEAR card. The element forces are output on request in either the real
or complex form. The positive directions for these forces are indicated in
Figure 1.3-3b. These forces consist of the forces applied to the element at
the corners in the direction of the sides, kick forces at the corners in a
direction normal to the plane formed by the two adjacent edges, and "shear
flows" (force per unit length) along the four edges. The shear stresses are
calculated at the corners in skewed coordinates parallel to the exterior
edges. The average of the four corner stresses and the maximum stress are
output on request in either the real or complex form. A margin of safety is
also output when the stresses are real.

   The twist panel performs the same function for bending action that the
shear panel performs for membrane action. The twist panel is defined with a
CTWIST card and its properties with a PTWIST card. In calculating the
stiffness matrix, a twist panel is assumed to be solid. For built-up panels,
the thickness in the PTWIST card must be adjusted to give the correct moment
of inertia of the cross-section. If mass calculations are being made, the
density will also have to be adjusted on a MAT1 card. The element coordinate
system and directions for positive forces are shown in Figure 1.3-4. Stress
recovery is similar to that for shear panels.

## 1.3.5  Plate and Membrane Elements

   NASTRAN includes two different shapes of plate and membrane elements
(triangular and quadrilateral) and two different stress systems (inplane and
bending) which are uncoupled. There are different forms of elements available
that are defined by connection cards as follows:

1. Plate (Bending) Elements

a. CTRBSC - basic unit from which the bending properties of the other plate
   elements are formed.

b. CTRPLT - triangular element with zero inplane stiffness and finite bending
   stiffness.

c. CTRPLT1 - a higher order triangular element with zero inplane stiffness and
   finite bending stiffness. Uses quintic polynomial representation for
   transverse displacements and bilinear variation for temperature and
   thickness.

d. CQDPLT - quadrilateral element with zero inplane stiffness and finite
   bending stiffness.

2. Membrane (Inplane) Elements

a. CTRMEM - triangular element with finite inplane stiffness and zero bending
   stiffness.

b. CTRIM6 - triangular element with finite inplane stiffness and zero bending
   stiffness. Uses quadratic polynomial representation for membrane
   displacements and bilinear variation for temperature and thickness.

c. CQDMEM - quadrilateral element consisting of four overlapping CTRMEM
   elements.

d. CQDMEM1 - an isoparametric quadrilateral membrane element.

e. CQDMEM2 - a quadrilateral membrane element consisting of four non-
   overlapping CTRMEM elements.

f. CIS2D8 - a quadriparabolic isoparametric membrane element. May be reduced
   to a triangular element under specified conditions.

3. Plate and Membrane Elements

a. CTRIA1 - triangular element with both inplane and bending stiffness. It is
   designed for sandwich plates which can have different materials referenced
   for membrane, bending, and transverse shear properties.

b. CTRIA2 - triangular element with both inplane and bending stiffness that
   assumes a solid homogeneous cross-section.

c. CQUAD1 - quadrilateral element with both inplane and bending stiffness. It
   is designed for sandwich plates which can have different materials
   referenced for membrane, bending, and transverse shear properties.

d. CQUAD2 - quadrilateral element with both inplane and bending stiffness that
   assumes a solid homogeneous cross-section.

   Theoretical aspects of these elements are treated in Section 5.8 of the
Theoretical Manual.

   The properties for the above elements are defined on their associated
Pxxxxxx cards (PTRBSC, PTRPLT, etc.). All of the properties of the elements
are assumed uniform over their surfaces, except for the CTRIM6 and CTRPLT1
elements. Anisotropic material may be specified for all these elements.
Transverse shear flexibility may be included for all bending elements on an
optional basis, except for homogeneous elements (CTRIA2 and CQUAD2), where
this effect is automatically included. Structural mass is calculated only for
elements that specify a membrane thickness and is based only on the membrane
thickness. Nonstructural mass can be specified for all plate elements, except
the basic bending triangle. Only lumped mass procedures are used for membrane
elements, except for the CIS2D8 element. Coupled mass procedures may be
requested for elements that include bending stiffness with the PARAM COUPMASS
card (see PARAM bulk data card). Differential stiffness matrices are generated
for the following elements: CTRMEM, CTRIA1, CTRIA2, CQDMEM, CQUAD1, CQUAD2.
The following elements may have nonlinear material characteristics in
Piecewise Linear Analysis: CTRMEM, CTRIA1, CTRIA2, CQDMEM, CQUAD1, CQUAD2.

   The element coordinate systems for the triangular and quadrilateral
elements are shown in Figure 1.3-5. The integers 1, 2, 3, and 4 refer to the
order of the connected grid points on the connection cards defining the
elements. A similar connection scheme for elements with mid-side grid points
would be defined by six or eight integers on the connection card. The angle �
is the orientation angle for anisotropic materials.

   Average values of element forces are calculated for all plate elements
(except the CTRPLT1) having a finite bending stiffness. The element forces for
the CTRPLT1 are calculated at the corners and centroid of the element. The
positive directions for plate element forces in the element coordinate system
are shown in Figure 1.3-6a. The following element forces per unit of length,
either real or complex, are output on request:

   -  Bending moments on the x and y faces.

   -  Twisting moment.

   -  Shear forces on the x and y faces.

   The CQDMEM2 is the only membrane element for which element forces are
calculated. The positive directions for these forces are shown in Figure 1.3-
3b, and the force output has the same interpretation as the force output for
the shear panel discussed previously.

   Average values of the membrane stresses are calculated for the triangular
and quadrilateral membrane elements, with the exception of the CQDMEM1 and
CTRIM6 elements. For the CQDMEM1 element, in which the stress field varies,
the stresses are evaluated at the intersection of diagonals (in a mean plane
if the element is warped.) For the CTRIM6 element, the stresses are calculated
at the corners and centroid of the element. The positive directions for the
membrane stresses are shown in Figure 1.3-6b. The stresses for the CQDMEM2
element are calculated in the material coordinate system. The material
coordinate system is defined by the material orientation angle on the CQDMEM2
card. The stresses for all other membrane elements are calculated in the
element coordinate system. For the CIS2D8 element, the stresses are computed
at the Gaussian quadrature points and extrapolated to the grid points.

   The following real membrane stresses are output on request:

   -  Normal stresses in the x and y directions

   -  Shear stress on the x face in the y direction

   -  Angle between the x-axis and the major principal axis

   -  Major and minor principal stresses

   -  Maximum shear stress

   Only the normal stresses and shearing stress are available in the complex
form.

   If an element has bending stiffness, the average stresses are calculated on
the two faces of the plate for homogeneous plates and at two specified points
on the cross-section for other plate elements. The distances to the specified
points are given on the property cards. The positive directions for these
fiber distances are defined according to the right-hand sequence of the grid
points specified on the connection card. These distances are identified in the
output and must be nonzero in order to obtain nonzero stress output. The same
stresses are calculated for each of the faces as are calculated for membrane
elements.

   In the case of composite plate elements (CTRIA1, CTRIA21, CQUAD1, and
CQUAD2 only), the stresses mentioned above can also be requested in a material
coordinate system which is specified on a MAT1 or MAT2 card. In place of the
fiber distances, the output in this case identifies the specified material
coordinate system as well as an output code. This latter code is set to 1 or 2
according as the material x-axis or the y-axis is chosen as the reference
axis.

   The element stresses in material coordinate system computed above (for
CTRIA1, CTRIA2, CQUAD1, and CQUAD2 elements) can also be requested at the
connected grid points. These stresses (at grid points) are obtained by
interpolation. The output code in this case is set to (10*N + projection code)
where N is the number of independent points used in the interpolation and the
projection code is an integer which is set to 1, 2, or 3 according as the
material x-axis, y-axis, or the z-axis is normal to projection.

   In the case of composite plate elements (CTRIA1, CTRIA2, CQUAD1, and CQUAD2
only), strains and curvatures are also output on request. The options
available and the output formats are similar to those available in the case of
stresses as described above.

   The quadrilateral elements are intended for use when the surfaces are
reasonably flat and the geometry is nearly rectangular. For these conditions,
the quadrilateral elements eliminate the modeling bias associated with the use
of triangular elements, and quadrilaterals give more accurate results for the
same mesh size. If the surfaces are highly warped, curved, or swept,
triangular elements should be used. Under extreme conditions quadrilateral
elements will give results that are considerably less accurate than triangular
elements for the sane mesh size. Quadrilateral elements should be kept as
nearly square as practicable, as the accuracy tends to deteriorate as the
aspect ratio of the quadrilateral increases. Triangular elements should be
kept as nearly equilateral as practicable, because the accuracy tends to
deteriorate as the angles become obtuse and as the ratio of the longest to the
shortest side increases.

## 1.3.6  Axisymmetric Shell Elements

   The properties of axisymmetric shells can be specified with either of two
elements, the conical shell (CONEAX) or the toroidal ring (TORDRG). However,
these cannot be used together in the same model. Also available for thick
shells of revolution are the axisymmetric solid elements (TRIARG, TRAPRG,
TRIAAX, and TRAPAX) which are described in the next section. Thin shell
(TRSHL) modeling is described in Section 1.3.12.

### 1.3.6.1  Conical Shell (CONEAX) Element

   The properties of the conical shell element are assumed to be symmetrical
with respect to the axis of the shell. However, the loads and deflections need
not be axisymmetric, as they are expanded in Fourier series with respect to
the aximuthal coordinate. Due to symmetry, the resulting load and deformation
systems for different harmonic orders are independent, a fact that results in
a large time saving when the use of the conical shell element is compared with
an equivalent model constructed from plate elements. Theoretical aspects of
the conical shell element are treated in Section 5.9 of the Theoretical
Manual.

   The conical shell element may be combined with TRIAAX and TRAPAX elements
only. The existence of a conical shell problem is defined by the AXIC card.
This card also indicates the number of harmonics desired in the problem
formulation. Only a limited number of bulk data cards are allowed when using
conical shell elements. The list of allowable cards is given on the AXIC card
description in Section 2.4.2.

   The geometry of a problem using the conical shell element is described with
RINGAX cards instead of GRID cards. The RINGAX cards describe concentric
circles about the basic z-axis, with their locations given by radii and z-
coordinates as shown in Figure 1.3-7. The degrees of freedom defined by each
RINGAX card are the Fourier coefficients of the motion with respect to angular
position around the circle. For example the radial motion, ur, at any angle,
�, is described by the equation:

               N     n           N     n*
   ur (�)  =   -   ur  cos n� +  -   ur   sin n�                    (1)
              n=0               n=0

where urn and urn* are the Fourier coefficients of radial motion for the n-
harmonic. For calculation purposes the series is limited to N harmonics as
defined by the AXIC card. The first sum in the above equation describes
symmetric motion with respect to the � = 0 plane. The second sum with the
"starred" (*) superscripts describes the antisymmetric motion. Thus each
RINGAX data card will produce six times (N+l) degrees of freedom for each
series.

   The selection of symmetric or antisymmetric solutions is controlled by the
AXISYM card in the Case Control Deck. For general loading conditions, a
combination of the symmetric and antisymmetric solutions must be made, using
the SYMCOM card in the Case Control Deck (Section 2.3 of User's Manual).

   Since you are rarely interested in applying loads in terms of Fourier
harmonics and interpreting your data by manually performing the above
summations, NASTRAN is provided with special cards which automatically perform
these operations. The POINTAX card is used like a GRID card to define physical
points on the structure for loading and output. Sections of the circle may be
defined by a SECTAX card, which defines a sector with two angles and a
referenced RINGAX card. The POINTAX and SECTAX cards define six degrees of
freedom each. The implied coordinate system for these points is a cylindrical
system (r, �, z) and their applied loads must be described in this coordinate
system. Since the displacements of these points are dependent on the harmonic
motions, they nay not be constrained in any manner.

   The conical shell element is connected to two RINGAX points with a CCONEAX
card. The properties of the conical shell element are described on the PCONEAX
card. The RINGAX points must be placed on the neutral surface of the element
and the points for stress calculation must be given on the PCONEAX card
relative to the neutral surface. Up to fourteen angular positions around the
element may be specified for stress and force output. These values will be
calculated midway between the two connected rings.

   The structure defined with RINGAX and CCONEAX cards must be constrained in
a special manner. All harmonics may be constrained for a particular degree of
freedom on a ring by using permanent single-point constraints on the RINGAX
cards. Specified harmonics of each degree of freedom on a ring may be
constrained with a SPCAX card. This card is the same as the SPC card except
that a harmonic must be specified. The MPCAX, OMITAX, and SUPAX data cards
correspond the MPC, OMIT, and SUPORT data except that harmonics must be
specified. SPCADD and MPCADD cards may be used to combine constraint sets in
the usual manner.

   The stiffness matrix includes five degrees of freedom per grid circle per
harmonic when transverse shear flexibility is included. Since the rotation
about the normal to the surface is not included, either the fourth or the
sixth degree of freedom (depending upon the situation) must be constrained to
zero when the angle between the meridional generators of two adjacent elements
is zero. When the transverse shear flexibility is not included, only four
independent degrees of freedom are used, and the fourth and sixth degrees of
freedom must be constrained to zero for all rings. These constraints can be
conveniently specified on the RINGAX card.

   The conical shell structure may be loaded in various ways. Concentrated
forces may be described by FORCE and MOMENT cards applied to POINTAX points.
Pressure loads may be input in the PRESAX data card which defines an area
bounded by two rings and two angles. Temperature fields are described by a
paired list of angles and temperatures around a ring as required by the TEMPAX
card. Direct loads on the harmonics of a RINGAX point are given by the FORCEAX
and MOMAX card. Since the implied coordinate system is cylindrical, the loads
are given in the r, �, and z directions. The value of a harmonic load Fn is
the total load on the whole ring of radius r. If a sinusoidal load per unit
length of maximum value an is given, the value on the FORCEAX card must be

   Fn  =  2+ r an             n = 0 ,                               (2)

   Fn  =  + r  an             n > 0 .                               (3)

   Displacements of rings and forces in conical shell elements can be
requested in two ways:

   1. The harmonic coefficients of displacements on a ring or forces in a
      conical element.

   2. The displacements at specified points or the average value over a
      specified sector of a ring. The forces in the element at specified
      azimuths or average values over specified sectors of a conical element.

Harmonic output is requested by ring number for displacements and conical
shell element number for element forces. The number of harmonics that will be
output for any request is a constant for any single execution. This number is
controlled by the HARMONICS card in the Case Control Deck (see Section 2.3).

   The following element forces per unit of width are output either as
harmonic coefficients or at specified locations on request:

   -  Bending moments on the u and v faces

   -  Twisting moments

   -  Shearing forces on the u and v faces

   The following element stresses are calculated at two specified points on
the cross-section of the element and output either as harmonic coefficients or
at specified locations on request:

   -  Normal stresses in u and v directions

   -  Shearing stress on the u face in the v direction

   -  Angle between the u-axis and the major principal axis

   -  Major and minor principal stresses

   -  Maximum shear stress

   The manner in which the data cards for the CONEAX element (as well as for
the TRAPAX and TRIAAX elements) are processed is described in Section 1.3.7.3.

### 1.3.6.2  Toroidal Ring (TORDRG) Element

   The cylindrical coordinate system for the toroidal ring is implied by the
use of the toroidal element, and hence, no explicit definition is required.
The toroidal element may use orthotropic materials. The axes of orthotropy are
assumed to coincide with the element coordinate axes.

   Deformation behavior of the toroidal element is described by five degrees
of freedom for each of the two grid rings which it connects. The degrees of
freedom in the implicit coordinate system are:
      _
   1. u - radial displacement

   2. Not defined for toroidal element (must be constrained)
      _
   3. w  - axial displacement

   4. w'  =  aw/ae  slope in e-direction

   5. u'  =  au/ae  strain in e-direction

   6. w'' =  a^2w/ae^2  curvature in ze-plane

   The displacements u and w are in the basic coordinate system, and hence can
be expressed in other local coordinate systems if desired. However, the
quantities u', w', and w'' are always in the element coordinate system.

   The toroidal ring element connectivity is defined with a CTORDRG card and
its properties with a PTORDRG card and, in the limit, this element becomes a
cap element (see Section 5.10 of the Theoretical Manual). The integers 1 and 2
refer to the order of the connected grid points on the CTORDRG card. The grid
points must lie in the r-z plane of the basic coordinate system and they must
lie to the right of the axis of symmetry. The angles +1 and +2 are the angles
of curvature and are defined as the angle measured in degrees from the axis of
symmetry to a line which is perpendicular to the tangent to the surface at
grid points 1 and 2 respectively. For conic rings +1 = +2 and for cylindrical
rings +1 = +2 = 90 degrees. Toroidal elements may be connected to form closed
figures in the r-z plane, but slope discontinuities are not permitted at
connection points.

   The following forces, evaluated at each end of the toroidal element, are
output on request:

   -  Radial force

   -  Axial force

   -  Meridional moment

   -  A generalized force which corresponds to the w' degree of freedom.

   -  A generalized force which corresponds to the w'' degree of freedom.

The first three forces are referenced to the global coordinate system and the
two generalized forces are referenced to the element coordinate system. For a
definition of the generalized forces see Section 5.10 of the Theoretical
Manual.

   The following stresses, evaluated at both ends and the midspan of each
element, are output on request:

   -  Tangential membrane stress (Force per unit length)

   -  Circumferential membrane stress (Force per unit length)

   -  Tangential bending stress (Moment per unit length)

   -  Circumferential bending stress (Moment per unit length)

   -  Shearing stress (Force per unit length)

## 1.3.7  Axisymmetric Solid Elements

   Two sets of elements are provided for representing thick axisymmetric shell
and/or solid structures (see Section 5.11 of the Theoretical Manual). The
first set, the triangular ring TRIARG and trapezoidal ring TRAPRG, is
restricted to axisymmetric applied loadings only. The second set is not
restricted to axisymmetric loadings and, like the conical shell element, their
displacements and loads are represented by coefficients of a Fourier series
about the circumference. These elements, the TRIAAX and the TRAPAX, also
define a triangular and a trapezoidal cross section respectively. The elements
of one set may not be used together with elements of the other set nor with
any other elements except the combination of TRIAAX and TRAPAX elements with
the conical shell element (CONEAX).

### 1.3.7.1  TRIARG and TRAPRG Elements

   The triangular and trapezoidal ring elements may be used for modeling
axisymmetric thick-walled structures of arbitrary profile. In the limiting
case only the TRAPRG element may become a solid core element.

   The coordinate systems for the triangular and trapezoidal ring elements are
shown in Figures 1.3-10 and 1.3-11, respectively. The cylindrical system is
implied by the use of these ring elements. Hence, no explicit definition of
the basic cylindrical coordinate system is required. Cylindrical anisotropy is
optional for the material properties in the ring elements. Orientation of the
orthotropic axes in the (r,z) plane is specified by the angle �. The
deformation behavior of the elements is described in terms of the translations
in the r and z directions at each of the connected grid points. All other
degrees of freedom must be constrained.

   The triangular ring element is defined with a CTRIARG card. No property
card is used for this element. The material property reference is given on the
connection card. The integers 1, 2, and 3 in Figure 1.3-10 refer to the order
of the connected grid points on the CTRIARG card. This order must be counter-
clockwise around the element. The grid points must lie in the r-z plane of the
basic cylindrical coordinate system, and they must lie to the right of the
axis of symmetry.

   The radial and axial forces at each connected grid point are output on
request. The positive directions for these forces are shown in Figure 1.3-10.
These are apparent element forces and they include any equivalent thermal
loads. The stresses at the centroid of an element are output on request. The
available quantities are the normal stresses in the radial, circumferential
and axial directions, and the shear stress on the radial face in the axial
direction. Positive stresses are in the positive direction on the positive
face.

   The trapezoidal ring element is defined with a CTRAPRG card in a manner
similar to that for a triangular element. This element is similar to the
triangular ring element. This element has the additional restriction that the
element numbering must begin at the lower left hand corner of the element.
Also, the parallel faces of the trapezoid must be perpendicular to the axis of
symmetry (see Figure 1.3-11). This element can be used in the limiting case
where the r coordinates associated with grid points 1 and 4 are zero. In this
special case the element is referred to as a core element.

   The forces at the four connected grid points are provided on request in a
manner similar to that for a triangular element. In addition to providing the
stresses at the four connected grid points of the trapezoid, similar stresses
are provided at a point of average radius and average z-distance from the four
points.

### 1.3.7.2  TRIAAX and TRAPAX Elements

   The two solid of revolution elements which are provided for representing
nonaxisymmetric loadings on axisymmetric structures with thick or solid cross
sections are the TRIAAX and TRAPAX elements. These define a triangle and a
trapezoidal cross section of the structure. They are functionally similar to
the conical shell element (see Section 1.3.6) and physically similar to the
TRAPRG and TRIARG axisymmetric ring elements described above (see Figures 1.3-
10 and 1.3-11).

   The elements are connected to RINGAX points which define displacement
degrees of freedom represented by coefficients of a Fourier series about the
circumference. Due to symmetry, the resulting load and deformation systems for
the different harmonic orders are uncoupled, resulting in large time savings
compared to a general three-dimensional model. Theoretical aspects of the
solid of revolution elements are treated in Section 5.11 of the Theoretical
Manual. Definitions of the Fourier series representation of the structural
displacements and loads are given in Section 5.9 of the Theoretical Manual. As
in the conical shell formulation, no other element types may be combined with
these elements.

   The following special case control cards, used also with the conical shell
problem, are used with the solid of revolution elements:

AXISYM - Defines whether the cosine series, sine series, or combination of
displacements are to be calculated.

HARMONICS - Limits the output to all harmonics up to and including the nth
harmonic; default is 0.

   The geometry of a problem using these elements is defined by the RINGAX
cards. The harmonic limit in the Fourier expansion is defined by the required
AXIC card. The RINGAX card does not allow a zero radius. However, a small
"hole" may be defined around the axis of revolution. To avoid inaccuracies, a
warning is issued for each element whose inner radius is less than one-tenth
its outer radius. Property cards PTRAPAX and PTRIAAX are used to identify the
material and the circumferential locations for stress output. The material
type is limited to MAT1 and MAT3 definitions. The following bulk data cards,
also used with the conical shell elements, are available with the solid of
revolution elements:

AXIC - Defines limit of displacement Fourier series.

SPCAX - Defines single point constraints and enforced displacements on
specified degrees of freedom.

MPCAX - Defines multipoint constraints connecting specified degrees of
freedom.

OMITAX - Defines degrees of freedom to be removed by structural partitioning.

SUPAX - Defines free-body support points.

POINTAX - Defines circumferential location on a RINGAX station for applied
loading and/or output.

SECTAX - Defines a circumferential sector on a RINGAX station for distributed
applied forces.

FORCE - Defines a concentrated force at a POINTAX or load per length at a
SECTAX location on the structure.

FORCEAX - Defines a generalized force directly on a specified harmonic of a
RINGAX station.

PRESAX - Defines a pressure load.

TEMPAX - Defines a temperature distribution at a RINGAX point for thermal
loading and temperature-dependent matrices.

   The implied coordinate system for the solid of revolution elements is a
cylindrical coordinate system (r, �, z). The rotational degrees of freedom
(components 4, 5, and 6) must be constrained.

   The output quantities for the RINGAX points are the displacement
coefficients for each harmonic. The output for the POINTAX degrees of freedom
are the sum of the harmonics giving the physical displacements at the point,
while the output for the SECTAX points are the average displacements over the
circumferential sector. These quantities are available only in SORT1 format.

   The stress output for these elements is similar to that for the TRIARG and
TRAPRG elements described above. However, since the stresses vary around the
circumference, each element output includes the Fourier coefficients of stress
for each harmonic, followed by the stresses at the angular locations specified
on the property card. Stresses are calculated at the centroid of the cross
section on the TRIAAX element. Stresses are calculated at the four corners as
well as at a fifth "grid point" on the TRAPAX element, which is located an
average radius and average length from the four corner points.

1.3.7.3  Data Processing for the CONEAX, TRAPAX, and TRIAAX Axisymmetric Elements
---------------------------------------------------------------------------------
   The data cards submitted by you for the CONEAX, TRAPAX, and TRIAAX
axisymmetric elements are processed by the NASTRAN Preface to produce
equivalent grid point, element connection, constraint, and load data card
images. Each specified harmonic, n, of the Fourier series solution produces a
complete set of these special data card images. In order to retain unique
internal identification numbers for each harmonic, your (or external)
identification numbers are encoded by the following algorithms.

RINGAX Cards

NASTRAN (or internal) grid ID = Your (or external) ring ID + 1,000,000 x n

(n = 1, 2, 3, ..., N, where N = highest harmonic defined on the AXIC card)

CONEAX, TRAPAX, and TRIAAX Connection Cards

NASTRAN (or internal) element ID = Your (or external) element ID x 1,000 + n
(n = 1, 2, 3, ..., N)

   The exact manner in which the above data cards as well as other data cards
for these elements are processed by the NASTRAN Preface is fully described in
Section 4.6.7 of the Programmer's Manual.

   You should use the NASTRAN (or internal) identification numbers (and not
your or external identification numbers) in specifying the data for plotting
purposes. (See, for instance, the description of the SET card in Section
4.2.2.4.)

## 1.3.8  Scalar Elements

   Scalar elements are connected between pairs of degrees of freedom (at
either scalar or geometric grid points) or between one degree of freedom and
ground. Scalar elements are available as springs, masses, and viscous dampers.
Scalar spring elements are useful for representing elastic properties that
cannot be conveniently modeled with the usual metric structural elements.
Scalar masses are useful for the selective representation of inertia
properties, such as occurs when a concentrated mass is effectively isolated
for motion in one direction only. The scalar damper is used to provide viscous
damping between two selected degrees of freedom or between one degree of
freedom and ground. It is possible, using only scalar elements and
constraints, to construct a model for the linear behavior of any structure.
However it is expected that these elements will be used only when the usual
metric elements are not satisfactory. Scalar elements are useful for modeling
part of a structure with its vibration modes or when trying to consider
electrical or heat transfer properties as part of an overall structural
analysis. The reader is referred to Sections 5.5 and 5.6 of the Theoretical
Manual for further discussions on the use of scalar elements.

   The most general definition of a scalar spring is given with a CELAS1 card.
The associated properties are given on the PELAS card. The properties include
the magnitude of the elastic spring, a damping coefficient, and a stress
coefficient to be used in stress recovery. The CELAS2 card defines a scalar
spring without reference to a property card. The CELAS3 card defines a scalar
spring that is connected only to scalar points and the properties are given on
a PELAS card. The CELAS4 card defines a scalar spring that is connected only
to scalar points and without reference to a property card. No damping
coefficient or stress coefficient is available with the CELAS4 card.

   Scalar elements may be connected to ground without the use of constraint
cards. Grounded connections are indicated on the connection card by leaving
the appropriate scalar identification number blank. Since the values for
scalar elements are not functions of material properties, no references to
such cards are needed.

   The CDAMP1, CDAMP2, CDAMP3, and CDAMP4 cards define scalar dampers in a
manner similar to the scalar spring definitions. The associated PDAMP card
contains only a value for the scalar damper.

## 1.3.9  Mass

   Inertia properties are specified directly as mass elements attached to grid
points and indirectly as the properties of matrix structural elements. In
addition, dynamic analysis mass matrix coefficients may be specified that are
directly referred to the global coordinate system. Some portions of the mass
matrix are generated automatically while other portions are not. Mass data may
be assembled according to two different kinds of relationships: lumped mass
assumptions or coupled mass considerations. Additional information on
treatment of inertia properties is given in Section 5.5 of the Theoretical
Manual.

### 1.3.9.1  Lumped Mass

   The partitions of the lumped mass matrix are explained in Section 5.5.3 of
the Theoretical Manual, but to aid you the form is repeated here in Equation
1.

         +                  +       +                  +
         | Scalar | 1st     |       | m      | N       |
         |        | Moment  |       |  ij    |  ij     |
   M =   | -------+-------- |   =   | -------+-------- |            (1)
         | 1st    | 2nd     |       |    T   | I       |
         | Moment | Moment  |       | N      |  ij     |
         +                  +       +  ij              +

   The only portion of the lumped mass matrix that is automatically generated
is the scalar partition. This implies that no first moment and second moment
terms for the lumped mass matrix are automatically generated. In this context,
automatic generation means the calculation of the mass from the structural
elements that are connected to a given grid point, solely from the information
provided on the element connection and property card. All of the metric
structural elements (rods, bars, shear panels, twist panels, plates, and shell
elements) may have uniformly distributed structural and nonstructural mass.
Structural mass is calculated from material and geometric properties. The mass
is assumed to be concentrated in the middle surface, or along the neutral axis
in the case of rods and bars, so that rotary inertia effects, including the
torsional inertia of beams, are absent.

   In the lumped mass method, the mass of an element is simply divided into
equal portions and each portion is assigned to only one of the surrounding
grid points. Thus, for uniform rods and bars, one-half of the mass is placed
at each end; for uniform triangles, one-third of the mass is placed at each
corner; quadrilaterals are treated as two pairs of overlapping triangles (see
the Theoretical Manual Sections 5.3 and 5.8). The lumped mass matrix is
independent of the elastic properties of elements. There are no other
automatic routines for providing mass terms for the lumped mass approach.

### 1.3.9.2  Coupled Mass

   In the coupled mass approach, properties of mass pertaining to a single
structural element include off-diagonal coefficients that couple action at
adjacent grid points. For further amplification of the techniques used in the
coupled mass approach see Section 5.5.3 of the Theoretical Manual. To invoke
the automatic generation of the coupled mass matrix, the parameter COUPMASS is
indicated on the PARAM card. If selected coupled mass properties are desired
only for certain element types, this is obtained by a second parameter call
specifying the element. For further details see the PARAM bulk data card. When
using COUPMASS, the nonzero terms are generated in off-diagonal positions of
the mass matrix corresponding generally to nonzero terms of the stiffness
matrix. This implies that a mass matrix generated by the coupled mass approach
will generally have a density and topology equivalent to that of the stiffness
matrix.

   Off-diagonal mass terms may also be created during Guyan reduction when the
OMIT or ASET bulk data cards are used to condense the stiffness and mass
matrices. Any mass associated with the omitted degrees of freedom will be
redistributed to the remaining degrees of freedom forming a coupled mass
matrix. The use of multipoint constraints (MPC cards) with mass terms on the
dependent degrees of freedom produces a similar effect. The mass on the
dependent coordinate will be transformed to the connected independent
coordinates, thereby coupling them together. Mathematically, these operations
and the element coupled mass formulations described above are closely related.

### 1.3.9.3  Mass Input

   In many cases it may be desired to add mass terms to the structure in
addition to those generated by the structural elements. For instance, in a
lumped mass formulation any additional masses involving rotational degrees of
freedom must be independently calculated and input manually via bulk data
cards.

   The concentrated mass elements CONM1 and CONM2 may be used to add mass
terms directly to a single grid point. The CONM2 element is used to specify a
rigid body with mass and inertia properties that is connected to a single grid
point (offsets are allowed). The CONM1 element has a more general input format
to allow directional mass terms.

   The notation on the CONM1 card is explicit; that is, subscripting of each
term spans the degree of freedom range from 1 through 6. On the CONM2 card,
double subscripting is used only for the second moment partition. Therefore,
the correspondence for symbols between CONM1 entries and CONM2 entries for the
second moment partition is as follows: I11, I21, I22, I31, I32, and I33 on the
CONM2 card (defined in Theoretical Manual section 5.5.2.2 by the integrals of
Equations 13, 14, and 15) correspond to M44, M54, M55, M64, M65, and M66 on
CONM1 (M54 = -Ixy, M64 = -Ixz, M65 = -Iyz) with sign changes on the off-
diagonal terms as shown in Equation 10 of the referenced section. The program
multiplies each cross product of inertia term from CONM2 user data by (-1)
before assembling this data into the mass matrix, to make it correspond to the
requirements of Equation 10.

   An alternative to specifying mass information for the lumped mass method is
to use the CMASSi and the PMASSi cards. This allows the option of treating
mass as finite elements, one degree of freedom at a time. A particularly
advantageous feature of the CMASSi card is the ability to couple mass terms
between grid points and/or scalar points. When dynamic rigid formats are used,
the direct matrix input (DMIG) may be used to supply grid point mass data.
When mass information is entered via DMIG cards, it will remain dormant until
activated by a call from Case Control via the M2PP card.

   When a DMAP sequence is used or a rigid format is ALTERed, another form is
available for presenting mass information via the DMI card. The DMI card is
not recognized as a legitimate source of bulk data for the rigid formats,
unless an ALTER is used.

   In all cases a combination of mass input can be used. For instance, the
translational inertias can be generated automatically by the element routines,
while the first and second moment properties can be provided through CONM2
cards. Some elements can be used to provide coupled mass properties through
the COUPMASS parameter, while other contributions to the same grid points can
be made by direct matrix input through DMIG cards. The information from these
several sources will be summed in the formation of the final mass matrix.

### 1.3.9.4  Output from the Grid Point Weight Generator

   The Grid Point Weight Generator (GPWG) module computes the rigid body mass
properties of an entire structure with respect to your specified point and
with respect to the center of mass.

   Output from the module is requested by a PARAM card in the Bulk Data Deck
which specifies from which grid point mass computations are to be referenced.
Optionally, the absence of a specific grid point automatically causes the
origin of the basic coordinate system to be utilized as a reference. The mass
properties are initially defined in the basic coordinate system. Subsequently,
the mass properties are transformed to principal mass axes and to principal
inertia axes. The actual printout is composed of several elements. These are

1. Title MO - RIGID BODY MASS MATRIX IN BASIC COORDINATE SYSTEM

   This is the rigid body mass matrix of the entire structure in the basic
coordinate system with respect to a reference point chosen by the analyst.

2. Title S - TRANSFORMATION MATRIX FOR SCALAR MASS PARTITION

   S is the transformation from the basic coordinate system to the set of
principal axes for the 3 x 3 scalar mass partition of the 6 x 6 mass matrix.
The principal axes for just the scalar partition are known as the principal
mass axes.

3. Title X-C.G. Y-C.G. Z-C.G.

   It is possible in NASTRAN to assemble a structural model having different
values of mass in each coordinate direction at a grid point. This can arise
for example assembling scalar mass components or from omitting some components
by means of bar element pin flags. Consequently three distinct mass systems
are assembled, one in each of the three directions of the principal mass axes
(the S system). This third tabulation has five columns. The first column lists
the axis direction in the S coordinates. The second column lists the mass
associated with the appropriate axis direction. The final three columns list
the x, y, and z coordinate distances from the reference point to the center of
mass for each of the three mass systems.

4. Title I(S) - INERTIAS RELATIVE TO C.G.

   This is the 3 x 3 mass moment of inertia partition with respect to the
center of gravity referred to the principal mass axes (the S system). This is
not necessarily a diagonal matrix because the determination of the S system
does not involve second moments. The values of inertias at the center of
gravity are found from the values at the reference point by employing the
parallel axes rule.

5. Title I(Q) - PRINCIPAL INERTIAS

   The principal moments of inertia at the center of gravity are displayed in
matrix form with reference to the Q system of axes. The Q system is obtained
from an eigenvalue analysis of the I(S) matrix.

6. Title Q - TRANSFORMATION MATRIX --I(Q) = QT*I(S)*Q

   Q is the coordinate transformation between the S axes and the Q axes.


### 1.3.9.5  Bulk Data Cards for Mass

   A summary chart is given in Table 1.3-1 to help in the selection of the
method of input for a given type of mass information. Descriptions of
individual cards for the entering of mass information into the bulk data are
listed here:

1. Element data from the combined sources of C(-), P(-), and MATi cards will
automatically cause the translational mass (scalar) terms of the mass matrix
to be generated, provided a density value and/or a nonstructural density
factor is entered.

2. The MASSi cards define scalar masses. CMASSi cards define connections
between a pair of degrees of freedom (at either scalar or geometric grid
points) or between one degree of freedom and ground. Thus, f1 = m(x1 - x2)
where x2 may be absent. The CMASS1 cards (i = 1 through 4) are necessary
whenever scalar points are used. PMASSi cards define mass property magnitudes.
Other applications include selective representations of inertia properties,
such as occur in shell theory where in-plane inertia forces are often ignored.

3. The CONM2 card defines the properties of a solid body: m, its mass, x1, x2,
x3, the three coordinates of its center of gravity offset with respect to the
grid point, I11, I22, I33, its three moments of inertia, and I12, I13, I23,
and its three products of inertia, all with respect to any (selected)
coordinate system. If a local cylindrical or a spherical coordinate system is
chosen to define the mass properties, the offset distances of the mass c.g.
from the grid point are measured along the axes (r, �, z or p, �, �) defined
at the grid point in that local system. Also note, that the mass properties of
inertia are computed relative to a set of axes at the mass c.g. which are
parallel to those r, �, z or p, �, � axes at that grid point. The CONM2
element routine uses the parallel axis theorem to transform inertias with
respect to the center of gravity to inertias with respect to the grid point.
Section 5.5.2.1 of the Theoretical Manual describes how to treat the signs of
cross products of inertia terms on CONM2 cards.

4. The CONM1 card defines a 6 x 6 matrix of mass coefficients at a geometric
grid point in any selected coordinate system. Since the only restrictions are
that the matrix be real and symmetric, there are 21 possible independent
coefficients. The CONM1 card therefore permits somewhat more general inertia
relationships than those of a solid body which has only 10 independent inertia
properties. This should be remembered in applications requiring unique centers
of gravity, such as in the calculation of centrifugal forces. See Section
5.5.2.5 of the Theoretical Manual for a discussion of inertia properties
resulting from CONM1 card input.

5. The DMIG (or DMIGAX for axisymmetric structures) card accommodates matrix
entries by grid point and component. This is a general card that can be used
for mass, stiffness, or damping matrices. It becomes particularized to mass
when the name given to the matrix is called by an M2PP card in Case Control.
Data defined by this card will be recognized as admissible only when used with
dynamic rigid formats 7 through 12.

6. The DMI card is used to assign values according to row-column positions in
a matrix. This is a general card for any kind of matrix which becomes
particularized to mass when the name given to the matrix is called from a DMAP
statement. Data defined by this card will be recognized as admissible only
when used in a DMAP sequence or in an ALTER to a rigid format.

7. The COUPMASS entry on the PARAM card will activate the "consistent" mass
matrix algorithms in the element routines which generate mass coupling
properties between grid points. There are three options available to regulate
whether the coupling properties are generated for all or some types of
elements (see PARAM bulk data card). A set of entries for a second PARAM card
of the form CP(element name) is available for use in connection with COUPMASS
for selecting the element types for which coupling terms will be computed.

8. The OMIT (or OMIT1, or OMITAX for axisymmetric structures, or ASET for
obverse operations) card will cause the initially-generated mass matrix to be
condensed from the omitted degrees of freedom to the remaining degrees of
freedom. The condensing process generally produces a mass term in every matrix
position in which there is a nonzero stiffness term in the corresponding
reduced stiffness matrix.

9. The GRDPNT entry on the PARAM card will activate the Grid Point Weight
Generator (GPWG) module previously discussed. It will treat the mass
properties of the entire structure as though the structure were rigid and it
will determine the translational (scalar) mass properties, the first and
second moment properties of the rigid body structure, and the center of
gravity distances with respect to your specified reference grid points. It
also computes the 6 x 6 matrix of mass properties with respect to the center
of mass and the orientation of the principal mass axes.

Table 1.3-1. Bulk Data Card Choices for Mass Properties Versus Method of Mass 
Representation. 

--------------+---------------------------------------------------------------
              |                   Representation Method
              +-------------------------------+-------------------+-----------
              |           Lumped              |      Coupled      | Grid
              +----------+--------------------+-----------+-------+ Point
              |Automatic |       Manual       | Automatic | Manual| Weight
              |          +-----+------+-------+           |       | Generator
              |          |All  | R.F.s| DMAP  |           |       | (Total
              |          |R.F.s| 7,8,9| or R.F|           |       |  Structure)
Mass Property |          |     |      | ALTER |           |       |
--------------+----------+-----+------+-------+-----------+-------+------------
Translational |Element   |MASSi|MASSi |DMI    |PARAM      |DMIG   |PARAM GRDPNT
Mass (Scalar) |Routines  |CONM1|CONM1 | |     |COUPMASS + |DMIGAX |     |
              |C (elem.)+|CONM2|CONM2 | |     |PARAM CP   |  |    |     |
              |P (elem.)+|  |  |DMIG  | |     |(element)  |  |    |     |
              |MATi      |  |  |DIMGAX| |     |OMIT       |  |    |     |
              |for struct|  |  |   |  | |     |OMIT1      |  |    |     |
              |and non-  |  |  |   |  | |     |OMITAX     |  |    |     |
              |struct.   |  |  |   |  | |     |ASET       |  |    |     |
              |contribs. |  |  |   |  | |     |    |      |  |    |     |
--------------+----------+  |  |   |  | |     |    |      |  |    |     |
First Moment  |          |  |  |   |  | |     |    |      |  |    |     |
--------------+----------+  |  |   |  | |     |    |      |  |    |     |
Second Moment*|          |  |  |   |  | |     |    |      |  |    |     |
--------------+----------+-----+------+-------+    |      |  |    +------------
All Order     |                               |    |      |  |    |
Moments and   |                               |    |      |  |    |
Off-Diagonal  |                               |    |      |  |    |
Properties    |                               |    |      |  |    |
Between       |                               |    |      |  |    |
Grid Points   |                               |    |      |  |    |
--------------+-------------------------------+-----------+-------+

* No torsional moment of inertia is generated for BAR elements when COUPMASS
and CPBAR are specified. Also, in the case of plate elements, no second moment
properties are computed with respect to the axis normal to the elements.

1.3.10  Solid Polyhedron Elements
---------------------------------
   Three types of solid polyhedron elements are provided for the general solid
structures (see Section 1.3.7 for axisymmetric structures with axisymmetric
loads). These elements (see Figure 1.3-12) are a tetrahedron, a wedge, and a
hexahedron. The theory is given in Section 5.12 of the Theoretical Manual.
These elements can be used with all other NASTRAN elements, except the
axisymmetric elements. Connections are made only to displacement degrees of
freedom at the grid points.

   The elements are defined by CTETRA, CWEDGE, CHEXA1, and CHEXA2 connection
cards. You should specify grid locations such that the quadrilateral faces are
nearly planar. No special element coordinate system is required. The only
properties required are material properties; thus no PID card is referenced;
direct reference is made to a MID card. For thermal stress problems, the
temperature is assumed to be the average of the connected grid points.
Differential stiffness, buckling, and piecewise linear analyses have not been
implemented.

   The output stresses are given in the basic coordinate system. In addition
to the six normal and shear stresses, output also includes the pressure

   po = - 1/3 (+x + +y + +z)

and the octahedral stress

                      2            2            2       2       2       2 1/2
   +o  = 1/3[(+x - +y)  + (+y - +z)  + (+z - +x)  + 6�yz  + 6�zx  + 6�xy )

The stresses in the tetrahedra are constant. The stresses in the wedge and the
hexahedron are obtained as the weighted average of the stresses in the
subtetrahedra. The weighting factor for each tetrahedron is proportional to
its volume.

## 1.3.11  Isoparametric Solid Hexahedron Elements

   Three types of isoparametric solid hexahedron elements are provided for
general solid structures. These elements (see Figure 1.3-13) are a linear, a
quadratic, and a cubic isoparametrIc hexahedron. The theory is given in
Section 5.13 of the Theoretical Manual. These elements can be used with all
other NASTRAN elements, except the axisymmetric elements. Connections are made
only to the translational degrees of freedom at the grid points. The elements
are defined by CIHEX1, CIHEX2, and CIHEX3 connection cards. All three of these
cards reference the PIHEX property card. These elements may use anisotropic
materials by reference to a MAT6 card on the PIHEX card.

   The isoparametric solid hexahedron elements allow you to accurately define
a structure with fewer elements and grid points than might otherwise be
necessary with simple constant strain solid elements. The linear element
generally gives best results for problems involving mostly shear deformations,
and the higher order elements give good results for problems involving both
shearing and bending deformations. Only a coupled mass matrix is generated to
retain the inherent accuracy of the elements. Temperature, temperature-
dependent material properties, displacements, and stresses may vary through
the volume of the elements. The values at interior points of the element are
interpolated using the isoparametric shape function. For best results, the
applied grid point temperatures should not have more than a "gentle" quadratic
variation in each of the three dimensions of the element. If the element has
non-uniform applied temperatures, or if it is not a rectangular
parallelopiped, three or more integration points should be specified on the
PIHEX card. Severely distorted element shapes should be avoided.

   Stiffness, mass, differential stiffness, structural damping, conductance,
and capacitance matrices may be generated with these elements. Piecewise
linear analysis has not been implemented.

   The output stresses are given in the basic coordinate system. The stresses
are assumed to vary through the element. Therefore, stresses are computed at
the center and at each corner grid point of these elements. For the quadratic
and cubic elements, they are also computed at the mid-point of each edge of
the element. In addition to the six normal and shear stresses, output also
includes the principal stresses (Sx, Sy, and Sz), the direction cosines of the
principal planes, the mean stress

   +n = - 1/3 (+x + +y + +z)

and the octahedral shear stress

                      2            2            2  1/2
   +o = {1/3[(Sx + +n)  + (Sy + +n)  + (Sz + +n) ]}

## 1.3.12  Shallow Shell Element

   A higher order shallow triangular shell element (TRSHL) formulated from the
TRIM6 and TRPLT1 elements is available. The inplane and bending properties are
coupled and the geometry of the element may be curved. If the element is flat
and either the inplane or bending properties are negligible, the element
degenerates to the TRPLT1 or TRIM6 element, respectively.

   The element has grid points at the vertices and at the midpoints of the
sides of the triangle (see Figure 1.3-14). At each grid point, there are five
degrees of freedom in the element coordinate system: that is, the membrane
displacements, u and v, parallel to the x and y axes, the transverse
displacement, w, in the z-direction normal to the x-y plane (with positive
direction outward from the paper) and the rotations of the normal to the
shell, + and +, about the x-z and y-z planes (with positive directions
following from the right-hand rule). The element, thus, has 30 degrees of
freedom in the element coordinate system.

   The membrane displacements, u and v, for the shell are expressed as
quadratic polynomials and are the same as for the higher order membrane
triangular element, TRIM6. The displacement function for the normal
deflection, w, is taken as a quintic polynomial as in the higher order bending
triangular element, TRPLT1. The geometry of the shell surface is approximated
by a quadratic polynomial in basic coordinates. Shallow shell theory is used
to include the membrane-bending coupling effects. Thus, the element should be
used only in cases where the shell is truly shallow. However, reasonably good
accuracy is seen even when the elements are used to analyze shells that are
only marginally shallow. You are cautioned, however, to be careful while
interpreting results obtained when the shell analyzed is very deep. Due to the
excessive computation time associated with such calculations, the transverse
shear flexibility is not taken into account in the element formulation.
Further discussion of this element is treated in Section 5.14 of the
Theoretical Manual.

   The connectivity of this element is described by a CTRSHL card and the
properties are defined by a PTRSHL card. The element may be used in the
statics, normal modes, and differential stiffness rigid formats. Loads may be
mechanical or thermal.

   Element forces per unit width are output for the following quantities:

   -  Bending moments on the x and y faces

   -  Twisting moment

   -  Shear forces on the x and y faces

The element forces are calculated at the three corners and the centroid. The
sign conventions for these forces are the same as previously discussed in
Section 1.3.5.

   Stresses are output for the following quantities:

   -  Normal stresses in the x and y directions

   -  Shear stress on the x face in the y direction

   -  Angle between the x-axis and the major principal axis

   -  Major and minor principal stresses (zero shear)

   -  Maximum shear stress

The stresses will be calculated at the specified fiber distances from the
elastic axis defined on the property card and are always calculated at the top
and bottom fibers for the centroid of the element. The sign conventions for
the stresses are the same as previously discussed in Section 1.3.5.

                               y  b(grid) x
                               |I2=Iyy | /
                               |     wb|/b(end)
                               |Plane 1/
                               | V1/| /
(a) Element coordinate         |  / |/
    system                     | /  /---
                               |/  /   /Plane 2
                               |  /   /
                               | /   /
                         wa    |/   /
                        -------+-----------------z
                      a(grid)  a(end)     I1=Izz



                            y                    v1
                            |                    |
                            |                    |
                            |                    |
               M1a (inplane)+-----------------+  |  M1b (inplane)
            Fx ----------+  +-----------------+--+-----------------x
               T (CCW    |  +-----------------+        Fx    T (CCW
                 about x)|  a     Plane 1     b                 about Tx)
                         v1



                            z                    v2
(b) Element forces          |                    |
                            |                    |
                            |                    |
               M2a (inplane)+-----------------+  |  M2b (inplane)
               ----------+  +-----------------+--+-----------------x
                         |  +-----------------+
                         |        Plane 2
                         v2


        Figure 1.3-1. Bar element coordinate system and element forces

                   P                        P
                 <----                    ---->
              -------------------------------------- x
               T     a                    b       T (clockwise about x)
               (counterclockwise
                about x)

        Figure 1.3-2. Rod element coordinate system and element forces

                              y
                              |
                              |
                              |4            3
                              +-------------+
  (a) Coordinate system       |             |
                              |             |
                              |             |
                              |             |
                              +-------------+-----x
                               1            2



                            K4                 K3
                               \ F41              \ F32
                                \|      -----q3    \|
                            F43--+------------------+--F34
                                 |4                3|
                                 |                  |
  (b) Corner forces and          |                  |
      shear flows              | |                  | q2
                               | |                  | |
                              q4 |                  | |
                                 |                  |
                            K1   |             K2   |
                               \ |                \ |
                                \|                 \|
                            F12--+------------------+--F21
                                 | 1     q1----     | 2
                                 F14                F23


Figure 1.3-3. Coordinate system and element forces for shear panel and CQDMEM2
elements

                              y         M13
                              |          \
                              |           \
                              |4           \ 3
                              +-------------+    M24
                             /|             |   /
                            / |             |  /
                           /  |             | /
                       M24    |             |/
                              +-------------+-----x
                             1 \            2
                                \
                                 \
                                    M13


        Figure 1.3-4. Twist panel coordinate system and element forces

                              y
                              |
                             3|\
                              | \
                              |  \
                              |   \
                              |    \
                              |     \
                              |      \
                              |       \
                              |        \
                              |   /     \
                              |  /       \
                              | / �       \
                              +-------------------x
                               1           2

                                       (a)



                              y
                              |
                              |
                             4+---------------+3
                              |               |
                              |               |
                              |               |
                              |   /           |
                              |  /            |
                              | / �           |
                              +---------------+---x
                               1              2

                                       (b)


          Figure 1.3-5. Plate and membrane element coordinate systems

                                            Vy
                                            |
                                            |
  (a) Plate element forces                  +-----My
                                           /
                                 y        /
                                /       Mxy
                        Mx     /
                       /      -------------------+
                      /      /                  /|
                     /      /                  / |
             Mxy----+   z  /                  / /        Vx
                    |   | /                  / /         |
                    |   |/                  / /          |
                   Vx   +------------------+ /           +-----Mxy
                        |                  |/----x      /
                        +------------------+           /
                                                     Mx
                               Mxy
                              /
                             /
                            /
                     My----+
                           |
                           |
                          Vy



                                        +
                                         y
                                        |
                                       -+--- �
  (b) Membrane element stresses               xy
                                    +-------+
                                    |       |  |
                            + ---+  |       |  +--- +
                             x   |  |       |        x
                                �   |       |
                                 xy +-------+

                                     ---+-
                                        |
                                        +
                                         y


       Figure 1.3-6. Forces and stresses in plate and membrane elements

                             z          uz - displacement coordinates
                             |          |
                             |          |�z (rotation)
                             |    u�    |    ur
                             |      \   |   /
                             |     ��\  |  /�r (rotation)
                             |(rotat.)\ | /
                             |         \|/
                             |          /
                             |         /
                             |        /
                             |    RB /
                             |      /
                             |     /
                             |    /    /
                             |   /    /
                             |  /    /
                             | /    /
                             |/�   / RA
                             +----/
                             |   /
                             |  /
                             | /
                             |/�
                             +----

               Figure 1.3-7. Geometry for conical shell element

               This figure is not included in the machine readable
               documentation because of complex graphics.

             Figure 1.3-8. Toroidal ring element coordinate system

               This figure is not included in the machine readable
               documentation because of complex graphics.

                  Figure 1.3-9. Stresses for toroidal element

         z,w,Fz
           |
           |
           |                          3
           |                          /\
           |                         /  \
           |                        /    \
           |                       /      \   w2,Fz2
           |                      /        \  |
           |                     /          \ |
  Axis of  |                    /            \|
  symmetry |                    --------------+-------u2,Fr2
           |                   1              2
           |
           |
           |
           |
           |
           |    /
           |   /
           |  /
           | /
           |/ � (Material orientation)
           +------------------------------------------------------------r,u,Fr

           Figure 1.3-10. Triangular ring element coordinate system

          z,w
           |
           |
           |
           |                       4    Z3=Z4      3
           |                        ---------------
           |                       /              /
           |                      /              /
           |                     /              /
           |                    /              /
  Axis of  |                   /              /
  symmetry |                   ---------------
           |                  1    Z1=Z2      2
           |
           |
           |
           |
           |
           |    /
           |   /
           |  /
           | /
           |/ � (Material orientation)
           +------------------------------------------------------------r,u

           Figure 1.3-11. Trapezoidal ring element coordinate system

                                         G4
                                         *
  (a) Tetrahedron                       /|\
                                       / | \
                                      /  |  \
                                     /   |   \
                                  G1*    |    \
                                    \ .  |     \
                                     \  .|      \
                                      \  | .     \
                                       \ |    .   \
                                         *---------*
                                        G2          G3



                                     G4_____G6
                                      /\   /\
  (b) Wedge and one of its           /  \ /  \
      six decompositions            /    *G5  \
                                 G1*- - -|- - -*G3
                                    \    |    /
                                     \   |   /
                                      \  |  /
                                       \ | /
                                         *
                                         G2


                                         G6
                                         *
                                        /|\
                                       / | \
                                      /  |  \
                                     /   |   \
                                  G1*    |    \
                                    \ .  |     \
                                     \  .|      \
                                      \  | .     \
                                       \ |    .   \
                                         *---------*
                                        G2          G3



                         G8                            G7
  (c) Hexahedron         *-----------------------------*
                        /|                            /|
                       /                             / |
                      /  |                          /  |
                     /                          G6 /   |
                  G5*-----------------------------*    |
                    |    *G4_ _ _ _ _ _ _ _ _ _ _ |_ _ *G3
                    |    /                        |    /
                    |                             |   /
                    |  /                          |  /
                    |                             | /
                    |/                            |/
                  G1*-----------------------------*G2


          Figure 1.3-12. Polyhedron elements and their subtetrahedra

                         7                             6
                         *-----------------------------*
  (a) Linear            /|                            /|
                       /                             / |
                      /  |                          /  |
                     /                           5 /   |
                   8*-----------------------------*    |
                    |    *3 _ _ _ _ _ _ _ _ _ _ _ |_ _ *2
                    |    /                        |    /
                    |                             |   /
                    |  /                          |  /
                    |                             | /
                    |/                            |/
                   4*-----------------------------*1



                         17            16              15
                         *-------------*---------------*
  (b) Quadratic         /                             /|
                       / |                         14* |
                    18*  *11                        /  |
                     /   |         20           13 /   *10
                  19*--------------*--------------*    |
                    |    *5 _ _ _ _ _ _*_ _ _ _ _ |_ _ *3
                    |    /             4          |    /
                  12*   *6                        *9  /
                    |  /                          |  *2
                    | /                           | /
                    |/                            |/
                    *-------------*---------------*
                    7             8               1



                         27       26        25         24
                         *--------*---------*----------*
  (c) Cubic           28*|                            /|
                       / *19                       23* *18
                    29*  |                          /  |
                     /   *15 31      32          22*   *14
                  30*--------*-------*------------*21  |
                    |    *7 _ _ *6_ _ _ _*5 _ _ _ |_ _ *4
                  20*    /                      17*    /
                    |   *8                        |   *3
                  16*  /                        13*  /
                    | *9                          | *2
                    |/                            |/
                    *--------*---------*----------*1
                    10       11        12


            Figure 1.3-13. Isoparametric solid hexahedron elements

                                   *G5
                                  / \
                           ye    /   \      .
                           |    /     \  .
                           | G6*      .*G4
                           |  /    .    \
                           | /  .    TH  \
                           |/.            \
                           *- - - -*- - - -* -------xe
                           G1      G2      G3

Figure 1.3-14. Triangular shallow shell element geometry and coordinate systems


# 1.4  CONSTRAINTS AND PARTITIONING

   Structural matrices are initially assembled in terms of all structural grid
points, which excludes only the extra scalar points introduced for dynamic
analysis. These matrices are generated with six degrees of freedom for each
geometric grid point and a single degree of freedom for each scalar point.
Various constraints are applied to these matrices in order to remove undesired
singularities, provide boundary conditions, define rigid elements, and provide
other desired characteristics for the structural model.

   There are two basic kinds of constraints. Single-point constraints are used
to constrain a degree of freedom to zero or to a prescribed value; multipoint
constraints and rigid elements are used to constrain one or more degrees of
freedom to be equal to linear combinations of the values of other degrees of
freedom. The following types of bulk data cards are provided for the
definition of constraints:

   1. Single-point constraint cards

   2. Multipoint constraint cards and rigid element connection cards

   3. Cards to define reaction points on free bodies

   4. Cards to define the omitted coordinates in matrix partitioning

The latter type does not produce constraint forces in static analysis.

## 1.4.1  Single-Point Constraints

   A single-point constraint applies a fixed value to a translational or
rotational component at a geometric grid point or to a scalar point. One of
the most common uses of single-point constraints is to specify the boundary
conditions of a structural model by fixing the appropriate degrees of freedom.
Multiple sets of single-point constraints can be provided in the Bulk Data
Deck, with selections made at execution time by using the subcase structure in
the Case Control Deck as explained in Section 2.3.3. This procedure is
particularly useful in the solution of problems having one or more planes of
symmetry.

   The elements connected to a grid point may not provide resistance to motion
in certain directions, causing the stiffness matrix to be singular.
Single-point constraints are used to remove these degrees of freedom from the
stiffness matrix. A typical example is a planar structure composed of membrane
and extensional elements. The translations normal to the plane and all three
rotational degrees of freedom must be constrained since the corresponding
stiffness matrix terms are all zero. If a grid point has a direction of zero
stiffness, the single-point constraint need not be exactly in that direction,
but only needs to have a component in that direction. This allows the use of
single-point constraints for the removal of such singularities regardless of
the orientation of the global coordinate system. Although the displacements
will depend on the direction of the constraint, the internal forces will be
unaffected.

   One of the tasks performed by the Structural Matrix Assembler (Section 4.27
of the Programmer's Manual) is to examine the stiffness matrix for
singularities at the grid point level. An input NASTRAN card entry STST, to
control the tolerance, is available. Singularities remaining at this level,
following the application of the single-point constraints, are listed in the
Grid Point Singularity Table (GPST). This table is automatically printed
following the comparison of the possible singularities tabulated by the
Structural Matrix Assembler with the single-point constraints and the
dependent coordinates of the multipoint constraint equations provided by you.
The GPST contains all possible combinations of single-point constraints, in
the global coordinate system, that can be used to remove the singularities.
These remaining singularities are treated only as warnings, because it cannot
be determined at the grid point level whether or not the singularities are
removed by other means, such as general elements or multipoint constraints in
which these singularities are associated with independent coordinates. See the
GPSPC module description in Section 5.10 for automatic removal of
singularities.

   Single-point constraints are defined on SPC, SPC1, SPCADD, and SPCAX cards.
The SPC card is the most general way of specifying single-point constraints.
The SPC1 card is a less general card that is more convenient when a number of
grid points have the same components constrained to a zero displacement. The
SPCADD card defines a union of single-point constraint sets specified with SPC
or SPC1 cards. The SPCAX card is used only for specifying single-point
constraints in problems using conical shell elements.

   Single-point constraints can also be defined on the GRID card. In this
case, however, the constraints are part of the model and modifications cannot
be made at the subcase level. Also, only zero displacements can be specified
on the GRID card.

## 1.4.2  Multipoint Constraints and Rigid Elements

   Multipoint constraints and rigid elements are used to constrain one or more
degrees of freedom to be equal to linear combinations of the values of other
degrees of freedom. In the former case, you must explicitly provide the
coefficients of the equations. In the latter case, you provides only the
connection data and the program internally generates the required
coefficients.

### 1.4.2.1  Multipoint Constraints

   Each multipoint constraint is described by a single equation that specifies
a linear relationship for two or more degrees of freedom. Multiple sets of
multipoint constraints can be provided in the Bulk Data Deck, with selections
made at execution time by using the subcase structure in the Case Control Deck
as explained in Section 2.3.3. Multipoint constraints are discussed in
Sections 3.5.1 and 5.4 of the Theoretical Manual.

   Multipoint constraints are defined on MPC, MPCADD, and MPCAX cards. The MPC
card is the basic card for defining multipoint constraints. The first
coordinate mentioned on the card is taken as the dependent degree of freedom,
i .e., that degree of freedom that is removed from the equations of motion.
Dependent degrees of freedom may appear as independent terms in other
equations of the set; however, they may appear as dependent terms in only a
single equation. The MPCADD card defines a union of multipoint constraint sets
specified with MPC cards. The MPCAX card is used only for specifying
multipoint constraints in problems using conical shell elements. Some uses of
multipoint constraints are:

   1. To enforce zero motion in directions other than those corresponding with
      components of the global coordinate system. In this case, the multipoint
      constraint will involve only the degrees of freedom at a single grid
      point. The constraint equation relates the displacement in the direction
      of zero motion to the displacement components in the global system at
      the grid point.

   2. To describe rigid elements and mechanisms such as levers, pulleys, and
      gear trains. In this application, the degrees of freedom associated with
      the rigid element that are in excess of those needed to describe rigid
      body motion are eliminated with multipoint constraint equations.
      Treatment of very stiff members as being rigid elements eliminates the
      ill-conditioning associated with their treatment as ordinary elastic
      elements.

   3. To be used with scalar elements to generate nonstandard structural
      elements and other special effects.

   4. To describe parts of a structure by local vibration modes. This
      application is treated in section 14.1 of the Theoretical Manual. The
      general idea is that the matrix of local eigenvectors represents a set
      of constraints relating physical coordinates to modal coordinates.

   You provide the coefficients in the multipoint constraint equations defined
on MPC, MPCADD, and MPCAX cards.

### 1.4.2.2  Rigid Elements

   Rigid elements provide a convenient means of specifying very stiff
connections. You do not provide the required coefficients directly. The
program internally generates them from the connection data. Rigid elements are
discussed in Section 3.5.6 of the Theoretical Manual.

   Rigid elements are defined on CRIGDR, CRIGD1, CRIGD2, and CRIGD3 cards. The
CRIGDR card defines a pin-ended rod element that is rigid in
extension-compression. The CRIGD1 card defines a rigid element connection in
which all six degrees of freedom of each of the dependent grid points are
coupled to all six degrees of freedom of the reference grid point. The CRIGD2
card is more general and defines a connection in which selected degrees of
freedom of the dependent grid points are coupled to all six degrees of freedom
of the reference grid point. The CRIGD3 card is the most general and defines a
rigid element in which selected degrees of freedom of the dependent grid
points are coupled to six selected degrees of freedom at one or more (up to
six) reference grid points.

   On all of the rigid element connection cards, you specify the degrees of
freedom that belong to the dependent set. This specification is implicit on
the CRIGD1 card and explicit on the others. It is important to note that a
dependent degree of freedom appearing in a rigid element may not appear as
dependent in any other rigid element or on a MPC card nor may it be
constrained in any other manner. Also, when using the CRIGD3 card, you must
ensure that the six selected degrees of freedom at the reference grid points
together are capable of representing any general rigid body motion of the
element.

   When using several rigid elements and multipoint constraints, you will
often find it useful to turn on DIAGs 21 and 22 in the Executive Control Deck
to obtain the GP4 definition of sets of degrees of freedom.

## 1.4.3  Free Body Supports

   In the following discussion, a free body is defined as a structure that is
capable of motion without internal stress; that is, it has one or more rigid
body degrees of freedom. The stiffness matrix for a free body is singular with
the defect equal to the number of stress-free, or rigid body, modes. A solid
three-dimensional body has up to six rigid body modes. Linkages and mechanisms
can have a greater number. No restriction is placed in the program on the
number of stress-free modes, in order to permit the analysis of mechanisms.

   Free-body supports are defined with a SUPORT card. In the case of problems
using conical shell elements, the SUPAX card is used. In either case, only a
single set can be specified, and if such cards appear in the Bulk Data Deck,
they are automatically used in the solution. Free-body supports must be
defined in the global coordinate system.

   In static analysis by the displacement method, the rigid body modes must be
restrained in order to remove the singularity of the stiffness matrix. The
required constraints may be supplied with single-point constraints, multipoint
constraints, or free-body supports. If free-body supports are used, the rigid
body characteristics will be calculated and a check will be made on the
sufficiency of the supports. Such a check is obtained by calculating the rigid
body error ratio as defined in the Rigid Body Matrix Generator operation in
Section 3.2.2. This error ratio is automatically printed following the
execution of the Rigid Body Matrix Generator. The error ratio should be zero,
but may be nonzero for any of the following reasons:

   1. Round-off error accumulation

   2. Insufficient free-body supports have been provided

   3. Redundant free-body supports have been provided

   The redundancy of the supports may be caused by improper use of the
free-body supports themselves, or by the presence of single-point or
multipoint constraints that constrain the rigid body motions.

   Static analysis with inertia relief is necessarily made on a model having
at least one rigid body motion. Such rigid body motion must be constrained by
the use of free-body supports. These supported degrees of freedom define a
reference system, and the elastic displacements are calculated relative to the
motion of the support points. The element stresses and forces will be
independent of any valid set of supports.

   Rigid body vibration modes are calculated by a separate procedure provided
that a set of free-body supports is supplied by you. This is done to improve
efficiency and, in some cases, reliability. The determinant method, for
example, has difficulty extracting zero frequency roots of high multiplicity,
whereas the alternate procedure of extracting rigid body modes is both
efficient and reliable. If you do not specify free-body supports (or you
specify an insufficient number of them) the (remaining) rigid body modes will
be calculated by the method selected for the finite frequency modes, provided
zero frequency is included in the range of interest. If you do not provide
free-body supports, and if zero frequency is not included in the range of
interest, the rigid body modes will not be calculated.

   Free-body supports must be specified if the mode acceleration method of
solution improvement is used for dynamics problems having rigid body degrees
of freedom (see Section 9.4 of the Theoretical Manual). This solution
improvement technique involves a static solution, and although the dynamic
solution can be made on a free-body, the static solution cannot be performed
without removing the singularities in the stiffness matrix associated with the
rigid body motions.

## 1.4.4  Partitioning

   A two-way partitioning scheme is provided as an optional feature for the
NASTRAN model. The partitions are defined by listing the degrees of freedom
for one of the partitions on the OMIT card. These degrees of freedom are
referred to as the "omitted set". The remaining degrees of freedom are
referred to as the "analysis set". The OMIT1 card is easier to use if a large
number of grid points have the same degrees of freedom in the omitted set. The
ASET or ASET1 cards can be used to place degrees of freedom in the analysis
set with the remaining degrees of freedom being placed in the omitted set.
This is easier if the omitted set is large. In the case of problems using
conical shell elements, the OMITAX card is used.

   Partitioning can be used to improve the efficiency in the solution of
ordinary statics problems where the bandwidth of the unpartitioned stiffness
matrix is large enough to cause excessive use of secondary storage devices
during the triangular decomposition of the stiffness matrix. In this
application, the analysis set should be relatively small and should be
selected so that the omitted set will consist of uncoupled partitions, each
having a bandwidth of approximately the same size and smaller than the
original matrix. The omitted set might be thought of as consisting of several
substructures which are coupled to the analysis set.

   Matrix partitioning also improves efficiency when solving a number of
similar cases with stiffness changes in local regions of the structure. In
this application, the omitted set is relatively large, and should be selected
so that the structural elements that will be changed are connected only to
points in the analysis set. The stiffness matrix for the omitted set is then
unaffected by the structural changes, and only the smaller stiffness matrix
for the analysis set need be decomposed for each case. In order to avoid
repeating the decomposition of the stiffness matrix for the omitted set, the
alter feature must be used to replace the functional module SMP1 with SMP2.
The alter feature is described in Section 2.2, and a similar use of SMP2
occurs near the end of the DMAP sequence used in the rigid format for Static
Analysis with Differential Stiffness.

   One of the more important applications of partitioning is the Guyan
Reduction, described in Section 3.5.4 of the Theoretical Manual. This
technique is a means for reducing the number of degrees of freedom used in
dynamic analysis with minimum loss of accuracy. Its basis is that many fewer
grid points are needed to describe the inertia of a structure than are needed
to describe its elasticity with comparable accuracy. The error in the
approximation is small provided that the set of displacements used for dynamic
analysis is judiciously chosen. Its members should be uniformly dispersed
throughout the structure and all large mass items should be connected to grid
points that are members of the analysis set.

   You are cautioned to consider the fact that the matrix operations
associated with this partitioning procedure tend to create nonzero terms and
to fill what were previously very sparse matrices. The partitioning option is
most effectively used if the members of the omitted set are either a very
large fraction or a very small fraction of the total set. In most of the
applications the omitted set is a large fraction of the total and the matrices
used for analysis, while small, are usually full. If the analysis set is not a
small fraction of the total, a solution using the larger, but sparser,
matrices, may well be more efficient. The partitioning option can also be used
to make modest reductions in the order of the problem by placing a few
scattered grid points in the omitted set. If the points in the omitted set are
uncoupled, the sparseness in the matrices will be well preserved.

## 1.4.5  The Nested Vector Set Concept Used to Represent Components of Displacement

   In constructing the matrices used in the displacement approach, each row
and/or column of a matrix is associated closely with a grid point, a scalar
point, or an extra point. Every grid point has 6 degrees of freedom associated
with it, and hence 6 rows and/or columns of the matrix. Scalar and extra
points only have one degree of freedom. At each point (grid, scalar, extra)
these degrees of freedom can be further classified into subsets, depending on
the constraints or handling required for particular degrees of freedom. (For
example, in a two-dimensional problem, all "z" degrees of freedom are
constrained and hence belong to the s (single-point constraint) set). Each
degree of freedom can be considered as a "point", and the entire model is the
collection of these one-dimensional points.

   Nearly all of the matrix operations in displacement analysis are concerned
with partitioning, merging, and transforming matrix arrays from one subset of
displacement components to another. All the components of displacement of a
given type (such as all points constrained by single-point constraints) form a
vector set that is distinguished by a subscript from other sets. A given
component of displacement can belong to several vector sets. The mutually
exclusive vector sets, the sum of whose members are the set of all physical
components of displacements, are as follows:

   um points eliminated by multipoint constraints and rigid elements,

   us points eliminated by single-point constraints,

   uo points omitted by structural matrix partitioning,

   ur points to which determinate reactions are applied in static analysis,

   ul the remaining structural points used in static analysis (points left
      over),

   ue extra degrees of freedom introduced in dynamic analysis to describe
      control systems, etc.

   The vector sets obtained by combining two or more of the above sets are (+
sign indicates the union of two sets):

   ua = ur + ul, the set used in real eigenvalue analysis,

   ud = ua + ue, the set used in dynamic analysis by the direct method,

   uf = ua + uo, unconstrained (free) structural points,

   un = uf + us, all structural points not constrained by multipoint
   constraints,

   ug = un + um, all structural (grid) points including scalar points,

   up = ug + ue, all physical points.

   In dynamic analysis, additional vector sets are obtained by a modal
transformation derived from real eigenvalue analysis of the set ua. These are:

   �o rigid body (zero frequency) modal coordinates,

   �f finite frequency modal coordinates,

   �i = �o + �f, the set of all modal coordinates.

   One vector set is defined that combines physical and modal coordinates.
That set is uh = �i + ue, the set used in dynamic analysis by the modal
method.

   The nesting of vector sets is depicted by the following diagram:

   - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + - -+
   um                                                          |    |
   - - - - - - - - - - - - - - - - - - - - - - - - - - - +     |    |
   us                                                    |     |    |
   - - - - - - - - - - - - - - - - - - - - - - - +       |     |    |
   uo                                            |       |     |    |
   - - - - - - - - + - - - - - - - - +           |       + un  + ug + up
   ur              |                 |           + uf    |     |    |
                   |                 + ua        |       |     |    |
                   + ud              |           |       |     |    |
   ul              |                 |           |       |     |    |
   - - - - - - - - | - - - - - - - - + - - - - - + - - - + - - +    |
   ue              |                 |                              |
   - - - - - - - - + - - - - - - - - | - - - - - - - - - - - - - - -+
   �o              |                 + uh
                   + �i              |
   �f              |                 |
   - - - - - - - - + - - - - - - - - +

   The data block USET (USETD in dynamics) is central to this set
classification. Each word of USET corresponds to a degree of freedom in the
problem. Each set is assigned a bit in the word. If a degree of freedom
belongs to a given set, the corresponding bit is on. Every degree of freedom
can then be classified by analysis of USET. The common block /BITPOS/ relates
the sets to bit numbers. A table indicating the various sets to which each
degree of freedom belongs may be obtained by setting DIAG 21 in the Executive
Control Deck. This table provides a listing of each grid, scalar, and extra
point in the model and shows the assignment of each associated degree of
freedom (six or one) to the sets L, A, F, N, G, R, O, S, and M. The S-set is
further divided into the SB and SG "sub" sets to indicate constraints applied
by SPC cards or GRID cards, respectively. Tables that indicate the membership
of A-set, O-set, S-set, and M-set may be obtained by setting DIAG 22 in the
Executive Control Deck. These tables summarize the degree of freedom
assignments for sets M, S, O, and A. The S-set is further divided into the SPC
and PERM SPC "sub" sets to indicate constraints applied by SPC cards or GRID
cards, respectively.

   In constructing the matrices used in the heat approach, you must constrain
five of the six degrees of freedom associated with each grid point. Since the
only unknown at a grid point is its temperature, there is only one degree of
freedom per grid point.

   In constructing the matrices used in the aero approach, the aerodynamic
degrees of freedom (including extra points) are added after the structural
matrices have been determined. This introduces the following displacement
sets:

   uk   aerodynamic box and body degrees of freedom

   usA  permanently constrained degrees of freedom associated with
        aerodynamic grid points

   ups     the union of up and usA

   upA  the union of uk and ups

   The nesting of the vector sets in the aero approach is indicated in the
following diagram:

   - - - - - - - - - - - - - - - - - - - - - - - +
   uk                                            |
   - - - - - - - - - - - - - - - - - +           |
   usA                               |           |
   - - - - - - - - - - - - +         |           + upA
                           |         + ups       |
                           + up      |           |
                           |         |           |
   - - - - - - - - - - - - + - - - - + - - - - - +

The upa set replaces the up set for output at grid, scalar, and extra points.

# 1.5  APPLIED LOADS
## 1.5.1  Static Loads

In NASTRAN, static loads are applied to geometric and scalar grid points in a
variety of ways, including:

   1. Loads applied directly to grid points.

   2. Pressure on surfaces.

   3. Gravity loads (internally generated).

   4. Centrifugal forces due to steady rotation.

   5. Equivalent loads resulting from thermal expansion

   6. Equivalent loads resulting from enforced deformations of structural
   elements. 

   7. Equivalent loads resulting from enforced displacements of grid points.

Additional information on static loads is given in Section 3.6 of the
Theoretical Manual. Any number of load sets can be defined in the Bulk Data
Deck. However, only those sets selected in the Case Control Deck, as described
in Section 2.3, will be used in the problem solution. The manner of selecting
each type of load is specified on the associated bulk data card description in
Section 2.4. 

   The FORCE card is used to define a static load applied to a geometric grid
point in terms of components defined by a local coordinate system. The
orientation of the load components depends on the type of local coordinate
system used to define the load. The directions of the load components are the
same as those indicated on Figure 1.2-1 of Section 1.2 for displacement
components. The FORCE1 card is used if the direction is determined by a vector
connecting two grid points, and a FORCE2 card is used if the direction is
specified by the cross product of two such vectors. The MOMENT, MOMENT1, and
MOMENT2 cards are used in a similar fashion to define the application of a
concentrated moment at a geometric grid point. The SLOAD card is used to
define a load at a scalar point. In this case, only the magnitude is
specified, as only one component of motion exists at a scalar point. 

   The FORCEAX and MOMAX cards are used to define the loading of specified
harmonics on rings of conical shell elements. FORCE and MOMENT cards may be
used to apply concentrated loads or moments to conical shell elements,
providing that such points have been defined with a POINTAX card. 

   Pressure loads on triangular and quadrilateral elements are defined with a
PLOAD2 card. The positive direction of the loading is determined by the order
of the grid points on the element connection card, using the right hand rule.
The magnitude and direction of the load is automatically computed from the
value of the pressure and the coordinates of the connected grid points. The
load is applied to the connected grid points. The PLOAD card is used in a
similar fashion to define the loading of any three or four grid points
regardless of whether they are connected with two-dimensional elements. The
PRESAX card is used to define a pressure loading on a conical shell element. 

   Pressure loads on the isoparametric solid elements are defined with the
PLOAD3 card. The pressure is defined positive outward from the element. The
magnitude and direction of the equivalent grid point forces are automatically
computed using the isoparametric shape functions of the element to which the
load has been applied. 

   The GRAV card is used to specify a gravity load by providing the components
of the gravity vector in any defined coordinate system. The gravity load is
obtained from the gravity vector and the mass matrix assembled by the
Structural Matrix Assembler (see Section 4.28 of the Programmer's Manual). The
gravitational acceleration is not calculated at scalar points. You are
required to introduce gravity loads at scalar points directly. 

   The RFORCE card is used to define a static loading condition due to a
centrifugal force field. A centrifugal force load is specified by the
designation of a grid point that lies on the axis of rotation and by the
components of rotational velocity in any defined coordinate system. In the
calculation of the centrifugal force, the mass matrix is regarded as
pertaining to a set of distinct rigid bodies connected to grid points.
Deviations from this viewpoint, such as the use of scalar points or the use of
mass coupling between grid points, can result in errors. 

   Temperatures may be specified for selected elements. The temperatures for a
ROD, BAR, CONROD, or TUBE element are specified on the TEMPRB data card. This
card specifies the average temperature on both ends and, in the case of the
BAR element, is used to define temperature gradients over the cross section.
Temperatures for two dimensional plate and membrane elements are specified on
a TEMPP1, TEMPP2, or TEMPP3 data card. Your defined average temperature over
the volume is used to produce in-plane loads and stresses. Thermal gradients
over the depth of the bending elements, or the resulting moments, may be used
to produce bending loads and stresses. 

   If no thermal element data is given for an element, the temperatures of the
connected grid points given on the TEMP, TEMPD, or TEMPAX cards are simply
averaged to produce an average temperature for the element. The thermal
expansion coefficients are defined on the material definition cards.
Regardless of the type of thermal data, if the material coefficients for an
element are temperature-dependent by use of the MATTi card, they are always
calculated from the "average" temperature of the element. The mere presence of
a thermal field does not imply the application of a thermal load. A thermal
load will not be applied unless you make a specific request in the Case
Control Deck. 

   Enforced axial deformations can be applied to rod and bar elements. They
are useful in the simulation of misfit and misalignment in engineering
structures. As in the case of thermal expansion, the equivalent loads are
calculated by separate subroutines for each type of structural element, and
are applied to the connected grid points. The magnitude of the axial
deformation is specified on a DEFORM card. 

   Zero enforced displacements may be specified on GRID, SPC, or SPC1 cards.
Zero displacements which result in nonzero forces of constraint are usually
specified on SPC or SPC1 cards. If GRID cards are used, the constraints become
part of the structural model and modifications cannot be made at the subcase
level. 

   Nonzero enforced displacements may be specified on SPC or SPCD cards. The
SPC card specifies both the component to be constrained and the magnitude of
the enforced displacement. The SPCD card specifies only the magnitude of the
enforced displacement. When an SPCD card is used, the component to be
constrained must be specified on either an SPC or SPC1 card. The use of the
SPCD card avoids the decomposition of the stiffness matrix when changes are
only made in the magnitudes of the enforced displacements. 

   The equivalent loads resulting from enforced displacements of grid points
are calculated by the program and added to the other applied loads. The
magnitudes of the enforced displacements are specified on SPC cards (SPCAX in
the case of conical shell problems) in the global coordinate system. The
application of the load is automatic when you select the associated SPC set in
the Case Control Deck. 

   The LOAD card in the Bulk Data Deck defines a static loading condition that
is a linear combination of load sets consisting of loads applied directly to
grid points, pressure loads, gravity loads, and centrifugal forces. This card
must be used if gravity loads are to be used in combination with loads applied
directly to grid points, pressure loads, or centrifugal forces. The
application of the combined loading condition is requested in the Case Control
Deck by selecting the set number of the LOAD combination. 

   It should be noted that the equivalent loads (thermal, enforced
deformation, and enforced displacement) must have unique set identification
numbers and be separately selected in the Case Control Deck. For any
particular solution, the total static load will be the sum of the applied
loads (grid point loading, pressure loading, gravity loading, and centrifugal
forces) and the equivalent loads. 

1.5.2  Frequency-Dependent Loads

   A discussion of frequency response calculations is given in Section 12.1 of
the Theoretical Manual. The DLOAD card is used to define linear combinations
of frequency-dependent loads that are defined on RLOAD1 or RLOAD2 cards. The
RLOAD1 card defines a frequency-dependent load of the form 

                              i(�-2+f�)
   {P(f)}  = {A[C(f) + iD(f)]e         }                            (1)

where A is defined on a DAREA card, C(f) and D(f) are defined on TABLEDi
cards, � is defined on a DPHASE card and � is defined on a DELAY card. The
RLOAD2 card defines a frequency-dependent load of the form 

                    i{�(f)+�-2+f�}
   {P(f)}  = {AB(f)e              }                                 (2)

where A is defined on a DAREA card, B(f) and �(f) are defined on TABLEDi
cards, � is defined on a DPHASE card, and � is defined on a DELAY card. The
coefficients on the DAREA, DELAY, and DPHASE cards may be different for each
loaded degree of freedom. The loads are applied to the specified components in
the global coordinate system. 

   A discussion of random response calculations is given in Section 12.2 of
the Theoretical Manual. The RANDPS card defines load set power spectral
density factors for use in random analysis of the form 

   Sjk(f)  =  (X + iY)G(f)                                          (3)

where G(f) is defined on a TABRNDi card. The subscripts j and k define the
subcase numbers of the load definitions. If the applied loads are independent,
only the diagonal terms (j=k) need be defined. The RANDT1 card is used to
specify the time lag constants for use in the computation of the
autocorrelation functions. 

## 1.5.3  Time-Dependent Loads

   A discussion of transient response calculations is given in Section 11 of
the Theoretical Manual. The DLOAD card is used to define linear combinations
of time-dependent loads that are defined on TLOAD1 and TLOAD2 cards  The
TLOAD1 card defines a time-dependent load of the form 

   {P(t)}  =  {AF(t - �)}                                           (4)

where A is defined on a DAREA card, � is defined on a DELAY card, and F(t-�)
is defined on a TABLEDi card. The TLOAD2 card defines a time-dependent load of
the form 

                +
                | {0} ,. t~ < 0  or t~ > T2 - T1
   {P(t)}   =   |     B  Ct~                                        (5)
                | {At~  e   cos(2+ft~+P)}, 0 <= t~ <= T2 - T1
                +

where t~  =  t - T1  - �, and A and � are defined as above. The coefficients
on the DAREA and DELAY cards may be different for each loaded degree of
freedom. The loads are applied to the specified components in the global
coordinate system. 

   Nonlinear effects are treated as an additional applied load vector, for
which the components are functions of either displacements or velocities. This
additional load vector is added to the right side of the equations of motion
and treated along with the applied load vector during numerical integration.
It is required that the points to which the nonlinear loads are applied and
the degrees of freedom on which they depend be members of the solution set,
i.e., that they cannot be degrees of freedom eliminated by constraints. It is
further required that if a modal formulation is used the points referenced by
the nonlinear loads be members of the set of extra scalar points introduced
for dynamic analysis. 

   At present, NASTRAN includes four different types of nonlinear elements.
For a discussion of nonlinear elements see Section 11.2 of the Theoretical
Manual. The NOLIN1 card defines a nonlinear load of the form 

   Pi(t)  =  SiT(xj)                                                (6)

where Pi is the load applied to xi, Si is a scale factor, T(xj) is a tabulated
function defined with a TABLEDi card, and xj is any permissible displacement
or velocity component. The NOLIN2 card defines a nonlinear load of the form 

   Pi(t)  =  Si xj yk                                               (7)

where xj and yk are any permissible pair of displacement or velocity
components. They may be the same. The NOLIN3 card defines a nonlinear load of
the form 

              +        A
              | Si (xj)    , xj > 0
   Pi(t)    = |                                                     (8)
              | 0          , xj <= 0
              +

where A is an exponent. The NOLIN4 card defines a nonlinear load of the form

              +          A
              | -Si (-xj)  , xj < 0
   Pi(t)    = |                                                     (9)
              | 0          , xj >= 0
              +

   Nonlinear loads applied to a massless system without damping will not
converge to a steady solution. Use of DIAG 10 (Section 2.2.1) will cause the
nonlinear term {Nn+1} to be replaced by 1/3 {Nn+1 + Nn + Nn-1} where Nn+1, Nn,
and Nn-1 are the values of the nonlinear loads at time steps preceding the
solution time step. Section 11.4 of the Theoretical Manual discusses the
integration of coupled equations.

# 1.6  DYNAMIC MATRICES

   The dynamic matrices are defined as the stiffness, mass, and damping
matrices used in either the direct or modal formulation of dynamics problems.
The assembly of dynamics matrices is discussed in Section 9.3 of the
Theoretical Manual. There are three general sources for the elements of the
dynamic matrices.

   1. Matrices generated by the structural matrix assembler.

   2. Direct input matrices.

   3. Modal matrices obtained from real eigenvalue analysis.

   The structural matrix assembler generates stiffness terms from the
following sources:

   1. Structural elements defined on connection cards, for example, CBAR and
      CROD.

   2. General elements defined on GENEL cards.

   3. Scalar springs defined on CELASi cards.

   The structural matrix assembler generates mass terms from the following
sources:

   1. A 6x6 matrix of mass coefficients at a grid point defined on a CONM1
      card.

   2. A concentrated mass element defined on a CONM2 card in terms of its mass
      and moments of inertia about its center of gravity.

   3. Structural mass for all elements, except plate elements without membrane
      stiffness, using the mass density on the material definition card.

   4. Nonstructural mass for all elements specifying a value on the property
      card.

   5. Scalar masses defined on CMASSi cards.

A discussion of inertia properties, including the lumped mass method and the
coupled mass method, is given in Section 5.5 of the Theoretical Manual. The
structural matrix assembler will use the lumped mass method for bars, rods,
and plates unless the PARAM card COUPMASS (see PARAM bulk data card) is used
to request the coupled mass method.

   The structural matrix assembler generates damping terms from the following
sources:

   1. Viscous rod elements defined on CVISC cards.

   2. Scalar viscous dampers defined on CDAMPi cards.

   3. Element structural damping by multiplying the stiffness matrix of an
      individual structural element by a damping factor obtained from the
      material properties (MATi) card for the element.

In addition, uniform structural damping is provided by multiplying the
stiffness matrix generated in structural matrix assembler by a damping factor
that is specified by you on the PARAM card G (see PARAM bulk data card). This
form of damping is not recommended for hydroelastic problems.

   The direct input matrices are generated by transfer functions (TF cards) or
they are supplied directly by you (DMIG or DMIAX cards). The terms of the
direct input matrices may be associated either with grid points or with extra
points introduced for dynamic analysis.

   The modal matrices are obtained from real eigenvalue analysis using the
stiffness and mass matrices generated by the structural matrix assembler.

## 1.6.1  Direct Formulation

   In the direct method of dynamic problem formulation, the degrees of freedom
are simply the displacements at grid points. The dynamic matrices are
assembled from the direct input matrices and the stiffness, mass, and damping
matrices generated by the structural matrix assembler. The direct input
matrices are generated by transfer functions (TF cards) or they are supplied
directly by you (DMIG or DMIAX cards).

   For frequency response analysis and complex eigenvalue analysis the
complete dynamic matrices are:

   [Kdd]  =  (1 + ig)[Kdd1] + [Kdd2] + i[Kdd4]                      (1)

   [Bdd]  =  [Bdd1] + [Bdd2]                                        (2)

   [Mdd]  =  [Mdd1] + [Mdd2]                                        (3)

where the subscripts dd indicate the solution set composed of the degrees of
freedom remaining after all constraints have been applied and the extra scalar
points introduced for dynamic analysis. The matrices K, B, and M are the
stiffness, damping, and mass matrices respectively. The superscript 1
indicates the matrices generated by the structural matrix assembler. The
superscript 2 indicates the direct input matrices. The matrix [Kdd4] is a
structural damping matrix obtained by multiplying the stiffness matrix of an
individual structural element by a damping factor obtained from the material
properties (MATi) card for the element. The matrix [Kdd1] is multiplied by the
damping factor (g) to provide for uniform structural damping in cases where it
is appropriate. The constant g is specified by you on a PARAM card (see PARAM
bulk data card).

   For transient response analysis the complete dynamic matrices are:

   [Kdd]  =  [Kdd1] + [Kdd2]                                        (4)

   [Bdd]  =  [Bdd1] + [Bdd2] + (g/�3)[Kdd1] + (1/�4)[Kdd4]          (5)

   [Mdd]  =  [Mdd1] + [Mdd2]                                        (6)

where �3 is the radian frequency at which the term (g/�3)[Kdd1] produces the
same magnitude of damping as the term ig[Kdd1] in frequency response analysis,
and �4 is the radian frequency at which the term (1/�4)[Kdd4] produces the same
magnitude of damping as the term i[Kdd4] in frequency response analysis. The
equivalent viscous damping is only an approximation to the structural damping
as the viscous damping forces are larger at higher frequencies and smaller at
lower frequencies. Therefore, the quantities �3 and �4 are frequently selected
by you to be at the center of the frequency range of interest. A small value
of g/�3 is frequently useful to insure stability of higher modes in nonlinear
transient analysis. You specify the values of �3 and �4 on PARAM cards W3 and
W4 (see PARAM bulk data card). If �3 and �4 are omitted, the corresponding
terms are ignored.

## 1.6.2  Modal Formulation

   In the modal method of dynamic problem formulation, the vibration modes of
the structure in a selected frequency range are used as degrees of freedom,
thereby reducing the number of degrees of freedom while maintaining accuracy
in the selected frequency range. The frequency range is specified on PARAM
cards by either selecting the number of lowest modes obtained from a real
eigenvalue analysis, or selecting all of the modes in a given frequency range
(see PARAM bulk data card).

   It is important to have both direct and modal methods of dynamic problem
formulation, in order to maximize efficiency in different situations. The
modal method will usually be more efficient in problems where a small fraction
of all of the modes are sufficient to produce the desired accuracy, provided
that the bandwidth of the direct stiffness matrix is large. The bandwidth may
be large due either to a compact structural arrangement or to dynamic coupling
effects. The direct method will usually be more efficient for problems in
which the bandwidth of the direct stiffness matrix is small and for problems
with dynamic coupling in which a large fraction of the vibration modes are
required to produce the desired accuracy. For problems without dynamic
coupling, that is, for problems in which the matrices of the modal formulation
are diagonal, the modal method will frequently be more efficient, even though
a large fraction of the modes are needed.

   The complete dynamic matrices used in dynamic analysis by the modal method
include the direct input mass, damping, and stiffness matrices [Mdd2], [Bdd2],
[Kdd2], and the modal matrices [mi], [bi], and [ki] obtained from real
eigenvalue analysis. The matrix [mi] is the modal mass matrix with
off-diagonal terms (which should be zero) omitted. The modal damping matrix
[bi] and stiffness matrix [ki] are obtained from [mi] by:

   [bi]  =  [2+fi g(fi) mi]                                         (7)

               2  2
   [ki]  =  [4+  fi  mi]                                            (8)

where fi is the frequency of the ith normal mode and g(fi) is obtained by
interpolation of a table supplied by you to represent the variation of
structural damping with frequency. This table is defined with a TABDMP1 card.
Structural damping will not be used in the modal formulation unless an
SDAMPING card is used in the Case Control Deck to select a particular TABDMP1
card. The specification of damping properties for the modal method is somewhat
less general than it is for the direct method, in that viscous dampers and
nonuniform structural damping are not used.

   The mode acceleration method of data recovery is optional when using the
modal formulation for transient response and frequency response problems; see
Section 9.4 of the Theoretical Manual for details. In this procedure, the
inertia and damping forces are computed from the modal solution. These forces
are then added to the applied forces and the combination is used to obtain a
more accurate displacement vector for the structure by static analysis. This
improved displacement vector is used in the stress recovery operation. The
mode acceleration method is selected with the PARAM card MODACC (see PARAM
bulk data card).

1.7  HYDROELASTIC MODELING
==========================
   There are two methods of hydroelastic modeling available in NASTRAN. One is
the axisymmetric hydroelastic modeling capability and the other is the
three-dimensional hydroelastic modeling capability. These are described in
Sections 1.7.1 and 1.7.2, respectively.

   The NASTRAN axisymmetric hydroelastic modeling capability is designed
primarily for the solution of problems involving small motion dynamic response
of models with combined structure and fluid effects. The options include both
rigid and flexible container boundaries, free surface effects, and
compressibility. The fluid is described by axisymmetric finite elements. The
structure is described by conventional nonaxisymmetric elements to form
matching boundaries with the fluid.

   The NASTRAN three-dimensional hydroelastic modeling capability is designed
for the solution of problems involving interacting, arbitrarily-shaped
structures and fluids, including tilted free surfaces, and allows for more
efficient methods of obtaining solutions for large-order problems. The fluid
is modeled by three-dimensional solid elements with options for tetrahedron,
wedge, and hexahedron shapes. The elements are connected to fluid grid points
which define the pressure in the fluid at specified locations. The structure
may be modeled arbitrarily using conventional NASTRAN elements. The fluids are
assumed to be incompressible, irrotational, and non-viscous.

## 1.7.1  Axisymmetric Hydroelastic Modeling
### 1.7.1.1  Solution of the NASTRAN Fluid Model

   The NASTRAN axisymmetric hydroelastic option allows you to solve a wide
variety of fluid problems having structural interfaces, compressibility, and
gravity effects. A complete derivation of the NASTRAN model and an explanation
of the assumptions are given in Section 16.1 of the Theoretical Manual. The
input data and the solution logic have many similarities to a structural
model. The standard normal modes analysis, transient analysis, complex
eigenvalue analysis, and frequency response solutions are available with minor
restrictions. The differences between a NASTRAN fluid model and an ordinary
structural problem are due to the physical properties of a fluid and are
summarized below:

   1. The independent degrees of freedom for a fluid are the Fourier
      coefficients of the pressure function (that is "harmonic pressures") in
      an axisymmetric coordinate system. The independent degrees of freedom
      for a structure are typically displacements and rotations at a physical
      point in space.

   2. Much like the structural model, the fluid data will produce "stiffness"
      and mass matrices. Because they now relate pressures and flow instead of
      displacements and forces, their physical meaning is quite different. You
      may not apply loads, constraints, sequencing, or omitted coordinates
      "directly" on the fluid points involved. Instead, you supply information
      related to the boundaries and NASTRAN internally generates the correct
      constraints, sequencing, and matrix terms. Indirect methods, however,
      are available to you for using the internally generated points as normal
      grid or scalar points. See Section 1.7.1.4 for the identification code.

   3. When a physical structure is to be connected to the fluid, you supply a
      list of fluid points and a related list of special structural grid
      points. NASTRAN will produce unsymmetric matrix terms which define the
      actual physical relations. A special provision is included in NASTRAN in
      the event that the structure has planes of symmetry. You may, if you
      wish, define only a section of the boundary and solve your problem with
      symmetric or antisymmetric constraints. The fluid-structure interface
      will take the missing sections of structural boundary into account.

   4. Because of the special nature of the fluid problems, various user
      convenience options are absent. The fluid elements and harmonic
      pressures may not be included in the structural plots at present.
      Plotting the harmonic pressures versus frequency or time may not be
      "directly" requested. Because mass matrix terms are automatically
      generated if compressibility or free surface effects are present, the
      weight and center of gravity calculations with fluid elements present
      may not be correct and should be avoided. Also, the inertia relief rigid
      format uses the mass matrix to produce internal loads and if fluids are
      included, these special fluid terms in the mass matrix may produce
      erroneous results.

   In spite of the numerous differences between a NASTRAN structural model and
a NASTRAN fluid model, the similarities allow you to formulate a model with a
minimum of data preparation and obtain efficient solutions to large order
problems. The similarities of the fluid model to the NASTRAN structural model
are as follows:

   1. The fluid is described by points in space and finite element
      connections. The locations of the axisymmetric fluid points are
      described by rings (RINGFL) about a polar axis, much like the
      axisymmetric conical shell. The rings are connected by elements
      (CFLUIDi) which have the properties of density and bulk modulus of
      compressibility. Each fluid ring produces, internally, a series of
      NASTRAN scalar points, pn and pn* (that is "harmonic pressures"),
      describing the pressure function, P(�), in the following equation:

                   N   n          N   n*
      P(�) =  po + -  p  cos n� + -  p   sin n�    0< N <100
                   n=1            n=1

      where the set of harmonics 0, n, and n* are selected by you. If you want
      the output of pressure at specific points on the circular ring, you may
      specify them as "pressure points" (PRESPT) by giving a point number and
      an angle on a specified fluid ring. The output data will have the values
      of pressure at the angle, �, given in the above equation. The output of
      free surface displacements normal to the surface (FREEPT) are also
      available at specified angles, �. The Case Control card option "AXISYM =
      FLUID" is necessary when any harmonic fluid degrees of freedom are
      included.

   2. The input data to NASTRAN may include all of the existing options except
      the axisymmetric structural element data. All of the existing Case
      Control options may be included with some additional fluid Case Control
      requests. All of the structural element and constraint data may be used
      (but not connected to RINGFL, PRESPT, or FREEPT fluid points). The
      structure-fluid boundary is defined with the aid of special grid points
      (GRIDB) which may be used for any purpose that a structural grid point
      is presently used.

   3. The output data options for the structural part of a hydroelastic model
      are unchanged from the existing NASTRAN options. The output values for
      the fluid will be produced in the same form as the displacement vectors,
      but with format modifications for the harmonic data. Printed values for
      the fluid may include both real and complex values. Pressures and free
      surface displacements, and their velocities and accelerations, may be
      printed with the same request (the Case Control request PRESSURE = SET
      is equivalent to DISP = SET) as structural displacements, velocities,
      and accelerations. Structural plots are restricted to GRID and GRIDB
      points and any elements connected to them. X-Y plot and Random Analysis
      capabilities are available for FREEPT and PRESPT points if they are
      treated as scalar points. The RINGFL point identification numbers may
      not be used in any plot request; instead the special internally
      generated points used for harmonics may be requested in X-Y plots and
      Random Analysis. See Section 1.7.1.4 for the identification number code.
      No element stress or force data is produced for the fluid elements. As
      in the axisymmetric conical shell problem, the Case Control request
      HARMONICS = N is used to select up to the Nth harmonic for output.

### 1.7.1.2  Hydroelastic Input Data

   A number of special NASTRAN data cards are required for fluid analysis
problems. These cards are compatible with structural NASTRAN data. A brief
description of the uses for each bulk data card follows.

AXIF

   This card controls the formulation of the axisymmetric fluid problem. It is
a required card if any of the subsequent fluid-related cards are present. The
data references a fluid-related coordinate system to define the axis of
symmetry. The gravity parameter is included on the card rather than on the
GRAV card because the direction of gravity must be parallel to the axis of
symmetry. The values of density and bulk elastic modulus are conveniences in
the event that these properties are constant throughout the fluid. A list of
harmonics and the request for the nonsymmetric (sine) coefficients are
included on this card to allow you to select any of the harmonics without
producing extra matrix terms for the missing harmonics. A change in this list,
however, will require a restart at the beginning of the problem.

RINGFL

   The geometry of the fluid model about the axis of symmetry is defined with
the aid of these data cards. The RINGFL data cards serve somewhat the same
function for the fluid as the GRID cards serve in the structural model. In
fact, each RINGFL card will produce, internally, a special grid point for each
of the various harmonics selected on the AXIF data card. They may not,
however, be connected directly to normal NASTRAN structural elements (see
GRIDB and BDYLIST data cards). No constraints may be applied directly to
RINGFL fluid points.

CFLUIDi

   The data on these cards are used to define a volume of fluid bounded by the
referenced RINGFL points. The volume is called an element and logically serves
the same purpose as a structural finite element. The physical properties
(density and bulk modulus) of the fluid element may be defined on this card if
they are variables with respect to the geometry. If a property is not defined,
the default value on the AXIF card is assumed. Two connected circles (RINGFL)
must be used to define fluid elements adjacent to the axis of symmetry. A
choice of three or four points is available in the remainder of the fluid.

GRIDB

   This card provides an alternative to the GRID card for the definition of
structural grid points. It also identifies the structural grid point with a
particular RINGFL fluid point for hydroelastic problems. The particular
purpose for this card is to force you to place structural boundary points in
exactly the same locations as the fluid points on the boundary. The format of
the GRIDB card is identical to the format of the GRID card except that one
additional field is used to identify the RINGFL point. The GRDSET card,
however, is not used for GRIDB data.

   If you desire, you may use GRIDB cards without a fluid model. This is
convenient in case you want to solve your structural problem first and to add
the fluid effects later without converting GRID cards to GRIDB cards. The
referenced RINGFL point must still be included in a boundary list (BDYLIST),
see below, and the AXIF card must always be present when GRIDB cards are used.
(The fluid effects are eliminated by specifying no harmonics.)

FREEPT, PRESPT

   These cards are used to define points on a free surface for surface
displacement output and points in the fluid for pressure output. No
constraints may be applied to these points. Scalar elements and direct matrix
data may be connected to these points, but the physical meaning of the
elements will be different from that in the structural case.

FSLIST, BDYLIST

   The purpose for these cards is to allow you to define the boundaries of the
fluid with complete freedom of choice. The FSLIST card defines a list of fluid
points which lie on a free surface. The BDYLIST data is a list of fluid points
to which structural GRIDB points are connected. Points on the boundary of the
fluid for which BDYLIST or FSLIST data are not defined are assumed to be
rigidly restrained from motion in a direction normal to the surface.

   With both of these lists the sequence of the listed points determines the
nature of the boundary. The following directions will aid you in producing a
list.

   1. Draw the z axis upward and the r axis to the right. Plot the locations
      of the fluid points on the right hand side of z.

   2. If one imagines oneself traveling along the free surface or boundary
      with the fluid on one's right side, the sequence of points encountered
      is used for the list. If the surface or boundary touches the axis, the
      word "AXIS" is placed in the list. "AXIS" may be used only for the first
      and/or last point in the list.

   3. The free surface must be consistent with static equilibrium. With no
      gravity field, any free surface consistent with axial symmetry is
      allowed. With gravity, the free surface must be a plane perpendicular to
      the z axis of the fluid coordinate system.

   4. Multiple free surface lists and boundary lists are allowed. A fluid
      point may be included in any number of lists.

FLSYM

   This card allows you to optionally model a portion of the structure with
planes of symmetry containing the polar axis of the fluid. The first plane of
symmetry is assumed at � = 0.0 and the second plane of symmetry is assumed at
� = 360 degrees/M where M is an integer specified on the card. Also specified
are the types of symmetry for each plane, symmetric (S) or antisymmetric (A).

   You must also supply the relevant constraint data for the structure. The
solution is performed correctly only for those harmonic coefficients that are
compatible with the symmetry conditions as illustrated in the following
example for quarter symmetry, M = 4.

+---------+-----------+---------------------------+
|         |           |          Plane 2          |
|         |           +-------------+-------------+
| Series  |  Plane 1  |   S         |       A     |
+---------+-----------+-------------+-------------+
| Cosine  |     S     |  0,2,4,...  |   1,3,5,... |
|         |           |             |             |
|         |     A     |  none       |   none      |
|         |           |             |             |
| Sine    |     S     |  none       |   none      |
|         |           |             |             |
| (*)     |     A     |  1,3,5,...  |   2,4,6,... |
+---------+-----------+-------------+-------------+

DMIAX

   These cards are used for Direct Matrix Input for special purposes such as
surface friction effects. They are equivalent to the DMIG cards, the only
difference being the capability to specify the harmonic numbers for the
degrees of freedom. A matrix may be defined with either DMIG or DMIAX cards,
but not with both.

### 1.7.1.3  Rigid Formats

   The characteristics of the fluid analysis problems which cause restrictions
on the type of solution are:

   1. The fluid-structure interface is mathematically described by a set of
      unsymmetric matrices. Since the first six Rigid Formats are restricted
      to the use of symmetric matrices, the fluid-structure boundary is
      ignored. Thus, for any of these Rigid Formats, the program solves the
      problem for a fluid in a rigid container with an optional free surface
      and an uncoupled elastic structure with no fluid present.

   2. No means are provided for the direct input of applied loads on the
      fluid. The only direct means of exciting the fluid is through the
      structure-fluid boundary. The fluid problem may be formulated in any
      rigid format. However, only some will provide nontrivial solutions.

   The suggested Rigid Formats for the axisymmetric fluid and the restrictions
on each are described below:

Rigid Format No. 3 - Normal Modes Analysis

   The modes of a fluid in a rigid container may be extracted with a
conventional solution request. Free surface effects with or without gravity
may be accounted for. Any structure data in the deck will be treated as a
disjoint problem. (The structure may also produce normal modes.) Normalization
of the eigenvectors using the POINT option will cause a fatal error.

Rigid Format No. 7 - Direct Complex Eigenvalue Analysis

   The coupled modes of the fluid and structure must be solved with this rigid
format. If no damping or direct input matrices are added, the resulting
complex roots will be purely imaginary numbers, whose values are the natural
frequencies of the system. The mode shape of the combination may be normalized
to the maximum quantity (harmonic pressure or structural displacement) or to a
specified structural point displacement.

Rigid Format No. 8 - Direct Frequency and Random Response

   This solution may be used directly if the loads are applied only to the
structural points. The use of overall structural damping (parameter g) is not
recommended since the fluid matrices will be affected incorrectly. Output
restrictions are listed in Section 1.7.1.1.

Rigid Format No. 9 - Direct Transient Response

   Transient analysis may be performed directly on the fluid-structure system
if the following rules apply.

   1. Applied loads and initial conditions are only given to the structural
      points.

   2. All quantities are measured relative to static equilibrium. The initial
      values of the pressures are assumed to be at equilibrium.

   3. Overall structural damping (parameters w3 and g) must not be used.

   4. Output restrictions are listed in Section 1.7.1.1.

Rigid Formats 10, 11, and 12 - Modal Formulations

   Although these rigid formats may be used in a fluid dynamics problem, their
practicality is limited. The modal coordinates used to formulate the dynamic
matrices will be the normal modes of both the fluid and the structure solved
as uncoupled systems. Even though the range of natural frequencies would be
typically very different for the fluid from that for the structure, NASTRAN
will select both sets of modes from a given fixed frequency range. The safest
method with the present system is the extraction of all modes for both systems
with the Tridiagonalization Method. This procedure, however, results in a
dynamic system with large full matrices. Direct formulation would be more
efficient in that case. At present, the capability for fluid-structure
boundary coupling is not provided with Rigid Formats 10, 11, and 12. However,
the capability may be provided by means of an ALTER using the same logic as in
the direct formulations.

### 1.7.1.4  Hydroelastic Data Processing

   The fluid related data cards submitted by you are processed by the NASTRAN
Preface to produce equivalent grid point, scalar point, element connection,
and constraint data card images. Each specified harmonic, N, of the Fourier
series solution produces a complete set of special grid and connection card
images. In order to retain unique internal identification numbers for each
harmonic, your (or external) identification numbers are encoded by the
algorithm below:

      RINGFL points:

      NASTRAN (or internal) grid ID = User (or external) ring ID + 1,000,000 x
      IN where

        IN  =  N + 1    cosine series

        IN  =  N + 1/2  sine series

      CFLUIDi connection cards:

      NASTRAN (or internal) element ID = User (or external) element ID x 1000
      + IN where IN is defined above for each harmonic N.

   For example, if you requested all harmonics from zero to two, including the
sine(*) series, each RINGFL card will produce five special grid cards
internally. If your identification number (in field 2 of the RINGFL data card)
were 37, the internally generated grid points would have the following
identification numbers:

      Harmonic       ID

         0        1,000,037
         1*       1,500,037
         1        2,000,037
         2*       2,500,037
         2        3,000,037

These equivalent grid points are resequenced automatically by NASTRAN to be
adjacent to the original RINGFL identification number. A RINGFL point may not
be resequenced by you.

   The output from matrix printout, table printout, and error messages will
have the fluid points labeled in this form. If you wish, you may use these
numbers as scalar points for Random Analysis, X-Y plotting, or for any other
purpose.

   In addition to the multiple sets of points and connection cards, the
NASTRAN Preface also may generate constraint sets. For example, if a free
surface (FSLIST) is specified in a zero-gravity field, the pressures are
constrained by NASTRAN to zero. For this case, the internally generated set of
single point constraints are internally combined with any user defined
structural constraints and will always be automatically selected.

   If pressures at points in the fluid (PRESPT) or gravity dependent normal
displacements on the free surface (FREEPT) are requested, the program will
convert them to scalar points and create a set of multipoint constraints with
the scalar points as dependent variables. The constraint set will be
internally combined with any user defined sets and will be selected
automatically.

   The PRESPT and FREEPT scalar points may be used as normal scalar points for
purposes such as plotting versus frequency or time. Although the FREEPT values
are displacements, scalar elements connected to them will have a different
meaning from that in the structural case.

1.7.2  Three-Dimensional Hydroelastic Modeling
----------------------------------------------
1.7.2.1  Solution Approach
--------------------------
   The three-dimensional hydroelasticity capability in NASTRAN allows for the
solution of problems involving interacting, arbitrarily-shaped structures and
fluids. It is intended for the vibration analysis of fluid-filled tanks in an
acceleration field where the fluid motions interact with the structure
displacements. Both free surface sloshing modes and higher frequency coupled
modes may be obtained from the analysis.

   The method used to formulate the fluid/structure equations is described in
Reference 1. The basis for defining the fluid is three-dimensional finite
elements connected to fluid grid points defining the Eulerian pressure at a
point fixed in space. The use of a single degree-of-freedom pressure at each
point rather than three displacements allows a finer mesh of elements with a
reasonable matrix order.

   In the formulation of the fluid/structure system, the interior fluid
degrees of freedom are transformed and removed from the solution matrices. The
eigenvalues of the combination are extracted from small, fully dense,
symmetric mass and stiffness matrices, efficiently processed with the "Givens"
method. The solution matrices are defined only by the free surface
displacements and the reduced structure coordinates.

   All NASTRAN modeling options are available for the definition of the
structure. All options for the Executive Control and Case Control data for
normal modes analysis are also available for the hydroelastic problems. In
addition to the normal NASTRAN data, a hydroelastic problem requires the
addition of a finite element fluid model, the specification of its boundaries,
and the addition of special control data.

   For three-dimensional hydroelastic analysis, the fluid is modeled with
three-dimensional finite elements having shapes defined by tetrahedra
(CFTETRA), wedge (CFWEDGE), and hexagonal (CFHEX1 or CFHEX2) volumes. The
fluid is assumed to be locally incompressible and non-viscous with small
motions relative to the overall free body displacements of the system. The
following options are provided for defining the fluid boundary conditions.

   1. The default boundary is a rigid wall.

   2. Pure free surfaces are defined with single point constraints.

   3. Free surfaces with gravity effects are specified with CFFREE data cards.

   4. Fluid/structure boundaries are defined by CFLSTR data cards.

Several alternate paths are available for the execution of the problem and the
formulation of the solution equations. These are:

   1. Direct versus Modal Structure Formulation

      In "direct" formulation, the solution matrices are defined by the
      structure degrees of freedom (after constrained and omitted points are
      removed) plus one degree of freedom for each free surface point defined
      on CFFREE data. The alternate "modal" formulation calculates the modes
      of the empty structure and uses the generalized displacements of these
      modes with the free surface degrees of freedom in the solution matrix
      formulation. Although the modal formulation requires the additional cost
      of another eigenvalue extraction process, the combination system
      matrices will be smaller. This method is recommended for problems where
      several different fluid models are used with the same structure model.
      The structure modes need only be calculated once. Different fluid models
      may be analyzed using the NASTRAN restart procedure to recover the
      structure mode data.

   2. Compressibility Options

      Two methods are provided for defining the compressible fluid effects.
      The overall compressibility of the enclosed volume may be specified as a
      parametric number which, in effect, provides a stiffness factor applied
      to the total volume change. The alternate method produces zero volume
      change by automatically constraining one degree of freedom in the
      system. The latter method is not allowed in the "modal" formulation
      option.

   3. Differential Stiffness Effects (Ullage Pressure)

      An option has been provided for including the effects of ullage pressure
      on the structure stiffness. These additional stiffness terms are
      calculated in a separate structure-only Rigid Format 4 analysis with
      pressures defined by static loads. The differential stiffness is
      transferred to the problem with the NASTRAN checkpoint/restart procedure
      and is controlled by two parameters, DISTIF and DIFSCALE.

      In the following sections, the actual NASTRAN input is described. The
      section on the Executive Control Deck describes the overall system
      control and the available parametric data. The section on the Case
      Control Deck describes the control of optional input cases and output
      requests. The Bulk Data Deck section describes the detailed formats for
      each bulk data card.

1.7.2.2  Executive Control Deck
-------------------------------
   The hydroelastic Executive Control Deck is similar to that for the standard
normal modes analysis, Rigid Format 3. When running the hydroelastic analyses,
you must insert one of the special DMAP ALTER packages into your Executive
Control Deck. These ALTER packages are delivered with the NASTRAN system.

   Two special DIAGs are provided for the hydroelastic analysis.

   DIAG 32 Prints a list of degrees of freedom including fluid point
           definitions. For each point, an indication is made identifying the
           sets to which it belongs.

   DIAG 33 Prints the contents of selected displacement sets. For each set, a
           list of all degrees of freedom belonging to the set is given.

These two DIAGs produce output similar to that provided by DIAGs 21 and 22
except that the following hydroelastic sets are included or modified:

      Ux  =  Structure point

      Uy  =  Fluid point

      Ufr =  Free surface point

      Uz  =  Ux + Ufr

      Uab =  a bits (structure only)

      Ui  =  Interior fluid points

      Ua  =  Uab + Ufr

Hydroelastic DMAP ALTERs

   Two sets of DMAP ALTERs to Rigid Format 3 are provided to perform the
three-dimensional hydroelastic analysis. The ALTERs obtain the hydroelastic
solution with either direct or modal formulation.

   Several optional parameters may be specified by you for each type of
formulation. These parameters are all described in Section 1.7.2.4 under the
description of the hydroelastic Bulk Data Deck.

### 1.7.2.3  Case Control Deck

   The Case Control data for normal modes analysis, Rigid Format 3, is not
modified for direct hydroelastic solutions. For modal formulation, the data is
similar except that two sets of subcases must be provided. The first set must
select an EIGR card (by means of the METHOD card) to define eigenvalue
extraction for the structure-only model. Several subcases may be used to
define output requests for different vectors with the MODES card. A second set
of subcases is also needed to define eigenvalue extraction and output requests
for the combined fluid/structure model. If the NEWMODE or OLDSTR parameter is
used with modal formulation, only the second set of subcases, used for the
complete model, is required. Three sample Case Control Decks are shown below.

Direct Formulation:

   TITLE  =
   SPC = 10
   METHOD  = 50
   DISP = ALL

Modal Formulation:
------------------
   TITLE =
   SPC = 10
   SUBCASE 1
      LABEL  =  MODES OF EMPTY STRUCTURE
      METHOD   = 10
      DISP =   NONE
   SUBCASE 2
      LABEL  =  MODES WITH FLUID INCLUDED
      METHOD   = 20
      DISP =   ALL

Modal Formulation with Selective Output Requests:
-------------------------------------------------
   TITLE =
   SPC = 10
   SUBCASE 1
      LABEL = STRUCTURE MODES 1 & 2
      METHOD = 10
      DISP = ALL
      MODES = 2
   SUBCASE 3
      LABEL STRUCTURE MODES 3 & 4
      DISP NONE
   SUBCASE 5
      LABEL = FLUID/STRUCTURE MODES 1-3
      METHOD = 20
      DISP = ALL
      MODES = 3
   SUBCASE 8
      LABEL = FLUID/STRUCTURE MODE 4
      DISP = NONE

In the third and last example above, the eigenvectors for only the first two
structure modes and the first three combined modes will be printed.

Hydroelastic Output Control
---------------------------
   The structure printout and plotting Case Control requests are used to
control both the fluid and structure outputs. The following data is available:

   1. Structure-related data such as displacements, forces, and stresses are
      processed with normal NASTRAN control.

   2. Fluid internal pressures are output by including their grid point
      identification numbers in the DISP = output request. If the fluid point
      is on a free surface defined by CFFREE data, the actual free surface
      displacements will be printed.

   3. Both structure and fluid elements may be plotted as undeformed shapes.
      The interior fluid point degrees of freedom are actually pressures and
      should not be plotted as deformed shapes.

   4. The deformed shape of the free surface may be plotted using the "SHAPE"
      or "VECTOR" plot options. It is recommended that PLOTEL elements be used
      to define the free surface. If the fluid elements CFHEX1, CFHEX2, etc.,
      are used in the requested plot set, all of their boundaries will be
      plotted and will result in a confused plot.

   5. The use of the MODES card to control output requests is described under
      the Case Control Deck section.

### 1.7.2.4  Bulk Data Deck

   The bulk data cards that pertain specifically to three-dimensional
hydroelastic modeling are CFFREE, CFHEXi (i = 1 or 2), CFLSTR, CFTETRA,
CFWEDGE, and MATF. These are all described in Section 2.4 along with all other
NASTRAN bulk data cards. These cards are used to define the fluid and
fluid/structure interface. The tank walls and supporting structure are defined
with NASTRAN structural elements. The actual tank walls must be defined by
two-dimensional membrane, panel, or plate elements.

   In addition to the special cards mentioned above, the following NASTRAN
bulk data cards are used for special hydroelastic purposes:

   1. GRID cards are used to define the fluid points. Fluid points contain
      only one degree of freedom and may not be connected to the structural
      elements.

   2. GRAV cards are used to define the magnitude and direction of the gravity
      field. The set identification numbers are referenced by the fluid
      boundary data cards.

   3. SPC and SPC1 data cards may be used to define constraints on the fluid
      grid points. These constraints are used to define regions of zero
      pressure in the fluid, such as a free surface without gravity effects or
      anti-symmetric boundary condition on a plane of symmetry. Only
      degree-of-freedom number 1 may be specified for a fluid grid point.

   In addition, as indicated in Section 1.7.2.2, several optional parameters
may be specified by you for both direct and modal formulations. These
parameters are in addition to those already provided in Rigid Format 3 and are
entered in the Bulk Data Deck using the PARAM card. The parameters are
described below. They are used to:

   1. Control the optional computation paths,

   2. Specify numerical factors to be used in the formulation, and

   3. Allow blocks of DMAP statements to be turned "off" for restart from a
      previous checkpoint run.

Direct Formulation Parameters
-----------------------------
   1. COMPTYP (optional) default = -1

      Controls the type of compressibility calculations performed. A negative
      integer will cause finite compressibility as defined by the KCOMP
      parameter. A positive integer will cause constraint equation to be
      generated to provide pure incompressibility.

   2. KCOMP (optional) default = 1.0

      The real value of this parameter defines the overall compressibility of
      the fluid volume. The definition is fluid bulk modulus divided by total
      volume.

   3. DIFSTIF (optional) default = 1

      A negative integer value causes the differential stiffness matrix to be
      included for ullage pressure effects. This matrix is available from the
      checkpoint file of a Rigid Format 4 solution run of the structure model.

   4. DIFSCALE (optional) default = 1.0

      The differential stiffness matrix may be multiplied by the real value of
      this parameter.

   5. NEWMODE (optional) default = 1

      A negative integer will cause all DMAP statements and ALTERs up to the
      eigenvalue extraction to be skipped. This allows you to restart the
      original solution to obtain different eigenvectors without changing the
      DMAP ALTER deck.

   6. OLDSTR (optional) default = 1

      A negative value will cause most structure-related processing to be
      skipped. This allows you to restart a previous solution, either hydro or
      structure only, and change the fluid model without recomputing the
      unchanged structure.

Modal Formulation Parameters
----------------------------
   1. KCOMP (optional) default = 1.0

      (same as direct formulation parameter)

   2. DIFSTIF (optional) default = 1

      (same as direct formulation parameter)

   3. DIFSCALE (optional) default = 1.0

      (same as direct formulation parameter)

   4. NEWMODE (optional) default = 1

      (same as direct formulation parameter)

   5. OLDSTR (optional) default = 1

      (same as direct formulation parameter)

   6. LMODES (optional) default = 1

      This integer value specifies the number of the lowest structure modes to
      be used when formulating the hydroelastic matrices. A negative value
      indicates all available modes are to be used.

REFERENCE
=========
1. Final Report, NASTRAN Hydroelastic Modal Studies, Volume I, Introduction,
   Theory and Results, (by Universal Analytics, Inc.), National Aeronautics
   and Space Administration, NASA-CR-150393, May 1977.

# 1.8  HEAT TRANSFER PROBLEMS
## 1.8.1  Introduction to NASTRAN Heat Transfer

   NASTRAN heat flow capability may be used either as a separate analysis to
determine temperatures and fluxes, or to determine temperature inputs for
structural problems. Steady and transient problems can be solved, including
heat conduction (with variable conductivity for static analysis), film heat
transfer, and nonlinear (fourth power law) radiation.

   The heat flow problem is similar, in many ways, to structural analysis
(Figure 1.8-1). The same grid points, coordinate systems, elements,
constraints, and sequencing can be used for both problems. There are several
differences, such as the number of degrees of freedom per grid point, the
methods of specifying loads, boundary film heat conduction, and the nonlinear
elements. For heat flow problems, the only unknown at a grid point is the
temperature (compare structural analysis with three translations and three
rotations), and hence, there is one degree of freedom per grid point.
Additional grid or scalar points are introduced for fluid ambient temperatures
in convective film heat transfer. If radiation effects are included or the
conductivity of an element is temperature dependent, the problem becomes
nonlinear (compare structural analysis with temperature dependent materials
which only requires looking up material properties and computing thermal
loads).

   The heat conduction analysis of NASTRAN is compatible with structural
analysis. If the same finite elements are appropriate, then the same grid and
connection cards can be used for both problems. As in structural analysis, the
choice of a finite element model is left to the analyst. Temperature
distributions can be output in a format which can be input into structural
problems. Heat flow analysis uses many structural NASTRAN Bulk Data cards.
These include (where i means there is more than one type):  CBAR, CDAMPi,
CELASi, CHEXAi, CIHEXi, CONROD, CORDii, CQDMEM, CQUADi, CROD, CTETRA, CTRAPRG,
CTRIAi, CTRIARG, CTRMEM, CTUBE, CVISC, CWEDGE, DAREA, DELAY, DLOAD, DMI, DMIG,
EPOINT, GRDSET, GRID, LOAD, MPC, MPCADD, NOLINi, OMITi, PARAM, Piii (for
elements requiring properties), PLOTEL, SEQiP, SLOAD, SPCi, SPCADD, SPOINT,
TABLEDi, TABLEMi, TEMPii, TF, TLOADi, and TSTEP.

## 1.8.2  Heat Transfer Elements

   The basic heat conduction elements are the same as NASTRAN structural
elements. These elements are shown in the following table:

+----------------------------------------------------------------------+
|                     Heat Conduction Elements                         |
+--------------------+-------------------------------------------------+
| Type               |               Elements                          |
+--------------------+-------------------------------------------------+
| Linear             | BAR, ROD, CONROD, TUBE                          |
|                    |                                                 |
| Membrane           | TRMEM, TRIA1, TRIA2, QDMEM, QUAD1, QUAD2        |
|                    |                                                 |
| Solid of Revolution| TRIARG, TRAPRG                                  |
|                    |                                                 |
| Solid              | TETRA, WEDGE, HEXA1, HEXA2, IHEX1, IHEX2, IHEX3 |
|                    |                                                 |
| Scalar             | CELASi, CDMAPi                                  |
+--------------------+-------------------------------------------------+

A connection card (Cxxx) and, if applicable, a property card (Pxxx) is defined
for each of these elements. Linear elements have a constant cross-sectional
area. The offset on the BAR is treated as a perfect conductor (no temperature
drop). For the membrane elements, the heat conduction thickness is the
membrane thickness. The bending characteristics of the elements do not enter
into heat conduction problems. The solid of revolution element, TRAPRG, has
been generalized to accept general quadrilateral rings (that is, the top and
bottom need not be perpendicular to the z-axis for heat conduction). These
heat conduction elements are composed of constant gradient lines, triangles,
and tetrahedra. The quadrilaterals are composed of overlapping triangles, and
the wedges and hexahedra from subtetrahedra. Scalar spring elements are used
for transient analysis temperature constraints and scalar damping elements are
used to add thermal mass. Gradients and fluxes may be output by requesting
ELFORCE.

   Thermal material conductivities and heat capacities are given on MAT4
(isotropic) and MAT5 (anisotropic) Bulk Data cards. Temperature dependent
conductivities are given on MATT4 and MATT5 bulk data cards, which can only be
used for nonlinear static analysis. The heat capacity per unit volume is
specified, which is the product of density and heat capacity per unit mass
(pCp). Lumped conductivities and thermal capacitance may be defined by the
CELASi and CDAMPi elements, respectively.

   A special element (HBDY) defines an area for boundary conditions. There are
five basic types, called POINT, LINE, REV, AREA3, and AREA4. A sixth type,
ELCYL, is for use only with QVECT radiation. The HBDY is considered an
element, since it can add terms to the conduction and heat capacity matrices.
There is a CHBDY connection and PHBDY property card. When a film heat transfer
condition is desired, film conductivity and heat capacity per unit area are
specified on MAT4 data cards. The ambient temperature is specified with
additional points (GRID or SPOINT) listed on the CHBDY connection card. See
Figure 1.8-2 for geometry.

   Radiation heat exchange may be included between HBDY elements. A list of
HBDY elements must be specified on a RADLST Bulk Data card. The emissivities
are specified on the PHBDY cards. The Stefan-Boltzmann constant (SIGMA) and
absolute reference temperature (TABS) are specified on PARAM Bulk Data cards.
Radiation exchange coefficients (default is zero) are specified on RADMTX Bulk
Data cards.

   The several types of power input to the HBDY elements can be output by the
ELFORCE request.

1.8.3  Constraints and Partitioning

   Constraints are applied to provide boundary conditions, represent "perfect"
conductors, and provide other desired characteristics for the heat transfer
model.

   Single point constraints are used to specify the temperature at a point.
The grid or scalar points are listed on SPC or SPC1 bulk data cards, not
GRDSET or GRID cards. The component on the data card must be "0" or "1". This
declares the degree of freedom to be in the us set. The method of specifying
temperature is dependent upon the problem type.

   In linear statics analysis, the SPC or SPC1 card is used to constrain grid
points at a fixed temperature. In nonlinear statics analysis, the SPC or SPC1
card is used to designate the grid point ID which is to be constrained. The
actual value of the temperature is indicated on a TEMP card, selected by
TEMP(MATERIAL) in the Case Control deck. In transient analysis, the SPC or
SPC1 card may be used to fix the temperature of a grid point only when the
temperature is zero. When the temperature is non-zero a large conductive
coupling to a "ground" at absolute temperature must be defined. From the
structural relationship F=Kx, the thermal analogy is made where K is the
conductive coupling, F is an applied load, and x is the fixed temperature. In
this case, x is adjusted to the desired temperature by defining the spring
constant, K, of a CELASi element, which is connected to "ground", and a load,
F, which is applied to the grid point in question. The numerical value of K
should be several orders of magnitude greater than the numerical value of the
conductances prescribed for the rest of the model.

   Multipoint constraints are linear relationships between temperatures at
several grid points, and are specified on MPC cards. The first entry on an MPC
card will be in the um set. The type of constraint is limited if nonlinear
elements are present. If a member of set um touches a non-linear (conduction
or radiation) element, the constraint relationship is restricted to be an
"equivalence". The term "equivalence" means that the value of the member of
the um set will be equal to one of the members of the un set (a point not
multipoint constrained). Those points not touching nonlinear elements are not
so limited. You will be responsible to satisfy the equivalence requirement, by
having only two entries on the MPC data card, with equal (but opposite in
sign) coefficients.

## 1.8.4  Thermal Loads

   Thermal "loads" may be boundary heat fluxes or volume heat addition. As in
the case of structural analysis, the method of specifying loads is different
for static and transient analysis. The HBDY element is used for boundaries of
conducting regions. Surface heat flux input can be specified for HBDY elements
with QBDY1 and QBDY2 data cards. These two cards are for constant and
(spatially) variable flux, respectively. Flux can be specified without
reference to an HBDY element with the QHBDY data card. Vector flux, such as
solar radiation, depends upon the angle between the flux and the element
normal, and is specified for HBDY elements with the QVECT data card. This
requires that the orientation of the HBDY element be defined. Volume heat
addition into a conduction element is specified on a QVOL data card.

   Static thermal loads are requested in Case Control with LOAD card. All of
the above load types plus SLOADs can be requested. Transient loads are
requested in Case Control with a DLOAD card, which selects TLOAD time
functions. Transient thermal loads may use DAREA (as in structural transient),
and/or the QBDY1, QBDY2, QHBDY, QVECT, QVOL, and SLOAD cards. The resultant
thermal load will be the sum of all loads applied. This means the LOAD SIDs
and DAREA SIDs must be the same when referenced on a TLOADi card.

## 1.8.5  Linear Static Analysis

   Linear static analysis uses APProach HEAT, SOLution 1. The rigid format is
the same as that used for static structural analysis. This implies that
several loading conditions and constraint sets can be solved in one job, by
using subcases in the Case Control deck.

## 1.8.6  Nonlinear Static Analysis

   Nonlinear static analysis uses APProach HEAT, SOLution 3. This rigid format
will allow temperature dependent conductivities of the elements, nonlinear
radiation exchange, and a limited use of multipoint constraints. There is no
looping for load and constraints. The solution is iterative. You can supply
values on PARAM Bulk Data cards for:

   MAXIT (integer) Maximum number of iterations (default 4).

   EPSHT (real)    � convergence parameter (default .001).

   TABS (real)     Absolute reference temperature (default 0.0).

   SIGMA (real)    Stefan-Boltzmann radiation constant (default 0.0).

   IRES (integer)  Request residual vector output if positive (default -1).

   You must supply an estimate of the temperature distribution vector {u1}.
This estimate is used to calculate the reference conductivity plus radiation
matrix needed for the iteration. {u1} is also used at all points in the us set
to specify a boundary temperature. The values of {u1} are given on TEMP Bulk
Data cards, and they are selected by TEMP(MATERIAL) in Case Control.

   Iteration may stop for the following reasons:

   1. Normal convergency:  �T < EPSHT, where �T is the per unit error estimate
      of the temperatures calculated.

   2. Number of iterations > MAXIT.

   3. Unstable: |�1| < 1 and the number of iterations > 3, where �1 is a
      stability estimator.

   4. Insufficient time to perform another iteration and output data.

The precise definitions are given in the NASTRAN Theoretical Manual, Section
8.4. Error estimates �p, �1, and �T for all iterations may be output with the
Executive Control card DIAG 18, where �p is the ratio of the Euclidian norms
of the residual (error) loads to the applied loads on the unconstrained
degrees of freedom.

## 1.8.7  Transient Analysis

   Transient analysis uses APProach HEAT, SOLution 9. This rigid format may
include conduction, film heat transfer, nonlinear radiation, and NASTRAN
nonlinear elements. Extra points are used as in structural transient analysis.
All points associated with nonlinear loads must be in the solution set. Loads
may be applied with TLOAD and DAREA cards as in structural analysis. Also, the
thermal static load cards can be modified by a function of time for use in
transient analysis. If the static load data is used to define a transient
load, the static load set identification is referenced on the TLOAD card in
the DAREA field. Loads are requested in Case Control with DLOAD. Initial
temperatures are specified on TEMP Bulk Data cards and are requested by IC.
Previous static or transient solutions can be easily used as initial
conditions, since they can be punched in the correct format. An estimate of
the temperature {u1} is specified on TEMP Bulk Data cards for transient with
radiation, and is requested by TEMP(MATERIAL). The parameters available are:

   TABS (real)     Absolute reference temperature (default 0.0).

   SIGMA (real)    Stefan-Boltzmann radiation constant (default 0.0).

   BETA (real)     Forward difference integration factor (default .55).

   RADLIN (Integer)Radiation is linearized if positive (default -1).

   Time steps are specified on TSTEP data cards.

## 1.8.8  Compatibility with Structural Analysis

   Grid point temperatures for thermal stress analysis (static structural
analysis) are specified on TEMP Bulk Data cards. If punched output is
requested in a heat conduction analysis for Rigid Formats 1 and 3, the format
of the punched card is exactly that of a double field TEMP* data card. Thus,
if the heat conduction model is the same as the structural model, the same
grid, connection, and property cards can be used for both, and the temperature
cards for the structural analysis are produced by the heat conduction
analysis. The output request in Case Control is THERMAL(PUNCH).

+--------------------+         +-----------------+         +-------------------+
|       SEQGP        |         |      CORDi      |         |                   |
|    Grid Point      |         |   Coordinate    |         |     Grid Point    |
|     Sequence       +----+    |     System      |    +----+     Properties    |
|                    |    |    |   Definition    |    |    |                   |
+--------------------+    |    +-------+---------+    |    +-------------------+
                          |            |              |
+--------------------+    |    +-------+---------+    |    +-------------------+
|    CONSTRAINTS     |    +----+      GRID       +----+    |       Cxxx        |
|    Single Point    +---------+   Grid Point    +---------+   Conduction &    |
|     Multipoint     |    +----+   Definition    |         |  Boundary Element |
|  (Omitted Points)  |    |    |                 |         |     Definition    |
|                    |    |    +-------+---------+         +---------+---------+
|                    |    |            |                             |
|                    |    |            |                             |
+--------------------+    |            |                             |
                          |            |                             |
+--------------------+    |    +-------+---------+         +---------+---------+
|  CONSTANT FACTORS  |    |    |  STATIC THERMAL |         |      Pxxx         |
|     Load Scale     |    |    |      LOADS      |         |     Property      |
|     Load Delay     +----+    |  Internal Heat  |         |    Definition     |
|                    |         |   Generation    |         +---------+---------+
+---------+----------+         |  Boundary Heat  |                   |
          |                    |     Fluxes      |                   |
          |                    |Directional Heat |                   |
          |                    |     Source      |                   |
          |                    +-----------------+                   |
+---------+----------+                                     +---------+---------+
|  DYNAMIC THERMAL   |                                     |      MATxx        |
|       LOADS        |                                     |     Material      |
|   Time Dependent   |                                     |    Definition     |
|   Thermal Loads    |                                     +---------+---------+
+---------+----------+                                               |
          |                                                          |
+---------+----------+                                     +---------+---------+
|     TABLEDi        |                                     |     TABLEMi       |
|   Table (Time)     |                                     |Table (Temperature)|
|                    |                                     |                   |
+--------------------+                                     +-------------------+


                  Figure 1.8-1. Thermal model diagram

Type = POINT

                                   
                                   _   _  _         _
The unit normal vector is given by n = V/|V|, where V is given in the basic
system at the referenced grid point (see CHBDY data card, fields 16-18).

Type = LINE

                                   
                                     _     _                      _
The unit normal lies in the plane of V and T, is perpendicular to T, and is
         _    _    _ _    _    _ _
given by n = (T x (VxT))/|T x (VxT)|.

Type = ELCYL

                                   
                                    _
The same logic is used to determine n as for type = LINE. The "radius" R  is in
    _                                       _     _                     1
the n direction, and R  is perpendicular to n and T (see fields 7 and 8 of PHBDY
                      2
card).


  Figure 1.8-2. HBDY element orientation (for QVECT flux) (continued)

Type = REV

                                   
                                                       _    _    _   _    _
The unit normal lies in the x-z plane, and is given by n = (e  x T)/|e  x T|.
_                                                            y        y
e  is the unit vector in the y direction.
 y

Type = AREA3 or AREA4

                                   
                                   _    _     _     _     _
The unit normal vector is given by n = (T   x T  )/|T   x T  |, where x = 3 for
                                         12    1x    12    1x
triangles and x = 4 for quadrilaterals.


  Figure 1.8-2. HBDY element orientation (for QVECT flux) (concluded)


# 1.9  ACOUSTIC CAVITY MODELING
## 1.9.1  Data Card Functions

   The NASTRAN structural analysis system is used as the basis for acoustic
cavity analysis. Many of the structural analysis options, such as selecting
boundary conditions, applying loading conditions, and selecting output data,
are also available for acoustics.

   The data cards specifically used for acoustic cavity analysis are described
below. The card formats are exhibited in Section 2.4. Their purposes are
analogous to the use of structural data cards. A gridwork of points is
distributed over the longitudinal cross section of an acoustic cavity and
finite elements are connected between these points to define the enclosed
volume.

   The points are defined by GRIDF data cards for the axisymmetric central
fluid cavity and by GRIDS data cards for the radial slots. The GRIDF points
are interconnected by finite elements via the CAXIF2, CAXIF3, and CAXIF4 data
cards to define a cross sectional area of the body of rotation. The CAXIF2
element data card defines the area of the cross section between the axis and
two points off the axis (the GRIDF points may not have a zero radius). The
CAXIF3 and CAXIF4 data cards define triangular or quadrilateral cross sections
and connect three or four GRIDF points respectively. The density and/or bulk
modulus at each location of the enclosed fluid may also be defined on these
cards.

   The GRIDS points in the slot region are interconnected by finite elements
via the CSLOT3 and CSLOT4 data cards. These define finite elements with
triangular and quadrilateral cross-sectional shapes respectively. The width of
the slot and the number of slots may be defined by default values on the
AXSLOT data card. If the width of the slots is a variable, the value is
specified on the GRIDS cards at each point. The number of slots, the density,
and/or the bulk modulus of the fluid may also be defined individually for each
element on the CSLOT3 and CSLOT4 cards.

   The AXSLOT data card is used to define the overall parameters for the
system. Some of these parameters are called the "default" values and may be
selectively changed at particular cross sections of the structure. The values
given on the AXSLOT card will be used if a corresponding value on the GRIDS,
CAXIFi, or CSLOTi is left blank. The parameters p (density) and B (bulk
modulus) are properties of the fluid. If the value given for Bulk Modulus is
zero the fluid is considered incompressible by the program. The parameters M
(number of slots) and W (slot width) are properties of the geometry. The
parameter M defines the number of equally spaced slots around the
circumference with the first slot located at � = 0 degrees. The parameter N
(harmonic number) is selected by you to analyze a particular set of acoustic
modes. The pressure is assumed to have the following distribution

   p(r,z,�)  =  p(r,z) cos N�

   If N = 0 the breathing and longitudinal modes will result. If N = 1 the
pressure at � = 180 degrees will be the negative of the pressure at � = 0
degrees. If N = 2, the pressures at � = 90 degrees and �  = 270 degrees will
be the negative of that at � = 0 degrees. Values of N larger than M/2 have no
significance.

   The interface between the central cavity and the slots is defined with the
SLBDY data cards. The data for each card consists of the density of the fluid
at the interface, the number of radial slots around the circumference, and a
list of GRIDS points that are listed in the sequence in which they occur as
the boundary is traversed. In order to ensure continuity between GRIDF and
GRIDS points at the interface, the GRIDF points on the boundary between the
cylindrical cavity and the slots are identified on the corresponding GRIDS
data cards rather than on GRIDF cards. Thus, the locations of the GRIDF points
will be exactly the same as the locations of the corresponding GRIDS points.

   Various standard NASTRAN data cards may be used for special purposes in
acoustic analysis. The SPC1 data card may be used to constrain the pressures
to zero at specified points such as at a free boundary. The formats for these
cards are included in Section 2.4. Dynamic load cards, direct input matrices,
and scalar elements may be introduced to account for special effects. The
reader is referred to Sections 1.4 and 1.5 for instruction in the use of these
cards.

## 1.9.2  Assumptions and Limitations

   The accuracy of the acoustic model will be dependent on the selection of
the mesh of finite elements. The assumption for each element is that the
pressure field has a linear variation over the cross section and a sinusoidal
variation around the axis in the circumferential direction. In areas where the
pressure gradient changes are large, such as near a sharp corner, the points
in the mesh should be placed closer together so that large changes in flow may
be defined accurately by the finite elements.

   The shapes of the finite elements play an important part in the accuracy of
the results. It has been observed that long narrow elements produce
disproportionate errors. Cutting a large square into two rectangles will not
improve the results, whereas dividing the square into four smaller squares may
decrease the local error by as much as a factor of ten.

   The slot portion of the cavity is limited to certain shapes because of
basic assumptions in the algorithms. The cross section of the cavity normal to
the axis must have a shape that is reasonably well defined by a central
circular cavity having equally spaced, narrow slots. Various shapes are shown
in Figure 1.9-1 in the order of increasing expected error.

   It is recommended that shapes such as the cloverleaf and square cross
section be analyzed with a full three dimensional technique. The assumption of
negligible pressure gradient in the circumferential direction within a slot is
not valid in these cases.

   The harmonic orders of the solutions are also limited by the width of the
slots. The harmonic number, N, should be no greater than the number of slots
divided by two. The response of the higher harmonics is approximated by the
slot width correction terms discussed in the NASTRAN Theoretical Manual,
Section 17.1.

   The output data for the acoustic analysis consists of the values of
pressure in the displacement vector selected via the case control card
"PRESSURE = i". The velocity vector components corresponding to each mode may
be optionally requested by the case control card "STRESS = i", where i is the
set number indicating the element numbers to be used for output, or by the
words "STRESS = ALL". The "SET =" card lists the element or point numbers to
be output.

   Plots of the finite element model and/or of the pressure field may be
requested with the NASTRAN plot request data cards. The central cavity cross
section will be positioned in the XY plane of the basic coordinate system of
NASTRAN. The slot elements are offset from the XY plane by the width of the
slot in the +Z direction. The radial direction corresponds to X and the axial
direction corresponds to the Y direction. Pressures will be plotted in the Z
direction for both the slot points and the central cavity points. The case
control data cards for plotting are documented in User's Manual. The PLOTEL
elements are used for plotting the acoustic cavity shape. The plot request
card "SET n INCLUDE PLOTEL" must be used, where n is a set number.

               This figure is not included in the machine readable
               documentation because of complex graphics.

               Figure 1.9-1. Modeling errors for various shapes


# 1.10  SUBSTRUCTURING

   Substructuring is an analytical technique used to facilitate the solution 
of structural problems by subdividing the structural models into smaller, more 
manageable components. The most elementary component, or basic substructure, 
is modeled separately just as any finite element model would be. These basic 
substructures are combined to build more complex substructures which, in turn, 
can be progressively combined with other substructures in stages to eventually 
arrive at the final desired solution model. Once the solution model is 
analyzed, the results at each stage of the combination process may be 
recovered until, ultimately, the detailed solution data are recovered for each 
of the original basic substructures. In effect, substructuring is an extension 
of basic finite element theory itself, whereby the usual simple beam, plate, 
and solid elements are replaced by basic substructures which themselves may be 
viewed as components of even more complex substructures. 

   Substructure analysis is logically performed in at least three phases as 
follows: 

   Phase 1     Analysis of each individual substructure by NASTRAN to produce 
               a description, in matrix terms, of its properties as seen at 
               the boundary degrees of freedom, ua. 

   Phase 2     Combination of the matrix properties from Phase 1 and the 
               inclusion, if desired, of additional terms to form a 
               "pseudostructure," which is then analyzed by NASTRAN. 

   Phase 3     Completion of the analysis of individual substructures using 
               the {ua} vector produced in Phase 2. 

   To provide maximum program flexibility, both the manual and automated 
approaches to substructuring are available. The manual approach requires user-
generated DMAP alters and can be used in all Rigid Formats except for 
piecewise linear analysis. The procedures for single-stage, manual 
substructuring are discussed and illustrated with a complete and fully 
annotated example of the input in Section 1.10.1. In Section 1.10.2, the 
automated multi-stage substructuring capabilities available for Rigid Formats 
1, 2, 3, 8, and 9 are presented. 

   Unlike the manual substructuring procedures, the automated capabilities 
provide for: 

   1.  Simple commands to control execution and data recovery at all stages of 
       analysis. 

   2.  Automatically generated DMAP alters.

   3.  Automated procedures to control and maintain the extensive data files 
       required. 

   4.  Data storage on single direct access file (minimizes or eliminates 
       checkpoint/restart tapes). 

   5.  Data transfer among IBM, CDC, or UNIVAC computers at any stage in the 
       analysis. 

   6.  No restrictions on grid point and element numbering. 

   7.  Modeling only one of two or more identical substructure components. 

   It should be noted that cyclic symmetry is available as an alternate 
formulation for substructuring structures with rotational or dihedral 
symmetry. This capability is described in Section 1.12. The more general 
approaches are described below, starting with the manual, single-stage 
substructuring, followed by the automated multi-stage substructuring 
capabilities. 

## 1.10.1  Manual Single-Stage Substructuring

   The theoretical basis for NASTRAN manual substructuring is given in Section 
4.3 of the Theoretical Manual. This technique may be used with any of the 
rigid formats, except Piecewise Linear Analysis. The following sections 
present instructions, including DMAP ALTERs for use with two of the rigid 
formats, static analysis and normal modes analysis. 

   Manual substructure analysis, as here defined, is a procedure in which the 
structural model is divided into separate parts which are then processed in 
separate computer executions to the point where the data blocks required to 
join each part to the whole are generated. The subsequent operations of 
merging the data for the substructures and of obtaining solutions for the 
combined problem are performed in one or more subsequent executions, after 
which detailed information for each substructure is obtained by additional 
separate executions. 

   The NASTRAN Data Deck for each of the substructures is constructed in the 
same manner as a NASTRAN analysis without substructuring. The following 
restrictions must be considered when forming the NASTRAN Data Deck for each of 
the substructures: 

   1.  All points on boundaries between substructures which are to be joined 
       must have their free (unconstrained) degrees of freedom placed in the 
       a-set. 

   2.  The sequence of internal grid point identification numbers along the 
       boundary between any two substructures must be in the same order. The 
       internal sequence is the external sequence modified by any SEQGP cards. 
       For example, if one substructure had boundary grid point internal 
       identification numbers of 3, 4, 9, 27, and 31, the adjoining 
       substructure could have a corresponding set of internal grid point 
       identification numbers of 7, 11, 21, 22, and 41, but not 7, 11, 22, 21, 
       and 41. This restriction is automatically satisfied if the same grid 
       point numbers, without SEQGP cards, are used on the boundaries for 
       connected substructures. 

   3.  The displacement coordinate system for each group of connected grid 
       points on the boundaries between substructures must be the same. 

   4.  Elements located on the boundary may be placed in either adjacent substructure.

   5.  The loads applied to boundary points may be arbitrarily distributed 
       between the adjoining substructures. Care should be exercised not to 
       duplicate the loads by placing the entire load on each substructure. 

   6.  The constrained stiffness matrix, [Koo], for each substructure must be 
       non-singular. This requirement is automatically satisfied in most 
       cases, since usually there are enough degrees of freedom on the 
       boundary of the substructure to account for its rigid body motions. In 
       exceptional cases, such as when the substructure is a hinged appendage, 
       it may be necessary for you to assign additional degrees of freedom to 
       ua, rather than uo, via ASET cards. 

   Although the following discussion is limited to single-stage 
substructuring, there is no inherent restriction on the use of multi-stage 
substructures in NASTRAN. In multi-stage substructuring, some of the 
substructures are precombined in Phase 2 to form intermediate substructures. 
The final combination in Phase 2 then consists of joining two or more 
intermediate substructures. This procedure will be useful if there are several 
substructures in the model, and changes are made in only one or a few 
substructures. In this case, the amount of effort and computer time required 
for changes in the model can be substantially reduced if the unchanged 
substructures are initially combined into a single intermediate substructure. 

### 1.10.1.1  Basic Manual Substructure Analysis

   Basic manual substructure analysis will be described with reference to the 
simple beam structure shown in Figure 1.10-1. The beam is arbitrarily 
separated into two substructures, referred to as substructure 1 and 
substructure 2, with a single boundary point being located at grid point 3. 
The beam is supported at grid points 1 and 6. No loads are applied to 
substructure 1. A single load is applied to substructure 2 at grid point 4, 
and a single load is applied at the boundary to grid point 3. 

   The complete NASTRAN Data Decks for all three phases of a substructure 
analysis for the beam shown in Figure 1.10-1 are presented in Tables 1.10-1, 
1.10-3, 1.10-5, 1.10-7, and 1.10-9. The integers in the left-hand column are 
used to relate the respective discussions in Tables 1.10-2, 1.10-4, 1.10-6, 
1.10-8, and 1.10-10 to the cards in the NASTRAN Data Decks. 

   It should be noted that no output has been requested in the Case Control 
Deck for substructure 1. If you want to have a plot of the undeformed 
structure for checking the model, a Plot Package can be inserted in the Case 
Control Deck in the usual way, as described in Section 4.2. 

   The partitioning matrix gives the relationship between the internal indices 
associated with the a-set matrices generated in Phase 1 and the external grid 
point component definition given on the GRID cards that are input to Phase 1 
as modified by any SEQGP cards. The same internal indices in Phase 1 for the 
a-set are redefined in Phase 2 as the indices for the g-set. The word 
"pseudostructure" is associated with the g-size matrices used in Phase 2. 

   The partitioning matrix for the problem under consideration is given as 
follows: 

                              PARTITIONING MATRIX

                                           External Grid-Component

   Internal Index                  Substructure 1         Substructure 2

         1                              3-1                    3-1

         2                              3-2                    3-2

         3                              3-6                    3-6

The procedure for constructing a partitioning matrix is as follows:

   1.  Select any one of the substructures and list the components of the a-
       set in sequence by grid point and component number as modified by any 
       SEQGP cards (internal sequence). These are the nonzero entries in the 
       partitioning vector for the first substructure. 

   2.  Build the second column of the partitioning matrix by selecting any 
       connected substructure and entering the connected components in the 
       same row as the associated components in the first substructure. 

   3.  Enter all unconnected a-set components in unoccupied rows of the 
       partitioning matrix according to their internal sequence numbers. 
       Unconnected members of the a-set having internal sequence numbers in 
       the range of the connected components will create new intermediate rows 
       in the previously formed columns of the matrix. 

   4.  Build the remaining columns of the partitioning matrix, one for each 
       substructure, by following a similar procedure for all remaining 
       substructures. In each case, first enter all components that are 
       connected to the previously selected substructure or substructures, 
       followed by the remaining unconnected components in their internal 
       sequence. 

   5.  The rows of the partitioning matrix are associated with the sequence of 
       the internal indices for the scalar points in the pseudostructure. Any 
       sequential set of integers may be used to identify these scalar points 
       in Phase 2. 

   6.  The columns of the partitioning matrix (one vector for each 
       substructure) are input with Direct Matrix Input (DMI) cards. The input 
       matrix contains real 1's in all locations in the partitioning matrix 
       having grid point-component entries. See Section 2.4 for DMI card 
       format. 

   The DMI cards (121 and 122 in Table 1.10-1) in the sample problem give the 
name E1 to the partitioning vector for substructure 1. The first card defines 
the partitioning vector as being rectangular and consisting of real single-
precision entries. The next-to-the-last entry on the first card indicates 
there are three rows in the g-set matrices input to Phase 2. The second 
integer 1 on the second card indicates that the first internal index is 
associated with one of the components in substructure 1; in this case, grid 
point 3, component 1. The three real 1.0's indicate the first three internal 
indices are associated with components in substructure 1; in this case, grid 
point 3, components 1, 2, and 6. In this particular case, only the initial two 
steps are required to construct the partitioning matrix, and the partitioning 
vector for substructure 2 will be identical to that for substructure 1. This 
results from the fact that the single boundary point in this problem is a part 
of both substructures. 

   The partitioning vectors are not needed until Phase 2. They were 
arbitrarily input to Phase 1 so they could be included on the User Tape, along 
with the output matrices from Phase 1. 

   The NASTRAN Data Deck for substructure 2 is given in Table 1.10-3. For 
identification purposes, the cards are arbitrarily numbered beginning with 
150. 

   The Phase 2 operations are concerned with merging the a-set matrices 
generated in Phase 1 which define the g-size pseudostructure in Phase 2. The 
NASTRAN Data Deck for Phase 2 is given in Table 1.10-5. The cards are 
arbitrarily numbered beginning with 201. 

   Although the data deck shown in Table 1.10-5 is prepared for two 
substructures, it was constructed in such a manner that it could be easily 
extended to more than two substructures. If there are more than two 
substructures, cards similar to 216 to 222, 232, and 233 need to be added to 
the NASTRAN data deck for each additional substructure. 

   The final part of a substructure analysis is to perform data recovery for 
each substructure of interest. These runs are made as a restart of the Phase 1 
runs. Any of the normal rigid format output can be requested, including both 
undeformed and deformed structure plots. All of the output will be in terms of 
the elements and grid points defined in the Phase 1 Bulk Data Decks. The 
NASTRAN Data Deck for the Phase 3 analysis of substructure 1 is given in Table 
1.10-7. 

   The NASTRAN data deck for the Phase 3 analysis of substructure 2 is given 
in Table 1.10-9. Comments are restricted to cards that are different from 
those presented for the Phase 3 run of substructure 1. 

1.10.1.2  Loads and Boundary Conditions
---------------------------------------
   The single load and the single boundary condition for the sample problem 
defined in Section 1.10.1.1 were introduced in Phase 1. It is also possible to 
introduce loads and boundary conditions in Phase 2. In this case, the loaded 
and/or constrained degrees of freedom must be included in the a-set for Phase 
1, so they will be a part of the pseudostructure in Phase 2. Loads are applied 
to the pseudostructure in Phase 2 with the SLOAD card. This limits the type of 
load that can be applied in Phase 2 to directly applied loads. Other loading 
conditions depending on element properties or connection data, such as thermal 
loads, gravity loads, and pressure loads, must be applied in Phase 1. Loads 
may be introduced in both Phases 1 and 2, as the suggested DMAP sequence will 
add contributions to the load vector from both phases. The lack of generality 
for the application of loads in Phase 2 will often dictate that static loads 
be applied in Phase 1. 

   The loads and boundary conditions for the sample problem can be applied in 
Phase 2 if the modifications shown in Tables 1.10-11 and 1.10-12 are made to 
the NASTRAN Data Decks presented in Section 1.10.1.1. 

   The modified partitioning matrix with grid points 1, 3, 4, and 6 in the a-
set is shown below. 

                              PARTITIONING MATRIX

                                              External Grid-Component

   Internal Index                     Substructure 1          Substructure 2

          1                                 1-1

          2                                 1-2

          3                                 1-6

          4                                 3-1                   3-1

          5                                 3-2                   3-2

          6                                 3-6                   3-6

          7                                                       4-1

          8                                                       4-2

          9                                                       4-6

         10                                                       6-1

         11                                                       6-2

         12                                                       6-6

   The modified partitioning matrix contains twelve scalar points, with six in 
substructure 1, nine in substructure 2, and three common to both 
substructures. The loads are now located at scalar points 5 and 8, as 
indicated on card 246a. The single-point constraints are located at scalar 
points 1, 2, and 11, as indicated on card 246b. The modified partitioning 
vector for substructure 1 indicates there are twelve degrees of freedom in the 
pseudostructure, and that, beginning with the first scalar point, there are 
six scalar points associated with substructure 1. The modified partitioning 
vector for substructure 2 indicates the first entry is associated with scalar 
point 4, and that there are a total of nine scalar points associated with 
substructure 2. 

   If multiple loading conditions are used in the solution, the subcase 
structure must be established in Phase 1. In order to perform the matrix 
operations in Phase 2, the same case control structure must be used for all 
substructures. This means that the same number of sub-cases must be defined 
for each substructure, even though some of the subcases will not contain a 
load selection or any other entries. NASTRAN will generate a null column in 
the load matrix for all subcases for which no load set is selected. If any 
loads are applied in Phase 2, the same subcase structure must be used in Phase 
2. In any event, the subcase structure established in Phase 1 must be used in 
Phase 3. The contents of each subcase in Phase 3 will relate to output 
selections, rather than load and boundary condition selections. 

   Consider adding two additional loading conditions to the sample problem in 
Section 1.10.1.1. If one additional loading condition were applied to 
substructure 1, identified as 202, and one additional loading to substructure 
2, identified as 203, the subcase structure established in Phase 1 would 
appear as follows: 

   Substructure 1                  Substructure 2

      SPC = 101                       SPC = 201

      SUBCASE 1                       SUBCASE 1

                                         LOAD = 201

      SUBCASE 2                       SUBCASE 2

         LOAD = 202

      SUBCASE 3                       SUBCASE 3

                                         LOAD = 203

   Load case 202 would have to be defined with some form of static loading in 
the Bulk Data Deck for Phase 1 of substructure 1. In addition, load set 203 
would have to be defined with some form of static loading in the Bulk Data 
Deck for Phase 1 of substructure 2. 

   The DMAP sequence for the sample problem in Section 1.10.1.1 will not 
support multiple boundary conditions in Phase 1. If multiple boundary 
conditions are introduced in Phase 1, it is necessary to generate a separate 
partitioning vector for use in Phase 2 for each of the unique boundary 
conditions. In some sense, this results in the definition of a number of 
separate problems equal to the number of unique boundary conditions. Although 
a DMAP sequence could be developed to support multiple boundary conditions in 
Phase 1, it is not recommended that multiple boundary conditions be introduced 
into Phase 1. 

   Multiple boundary conditions may be introduced in Phase 2 without any 
difficulty. However, in order to handle the internal looping for each boundary 
condition, it is more convenient if the loads are also introduced in Phase 2. 
As indicated earlier, the introduction of loads in Phase 2 does limit the 
manner in which the static loads can be defined. If the loads and boundary 
conditions are introduced in Phase 2, all of the case control options for 
combining subcases, including symmetry combinations, may be used in the usual 
manner. 

   It is possible to introduce the loads in Phase 1 and multiple boundary 
conditions in Phase 2. However, provision must be made to generate all loading 
conditions in Phase 1, which will automatically take place if one subcase is 
defined for each loading condition and no boundary conditions are mentioned in 
the Phase 1 Case Control Deck. It is then necessary in Phase 2 to partition 
out the proper columns of the loading matrix for each loop or boundary 
condition in Phase 2. This requires that you construct the proper partitioning 
vector for each boundary condition. Also, appropriate modifications would have 
to be made to the suggested DMAP sequence for Phase 2. 

### 1.10.1.3  Normal Modes Analysis

   Substructuring for normal modes analysis is performed in much the same way 
as that for static analysis. A NASTRAN Data Deck for use in Phase 1 of a 
Normal Modes Analysis (Rigid Format 3) is shown in Table 1.10-13. 

   Note that the OUTPUT1 module writes the mass matrix, as well as the 
stiffness matrix and partitioning vector, on User Tape 1. The Case Control 
Deck is similar to the Phase 1 deck for static analysis. It must include a 
constraint selection if the boundary conditions are applied in Phase 1. The 
Bulk Data Deck is also similar to that used in Phase 1 for static analysis. In 
general, it includes all the cards associated with the definition of the model 
and the DMI cards for the definition of the partitioning vector. It will also 
include cards for the definition of the a-set and other constraint cards if 
the boundary conditions are applied in Phase 1. As in static analysis, one 
such deck must be prepared for each substructure. 

   The NASTRAN Data Deck for Phase 2 of Normal Modes Analysis with two 
substructures is shown in Table 1.10-14. 

   The Phase 2 NASTRAN Data Deck for Normal Modes Analysis is similar to that 
used for Static Analysis. The following comments are related to differences in 
the two decks: 

   1.  Since there are no loads associated with a normal modes analysis, the 
       module GP3 is not executed. 

   2.  The same operations are performed on the mass matrix as are performed 
       for the stiffness matrix. 

   3.  The data block LAMA (eigenvalue summary) is written as the first data 
       block on User Tape 3. This is followed by the appropriate partitions of 
       the eigenvectors for each of the substructures. 

   4.  The Case Control Deck must include a method selection for eigenvalue 
       extraction. 

   5.  The Bulk Data Deck is similar to that used in static analysis, except 
       that a null matrix must be defined for the mass matrix, instead of the 
       load matrix (since matrix assembly is not required), and an EIGR card 
       must be included. 

   The Phase 3 data deck for Normal Modes Analysis, given in Table 1.10-15, is 
similar to that used for Static Analysis. The first reference to module 
INPUTT1 is to read the data block LAMA, which is the first data block on User 
Tape 3. The second reference to INPUTT1 is to read the proper partition of the 
eigenvectors. The zero parameter at the end of the statement should be 
incremented one for each substructure in order to point to the proper 
eigenvector partition. 

### 1.10.1.4  Dynamic Analysis

   Manual substructuring may be used with any of the other dynamics rigid 
formats. The NASTRAN Data Decks will be similar to those used for Normal Modes 
Analysis. All dynamic loads must be applied in Phase 2. If the SUPORT card is 
needed to define free body motions for the structure as a whole, it must be 
included in Phase 2. 

   In dynamic analysis, the a-set will include, in addition to all points on 
the boundary of the substructure, a number of points within each substructure 
sufficient to define the dynamic response. Since all active degrees of freedom 
along interior boundaries must be included in ua, the a-set will contain more 
degrees of freedom than are needed in dynamic analysis, with a large resulting 
inefficiency for a very small gain in accuracy. This is a serious 
consideration because, due to the high density of Kaa, the time to perform 
most of the significant matrix operations in Phase 2 increases nearly as the 
cube of the number of degrees of freedom in ua. The situation can be greatly 
improved by a second stiffness reduction in Phase 2, in which ua is 
partitioned into a set, uc, that will be retained in dynamic analysis, and a 
set, ub, that will be eliminated. The ub set includes the excess degrees of 
freedom on the interior boundaries. The second stiffness reduction in Phase 2 
is defined by listing the members of the ub set that will be eliminated on 
OMIT cards. These omitted degrees of freedom must reference the scalar points 
associated with the pseudostructure. 

   In Phase 3 for dynamics, each NASTRAN substructure is restarted with the 
partition of the Phase 2 solution vector, or eigenvector, for each 
substructure. All normal data reduction procedures may then be applied. In 
dynamic analysis, Phase 3 can be omitted if output requests are restricted to 
the response quantities for the scalar points of the pseudostructure. In this 
case, the output and partition modules can be omitted from the Phase 2 runs, 
as their only purpose is to serve as input for the Phase 3 runs. If output is 
desired for dependent response quantities or element stresses and forces, a 
Phase 3 run must be made for each substructure of interest. 

### 1.10.1.5  DMAP Loops for Phase 2

   The DMAP sequences for the substructure example in Section 1.10.1.1 use 
repeated blocks of code for each substructure. Cards 209 through 215 are 
associated with input for substructure 1. Cards 216 through 222 perform the 
same operations for substructure 2. Likewise, cards 230 and 231 are associated 
with output for substructure 1, and cards 232 and 233 are associated with 
output for substructure 2. If a large number of substructures is used, it is 
more convenient to use a DMAP loop, rather than repeating blocks of code. DMAP 
loops are constructed by placing a LABEL statement at the beginning of the 
loop and a REPT statement at the end of the loop. The number of times the REPT 
statement must be executed is set by an integer constant. 

   The series of statements represented by cards 209 through 222 (in Table 
1.10-5) can be replaced with the following sequence of DMAP operations: 

   PARAM     // C,N,NOP / V,N,INP=1 $
   LABEL     BLOCK1 $
   INPUTT1   / E,KGGA,PGA,, / C,N,-3 / V,N,INP $
   MERGE,    ,,,KGGA,E, / KGGTA $
   ADD       KGG,KGGTA / KTA $
   EQUIV     KTA,KGG / TRUE $
   MERGE,    ,PGA,,,,E / PGTA / C,N,1 $
   ADD       PGT,PGTA / PTA $
   EQUIV     PTA,PGT / TRUE $
   PARAM     // C,N,ADD / V,N,INP / V,N,INP / C,N,1 $
   REPT      BLOCK1,1 $

   The LABEL BLOCK1 is shown at the beginning of the loop, and the REPT 
statement is shown at the end. The integer in the REPT statement is set to one 
less than the number of substructures, which in this case is one. The PARAM 
statement preceding the REPT statement is used to increment the second 
parameter of INPUTT1 by one each time through the loop. This causes the 
information to be read from a different tape each time through the loop. This 
DMAP loop does not check the label before reading the information on the input 
tape. The fact that the same names are used for the matrices each time through 
the loop does not cause any difficulty, as the matrices are located by their 
position on the tape, rather than by name. 

   If a DMAP loop is used for the input sequence, consideration must be given 
to its effect on the output sequence. Since the partitioning vectors were not 
saved on each pass through the DMAP loop for the input sequence, it is 
necessary to recover this information for use in the output sequence. This 
might be done by rerunning INPUTT1 to reread the partitioning vectors as 
needed, or perhaps by inserting the DMI cards for the partitioning vectors in 
the Bulk Data Deck for Phase 2. If Phase 3 runs are not required, no output 
sequence is necessary. 

### 1.10.1.6  Identical Substructures

   In the case of identical substructures, the substructuring procedures can 
be organized to take full advantage of the repetitive parts. The substructures 
only have to appear identical in Phase 1. The loading conditions and boundary 
conditions used in Phase 2 may be quite different for the otherwise identical 
substructures. The Phase 1 substructures must have identical geometry, 
including the global coordinate systems used on the boundary grid points. 

   Only a single Phase 1 run is made for each group of identical 
substructures. Since the identical substructures will be coupled in different 
ways during Phase 2, a different partitioning vector must be generated for 
each use of the identical substructures in Phase 2. These multiple 
partitioning vectors can be placed on the same output tape from Phase 1, which 
also contains the single set of structural and loading matrices for the group 
of identical substructures. 

   You may choose to make one or more Phase 3 runs for the members of a group 
of identical substructures. If the loading conditions and boundary conditions 
are also identical for the group of identical substructures, a single Phase 3 
run will give all information of interest. However, if the boundary conditions 
and/or loading conditions are different for the various members of the group 
of identical substructures, it will probably be desirable to make a separate 
Phase 3 run for each of the substructures used in the complete structural 
model. 

   The use of identical substructures not only saves time in computer runs for 
Phase 1 and perhaps for Phase 3, but also substantially reduces the effort 
associated with the preparation of the structural model in the Bulk Data Deck. 
In some sense, substructuring procedures with identical substructures can be 
thought of as being a form of data generation. Although substructuring is 
usually used because of problem size, it may be desirable, in some cases, to 
use substructuring because of the repetitive nature of the structure, and a 
consequent saving in data generation effort. 


            Table 1.10-1. Data Deck for Phase 1 of Substructure 1.

100  NASTRAN    FILES = (INPT,NPTP)
101  ID         PHASE,ONE $ SUBSTRUCTURE 1
102  TIME       2
103  CHKPNT     YES
104  APP        DISP
105  SOL        1,9
106  ALTER      n1 $ (where n1 = DMAP statement number of EQUIV KAA,KLL/REACT)
107  JUMP       LBL7 $
108  ALTER      n2 $ (where n2 = DMAP statement number of LABEL LBL10)
109  FBS        LOO,UOO,PO/UOOV $
110  CHKPNT     UOOV $
111  OUTPUT1    E1,KLL,PL,,//C,N,-1/C,N,0/C,N,USERTP1 $
112  ALTER      n3,n4 $ (where n3 = DMAP statement number of SSG3 module and
                               n4 = DMAP statement number of REPT LOOPTOP,360)
113  ENDALTER
114  CEND
115  TITLE = PHASE ONE - SUBSTRUCTURE 1
116  SPC = 101
117  BEGIN BULK

     1       2       3       4       5       6       7       8       9       10

118  ASET    3       126
119  CBAR    1       10      1       2               1.0             1
120  CBAR    2       10      2       3               1.0             1
121  DMI     E1      0       2       1       1               3
122  DMI     E1      1       1       1.0     1.0     1.0
123  GRID    1                                               345
124  GRID    2               240.                            345
125  GRID    3               480.                            345
126  MAT1    11      30.+6
127  PBAR    10      11      60.     500.
128  SPC     101     1       12
129  ENDDATA


Table 1.10-2. Comments for Phase 1, Substructure 1 Data Deck.

Card
No.      Refer to Table 1.10-1 for input cards described below.

 103     This run will be checkpointed, so that a restart can be made for Phase
         3. You must allocate space for the checkpoint file, NPTP. (The
         NPTP file is presumed to be copied to tape at the end of the job.)

 105     Rigid Format 1, Static Analysis, will be used for this problem without
         property optimization.

 106     Insert the following statement after DMAP statement EQUIV
         KAA,KLL/REACT.

 107     Jump around the Rigid Body Matrix Generator modules. The solution for
         {ua} will be performed in Phase 2.

 108     Insert the following three statements after DMAP statement LABEL LBL10.

 109     Use the module FBS to solve for {uoo} the displacement of the o-set
         relative to the a-set points.

 110     Write displacement vector UOOV on the New Problem Tape.

 111     Use the module OUTPUT1 to write the DMI matrix given on cards 121 and
         122, along with the stiffness matrix KLL, and the load vector PL on
         User Tape 1 (USERTP1). You must allocate space for the User Tape
         file, INPT. (The INPT file is presumed to be copied to tape at the end
         of the job.) The details of the call for DMAP module OUTPUT1 and other
         DMAP information are given in Section 5.

 112     Delete the data recovery modules (SSG3 through REPT LOOPTOP,360).

 116     Select single-point constraint set 101.

 118     Defines grid point 3 as a boundary point between substructures.

 119     Connection cards defining bar elements in substructure 1.
 120

 121     Direct Matrix Input cards that define the partitioning vector for use
 122     in Phase 2. The entries on these cards are discussed below.

 123
 124     These cards define the grid points in substructure 1.
 125

 126     Defines the material for the elements in substructure 1.

 127     Defines the properties of the elements in substructure 1.

 128     Defines single-point constraint set 101. Components 1 and 2 are
         constrained at grid point 1 in substructure 1.


Table 1.10-3. Data Deck for Phase 1, Substructure 2.

150a NASTRAN    FILES = (INPT,NPTP)
150b ID         PHASE,ONE $ SUBSTRUCTURE 2
151  TIME       2
152  CHKPNT     YES
153  APP        DISP
154  SOL        1,9
155  ALTER      n1 $ (where n1 = DMAP statement number of EQUIV KAA,KLL/REACT)
156  JUMP       LBL7 $
157  ALTER      n2 $ (where n2 = DMAP statement number of LABEL LBL10)
158  FBS        LOO,UOO,PO/UOOV $
159  CHKPNT     UOOV $
160  OUTPUT1    E2,KLL,PL,,//C,N,-1/C,N,0/C,N,USERTP2 $
161  ALTER      n3,n4 $ (where  n3 = DMAP statement number of SSG3 module and
                                n4 = DMAP statement number of REPT LOOPTOP,360)
162  ENDALTER
163  CEND
164  TITLE = PHASE ONE - SUBSTRUCTURE 2
165  SPC = 201
166  LOAD = 202
167  BEGIN BULK

     1       2       3       4       5       6       7       8       9       10

168  ASET    3       126
169  CBAR    3       10      3       4               1.0             1
170  CBAR    4       10      4       5               1.0             1
171  CBAR    5       10      5       6               1.0             1
172  DMI     E2      0       2       1       1               3       1
173  DMI     E2      1       1       1.0     1.0     1.0
174  FORCE   202     3               1000.           -1.0
175  FORCE   202     4               1000.           -1.0
176  GRID    3               480.                            345
177  GRID    4               720.                            345
178  GRID    5               960.                            345
179  GRID    6               1200.                           345
180  MAT1    11      30.+6
181  PBAR    10      11      60.     500.
182  SPC     201     6       2
183  ENDDATA

Table 1.10-4. Comments for Phase 1, Substructure 2 Data Deck.

Card
No.      Refer to Table 1.10-3 for input cards described below.

 160     The partitioning vector for substructure 2 is written on User Tape 2
         and is named E2. You must allocate space for User Tape file INPT.
         (The INPT file is presumed to be copied to tape at the end of the job.)
         It is possible to change the OUTPUT1 statement and write the results
         for substructure 2 on the same tape as for substructure 1, if desired.

 165     Selects single-point constraint set 201.

 166     Selects load set 202.

 172     Other than the name E2, the partitioning vector is identical to that
 173     for substructure 1.

 174     Defines the external loads in load set 202. The load applied to grid
 175     point 3 has arbitrarily been placed in substructure 2.

 182     Defines single-point constraint set 201 at grid point 6, component 2.

Table 1.10-5. Data Deck for Phase 2

200  NASTRAN    FILES = (INPT,INP1,1NP2)
201  ID         PHASE,TWO
202  TIME       2
203  APP        DISP
204  SOL        1,9
205  ALTER      n0 $ (where n0 = DMAP statement number of the BEGIN statement)
206  PARAM      //C,N,NOP/V,N,TRUE=-1 $
207  ALTER      n1,n2 $ (where n1 = DMAP statement number of module GP2 and
                               n2 = DMAP statement number of LABEL P1)
208  ALTER      n3,n4 $ (where n3 = DMAP statement number of PARAM just before
                                    TA1 and
                               n4 = DMAP statement number of LABEL LBL11A)
209  INPUTT1    /E01,KGG01,PG01,,/C,N,-1/C,N,1/C,N,USERTP1 $
210  MERGE,     ,,,KGG01,E0l,/KGGT01 $
211  ADD        KGG,KGGT01/KT01 $
212  EQUIV      KT01,KGG/TRUE $
213  MERGE,     ,PG0l,,,,E01/PGT01/C,N,1 $
214  ADD        PGT,PGT01/PT01 $
215  EQUIV      PT01,PGT/TRUE $
216  INPUTT1    /E02,KGG02,PG02,,/C,N,-1/C,N,2/C,N,USERTP2 $
217  MERGE,     ,,,KGG02,E02,/KGGT02 $
218  ADD        KGG,KGGT02/KT02 $
219  EQUIV      KT02,KGG/TRUE $
220  MERGE,     ,PG02,,,,E02/PGT02/C,N,1 $
221  ADD        PGT,PGT02/PT02 $
222  EQUIV      PT02,PGT/TRUE $
223  ALTER      n5,n6 $ (where n5 = DMAP statement number of COND LBL4,GENEL and
                               n6 = DMAP statement number of LABEL LBL4)
224  ALTER      n7,n7 $ (where n7 = DMAP statement number of module SSG1)
225  SSG1       SLT,BGPDT,CSTM,SIL,,MPT,,EDT,,CASECC,DIT/PG/V,N,LUSET/V,N,NSKIP
                $
226  ADD        PGT,PG/PGX $
227  EQUIV      PGX,PG/TRUE $
228  ALTER      n8,n9 $ (where n8 = DMAP statement number of the first SDR2
                                    module and
                               n9 = DMAP statement number of OFP just before
                                    XYTRAN)
229  OUTPUT1,   ,,,,//C,N,-1/C,N,0/C,N,USERTP3 $
230  PARTN      UGV,,E01/,ULV01,,/C,N,1 $
231  OUTPUT1    ULV01,,,,//C,N,0/C,N,0/C,N,USERTP3 $
232  PARTN      UGV,,E02/,ULV02,,/C,N,1 $
233  OUTPUT1    ULV02,,,,//C,N,0/C,N,0/C,N,USERTP3 $
234  SDR2       CASECC,CSTM,MPT,DIT,EQEXIN,SIL,,,BGPDT,PGG,QG,UGV,,/
                OPG1,OQG1,OUGV1,,,/C,N,STATICS $
235  OFP        OUGV1,OPG1,OQG1,,,//V,N,CARDNO $
236  ALTER      n10,n11 $ (where n10 = DMAP statement number of COND
                                       LBLOFP,COUNT and
                                 n11 = DMAP statement number of OFP just before
                                       LABEL DPLOT)
237  ALTER      n12,n13 $ (where n12 = DMAP statement number of COND P2,JUMPPLOT
                                       and
                                 n13 = DMAP statement number of REPT
                                       LOOPTOP,360)
238  ALTER      n14,n15 $ (where n14 and n15 are the DMAP statement numbers of
                                 LABEL ERROR2 and the PRTPARM module immediately
                                 following it, respectively)
     ALTER      n16,n17 $ (where n16 and n17 are the DMAP statement numbers of
                                 LABEL ERROR4 and the PRTPARM module immediately
                                 following it, respectively)
239  ENDALTER
240  CEND
241  TITLE = PHASE TWO

Table 1.10-5. Data Deck for Phase 2 (continued)

242  BEGIN BULK
     1       2       3       4       5       6       7       8       9       10

243  DMI     KGG     0       6       1       2               3       3
244  DMI     KGG     1       1       0.0
245  DMI     PGT     0       2       1       2               3       1
246  DMI     PGT     1       1       0.0
247  SPOINT  1       THRU    3
248  ENDDATA

Table 1.10-6. Comments for Phase 2 Data Deck

Card
No.      Refer to Table 1.10-5 for input cards described below.

 204     Rigid Format 1, Static Analysis, will be used for this problem.

 205     Insert the following statement after DMAP statement No. 1.

 206     Define the parameter TRUE = -1.

 207     Delete the DMAP statements associated with the preparation of the
         Element Connection Table and structure plots (module GP2 through LABEL
         P1).

 208     Delete the DMAP statements associated with matrix assembly (PARAM just
         before TA1 through LABEL LBL11A).

 209     Insert the DMAP module INPUTT1 to read the partitioning vector, the
         stiffness matrix, and the load vector from User Tape 1. These matrices
         have been renamed E01, KGG01, and PG01, respectively. You must
         arrange to have the tape mounted that was prepared at the end of Phase
         1 run on substructure 1 copied to a file designated as INP1.

 210     Insert the module MERGE to change the a-set size of the stiffness
         matrix from Phase 1 to g-size for Phase 2, and designate the output as
         KGGT01. In this particular case, no change will take place, since the
         a-size from Phase 1 is the same as the g-size in Phase 2.

 211     Insert the module ADD to add the null matrix KGG, defined in the Bulk
         Data Deck, to KGGT01, and designate the output as KT01.

 212     Insert the module EQUIV to equivalence KT01 to KGG.

 213     Insert the module MERGE to change the a-size of the load vector from
         Phase 1 to g-size for Phase 2, and designate the output as PGT01. In
         this case, no change in size will take place.

 214     Insert the module ADD to add the null matrix PGT, defined in the Bulk
         Data Deck, to PGT01, and designate the output as PT01.

 215     Insert the module EQUIV to equivalence PT01 to PGT.

 216     Insert the module INPUTT1 to read the partitioning vector, the
         stiffness matrix, and the load vector from User Tape 2. These matrices,
         which were generated for substructure 2 in Phase 1, are redesignated as
         E02, KGG02, and PG02, respectively. You must arrange to have the
         tape mounted that was prepared at the end of the Phase 1 run for
         substructure 2 copied to a file designated as INP2.

 217     Insert the module MERGE to change the stiffness matrix for substructure
         2 from a-size in Phase 1 to g-size in Phase 2 and designate the output
         as KGGT02.

 218     Insert the module ADD to add the stiffness matrix for substructure 2 to
         the stiffness matrix for substructure 1, and designate the output as
         KT02.

 219     Insert module EQUIV to equivalence KT02 to KGG. The matrix KGG now
         represents the stiffness matrix for the pseudostructure, and will be
         used for input to Phase 2.

 220     Insert the module MERGE to change the load vector from a-size in Phase
         1 to g-size in Phase 2.

 221     Insert the module ADD to add the loads applied to substructure 2 to the
         load vector for substructure 1, and designate the output as PT02.

Table 1.10-6. Comments for Phase 2 Data Deck (continued)

Card
No.      Refer to Table 1.10-5 for input cards described below.

 222     Insert the module EQUIV to equivalence PT02 to PGT.

 223     Delete the DMAP statements associated with the Grid Point Singularity
         Processor (COND LBL4,GENEL through LABEL LBL4).

 224     Delete the SSG1 module.

 225     Insert the module SSG1 with the calling sequence modified to remove
         parts not associated with directly applied loads. Since, for this
         particular problem, all loads were applied in Phase 1, there will be no
         output from SSG1.

 226     Insert the module ADD to combine the load vector from Phase 2 with the
         load vectors generated in Phase 1, and designate the output as PGX.

 227     Insert the module EQUIV to equivalence PGX to PG. The data block PG now
         includes all loads from both Phase 1 and Phase 2, and will be used as
         input to Phase 3.

 228     Delete data recovery and OFP modules (the first SDR2 through the OFP
         just before XYTRAN).

 229     Insert the module OUTPUT1 to rewind User Tape 3 and place the label
         USERTP3 on this file. You must arrange a third file allocated
         which is designated as INPT. (It is presumed the INPT file will be
         copied to a tape at the end of the job.)

 230     Insert the module PARTN to separate that part of the solution vector
         UGV associated with substructure 1, and designate the output as ULV01.

 231     Insert the module OUTPUT1 to write the partition of the solution vector
         associated with substructure 1 on User Tape 3.

 232     Insert the module PARTN to separate that part of the solution vector
         associated with substructure 2, and designate the output as ULV02.

 233     Insert the module OUTPUT1 to write that part of the solution vector
         associated with substructure 2 on User Tape 3. This will place the
         solution vectors for both substructures on User Tape 3. (A second tape
         could be used for the solution vector for substructure 2 by changing
         the DMAP statement for OUTPUT1.)

 234     Insert the module SDR2 with the calling sequence modified to remove
         those parts associated with element output.

 235     Insert the module OFP with the calling sequence modified to remove
         those parts associated with element output.

 236     Remove OFP and additional DMAP statements (COND LBLOFP,COUNT through
         the OFP just before LABEL DPLOT).

 237     Remove the DMAP statements associated with the preparation of the
         deformed structure plots (COND P2,JUMPPLOT through REPT LOOPTOP,360).

 238     Remove the statements associated with ERROR2 and ERROR4.

 243     DMI cards used to define the null matrix KGG.
 244

 245     DMI cards used to define the null matrix PGT.
 246

 247     Definition of the three scalar points for the pseudostructure.

Table 1.10-7. Data Deck for Phase 3, Substructure 1

300  NASTRAN    FILES = (INPT,OPTP)
301  ID         PHASE,THREE $ SUBSTRUCTURE 1
302  TIME       2
303  APP        DISP
304  SOL        1,9
305  ALTER      n1,n2 $ (where  n1 = DMAP statement number of module GP3 and
                                n2 = DMAP statement number of LABEL LBL9)
306  INPUTT1    /,,,,/C,N,-1/C,N,0/C,N,USERTP3 $
307  INPUTT1    /ULV,,,,/C,N,0 $
308  ALTER      n3,n4 $ (where n3 = DMAP statement number of COND LBL8,REPEAT
                           and n4 = DMAP statement number of LABEL LBL8)
309  ALTER      n5,n6 $ (where n5 = DMAP statement number of JUMP FINIS and
                               n6 = DMAP statement number of LABEL FINIS)
310  ENDALTER
311    (Include Restart Dictionary from Phase 1)
312  CEND
313  TITLE = PHASE THREE - SUBSTRUCTURE 1
314  DISP = ALL
315  ELFORCE = ALL
316  OLOAD = ALL
317  SPCFORCE = ALL
318  BEGIN BULK
319     (No Bulk Data)
320  ENDDATA


Table 1.10-8. Comments for Phase 3, Substructure 1 Data Deck

Card
No.      Refer to Table 1.10-7 for input cards described below.

 304     Rigid Format 1, Static Analysis, will be used for this problem.

 305     Delete all parts of the rigid format, except the data recovery modules
         (GP3 through LABEL LBL9).

 306     Insert module INPUTT1 to rewind and check the label on User Tape 3. The
         user must arrange to have the tape mounted that was prepared at the end
         of the Phase 2 run copied to a file designated as INPT.

 307     Insert module INPUTT1 to read the solution vector for substructure 1
         from User Tape 3. The solution vector is designated as ULV for input to
         module SDR1.

 308     Remove additional DMAP statements not associated with data recovery
 309     operations (COND LBL8, REPEAT through LABEL LBL8, and JUMP FINIS
         through LABEL FINIS).

 311     Insert the Restart Dictionary punched during the Phase 1 run of
         substructure 1. You must arrange to have the checkpoint tape from
         the Phase 1 run for substructure 1 copied to a file OPTP for the
         restart.

 314     Request printed output for all displacements of substructure 1.

 315     Request printed output of forces for all elements in substructure 1.

 316     Request printed output of the load vector for substructure 1. In this
         particular case, no output will result because no loads were applied to
         substructure 1.

 317     Request printed output for all nonzero single-point forces of
         constraint on substructure 1.

 318     Beginning of Bulk Data Deck.

 319     No bulk data cards should be included in the Phase 3 run. However, the
         BEGIN BULK and ENDDATA cards must be present.

 320     End of NASTRAN Data Deck.


Table 1.10-9. Data Deck for Phase 3, Substructure 2

350a NASTRAN    FILES = (INPT,OPTP)
350b ID         PHASE,THREE $ SUBSTRUCTURE 2
351  TIME       2
352  APP        DISP
353  SOL        1,9
354  ALTER      n1,n2 $ (where n1 = DMAP statement number of module GP3 and
                               n2 = DMAP statement number of LABEL LBL9)
355  INPUTT1    /,,,,/C,N,-1/C,N,0/C,N,USERTP3 $
356  INPUTT1    /ULV,,,,/C,N,1 $
357  ALTER      n3,n4 $ (where n3 = DMAP statement number of COND LBL8,REPEAT
                           and n4  = DMAP statement number of LABEL LBL8)
358  ALTER      n5,n6 $ (where n5  = DMAP statement number of JUMP FINIS and
                               n6  = DMAP statement number of LABEL FINIS)
359  ENDALTER
360    (Include Restart Dictionary from Phase 1)
361  CEND
362  TITLE = PHASE THREE - SUBSTRUCTURE 2
363  DISP = ALL
364  ELFORCE = ALL
365  BLOAD = ALL
366  SPCFORCE = ALL
367  BEGIN BULK
368     (No Bulk Data)
369  ENDDATA

Table 1.10-10. Comments for Phase 3, Substructure 2 Data Deck

Card
No.      Refer to Table 1.10-9 for input cards described below.

 355     Insert module INPUTT1 to rewind User Tape 3. You must arrange to
         have the tape mounted that was prepared at the end of the Phase 2 run
         copied to a file, INPT, if it is not already available as a result of
         the previous run on substructure 1.

 356     Insert module INPUTT1 to skip over the solution vector for substructure
         1 on User Tape 3, and read the solution vector for substructure 2.

 365     The request for printed output of the load vectors will show nonzero
         loads applied to grid points 3 and 4.

Table 1.10-11. Instructions for Modified Phase 2 Data Deck

 1. Remove card 116, SPC set selection for Phase 1 substructure 1, and request
    SPC set 201 after card 241.

 2. Replace card 118 as shown in Table 1.10-12 to redefine the a-set for
    substructure 1.

 3. Replace cards 121 and 122 with cards 121, 122, and 122a shown in Table 
    1.10-12 to redefine the partitioning vectors for substructure 1. 

 4. Card 128 is not required, SPC set definition for substructure 1 (see Item 1
    above).

 5. Remove cards 165 and 166, SPC and load set selection for Phase 1,
    substructure 2 (see also item 1 above). Select LOAD set 202 and place after
    card 241.

 6. Replace card 168 as shown in Table 1.10-12 to redefine the a-set for
    substructure 2.

 7. Replace cards 172 and 173 with cards 172, 173, and 173a shown in Table 
    1.10-12 to redefine the partitioning vectors for substructure 2. 

 8. Cards 174, 175, and 182 are not required, load definition and SPC definition
    for substructure 2 (see item 1 above).

 9. Replace cards 243 and 245 as shown in Table 1.10-12 to conform to new size 
    for pseudostructure. 

10. Insert the cards 246a and 246b as shown in Table 1.10-12 in the Bulk Data 
    Deck for Phase 2 for definition of the loading condition and boundary 
    condition. 

11. Replace card 247 as shown in Table 1.10-12 to modify the definition of the
    pseudostructure to contain 12 scalar points.

Table 1.10-12. New Data for Modified Phase 2

     1       2       3       4       5       6       7       8       9       10

118  ASET1   126     1       3
121  DMI     E1      0       2       1       1               12      1
122  DMI     E1      1       1       1.0     1.0     1.0     1.0     1.0    +E11
122a +E11    E1      1.0
168  ASET1   126     3       4       5
172  DMI     E2      0       2       1       1               12      1
173  DMI     E2      1       4       1.0     1.0     1.0     1.0     1.0    +E21
173a +E21    E2      1.0     1.0     1.0     1.0
243  DMI     KGG     0       6       1       2               12      12
245  DMI     PGT     0       2       1       2               12      1
246a SLOAD   202     5       1000.   8       1000.
246b SPC1    201             1       2       11
247  SPOINT  1       THRU    12

Table 1.10-13. Phase 1 Normal Modes Analysis Data Deck

NASTRAN   FILES = (INPT,NPTP)
ID        PHASE,ONE $ NORMAL MODES
TIME      2
CHKPNT    YES
APP       DISP
SOL       3,0
ALTER     n1,n2 $ (where n1 = DMAP statement number of COND LBL6,REACT and
                         n2 = DMAP statement number of LABEL P2)
OUTPUT1   E10,KAA,MAA,,//C,N,-1/C,N,0/C,N,USERTP1 $
ENDALTER
CEND
   (Case Control Deck)
BEGIN BULK
   (Bulk Data Deck)
ENDDATA

Table 1.10-14. Phase 2 Normal Modes Analysis Data Deck

NASTRAN   FILES = (INPT,INP1,INP2)
ID        PHASE,TWO $ NORMAL MODES
TIME      2
APP       DISP
SOL       3,0
ALTER     n0 $ (where n0 = DMAP statement number of the BEGIN statement)
PARAM     //C,N,NOP/V,N,TRUE=-1 $
ALTER     n1,n2 $ (where n1 = DMAP statement number of module GP2 and
                         n2 = DMAP statement number of module SMA3)
INPUTT1   /E01,KGG01,MGG01,,/C,N,-1/C,N,1/C,N,USERTP1 $
MERGE,    ,,,KGG01,E01,/KGGT01 $
ADD       KGG,KGGT01/KT01 $
EQUIV     KT01,KGG/TRUE $
MERGE,    ,,,MGG01,E01,/MGGT01 $
ADD       MGG,MGGT01/MT01 $
EQUIV     MT01,MGG/TRUE $
INPUTT1   /E02,KGG02,MGG02,,/C,N,-1/C,N,2/C,N,USERTP2 $
MERGE,    ,,,KGG02,E02,/KGGT02 $
ADD       KGG,KGGT02/KT02 $
EQUIV     KT02,KGG/TRUE $
MERGE,    ,,,MGG02,E02,/MGGT02 $
ADD       MGG,MGGT02/MT02 $
EQUIV     MT02,MGG/TRUE $
ALTER     n3,n4 $ (where n3 = DMAP statement number of COND LBL4,GENEL and
                         n4 = DMAP statement number of LABEL LBL4)
ALTER     n5,n6 $ (where n5 = DMAP statement number of module SDR2 and
                         n6 = DMAP statement number of LABEL P2)
OUTPUT1   LAMA,,,,//C,N,-1/C,N,0/C,N,USERTP3 $
PARTN     PHIG,,E01/,PHIA01,,/C,N,1 $
OUTPUT1   PHIA01,,,,//C,N,0/C,N,0/C,N,USERTP3 $
PARTN     PHIG,,E02/,PHIA02,,/C,N,1 $
OUTPUT1   PHIA02,,,,//C,N,0/C,N,0/C,N,USERTP3 $
SDR2      CASECC,CSTM,MPT,DIT,EQEXIN,SIL,,,BGPDT,LAMA,QG,PHIG,,/
          ,OQG1,OPHIG,,,/C,N,REIG $
OFP       OPHIG,OQG1,,,,//V,N,CARDNO $
ALTER     n7,n8 $ (where n7 and n8 are the DMAP statement numbers of LABEL
                   ERROR1 and the PRTPARM module immediately following it,
                   respectively)
ENDALTER
CEND
  (Case Control Deck)
BEGIN BULK
  (Bulk Data Deck)
ENDDATA

Table 1.10-15. Phase 3 Normal Modes Analysis Data Deck

NASTRAN   FILES = (INPT,OPTP)
ID        PHASE,THREE $ NORMAL MODES
TIME      2
APP       DISP
SOL       3,0
ALTER     n1,n2 $ (where n1 = DMAP statement number of module GP3 and
                         n2 = DMAP statement number of the OFP module just prior
                         to the SDR1 module)
INPUTT1   /LAMA,,,,/C,N,-1/C,N,0/C,N,USERTP3 $
INPUTT1   /PHIA,,,,/C,N,0 $
ALTER     n3,n4 $ (where n3 = DMAP statement number of JUMP FINIS and
                         n4 = DMAP statement number of LABEL FINIS)
ENDALTER
   (Include Restart Dictionary from Phase 1)
CEND
   (Case Control Deck)
BEGIN BULK
   (No Bulk Data)
ENDDATA

       Y
         |                   |P        |P
         |1        2        3|        4|        5         6
         *---+-+---*---+-+---*---+-+---*---+-+---*---+-+---*----- X
       --+-- |1|       |2|       |3|       |4|       |5| --+--
       ///// +-+       +-+       +-+       +-+       +-+ /////
         |                                                 |
         |                                                 |
         |                                                 |
         +-------------------------------------------------+
                          5 @ 20 ft. = 100 ft.



         Substructure 1                    Substructure 2

                                     |P        |P
          1        2        3       3|        4|        5         6
         *---+-+---*---+-+---*       *---+-+---*---+-+---*---+-+---*--
       --+-- |1|       |2|               |3|       |4|       |5| --+--
       ///// +-+       +-+               +-+       +-+       +-+ /////
         |         |         |       |         |         |         |
         |         |         |       |         |         |         |
         +---------+---------+       +---------+---------+---------+
             240"      240"              240"     240"      240"



     2   Grid point numbers

    +-+
    |3|  Element numbers
    +-+

                6
     E = 30 x 10  psi

               4
     I = 500 in

     P = 1000 lbs.


                 Figure 1.10-1. Manual substructuring problem


## 1.10.2  Automated Multi-Stage Substructuring

   Large and complex structural analysis problems can be solved for static and 
dynamic response and/or normal mode shapes using the automated multi-stage 
substructuring features of NASTRAN. As with all substructuring approaches, you 
subdivide the intended model into a set of smaller, more elementary partitions 
called basic substructures. The components of the whole structure can be 
modeled independently, checked for accuracy, and then assembled automatically 
all at once or in stages to form a composite model representing the whole 
structure for final solution. 

   In order to effectively employ this automated substructuring capability of 
NASTRAN for static and normal modes analyses, you should gain an overall 
understanding of the basic program design concepts, the data base on which it 
operates, and the control functions provided. These topics are discussed in 
the sections which follow. Suggestions, recommendations, and cautions to be 
observed when using automated substructuring are presented in Section 
1.10.2.6. 

   A detailed description of the substructuring control cards and a summary of 
pertinent bulk data cards is provided in Section 2.7 of this manual. A 
detailed description of each of these bulk data cards is included 
alphabetically along with all other bulk data cards in Section 2.4. The basic 
design concepts used in developing this automated substructuring capability 
are described below. The theory is presented in Section 4.6 of the Theoretical 
Manual. 

### 1.10.2.1  Basic Concepts

   Automated substructuring analysis is available for use with NASTRAN Rigid 
Formats 1, 2, 3, 8, and 9. This provides capability for static analysis, 
static analysis with inertial relief for unsupported structures, and normal 
modes, frequency response, and transient response analyses. The capability 
allows an unlimited number of substructures to be combined and/or reduced in 
any sequence desired. Each substructure is represented by its mass, stiffness, 
and damping matrices. A reduction in size or condensation of these matrices is 
accomplished using the Guyan reduction technique or reduction to normal or 
complex modal coordinates. 

   Although the NASTRAN substructuring system may be used for small and 
moderate size problems, several features are available to accommodate very 
large problems. The most important of these features is the automated data 
base management system used to maintain the Substructure Operating File (SOF) 
on which all pertinent matrix and substructural loading data and associated 
control files are stored. This SOF carries all the information needed from run 
to run throughout a substructuring analysis. 

   Processing automated substructuring analyses is subdivided into three 
phases similar to those described earlier for manual substructuring. The usual 
analysis proceeds as follows. First, several separate Phase 1 executions are 
performed, one for each basic substructure. Second, one or more Phase 2 
executions may be performed. In a Phase 2 run, any number of substructure 
reductions and/or combinations, resulting in higher level (meaning more 
complex) pseudostructures, may be performed. Phase 2 processing may be halted 
at any stage of model assembly and restarted in a subsequent Phase 2 
execution. The results at each step in the operation are stored on the SOF so 
as to be available for subsequent execution. The final steps of a Phase 2 
operation would be the solution step for the highest level structure and the 
data recovery steps with limited output capability (displacements, forces of 
constraint, modal energies, and applied loads only) for any lower level 
substructure. Complete and detailed data recovery for the basic substructures 
must be obtained by separate Phase 3 executions, one for each basic 
substructure. This level of data recovery may include any or all of the 
NASTRAN output normal for a non-substructure analysis. 

   Automated substructuring allows each basic substructure to be defined 
independently. This concept is represented by three key features of the 
system. 

   1.  There are no restrictions as to duplication of grid point or element 
       identification numbers, load sets, individual coordinate systems, etc. 
       All data for a given substructure is associated with an assigned unique 
       name for that structure. The only data restriction is one of proper 
       modeling, that is, common boundaries require grid points to be located 
       at the same point in space for each connecting substructure. 

   2.  No substructure may appear as a component of another substructure more 
       than once; and no degrees of freedom within a substructure may be 
       connected ("combined") to other degrees of freedom in that same 
       substructure except by multipoint constraints imposed at the solution 
       step operation. 

   3.  All pertinent substructure data are stored on the SOF, an expandable 
       direct access file. This file may be selectively edited and/or dumped 
       to tape and transmitted to another user who may have need for the data. 
       Provision is made for automated tape conversion among CDC, IBM, UNIVAC, 
       and DEC VAX computers to facilitate such data transmittal between 
       different users. Use of this file is described in Section 1.10.2.4. 

   Control of the automated substructuring system is obtained through the use 
of linguistic commands, similar to those of Case Control. These commands are 
placed in the Substructure Control Deck shown in Figure 1.10-2. This 
Substructure Control Deck is situated between the Executive Control and Case 
Control Decks. 

   Each substructure control command is automatically translated into 
appropriate DMAP ALTER cards to augment the requested Rigid Format sequence. 
You may also include your own DMAP ALTER commands, or may modify a previously 
defined DMAP sequence. A description of how you may interface with this 
NASTRAN-generated substructuring DMAP is presented in Section 2.7.2. Listings 
of the DMAP ALTERs generated by each substructure command are presented in 
Section 5.9. Descriptions of the corresponding modules provided for 
substructuring are found in the NASTRAN Programmer's Manual. 

### 1.10.2.2  Substructure Operations and Control Functions

   User control of the automated multi-stage substructuring system is obtained 
via the Substructure Control Deck commands. The key terms used to describe 
these commands and their functions are defined in Table 1.10-16. A summary of 
the substructuring command options is presented in Table 1.10-17. Some of 
these commands require specific bulk data cards which are listed for easy 
reference in Table 18. You should also refer to Section 2.7 for a complete 
description of the Substructure Control Deck commands and to Section 2.3 for 
detailed descriptions of the corresponding bulk data cards. 

   The operation and control functions of automated substructuring analysis 
are best illustrated and explained using the "tree" structure presented in 
Figure 1.10-3. This figure defines the genealogy of all the component 
substructures used in building a final model. Basic substructures are created 
at the Phase 1 level. Substructures "A," "B," and "E" are shown in solid boxes 
indicating they were formed from actual data deck submittals and are 
physically different models. The dotted boxes are called "image" substructures 
and are the result of an EQUIVALENCE operation rather than an actual Phase 1 
data deck submittal. The EQUIVALENCE operation defines a new substructure 
which is a duplicate of an existing substructure, and automatically creates 
all equivalent lower level component substructures. Thus, space is saved on 
the data files by eliminating storage of redundant matrix data. A four-bladed 
propeller, for example, could be seen to consist of four identical components 
and, hence, only one need be explicitly modeled. The other three blades could 
be defined solely by using the EQUIVALENCE command. 

   The image substructures exist in name only. Note in Figure 1.10-3 that the 
names of the image structures are identical to the equivalent parent 
structure, with the exception of a prefix character. The new names would be 
created automatically by NASTRAN with the use of the PREFIX subcommand to 
EQUIVALENCE. These new prefixed names would then be used to reference the 
appropriate component substructure as if it were created independently. 

   Note that the term "lower level" refers to the less complex of the 
component substructures which are used to create a higher level, or more 
complex, substructure. 

   From the user point of view, all substructures shown in Figure 1.10-3, with 
either solid or dotted boxes, are separate and distinct substructures. They 
may have different applied loads, boundary conditions, and responses. For 
example, though only A, B, and E represent actual Phase 1 executions, Phase 3 
data recovery executions may be made for A, B, E, XA, XB, YA, YB, YXB, and YE, 
each of which generally would have different results. 

   The COMBINE command (see Table 1.10-17) with its numerous subcomnands, 
offers flexibility in the assembly of substructures into a higher level 
substructure. The COMBINE capability allows component substructures to be 
translated, rotated, and/or symmetrically transformed via mirror image 
transformation for proper positioning in space. 

   For example, the right wing of an aircraft is first modeled and an 
EQUIVALENT operation is performed to define an identical duplicate wing. Then, 
in the COMBINE operation, a SYMTRANSFORM is applied so that the wing now 
appears as the actual left wing (a mirror image of the right wing), and a 
TRANSFORM Is applied to properly position it on the left side of the aircraft. 
Caution is advised in that the symmetry transformation (SYMTRAN) is always 
applied to the component in its own basic coordinate system before the usual 
translation and rotation (TRANS) for final positioning (see Section 4.6 of the 
Theoretical Manual). 

   The REDUCE command causes a Guyan reduction to be performed on an existing 
substructure. You specify which degrees of freedom are to be retained using 
the BDYC and BDYS (or BDYS1) bulk data cards provided. The degrees of freedom 
retained are all called boundary degrees of freedom, although they all need 
not ever appear on the boundary with another substructure. Obviously, all 
degrees of freedom eventually needed for boundary connections must be 
retained, that is, they must not be reduced out. However, care must be taken 
to retain in this boundary set all the appropriate degrees of freedom needed 
to represent the dominant displacement patterns for accurate calculation of 
eigenvalues and eigenvectors for normal modes analyses. 

   The MREDUCE and CREDUCE commands provide a modal synthesis capability to 
automated multi-stage substructuring. With these commands you define boundary 
degrees of freedom to identify degrees of freedom retained as physical 
coordinates. The remaining degrees of freedom are replaced by a smaller set of 
normal (MREDUCE) or complex (CREDUCE) generalized modal coordinates. MREDUCE 
may be used when real symmetric mass and stiffness matrices are used to define 
the model. CREDUCE provides a general modal reduction capability when damped 
modes are desired or complex or unsymmetric matrices are present. 

   You may also define constraints for the structure to be applied only for 
the purpose of calculating the modes. BDYC and BDYS (or BDYS1) bulk data cards 
are used to define these degrees of freedom and are requested by the 
subcommand FIXED. 

   Note that for both the REDUCE and MREDUCE substructure commands, the 
damping matrices, B and K4, and the load vectors, P, are transformed to the 
reduced set of coordinates. The reduced substructures may be processed with 
any of the other substructure operations. However, substructures  generated 
with the complex modal reduction, CREDUCE, may not be processed with any 
commands requiring real arithmetic, namely REDUCE, MREDUCE, or SOLVE with 
Rigid Formats 1, 2, 3, or 9. 

   As many EQUIVALENCE, COMBINE, REDUCE, MREDUCE, or CREDUCE commands as 
desired may be used in one or more Phase 1 or Phase 2 executions. However, 
only one SOLVE command is allowed in any single Phase 2 execution, and the 
SOLVE command is not allowed in Phase 1 executions. As indicated in the 
definitions of Table 1.10-1, the SOLVE command requests a solution for 
structural response to applied static loads (Rigid Formats 1 and 2), the 
calculation of normal modes (Rigid Format 3), or structural response to 
frequency dependent or time dependent loads (Rigid Formats 8 and 9) of the 
substructure named in the command. 

   The RECOVER command is used in Phase 2 to recover the solution data for 
successively lower level substructures. Only the displacements, forces of 
constraint, modal energies, and applied loads can be selectively output for 
any component substructure during these Phase 2 operations. The BRECOVER 
command is then used in a Phase 3 execution to obtain all the detail response 
output normally provided by NASTRAN for each desired basic substructure. The 
command MRECOVER is used to recover mode shape data for modal reduced 
substructures. 

   Using the PLOT command, only undeformed plots may be requested in a Phase 2 
execution. Deformed plots can only be obtained from a Phase 3 execution. 

   You control each step in the analysis by specifying the appropriate 
commands to be executed and the substructure names, such as A, B, YC, etc. 
(see Figure 1.10-3), of each substructure to be used in that step. 

   To reduce the potential for input error and to simplify the bookkeeping 
tasks, all specific references to loadings and grid points for connection, 
boundary sets, and constraints, etc. are made with respect to the basic 
substructure name only. For these reasons, no component substructure may be 
used more than once while building the solution structure. That is, every 
component named in any substructure must be unique. If the same component 
substructure is to be used more than once, for example, identical components 
are to be used to create the full model, the EQUIVALENCE operation should be 
used as described earlier to assign unique names to all substructures 
comprising that component. 

   Substructure names are allowed no more than eight alphanumeric characters. 
Notice in the EQUIVALENCE operation shown in Figure 1.10-3, the required 
subcommand PREFIX generates an additional character which is placed ahead of 
the existing name as a prefix to the parent substructure name. Care must be 
taken with successive EQUIV operations to monitor the growth of image 
substructure names so as not to exceed the eight-character limit. If the limit 
is exceeded, the right-most character will be truncated. Therefore, it is 
possible to inadvertently create duplicate substructure names as more prefixes 
are added. It is recommended, therefore, that the entire tree structure for 
the analysis be prepared ahead of time to help avoid these problems. This pre-
planning also will be an invaluable aid to the task of data preparation and 
proper sequencing of the individual steps in the analysis. 

### 1.10.2.3  Input Data Checking and Interpretation of Output

   The automated substructuring system provides several methods for input data 
checking, diagnostic output, and substructure-oriented data output. 

   A principal facility for input data checking is the RUN = DRY command. This 
option allows you to validate the command structure and data without actually 
performing the more time-consuming matrix operations. Assuming the input is 
found to be consistent, the run may be resubmitted with the RUN = GO option to 
complete the matrix processing. 

   Also available is a RUN = STEP option (the default option) which first 
checks the data and then executes the matrix operations one step at a time. If 
errors are detected in the data, the matrix operations are skipped and the 
remainder of the processing sequence is executed as a DRY run only. 

   You also are allowed to process only selected matrix data. If, for example, 
after having assembled the solution structure, new loading conditions are to 
be added or normal modes are desired but the mass matrix is not available, the 
necessary sequence of matrix operations can be requested using the RUN = GO 
option to process the new load or mass matrix data only. The OPTIONS command, 
described in Section 2.7, causes selective processing of mass (M), damping (B 
or K4), stiffness (K), or load (P) data only. The PA option (load append) is 
used when new Phase 1 load vectors are to be added to the set of existing load 
vectors. Note that when using the OPTIONS command, if existing substructure 
data items are to be recreated (see Table 1.10-19), the old data must be 
removed using the EDIT or DELETE commands as described in the next section. 
This is necessary because only one item of a given type may be allowed on the 
SOF for any particular substructure. 

   All the relevant substructuring data generated by the program may be 
displayed with the OUTPUT command described in Section 2.7. The COMBINE, 
REDUCE, MREDUCE, and CREDUCE operations involve specification of grid point 
and degree of freedom data related to the basic substructures involved. The 
automatically generated or manually specified connectivities are critical to 
the COMBINE operation. Using these output options, the information can be 
obtained to explicitly verify all connectivities. The REDUCE, MREDUCE, and 
CREDUCE operations require you to specify the degrees of freedom to be 
retained. These also are identified by basic substructure grid point numbers. 
If desired, these same output options can be used to obtain lists of all the 
retained degrees of freedom of the resulting pseudostructure to help verify 
the resulting model. The following paragraphs describe examples of the 
possible output that can be requested. 

   The table shown below may be used to verify all substructure 
connectivities. This, and the other examples of diagnostic output to be 
described later, are reproductions of actual problem output requested under 
the COMBINE command used to create a pseudostructure named WINDMILL from 
component substructures RING and VANR. 

                   SUMMARY OF PSEUDOSTRUCTURE CONNECTIVITIES

       INTERNAL    INTERNAL     DEGREES OF      RING        VANR
       POINT NO.   DOF NO.      FREEDOM

          34          67            12          RING 146
          35          69            12          RING 147
          36          71            12          RING 148
          37          73            12          RING 103    VANE 1
          38          75            12          RING 106    VANE 2
          39          77            12          RING 109    VANE 3
          40          79            12                      VANE 13
          41          81            12                      VANE 14

   The column heading "INTERNAL POINT NO." references the equivalent of 
internally generated "grid points" for the resulting pseudostructure. 
"INTERNAL DOF NO." references the internally sequenced first degree of freedom 
(row or column number) in the matrices of WINDMILL for the designated internal 
grid point. "DEGREES OF FREEDOM" references the component degrees of freedom 
in the global coordinate system of the assembled structure associated with the 
internal grid point. In the example above, the following may be observed: 

   1.  Degrees of freedom 1 and 2 from grid point 109 of basic substructure 
       RING and grid point 3 of basic component VANE in substructure VANE are 
       connected and assigned to internal point 39 of pseudostructure 
       WINDMILL. 

   2.  Displacement components 1 and 2 at internal point 39 are the 77th and 
       78th degrees of freedom for the matrices of WINDMILL. 

   Note that only basic substructure names appear in association with grid 
points. In this example, RING and VANR are the substructures referenced by the 
COMBINE command. VANR exists as a higher level substructure with VANE as the 
basic substructure. 

   Substructure items EQSS and BGSS, which are created by the COMBINE or 
REDUCE operations, are helpful in checking the results of these substructure 
commands. They are stored along with the other items on the SOF (see Table 
1.10-19) and can be accessed at any time with the SOFPRINT command. The 
display of these items, however, is normally requested by the OUTPUT 
subcommand of either the COMBINE, REDUCE, MREDUCE, or CREDUCE commands at the 
time of their execution. 

   The EQSS item provides data for each basic substructure relating external 
or basic substructure grid point numbers to pseudostructure internal grid 
point numbers. In the example shown below, degrees of freedom 1 and 2 of grid 
point 102 of basic substructure RING have been assigned to internal grid point 
2 of pseudostructure WINDMILL. 

       EQSS ITEM FOR SUBSTRUCTURE WINDMILL COMPONENT RING

            GRID POINT       INTERNAL       COMPONENT
                ID           POINT NO.         DOF

               102               2             12
               105               4             12
               108               6             12
               111               8             12
               114              11             12
               117              13             12
               120              15             12
               123              17             12
               126              20             12
               129              22             12
               132              24             12
               135              26             12
               138              29             12
               141              31             12
               144              33             12
               147              35             12

   In addition to the above data for each basic substructure, the EQSS item 
also contains summary data for the resultant pseudostructure. A sample is 
shown below. 

       EQSS ITEM - SCALAR INDEX LIST FOR SUBSTRUCTURE WINDMILL

            INTERNAL         INTERNAL          COMPONENT
            POINT ID          SIL ID              DOF

                2                 3               12
                5                 9               12
                8                15               12
               11                21               12
               14                27               12
               17                33               12
               20                39               12
               23                45               12
               26                51               12
               29                57               12
               32                63               12
               35                69               12

   In the above table, the relationships of the internal grid point numbers to 
the internal degree of freedom numbers (referenced as "INTERNAL SIL ID") and 
to the component degrees of freedom are defined for pseudostructure WINDMILL. 
The internal degrees of freedom are referenced as a Scalar Index List (SIL) 
because all substructure problem degrees of freedom are converted to scalar 
points for purposes of Phase 2 processing. If desired for special purposes, 
therefore, these internal degrees of freedom may be referenced as scalar 
points for use with any of the non-substructuring Bulk Data cards to be input 
to the SOLVE step operations in Phase 2. 

   The EQSS items and the summary of pseudostructure connectivities table are 
related. For example, by cross referencing each table it can be seen that 
internal grid point 35 of substructure WINDMILL has degrees of freedom 1 and 2 
assigned to it. These degrees of freedom numbers in the SIL list are 69 and 
70, respectively, and these degrees of freedom come from grid point 147 of 
basic substructure RING. 

   Special treatment is required for the EQSS item for substructures which are 
modal reduced. For example, if basic substructure A is reduced to MA using 
MREDUCE or CREDUCE, the EQSS for MA indicates that pseudostructure MA has two 
component substructures, A and MA. The EQSS for component A contains the 
boundary point definitions. The EQSS for component MA contains definitions for 
the newly created modal coordinates. Inertia relief coordinates are assigned 
grid point ID's of 1 through 6 to MA, and flexible mode coordinates are 
assigned grid point ID's of 101 through 100+N, where N is the number of 
flexible modes used. Refer to Sections 4.6.2, 4.7.1, and 4.7.2 of the 
Theoretical Manual and Section 2.7 of this manual for definitions of the modal 
coordinates. 

   The modal degrees of freedom of component substructure MA (both inertia 
relief and flexible mode coordinates) may be referenced for application of 
constraints in the SOLVE operation. They may also be referenced as boundary 
coordinates in subsequent reduction operations. 

   COMBINE or reduction operations also create the BGSS item. A sample is 
shown below. The BGSS item contains internal grid point locations for the 
substructure model. In this example, the BGSS item displays all the internal 
point numbers for the pseudostructure WINDMILL along with its corresponding 
location coordinates in that pseudostructure's basic system. The "CSTM ID NO." 
column indicates the existence (if any) of local coordinate systems associated 
with those internal points. If the entry is "0", the displacement components 
will be in that pseudostructure basic system. Otherwise, they will be in a 
local system which may be verified with the optional printout of the 
coordinate system transformations (a 3x3 matrix of direction cosines) as 
stored in the "CSTM" item for that pseudostructure. 

                      BGSS ITEM FOR SUBSTRUCTURE WINDMILL

       INTERNAL      CSTM ID           --------�COORDINATES�-----------
       POINT ID.        NO.            X1               X2           X3

          1             0         -0.500000E+01    0.100000E+02    0.E+00
          2             0         -0.500000E+01    0.150000E+02    0.E+00
          3             0         0.E+00           0.100000E+02    0.E+00
          4             0         0.E+00           0.150000E+02    0.E+00
          5             0         0.500000E+01     0.100000E+02    0.E+00
          6             0         0.500000E+01     0.150000E+02    0.E+00
          7             0         0.750000E+01     0.750000E+01    0.E+00
          8             0         0.100000E+02     0.100000E+02    0.E+00
          9             0         0.125000E+02     0.125000E+02    0.E+00
         10             0         0.100000E+02     0.500000E+01    0.E+00

   Modal coordinates are indicated in the BGSS by a CSTM ID NO. of -1 and a 
coordinate location of X1 = 0.0, X2 = 0.0, and X3 = 0.0. The CSTM ID NO. of -1 
is the NASTRAN convention for a scalar point. Note that scalar points will 
never be combined with any other points using the automatic COMBINE operation. 

   Another useful output item is the SUBSTRUCTURE OPERATING FILE TABLE OF 
CONTENTS (TOC), as shown in Figure 1.10-4. In this figure, the substructure 
tree has been added to the TOC output to help visualize the sample problem. 
This output is obtained with the command SOFPRINT TOC. The TOC lists by name 
all substructures that reside on the SOF, lists the current items available 
for each substructure, and provides a set of pointers which describe the 
hierarchy of substructure relationships. The SOF pointer scheme is described 
by defining the individual column headings shown in the TOC. 

   TYPE    Defines the substructure type:

           B - basic substructure

           C - combined substructure

           R - Guyan reduced substructure

           M - real modal reduced substructure

           CM - complex modal reduced substructure

           Any of the above types will have prefix "I" if it is an image 
           substructure resulting from an EQUIV operation. 

   SS      Points to a substructure which is secondary to the current 
           substructure. In the case where many secondary substructures have 
           been EQUIVed to a single primary substructure, the SS entries form 
           a chain starting with the primary substructure and ending with an 
           SS pointer of zero. 

   PS      Points to the substructure which is primary to the current 
           substructure. PS is non-zero for secondary substructures only. 

   LL      Points to a substructure at the next lower (simpler) level to the 
           current substructure. 

   CS      Points to a substructure which has been combined with the current 
           substructure. The CS entries form a circular chain. 

   HL      Points to the substructure at the next higher (complex) level to 
           the current substructure. 

   All normal NASTRAN output for each basic substructure, primary or image 
substructure, is available via a Phase 3 execution. Also, certain output may 
be recovered in Phase 2 for any or all of the substructures in the solution 
structure's tree. However, this output is limited to displacements, applied 
loads, and forces of single-point constraint. The output requested in Phase 2 
is labeled by both the pseudostructure and its component basic substructure 
names. 

   Some discussion of the forces of constraint, which may be requested as 
output in both Phase 2 and Phase 3, is required. The Phase 3 calculations for 
forces of constraint are computed in the normal NASTRAN convention (refer to 
Section 3.7 of the Theoretical Manual). In a Phase 2 execution, however, the 
forces of constraint include additional terms. The equations used for the 
calculations are shown below and are identified by rigid format application. 
In these equations, {Q} are the forces of constraint, {P} are the applied 
loads, {u} is the displacement vector, [K] is the stiffness, [B] is the 
damping, [M] is the mass, w2 are eigenvalues from a real modes analysis, and p 
are complex eigenvalues from a complex modal reduction. 

   +-----------------+--------------------------------------------------+
   | Rigid Format    |     Equation for Forces of Constraint            |
   +-----------------+--------------------------------------------------+
   |                 |                                                  |
   | 1 and 2         |     {Q} = [K]{u}                          - {P}  |
   |                 |                                                  |
   |   3             |     {Q} = [K]{u}            - [M][w2]{u}         |
   |                 |                                                  |
   |   3             |     {Q} = [K]{u} + [B][p]{u} +  [M][p2]{u}       |
   |                 |                        .           ..            |
   | 8 and 9         |     Q   = [K]{u} + [B]{u}    + [M]{u}     - {P}  |
   +-----------------+--------------------------------------------------+

   The force vectors {Q} contain all the terms due to

   1. Inertia forces

   2. Damping forces

   3. Single-point constraints

   4. Multipoint constraints

   5. Forces transferred from other connected substructures

   6. Residual forces due to computer round-off

   The equations presented above for calculation of forces of constraint 
provide especially useful information, that is, the forces of substructure 
interconnection as shown below. 

                         -F1              F1
       +----------+-------                 -------+----------+
       |          |                               |          |
       |          |                               |    B     |
       |          |      -F2             F2       |          |
       |    A     |---------             ---------+----------+
       |          |                               |          |
       |          |                               |    C     |
       |          |                               |          |
       +----------+                               +----------+

       Substructure A                              Substructure BC

   Forces F1 and F2, recovered as forces of constraint for substructure A and 
for pseudostructure BC, represent the forces of interconnectivity. Force F2 
represents the sum of two component forces, one from each component 
substructure B and C, acting at their common grid point. The separate 
contributions to F2 from each B and C may be determined by using the RECOVER 
command for the component substructures B and C individually, as shown below. 

                                                      +----------+
                                                      |          |
                +----------+                          |    B     |
                |          |                 F2B      |          |
                |    B     |                 ---------+----------+
       F2       |          |
       ---------+----------+   =                           +
                |          |                 F2C
                |    C     |                 ---------+----------+
                |          |                          |          |
                +----------+                          |    C     |
                                                      |          |
                                                      +----------+

### 1.10.2.4  Substructure Operating File (SOF)

   The data required for each basic substructure and for all subsequent 
combinatIons of substructures are stored on the Substructure Operating File 
(SOF). The SOF data are stored in direct access format on disk or drum during 
a NASTRAN execution. These data may also be stored on tape between runs for 
backup storage or for subsequent input to other computers. Schematic diagrams 
of data flow for each of the three phases of execution are given in Figure 
1.10-5. 

   The SOF file, which contains the data items listed in Table 1.10-19, is 
used to communicate all required data between phases of operation and between 
steps of the Phase 2 operation. Thus, you are allowed to develop your analysis 
in separate steps without requiring the checkpoint/restart feature of NASTRAN. 
A Phase 1 run is required to build each basic substructure and place its data 
on the SOF prior to any Phase 2 reduction or combination using that 
substructure. Using that data, component pseudostructures may be assembled in 
stages from these basic substructures and added later to other component 
substructures already on the SOF file. Also, the same SOF may be used to build 
the data files for more than one solution structure at a time. 

   Once the final solution model is established, the solution may be obtained 
and results recovered for any level, component pseudo- or basic substructure. 
However, detail element stresses and element forces or support reactions 
specified with the basic substructure can be recovered only in Phase 3. These 
Phase 3 results may be recovered either by using the original data deck or by 
restarting from a checkpointed Phase 1 execution. 

   The SOF is structured as a single logical file used to store all data 
necessary for a complete multi-stage substructuring analysis. However, the SOF 
may actually reside on from one to ten physical files. These physical files 
would be chained together to form the single logical file for use in the 
analysis of larger problems. The figure below shows the basic arrangement of 
an SOF on disk or drum. 

       +----------+                  +----------+
       +----------+                  +----------+
       | SOF(1)   |- - - - - - - - - | SOF(2)   | - -+
       +----------+                  +----------+    
       |          |                  |          |    |
       +----------+                  |          |
       | SOF(1)   |- - - - -+        +----------+    |
       +----------+         + - - - -| SOF(3)   | - -+
       |          |                  +----------+
       +----------+                  +----------+


   Each physical file comprising the SOF is a direct access file. These disk 
or drum files are not used by NASTRAN GINO operations. NASTRAN treats them as 
external user files. In a substructure analysis, NASTRAN stores data on the 
SOF which must be saved from run to run. Therefore, it is your responsibility 
to maintain the physical files comprising the SOF from one execution to the 
next. For large disk files which may arise in some substructuring problems, it 
may be advisable to store the SOF on tape for backup protection between 
executions. You should refer to the DUMP, RESTORE, SOFOUT, and SOFIN commands 
for this capability, or may use operating system utilities. 

   The SOF declaration in the Substructure Control Deck is used to define the 
physical files which make up the SOF. See Section 2.7 for a complete 
description of the SOF declaration. An SOF composed of only one physical file 
which already exists would be declared as follows: 

   SOF(1) = SOF1,200,OLD (CDC example)

A new SOF composed of three physical files could be declared as follows on the 
first execution with this particular SOF logical file: 

   SOF(1) = SOF1,200,NEW
   SOF(2) = SOF2,200
   SOF(3) = SOF3,400

The parameter "NEW" is never used again on any subsequent execution with this 
SOF. If it were used, all data on that SOF logical file would be lost. For 
example, to add a new physical file on a subsequent execution, simply add its 
declaration, that is, SOF(4) = SOF4,600. Again, do not declare this as a "NEW" 
file or the whole logical SOF file will be re-initialized and all existing 
data will be lost. (Refer to the SOF command in Section 2.7 for machine 
dependent restrictions.) 

   All data stored on the SOF is accessed via the substructure name. For each 
substructure, various types of SOF data may be stored. These types of data are 
called items and are accessed via their item names. Thus, the substructure 
name and item name are all that is required to access any block of data on the 
SOF. The items which can be stored for any substructure are described in Table 
1.10-19. The program automatically keeps track of the data, stores the data as 
it is created, and retrieves these data when required. Your only 
responsibility is to maintain the file. It must be accessible by the system 
when needed. You must remove items generated from data containing input errors 
and/or if that data is no longer needed for subsequent analyses. Also, data 
may be selectively stored on a backup tape for later retrieval, thus releasing 
needed space for subsequent operations. 

### 1.10.2.5  The Case Control Deck for Automated Substructure Analyses

   The Case Control Deck for substructuring analysis controls loading 
conditions, constraint set selection, output requests, and method of analysis 
just as in any non-substructuring analysis. However, in a substructuring 
analysis, there are very important relationships among the Case Control Decks 
to be input for each of the three phases of substructuring. Compatibility 
among the substructuring phases must be maintained for load sets, constraint 
sets, and subcase definitions. 

   The following requirements must be satisfied by the Case Control Deck in 
Phase 1: 

   1.  Constraint set selection (MPC, SPC) must be above the subcase level. 
       That is, only one set of constraints is allowed in Phase 1 for all 
       loading conditions. 

   2.  One subcase must be defined for each loading condition which is to be 
       saved on the SOF. The loading condition may consist of any combination 
       of external static loads, thermal loads, element deformation loads, or 
       enforced displacements. Loading conditions which are not saved on the 
       SOF in Phase 1 cannot be used in any solution in Phase 2. 

   The Phase 2 Case Control Deck is exactly like the Case Control used in a 
non-substructuring analysis. Only the TITLE and BEGIN BULK cards are needed 
except when plots are requested or when there is a SOLVE command in the 
Substructure Control Deck. In this latter case, the subcase definitions, load 
and constraint set selections, etc. are used in the usual fashion to control 
the solution process. 

   Output requests in Case Control are honored only if there is a PRINT 
subcommand under the RECOVER command in the Substructure Control Deck. If a 
RECOVER command with a PRINT subcommand is used, the Case Control should be 
identical (except for output requests) to that used to obtain the solution 
being printed. 

   The following requirements must be satisfied by the Case Control Deck in 
Phase 3: 

   1.  Constraint sets (MPC, SPC) must be identical to those used in Phase 1 
       for this substructure. 

   2.  The subcase definition for load set IDs must be identical to those used 
       in Phase 1 for this substructure including those for appended loads, if 
       any. All load definitions must appear in the order generated. 

   3.  The subcase definition for the Phase 3 output requests for solution 
       vectors generated in Phase 2 must be merged with the above subcase 
       definition for load set IDs. Note that the OLOAD output requested in 
       Phase 3 will correspond to the load factors defined during Phase 2 
       solution, not those defined by Phase 3 Case Control. 

   The number of Phase 3 subcases required is the maximum of those defined in 
either Phase 1 or Phase 2. All output requests will correspond to the Phase 2 
subcase sequence, starting with the first subcase defined in Phase 3. It is 
essential to assign the same thermal and element deformation loadings to the 
same subcases in both Phase 1 and Phase 2 in order to provide the correct load 
correction data to the Phase 3 output processing of element forces and 
stresses. 

### 1.10.2.6  User Aids for Automated Substructure Analyses

   The following suggestions, recommendations, and cautions should be 
considered when using automated multi-stage substructuring. The automated 
substructuring capability offers you flexibility in the performance of an 
analysis. To take advantage of this capability, it is recommended that the new 
user carefully review both the Theoretical and User's Manual sections on 
substructuring and execute the demonstration problems which are documented in 
the Demonstration Problem Manual. 

   Simulation Analyses - You are advised to simulate large structural model 
analyses with simplified models using the substructuring system. Using this 
technique, all deck structures, including operational commands and control of 
the SOF, may be tested using small matrices at low cost. In addition, any 
special features such as user DMAP operations may be tested at this time. 

   Reduction - Generally, the most economical analyses may be performed using 
relatively small basic substructures or by performing significant reductions 
in Phase 1 (using OMIT or ASET bulk data cards). When using Guyan reduction, 
either reduce most degrees of freedom (many more than half) or very few 
degrees of freedom (many less than half) if possible. Note that the resulting 
matrices are usually dense and, hence, may take up more space on the SOF than 
the original matrices. 

   When using modal reduction use the FIXED set to help approximate the 
expected solution mode shapes. Also, remember that when inertia relief shapes 
are requested, six shapes are created. However, if the problem is not fully 
three dimensional, some of these shapes may be null, and the resulting 
singularities must be accounted for in subsequent operations. Note that 
flexible mode shapes which introduce singularities, such as rigid body shapes 
at zero frequency, are automatically excluded from assignment to the reduced 
substructure. The rigid body shapes are not needed because the boundary 
points, by definition, must provide the rigid body description of the 
structure. 

   Load Append - In the event that additional new loading conditions are 
required, the LODAPP (Load Append) feature may be used. This feature, 
described in Section 2.7, allows you to avoid performing redundant Phase 2 
computations. 

   Singularities - Selective grid point degrees of freedom are often singular 
in stiffness (such as rotations about a vector normal to a plate) and may be 
constrained in Phase 1. However, if these grid points are later transformed to 
a new output coordinate system during a COMBINE operation, the singularity may 
be re-introduced to the problem. NASTRAN substructuring transforms grid point 
degrees of freedom in groups of three translations and three rotations. Thus, 
if one or more translational and/or rotational degrees of freedom exist for a 
grid point and a general transformation (not 90, 180, or 270 degrees) is 
applied, 3 translational and/or rotational degrees of freedom will exist for 
the resulting structure for that grid point. However, the stiffness matrix 
will be singular, and this must be considered in subsequent operations. For 
example, in future reduction operations some of these degrees of freedom must 
be kept in the boundary set so that the interior point stiffness matrix is 
non-singular. The extraneous singularities are finally removed at the SOLVE 
operation using SPCS or MPCS cards. 

   User Modes - You may define a substructure in terms of modal data obtained 
from another source, such as test data for example. To use this capability you 
create a Phase 1 job with an MREDUCE command as shown below. 

   SUBSTRUCTURE PHASE1
   (SOF control cards)
   NAME = name
   MREDUCE name
   NAME = r-name
   USERMODES = j
    :
    :

Two options are allowed, j = 1 or 2. If j = 1, a structural model is defined 
as usual with bulk data cards. However, the modal data, that is, the 
eigenvalue data and mode shape data, are defined by using direct input tables 
and matrices in the bulk data deck. Table LAMAR must be input using DTI cards 
using the format specified for the LAMA data block described in the 
Programmer's Manual. Only the modal mass and frequency (HZ) need be defined in 
LAMAR. The mode shapes must be input using DMI cards and the matrix name PHIS. 
The PHIS matrix must be the NASTRAN F-set size, that is, the fixed degrees of 
freedom must be described with null rows. 

   If j = 2, the model is completely defined with matrix data. As is done for 
j = 1, a LAMAR table and PHIS matrix must be input. In addition, a matrix 
named QSM, which contains the modal reaction forces for degrees of freedom 
fixed in mode extraction, is input using DMI cards. Matrix QSM has one row for 
every degree of freedom (as does PHIS) and one column for every mode. Null row 
entries exist for degrees of freedom not fixed in mode extraction. Note that 
the number of modes must exceed the number of degrees of freedom for this 
option (see Section 4.7.4 of the Theoretical Manual). For the j = 2 option, 
the bulk data deck must include GRID cards to define the degrees of freedom 
represented by the rows of PHIS and QSM. In addition, a dummy element should 
be included in the data deck so that NASTRAN parameter values are properly 
set. You may also input boundary mass and stiffness matrices. These data may 
be defined using CONMi, CELASi, and GENEL cards, in which case dummy elements 
are not required, or may be input using DMI or DMIG cards. For the latter 
case, you must insert the correct Executive Control Deck DMAP ALTERs to 
equivalence the input mass and stiffness data to MGG and KGG respectively. 

   Boundary set definitions are required using BDYC, BDYS, and BDYS1 cards for 
both user mode options. Note that all degrees of freedom defined for the j = 2 
options must be specified as boundary degrees of freedom. 

   Old Modes and Old Boundaries - The OLDMODES and OLDBOUND subcommands to the 
MREDUCE command allow you to modify the new, modal coordinate substructure 
without performing all new calculations. 

   The OLDMODES subcommand requests that the mode shapes and frequencies 
computed in a previous MREDUCE be reused to define the modified structure. 
This is possible because all modes computed are saved on the SOF even if they 
are not currently used to describe the substructure. You may request the 
previously used set of modes or a new subset of the previously calculated 
modes by your use of the NMAX or RANGE subcommands. Use of OLDMODES alone 
(without OLDBOUND) implies that a new boundary set is to be defined for the 
reduced substructure. Use of this subcommand requires the additional 
subcommands BOUNDARY and NMAX or RANGE. 

   The OLDBOUND subcommand requests that the boundary set definition not 
change for the modification to the substructure. For this case, a new set of 
modal data will be computed. Use of this subcommand requires the additional 
subcommands METHOD, NMAX or RANGE, and optionally FIXED, RNAME, and RGRID. 

   The use of both OLDMODES and OLDBOUND implies only a change in the number 
of modes used from the previously computed set of modes. The use of both 
commands requires only a new NMAX or RANGE card as additional subcommands. 

   When using these subcommands you must EDIT conflicting data from the SOF. 
Refer to the descriptions of MREDUCE and CREDUCE in Section 2.7 for details. 
Also note that both OLDMODES and OLDBOUND are subcommands for MREDUCE, but 
only OLDMODES is allowed for CREDUCE. The equivalent operation of OLDBOUND for 
CREDUCE requires complete redefinition of the reduced substructure. 

   Solution Items - It should be remembered that due to the data base 
protection features, at no time are there any SOF items destroyed by NASTRAN 
without a specific user command in the Substructure Control Deck. In addition, 
NASTRAN does not allow more than one substructure item (see Table 1.10-19) to 
exist for each substructure at any one time. As a result, some operations such 
as a repeated SOLVE might require you to manually edit out previously 
generated solution data items or any recovered solution data items before the 
operation could be repeated. That is, SOLN and UVEC items (the load factor or 
eigenvalue data tables and displacement vectors respectively) created in an 
earlier SOLVE operation should be deleted if a new solution with new loads or 
frequency range is desired for the same substructure. These same items must 
also be edited out from each lower level substructure for which the new 
solution data will be recovered. SOLN and UVEC items are also created by 
MRECOVER and must be deleted prior to a SOLVE and RECOVER for the same 
structure. 

   By using the EQUIVALENCE operation to create an identical structure, a new 
solution may be obtained for the same structure without deleting the older 
solution data items, as required in the example above. 

   Structural Design Considerations - Substructures which may change due to 
design iterations should be combined with other structures as late in the 
sequence of COMBINE operations as possible. This will minimize the cost of 
creating a new solution structure. Also, if the design iteration changes are 
minor and their impact on other substructures in the model can be neglected, 
then RECOVER operations need be performed only from the lowest level of 
substructure affected by the changes. Frequently, these design changes can be 
evaluated using only the Phase 3 recovery calculations. Of course, care must 
be taken to maintain compatibility with the degree of freedom list defining 
the solution displacement vector. That is, the boundary grid points and 
connections should not be changed. 

Table 1.10-16. Definitions of Substructure Terminology

Basic Substructure      - A structure formulated from finite elements in Phase
                          1.

Boundary Set            - Set of degrees of freedom to be retained in a reduce
                          operation.

Combine Operation       - Merge two or more structures by connecting related
                          degrees of freedom. The matrix elements for connected
                          degrees of freedom are added to produce the combined
                          structure matrices, and the substructure load vectors
                          are processed and stored for subsequent combination
                          at solution time.

Component Substructure  - Any basic or pseudostructure comprising a part of an
                          assembled substructure.

Connection Set          - Set of grid points and their component degrees of
                          freedom to be connected in adjoining structures.

Equivalence Operation   - The creation of a secondary substructure equivalent to
                          a primary substructure. Also creates image
                          substructures back to the basic substructure level.

Image Substructure      - A substructure equivalent to an existing component
                          substructure. May have different applied loads and/or
                          solution vectors but has identical stiffness and mass
                          matrices. Image substructures are automatically
                          created as a result of an equivalence operation.

Phase (1, 2, or 3)      - Basic steps required for multi-stage substructure
                          processing with NASTRAN - creation, combination,
                          reduction, solution and recovery, and detail data
                          recovery.

Primary Substructure    - Any basic substructure or any substructure resulting
                          from a combine or reduce operation.

Pseudostructure         - A combination of component substructures.

Reduce Operation        - Structural matrix and load vector Guyan or modal
                          reduction process to obtain smaller matrices.

Secondary Substructure  - A substructure created from an equivalence operation.

SOF                     - Substructure Operating File. Contains all data
                          necessary to define a structure at any stage,
                          including solutions.

Solution Structure      - The resulting substructure to be used in the solve
                          operation.

Solve Operation         - To obtain solutions using the present structural
                          matrices and user-defined input data.

Table 1.10-17. Summary of Substructure Commands

                       # Mandatory Control Cards     * Required Subcommand

                            Phase and Mode Control

# SUBSTRUCTURE    - Defines execution phase (1, 2, or 3)

    NAME*         - Specifies Phase 1 substructure name

    SAVEPLOT      - Requests plot data be saved in Phase 1

  OPTIONS         - Defines matrix options (K, B, K4, M, P, or PA)

  RUN             - Limits mode of execution (DRY, GO, DRYGO, STEP)

# ENDSUBS         - Terminates Substructure Control Deck

                                 SOF Controls

# SOF             - Assigns physical file for storage of the SOF

# PASSWORD        - Protects and ensures access to correct file

  SOFOUT or SOFIN - Copies SOF data to or from an external file

    POSITION      - Specifies initial position of input file
    NAMES         - Specifies substructure name used for input
    ITEMS         - Specifies data items to be copied in or out

  SOFPRINT        - Prints selected items from the SOF

  DUMP            - Dumps entire SOF to a backup file

  RESTORE         - Restores entire SOF from a previous DUMP operation

  CHECK           - Checks contents of external file created by SOFOUT

  DELETE          - Deletes out selected groups of items from the SOF

  EDIT            - Edits out selected groups of items from the SOF

  DESTROY         - Destroys all data for a named substructure and all
                    the substructures of which it is a component

                            Substructure Operations

  COMBINE         - Combines sets of substructures

    NAME*         - Names the resulting substructure
    TOLERANCE*    - Limits distance between automatically connected grids
    CONNECT       - Defines sets for manually connected grids and releases
    OUTPUT        - Specifies optional output results
    COMPONENT     - Identifies component substructure for special processing
    TRANSFORM     - Defines transformations for named component substructures
    SYMTRANSFORM  - Specifies symmetry transformation
    SEARCH        - Limits search for automatic connects

  EQUIV           - Creates a new equivalent substructure

    PREFIX*       - Prefix to rename equivalenced lower level substructures

  REDUCE          - Reduces substructure matrices

    NAME*         - Names the resulting substructure
    BOUNDARY*     - Defines set of retained degrees of freedom
    RSAVE         - Indicates the decomposition product of the interior point
                    stiffness matrix is to be saved on the SOF
    OUTPUT        - Specifies optional output requests

Table 1.10-17. Summary of Substructure Commands (continued)

  MREDUCE         - Reduces substructure matrices using a normal modes
                    transformation

    NAME*         - Names the resulting substructure
    BOUNDARY*     - Defines set of retained degrees of freedom
    FIXED         - Defines set of constrained degrees of freedom for modes
                    calculation
    RNAME         - Specifies basic substructure to define reference point
                    for inertia relief shapes
    RGRID         - Specifies grid point in the basic substructure to define
                    reference point for inertia relief shapes. Defaults to
                    origin of basic substructure coordinate system.
    METHOD        - Identifies EIGR Bulk Data card
    RANGE         - Identifies frequency range for retained modal coordinates
    NMAX          - Identifies number of lowest frequency modes for retained
                    modal coordinates
    OLDMODES      - Flag to identify rerunning problem with previously computed
                    modal data.
    OLDBOUND      - Flag to identify rerunning problem with previously defined
                    boundary set
    USERMODES     - Flag to indicate modal data have been input on bulk data.
    OUTPUT        - Specifies optional output requests.
    RSAVE         - Indicates the decomposition product of the interior point
                    stiffness matrix is to be stored on the SOF.

                            Substructure Operations

  CREDUCE          - Reduces substructure matrices using a complex modes
                     transformation.

    NAME*          - Names the resulting substructure.
    BOUNDARY*      - Defines set of retained degrees of freedom.
    FIXED          - Defines set of constrained degrees of freedom for modes
                     calculation.
    METHOD         - Identifies EIGC Bulk Data card.
    RANGE          - Identifies frequency range of imaginary part of the root
                     for retained modal coordinates.
    NMAX           - Identifies number of lowest frequency modes for retained
                     modal coordinates.
    OLDMODES       - Flag to identify rerunning problem with previously computed
                     modal data.
    GPARAM         - Specifies structural damping parameter.
    OUTPUT         - Specifies optional output requests.
    RSAVE          - Indicates the decomposition product of the interior point
                     stiffness matrix Is to be stored on the SOF.

  MRECOVER         - Recovers mode shape data from an MREDUCE or CREDUCE
                     operation.

    SAVE           - Stores modal data on SOF.
    PRINT          - Stores modal data and prints data requested.

  SOLVE            - Initiates substructure solution (statics, normal modes,
                     frequency response, or transient response).

  RECOVER          - Recovers Phase 2 solution data.

    SAVE           - Stores solution data on SOF.
    PRINT          - Stores solution and prints data requested.

  BRECOVER         - Basic substructure data recovery, Phase 3.

  PLOT             - Initiates substructure undeformed plots.

Table 1.10-18. Substructure Bulk Data Card Summary

     Bulk Data Used By Substructure Commands REDUCE, MREDUCE, and CREDUCE

  BDYC      - Combination of substructure boundary sets of retained degrees of
              freedom or fixed degrees of freedom for modes calculation.

  BDYS      - Boundary set definition.

  BDYS1     - Alternate boundary set definition.

                Bulk Data Used By Substructure Command COMBINE

  CONCT     - Specifies grid points and degrees of freedom for manually
              specified connectivities - will be overridden by RELES data.

  CONCT1    - Alternate specification of connectivities.

  RELES     - Specifies grid point degrees of freedom to be disconnected -
              overrides CONCT and automatic connectivities.

  GTRAN     - Redefines the output coordinate system grid point displacement
              sets.

  TRANS     - Specifies coordinate systems for substructure and grid point
              transformations.

                 Bulk Data Used by Substructure Command SOLVE

  LOADC     - Defines loading conditions for static analysis.

  MPCS      - Specifies multipoint constraints.

  SPCS      - Specifies single-point constraints.

  SPCS1     - Alternate specification of single-point constraints.

  SPCSD     - Specifies enforced displacements for single-point constraints.

  DAREAS    - Specifies dynamic loadings.

  DELAYS    - Specifies time delays for dynamic loads.

  DPHASES   - Specifies phase lead terms for dynamic loads.

  TICS      - Specifies transient initial conditions.


Table 1.10-19. Substructure Item Descriptions

 EQSS     External grid point and internal point equivalence data.

 BGSS     Basic grid point coordinates.

 CSTM     Local coordinate system transformation matrices.

 LODS     Load set identification numbers.

 LOAP     Load set identification numbers for appended load vectors.

 PLTS     Plot sets and other data required for Phase 2 plotting.

 KMTX     Stiffness matrix.

 LMTX     Decomposition product of REDUCE operation.

 MMTX     Mass matrix.

 PAPP     Appended load vectors.

 PVEC     Load vectors.

 POAP     Appended load vectors on omitted points.

 POVE     Load vectors on points omitted during matrix reduction.

 UPRT     Partitioning vector used in matrix reduction.

 HORG     H or G transformation matrix.

 UVEC     Displacement vectors or eigenvectors.

 QVEC     Reaction force vectors.

 SOLN     Load factor data or eigenvalues used in a solution.

 LAMS     Eigenvalue data from modal reduce operation.

 PHIS     Eigenvector matrix.

 GIMS     G transformation matrix for interior points from a modal reduction.

 K4MX     Structural damping matrix.

 BMTX     Viscous damping matrix.

 PHIL     Left side eigenvector matrix from unsymmetric CREDUCE operation.

 HLFT     Left side H transformation matrix from unsymmetric CREDUCE operation.


     Job Control Deck
       :
       :

     NASTRAN              +
                          |
     ID                   |
                          |
     APP DISP,SUBS        |
                          |
     RESTART              | Executive Control Deck
       :                  |
       :                  |
     (optional)           |
                          |
     CEND                 +

     SUBSTRUCTURE         +
                          |
     SOF                  |
       :                  | Substructure Control Deck
       :                  |
                          |
     ENDSUBS              +

     TITLE =              +
       :                  | Case Control Deck
       :                  +

     BEGIN BULK           +
       :                  |
       :                  | Bulk Data Deck
                          |
     ENDDATA              +



                 Figure 1.10-2. Substructuring input data deck

        +----+ +----+ +----+ +----+ +----+ +----+ +----+ +----+ +----+ +----+
Phase 1 | A  | | B  | | xa | | xb | | E  | | ya | | yb | | yxa| | yxb| | ye |
Phase 2 +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+ +-+--+
COMBINE   +--+---+      +--+---+      |      +--+---+      +--+---+      |
  |          |    EQUIV    |          |         |             |          |
  |        +-+--+--------+-+--+       |       +-+--+        +-+--+       |
  |        | C  | PREFIX | D  |       |       | yc |        | yd |       |
  |        +-+--+ = X    +-+--+       |       +-+--+        +-+--+       |
COMBINE      +-------------+----------+         +-------------+----------+
  |                        |                                  |
  |                      +-+--+                             +-+--+
  |                      | F  |                             | yf |       Phase 3
  |                      +-+--+                             +-+--+          |
  |                        |                                  |             |
REDUCE                   +-+--+-----------------------------+-+--+          |
  |                      | F  |    EQUIV PREFIX = Y         | H  |          |
  |                      +-+--+                             +-+--+          |
COMBINE                    +----------------+-----------------+             |
  |                                         |                               |
  |                                       +-+--+                            |
  |                                       | I  |                            |
  |                                       +----+                            |
SOLVE ------------------------------------------------------------------ RECOVER


+----+
| A  |  Primary Substructures
+----+
+----+
| xa |  Image Substructures
+----+



             Figure 1.10-3. Example of multi-stage substructuring

SUBSTRUCTURE OPERATING FILE TABLE OF CONTENTS


                               E B C L P K M P P U H U Q S P P L L G P L K B P H
                               Q G S O L M M V O P O V V O A O O M I H A 4 M H L
                               S S T D T T T E V R R E E L P A A T M I M M T I F
SUBSTRUCTURE                   S S M S S X X C E T G C C N P P P X S S S X X L T
NO.  NAME  TYPE SS PS LL CS HL--------------------------------------------------
 1  VANE     B   5  0  0  3  6 2 2   2   2 2 2     2 2
 2  RING     B   0  0  0  1  6 2 2   2   2 2 2     2 2
 3  VANER    B   0  1  0  4  6 2 2   2   2 2 2     2
 4  VANEB    B   3  1  0  5  6 2 2   2   2 2 2     2
 5  VANEL    B   4  1  0  2  6 2 2   2   2 2 2     2
 6  WINDMILL C   0  0  2  0  0 2 2   2 2 2 2 2       2 2

 SIZE OF ITEM IS GIVEN IN POWERS OF 10  (0 INDICATES DATA IS STORED IN PRIMARY)





         +--------+   +--------+   +--------+   +--------+   +--------+
         |  RING  |   |  VANE  |   | VANER  |   | VANEB  |   | VANEL  |
         +---+----+   +---+----+   +---+----+   +---+----+   +---+----+
             +------------+------------+------------+------------+
                                       |
                                   +---+----+
                                   |WINDMILL|
                                   +--------+



    Figure 1.10-4. Sample of substructure operating file table of contents

                             +    +----------+    +
           NASTRAN Data Deck +----+          +----+ Printout and Plots
                             +    |          |    +
                                  | PHASE 1  |
                             +    |          |    +
         OPTP from Prior Run +----+          +----+ NPTP and SOF for Input to
                             +    +----+-----+    +  Phase 2 Run on Other
                                       |             Computer
                                       |
                                      SOF Substructure Operating File



                             +    +----------+    +
           NASTRAN Data Deck +----+          +----+ Printout and Plots
                             +    |          |    +
                                  | PHASE 2  |
                             +    |          |    +
  SOFs from Prior Phase 1 or +----+          +----+ SOF for Input to Other
   Phase 2 Runs on Other     +    +----+-----+    +  Computer Phase 2 or Phase
   Computers                           |             3 Runs
                                       |
                                      SOF Substructure Operating File




                             +    +----------+
           NASTRAN Data Deck +----+          |
                             +    |          |
    SOF from Prior Phase 2 +------+ PHASE 3  |
    Run on Other Computer    +    |          |    +
           OPTP from Phase 1 +----+          +----+ NPTP
                             +    +--+----+--+    +
                                     |    |
                                     |    |
                                     |   SOF Substructure Operating File
                                     |
                                     Printout of
                                     Final Results
                                     and Plots


Note: If all processing is performed on the same computer, SOF tape output is
      not required. All communication may be carried out using the same SOF
      disk/drum throughout.


 Figure 1.10-5. Data file organization for NASTRAN multi-stage substructuring


# 1.11  AEROELASTIC MODELING
## 1.11.1  Introduction

   The NASTRAN aeroelastic capability is intended for the study of stability
and response of aeroelastic systems. It is compatible with the general
structural capability, but it is not designed for use with other special
capabilities such as conical shell elements, hydroelastic option, and acoustic
cavity analysis. The structural part of the problem will be modeled as
described in other sections of this manual. This section deals with the
aerodynamic data and the connection between structural and aerodynamic
elements.

   Section 1.11.2 deals with the aerodynamic data. The selection of a good
aerodynamic model will depend upon a knowledge of the theory (see Section 17.5
of the Theoretical Manual). Several choices of aerodynamic theory are
available. All assume small amplitude sinusoidal motions. Transient
aerodynamic forces are obtained by Fourier methods.

   Section 1.11.3 deals with the interconnection between aerodynamic and
structural degrees of freedom. The interpolation methods include both linear
and surface splines. These methods are superior to high order polynomials
since they tend to give smooth interpolation. They are based upon the theory
of uniform beams and plates of infinite extent (see Section 17.3 of the
Theoretical Manual).

   Section 1.11.4 describes modal flutter analysis by the three available
methods.

   Section 1.11.5 gives instructions for modal aerodynamic response analysis.
This includes frequency response, transient response, and random analysis. The
excitation may consist of applied forces or gusts (Doublet-Lattice theory
only).

## 1.11.2  Aerodynamic Modeling

   Aerodynamic elements define the interaction between the structure and an
airflow. Since the elements usually occur in regular arrays, the connection
cards are designed to specify arrays. The grid points associated with the
elements in an array are generated within the program. Spline methods are used
to interpolate for aerodynamic grid point deflection in terms of structural
points.

   For every aerodynamic problem, basic parameters are specified on the AERO
bulk data card. A rectangular aerodynamic coordinate system must be
identified. The flow is in the positive x-direction in this system. The use of
symmetry (or antisymmetry) is recommended to analyze symmetric structures, to
simulate ground effects, or to simulate wind tunnel walls. Any consistent set
of units can be used for the dimensional quantities.

   The types of elements available are shown in Table 1.11-1. Every CAEROi
element must reference a PAERO1 data card, which is used for additional
parameters. Lists of real numbers are sometimes required, which are given on
AEFACT lists. These lists may include division points (for unequal box sizes)
and parameter values.

### 1.11.2.1  Doublet-Lattice Panels

   The lifting surfaces are idealized as planes parallel to the flow. The
configuration is divided into plane panels (macro-elements), each of constant
dihedral. These panels are further subdivided into "boxes" (see Figure
1.11-1), which are trapezoids with sides parallel to the airflow direction. If
an airfoil lies in (or nearly in) the wake of another, then the spanwise
divisions should lie along the same streamline. The boxes should be arranged
so that any fold or hinge lines lie along the box boundaries. The aspect ratio
of the boxes should be roughly unity or less. The chord length of the boxes
should be less than 0.08 times the velocity divided by the greatest frequency
of interest, but no less than four boxes per chord should be used. Boxes
should be concentrated near wing edges and hinge lines or any other place
where downwash is discontinuous. A further discussion of the choice of models
is found in Reference 1. Aerodynamic panels are assigned to groups. All panels
within a group have aerodynamic interaction. The purpose of the groups is to
reduce the time to compute aerodynamic matrices when it is known that
aerodynamic interference is unimportant, or to allow the analyst to
investigate the effects of aerodynamic interference.

   Each panel is described by a bulk data CAERO1 card. A property card PAERO1
may be used to identify associated interference bodies. It is recommended that
a body be identified if the panel is less than one body diameter from the
body. The box divisions along the span are determined either by specifying the
number of equal boxes (NSPAN) or the identity (LSPAN) of an AEFACT data card
which gives a list of division points in terms of a fraction of the span. A
similar arrangement is used in the chord direction. The locations of the two
leading edge points are specified in any coordinate system (CP) defined by you
(including BASIC). The lengths of the sides are specified by you, and they are
in the airstream direction, assuring that the panel is parallel to the flow.
Every panel must be assigned to some group (IGID). If all panels interact,
then select IGID = 1 for all panels.

   There will be many degrees of freedom associated with each aerodynamic
panel. There is an aerodynamic grid point associated with each box within a
given panel. These points are located at the center of each box and are
automatically numbered and sequenced by the program. The lowest aerodynamic
grid point number for a given panel is assigned the same number specified for
the panel designation. The grid point numbers increase in increments of 1 (see
CAERO1 data card figure) over all boxes in the panel. You must be aware of
these internally generated grid points and ensure that their numbers are
distinct from structural grid points. These aerodynamic points are used for
output including displacements, plotting, matrix prints, etc. The local
displacement coordinate system has component T1 in the flow direction and
component T3 in the direction normal to the panel (the element coordinate
system of CAERO1).

### 1.11.2.2  Slender and Interference Bodies

   The bodies are idealized as either "slender" or "interference" elements.
The major purpose of the slender body elements is to account for the forces
arising from the motion of the body, while the interference elements account
for the effects of the body upon the panels and other bodies. Bodies are
further classified as to the type of motion allowed. In the aerodynamic
coordinate system, y and z are perpendicular to the flow. In general, bodies
may move in both the y- and z-directions. Frequently, a body (for example, a
fuselage) lies on a plane of symmetry and only z (or y) motion is allowed.
Thus, any model may contain z-bodies, zy-bodies, and y-bodies. One or two
planes of symmetry or antisymmetry may be specified. Figure 1.11-2 shows an
idealization with bodies and panels. This example case is the one used to
illustrate the Doublet-Lattice program in Ref. 2. It has a body (on the
midplane), a wing, pylon, and nacelle.

   The location of a body is specified on a CAERO2 data card. The location of
the nose and the length in the flow direction are given. The slender body
elements and interference elements are distinct quantities and must be
specified separately. At least two slender body elements are required for
every aerodynamic body, while interference elements are optional. The geometry
is given in terms of the element division points, and the width and height of
the assumed elliptical cross section. The locations of the division points may
be given in dimensionless units or, if the lengths are equal, only the number
of elements need be specified. The semi-widths of the two types of elements
may be specified separately and are given in units of length. Usually the
slender body semi-width is taken as zero at the nose and is a function of x,
while the interference body semi-width is taken to be constant. The
height-to-width ratio must be constant for each body.

   These body elements are primarily intended for use with Doublet-Lattice
panels. The interference elements are only intended for use with panels, while
slender body elements can stand alone. Grid points will be generated only for
the slender body elements. The first grid point will be assigned the ID of the
body and other grid points will be incremented by one. You must ensure that
the IDs of these generated grid points are distinct from all other grid points
in the model.

   There are some rules about bodies which have been imposed. All z-only
bodies must have lower ID numbers than zy-bodies, which in turn must have
lower ID numbers than y-only bodies. The total number of interference bodies
associated with a panel is limited to six. You should be cautious about the
use of associated interference bodies since they tend to increase computing
time significantly.

### 1.11.2.3  Mach Box Theory

   Mach box aerodynamics may be used to compute unsteady supersonic
aerodynamic forces for a flat, isolated wing at supersonic speeds. The surface
(see Figure 1.11-3) may have a leading and/or trailing edge crank (change of
angle). There may be one or two adjacent (to each other) trailing edge control
surfaces. The "inboard" edge (side 1-2 on the connection card) must be a plane
of aerodynamic symmetry or antisymmetry.

   The geometry of the planform is specified on the CAERO3 data card. Two
leading edge corners (points 1 and 4 of Figure 1.11-3) are located by you,
using any NASTRAN coordinate system. These, along with the flow direction,
define the plane of the wing. Up to ten additional points are permitted to
specify cranks and controls; these are dimensional quantities using a
coordinate system in the plane of the wing and with origin at point 1.

   The aerodynamic grid points for interconnection are in the plane of the
element. You must specify a list of x,y pairs for the wing. These are located
using the coordinate system shown in Figure 1.11-3. There must be at least
three points. Additional lists of at least three points are needed for each
control surface which is used. The T3 component of these aerodynamic grid
points is normal to the plane of the element. Interpolation for deflections
and slopes at Mach box locations is done by surface spline routines within the
program. Thus the control point locations can be held fixed, even when the
Mach number is changed. These aerodynamic grid points will be numbered,
starting with the element ID, and must be distinct from all other grid points.

   The following restrictions must be satisfied:

   1. The leading edge and hinge line sweepback angles must be greater than or
      equal to zero.

   2. All control surface sides must be parallel to the flow, or else the aft
      point of the control surface side must be inboard of the forward point.

   3. If a leading edge crank is not present, then x5,y5 do not have to be
      input.

   4. If a trailing edge crank is not present, then x6,y6 do not have to be
      input.

   5. A trailing edge crank cannot be located on a control surface. It must be
      located inboard, outboard, or exactly at the junction of the two control
      surfaces.

   6. Points 8, 10, and 12 are used with points 7, 9, and 11 respectively to
      define the control surface edges. They must be distinct from points 7,
      9, and 11, but they do not have to lie on the wing trailing edge. The
      program will calculate new points 8, 10, and 12 for the wing trailing
      edge. However, points 8, 10, or 12 must be located on the trailing edge
      if the trailing edge crank is located at the left corner of control
      surface one (1) or the right corner of control surface two (2) or
      between the two control surfaces. For example, set x8 = x6 and y8 = y6
      if the crank is at the left corner of control surface one.

   7. When only one control surface is present, it must be control surface one
      (1).

   8. If control surface two (2) is not present, then x11,y11 and x12,y12 are
      not required as input.

   9. If no control surfaces are present, then xi,yi (i = 7 through 12) are
      not required as input.

   10.  No aerodynamic balance for the control surfaces has been included in
        the Mach Box Theory.

   11.  The number of chordwise boxes used as input (NBOX) to the program
        should be carefully selected. Note that NBOX is the number of
        chordwise divisions from the most forward point to the most aft point
        on the lifting surface, as shown in Figure 1.11-4. If the maximum
        number of allowable boxes (200 on the main surface, 125 on each
        control surface) is exceeded, the program will reduce the number of
        chordwise boxes one at a time until the number of boxes is under the
        allowable limit. Expenditure of excessive computer time may occur
        during this process.

   12.  The edge 1-2 will be taken as a plane of symmetry unless SYMXZ=-l
        (see AERO data card).

### 1.11.2.4  Strip Theory

   Modified strip theory can be used for unsteady aerodynamic forces on a high
aspect ratio lifting surface. Each strip may have two or three degrees of
freedom. Plunge and pitch are always used, and an aerodynamically balanced
control surface is optional. If a control surface is present, either a sealed
or an open gap may be used.

   The planform (which may have several strips in one macro-element) is
specified on a CAERO4 bulk data card. A sample planform is shown in Figure
1.11-5. You supply the two leading edge corner locations and the edge chords
as dimensional quantities. Edge chords are assumed parallel to the flow. All
additional geometry (box divisions, hinge locations, etc.) is given in
dimensionless units. Several CAERO4 cards may be used if there are several
surfaces or cranks.

   A grid point is assigned to each strip, and will be assigned an ID starting
with the macro-element ID and incrementing by one for each strip. The plunge
(T3) and pitch (R2) degrees of freedom have the conventional definition. When
a control surface is present, the R3 degree of freedom has a nonstandard
definition, which is the relative control rotation. When interconnecting with
the structure, the ordinary (surface or linear) splines can be used for T3 and
R2, but a special method (see SPLINE3 data card) is used for the relative
control rotation.

   The parameters such as lift curve slope or lag function may be varied to
account for tip effects (three-dimensional flow) and Mach number by AEFACT
data card selection from PAERO4. The AEFACT data card format used by strip
theory is shown in the remarks on the PAERO4 data card. You may request a
Prandtl-Glauert (compressibility and sweep) correction to the value of the
curve slope. The lag function depends upon the local (that is, using the chord
of the strip) reduced frequency. For incompressible flow, it is the
Theordorsen function C(k). An approximate form for this function is given by

                 b
          N       n
   C(k) = -   ---------                                             (1)
         n=0  1-i + /k
                   n

where +0 = 0, may be selected for computing lags. The choice of parameters bn
and +n is left to you so that you may select values suitable for your
requirement. Reference 3 gives values for various Mach numbers and aspect
ratios.

### 1.11.2.5  Piston Theory

   Piston theory in NASTRAN is a form of strip theory. The aerodynamic forces
are computed from third order piston theory, which is valid for high Mach
numbers m >> 1, or sufficiently high reduced frequency m2k2 >> 1. Although the
latter condition may be met in subsonic flow, the primary application of
piston theory is in supersonic flow.

   The coefficients of the point pressure function (relating local pressure to
local downwash) may be modified to agree with the Van Dyke theory and to
account for sweepback effects. The resulting strip parameters will depend upon
the wing thickness distribution and spanwise variation of initial angle of
attack, which must be supplied by you. The point pressure function is given by
Cp = -(4/m)[C1 + 2C2 mgx + 3C3m2 (gx2 + +02)] v, where

   +---------------+------------------------------------------+----------------+
   | Coefficient   |    Van Dyke theory with Sweep            |  Piston Theory |
   +---------------+------------------------------------------+----------------+
   |     _         |        2    2 1/2                        |                |
   |     C         |    m/(m  - s )                           |     1          |
   |      1        |                                          |                |
   +---------------+------------------------------------------+----------------+
   |     _         |      4          2  2    2      2    2 2  |                |
   |     C         |    [m (�+1) - 4s (m  - s )]/4(m  - s )   |  (�+1)/4       |
   |      2        |                                          |                |
   +---------------+------------------------------------------+----------------+
   |     C         |    (�+1)/12                              |  (�+1)/12      |
   |      3        |                                          |                |
   +---------------+------------------------------------------+----------------+

and where

   Cp local pressure coefficient (pressure rise divided by dynamic pressure)

   9x derivative of airfoil semi-thickness in the flow direction

   m  Mach number

   s  sec^, secant of sweepback angle

   v  unsteady dimensionless downwash

   +o initial angle of attack

   y  ratio of specific heats = 1.4

   Geometry specification and interconnection points follow the same rules as
for strip theory (see Section 1.11.2.4). The additional information about
angle of attack and thickness is given on AEFACT data cards which are
referenced by the CAERO5 and PAERO5 data cards. The AEFACT data card format
used by piston theory is shown in the remarks on the PAERO5 data card. If
thickness integrals are input on AEFACT data cards, see the thickness integral
definitions on the CAERO5 data card.

## 1.11.3  The Interconnection Between Structure and Aerodynamic Models

   The interpolation between the structural and aerodynamic degrees of freedom
is based upon the theory of splines (Figure 1.11-6). High aspect ratio wings,
bodies, or other beamlike structures should use linear splines. Low aspect
ratio wings, where the structural grid points are distributed over an area,
should use surface splines. Several splines can be used to interpolate to the
boxes on a panel or elements on a body; however, each point can refer to only
one spline. Any box or body element not referenced by a spline will be "fixed"
and have no motion. For any point, especially a control surface degree of
freedom, a linear relationship (like an MPC) may be specified.

   For all types of splines, you must specify the structural degrees of
freedom and the aerodynamic points involved. The structural points, called the
g-set, can be specified by a list or by specifying a volume in space and
determining all the grid points in the volume. The degrees of freedom retained
at the grid points include only the normal displacements for surface splines.
For linear splines, the normal displacement is always used and, by user
option, torsional rotations or slopes may be included. The global
transformation at structural points is automatically applied for surface and
linear splines.

   The SPLINE1 data card defines a surface spline. This can interpolate for
any "rectangular" subarray of boxes on a panel. For example, one spline can be
used for the inboard end of a panel and another for the outboard end. The
interpolated grid points (k-set) are specified by naming the lowest and
highest aerodynamic grid point numbers in the area to be splined. The two
methods for specifying the grid points use SET1 and SET2 data cards. A
parameter DZ is used to allow some smoothing of the spline fit. If DZ = 0 (the
usual value), the spline will pass through all deflected grid points. If DZ >
0, then the spline (a plate) is attached to the grid deflections via springs,
which produce a smoother interpolation that does not necessarily pass exactly
through any of the points. The flexibility of the springs is proportional to
DZ.

   The SPLINE2 data card defines a linear spline. As can be seen from Figure
1.11-6, this is really a generalization of a simple spline to allow for
interpolation over an area. It is similar to the method often used by
aeronautical engineers who assume that an airfoil chord is rigid. The portion
of a panel to be interpolated and the set of structural points are determined
in the same manner as with SPLINE1. A NASTRAN coordinate system must be
supplied to determine the axis of the spline. Since the spline has torsion as
well as bending flexibility, you may specify the ratio of flexibilities; the
default value for this ratio is 1.0. The attachment flexibilities, Dz, D�x,
and D�y, allow for smoothing, but usually all values are taken to be zero. An
exception would occur if the structural model does not have slopes defined, in
which case the flexibility DTHX must be infinite; the convention DTHX = -1.0
is used in this case. When used with bodies, there is no torsion and the
spline axis is along the body.

   There are certain cases with splines where attachment flexibility is either
required or should not be used. The following special cases should be noted.

   1. Two or more grid points, when projected onto the plane of the element
      (or the axis of a body) may have the same location. To avoid a singular
      interpolation matrix, a positive attachment flexibility must be used.

   2. With linear splines, three deflections with the same spline y-coordinate
      would overdetermine the interpolated deflections since the perpendicular
      arms are rigid. A positive DZ is needed to make the interpolation matrix
      nonsingular.

   3. With linear splines, two slopes (or twists) at the same y-coordinate
      would lead to a singular interpolation matrix. Use DTHX > 0 (or DTHY >
      0) to allow interpolation.

   4. For some modeling techniques, that is, those which use only displacement
      degrees of freedom, the rotations of the structural model are
      constrained to zero to avoid matrix singularities. If a linear spline is
      used, the rotational constraints should not be enforced to these zero
      values. When used for panels, negative values of DTHX will disconnect
      the slope, and negative values of DTHY will disconnect the twist. For
      bodies, DTHY constrains the slopes, since there is no twist degree of
      freedom for body interpolation. For a linear spline, if all of the
      structural points lie on a straight line, the use of infinite (negative
      DTHX or DTHY) rotational flexibility results in a kinematically unstable
      idealization.

   For linear splines used with wings, the parameter DTOR should be selected
as a representative value of EI/GJ.

## 1.11.4  Modal Flutter Analysis

   The purpose of modal flutter analysis is to study the stability of an
aeroelastic system with a minimum number of degrees of freedom. A prerequisite
to modal flutter analysis is the calculation of an aerodynamic matrix with a
transformation to modal coordinates. This operation is often very costly and
care should be taken to avoid unnecessary computations. One method is to
compute the modal aerodynamic matrix at a few Mach numbers and reduced
frequencies and interpolate to others. Matrix interpolation is an automatic
feature of the flutter rigid format. The MKAERO1 and MKAERO2 data cards allow
the selection of parameters for the aerodynamic matrix calculation on which
the interpolation is based.

   The method of flutter analysis is specified on the FLUTTER bulk data card.
The FLUTTER card is selected in case control by an FMETHOD card. Three methods
of flutter analysis are available; K, KE, and PK. These are shown in Table
1.11-2.

   The K-method allows looping through three sets of parameters: density ratio
(p/pref; pref is given on an AERO data card); Mach number m; and reduced
frequency k. For example, if you specify two values of each, there will be
eight loops in the following order.

      LOOP (CURVE)      DENS       MACH      REFREQ

           1             1          1           1
           2             2          I           1
           3             1          1           2
           4             2          1           2
           5             1          2           1
           6             2          2           1
           7             1          2           2
           8             2          2           2

Values for the parameters are listed on FLFACT bulk data cards. Usually, one
or two of the parameters will have only a single value. Caution: Do not set up
a large number of loops; it may take an excessive time to execute.

   A parameter VREF may be used to scale the output velocity. This can be used
to convert from consistent units (for example, in/sec) to any units you may
desire (for example, knots), determined from Vout = V/VREF. Another use of this
parameter is to compute the flutter index, by choosing VREF =bw� * sqrt(u).

   If physical output (grid point deflections or element forces, plots, etc.)
is desired rather than modal amplitudes, this data recovery can be made upon a
user selected subset of the cases. The selection is based upon the velocity;
the method is discussed in Section 3.20.4.

   The KE-method is similar to the K method. By restricting the option, the
KE-method is a more efficient K-method. The two major restrictions are that no
damping (B) matrix is allowed and no eigenvector recovery is made. This means
that the KE-method is not suitable for a control system, but it is a good
method for producing a large number of points for the classical V-g curve. The
KE-method also sorts the data for plotting. A plot request for one curve gives
all of the reduced frequencies for a mode, while a similar request in the
K-method gives all of the modes at one k value.

   The PK-method treats the aerodynamic matrices as frequency dependent
springs and dampers. A frequency is estimated and the eigenvalues are found.
From an eigenvalue, a new frequency is found. The convergence to a consistent
root is very rapid. The major advantage of the method is that the damping
values obtained at subcritical flutter conditions appear to be more
representative of the physical damping. Another advantage occurs when the
stability at a specified velocity is required, since many fewer eigenvalue
analyses are needed to find the behavior at one velocity.

   The input data for the PK-method also allows looping, as in the K method.
The inner loop of your data is velocity, with Mach number and density on outer
loops. Thus, the effects of varying any or all of the three parameters on one
run is possible.

   Subsets of flutter analysis for checking data are listed under the
description of the SOL card in Section 2.2.3.

## 1.11.5  Modal Aeroelastic Response Analysis

   The purpose of the modal aeroelastic response analysis is to study the
behavior of an aeroelastic system resulting from applied loads and gusts. One
rigid format can solve frequency response, random response, and transient
response problems. The capability includes control systems (using NASTRAN
Extra Points and Transfer Functions), multiple loading conditions (with
SUBCASES), and rigid body modes.

   The input data deck is the same as for the flutter analysis, except for
load requests and output selection. The point loads are applied with standard
RLOAD (frequency response) or TLOAD (transient response) data cards. For gust
fields, which are only implemented for the Doublet-Lattice/Body Aerodynamic
theory, the vertical stationary gust velocity can be specified with either
RLOAD or TLOAD cards. In this manner, the response to either random or
time-dependent gusts may be obtained.

   For random response analysis, the power spectral density of the load must
be supplied. For gusts, either the Von Karman or the Dryden formula can be
selected. The output power spectral density is requested by the XYOUT Case
Control cards. The r.m.s. value and No, the expected frequency, are
automatically printed when PSDF information is requested.

   You must supply the basic flight conditions. The velocity is specified by
the AERO data card, while Mach number and dynamic pressure (q) are supplied on
PARAM bulk data cards.

   The damping must be modal damping. Ordinarily, a modal viscous damping is
assumed, as in the NASTRAN modal dynamic rigid format. A parameter KDAMP = -1
can be used to substitute modal structural damping; the modal stiffness is
multiplied by [1+ig(w)].

               This figure is not included in the machine readable
               documentation because of complex graphics.

   Figure 1.11-1. An aerodynamic doublet-lattice panel subdivided into boxes


               This figure is not included in the machine readable
               documentation because of complex graphics.

Figure 1.11-2a. N5KA example with three panels (ten boxes), two bodies (nine
slender body elements), and seven interference elements

               This figure is not included in the machine readable
               documentation because of complex graphics.

Figure 1.11-2b. N5KA example with three panels (ten boxes), two bodies (nine
slender body elements), and seven interference elements

               This figure is not included in the machine readable
               documentation because of complex graphics.

                        Figure 1.11-3. Mach box surface

                  GRAPHIC DISPLAY OF REGIONS ON MAIN SEMISPAN

MACH NUMBER   1.300     BOX WIDTH     .052064         BOX LENGTH       .043248

                   SS                                             S  MAIN
                   SS.                                            1  CNTRL 1
                   SSS.                                           2  CNTRL 2
                   SSS..                                          .  DIAPHRAGM
                   SSSS..                                         ;  WAKE
                   SSSS..
                   SSSSS...
                   SSSSS....
                   SSSSSS....
                   SSSSSS.....
                   SSSSSSS.....
                   SSSSSSS......
                   SSSSSSSS......
                   SSSSSSSSS......
                   SSSSSSSSSS......
                   SSSSSSSSSSS......
                   SSSSSSSSSSSS......
                   SSSSSSSSSSSSS......
                   SSSSSSSSSSSSSS......
                   SSSSSSSSSSSSSS......
                   SS1111122SSSSS.....
                   SS111112222SSS....
                   SS1111122222SS...
                   SS1111122222SS..
                             22SS.
                                S

                  (b) Surface as generated by program

   Figure 1.11-4. Mach box surface showing Mach boxes and diaphragm

               This figure is not included in the machine readable
               documentation because of complex graphics.

              Figure 1.11-5. Strip theory example lifting surface

               This figure is not included in the machine readable
               documentation because of complex graphics.

              Figure 1.11-6. Splines and their coordinate systems

Table 1.11-1. Aerodynamic Elements

                Doublet    Lifting Body
                Lattice    (Inter-      Mach Box    Strip       Piston
Type            Panel      ference)     Surface     Theory      Theory

Data Cards      CAERO1     CAERO2       CAERO3      CAERO4      CAERO5
                PAERO1     PAERO2       PAERO3      PAERO4      PAERO5

Mach Number     Subsonic   Subsonic     Supersonic  All regimes Hypersonic

Symmetry        2 planes   2 planes     1 plane     None        None
Options         y = 0      y = 0        required
                z = 0      z = 0


Interaction     Panels and bodies       Boxes on    None        None
                in the same group       one surface

Comments                                One or two  Control     A strip theory,
                                        control     surface     coefficients
                                        surfaces    allowed.    from piston or
                                                    User may    Van Dyke theory.
                                                    vary        Control surface
                                                    parameters.

Interconnection Box        Slender body User        Strip       Strip
to Structure    centers    element      specified   1/4-chord   1/4-chord
                           centers      locations

Displacement    3,5        3,5 z-bodies 3           3,5 No      3,5 No control
Components Used            2,6 y-bodies             control     3,5,6 Control
at Connection                                       3,5,6
Points                                              Control

Table 1.11-2. Flutter Analysis Methods

                 "K"                  "KE"                 "PK"

Structural    K (complex)          K (complex)           K (real)
Matrices      B (complex)                                B (real)
              M (complex)          M (complex)           M (real)

Aerodynamic   M (complex)          M (complex)           K (real)
Matrices                                                 B (real)

User Input    p-density            p-density             p-density
Loops         m-Mach number        m-Mach number         m-Mach number
              k-reduced frequency  k-reduced frequency   V-velocity

Output        V-g curve            V-g curve             V-g curve
              Complex modes                              Complex modes
              Displacements                              Displacements
              Deformed plots                             Deformed plots

Method        Compute roots for    Compute roots for     For each p, m, V,
              user input p, m, k.  user input p, m, k.   iterate on each root
                                   Reorder output so a   to find consistent
                                   "curve" refers to a   results. (Details
                                   mode.                 in the Theoretical
                                                         Manual.)

Eigenvalue    Several methods      Complex Upper*        Real Upper*
Method        available, selected  Hessenberg            Hessenberg
              by user via CMETHOD
              in case control.



* No CMETHOD card is used.

REFERENCES

1. Giesing, J.P., T. P. Kalman, and W. P. Rodden, "Subsonic Unsteady
   Aerodynamics for General Configurations," Part II; Volume I, Application of
   the Doublet-Lattice Method and the Method of Images to Lifting-Surface/Body
   Interference; AFFDL-TR-71-5; April 1972.

2. Giesing, J.P., T. P. Kalman, and W. P. Rodden, "Subsonic Unsteady
   Aerodynamics for General Configurations," Part II; Volume II, Computer
   Program N5KA; AFFDL-TR-71-5, April 1972.

3. Yates, E. C. and R. M. Bennett, "Use of Aerodynamic Parameters from
   Nonlinear Theory in Modified-Strip-Analysis Flutter Calculations for
   Finite-Span Wings at Supersonic Speeds;" NASA TN D-1824; July 1963.

4. Bisplinghoff, R. L., H. Ashley, and R. L. Halfman, "Aeroelasticity," pp.
   682, 691; Addison-Wesley; 1955.



# 1.12  CYCLIC SYMMETRY

   Many structures, including pressure vessels, rotating machines, and
antennae for space communications, are made up of virtually identical segments
that are symmetrically arranged with respect to an axis. There are two types
of cyclic symmetry as shown in Figures 1.12-1 and 1.12-2: simple rotational
symmetry, in which the segments do not have planes of reflective symmetry and
the boundaries between segments may be general doubly-curved surfaces; and
dihedral symmetry, in which each segment has a plane of reflective symmetry
and the boundaries between segments are planar. The use of cyclic symmetry
allows you to model only one of the identical substructures. There will also
be a large saving of computer time for most problems. The theoretical
treatment for cyclic symmetry is given in Section 4.5 of the Theoretical
Manual. 

   The total model consists of N identical segments which are numbered
consecutively from 1 to N. You supply a NASTRAN model for one segment, using
regular elements and standard modeling techniques, except grid points are not
permitted on the polar axis. All other segments and their coordinate systems
are automatically rotated to equally spaced positions about the polar axis by
the program. The boundaries must be conformable, that is, the segments must
coincide. This is easiest to insure if a cylindrical or spherical coordinate
system is used, but such is not required. The PARAM card, CTYPE, is used to
specify either rotational symmetry or dihedral symmetry; and the number of
segments, N, in the structural model is specified on the PARAM card, NSEGS. As
indicated in Figure 1.12-2, dihedral symmetry provides solutions for each
segment and its reflected image. This requires application of both symmetric
and antisymmetric boundary conditions. 

   In rotational symmetry the basic transformation equation between the
structure segments n = 1, 2, etc. and the harmonic indices k = 0, 1, 2, etc.
is 

    n   _o   KMAX _kc              _kx
   u  = u  +  -  [u   cos(n-1)ka + u   sin(n-1)ka]                  (1)
             k=1

where

      n
     u  is any displacement, load, stress, etc., on the nth segment (n = 1,
     2...NSEGS),

     _o  _kc  _ks
     u , u  , u     are the corresponding cyclic coefficients used in the
                    solution which define the entire structure,

     k is the cyclic index (that is, KINDEX),

     KMAX is the limit (KMAX <= N/2) of k. (If all values of k are used, the
     transformation is exact),

            2+
     a  =  ----- is the circumferential angle for each segment.
           NSEGS

In dihedral symmetry the repeated request may be divided into two half
segments divided by a plane of symmetry. The solution is obtained for
symmetric motions (S) and antisymmetric motions (A) of the right half segment
modeled by you. Thus, for each cyclic index, k, four coefficients are obtained
defining the variable, n, that is, �ks; �kc,S; �ks,A; and �kc,A. In the right
hand segment the terms are added: 
               _     _       _
   Right side: uks = uks,S + uks,A                                  (2)

In the left hand mirror image the antisymmetric solution is subtracted:
              _     _       _
   Left side: uks = uks,S - uks,A                                   (3)

The reason for using dihedral symmetry is to reduce the size of the model by
one half. However in static analysis, this procedure requires twice as many
solutions as in rotational cyclic symmetry. In normal modes analysis only the
modes for the symmetrical components ukc,S and uks,A are obtained. The modes
for the other two terms are identical and correspond to a one segment rotation
of the structure. 

   The two boundaries are called sides 1 and 2. In the case of rotational
symmetry, side 2 of segment n is connected to side 1 of segment n+l, as shown
in Figure 1.12-1. In the case of dihedral symmetry, side 1 is on the boundary
of the segment and side 2 is on the plane of symmetry for the segment, as
shown in Figure 1.12-2. In either case the grid point numbers on sides 1 and 2
must be specified on the bulk data card, CYJOIN. 

   As indicated in the Theoretical Manual Section 4.5, the cyclic symmetry
analysis uses a finite Fourier transformation. Hence, the use of cyclic
symmetry procedures does not introduce any additional approximations beyond
those normally associated with finite element analysis. In the case of static
analysis, a shortened approximate method may be used where the maximum value
of the harmonic index is specified on the PARAM card, KMAX. The default
procedure is to include all harmonic indices. The use of a smaller number of
harmonic indices is similar to truncating a Fourier series. The stiffness
associated with the higher harmonic indices tends to be large, so that these
components of displacements tend to be small. In the case of vibration
analysis, the solutions are performed separately for each harmonic index. The
harmonic index for each solution is specified on the PARAM card, KINDEX. The
standard restart procedures can be used to calculate vibration modes for
additional harmonic indices. 

   No restrictions are placed on the use of the single point constraint, the
multipoint constraint, or the OMIT feature of NASTRAN, other than that the
constraints must be the same for each segment. Constraints between segments
are automatically applied to the degrees of freedom at grid points specified
on CYJOIN bulk data cards which are not otherwise constrained. The SPCD bulk
data card may be used to vary the magnitude of enforced displacements for each
of the segments. In the case of static analysis, the OMIT feature may be used
to remove all degrees of freedom at internal grid points without any loss of
accuracy. Since this reduction is applied to a single segment prior to the
symmetry transformations, it can greatly reduce the amount of subsequent
calculation. In the case of vibration analysis, the OMIT feature is used in
the usual way to reduce the size of the analysis set and involves the usual
approximations. The SUPORT card for free bodies cannot be used with cyclic
symmetry. 

   Static loads are applied to the structural model in the usual way. A
separate subcase is defined for each segment (half segment for dihedral
symmetry) and loading condition. The subcases for static loading must be
ordered sequentially, according to the segment numbers. Multiple loading
conditions for each segment must be in consecutive subcases. In the case of
rotational symmetry, there will be a number of subcases equal to the number of
segments in the structural model for each loading condition. In the case of
dihedral symmetry, there will be twice as many subcases as for rotational
symmetry because of the two symmetric components. If there is more than a
single loading condition, the number of loading conditions must be specified
on the PARAM card, NLOAD. 

   An alternate procedure for specifying the static loads may be used if the
transform values of the forcing functions are known. In this case, the
transform values of the loads are specified directly on the usual loading
cards. The PARAM card, CYCIO, must be included in the Bulk Data Deck to
indicate that cyclic transform representation rather than physical segment
representation is being used for the static loads. If this option is used, the
subcases must be ordered according to the symmetrical components with the
cosine cases preceding the sine cases for each symmetrical component. The
output quantities will also be prepared in terms of the symmetric components. 

   If the loading is specified in terms of the physical segments, the data
reduction will also be done in terms of the physical variables. All of the
normal outputs, including structure plots, are available. No provision is made
to recover physical segment data in vibration analysis. The available output
data does, however, include the symmetrical components of dependent
displacements, internal forces, and stresses. 

   For purposes of minimizing matrix bandwidth, the equations of the solution
set are normally sequenced with the cosine terms alternating with the sine
terms. You may request an alternate sequence on the PARAM card, CYCSEQ, which
orders all cosine terms before all sine terms. The latter may improve
efficiency when all of the interior points have been omitted.

      1.You model one segment.

      2.Each segment has its own coordinate system which rotates with
        the segment.

      3.Segment boundaries may be curved surfaces. The local
        displacement coordinate systems must conform at the joining
        points. You give a paired list of points on Side 1 and Side 2
        which are to be joined.

               This figure is not included in the machine readable
               documentation because of complex graphics.

                      Figure 1.12-1. Rotational symmetry

      1.You model one-half segment (an R segment). The L half segments
        are mirror images of the R half segments.

      2.Each half segment has its own coordinate system which rotates
        with the segment. The L half segments use left hand coordinate
        systems.

      3.Segment boundaries must be planar. Local displacement systems
        axes, associated with inter-segment boundaries, must be in the
        plane or normal to the plane. You list the points on Side 1 and
        Side 2 which are to be joined.

               This figure is not included in the machine readable
               documentation because of complex graphics.

                       Figure 1.12-2. Dihedral symmetry


# 1.13  FULLY STRESSED DESIGN

   The fully stressed design option is part of the static analysis rigid
format for structural analysis. Functional modules (OPTPR1 and OPTPR2) are
provided to automatically adjust the properties based on maximum stress
levels, and to control the number of design iterations based on user-supplied
convergence criteria. All elements using a common property are sized together,
that is, a plate with uniform thickness remains uniform. If you want to scale
the properties for each element separately, each element must have its own
property card. After a sufficient number of iterations, the element properties
will be adjusted to the minimum values necessary to carry the prescribed
loads. 

   The process begins by performing a static analysis for all loading
conditions using the initial values for all element properties. A new
property, P2, will be scaled such that 

                 +
   P  = P  [------------]                                           (1)
    2    1   + + (1-+)�

where P1 is the current property value and � is an iteration factor with a
default value of unity. The scale factor, +, is defined as follows: 

             +
   + = Max (---)                                                    (2)
             +
              l

where + is a stress value and +l is a stress limit. The maximum value of + is
taken for all loading conditions. Values of � smaller than unity limit the
property change in a single iteration, and thereby tend to improve the
stability of the process. The maximum change in any property is limited by 

           P
            2
   K    < --- < K                                                   (3)
    min    P     max
            i

where Pi is the initial value of the property and Kmin and Kmax are
user-supplied limits. 

   Convergence is achieved by completing the specified number of iterations,
by having all selected element properties reach the specified limits, or by
satisfying the following convergence criteria: 

   |+ - + |
   |     l|
   --------  < �                                                    (4)
      + 
       l

where � is a user-supplied convergence limit.

   The following actions are required by you in order to utilize the fully
stressed design capability: 

   1. You must select stress output in the Case Control Deck for all elements
      that will participate in the fully stressed design. 

   2. All required stress limits must be specified on the structural material
      cards associated with element properties that will participate in the
      fully stressed design. 

   3. The property optimization parameters must be specified on the bulk data
      card POPT. This card contains user-specified values for the maximum
      number of iterations, the convergence criteria (�), the iteration factor
      (�), and output options to print and/or punch the calculated values of
      the element properties. 

   4. The property optimization limits (Kmin and Kmax) must be specified on the
      PLIMIT bulk data card if you want to limit the maximum and minimum
      values of the element properties. 

   The detailed definitions of the scale factors for each of the element types
are given in Table 1.13-1. The symbols +t, +c, and +s represent the limiting
stress values in tension, compression, and shear, given on the structural
material cards. All of the properties listed for each element are scaled in
the same way, that is, both the area and torsional constant for the ROD are
modified using the same scale factor. 

         Table 1.13-1. Scale Factors for Fully Stressed Design

+-------+--------------------------+-------------------+----------------------+
|Element|Stress Value Used         |Scale Factor (+)   |Properties Changed    |
+-------+--------------------------+-------------------+----------------------+
|ROD    |Axial Tension (+1)        |Max (+1/+t,+2/+c,  |Area (A)              |
|TUBE   |Axial Compression (+2)    |     �/+s)         |Torsional Constant (J)|
|       |Torsion (�)               |                   |                      |
+-------+--------------------------+-------------------+----------------------+
|       |             +            |                   |                      |
|BAR    |Fiber Stress |End a (+a1) |Max (+a1/+t,+b1/+t,|Area (A)              |
|       |Tension      |End b (+b1) |     +a2/+c,+b2/+c)|Torsional Constant (J)|
|       |             +            |                   |Moments of Inertia    |
|       |             +            |                   |(I1, I2, I12)         |
|ELBOW  |Fiber Stress |End a (+a2) |                   |(I12 for BAR only)    |
|       |Compression  |End b (+b2) |                   |                      |
|       |             +            |                   |                      |
+-------+--------------------------+-------------------+----------------------+
|TRMEM  |Principal Tension (+1)    |Max (+1/+t,+2/+c,  |Thickness (t)         |
|QDMEM  |Principal Compression (+2)|     �m/+s)        |(Thicknesses t1, t2,  |
|QDMEM1 |Maximum Shear (�m)        |                   |t3 for TRIM6)         |
|QDMEM2 |                          |                   |                      |
|IS2D8  |                          |                   |                      |
|TRIM6  |                          |                   |                      |
+-------+--------------------------+-------------------+----------------------+
|TRPLT  |Same as Above             |Same as Above      |Moment of Inertia (I) |
|QDPLT  |(Fiber Distances z1 & z2) |                   |                      |
|TRBSC  |                          |                   |                      |
+-------+--------------------------+-------------------+----------------------+
|TRIA1  |Same as Above             |Same as Above      |Moment of Inertia (I) |
|QUAD1  |                          |                   |Membrane Thickness    |
|       |                          |                   | (t1)                 |
+-------+--------------------------+-------------------+----------------------+
|TRIA2  |Same as Above             |Same as Above      |Thickness (t)         |
|QUAD2  |                          |                   |                      |
+-------+--------------------------+-------------------+----------------------+
|SHEAR  |Maximum Shear (�m)        | �m                |Thickness (t)         |
|       |                          |----               |                      |
|       |                          | +s                |                      |
+-------+--------------------------+-------------------+----------------------+

# 1.14  THE CONGRUENT FEATURE
## 1.14.1  Introduction

   An important step in any NASTRAN problem is the generation of element
matrices (stiffness, mass, and damping matrices, as required) in the EMG
(Element Matrix Generator) module. In many cases, this step can represent a
significant portion of the total problem activity. Because of the differences
in algorithms and procedures, the cost of generating the element matrices for
an element depends on the element type, its configuration, and its properties.
However, this cost is associated primarily with CPU activity and is not
significantly affected by core size or I/O transfers (see Section 14.3.2 of
the User's Guide).

   Normally, the element matrices are generated in the EMG module once for
each element in the model. However, when two or more elements in the model
have the same element matrices, there is no reason why the same matrices
should be computed separately for each such identical element. By declaring
such elements as congruent, it is possible to cause their element matrices to
be computed only once for all elements in the congruent set instead of their
being computed repeatedly for each of the individual elements in the set. This
results, in general, in a saving of CPU time in the EMG module. In many cases,
judicious formulation of the problem to facilitate the use of the congruent
feature can result in substantial savings in the computational effort. In some
problems, over 99 percent reductions in EMG module CPU times have been
obtained.

# 1.14.2  Congruent Feature Usage

   The congruent feature is specified in NASTRAN by means of one or more
CNGRNT cards in the Bulk Data Deck (see Section 2.4). Any number of such cards
may be employed.

   The CNGRNT bulk data card is an open-ended card and requires the
specification of a primary element identification number and one or more
secondary element identification numbers. The terms primary and secondary as
used with regard to congruent data are purely relative and have no real
significance. Generally, the primary element is the lowest numbered element in
the congruent set, but this need not be so. The element matrices are actually
computed in the EMG module only for the lowest numbered element in a congruent
set (even though this element may not be the primary element). The element
matrices for the rest of the elements in the congruent set are then derived
from these computed matrices.

   When using CNGRNT cards, you should be aware of the following important
characteristics of the congruent capability software design in NASTRAN.

User Responsibility for Congruency Specification

   The elements declared as congruent must have characteristics (such as their
orientation and geometry) that cause their element matrices in the global
coordinate system to be truly identical. The program cannot test the validity
of this structural specification. Therefore it is your responsibility to
ensure that element congruence specifications are valid. Improper congruence
specifications will result in an improper structure definition and will in
turn lead to erroneous results. It should be emphasized that the proper use of
the congruent feature will not cause the answers to be any different from
those obtained without the use of the feature, but will only result in a
saving of CPU time in the EMG module.

Flexibility in Specifying Congruencies

   Clearly, congruency by its very definition can apply only to elements of
the same type. Thus, for instance, a bar element can be congruent only to
another bar element and not to a plate element. However, because of the
effective manner in which the congruent feature has been incorporated into
NASTRAN, elements of different types can be specified on the same logical
CNGRNT card without in any way making the different element types congruent.
Thus, on the same logical CNGRNT card, several bar elements can be declared as
belonging to a congruent set and several plate elements can be specified as
belonging to a separate congruent set. However, you should ensure that such
specifications do not lead to erroneous declarations when elements of
different types have the same identification numbers.

Provision of "Phantom" Element Identification Numbers

   As a corollary to the above, it may be noted that the element
identification numbers (primary or secondary) specified on a CNGRNT card need
not all exist in a model. This greatly facilitates the use of the THRU option
on the card. However, you are cautioned that, if too many non-existent
elements are specified in the CNGRNT data (as may be the case when the THRU
option is used), the EMG module may not have enough core to process all the
CNGRNT data. In that case, an appropriate message is issued and those elements
whose CNGRNT data cannot be processed will have their element matrices
computed separately.

1.14.3  Factors Affecting Congruent Feature Efficiency

   As indicated earlier, the use of the congruent feature results in increased
computational efficiency. The degree of efficiency obtained depends on the
following factors, some of which can be influenced by your input
specifications.

Number of Congruent Elements

   Clearly, the larger the number of elements in a congruent set and the
larger the number of sets, the greater the savings in CPU time.

Type of Elements Specified as Congruent

   Greater savings in CPU time are obtained for certain element types than for
other element types. Thus, for instance, declaring two IHEX3 elements as
congruent will result in more savings than declaring two IHEX1 elements as
congruent.

Type of Analysis

   For a specified congruent set, greater savings are obtained in dynamic
analysis than in static analysis since, in the former, mass and/or damping
matrices need to be computed, in addition to stiffness matrices.

Numbering of Grid Points of the Congruent Elements

   Processing is slightly more efficient if the relative order of the
numbering of the grid points of the congruent elements is the same. Thus, for
instance, two congruent quadrilateral plate elements are processed more
efficiently if their grid points are numbered 1-7-4-6 and 12-23-16-20,
respectively, than if they were numbered 1-7-4-6 and 11-14-27-15,
respectively. In the former case, the grid point numbers of the two congruent
elements increase or decrease in the same order as we go around the elements.
In the latter case, the grid point numbers of the two congruent elements
increase or decrease in different orders as we go around the elements.

## 1.14.4  Examples of Congruent Feature Usage

   The congruent feature is employed in fifteen (15) of the NASTRAN
demonstration problems. A comparison of the EMG module CPU times (on IBM
5/360-95 computer) for these problems with and without the congruent feature
is presented in Table 1.14-1. The savings resulting from the use of the
congruent capability are quite apparent from this table. The most dramatic
savings are obtained in NASTRAN Demonstration Problem Nos. 3-1-2 and 8-1-2, in
which the EMG module CPU times are reduced by more than 99 percent.

Table 1.14-1. Examples of Congruent Feature Usage in NASTRAN Demonstration Problems

                    Congruent Element Data    Module CPU Times (sec)*
                   -------------------------  -----------------------
                                      No. of   (a)        (b)         Saving in
 Ex.  Demo. Prob.  Element  No. of    CNGRNT  Using      Not Using    Module CPU
 No.  No.          Type     Elements  Sets    Congruent  Congruent    Time (%)**

  1   D01-03-1A    QDMEM    216        1        0.8         8.3        90.4
  2   D01-03-2A    QDMEM1   216        1        1.2        13.5        91.1
  3   D01-03-3A    QDMEM2   216        1        1.5        11.1        86.5
  4   D01-08-1A    HEXA1     40        1        0.1         3.5        97.1
  5   D01-09-1A    HEXA2     40        1        0.3         7.4        95.9
  6   D01-11-1A    QUAD1     50        1        0.2         7.7        97.4
  7   D01-13-1A    IHEX1     40        5        2.8        16.9        83.4
  8   D01-13-2A    IHEX2      2        1        2.7         4.5        40.0
  9   D03-01-1A    QUAD1    200        1        0.4        15.4        97.4
 10   D03-01-2A    QUAD1    800        1        0.8       130.5        99.4
 11   D05-01-1A    TRIA1     80        4        0.7        11.7        94.0
 12   D08-01-1A    QUAD1    100        1        0.4         5.8        93.1
 13   D08-01-2A    QUAD1    400        1        0.4        49.1        99.2
 14   D14-01-1A    QUAD2     10        5        1.7         2.3        26.1
 15   D15-0101A    BAR       10        5        1.4         5.0        72.0
                   QUAD2     20        5


* All problems were run on the IBM S/360-95 computer.
** ((b-a)/b)*100

# 1.15  MAGNETIC FIELD PROBLEMS
## 1.15.1  Introduction

The determination of the magnetic fields in and about ferromagnetic bodies
is an important step in the design of many structures and components. In
commercial applications, knowledge of the fields in and near transformers and
electrical machinery is often desired because of their effect on performance.
This is discussed further in Reference 1.

## 1.15.2  Theory

The governing equations of classical electromagnetic wave theory are
Maxwell's equations:

V * D = p                                                        (1)

V * B = 0                                                        (2)

           +B
V x E = - ----                                                   (3)
           +t

             +D
V x H = J + ----                                                 (4)
             +t

where

D =  electric displacement vector

B =  magnetic flux density vector

E =  electric field intensity vector

H =  magnetic field intensity vector

J =  current density vector

P =  charge density

t =  time

Additional relations are:

D = �E

J = +E

B = �H

where

� = permittivity

+ = conductivity

� = magnetic permeability

The present work is concerned only with time-independent fields, thereby
decoupling Equations 1 through 4 into one pair of equations governing the
electrostatic field (Equations 1 and 3) and a second pair governing the
magnetostatic field (Equations 2 and 4). Interest here is in the latter pair
and the appropriate constitutive equations:

V * B = 0                                                        (5)

V x H = J                                                        (6)

with B = �H                                                      (7)

Numerical techniques for solving Equations 5 through 7 include integral
equations and differential equations. The present work uses the differential
equation approach incorporated into NASTRAN.

In the theoretical aspects of the analysis, � is defined as the scalar
potential of the magnetic field anomaly Hm, that is,

     H  = V �                                                    (8)
      m

where Hm is the modification, or anomaly, due to the presence of ferromagnetic
material, to a Biot-Savart field. It is � that is solved for by using the heat
transfer approach in NASTRAN.

In the anticipated applications of this method, accurate values of � will
be required in both the near field and far field. A major drawback of using
the finite element method for solving magnetostatic problems is that the
infinite domain surrounding the ferromagnetic material must be modeled (at
least, to the point at which � may be considered small). These accuracy and
modeling requirements mean that the finite element mesh must be very fine in
all regions. In addition, the results near the finite element boundary may not
be as precise as desired because of the imposed � = 0 boundary condition.

Two methods which could avoid the need for modeling the vast majority of
the exterior domain are the use of infinite elements and the coupling of
integral and differential techniques. These methods are presently being
investigated, but, meanwhile, a third method, harmonic expansions, is being
used to avoid fine modeling to "infinity". In the present applications, all
ferromagnetic material and sources are enclosed by a suitably shaped surface,
usually spherical or prolate spheroidal. Then NASTRAN is used to solve for the
potentials at the grid points on the enclosing surface. Finally, Laplace's
equation

 2
V � = 0                                                          (9)

may be solved, in the proper coordinates, using the potentials on the
enclosing surface as an interior boundary condition.

## 1.15.3  Prolate Spheroidal Harmonic Expansion

Most applications require only prolate spheroidal coordinates. The solution
of Laplace's equation in these coordinates is

            �   n                                 m      (Qmn(�))
�(�,�,�) =  -   -  [A   cos (m�) + B   sin (m�)] P  (�) [---------](10)
           n=0 m=0   mn             mn            n      (Qmn(�o))

where

�       = reduced magnetic scalar potential

�,�,�   = prolate spheroidal coordinates

�o      = coordinate of the interior prolate spheroidal surface

 m   m
P  ,Q   = Legendre functions of the first and second kind, respectively
 n   n

    +                      2+            +1
Amn | =  �m        (n-m)! �  cos        �
Bmn |    ---(2n+1) ------ |  sin (m�)d� | �o(�,�)Pmn(�) d�
    +    4+        (n+m)! �             �
                          0             -1
     +
     | 1, m = 0
�m = | 2, m > 0
     +

�o(�,�) = distribution of potential � on prolate spheroidal surface �=�o

With the use of this expansion, the finite element model can become coarser
as the distance from the prolate spheroidal reference surface increases. In
addition, the model need not extend "too far", since the concept requires an
accurate potential distribution only on the reference surface, which is placed
as close as possible to the ferromagnetic material. However, the
discretization of the reference surface itself must be fine enough to allow
for an accurate representation of the integrals in the computation of the
coefficients Amn and Bmn.

## 1.15.4  Input Data for Magnetostatic Analysis

This section provides user information needed to perform a magnetostatic
analysis with NASTRAN. This information is divided into six parts:  NASTRAN
Card, Executive Control Deck, Case Control Deck, Bulk Data Deck, Data Cards
with Different Meanings, and Output.

### 1.15.4.1  NASTRAN Card

In magnetostatic problems, functional module SSG1 (Static Solution
Generator - Phase 1) generates a data block, HCFLD, that contains the source
magnetic field at each grid point for each subcase resulting from specified
fields on the SPCFLD bulk data card (see Section 1.15.4.4). Since HCFLD is not
used in subsequent functional modules and is generated only for informational
purposes, the costlier computation of grid point source magnetic fields due to
current coils and dipoles is left as an option to you. If these fields are to
be computed for HCFLD, the NASTRAN card must contain MODCOM (9) = 1.

### 1.15.4.2  Executive Control Deck

Magnetostatic analysis is performed by using the steady-state heat transfer
capability (Rigid Format 1, Approach HEAT) in NASTRAN. Therefore, the
Executive Control Deck must contain the following two cards:

1. APP HEAT

2. SOL 1

In addition, there are three functional modules that pertain specifically
to magnetostatic analysis. but are not incorporated into the Rigid Format.
These are briefly described below:

1. Module EMFLD computes the total field intensity and flux density of
   user-selected finite elements. It reads the anomaly field information
   (temperature gradients) which NASTRAN computes in element coordinate
   systems, transforms it to the basic coordinate system, and adds the
   results to the element centroidal source magnetic fields computed in
   functional module SSG1.

2. Module MAGBDY processes bulk data card PERMBDY (see Section 1.15.4.4)
   and converts the grid points on the card to a form more readily usable
   by functional module SSG1.

3. Module PROLATE computes the prolate spheroidal harmonic coefficients to
   be used by an interactive graphics program.

In order to execute the above modules and perform certain tasks related to the
data blocks output from functional module SSG1, the following ALTER statements
to the Rigid Format are required:

ALTER n1 $ (where n1 = DMAP statement number of LABEL HLBL7, just before
            SSG1 module)
MAGBDY GEOM1, HEQEXIN/PER/V,N,IPG $
ALTER n2 $ (where n2 = DMAP statement number of SDR1 module)
SDR1,     ,HCFLD,,,,,,,,,/,HCFLDG,/V,N,NSKIP/STATICS $
SDR1,     ,HCCEN,,,,,,,,,/,HCCENG,/V,N,NSKIP/STATICS $
SDR1,     ,REMFLD,,,,,,,,,/,REMFLG,/V,N,NSKIP/STATICS $
ALTER n3 $ (where n3 = DMAP statement number of SDR2 module)
EMFLD     HOEF1,HEST,CASECC,HCFLDG,MPT,DIT,REMFLG,GEOM1,CSTM,HCCENG/
          HOEH1/V,N,HLUSET $
ALTER  n4 $ (where n4 = DMAP statement number of OFP module, just after
             SDR2 module)
OFP       HOEH1,,,,,//S,N,CARDNO $
PROLATE   GEOM1,HEQEXIN,BGPDT,CASECC,NSLT,HUGV,REMFLG,HEST,MPT,DIT/PROCOF $
OUTPUT2   PROCOF,,,,//0/11 $
TABPT     PROCOF,,,,// $
ENDALTER  $

The OUTPUT2 functional module writes prolate spheroidal coefficient
information to FORTRAN-readable file UT1, which can be used as input to an
interactive graphics post-processor. The TABPT instruction prints that file
for user inspection.

### 1.15.4.3  Case Control Deck

The FORCE (or ELFORCE) card is an optional request used to output the
finite element anomaly and total magnetic fields. The anomaly field is output
in the element coordinate system, the total field intensity is output in the
basic coordinate system, and the total flux density is output in the
coordinate system given on the BFIELD bulk data card (see Section 1.15.4.4).
The basic coordinate system is the default.

In order to output the total magnetic field for an element, the source and
anomaly magnetic fields must be computed for the element, usually at the
centroid. Since the number of elements in a magnetostatic analysis is usually
large, care should be taken in requesting this output for a significant number
of elements.

    The AXISYMMETRIC (or AXISYM) card is used in conjunction with the PROLATE
bulk data card (see Section 1.15.4.4) to indicate symmetric or antisymmetric
boundary conditions (or lack thereof). Symmetry and antisymmetry conditions
refer to the source magnetic field (applied to a symmetric finite element
model) and, therefore, to the anomaly potential with respect to the X-Y plane
of the coordinate system which must be used when prolate spheroidal harmonic
coefficients are to be computed. The options for AXISYM are:

    Option       Meaning

    SYMM         Symmetry conditions, and the source magnetic field for this
                 subcase, will be included in the prolate spheroidal harmonic
                 expansion.

    SYMMANOM     Symmetry conditions, and the source magnetic field for this
                 subcase, will not be included in the prolate spheroidal
                 harmonic expansion.

    ANTI         Antisymmetric conditions, and the source magnetic field for
                 this subcase, will be included in the prolate spheroidal
                 harmonic expansion.

    ANTIANOM     Antisymmetric conditions, and the source magnetic field for
                 this subcase, will not be included in the prolate spheroidal
                 harmonic expansion.

    ANOM         Neither symmetry nor antisymmetry. Also, the source magnetic
                 field for this subcase will not be included in the prolate
                 spheroidal harmonic expansion.

    No option    (Card does not appear.) Neither symmetry nor antisymmetry.
                 Also, the source magnetic field for this subcase will be
                 included in the prolate spheroidal harmonic expansion.

    The specification of SYMM, SYMMANOM, ANTI, or ANTIANOM implies that the
structure is symmetric with respect to the X-Y plane of the required
coordinate system and that only one half, or 180 degrees, of the structure and
surrounding medium is modeled. If ANOM or no specification is made, then full
360 degree modeling is assumed.

    The use of ANOM, with or without SYMM and ANTI, means that only the anomaly
potential and anomaly field will be available for that subcase from the
prolate spheroidal harmonic expansion. Requiring only the anomaly results is
often the situation when the Earth's magnetic field is the source field. When
a current coil is the source, the total potential and field are usually
needed, in which case ANOM would be omitted.

### 1.15.4.4  Bulk Data Deck

    There are eight bulk data cards that pertain specifically to magnetostatics
analysis. A brief description of each card follows.

    1. The BFIELD card specifies a coordinate system identification number in
       which the total flux density for selected elements will be output. (The
       basic coordinate system is the default.) The anomaly field intensity is
       output in the element coordinate system, the total field intensity in
       the basic coordinate system, and the total flux density in the
       coordinate system specified by BFIELD.

    2. The CEMLOOP card defines a circular current coil. The orientation of the
       coil is defined by specifying coordinates of the center of the coil and
       coordinates of two points on its circumference. The magnetic field due
       to the coil is computed from the Biot-Savart law using an elliptic
       integral formulation.

    3. The GEMLOOP card defines a general current coil in piecewise linear
       segments by specifying the coordinates of the endpoints of the segments.
       At most, 14 linear segments are allowed on one logical GEMLOOP card, but
       the segments can be continued on another card.

    4. The MDIPOLE card defines a magnetic dipole moment by specifying the
       coordinates of the location of the dipole and the components of its
       moment. The resulting magnetic field intensity is computed only at those
       points whose distances from the dipole are within ranges defined on the
       MDIPOLE card.

    5. The PERMBDY card specifies points on boundaries of dissimilar magnetic
       permeability. The purpose of this card is two-fold: to reduce computer
       run time and to avoid numerical errors which may occur due to limited
       orders of numerical integration, nonuniform modeling, use of CTETRA
       elements, etc. Such numerical errors may occur as follows: the magnetic
       equivalent loading at a point, resulting from a single finite element,
       is given by the equation:

            �      T
       f  = | (VN )   �H dV                                                          (11)
        i   �    i      c
            V

       It can be shown that, if a point is surrounded by elements of the same
       magnetic permeability �, then fi at the point must be 0. (The integral
       of Equation 11 is obtained from an integration by parts of

       �
       | N  (V�*H )dV
       �  i      c
       V

       which is zero in areas of uniform permeability.)  However, due to
       various combinations of circumstances involving both numerical and
       modeling techniques, fi may be nonzero in areas of uniform permeability,
       and, in fact, may be significant compared with the loading at points
       which are connected to elements of different permeabilities, thus
       degrading the results. The presence of PERMBDY causes NASTRAN to compute
       equivalent loads only at the grid points of the PERMBDY card. Therefore,
       if this card is used, it must contain all appropriate points. In this
       way, the presence of PERMBDY improves numerical accuracy as well as
       computational efficiency.

    6. The PROLATE card defines a prolate spheroidal surface in the finite
       element model, which is used to compute coefficients of a prolate
       spheroidal harmonic expansion of the anomaly or total scalar potential.

       When the PROLATE card is used, NASTRAN assumes an orientation of the
       generating ellipse of the prolate spheroidal surface with respect to the
       basic coordinate system. Therefore, the center of the ellipse is assumed
       to coincide with the origin of the basic coordinate system, the major
       axis of the ellipse is assumed to coincide with the X-axis of the basic
       coordinate system, and the minor axis is assumed to coincide with the
       Y-axis of the basic coordinate system. In addition, the aximuthal
       original of the component of the prolate spheroidal coordinate system is
       the X-Y plane, with the direction of rotation following the right-hand
       rule about the X-axis. This assumption does not preclude the definition
       of other right-handed coordinate systems with which the locations of
       grid points may be defined.

    7. The REMFLUX card specifies remanent flux density for selected elements.
       Since NASTRAN handles only linear materials, it cannot follow the
       hysteresis loop of a magnetization curve. However, as long as the
       section of interest of the magnetization curve is approximately linear,
       REMFLUX may be used to specify nonzero remanence.

    8. The SPCFLD card is used to specify components of source magnetic field
       intensity at selected grid points. One use of this card is to specify
       the Earth's magnetic fields.

### 1.15.4.5  Data Cards with Different Meanings

    In a standard NASTRAN steady-state heat transfer analysis, the basic
unknown in the problem is the temperature at each grid point. In a
magnetostatic analysis, the basic unknown is the anomaly potential Vm.
Therefore, any NASTRAN data card or output which refers to degrees-of-freedom
refers to the anomaly, or reduced, scalar potential. Some examples are bulk
data cards SPC and SPC1, Case Control card THERMAL (or DISPLACEMENT, which is
a carryover from structural analysis), and TEMPERATURE output.

    Two other bulk data cards for which the meanings are different are material
cards MAT4 and MAT5. In heat transfer, these cards contain thermal
conductivity values. In magnetostatics, they specify magnetic permeability.

### 1.15.4.6  Output

    The output available from a magnetostatic analysis is similar to that from
a heat transfer analysis. The temperature output obtained from a DISPLACEMENT
or THERMAL request must be interpreted as anomaly potential output. The load
vector output obtained from the OLOAD request is the magnetic equivalent load.
The temperature gradient and flux output resulting from a FORCE or ELFORCE
request should be interpreted as anomaly magnetic field intensity and anomaly
flux density, respectively. These vectors are output in the element coordinate
system. In addition, the FORCE or ELFORCE request also generates total finite
element magnetic field and induction output. The magnetic field intensity is
output in the basic coordinate system, and the magnetic flux density or
induction is output in a coordinate system specified on a BFIELD bulk data
card.

    Finally, the file of prolate spheroidal harmonic coefficient information is
available for inspection. This file is contained in data block PROCOF. The
TABPT statement needed to print PROCOF is given in Section 1.15.4.2.

REFERENCE

1.  Hurwitz, M. M., and Brooks, E. W., "The Solution of Magnetostatic Field
    Problems with NASTRAN," David W. Taylor Naval Ship Research and Development
    Center, DTNSRDC-82/106, December 1982.

# 1.16  DYNAMIC DESIGN-ANALYSIS
## 1.16.1  Introduction

   The Dynamic Design-Analysis Method (DDAM) is the standard procedure for
shock design of equipment. Often, the equipment is first analyzed using
NASTRAN. The data and results must then be converted into other forms for use
in DDAM. Incorporating DDAM into NASTRAN has enabled the entire process to be
performed more efficiently. (The details of the implementation of DDAM into
NASTRAN are described in Reference 1.)

## 1.16.2  Theory

   The steps of the DDAM procedure are described here very briefly. A more
complete description is given in Reference 2.

   Step 1. Compute natural frequencies and mode shapes. (Rigid Format 3,
Approach DISP)

   Step 2. Compute the participation factor for each mode:

            - M  X
            i  i  ia
      P  = -----------                                              (1)
       a          2
            - M  X 
            i  i  ia

where Mi is the mass of the ith degree-of-freedom and Xia is the ith component
of the ath mode shape.

   It is assumed that only those terms of {Xa} that correspond to a particular
direction are used in Equation 1. That is, the ath mode may have three
participation factors associated with it, one for each orthogonal direction.

   The numerator of Equation 1 may be written as (considering all computed
modes):

         T
      [�]  [M] [V]                                                  (2)

where

   [�] = matrix of eigenvectors (mode shapes), order n x m, with n = order of
         the problem, m = number of modes computed;

   [M] = mass matrix, order n x n; and

   [V] = direction cosine matrix, order n x l with l = 1, 2, or 3, the number
         of desired directions.

Typically, [V] may consist of 1's and 0's which "pick off" desired directions.
However, that form is not necessary and any consistent set of direction
cosines may be used.

   The denominator of Equation 1 may be written as (considering all computed
modes):

         T
      [�]  [M] [�]                                                  (3)

which is the diagonal modal mass matrix. Therefore, Equation 1 may be written
as:

                          T        -1   T
      [P ]    = [diag ([�] [M][�])]  [�] [M][V]                     (4)
        a mxl

   Step 3. Compute the "effective mass" in each mode:

      M  = P  - M  X                                                (5)
       a    a i  i  ia

   Thus,

                             T
      [M ]    = [P ] x  [[[�] [M][V]]                               (6)
        a mxl     a

where the x on the right side indicates the so-called matrix outer product, in
which a term-by-term multiplication is performed. For example, if

      [C] = [A] x [B]                                               (7)

then

      c   = a   b                                                   (8)
       ij    ij  ij

   Step 4. Compute the "effective weight" [Wa] in each mode by multiplying [Ma]
by g, the acceleration due to gravity.

   Step 5. Compute the direction-dependent velocity spectrum design values [Va]
from [Wa].

   Step 6. Compute the effective static load at each mass, due to the ath mode,
by

      F   = M  X    P  V  w                                         (9)
       ia    i  ia   a  a  a

where wa is the ath natural radian frequency.

   The matrix of loads is computed as follows: The matrix product [M][�] is of
order n x m and corresponds to the product Mi Xia of Equation 9. (Here, only
terms of [M][�] in the desired directions are used.) The ath column of [M][�]
corresponds to the ath mode. Multiplying the ath column by wa and by PaVa for
the first desired direction gives a matrix of load vectors of order n x m. If
PaVa's for other desired directions are used, then other n x m sets of loads
are created and appended to the first set. A final load matrix [F], of order n
x ml, is thus created, where l is the number of desired directions; that is,
there will be ml static load cases. (In practice, instead of the product Vawa
in Equation 9, the term actually used is min (Vawa,Aag), where Aa is an
acceleration spectrum design value in g's and g is the acceleration due to
gravity.)

   Step 7. Perform static analyses to compute direction-dependent maximum
responses, using the load cases from Step 6, and calculate element stresses.

   The computation of the effective static load at each mass in Step 6 and the
static analyses of Step 7 may be replaced as follows: For the ath mode {�a},
Equation 9 may be written as

      {F }  =  [M] {� } P  V  w                                    (10)
        a            a   a  a  a

Solving,

      [K] {u }  =  {F }                                            (11)
            a        a

where [K] is the stiffness matrix and {ua} is the vector of grid point
displacements, yields

                  -1
      {u }  =  [K]   [M] {� } P  V  w                              (12)
        a                  a   a  a  a

However, from dynamics,

          2
      [-w  M+K] {� }  = 0                                          (13)
         a        a

or

         -1              1
      [K]  [M] {� }  =  ---  {� }                                  (14)
                 a       2     a
                        w
                         a

Using Equation 14 in Equation 12 yields

                     P  V
                      a  a
      {u }  =  {� } ------                                         (15)
        a        a    w
                       a

(As in Step 6, rather than Va/wa, min (Va/wa,Aag/wa) is used.)

Equation 15 is used to compute the direction-dependent maximum response.

   Step 8. For each of the 2 desired directions, compute the NRL (Naval
Research Laboratory) sums of stresses (see Reference 3) for each element as
follows:

              |   |                    2
      S   =   |S  | +  sqrt(-     (S  ) )                          (16)
       j      | jm|         b.NE.m  jb

where Sjm = maximum stress at the jth point (taken over the modes under
consideration in one desired direction) and Sjb = stresses (other than the
maximum) at the jth point corresponding to the modes described for Sjm.

## 1.16.3  DDAM Implementation in NASTRAN

   Since DDAM requires the determination of natural frequencies and mode
shapes, a NASTRAN/DDAM analysis involves the use of Rigid Format 3 (Approach
DISP) with ALTERs. These ALTERs are required in order to compute the various
quantities described in the previous section. Among these ALTERs are
instructions for NASTRAN to execute eight functional modules that pertain
specifically to DDAM. These modules are briefly described in the following
sections.

### 1.16.3.1  GENCOS

   GENCOS generates the direction cosine matrix [V] in Equation 2. You may
specify a coordinate system which defines the shock directions. A PARAM bulk
data card giving the value of parameter SHOCK passes to GENCOS the coordinate
system identification number of the shock system. If you do not include such a
card, the basic coordinate system will be used. (The value of parameter SHOCK
should, in most cases, correspond to the displacement coordinate system
identification number for the grid points in the problem. However, to allow
for possible exceptions, no check for this correspondence is made.) Parameter
DIRECT must also be specified, defining the directions of the shock system
which are to be considered. The options for DIRECT are 1, 2, 3, 12, 13, 23,
and 123. For example, if DIRECT is 23, then the second and third directions of
the shock coordinate system will be used. If you do not define DIRECT, the
default is 123, that is, all three directions will be considered.

   The DMAP statement for GENCOS is

   GENCOS   BGPDT,CSTM/DIRCOS/C,Y,SHOCK=0/C,Y,DIRECT=123/
                  V,N,LUSET/V,N,NSCALE $

### 1.16.3.2  DDAMAT

   DDAMAT calculates a matrix outer product such as that in Equation 6, and
multiplies the result by parameter GG. For example, to compute effective
weights, Steps 3 and 4 are performed, and GG = g = 386.4 is specified, if
units of pounds and inches are used.

   The DMAP statement for DDAMAT is

   DDAMAT   A,B/C/C,Y,GG $

Parameter GG must be given a value on a PARAM bulk data card or in the DMAP
statement itself.

### 1.16.3.3  GENPART

   It is assumed that, in the eigenvalue analysis, the lowest N modes were
computed. If, in the static analyses (or equivalent static analyses), fewer
modes are to be used, say, the lowest M, where M < N, then the orders of a
number of matrices must be truncated. GENPART generates the partitioning
vectors required by functional module PARTN to partition the necessary
matrices.

   The DMAP statement for GENPART is

   GENPART   PF/RPLAMB,CPLAMB,RPPF,CPMP/C,Y,LMODES/V,N,NMODES $

Parameter LMODES is the integer value of the number of lowest modes to be used
in the static analyses. The value of this parameter must be specified on a
PARAM bulk data card, or else a fatal error will result.

### 1.16.3.4  DESVEL

   DESVEL computes design velocity and acceleration spectra. The assumed form
for velocity is

                   V +W
                    b
      V  =  V  V  ------                                           (17)
             f  a  V +W
                    c

where

      V       =  velocity computed from modified effective weight W

      Vf      =  factor usually associated with a desired direction

      Va,Vb,Vc=  factors usually associated with various ship types and
                 parameters

      W       =  effective weight/1000

Items V and Va are in units of length/second, and Vb and Vc are in units of
effective weight W.

   Acceleration spectrum values may be expressed in one of two forms. The
first form is the same as that for velocity

                    A +W
                     b
      A = A  A  A  -------                                         (18)
           f  a  b  A +W
                     c

The second form is

                                         2
      A = A  A  (A  + W)(A  + W)/(A  + W)                          (19)
           f  a   b       c        d

where A = acceleration is in g's for modified effective weight in. Af, Aa, Ab,
Ac, and Ad are factors defined similarly to factors Vf, Va, Vb, and Vc. If Ad =
0, then the form of Equation 18 is used. In addition, values of Vw/g are
computed and are output along with acceleration values A for comparison
purposes. Also, a matrix of minimum values of Vw and Ag is output for use in
Equation 9, that is,

      A    = min (Vw,Ag)                                           (20)
       min

Finally, the matrix

                1
      A'     = ---  A                                              (21)
         min     2   min
                w

is output for use in Equation 15. Note that the natural frequency must not be
zero. However, this is not a restriction for DDAM since a fixed base is
assumed.

   The DMAP statement for DESVEL is:

   DESVEL   EFFW,OMEGA/SSDV,ACC,VWG,MINAC,MINOW2/C,Y,GG = 386.4/
            C,Y,VEL1/C,Y,VEL2/C,Y,VEL3/C,Y,VELA/C,Y,VELB/
            C,Y,VELC/C,Y,ACC1/C,Y,ACC2/C,Y,ACC3/C,Y,ACCA/
            C,Y,ACCB/C,Y,ACCC/C,Y,ACCD $

Parameter GG is the acceleration due to gravity. A default value of 386.4 is
supplied. Any other value must be specified on a PARAM bulk data card.
Parameters VEL1, VEL2, and VEL3 correspond to the factor Vf in Equation 17, in
the first, second, and third desired directions, respectively. If fewer than
three directions are desired, then only VEL1, or VEL1 and VEL2, are specified.
For example, if only one direction is specified, say direction 3, than VEL1
corresponds to direction 3, the first (and only) desired direction. Parameters
VELA, VELB, and VELC correspond to Va, Vb, and Vc, respectively, in Equation
17. These velocity parameters, VEL1 through VELC, must appear on PARAM bulk
data cards, or else a fatal error will result. If VEL2 or VEL3 is not used,
then values of 0. must be specified.

   Acceleration parameters ACC1 through ACCD are similar to VEL1 through VELC
and refer to Equations 18 and 19.

### 1.16.3.5  DDAMPG

   DDAMPG creates the static load vectors of Equation 9 or the maximum
responses of Equation 15. For the former, the matrix [MP] = [M][�] is input to
DDAMPG and is operated on by a matrix

      [PVW] = [P ] x [A   ]                                        (22)
                a      min

where [Pa] is the matrix of participation factors defined by Equation 4 and
[Amin] is computed from Equation 20. The order of these matrices is m x l,
where m is the number of modes to be used and l is the number of desired
directions. [PVW] is formed by functional module DDAMAT.

   The columns of [PVW] correspond to desired directions. Within a column,
each row term corresponds to a mode. The matrix [MP] is of order n x m, where
n is the number of degrees-of-freedom in the problem. Each column of [MP]
corresponds to a mode, and in each column of [PVW], the ith row term of [PVW]
multiplies the ith column of [MP]. After all columns of [PVW] have been
considered, the resulting static load matrix is of order n x (ml).

   To compute the maximum response of Equation 15, the same operations just
described are performed, except that matrix [PHIG] = [�] replaces [MP] and

                  1
      [PVOW]  =  ---- [A   ]                                       (23)
                   2    min
                  w

replaces [PVW], where w = wa for the ath row of [Amin].

   The DMAP statement for DDAMPG for static loads is

   DDAMPG   MP,PVW/PG/V,N,NMODES/V,N,NDIR $

   For maximum responses, the DMAP statement is

   DDAMPG   PHIG,PVOW/UGV/V,N,NMODES/V,N,NDIR $

### 1.16.3.6  CASEGEN

   The static load and maximum response vectors created in DDAMPG are
considered individual load cases by NASTRAN and must, therefore, be selected
in the Case Control Deck. The number of cases then is ml. For example, the use
of 30 modes and 3 directions gives a total of 90 cases. Rather than having you
generate the SUBCASE cards, CASEGEN generates a new Case Control Data Table
which includes the required cards.

   The DMAP statement for CASEGEN is:

   CASEGEN   CASECC/CASEDD/C,Y,LMODES/V,N,NDIR/V,N,NMODES $

   Parameter LMODES has the same meaning here as in functional module GENPART
and must appear on a PARAM bulk data card, or else a fatal error will result.

### 1.16.3.7  NRLSUM

   Functional module NRLSUM computes the NRL stresses and forces over the m
maximum responses for a given direction for each requested element. The NRL
sum stress for a given component is

             |    |               2
      S  =   |S   | +  sqrt(-  (S  ) )                             (24)
             | max|         j    j
                            .NE.max

where Sj is the stress component for the jth mode and Smax is the maximum of
these stress components taken over all modes under consideration. The Case
Control request for stresses and forces is made in the usual way, except that
SORT2 format must be specified. The output device for the NRL sums (printer,
punch, or both) will be the same as that for the standard stresses and forces.
If principal stresses are computed for an element, they will be computed on
the basis of the NRL sum of the normal stresses. For the BAR element, the
element axial stress in a mode will be added to each of the extensional
stresses due to bending in that mode. The NRL sums will then be computed for
these new extensional stresses. The NRL sums corresponding to the printed
columns headed by AXIAL STRESS, SA-MAX, SB-MAX, SA-MIN, and SB-MIN will be set
to 0.

   In seismic analyses, the square root of the sums of the squares (SQRSS) is
used rather than the NRL sums of the stresses and forces. You may select the
latter method.

   The DMAP statement for NRLSUM is

   NRLSUM   OES2,OEF2/NRLSTR,NRLFOR/V,N,NMODES/V,N,NDIR/
            C,Y,DIRECT = 123/C,Y,SQRSS = 0 $

Parameter DIRECT has the same meaning here as in functional module GENCOS.
Integer parameter SQRSS indicates whether the summing process should use NRL
sums or the SQRSS method. A value of 0 (the default) indicates NRL sums; a
value of 1 indicates SQRSS.

### 1.16.3.8  COMBUGV

   COMBUGV combines the direction-dependent maximum response in a number of
ways. The method used is intended for DDAM analyses, but seismic analyses,
which make use of similar theory, may also be run. In seismic analysis, unlike
DDAM, the maximum responses in the three directions for each mode are combined
into one total response for the mode. This combination may be performed by
simply adding the absolute values of the maximum component responses for the
mode, or by computing the square root of the sum of the squares (SQRSS) of the
component responses. In both cases, the result is a matrix in which each
column represents a total response due to a mode. These responses are then
combined by the SQRSS method over the modes to give a final response vector.
Finally, the NRL sums of the displacements are also computed.

   The DMAP statement for COMBUGV is

   COMBUGV   UGV/UGVADD,UGVSQR,UGVADC,UGVSQC,UGVNRL/V,N,NMODES/V,N,NDIR $

Data block UGVADD is obtained by adding, for each mode, the absolute values of
the component responses for that mode. Data block UGVSQR is obtained by using
the SQRSS method, rather than by adding. Data blocks UGVADC and UGVSQC are
obtained from UGVADD and UGVSQR, respectively, by combining the total modal
responses using the SQRSS method. Data block UGVNRL contains the NRL sums of
the displacements.

## 1.16.4  Input Data for DDAM

   A complete DDAM analysis with NASTRAN is performed in one normal modes
analysis run with a set of DMAP ALTERs. This section describes the input
details for such a run.

### 1.16.4.1  Executive Control Deck

   In addition to standard Executive Control Deck cards, the Executive Control
Deck for the normal modes analysis must include the proper Rigid Format
selection, SOL 3,0 (Approach DISP) and the following DMAP ALTER package. (The
numbers to the left of each card are for explanatory purposes only and are not
actually entered on the card.)

 1. ALTER    n $ (where n = DMAP statement number of LABEL P2)
 2. GENCOS   BGPDT,CSTM/DIRCOS/C,Y,SHOCK = 0/
             C,Y,DIRECT = 123/LUSET/S,N,NSCALE $
 3. DIAGONAL MI/MID/*SQUARE*/-1. $
 4. MPYAD    MGG, PHIG,/MP/0 $
 5. MPYAD    MP,DIRCOS,/PMD/1 $
 6. MPYAD    MID,PMD,/PF/0 $
 7. DDAMT    PF, PMD/EFFW/C,Y,GG = 386.4 $
 8. LAMX,    ,LAMA/LAMB/-1 $
 9. GENPART  PF/RPLAMB,CPLAMB,RPPF,CPMP/C,Y,LMODES/S,N,NMODES $
10. PARTN    LAMB,CPLAMB,RPLAMB/,,,OMEGA/1 $
11. PARAM    //*GE*/TEST/C,Y,LMODES/NMODES $
12. COND     DDAM, TEST $
13. PARTN    PF,,RPPF/,PFR,,/1 $
14. EQUIV    PFR,PF $
15. PARTN    EFFW,,RPPF/,EFFWR,,/1 $
16. EQUIV    EFFWR,EFFW $
17. PARTN    MP,CPMP,/,,MPR,/1 $
18. EQUIV    MPR,MP $
19. PARTN    PHIG,CPMP,/,,PHIGR,/1 $
20. EQUIV    PHIGR,PHIG $
21. LABEL    DDAM $
22. DESVEL   EFFW,OMEGA/SSDV,ACC,VWG,MINAC,MINOW2/C,Y,GG=386.4/C,Y,VEL1/
             C,Y,VEL2/C,Y,VEL3/C,Y,VELA/C,Y,VELB/C,Y,VELC/C,Y,ACC1/
             C,Y,ACC2/C,Y,ACC3/C,Y,ACCA/C,Y,ACCB/C,Y,ACCC/C,Y,ACCD $
23. DDAMAT   PF,MINAC/PVW/1. $
24. DDAMAT   PF,MINOW2/PVOW/1. $
25. DDAMPG   PHIG,PVOW/UGV/S,N,NMODES/S,N,NDIR $
26. DDAMPG   MP,PVW/PG/NMODES/NDIR $
27. CASEGEN  CASECC/CASEDD/C,Y,LMODES/NDIR/NMODES $
28. EQUIV    CASEDD,CASECC $
29. SDR2     CASECC,CSTM,MPT,DIT,EQEXIN,SIL,,,BGPDT,,QG,UGV,EST,,/,OQG3
             OUGV3,OES3,OEF3,/*STATICS*/S,N,NOSORT2 = -1/-1 $
30. SDR3     OUGV3,,OQG3,OEF3,OES3,/OUGV4,,OQG4,OEF4,OES4, $
31. NRLSUM   OES4,OEF4/NRLSTR,NRLFOR/NMODES/NDIR/C,Y,DIRECT = 123/
             C,Y,SQRSS = 0  $
32. OFP      NRLSTR,NRLFOR,,,,//S,N,CARDNO $
33. COMBUGV  UGV/UGVADD,UGVSQR,UGVADC,UGVSQC,UGVNRL/NMODES/NDIR $
34. CASEGEN  CASECC/CASEEE/1/NDIR/NMODES $
35. SDR2     CASEEE,CSTM,MPT,DIT,EQEXIN,SIL,,,BGPDT,,QG,UGVNRL,EST,,/
             ,,OUGV5,,,/*STATICS*/S,N,NOSORT2/-1 $
36. OFP      OUGV5,,,,,//S,N,CARDNO $
37. ENDALTER $

   The following notes are keyed to the cards with the corresponding numbers.

2.    Computes direction cosine matrix [V] in Equation 2.
3.    Creates a diagonal matrix, consisting of the diagonal of the modal mass
      matrix, and inverts it. The new matrix is used in Equation 4.
4.    Computes [M][�] for later use.
5.    Computes [�][M][V] as described in Equation 2.
6.    Computes matrix of participation factors [Pa] (Equation 4).
7.    Computes effective masses and weights in Equation 6.
8.    Creates a matrix of the information on the Real Eigenvalue Table for
      later use in Equation 9.
9.    Creates partitioning vectors which will be used to create a vector of
      natural circular frequencies from a matrix of miscellaneous eigenvalue
      results. Additionally, if the number of modes to be used in computing
      maximum responses is less than the number computed in the normal modes
      analysis, other partitioning vectors are created to reduce the orders of
      a number of matrices.
10.   Creates the vector of natural circular frequencies.
11.   Compares the number of desired modes (LMODES) and the number of computed
      modes (NMODES).
12.   If LMODES >= NMODES, skips to 21.
13-20.  Reduce orders of several matrices from NMODES to LMODES.
22.   Computes shock spectrum design velocities and accelerations as given in
      Equations 17 through 19. In addition, matrices corresponding to
      Equations 20 and 21 are created for use in Equations 9 and 15,
      respectively. If Equations 17 through 20 do not represent the desired
      forms for velocities and accelerations, matrix MINAC or MINOW2 may be
      directly specified on DMI bulk data cards and functional module DESVEL
      may be deleted. MINAC and MINOW2 must be of order LMODES x L; LMODES is
      explained in Section 1.16.3.3 above, and L is the number of desired
      directions.
23.   Creates the outer product of Equation 22.
24.   Creates the matrix of Equation 23.
25.   Computes the LMODES x L matrix of direction-dependent maximum responses.
26.   Creates the LMODES x L static load matrix as in Equation 9.
27.   Generates a new Case Control Data Table which includes the (LMODES x L)
      subcases.
29.   Computes stresses due to each maximum response.
30.   Converts stresses in 29 from SORT1 to SORT2.
31.   Computes the NRL sum or SQRSS stresses and forces for each requested
      element.
32.   Outputs the NRL sum or SQRSS stresses and forces to the printer and/or
      punch, as requested in the Case Control Deck.
33.   Computes various combinations of the component maximum responses.
34-36.  Prepares and prints file of NRL sum displacements.

1.16.4.2  Case Control Deck

   Although the usual selections may be made, two requirements are imposed:

   1. No subcases are to be specified.

   2. Stress and force selections must request SORT2 format.

This last requirement will force all output selections; for example,
displacements, applied loads, etc., to be in SORT2 format. Also, the NRL sum
(or SQRSS) stresses and forces will be printed and/or punched, as requested in
the corresponding STRESS and FORCE requests.

1.16.4.3  Bulk Data Deck

   The values of a number of parameters special to DDAM must be specified. For
those parameters with no default values and for parameters for which the
default values are to be overridden, PARAM bulk data cards will be required.
The parameters are as follows:

   1. SHOCK - The non-negative integer value of this parameter is the
      identification number of the coordinate system which defines the shock
      direction. A non-zero value requires definition of the system on a
      CORDij card. A zero value implies the basic coordinate system with shock
      directions X, Y, and Z. The default value is zero. The value of SHOCK
      should, in most cases, be the same as the displacement coordinate system
      identification number for the grid points.

   2. DIRECT - This parameter may have one of the following integer values: 1,
      2, 3, 12, 13, 23, or 123. The default value is 123. The value of DIRECT
      indicates which directions of coordinate system SHOCK are to be
      considered. For example, if DIRECT = 123, then all three directions will
      be used. If DIRECT = 13, only two directions will be used, the first and
      the third.

   3. GG - The real value of this parameter is the acceleration due to
      gravity. The default value is 386.4.

   4. LMODES - The integer value of this parameter is the number of lowest
      modes to be used in the static analyses. This number may be less than
      the number of modes computed in the normal modes analysis. No default
      value is provided, so the value of this parameter must be given on a
      PARAM bulk card or else a fatal message will result.

   5. VEL1, VEL2, VEL3, VELA, VELB, VELC, ACC1, ACC2, ACC3, ACCA, ACCB, ACCC,
      ACCD - The real values of these parameters control the computation of
      the shock spectrum design values for velocity and acceleration. These
      parameters are defined by Equations 17 through 19 and further explained
      in Section 1.16.3.4. No default values for any of these parameters are
      provided, so a PARAM bulk data card for each parameter must be included
      in the Bulk Data Deck.

REFERENCES

1. Hurwitz, M. M., "A Revision of the Dynamic Design-Analysis Method (DDAM) in
   NASTRAN," David W. Taylor Naval Ship Research and Development Center,
   DTNSRDC-82/107, December 1982.

2. Belsheim, R. O. and O'Hara, G. J., "Shock Design of Shipboard Equipment,"
   NAVSHIPS 250-423-30, May 1961.

3. "Shock Design Criteria for Surface Ships," Naval Sea Systems Command,
   Report NAVSEA 0908-LP-000-3010, May 1976.

# 1.17  PIEZOELECTRIC MODELING
## 1.17.1  Introduction

   The analysis of sonar transducers requires accounting for the effects of
their piezoelectric materials. The theory for these materials couples
structural displacements to electric potentials. This theory has been
incorporated into the finite element formulations of the TRAPAX and TRIAAX
elements in NASTRAN. (See Reference 1 for details of the implementation.)
These elements, trapezoidal and triangular in cross-section respectively, are
solid, axisymmetric rings whose degrees-of-freedom are expanded into Fourier
series, thus allowing non-axisymmetric loads.

## 1.17.2  Theory

   The constitutive relations of a piezoelectric material may be written as

      +   +      +   E        +  +   +
      |{+}|      | [c ] [e]   |  |{�}|
      |   |  =   |            |  |   |                              (1)
      |   |      |    T     S |  |   |
      |{D}|      | [e]  - [� ]|  |{E}|
      +   +      +            +  +   +

where

                                                               T
      {+}  =  stress components =  | +  ,+  ,+  ,+  ,+  ,+   |
                                   +  rr  zz  ��  rz  r�  z� +

                                                                    T
      {D}  =  components of electric flux density =  | D  ,D  ,D   |
                                                     +  rr  zz  �� +

      {�}  =  mechanical strain components

      {E}  =  electric field components

        E
      [c ] =  elastic stiffness tensor evaluated at constant electric field

      [e]  =  piezoelectric tensor

        S
      [� ] =  dielectric tensor evaluated at constant mechanical strain

   The displacement vector of a point within an element is taken to be

             +   +
             | u |
       _     | v |
      {u}  = | w |                                                  (2)
             | � |
             +   +

where u, v, and w are the ring displacements in the radial, tangential, and
axial directions, respectively, and � is the electric potential. The latter
degree-of-freedom is taken to be the fourth degree-of-freedom at each ring.
Each of these quantities is expanded into a Fourier series with respect to the
azimuth position �. The Fourier series for the electric potential has the same
form as the Fourier series for radial displacement u, as given in Section
5.11.1 of the Theoretical Manual.

The "stiffness" matrix for the Nth harmonic is

                                 +  E        +
                                 |[c ]   [e] |
        (N)         � �   (N) T  |           |    (N)
      [K   ]  =  +  | | [B   ]   |   T     S |  [B   ] rdrdz        (3)
                    � �          |[e]   -[� ]|
                    r z          +           +

where [B(N)] is the matrix of "strain"-"displacement" coefficients for the Nth
harmonic.

   Equations 2 and 3 indicate that the matrix equation to be solved for static
analysis may be partitioned as follows:

      +            +  +   +      +    +
      |[K  ]  [K  ]|  |{�}|      |{F�}|
      |  ��     �� |  |   |  =   |  � |                             (4)
      |[K  ]  [K]  |  |{�}|      |{F�}|
      +  ��     �� +  +   +      +  � +

where

                                        T
      {�}  = | u ,v ,w , ..., u ,v ,w  |
             +  1  1  1        n  n  n +

                            T
      {d}  = | � , ..., �  |
             +  1        n +

      {F } =  vector of structural forces
        �

      {F } =  vector of electrical charges
        �

Note, however, that the program assumes that the electric potential �i is the
fourth degree-of-freedom of grid point i.

   Both lumped and consistent mass matrices are available and are of standard
structural form; that is, the mass matrix does not couple the structural and
electrical unknowns. The structural damping matrix also is of standard
structural form. Both point charges and surface charges are also available.

## 1.17.3  Input Data for Piezoelectric Modeling

   Piezoelectric modeling requires some special input data. These include the
specification of a parameter on the NASTRAN card as well as the use of one or
more of four bulk data cards that pertain specifically to piezoelectric
modeling. In addition, some other bulk data cards are treated differently when
used in piezoelectric modeling. The details are discussed in the following
sections.

### 1.17.3.1  NASTRAN Card

   The NASTRAN card allows you to override various NASTRAN system parameters
by defining specific words in the /SYSTEM/ COMMON block (see Section 2.1). The
78th word of /SYSTEM/, that is, SYSTEM (78), has been set aside to indicate
the use of piezoelectric materials. The default value for SYSTEM(78) is zero,
implying that no piezoelectric materials are allowed. If SYSTEM(78) = 1,
piezoelectric materials are allowed and coupling occurs between the structural
and electric degrees-of-freedom. If SYSTEM(78) = 2, piezoelectric materials
are allowed, but no coupling occurs and electrical effects are not taken into
account.

   Setting SYSTEM(78) to its proper value is important for several reasons:

   1. If SYSTEM(78) = 0, no piezoelectric materials are expected, and MATPZ1
      and MATPZ2 cards (see Section 1.17.3.2) will not be searched.

   2. If SYSTEM(78) does not equal 1, a negative ring identification number is
      not allowed on the PRESAX card (see Section 1.17.3.2).

   3. If SYSTEM(78) does not equal 1, NASTRAN will automatically constrain
      degree-of-freedom 4 (the electric potential) at each ring for the zero
      harmonic in the AXISYMMETRIC = COSINE case.

   4. If SYSTEM(78) = 2, some time will be saved in generating the "stiffness"
      matrix compared to the time for the SYSTEM(78) = 1 case.

   5. If SYSTEM(78) does not equal 1, degrees-of-freedom 4, 5, and 6 must be
      removed from the problem via SPCAX or RINGAX cards. If SYSTEM(78) = 1,
      only degrees-of-freedom 5 and 6 must be removed.

### 1.17.3.2  Bulk Data Deck

   There are four bulk data cards that pertain specifically to piezoelectric
modeling. All these cards define piezoelectric material properties. These
properties are usually described by the following matrices:

              +                                    +
              | SE11  SE12  SE13    0     0     0  |
        E     | SE12  SE11  SE13    0     0     0  |
      [S ] =  | SE13  SE13  SE33    0     0     0  |                (5)
              |   0     0     0   SE44    0     0  |
              |   0     0     0     0   SE44    0  |
              |   0     0     0     0     0   SE66 |
              +                                    +

where

      SE66 = 2 ( SE11 - SE12 )

              +                                    +
              |   0     0     0     0    d15    0  |
      [d]  =  |   0     0     0    d15    0     0  |                (6)
              |  d31   d31   d33    0     0     0  |
              +                                    +

              +                  +
        S     | �S11    0     0  |
      [� ] =  |   0   �S11    0  |                                  (7)
              |   0     0   �S33 |
              +                  +

   The matrices in Equation 1 are computed as follows:

        E        E -1
      [c ]  =  [S ]                                                 (8)

                    E
      [e]   =  [d][c ]                                              (9)

and [�S] is given by Equation 7.

   Two of the bulk data cards, MATPZ1 and MATPZ2, describe the piezoelectric
material properties in two different ways. MATPZ1 is used to specify the
parameters in Equations 5 through 7. MATPZ2 is more general and allows you to
enter the full matrices [cE], [e], and [�S]. The only assumption concerning
these matrices is that [cE] and [�S] are symmetric.

   CAUTION: Piezoelectric electric material properties are usually specified
with respect to a standard set of material axes 1, 2, 3. For axisymmetric
solids, direction 1 coincides with the Z-axis and direction 2 coincides with
the �-axis. Polarization direction 3 may vary in the R-Z plane and, for radial
polarization, coincides with the R-axis. When a user specifies properties on a
MATPZ1 card, the transformation from the 1, 2, 3 directions to the R, Z, �
directions is performed by NASTRAN. However, such a transformation is not
performed by NASTRAN when the MATPZ2 card is used. Also, the ordering of the
components of the stress and strain vectors is somewhat different for
conventional piezoelectric specifications and for NASTRAN. The difference is
that the ordering of the Z-� and R-Z shears is interchanged. Once again,
NASTRAN performs the transformation for MATPZ1, but not for MATPZ2.

   The other two data cards, MTTPZ1 and MTTPZ2, allow the values on the MATPZ1
and MATPZ2 cards to be temperature-dependent. (However, the TRAPAX and TRIAAX
elements have not yet been modified to handle the combination of thermal loads
and piezoelectric materials.)

   Point and surface charges may be specified in piezoelectric modeling. These
charges are analogous to structural point loads and pressures, respectively,
and are entered into {F�} in Equation 4. Since the electric potential is
associated with degree-of-freedom 4, point charges may be applied to specific
harmonics with MOMAX bulk data cards or may be specified by MOMENT, MOMENT1,
or MOMENT2 cards applied to POINTAX points. In the latter case, the direction
of the "moment" must be about the radial direction, that is, degree-of-freedom
4. The MKS unit of the point charge is coulombs.

   The PRESAX bulk data card is used to specify surface charges. However, in
order to distinguish between surface charges and structural pressure loads
within the same problem, the first-specified ring identification number on the
PRESAX card (field 4) must be made negative if a surface charge is desired. A
negative ring identification number is, however, allowed only when the
parameter SYSTEM(78) is set to 1 on the NASTRAN card.

## 1.17.4  Notes on Piezoelectric Modeling

   The following notes summarize the important points about piezoelectric
modeling and should prove helpful to you.

   1. In order to use piezoelectric materials, SYSTEM(78) must be set to 1 or
      2 on the NASTRAN card. (The default value is 0.) A value of 1 indicates
      electrical-structural coupling and a value of 2 allows the use of
      piezoelectric materials, but does not take into account any electrical
      effects. The latter case requires that the degrees-of-freedom
      corresponding to the electric potential be constrained.

   2. The electric potential at each ring is considered to be
      degree-of-freedom 4. Degrees-of-freedom 5 and 6 always have zero
      stiffness and must be removed from the problem with SPCAX or RINGAX
      cards. (Degree-of-freedom 4 must also be removed if SYSTEM(78) = 2.)
      Electroded surfaces (surfaces of constant potential) may be specified
      with MPCAX cards.

   3. Only TRAPAX and TRIAAX elements may reference piezoelectric material
      cards MATPZ1 and MATPZ2.

   4. Standard material cards MAT1 and MAT3 are allowed in problems which also
      contain piezoelectric materials.

   5. The SE and d values on MATPZ1 cards will be multiplied by 10-12 by
      NASTRAN. Also, the value of �0 is fixed in NASTRAN as 8.854 x 10-12
      farad/meter.

   6. As may be seen from Equation 3, the lower right-hand portion of the
      stiffness matrix is negative-definite. This situation does not affect
      NASTRAN execution except that grid point singularity warning messages
      are issued for all unconstrained electric potentials.

   7. To specify surface charge loads, the first ring identification number on
      the PRESAX card (field 4) must be negative. This format change will
      allow NASTRAN to distinguish between electrical charges and structural
      pressures within a piezoelectric run. However, this change is allowed
      only when SYSTEM(78) = 1.

   8. Lumped mass and consistent mass are available for TRAPAX and TRIAAX
      elements. The mass associated with the electric potential
      degree-of-freedom is zero. Therefore, if a normal modes analysis by
      GIVENS method is run, all unconstrained electric potentials must appear
      on OMIT cards.

   9. If a structural damping coefficient is specified on a MATPZ1 or MATPZ2
      card in a dynamics problem, the terms of the resulting structural
      damping matrix corresponding to electric potentials will be zero. The
      uniform structural damping parameter G in direct frequency response
      problems should not be used, since its use will result in structural
      damping terms corresponding to the electric potentials.

   10.  Earlier versions of NASTRAN could not handle stresses or forces,
        whether real or complex, in axisymmetric (AXIC) dynamics problems.
        However, NASTRAN can now handle all such cases for the TRAPAX and
        TRIAAX finite elements.

   11.  Material properties specified on MATPZ1 cards are transformed by
        NASTRAN from the standard 1, 2, 3 material directions to the R, Z, �
        directions. Also, the transformation required due to a switch in the
        order of the R-Z and Z-� shears between conventional specifications
        and NASTRAN is performed for MATPZ1 properties. However, material
        properties on MATPZ2 cards are used by NASTRAN as they appear on the
        card. Therefore, any required transformation must be performed by
        you.

REFERENCE

1. Lipman, R. R., and Hurwitz, M. M., "Piezoelectric Finite Elements for
   NASTRAN," David W. Taylor Naval Ship Research and Development Center,
   Report Number DTNSRDC-80/045, April 1980.

# 1.18  FORCED VIBRATION ANALYSIS OF ROTATING CYCLIC STRUCTURES AND TURBOSYSTEMS
## 1.18.1  Introduction

   Forced vibration analysis of rotating cyclic structures and turbosystems
can be conducted using the capability described in this section. Two types of
analyses are possible, and they are both accomplished by means of extensive
DMAP ALTERs that have been developed for use with the Displacement Approach
Rigid Format 8 (DISP APP R.F. 8) and are supplied with the program as two DMAP
ALTER packages. Special functional modules for computing Coriolis,
centripetal, and base acceleration terms, and bulk data parameters specific to
these analyses are some of the features of these two DMAP ALTER packages. It
is to be noted here that the capability is valid for tuned cyclic structures,
that is, structures composed of cyclic sectors or segments that have identical
mass, damping, stiffness, and constraint properties.

   The first type of analysis is very general. It involves the direct forced
vibration analysis of rotating cyclic structures and is accomplished by the
use of the COSDFVA DMAP ALTER package. It is described in Section 1.18.5. This
capability is based on the work described in References 1 and 2.

   The second type of analysis is more specific. It involves the modal forced
vibration analysis of aerodynamically excited turbosystems and is accomplished
by the use of the COSMFVA DMAP ALTER package. It is described in Section
1.18.6. This capability is based on the work described in References 3 and 4.

## 1.18.2  Problem Formulation

   The forced vibration response of a tuned rotating cyclic structure or an
aerodynamically excited turbosystem is collectively described by the following
equations of motion:

        n   ..n       n         n    .n
      [M ] {u  } + [[B ] + 2� [B ]] {u }
                                1

                       n       n
                      e       d      2   n     n      n    n
                 + [[K  ] + [K  ] - �  [M ]] {u } - [Q ] {u }
                                         1

                     n aero.     n non-aero.     n    ..
                 = {P }      + {P }          - [M ] {R }            (1)
                                                 2     o

        n            n+1
      {u }       = {u   }                                           (2)
          side 2         side 1,

for n = 1, 2,..., N,

where n is the cyclic sector number and N is the number of cyclic sectors (or
blades) in the structure. The cyclic sector numbers and their sides referred
to in Equation 2 above are illustrated in Figure 1.18-1. (See Section 1.12 for
a discussion of cyclic symmetry.)

   In the above equations, {un} represents the vibratory displacements in the
nth cyclic sector superposed on the steady-state deformed shape. The other
terms in the equations have the following meanings. (The superscript n
indicating the cyclic sector number has been left out for convenience. The
specific terms that are retained for the direct forced vibration analysis of
rotating cyclic structures and for the modal forced vibration analysis of
aerodynamically excited turbosystems are indicated in Sections 1.18.5 and
1.18.6, respectively.)

      [M]            Mass matrix

      [M ]           Centripetal acceleration coefficient matrix
        1

      [M ]           Base acceleration coefficient matrix
        2

      [B]            Viscous damping matrix

      [B ]           Coriolis acceleration coefficient matrix
        1

        e
      [K ]           Elastic stiffness matrix

        d
      [K ]           Differential stiffness matrix

         aero
      {P}            Aerodynamic load vector

         non-aero
      {P}            Non-aerodynamic load vector

      [Q]            Aerodynamic matrix

       ..
      [R ]           Base acceleration vector
        o

      �              Rotational velocity

   The forced vibration response of the tuned cyclic structure can be grouped
in terms of several uncoupled sets, with each set corresponding to a
permissible circumferential harmonic index, k. Except for k = 0 and k = N/2 (N
even), the cyclic response can be further separated into cosine and sine
components. For k = 0 and k = N/2, only cosine components are defined. (See
Section 4.5 of the Theoretical Manual.)

## 1.18.3  Coordinate Systems

   In order to conveniently pose and solve the forced vibration problem of
general rotating cyclic structures as well as aerodynamically excited
turbosystems, a number of coordinate systems are employed. These are described
below. Figure 1.18-2 illustrates the use of these coordinate systems for a
bladed disc and Figure 1.18-3 illustrates these for an advanced turbopropeller
with its axis of rotation at an angle with respect to the tunnel mean flow.

      1.Vector � is the angular velocity of the XBYBZB (Basic) coordinate
        system with respect to the XIYIZI (Inertial) coordinate system.

      2.Sector n = 1 is always the modeled sector.

      3.Sector numbers, and side numbers within a sector, increase in the
        direction of |�t|.

               This figure is not included in the machine readable
               documentation because of complex graphics.

          Figure 1.18-1. Cyclic sector and side numbering convention

               This figure is not included in the machine readable
               documentation because of complex graphics.

Figure 1.18-2. NASTRAN model of a 12-bladed disc showing the coordinate systems

               This figure is not included in the machine readable
               documentation because of complex graphics.

 Figure 1.18-3. Coordinate systems for an aerodynamically excited turbosystem

               This figure is not included in the machine readable
               documentation because of complex graphics.

Figure 1.18-4. Turboprop axis inclination angle and tunnel coordinate system
orientation in uniform inflow case

   The following coordinate systems are used for general rotating cyclic
structures as well as aerodynamically excited turbosystems.

XIYIZI  Inertial coordinate system

        In the case of general rotating cyclic structures, this coordinate
        system is used to specify the base acceleration in terms of the
        translational accelerations of the axis of rotation. In the case of
        aerodynamically excited turbosystems, this coordinate system is used
        to relate the quantities in the tunnel and the basic coordinate
        systems (described later). The orientation of this coordinate system
        is completely arbitrary except for the XI axis to be parallel to, and
        in the direction of, the XB axis of the basic coordinate system
        described next. The zero reference for time/phase measurements is
        defined when the inertial and the basic coordinate systems are
        parallel.

XBYBZB  Basic coordinate system

        This coordinate system is fixed to the rotating cyclic structure or
        the turbosystem and has its XB axis coincident with the axis of
        rotation, and directed aftward. The location of the origin is
        arbitrary. The XBZB plane contains (approximately) the maximum
        planform of the modeled cyclic sector (or blade). In the case of
        aerodynamically excited turbosystems, the definition of this
        coordinate system is consistent with the theoretical developments of
        the two-dimensional cascade unsteady aerodynamics presently
        incorporated in NASTRAN (Reference 3).

XGYGZG  Grid point location and displacement coordinate systems

        All of these coordinate systems are fixed to the rotating cyclic
        structure or the turbosystem. Any number of such rectangular,
        cylindrical, or spherical coordinate systems can be completely
        arbitrarily defined to locate grid points of the NASTRAN model, as
        well as to request output at these grid points. All of the XGYGZG
        coordinate systems used for output requests collectively form the
        NASTRAN global coordinates system.

   The following coordinate systems are used specifically when modeling
aerodynamically excited turbosystems.

XTYTZT  Tunnel coordinate system

        This is defined to conveniently specify the velocity components of
        the spatially non-uniform tunnel free stream. It can be suitably
        oriented based on the available tunnel data.

        In the special case of aerodynamic excitation in uniform inflow, the
        tunnel coordinate system is oriented such that the XTZT plane is
        parallel to the XIZI plane of the inertial coordinate system as shown
        in Figure 1.18-4. The origin of the XTYTZT system is arbitrarily
        located. The inclination angle of the turbosystem axis of rotation
        with respect to the tunnel flow also lies in a plane parallel to XIZI
        plane. The uniform flow is directed along the +XT axis.

XSYSZS  (Blade) Shank-fixed coordinate system

        The principal advantage of this shank-fixed coordinate system is in
        modeling changes in the blade setting angles by a simple 3 x 3
        transformation matrix relating to the basic coordinate system. ZS
        coincides with the blade shank axis. The definition of the coordinate
        system is otherwise arbitrary.

xsyszs     Internally generated coordinate system on swept chord s

        This coordinate system is internally generated in NASTRAN and is used
        to define the flow and motion properties for the unsteady aerodynamic
        theories on a given swept chord s. It is located at the blade leading
        edge with the xs directed aftward along the chord s. ys is defined
        normal to the blade local mean surface.

## 1.18.4  Structural Modeling of Rotating Cyclic Structures and Turbosystems

   In both types of analyses referred to above, you model only one
rotationally cyclic sector (or segment) of the entire structure (or
turbosystem) as shown in Figures 1.18-2 and 1.18-3. This modeled sector is
considered the n = 1 sector. Each cyclic sector is defined with two sides
which identify its boundaries with the two adjacent cyclic sectors (Figure
1.18-1).

   The side 2 degrees of freedom are related to those on side 1 via the
circumferential harmonic index. The modeling of rigid hub/disk conditions is
accomplished by completely constraining all degrees of freedom on both sides
of the cyclic sector to zero. Although the circumferential harmonic index is
irrelevant in such situations, it should be selected as zero for computational
efficiency.

   The structural model is prepared using the general capabilities of NASTRAN
for modeling rotationally cyclic structures (see Section 1.12; see also
Section 4.5 of the Theoretical Manual).

## 1.18.5  Direct Forced Vibration Analysis of Rotating Cyclic Structures

   This capability addresses the dynamic response of a cyclic structure
rotating about its axis of symmetry at a constant angular velocity, and
subjected to sinusoidal or general periodic loads moving with the structure.
In addition, the axis of rotation itself is permitted translational
oscillations resulting in inertial loads. Coriolis and centripetal
acceleration effects are also included.

   Referring to Equation 1 in Section 1.18.2, all but the [Q]{u} and {P}aero
terms are retained in the analysis.

   Figure 1.18-5 presents a schematic flowchart of this capability.

   The theoretical development of this capability is discussed in detail in
Reference 1. Complete details of the implementation of the capability in an
earlier version of NASTRAN are given in Reference 2.

### 1.18.5.1  Modeling Features

   The rotating structure can be loaded with steady-state sinusoidal or
general periodic loads as follows:

   1. Directly applied loads moving with the structure, and

   2. Inertial loads due to the translational acceleration of the axis of
      rotation ("base" acceleration).

   Sinusoidal loads are specified as functions of frequency using RLOADi bulk
data cards. General periodic loads are specified as functions of time using
TLOADi bulk data cards.

   The following options are provided to specify the form of excitation.

   Directly applied loads may be specified as:

   - periodic functions of time on various segments (PARAM CYCIO = +1)

   - periodic functions of time for various circumferential harmonic indices
(PARAM CYCIO = -1)

   - functions of frequency on various segments (PARAM CYCIO = +1)

   - functions of frequency for various circumferential harmonic indices
(PARAM CYCIO = -1)

                                      ENTER
                                        |
                       +----------------+---------------+
                       |   Finite element model of one  |
                       |    cyclic sector, rotational   |
                       |    speed, constraints, loads   |
                       +----------------+---------------+
                                        |
+--------------+       +----------------+---------------+
| Differential |       |    Generation of stiffness,    |
|  Stiffness   +-------+        mass and damping        |
|   Matrix     |       |            matrices            |
+--------------+       +----------------+---------------+
                                        |
                       +----------------+---------------+
                       | Application of constraints and |
                       | partitioning to stiffness, mass|
                       |      and damping matrices      |
                       +----------------+---------------+
                                        |

           Frequency dependent       Type of      General, periodic in time
                +-------------   Applied Loads   ----------+
                |                                          |
Circumferential |                     Circumferential      |
Harmonic        |       Segment       Harmonic             |       Segment
Dependent    Type of    Dependent     Dependent          Type of   Dependent
    +----- Input/Output -----+               +-------- Input/Output --+
    |                        |               |                        |
    |                        |      +--------+--------+      +--------+--------+
    |                        |      |Fourier decomp.  |      |Fourier decomp.  |
    |                        |      |Phase 1 (time)   |      |Phase 1 (time)   |
    |                        |      +--------+--------+      +--------+--------+
    |                        |               |                        |
    |               +--------+--------+      |               +--------+--------+
    |               |Fourier decomp.  |      |               |Fourier decomp.  |
    |               |Phase 2 (circum.)|      |               |Phase 2 (circum.)|
    |               +--------+--------+      |               +--------+--------+
    |                        |               |                        |
    |                        |               |                        |
    +------------------------+---------+-----+------------------------+
                                       |
                                       |
                       +---------------+----------------+
                       | Application of constraints and |
                       |  partitioning to load matrices |
                       +---------------+----------------+
                                       |
                                       A


Figure 1.18-5a. Overall flowchart for direct forced vibration analysis of
rotating cyclic structures

                                        A
                                        |
                                        |

                                  Selection of
         +----------------  circumferential harmonic
         |                          index, k
         |                        k   <= k <= k
         |                         min         max
         |                              |
         |                              |
         |      +-----------------------+-----------------------+
         |      |   Application of intersegment compatibility   |
         |      |    constraints to stiffness, mass, damping    |
         |      |               and load matrices               |
         |      +-----------------------+-----------------------+
         |                              |
         |                              |
         |      +-----------------------+-----------------------+
         |      |            Solution of independent            |
         |      |            harmonic displacements             |
         |      +-----------------------+-----------------------+
         |                              |
         |                              |
         |               No
         +--------------------  Increment k by 1
                                   k > k    ?
                                        max

                                        | Yes
                                        |
                +-----------------------+-----------------------+
                |   Recovery of segment-dependent independent   |
                | displacements (Inverse Phase 2, if necessary) |
                +-----------------------+-----------------------+
                                        |
                +-----------------------+-----------------------+
                |       Recover of dependent displacements      |
                +-----------------------+-----------------------+
                                        |
                +-----------------------+-----------------------+
                |      Output requests for displacements,       |
                |         stresses, loads, plots, etc.          |
                +-----------------------+-----------------------+
                                        |
                                        |
                                       EXIT


Figure 1.18-5b. Overall flowchart for direct forced vibration analysis of
rotating cyclic structures

   Base acceleration is specified as:

   - function of frequency (PARAM CYCIO = -1 only)

   The base acceleration refers to the translational acceleration of the axis
of rotation and is specified in the inertial coordinate system (see Section
1.18.3). You specify the X, Y, and Z components (magnitude and phase) of the
base acceleration vector as functions of frequency on TABLEDi bulk data cards.
The use of these tables is activated by the bulk data parameters BXTID,
BXPTID, BYTID, BYPTID, BZTID, and BZPTID.

   You are provided with two options to include damping by specifying the form
of the Kdd, Bdd, and Mdd matrices in the functional module GKAD as per
equations 16 through 21 in Section 9.3.3 of the Theoretical Manual. Bulk data
parameters GKAD and LGKAD have been defined for this purpose.

   Section 1.18.5.4 describes all of the bulk data parameters applicable to
this capability.

1.18.5.2  Executive Control Deck

   The salient points are noted as follows:

   1. APP DISP and SOL 8 must be selected.

   2. The DMAP ALTER package, COSDFVA (COSMIC-supplied Direct Forced Vibration
      Analysis of rotating cyclic structures), must be included. The READFILE
      capability of NASTRAN (see Section 2.0.2) can be utilized for this
      purpose as follows:

        READFILE COSDFVA

### 1.18.5.3  Case Control Deck

   The subcase definitions and the selection of other data items for the Case
Control Deck are discussed below.

#### 1.18.5.3.1  Subcase Definitions

   The bulk data parameters CYCIO (= +/- 1) and KMAX (>= 0, <= NSEGS/2 for
even NSEGS, <= (NSEGS - 1)/2 for odd NSEGS, where NSEGS is the number of
cyclic sectors or segments) determine the number, order and meaning of
subcases as follows:

   CYCIO = +1

   The number of subcases is equal to NSEGS, independent of KMAX.

   SUBCASE 1 (SEGMENT NO. 1)
   SUBCASE 2 (SEGMENT NO. 2)
   SUBCASE NSEGS (SEGMENT NO. NSEGS)

   CYCIO = -1

   The number of subcases is equal to FKMAX, where

   FKMAX = 1, if KMAX = 0
         = 1 + 2 * KMAX, if 0 < KMAX <= (NSEGS - 1)/2, NSEGS odd,
         = 1 + 2 * KMAX, if 0 < KMAX <= (NSEGS - 2)/2, NSEGS even, and
         = NSEGS, if KMAX = NSEGS/2, NSEGS even.

   SUBCASE 1 ("k" = 0)
   SUBCASE 2 ("k" = 1c)
   SUBCASE 3 ("k" = 1s)
   SUBCASE 4 ("k" = 2c)
   SUBCASE 5 ("k" = 2s)
      :
      :
   SUBCASE FKMAX ("k" = KMAXs)

   If NSEGS is even and KMAX = NSEGS/2, Subcase FKMAX will represent "k" =
KMAXc, as KMAXs does not exist.

   Directly applied loads on various segments (CYCIO = +1) or their
circumferential harmonic components (CYCIO = -1) are specified under the
appropriate subcases. With RLOADi bulk data cards, null loads need not be
specified by you. With TLOADi bulk data cards, you are required to provide
information to generate null loads where applicable.

   Base acceleration is included only when CYCIO = -1. Based on the activating
PARAMeters BXTID etc., the corresponding inertial loads are internally
calculated and assigned to "k" = 0, 1c, and 1s as applicable.

#### 1.18.5.3.2  Other Data Selection Items

   1. The SPC and MPC request must appear above the subcase level and may not
      be changed.

   2. Either FREQUENCY or TSTEP must be selected and must be above the subcase
      level.

   3. If selected, FREQUENCY must be used to select one and only one FREQ,
      FREQ1, or FREQ2 card from the Bulk Data Deck.

   4. If selected, TSTEP must be used to select the time-steps to be used for
      load definition via a TSTEP card in the Bulk Data Deck.

   5. Direct input matrices are not allowed.

   6. OFREQ must not be used.

   7. DLOAD must be used to define a frequency-dependent or time-dependent
      loading condition for each subcase. For frequency-dependent loads,
      subcases without loads need not refer to a DLOAD card. For
      time-dependent loads, subcases without loads must refer to a DLOAD card
      that explicitly generates a null load.

   8. If random response calculations are desired, RANDOM must be used to
      select RANDPS and RANDTi cards from the Bulk Data Deck.

   The following printed output, sorted by frequency (SORT1) or by point
number or element number (SORT2), is available, either as real and imaginary
parts or magnitude and phase angle (0 - 360 degree lead), for the list of
frequencies specified:

   1. Displacements, velocities and accelerations for a list of PHYSICAL
      points (grid points and extra scalar points introduced for dynamic
      analysis) or SOLUTION points (points used in formulation of the general
      K system).

   2. Nonzero components of the applied load vector and single-point forces of
      constraint for a list of PHYSICAL points.

   3. Stresses and forces in selected elements (ALL available only for SORT1).

   The following plotter output is available for frequency response
calculations:

   1. Undeformed plot of the structural model.

   2. X-Y plot of any component of displacement, velocity, or acceleration of
      a PHYSICAL point or SOLUTION point.

   3. X-Y plot of any component of the applied load vector or single-point
      force of constraint.

   4. X-Y plot of any stress or force component for an element.

   The following plotter output is available for random response calculations:

   1. X-Y plot of the power spectral density versus frequency for the response
      of selected components for points or elements.

   2. X-Y plot of the autocorrelation versus time lag for the response of
      selected components for points or elements.

The data used for preparing X-Y plots may be punched or printed in tabular
form (see Section 4.3). This is the only form of printed output that is
available for random response. Also, a printed summary is prepared for each
X-Y plot which includes the maximum and minimum values of the plotted
function.

### 1.18.5.4  Bulk Data Deck

   The bulk data parameters under user control are described in Section
1.18.5.4.1. The usage of certain bulk data cards is discussed in Section
1.18.5.4.2.

   The bulk data parameters CYCSEQ, CTYPE, and NLOAD, normally under user
control when using the cyclic symmetry feature, are not to be specified by you
in the present case as they either have fixed values assigned to them or are
internally computed. This is discussed below.

   The integer value of CYCSEQ parameter specifies the procedure for
sequencing the equations in the solution set. A value of +1 specifies that all
cosine terms are to be sequenced before all sine terms, and a value of -1
specifies alternating cosine and sine terms. The value has been set to -1.

   The alphanumeric (BCD) value of the CTYPE parameter specifies the type of
cyclic symmetry (rotational or dihedral symmetry). The value has been set to
ROT to indicate rotational cyclic symmetry.

   The integer value of NLOAD specifies the number of loading conditions. This
value is internally computed.

#### 1.18.5.4.1  Bulk Data Parameters

   The following bulk data parameters are used in the direct forced vibration
analysis of rotating cyclic structures:

   1. BXTID, BYTID, BZTID, BXPTID, BYPTID, BZPTID - optional. The positive
      integer values of these parameters define the set identification numbers
      of TABLEDi bulk data cards which define the components of the base
      acceleration vector. The tables referred to by BXTID, BYTID, and BZTID
      define the magnitude of the vector, and the tables referred to by
      BXPTID, BYPTID, and BZPTID define the phase (in degrees) of the vector.
      The default values are -1, indicating that the respective terms are
      ignored.

   2. COUPMASS - CPBAR, CPROD, CPQUAD1, CPQUAD2, CPTRIA1, CPTRIA2, CPTUBE,
      CPQDPLT, CPTRPLT, CPTRBSC - not to be used. These parameters are not to
      be specified by you, as only lumped mass matrices must be used.

   3. CYCIO - required. The integer value of this parameter specifies the form
      of the input and output data. A value of +1 is used to specify physical
      segment representation, and a value of -1 for cyclic transform
      representation. There is no default. A value must be input.

   4. G - optional. The real value of this parameter is used as a uniform
      structural damping coefficient in the formulation of dynamics problems.
      Not recommended for use in hydroelastic problems (use GE on MAT1).

   5. GKAD - optional. The BCD value of this parameter is used to tell the
      GKAD module the desired form of the matrices KDD, BDD, and MDD. The BCD
      value can be FREQRESP or TRANRESP. The default value is TRANRESP.

      NOTE: Remember to define the parameters G, W3, and W4. See Section 9.3.3
      (Direct Dynamic Matrix Assembly) of the Theoretical Manual for further
      details.

   6. GRDPNT - optional. A positive integer value of this parameter causes the
      Grid Point Weight Generator to be executed and the resulting weight and
      balance information to be printed. All fluid related masses are ignored.

   7. KMAX - required. The integer value of this parameter specifies the
      maximum value of the harmonic index, and is used in subcase definition.
      There is no default for this parameter. A value must be input. The
      maximum value that can be specified is NSEGS/2.

   8. KMIN - optional. The integer value of this parameter specifies the
      minimum value of the conic index to be used in the solution loop. KMIN
      can equal KMAX. The default value is 0.

   9. LGKAD - optional. The integer value of this parameter is used in
      conjunction with parameter GKAD. If GKAD = FREQRESP, set LGKAD = 1; if
      GKAD = TRANRESP, set LGKAD = -1. The default value is -1.

   10.  LMAX - optional. The integer value of this parameter specifies the
        maximum harmonic in the Fourier decomposition of periodic,
        time-dependent loads. The default value is NTSTEPS/2, where NTSTEPS
        equals N (from TSTEP bulk data card) plus 2.

   11.  NOKPRT - optional. An integer value of +1 for this parameter causes
        the current harmonic index, KINDEX, to be printed at the top of the
        harmonic loop. The default value is +1.

   12.  NSEGS - required. The integer value of this parameter is the number
        of identical segments in the structural model. There is no default. A
        value must be input.

   13.  RPS - optional. The real value of this parameter defines the
        rotational speed of the structure in revolutions per unit time. The
        default value is 0.0.

   14.  W3 - optional. The real value of this parameter is used as a pivotal
        frequency for uniform structural damping if parameter GKAD =
        TRANRESP. In this case, W3 is required if uniform structural damping
        is desired. The default value is 0.0.

   15.  W4 - optional. The real value of this parameter is used as a pivotal
        frequency for element structural damping if parameter GKAD =
        TRANRESP. In this case, W4 is required if structural damping is
        desired for any of the structural elements. The default value is 0.0.

   16.  WTMASS - optional. The terms of the structural mass matrix are
        multiplied by the real value of this parameter when they are
        generated in the EMA. Not recommended for use in hydroelastic
        problems.

#### 1.18.5.4.2  Usage of Certain Bulk Data Cards

   The following items relate to restrictions on certain bulk data cards:

   1. SUPORT cards are not allowed.

   2. EPOINT cards are not allowed.

   3. SPOINT cards are not allowed.

   4. CYJOIN cards are required.

   5. If a TSTEP bulk data card is used, then it must not be continued, since
      only one uniform time step interval must be specified. The skip factor
      for output, NO, on this card must be 1.

## 1.18.6  Modal Forced Vibration Analysis of Aerodynamically Excited Turbosystems

   This capability is designed to perform modal forced vibration analysis of
turbosystems subjected to aerodynamic excitation.

   Single- and counter-rotating advanced turboprops with significantly swept
blades (see Figure 1.18-3), and axial-flow compressors and turbines are
examples of turbosystems that can be analyzed using this capability.

   Generally non-uniform steady inflow fields and uniform flow fields
arbitrarily inclined at small angles with respect to the axis of rotation of
the turbosystem are considered as the aerodynamic sources of excitation.
Subsonic and supersonic relative inflows are recognized, with a provision for
linearly interpolating transonic aerodynamic loads.

   Although the absolute inflow field does not change with time, the rotation
of the turbosystem results in velocities with oscillatory components relative
to the blades. Relative velocities with harmonic components at the rotational
frequency also exist in uniform flow fields when the turbosystem axis of
rotation is misaligned with the absolute flow direction.

   The capability has the following features:

   1. Turbosystems with both rigid and flexible hubs/disks can be handled.

   2. Differential stiffness effects due to centrifugal loads and any
      (externally specified) steady state airloads are included.

   3. Coriolis and centripetal acceleration (stiffness softening) effects are
      taken into account.

   4. Aerodynamic modeling is essentially dictated by the unsteady aerodynamic
      theories used to determine the unsteady blade loading distribution. Due
      to the use of two-dimensional cascade aerodynamic theories, the blade
      aerodynamic model comprises a series of chordwise strips stacked
      spanwise to cover the entire blade surface as shown in Figure 1.18-6.

   5. Two-dimensional subsonic and supersonic cascade aerodynamic theories are
      utilized for generating the reactionary airloads on turbosystem blades
      due to oscillatory blade motions. Blade sweep effects are included in
      both cases. Transonic airloads are linearly interpolated.

   6. Externally specified aerodynamic loads can be applied to any degree of
      freedom of the structural model. These degrees of freedom are not
      restricted to those used in generating reactionary airloads mentioned
      above.

Referring to Equation 1 in Section 1.18.2, all but the [M2]{Ro} and {P}non-aero
terms are retained in the analysis. Real cyclic modes of a user-selected
circumferential harmonic index are used to pose and solve the problem.


               This figure is not included in the machine readable
               documentation because of complex graphics.

Figure 1.18-6. NASTRAN aerodynamic model of turboprop blade for 2-D cascade
theories

   Figure 1.18-7 presents a schematic flowchart of this capability.

   The theoretical development of this capability is discussed in detail in
Reference 3. Complete details of the implementation of the capability in an
earlier version of NASTRAN are given in Reference 4.

   The problem of determining the applied oscillatory airloads on the
turbosystem blades has been addressed in a stand-alone development outside,
and independent of, NASTRAN. However, this stand-alone program, called
AIRLOADS, can also function as a pre-processor to NASTRAN analyses. It is
available from COSMIC and is discussed in detail in Reference 5.

### 1.18.6.1  Modeling Features

   The structural model is prepared using the general capabilities of NASTRAN
for modeling rotationally cyclic structures as indicated in Section 1.18.4.

   The aerodynamic model for the generation of reactionary airloads comprises
a grid defined by the intersection of a series of chords and "computing
stations" as shown in Figure 1.18-7. The chords are selected normal to any
spanwise reference curve such as the blade leading edge. The choice of the
number and location of the chords and the computing stations is dictated by
the expected variation of the relative flow properties across the blade span,
and the complexity of the mode shapes exhibited by the turbosystem blade. Due
to its resemblance to the structural model of the blade, and the adequacy of a
relatively coarse grid to describe the spanwise flow variations, the
aerodynamic model is generally chosen as a subset of the structural model as
indicated in Figure 1.18-7.

   The aerodynamic grid is specified on STREAML1 bulk data cards.

                                    START
                                      |
                                      |
+-------------------+  +--------------+----------------+   +-------------------+
|  Osc. airloads    |  |      Finite element model     |   |  Total stiffness  |
|      from         +--+      of one cyclic sector,    +---+      matrix       |
|  pre-processor,   |  |        RPM, constraints,      |   |  (elastic plus    |
|    AIRLOADS       |  | circumferential harmonic index|   |   differential)   |
+-------------------+  +--------------+----------------+   +-------------------+
                                      |
                       +--------------+----------------+
                       |       Generation of mass,     |
                       |       damping, loads, and     |
                       |    stiffness (if necessary)   |
                       |            matrices           |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |         Application of        |
                       |    constraints to stiffness,  |
                       |       mass, damping, and      |
                       |         loads matrices        |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |         Application of        |
                       |          inter-segment        |
                       |          compatibility        |
                       |           constraints         |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |       Natural frequencies     |
                       |               and             |
                       |           mode shapes         |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |       Generalized motion      |
                       |           aerodynamic         |
                       |           matrix list         |
                       +--------------+----------------+
                                      |
                                      |
                                      X

Figure 1.18-7a. Overall flowchart of modal forced vibration analysis 
capability for aerodynamically excited turbosystems 

                                      X
                                      |
                       +--------------+----------------+
                       |           Generalized         |
                       |     equations of motion for   |
                       |     aerodynamically forced    |
                       |           vibrations          |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |           Solution of         |
                       |           independent         |
                       |            harmonic           |
                       |        modal coordinates      |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |           Independent         |
                       |            harmonic           |
                       |          displacements        |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |           Recovery of         |
                       |            dependent          |
                       |            harmonic           |
                       |          displacements        |
                       +--------------+----------------+
                                      |
                       +--------------+----------------+
                       |       Output requests for     |
                       |         displacements,        |
                       |            stresses,          |
                       |           plots, etc.         |
                       +--------------+----------------+
                                      |
                                      |
                                     EXIT

Figure 1.18-7b. Overall flowchart of modal forced vibration analysis 
capability for aerodynamically excited turbosystems


### 1.18.6.2  Executive Control Deck 

   The salient points are noted as follows:

   1. The NASTRAN card is required immediately preceding the ID card in the
      Executive Control Deck, and must contain, at least, the following
      operational parameter:

        NASTRAN SYSTEM (93) = 1

      This invokes the sweep effects in subsonic and supersonic reactionary
      aerodynamic routines, and is suggested for use even when sweep effects
      are negligible. In all cases where STREAML2 bulk data cards are obtained
      from the AIRLOADS program, this card is required.

   2. APP DISP and SOL 8 must be selected.

   3. The DMAP ALTER package, COSMFVA (COSMIC-supplied Modal Forced Vibration
      Analysis of aerodynamically excited turbosystems), must be included. The
      READFILE capability of NASTRAN (see Section 2.0.2) can be utilized for
      this purpose as follows:

        READFILE COSMFVA

### 1.18.6.3  Case Control Deck

   The subcase definitions and the selection of other data items for the Case
Control Deck are discussed below.

#### 1.18.6.3.1  Subcase Definitions

   The bulk data parameter KMAX (>= 0, <= NSEGS/2 for even NSEGS, <= (NSEGS
-1)/2 for odd NSEGS, where NSEGS is the number of cyclic sectors or segments)
determines the number, order, and meaning of subcases as follows:

   The number of subcases is equal to FKMAX, where

      FKMAX = 1, if  KMAX = O
            = 1 + 2 * KMAX, if 0 < KMAX <= (NSEGS -1)/2, NSEGS odd,
            = 1 + 2 * KMAX, if 0 < KMAX <= (NSEGS -2)/2, NSEGS even, and
            = NSEGS,  if KMAX = NSEGS/2, NSEGS even.
      SUBCASE 1 ("k" = 0)
      SUBCASE 2 ("k" = 1c)
      SUBCASE 3 ("k" = 1s)
      SUBCASE 4 ("k" = 2c)
      SUBCASE 5 ("k" = 2s)
         :
         :
      SUBCASE FKMAX ("k" = KMAXs)

   If NSEGS is even and KMAX = NSEGS/2, Subcase FKMAX will represent "k" =
KMAXc, as KMAXs does not exist.

   Circumferential harmonic components of directly applied loads are specified
under the appropriate subcases. With RLOADi bulk data cards, null loads need
not be specified by you.

#### 1.18.6.3.2  Other Data Selection Items

   1. The SPC and MPC request must appear above the subcase level and may not
      be changed.

   2. METHOD must be used to select an EIGR bulk data card.

   3. FREQUENCY must be selected and must be above the subcase level.

   4. FREQUENCY must be used to select one and only one FREQ, FREQ1, or FREQ2
      card from the Bulk Data Deck.

   5. Direct input matrices are not allowed.

   6. OFREQ must not be used.

   7. DLOAD must be used to define a frequency-dependent loading condition for
      each subcase. For frequency-dependent loads, subcases without loads need
      not refer to a DLOAD card.

   8. If random response calculations are desired, RANDOM must be used to
      select RANDPS and RANDTi cards from the Bulk Data Deck.

   The following printed output, sorted by frequency (SORT1) or by point
number or element number (SORT2), is available, either as real and imaginary
parts or magnitude and phase angle (0 - 360 degree lead), for the list of
frequencies specified:

   1. Displacements, velocities, and accelerations for a list of PHYSICAL
      points (grid points and extra scalar points introduced for dynamic
      analysis) or SOLUTION points (points used in formulation of the general
      K system).

   2. Nonzero components of the applied load vector and single-point forces of
      constraint for a list of PHYSICAL points.

   3. Stresses and forces in selected elements (ALL available only for SORT1).

   The following plotter output is available for frequency response
calculations:

   1. Undeformed plot of the structural model.

   2. X-Y plot of any component of displacement, velocity, or acceleration of
      a PHYSICAL point or SOLUTION point.

   3. X-Y plot of any component of the applied load vector or single-point
      force of constraint.

   4. X-Y plot of any stress or force component for an element.

   The following plotter output is available for random response calculations:

   1. X-Y plot of the power spectral density versus frequency for the response
      of selected components for points or elements.

   2. X-Y plot of the autocorrelation versus time lag for the response of
      selected components for points or elements.

The data used for preparing X-Y plots may be punched or printed in tabular
form (see Section 4.3). This is the only form of printed output that is
available for random response. Also, a printed summary is prepared for each
X-Y plot which includes the maximum and minimum values of the plotted
function.

### 1.18.6.4  Bulk Data Deck

   The bulk data parameters under user control are described in Section
1.18.6.4.1. The usage of certain bulk data cards is discussed in Section
1.18.6.4.2.

   The bulk data parameters CYCSEQ, CTYPE, and NLOAD, normally under user
control when using the cyclic symmetry feature, are not to be specified by you
in the present case as they either have fixed values assigned to them or are
internally computed. This is discussed below.

   The integer value of CYCSEQ parameter specifies the procedure for
sequencing the equations in the solution set. A value of +1 specifies that all
cosine terms are to be sequenced before all sine terms, and a value of -1
specifies alternating cosine and sine terms. The value has been set to -1.

   The alphanumeric (BCD) value of the CTYPE parameter specifies the type of
cyclic symmetry (rotational or dihedral symmetry). The value has been set to
ROT to indicate rotational cyclic symmetry.

   The integer value of NLOAD specifies the number of loading conditions. This
value is internally computed.

#### 1.18.6.4.1  Bulk Data Parameters

   The following bulk data parameters are used in the modal forced vibration
analysis of aerodynamically excited turbosystems:

   1. BOV - required. The real value of this parameter equals the ratio of the
      semichord to the velocity on the STREAML2 bulk data card for the
      reference (PARAM IREF) streamline.

   2. COUPMASS - CPBAR, CPROD, CPQUAD1, CPQUAD2, CPTRIA1, CPTRIA2, CPTUBE,
      CPQDPLT, CPTRPLT, CPTRBSC - not to be used. These parameters are not to
      be specified by you as only lumped mass matrices must be used.

   3. CYCIO - required. The integer value of this parameter specifies the form
      of the input and output data. A value of +1 is used to specify physical
      segment representation, and a value of -1 for cyclic transform
      representation. The value of CYCIO must be input as -1.

   4. G - optional. The real value of this parameter is used as a uniform
      structural damping coefficient in the formulation of dynamics problems.
      Not recommended for use in hydroelastic problems (use GE on MAT1).

   5. GKAD - optional. The BCD value of this parameter is used to tell the
      GKAD module the desired form of the matrices KDD, BDD, and MDD. The BCD
      value can be FREQRESP or TRANRESP. The default value is TRANRESP.

      Note: Remember to define the parameters G, W3, and W4. See Section 9.3.3
      (Direct Dynamic Matrix Assembly) of the Theoretical Manual for further
      details.

   6. GRDPNT - optional. A positive integer value of this parameter causes the
      Grid Point Weight Generator to be executed and the resulting weight and
      balance information to be printed. All fluid related masses are ignored.

   7. IREF - optional. This defines the reference streamline number. IREF must
      be equal to an SLN on a STREAML2 bulk data card. The default value of -1
      represents the blade tip streamline. If IREF does not correspond to a
      valid SLN, the default is taken.

   8. KGGIN - optional. A positive integer value of this parameter indicates
      that your stiffness matrix is to be read from an external file (GINO
      file INPT) via the INPUTT1 module in the rigid format. The default value
      is -1.

   9. KINDEX - optional. The integer value of this parameter specifies the
      circumferential harmonic index. See parameter BIN for usage. There is no
      default.

   10.  KMIN - optional. The integer value of this parameter specifies the
        minimum value of the conic index to be used in the solution loop.

      If KMIN (>= 0, default = 0) equals KMAX, the parameter KINDEX is
      internally set to KMIN (or KMAX). Your value of KINDEX (if any) is then
      ignored.

      If KMIN differs from MAX, then KINDEX (KMIN <= KINDEX <= KMAX) must be
      specified.

   11.  KMAX - required. The integer value of this parameter specifies the
        maximum value of the conic index, and is used in subcase definition.
        There is no default for this parameter. A value must be input. The
        maximum value that can be specified is NSEGS/2.

   12.  LFREQ and HFREQ - required, unless parameter LMODES is used. The real
        values of these parameters give the frequency range (LFREQ is the
        lower limit, and HFREQ is the upper limit) of the modes to be used in
        the modal formulation. To use this option, parameter LMODES must be
        set to 0.

   13.  LGKAD - optional. The integer value of this parameter is used in
        conjunction with parameter GKAD. If GKAD = FREQRESP, set LGKAD = 1;
        if GKAD = TRANRESP, set LGKAD = -1. The default value is -1.

   14.  LMODES - used, unless set to 0. The integer value of this parameter
        is the number of lowest modes to be used in the modal formulation.
        The default is to use all modes.

   15.  MAXMACH - optional. The real value of this parameter is the maximum
        Mach number at and below which the subsonic unsteady cascade theory
        is valid. The default value is 0.80.

   16.  MINMACH - optional. The real value of this parameter is the minimum
        Mach number at and above which the supersonic unsteady cascade theory
        is valid. The default value is 1.01.

   17.  NOKPRT - optional. An integer value of +1 for this parameter causes
        the current harmonic index, KINDEX, to be printed at the top of the
        harmonic loop. The default is +1.

   18.  NSEGS - required. The integer value of this parameter is the number
        of identical segments in the structural model. There is no default. A
        value must be input.

   19.  Q - required. The real value of this parameter specifies the inflow
        dynamic pressure used on the density and velocity on the STREAML2
        bulk data card for the reference (PARAM IREF) streamline.

   20.  RPS - optional. The real value of this parameter defines the
        rotational speed of the structure in revolutions per unit time. The
        default value is 0.0.

   21.  W3 - optional. The real value of this parameter is used as a pivotal
        frequency for uniform structural damping if parameter GKAD =
        TRANRESP. In this case, W3 is required if uniform structural damping
        is desired. The default value is 0.0.

   22.  W4 - optional. The real value of this parameter is used as a pivotal
        frequency for element structural damping if parameter GKAD =
        TRANRESP. In this case, W4 is required if structural damping is
        desired for any of the structural elements. The default value is 0.0.

   23.  WTMASS - optional. The terms of the structural mass matrix are
        multiplied by the real value of this parameter when they are
        generated in the EMA. Not recommended for use in hydroelastic
        problems.

#### 1.18.6.4.2  Usage of Certain Bulk Data Cards

   The following remarks relate to the usage of some of the bulk data cards:

   1. SUPORT cards are not allowed.

   2. EPOINT cards are not allowed.

   3. SPOINT cards are not allowed.

   4. CYJOIN cards are required. These cards are used to list the
      corresponding grid points on sides 1 and 2 of the modeled cyclic sector.

      In the case of rigid hub/disk conditions, the grid points listed on
      these cards must be totally fixed. The bulk data parameters KMAX, KMIN,
      and KINDEX must be identically zero.

      In the case of flexible hub/disk conditions, the data on these cards
      must reflect such boundary connections. Bulk data parameters KMAX, KMIN,
      and KINDEX are truly active and meaningful. The displacement coordinate
      systems for any pair of corresponding grid points must be
      axisymmetrically compatible, that is, the coordinate system for a side 1
      grid point must completely coincide with that for the corresponding grid
      point on side 2, when the side 1 coordinate system is rotated as a rigid
      body about the axis of rotation, and moved to side 2.

   5. The variables on the AERO card represent the conditions for the entire
      blade/turbosystem as a whole. The values of these variables on the
      reference streamline are also assumed to represent those for the entire
      blade/turbosystem.

      The reference streamline is picked by you (PARAM IREF), and defaults to
      the blade tip streamline otherwise.

   6. The STREAML2 card defines the unsteady aerodynamic data for a given
      streamline.

   7. The reduced frequency on the MKAEROi cards is based on the semichord and
      velocity on the STREAML2 bulk data card for the reference streamline.
      Referring to the sketch below, a positive interblade phase angle implies
      that blade 1 of the two-dimensional cascade leads the reference blade 0.

                     |                    |
                     |                   .|  Blade 1
                     |         1     .    |
                     |           .        |
                     |      .             |
                     | .                  |
                     |                    |
                     |                   .|  Blade 0 (ref.)
                     |         0     .    |
                     |           .        |
                     |      .             |
                     | .                  |
                     |                    |
                     |                   .|
                     |               .    |
                     |           .        |
                     |      .             |
                     | .       |          |
                     |         |          |
                               |
                               |

REFERENCES

1. Elchuri, V., and Smith, G. C. C., "Finite Element Forced Vibration Analysis
   of Rotating Cyclic Structures," NASA CR-165430, December 1981.

2. Elchuri, V., Gallo, A. M., and Skalski, S. C., "Forced Vibration Analysis
   of Rotating Cyclic Structures in NASTRAN," NASA CR-165429, December 1981.

3. Elchuri, V., "Modal Forced Vibration Analysis of Aerodynamically Excited
   Turbosystems," NASA CR 174966, July 1985.

4. Elchuri, V., and Pamidi, P. R., "NASTRAN Supplemental Documentation for
   Modal Forced Vibration Analysis of Aerodynamically Excited Turbosystems,"
   NASA CR 174967, July 1985.

5. Elchuri, V., and Pamidi, P. R., "AIRLOADS: A Program for Oscillatory
   Airloads on Blades of Turbosystems in Spatially Non-Uniform Inflow," NASA
   CR 174968, July 1985.

# 1.19  STATIC AEROTHERMOELASTIC DESIGN/ANALYSIS OF AXIAL-FLOW COMPRESSORS
## 1.19.1  Introduction

   The non-linear interactive influences between the flexible structure of the
rotor/stator of a single-stage, or each stage of a multi-stage, axial-flow
compressor and the steady state aerothermodynamics of the internal flow can be
studied in NASTRAN. A rigid format (DISP APP R.F. 16) has been developed for
the purpose and can be employed for the solution of design/analysis problems
of axial-flow compressors. The capability is based on the work described in
References 1, 2, and 3. It utilizes the three-dimensional aerothermodynamic
theory described in Reference 4, and is therefore valid for axial-flow
compressors. It is to be noted here that the capability assumes tuned cyclic
structures, that is, structures composed of cyclic sectors (or segments) that
have identical mass, stiffness, damping, and constraint properties.

   A brief description of the capability is given in Section 1.19.2. The
structural part of the problem is modeled as usual in NASTRAN. Aerodynamic
modeling is discussed in Section 1.19.3. The preparation of the aerodynamic
input data is described in Section 1.19.4 and the interpretation of the
aerodynamic output data is discussed in Section 1.19.5.

1.19.2  Description of the Capability

1.19.2.1  Problem Definition

   At any operating point under steady-state conditions, the rotors and
stators of axial-flow compressors are subjected to aerodynamic pressure and
temperature loads. The rotors, in addition, also experience centrifugal loads.
These loads result in deformation of the elastic structure, which, in turn,
influences the aerodynamic loads. These interactive loads and responses arise
fundamentally from the elasticity of the structure, and determine the
performance of the "flexible" turbomachine. For a given flow rate and
rotational speed, the elastic deformation implies a change in the operating
point pressure ratio.

   The process of arriving at an "as manufactured" blade shape to produce a
desired (design point) pressure ratio (given the flow rate and rotational
speed) is herein termed the "design" problem of axial-flow compressors. The
subsequent process of analyzing the performance of "as manufactured" geometry
at off-design operating conditions, including the effects of flexibility, is
termed the "analysis" problem of axial-flow compressors.

### 1.19.2.2  Problem Formulation

   The static aerothermoelastic behavior of each cyclic sector of the tuned
rotor/stator of an axial-flow compressor is described by the equation:

         e     d            aero       non-aero
      [[K ]+ [K ]] {u} = {P}      + {P}                             (1)

   In the above equation, the degrees of freedom, {u}, are the steady-state
displacements expressed in body-fixed global coordinate systems. [Ke] and [Kd]
are the elastic and differential stiffness matrices, respectively. {P}aero
represents the steady-state aerodynamic pressure and thermal loads. These are
computed using the three-dimensional aerodynamic theory of Reference 1.
Finally, {P}non-aero represents all non-aerodynamic loads.

   As all cyclic sectors of the tuned structure are assumed to respond
identically, only one rotationally cyclic sector is modeled and analyzed
(Figure 1.19-1), with the intersector boundary conditions imposed via
multipoint constraints (MPCs).

               This figure is not included in the machine readable
               documentation because of complex graphics. 

Figure 1.19-1. Bladed-disc aerodynamic grid and the basic coordinate system

            +------------------------------------------------------+
            | Compressor Bladed-Disc Sector Geometry, Constraints, |
            |  Stiffness Matrix, Non-Aerodynamic Loads + Operating |
            |    Point (Flow Rate, Speed, Loss Parameters, Etc.)   |
            +---------------------------+--------------------------+
                                        |
                                        |
            +---------------------------+--------------------------+
            |      Aerodynamic Pressure and Temperature Loads,     |
            |               A                                      |
            |             {P } on Undeformed Blade, ALG            |
            |               g                                      |
            +---------------------------+--------------------------+
                                        |
                                        |
            +---------------------------+--------------------------+
            |  Total Loads {P } (Aerodynamic and Non-Aerodynamic)  |
            |                g                                     |
            +---------------------------+--------------------------+
                                        |
                                        |
            +---------------------------+--------------------------+
            |   Independent Displacements {u } (Linear Solution)   |
            |                               l                      |
            +---------------------------+--------------------------+
                                        |
                                        |
            +---------------------------+--------------------------+
            |        Dependent Displacements, Stresses, Etc.       |
            |                   (Linear Solution)                  |
            +---------------------------+--------------------------+
                                        |
                                        |
                                        A


 Figure 1.19-2a. Simplified problem flow for static aerothermoelastic
design/analysis rigid format for axial-flow compressors

                                        A
                                        |
                                        |
              +-------------------------+------------------------+
              |                                        d         |
              |        Differential Stiffness Matrix [K  ]       |
              |                                        gg        |
              +-------------------------+------------------------+
+---------------------------------------+
|                                       |
|             +-------------------------+------------------------+
|             |                                    b             |
|             |           Total Stiffness Matrix [K  ]           |
|             |                                    ll            |
|             +-------------------------+------------------------+
|                                       +--------------------------------------+
|                                       |                                      |
|             +-------------------------+------------------------+             |
|             |                                               A  |             |
|             |  Aerodynamic Pressure and Temperature Loads {P } |             |
|             |                                               g  |             |
|             +-------------------------+------------------------+             |
|                                       |                                      |
|             +-------------------------+-------------------------+            |
|             |Total Loads {P  } (Aerodynamic and Non-Aerodynamic)|            |
| Outer       |              g2                                   |      Inner |
| Loop        +-------------------------+-------------------------+      Loop  |
|                                       |                                      |
|             +-------------------------+-------------------------+            |
|             |                                      b            |            |
|             |          Independent Displacements {u }           |            |
|             |                                      l            |            |
|             |               (Non-Linear Solution)               |            |
|             +-------------------------+-------------------------+            |
|                                       |                                      |
|             +-------------------------+-------------------------+            |
|             |      Dependent Displacements, Stresses, Etc.      |            |
|             |               (Non-Linear Solution)               |            |
|             +-------------------------+-------------------------+            |
|                                       |                                      |
|                                       |                                      |
|                                                                              |
|  Adjustment to             No    Convergence    No                      d    |
+--  d             -------------  Checks, DSCHK  ----------No change in [K  ] -+
   [K  ] necessary                                                        gg
     gg                                 | Yes
              +-------------------------+-------------------------+
              |                      b                            |
              | Final Displacement {u }, Deformed Blade Geometry, |  Point b on
              |                      g                            |  the map
              |   Stress, Etc. + Operating Point Pressure Ratio   |
              |             and other Flow Parameters             |
              +-------------------------+-------------------------+
                                        |
                                        |
                                      EXIT


 Figure 1.19-2b. Simplified problem flow for static aerothermoelastic
design/analysis rigid format for axial-flow compressors

### 1.19.2.3  NASTRAN Implementation

   A rigid format (DISP APP R.F. 16) has been developed specifically for the
solution of "design/analysis" problems of axial-flow compressors. The rigid
format features functional modules and parameters specifically designed for
this capability. The rigid format was developed by modifying DISP APP R.F. 4
(Static Analysis with Differential Stiffness) to include the interactive
effects of aerodynamic loads along with the effects due to centrifugal loads.
The aerodynamic computer code of Reference 4, with minor changes, has been
adapted in a functional module called ALG (Aerodynamic Load Generator).
Complete details of the implementation in earlier versions of NASTRAN are
given in References 1 and 3. A simplified flowchart of the rigid format is
shown in Figure 1.19-2.

   The value of the parameter SIGN (= +/-1.0) selects the analysis mode (SIGN
= 1.0) or the design mode (SIGN = -1.0) of the rigid format. Deformation of
the structure as a result of the applied centrifugal and aerodynamic loads is
used to revise the blade geometry each time through the differential stiffness
loop of the rigid format. Because of the non-linear relationship between the
blade geometry and the resulting operating point pressure ratio, provision is
made to control the fraction of the displacements used to redefine the blade
geometry. This is especially helpful in the solution of the "design" problem.
The fractions of the displacements used to redefine the blade geometry are
specified via the FXCOOR, FYCOOR, and FZCOOR parameters. The application of
the aerodynamic pressure and thermal loads is controlled respectively by the
parameters APRESS and ATEMP. These parameters also enable the inclusion of the
centrifugal loads alone.

   The functional module ALG is used in the rigid format before, within, and
after the differential stiffness loops (see Section 3.17) to generate the
aerodynamic loads. Printed output from this module during these three stages
can be controlled through the use of the parameters IPRTCI, IPRTCL, and
IPRTCF, respectively. This enables observation of the variation in the
aerodynamic loads as a function of the blade geometry.

   The capability also determines:

   1. the steady-state response of the structure (displacements, stresses,
      reactions, etc.), and

   2. a differential stiffness matrix for use in subsequent modal, flutter,
      and dynamic response analyses.

   GRID, CTRIA2, and PTRIA2 bulk data cards for the final blade shape can be
punched out using the parameter PGEOM. At the end of a "design" run, these
cards define the "as manufactured" blade shape, which can subsequently be
"analyzed" at selected operating points over the compressor map. In an
"analysis" run at any operating point, the total stiffness (elastic and
geometric) of the bladed-disc structure can be saved via the parameter KTOUT
for use in subsequent modal, modal flutter, and subcritical roots analyses.
STREAML1 and STREAML2 bulk data cards specifying the aerodynamic grid and flow
data can be punched out using the parameter STREAML.

## 1.19.3  Aerodynamic Modeling

   The aerodynamic model is based on a grid generated by the intersection of a
series of streamlines and "computing stations" (similar to potential lines) as
shown in Figure 1.19-1.

   The aerodynamic loads are assumed significant only on the bladed portion of
a bladed disc and no other part of the structure need be modeled
aerodynamically. The data required to generate the aerodynamic model for the
steady state aeroelastic analyses are specified on DTI bulk data cards, and
are described in Section 1.19.4.

   The streamlines are defined by the intersection of the blade mean surface
and a set of coaxial cylindrical (or conical) surfaces. The axis of the
cylinders (cones) coincides with the axis of rotation of the turbomachine. The
"computing stations" lie on the blade mean surface and divide it from the
leading edge to the trailing edge. The choice of the number and location of
the streamlines and the "computing stations" is dictated by the expected
variation of the relative flow properties across the blade span, and the
complexity of the deformation shape exhibited by this part of the structure.
However, a minimum of three streamlines (including the blade root and the tip)
and three "computing stations" (including the blade leading edge and the
trailing edge) must be specified.

   The distribution of the aerodynamic parameters over the blade is, in
general, different from that of the structural parameters such as stress,
strain, etc. Accordingly, the aerodynamic model and the structural model of
the blade, in general, may differ. The difference permitted in the two models
is similar to that shown in Figure 1.19-1, wherein the aerodynamic grid is
shown to be a part of the structural grid.

   The X-axis of the basic coordinate system (Figure 1.19-1) is chosen to
coincide with the axis of rotation and is oriented in the direction of the
flow. The location of the origin is arbitrary. The XZ-plane lies parallel to
the "mean" meridional plane passing through the blade, with the Z-axis
directed towards the blade.

## 1.19.4  Aerodynamic Input Data

   The aerodynamic input data consists of a set of initial directives and the
remaining data which comprises two sections: the analytic meanline blade
section and aerodynamic section. The data in these sections consists of a set
of data items for each entry in each section. The data required for the
interfacing of the output from the analytic meanline blade section to the
aerodynamic section is included in the data items for the analytic meanline
blade section. Because partial input to the aerodynamic section is generated
by execution of the analytic meanline blade section, the input for the
aerodynamic section to be supplied directly by you varies.

   The analytic meanline blade section must be directed by you to produce data
for the aerodynamic section for a particular computing station. This data is
internally generated on a scratch file called LOG5. The discussion below
indicates the data that is taken from this LOG5 file and therefore is not
supplied directly by you.

   The following data items must be input using the Direct Table Input (DTI)
bulk data cards. A description of the DTI card is given in Section 2.4. The
table data block name must be ALGDB. The trailer value for T1 (see the
description of the DTI bulk data card) must be the number of logical records
in the DTI table, not counting the header record. This is the same as the
maximum value of IREC used in the table. The trailer values for T2 through T6
are all zero. Each of the following input cards corresponds to one logical
record of the DTI table. Trailing zeroes need not be input. Data types, that
is, alphanumeric (BCD), real, and integer, must correspond to those specified
for each data item. Data item names that begin with the letters I, J, K, L, M,
and N are to be input as integers, while all others are input as real numbers.
Titles are input as alphanumeric (BCD) with the restriction that only
alphabetic letters occupy the first character in each field of the DTI card.
Titles may use up to nine DTI fields.

### 1.19.4.1  Aerodynamic DTI Data Setup

   In the following discussion, one line (which may be continued) corresponds
to one logical record of a DTI card. The data items used here are defined in
Section 1.19.4.2. For additional details, you may refer to Reference 4.

#### 1.19.4.1.1  Initial Directives

   The following data items form the initial directives.

      TITLE1
      NANAL NAERO

#### 1.19.4.1.2  Analytic Meanline Blade Section

   The following set of data items is input to the analytic meanline blade
section, and will occur NANAL times. The last record in this set is indicated
with an asterisk.

          TITLE2

          NLINES NSTNS NZ NSPEC NPOINT NBLADE ISTAK IPUNCH ISECN IFCORD IFPLOT
(cont.)   IPRINT ISPLIT INAST IRLE IRTE NSIGN

          ZINNER ZOUTER SCALE STACKX PLTSZE
                                                                 +
          KPTS IFANGS                                            | Occurs
                                                                 |
          XSTA RSTA      - Occurs KPTS times                     | NSTNS
                                                                 |
          R BLAFOR       - Occurs NLINES times                   | times
                                                                 +
                                                                 +
          ZR B1 B2 PP QQ RLE                                     | Occurs
                                                                 |
          TC TE Z CORD DELX DELY                                 | NSPEC
                                                                 |
          S BS - Only if ISECN = 1  or 3                         | times
                                                                 +
                                                                 +
          NRAD NDPTS NDATR NSWITC NLE NTE                        |
                                                                 |
          XKSHPE SPEED                                           |
                                                                 |
          NOUT1 NOUT2 NOUT3 - Refers to leading edge station     |
                                                                 |
          NR NTERP NMACH NLOSS NL1       + Occurs                | This group
                                         | for each              | is used to
(cont.)   NL2 NEVAL NCURVE NLITER NDEL   | station               | generate
                                         | within                | LOG5 data
(cont.)   NOUT1 NOUT2 NOUT3 NBLADE       | blade or              | for the
                                         | at trailing           | aerodynamic
          R XLOSS  ]-Occurs NR times     + edge                  | section
                                                                 |
          RTE                            + Occurs                |
                                         | NRAD                  |
          DM DVFRAC ]-Occurs NDPTS times + times                 |
                                                                 |
       *  RDTE DELTAD AC ]-Occurs NDATR times                    |
                                                                 +

#### 1.19.4.1.3  Aerodynamic Section

   The following set of data items is input to the aerodynamic section and the
last record in this set is indicated with a double asterisk.

          TITLE3

          CP GASR G EJ

          NSTNS NSTRMS NMAX NFORCE NBL NCASE NSPLIT NSET1 NSET2 NREAD NPUNCH

(cont.)   NPLOT NPAGE NTRANS NMIX NMANY NSTPLT NEQN NLE NTE NSIGN

          NWHICH - Occurs NMANY times on the same card

          G EJ SCLFAC TOLNCE VISK SHAPE

          XSCALE PSCALE RLOW PLOW XMMAX RCONST

          CONTR CONMX
                                                     +
          FLOW SPDFAC                                |
                                                     |
          NSPEC                                      | Occurs
                                                     | NSTNS
          XSTN RSTN - Occurs NSPEC times             | times
                                                     +
                                                     +
          NDATA NTERP NDIMEN NMACH                   | Inlet
                                                     | condition
          DATAC DATA1 DATA2 DATA3  - Occurs          | specification
                                     NDATA times     |
                                                     +
                                                               +
(LOG5)    NDATA NTERP NDIMEN NMACH NWORK                       |
                                                               |
(cont.)   NLOSS NL1 NL2 NEVAL NCURVE NLITER                    |
                                                               |
(cont.)   NDEL NOUT1 NOUT2 NOUT3 NBLADE                        |
                                                               | For stations
(LOG5)    SPEED - If NDATA > 0                                 | 2 through
                                                +              | NSTNS
(LOG5)    DATAC DATA1 DATA2 DATA3 DATA4         |              |
                                                | Occurs       |
(cont.)   DATA5                                 | NDATA        |
                                                | times        |
(LOG5)    DATA6 DATA7 DATA8 DATA9               |              |
                                                +              |
          DELC DELTA - Occurs NDEL times                       |
                                                               +
          WBLOCK BBLOCK BDIST - Occurs NSTNS times
                                                     +
          NDIFF                                      | Occurs
                                                     | NSET1
          DIFF FDHUB FDMID FDTIP - Occurs NDIFF      | times
                                   times             |
                                                     +
                                                     +
          NM NRAD                                    |
                                           +         | Occurs
          TERAD                            | Occurs  | NSET2
                                           | NRAD    | times
          DM WFRAC - Occurs NM times       | times   |
                                           +         +
          DELF(1) DELF(2)....DELF(NSTRMS) - if NSPLIT = 1 (6 per card)
                                            or NREAD = 1

     **   R X XL II JJ - Occurs NSTRMS times for NSTNS stations if
                         NREAD = 1

### 1.19.4.2   Aerodynamic DTI Data Item Definitions

   The aerodynamic input data may be specified in any self-consistent unit
system and, additionally, a "linear dimension scaling factor" (SCLFAC) is
incorporated into the input so that some commonly used but inconsistent unit
systems may be used. This is principally intended to allow the use of inches
for physical dimensions and yet retain feet for velocities. The basic
dimensions used in the data are length (L), time (T), and force (F). Angles
are expressed in degrees (A) and temperatures on an absolute temperature scale
(D). Heat capacities (H) are also required. Some possible unit systems are
given below, together with the corresponding value of SCLFAC.

      L        T         F           D              H       SCLFAC

      Feet     Seconds   Pounds      Deg. Rankine   BTU      1.0

      Inches   Seconds   Pounds      Deg. Rankine   BTU     12.0

      Meters   Seconds   Kilograms   Deg. Kelvin    CHU      1.0

   The data items specified in Section 1.19.4.1 are defined below. Note that
some of the data names are used in more than one section; care should be taken
to consult the correct section below for definitions.

#### 1.19.4.2.1  Initial Directives

   TITLE1  This is a title card for the run.

   NANALSet NANAL = 1

   NAEROSet NAERO = 1

#### 1.19.4.2.2  Analytic Meanline Blade Section

   For a more detailed discussion of the input to this section, see Reference
1. For this section, the dimensioned input is either in degrees (A) or in
length (L).

TITLE2  A title card for the analytic meanline blade section of the program.

NLINES  The number of streamsurfaces which are defined, and on which blade
        sections will be designed. Must satisfy 2 <= NLINES <= 21.

NSTNS   The number of computing stations at which the streamsurface radii are
        specified. Must satisfy 3 <= NSTNS <= 10.

NZ      The number of constant-z planes on which manufacturing (Cartesian)
        coordinates for the blade are required. Must satisfy 3 <= NZ <= 15.

NSPEC   The number of radially disposed points at which the parameters of the
        blade sections are specified. Must satisfy 1 <= NSPEC <= 21.

NPOINT  The number of points that will be generated to specify the pressure
        and suction surfaces of each blade section. Must satisfy 2 <= NPOINT
        <= 80. Generally, no less than 30 should be used.

NBLADE  The number of blades in the blade row.

ISTAK   If ISTAK = 0, the blade will be stacked at the leading edge.

        If ISTAK = 1, the blade will be stacked at the trailing edge.

        If ISTAK = 2, the blade will be stacked at, or offset from, the
        section centroid.

IPUNCH  Set IPUNCH  =  0

ISECN   If ISECN = 0, the blade will be constructed using the polynomial
        camber line and the standard (that is, double-cubic) thickness
        distribution.

        If ISECN = 1, the exponential camber line and the standard thickness
        distribution will be used.

        If ISECN = 2, the circular arc camber line and the
        double-circular-arc thickness distribution will be used.

        If ISECN = 3, the multiple-circular-arc meanline and the standard
        thickness distribution will be used.

IFCORD  If IFCORD = 0, the meridional projection of the streamsurface blade
        section chords are specified.

        If IFCORD = 1, the streamsurface blade section chords are specified.

IFPLOT  Set IFPLOT = 0

IPRINT  The input data is always listed by the program. Details of the
        streamsurface and manufacturing sections are printed as prescribed by
        IPRINT.

        If IPRINT = 0, details of the streamsurface and manufacturing
        sections are printed.

        If IPRINT = 1, details of streamsurface sections are printed.

        If IPRINT = 2, details of manufacturing sections are printed.

        If IPRINT = 3, details of neither streamsurface nor manufacturing
        sections are printed. (The interface data for use with the
        aerodynamic section of the program is still displayed.)

ISPLIT  Set ISPLIT = 0

INAST   Set INAST = 0

IRLE    The computing station number at the blade leading edge.

IRTE    The computing station number at the blade trailing edge.

NSIGN   Indicator used to sign blade pressure forces according to program
        sign conventions. For compressor rotors, if the machine rotates
        clockwise when viewed from the front, set NSIGN to 1; otherwise, set
        NSIGN to -1. For compressor stators, the two values given for NSIGN
        are reversed.

ZINNER, Extreme Z values between which the NZ manufacturing sections are
ZOUTER  equally spaced in the Z direction between ZINNER and ZOUTER.

SCALE   Set SCALE = 0.0

STACKX  This is the axial coordinate of the stacking axis for the blade,
        relative to the same origin as used for the station locations, XSTA.

PLTSZE  Set PLTSZE = 0.0

KPTS    The number of points provided to specify the shape of a computing
        station.

        If KPTS = 1, the computing station is upright and linear.

        If KPTS = 2, the computing station is linear and either upright or
        inclined.

        If KPTS > 2, a spline curve is fit through the points provided to
        specify the shape of the station.

IFANGS  If IFANGS = 0, the calculations of the quantities required for
        aerodynamic analysis will be omitted at a particular computing
        station.

        If IFANGS = 1, these calculations will be performed at that station.

XSTA    An array of KPTS axial coordinates (relative to an arbitrary origin)
        which, together with RSTA, specify the shape of a particular
        computing station.

RSTA    An array of KPTS radii which, together with XSTA, specify the shape
        of a particular computing station.

R       The stream surface radii at NLINES locations at each of the NSTNS
        stations.

BLAFOR  Set BLAFOR = 0.0

ZR      The variation of properties of the streamsurface blade section is
        specified as a function of streamsurface number. The various
        quantities are then interpolated (or extrapolated) at each
        streamsurface. The streamsurfaces are numbered consecutively from the
        innermost outward, starting with 1.0. ZR must increase monotonically,
        there being NSPEC values in all.

B1      The blade inlet angle.

B2      The blade outlet angle.

PP      If ISECN = 0, PP is the ratio of the second derivative of the camber
        line at the leading edge to its maximum value. Must satisfy -2.0 < PP
        < 1.0.

        If ISECN = 1, PP is the ratio of the second derivative of the camber
        line at the leading edge to its maximum value forward of the
        inflection point. Must satisfy 0.0 < PP <= 1.0. If ISECN = 2 or 3, PP
        is superfluous.

QQ      If ISECN = 0, QQ is the ratio of the second derivative of the camber
        line at the trailing edge to its maximum value. Must satisfy 0.0 <=
        QQ <= 1.0.

        If ISECN = 1, QQ is the ratio of the second derivative of the camber
        line at the trailing edge to its maximum value rearward of the
        inflection point. Must satisfy 0.0 < QQ <= 1.0.

        If ISECN = 2 or 3, QQ is superfluous.

RLE     The ratio of blade leading edge radius to chord.

TC      The ratio of blade maximum thickness to chord.

TE      The ratio of blade trailing edge half-thickness to chord.

        If ISECN = 2, TE is superfluous.

Z       The location of the blade maximum thickness, as a fraction of camber
        line length from the leading edge.

        If ISECN = 2, Z is superfluous.

CORD    If IFCORD = 0, CORD is the meridional projection of the blade chord.

        If IFCORD = 1, CORD is the blade chord.

DELX,   The stacking axis passes through the streamsurface blade sections,
DELY    offset from the centroids, leading or trailing edge by DELX and DELY
        in the X and Y directions, respectively.

S, BS   If ISECN = 1 or 3, S and BS are used to specify the locations of the
        inflection point (as a fraction of the meridionally-projected chord
        length) and the change in camber angle from the leading edge to the
        inflection point. If the absolute value of the angle at the
        inflection point is larger than the absolute value of B1, BS should
        have the same sign as B1; otherwise, B1 and BS should be of opposite
        signs.

NRAD    The number of radii at which a distribution of the fraction of
        trailing edge deviation is input. Must satisfy 1 <= NRAD <= 5.

NDPTS   The number of points used to define each deviation curve. Must
        satisfy 1 <= NDPTS <= 11.

NDATR   The number of radii at which an additional deviation angle increment
        and the point of maximum camber are specified. Must satisfy 1 <=
        NDATR <= 21.

NSWITC  If NSWITC = 1, the deviation correlation parameter "m" for the NACA
        (A10) meanline is used.

        If NSWITC = 2, the deviation correlation parameter "m" for
        double-circular-arc blades is used.

NLE     Station number at leading edge.

NTE     Station number at trailing edge.

XKSHPE  The blade shape correction factor in the deviation rule.

SPEED   Speed of compressor rotation.

NR      The number of radii where a "loss" is input.

NTERP   See Section 1.19.4.2.3 for definitions.
NMACH
NLOSS
NL1
NL2
NEVAL
NCURVE
NLITER
NDEL
NOUT1
NOUT2
NOUT3
NBLADE

R       Radius at which loss is specified.

XLOSS   Loss description. The form is prescribed by NLSSS; see aerodynamic
        section.

RTE     Radius at blade trailing edge where the following deviation
        fraction/chord curve applies.

        If NRAD = 1, it has no significance. Must increase monotonically.

DM      The location on the meridional chord where the deviation fraction is
        given. Expressed as a fraction of the meridional chord from the
        leading edge. Must increase monotonically.

DVFRAC  Fraction of trailing-edge deviation that occurs at location DM.

RDTE    Radius at trailing edge where additional deviation and point of
        maximum camber are specified.

DELTAD  Additional deviation angle added to that determined by deviation
        rule. Input positive for conventionally positive deviation for both
        rotors and stators.

AC      Fraction of blade chord from leading edge where maximum camber
        occurs.

#### 1.19.4.2.3  Aerodynamic Section

TITLE3  A title card for the aerodynamic section of the program.

CP      Specific heat at constant pressure. An input value of zero will be
        reset to 0.24. Units: H/F/D.

GASR    Gas constant. An input value of zero will be reset to 53.52. Units:
        L/SCLFAC/D.

G       Acceleration due to gravity. An input value of zero will be reset to
        32.174. Units: L/SCLFAC/T/T.

EJ      Joules equivalent. An input value of zero will be reset to 778.16.
        Units: LF/SCLFAC/H.

NSTNS   Number of computing stations. Must satisfy 3 <= NSTNS <= 30.

NSTRMS  Number of streamlines. Must satisfy 3 <= NSTRMS <= 21. An input value
        of zero will be reset to 11.

NMAX    Maximum number of passes through the iterative streamline
        determination procedure. An input value of zero will be reset to 40.

NFORCE  The first NFORCE passes are performed with arbitrary numbers inserted
        should any calculation produce impossible values. Thereafter,
        execution will cease, the calculation having "failed". An input value
        of zero will be reset to 10.

NBL     If NBL = 0, the annulus wall boundary layer blockage allowance will
        be held at the values prescribed by WBLOCK.

        If NBL = 1, blockage due to annulus wall boundary layers will be
        recalculated except at station 1. VISK and SHAPE are used in the
        calculation.

NCASE   Set NCASE = 1

NSPLIT  If NSPLIT = 0, the flow distribution between the streamlines will be
        determined by the program so that roughly uniform increments of
        computing station will occur between the streamlines at station 1.

        If NSPLIT = 1, the flow distribution between the streamlines is read
        in (see DELF).

NSET1   The blade loss coefficient re-evaluation option (specified by NEVAL)
        requires loss parameter/diffusion factor data. NSET1 sets of data are
        input, the set numbers being allocated according to the order in
        which they are input. Up to 4 sets may be input (see NDIFF).

NSET2   When NLOSS = 4, the loss coefficients at the station are determined
        as a fraction of the value at the trailing edge. Then, NSET2 sets of
        curves are input to define this fraction at a function of radius and
        meridional chord. Up to 2 sets may be input (see NM).

NREAD   If NREAD = 0, the initial streamline pattern estimate is generated by
        the program.

        If NREAD = 1, the initial streamline pattern estimate and also the
        DELF values are read in. (See DELF, R, X, and XL.)

NPUNCH  Set NPUNCH = 0

NPLOT   Set NPLOT = 0

NPAGE   The maximum number of lines printed per page. An input value of zero
        will be reset to 60.

NTRANS  If NTRANS = 0, no action is taken.

        If NTRANS = 1, relative total pressure loss coefficients will be
        modified to account for radial transfer of wakes. See Reference 1.

NMIX    If NMIX = 0, no action is taken.

        If NMIX = 1, entropy, angular momentum, and total enthalpy
        distributions will be modified to account for turbulent mixing. See
        Reference 1.

NMANY   The number of computing stations for which blade descriptive data is
        being generated by the analytic meanline blade section.

NSTPLT  If NSTPLT = 0, no action is taken.

        If NSTPLT = 1, a line-printer plot of the changes made to the
        midstreamline "l" coordinate is made for each computing station. If
        more than 59 passes through the iterative procedure have been made,
        then the plots will show the changes for the last 59 passes. The
        graph should decay approximately exponentially towards zero,
        indicating that the streamline locations are stabilizing. Decaying
        oscillations are equally acceptable, but growing oscillations show
        the need for heavier damping in the streamline relocation
        calculations, that is, a decrease in RCONST.

NEQN    This item controls the selection of the form of momentum equation
        that will be used to compute the meridional velocity distributions at
        each computing station. There are two basic forms, and for each case,
        one may select not to compute the terms relating to blade forces.
        (See Reference 1.)

        If NEQN = 0, the momentum equation involves the differential form of
        the continuity equations and hence (1-Mm2 ) terms in the denominator.
        Streamwise gradients of entropy and angular momentum (blade forces)
        are computed within blades and at the blade edges (provided data that
        describe the blades are given). Elsewhere, streamwise entropy
        gradients only are included in a simpler form of the momentum
        equation, except that at the first and last computing station, all
        streamwise gradients are taken to be zero. This is generally the
        preferred option when computing stations are located within the blade
        rows.

        If NEQN = 1, the momentum equation form is similar to that used when
        NEQN = 0, but angular momentum gradients (blade force terms) are
        nowhere computed. This generally is the preferred option when
        computing stations are located at the blade edges only.

        If NEQN = 2, the momentum equation includes an explicit dVm/dm term
        instead of the (1-Mm2) denominator terms. All streamwise gradients
        (including blade force terms) are computed as for the case when NEQN
        = 0. When computing stations are located within the blade rows, the
        results will generally be similar to those obtained with NEQN = 0,
        and solutions may be found that cannot be computed with NEQN = 0 due
        to high meridional Mach numbers.

        If NEQN = 3, the momentum equation is similar to that used when NEQN
        = 1, and no angular momentum gradients are computed. This may be used
        when computing stations are located only at the blade edges and high
        meridional Mach numbers preclude the use of NEQN = 1.

NLE     See Section 1.19.4.2.2 for definitions.
NTE
NSIGN

NWHICH  The numbers of each of the computing stations for which blade
        descriptive data is being generated by the analytic meanline blade
        section.

SCLFAC  Linear dimension scale factor. (See Section 1.19.4.2.) An input value
        of zero will be reset to 12.0.

TOLNCE  Basic tolerance in iterative calculation scheme. An input value of
        zero will be reset to 0.001. (See discussion of tolerance scheme in
        Reference 1.)

VISK    Kinematic viscosity of gas (for annulus wall boundary layer
        calculations). An input value of zero will be reset to 0.00018.
        Units: LL/SCLFAC/SCLFAC/T.

SHAPE   Shape factor for annulus wall boundary layer calculations. An input
        value of zero will be reset to 0.7.

XSCALE  Set each equal to 0.0.
PSCALE
RLOW
PLOW

XMMAX   The square of the Mach number that appears in the equation for the
        streamline relocation relaxation factor is limited to be not greater
        than XMMAX. Thus, at computing stations where the appropriate Mach
        number is high enough for the limit to be imposed, a decrease in
        XMMAX corresponds to an increase in damping. If a value of zero is
        input, it is reset to 0.6.

RCONST  The constant in the equation for the streamline relocation relaxation
        factor. The value of 8.0 that the analysis yields is often too high
        for stability. If zero is input, it is reset to 6.0.

CONTR   The constant in the blade wake radial transfer calculations.

CONMX   The eddy viscosity for the turbulent mixing calculations. Units:
        L2/SCLFAC2/T.

FLOW    Compressor flow rate. Units: F/T.

SPDFAC  The speed of rotation of each computing station is SPDFAC times
        SPEED(I). The units for the product are revolutions/(60 x T).

NSPEC   The number of points used to define a computing station. Must satisfy
        2 <= NSPEC <= 21, and also the sum of NSPEC for all stations <= 150.
        If 2 points are used, the station is a straight line. Otherwise, a
        spline-curve is fitted through the given points.

XSTN,   The axial and radial coordinates, respectively, of a point defining a
RSTN    computing station. The first point must be on the hub and the last
        point must be on the casing. Units: L.

NDATA   Number of points defining conditions or blade geometry at a computing
        station. Must satisfy 0 <= NDATA <= 21, and also the sum of NDATA for
        all stations <= 100.

NTERP   If NTERP = 0, and NDATA >= 3, interpolation of the data at the
        station is by spline-fit.

        If NTERP = 1 (or NDATA <= 2), interpolation is linear point-to-point.

NDIMEN  If NDIMEN = 0, the data are input as a function of radius.

        If NDIMEN = 1, the data are input as a function of radius normalized
        with respect to tip radius.

        If NDIMEN = 2, the data are input as a function of distance along the
        computing station from the hub.

        If NDIMEN = 3, the data are input as a function of distance along the
        computing station normalized with respect to the total computing
        station length.

NMACH   If NMACH = 0, the subsonic solution to the continuity equation is
        sought.

        If NMACH = 1, the supersonic solution to the continuity equation is
        sought. This should only be used at stations where the relative flow
        angle is specified, that is, NWORK = 5, 6 or 7.

DATAC   The coordinate on the computing station, defined according to NDIMEN,
        where the following data items apply. Must increase monotonically.
        For dimensional cases, units are L.

DATA1   At Station 1 and if NWORK = 1, DATA1 is total pressure. Units: F/L/L.

        If NWORK = 0 and the station is at a blade leading edge, by setting
        NDATA not equal to 0, the blade leading edge may be described. Then
        DATA1 is the blade angle measured in the cylindrical plane. Generally
        negative for a rotor, positive for a stator. (Define the blade lean
        angle (DATA3) also). Units: A.

        If NWORK = 2, DATA1 is total enthalpy. Units: H/F.

        If NWORK = 3, DATA1 is angular momentum (radius times absolute whirl
        velocity). Units: LL/SCLFAC/T.

        If NWORK = 4, DATA1 is absolute whirl velocity. Units: L/SCLFAC/T.

        If NWORK = 5, DATA1 is blade angle measured in the streamsurface
        plane. Generally negative for a rotor, positive for a stator. If zero
        deviation is input, it becomes the relative flow angle. Units: A.

        If NWORK = 6, DATA1 is the blade angle measured in the cylindrical
        plane. Generally negative for a rotor, positive for a stator. If zero
        deviation is input, it becomes, after correction for streamsurface
        orientation and station lean angle, the relative flow angle. Units:
        A.

        If NWORK = 7, DATA1 is the reference relative outlet flow angle
        measured in the streamsurface plane. Generally negative for a rotor,
        positive for a stator. Units: A.

DATA2   At Station 1, DATA2 is total temperature. Units: D.

        If NLOSS = 1, DATA2 is the relative total pressure loss coefficient.
        The relative total pressure loss is measured from the station that is
        NL1 stations removed from the current station, NL1 being negative to
        indicate an upstream station. The relative dynamic head is determined
        NL2 stations removed from the current station, positive for a
        downstream station, negative for an upstream station.

        If NLOSS = 2, DATA2 is the isentropic efficiency of compression
        relative to conditions NL1 stations removed, NL1 being negative to
        indicate an upstream station.

        If NLOSS = 3, DATA2 is the entropy rise relative to the value NL1
        stations removed, NL1 being negative to indicate an upstream station.
        Units: H/F/D.

        If NLOSS = 4, DATA2 is not used, but a relative total pressure loss
        coefficient is determined from the trailing edge value and curve set
        number NCURVE of the NSET2 families of curves. NL1 and NL2 apply as
        for NLOSS = 1.

        If NLOSS = 7, DATA2 is the reference (minimum) relative total
        pressure loss coefficient. NL1 and NL2 apply as for NLOSS = 1.

DATA3   The blade lean angle measured from the projection of a radial line in
        the plane of the computing station, positive when the innermost
        portion of the blade precedes the outermost in the direction of rotor
        rotation. Units: A.

DATA4   The fraction of the periphery that is blocked by the presence of the
        blades.

DATA5   Cascade solidity. When a number of stations are used to describe the
        flow through a blade, values are only required at the trailing edge.
        (They are used in the loss coefficient re-estimation procedure, and
        to evaluate diffusion factors for the output.)

DATA6   If NWORK = 5 or 6, DATA6 is the deviation angle measured in the
        streamsurface plane. Generally negative for a rotor, positive for a
        stator. Units: A.

        If NWORK = 7, DATA6 is reference relative inlet angle, to which the
        minimum loss coefficient (DATA2) and the reference relative outlet
        angle (DATA7) correspond. Measured in the streamsurface plane and
        generally negative for a rotor, positive for a stator. Units: A.

DATA7   If NWORK = 7, DATA7 is the rate of change of relative outlet angle
        with relative inlet angle.

DATA8   If NWORK = 7, DATA8 is the relative inlet angle larger than the
        reference value at which the loss coefficient attains twice its
        reference value. Measured in the streamsurface plane. Units: A.

DATA9   If NWORK = 7, DATA9 is the relative inlet angle smaller than the
        reference value at which the loss coefficient attains twice its
        reference value. Measured in the streamsurface plane. Units: A.

NWORK   If NWORK = 0, constant entropy, angular momentum, and total enthalpy
        exist along streamlines from the previous station. (If NMIX = 1, the
        distributions will be modified.)

        If NWORK = 1, the total pressure distribution at the computing
        station is specified. Used for rotors only.

        If NWORK = 2, the total enthalpy distribution at the computing
        station is specified. Used for rotors only.

        If NWORK = 3, the absolute angular momentum distribution at the
        computing station is specified.

        If NWORK = 4, the absolute whirl velocity distribution at the
        computing station is specified.

        If NWORK = 5, the relative flow angle distribution at the station is
        specified by giving blade angles and deviation angles, both measured
        in the streamsurface plane.

        If NWORK = 6, the relative flow angle distribution at the station is
        specified by giving the blade angles measured in the cylindrical
        plane, and the deviation angles measured in the streamsurface plane.

        If NWORK = 7, the relative flow angle and relative total pressure
        loss coefficient distributions are specified by means of an
        off-design analysis procedure. "Reference", "stalling", and "choking"
        relative inlet angles are specified. The minimum loss coefficient
        varies parabolically with the relative inlet angle so that it is
        twice the minimum value at the "stalling" or "choking" values. A
        maximum value of 0.5 is imposed. "Reference" relative outlet angles
        and the rate of change of outlet angle with inlet angle are
        specified, and the relative outlet angle varies linearly from the
        reference value with the relative inlet angle. NLOSS should be set to
        zero.

NLOSS   If NLOSS = 1, the relative total pressure loss coefficient
        distribution is specified.

        If NLOSS = 2, isentropic efficiency (for compression) distribution is
        specified.

        If NLOSS = 3, the entropy rise distribution is specified.

        If NLOSS = 4, the total pressure loss coefficient distribution is
        specified by use of curve-set NCURVE of the NSET2 families of curves
        giving the fraction of final (trailing edge) loss coefficient.

NL1     The station from which the loss (in whatever form NLOSS specifies) is
        measured is NL1 stations removed from the station being evaluated.
        NL1 is negative to indicate an upstream station.

NL2     When a relative total pressure loss coefficient is used to specify
        losses, the relative dynamic head is taken NL2 stations removed from
        the station being evaluated. NL2 may be positive, zero, or negative;
        a positive value indicates a downstream station, a negative value
        indicates an upstream station.

NEVAL   If NEVAL = 0, no action is taken.

        If NEVAL > 0, curve-set number NEVAL of the NSET1 families of curves
        giving diffusion loss parameter as a function of diffusion factor
        will be used to re-estimate the relative total pressure loss
        coefficient. NLOSS must be 1, and NL1 and NL2 must specify the
        leading edge of the blade. See also NDEL.

        If NEVAL < 0, curve-set number NEVAL is used as when NEVAL > 0,
        except that the re-estimation is only made after the overall
        computation is completed (with the input losses). The resulting loss
        coefficients are displayed but not incorporated into the overall
        calculation. See also NDEL.

NCURVE  When NLOSS = 4, curve-set NCURVE of the NSET2 families of curves
        specifying the fraction of trailing-edge pressure loss coefficient as
        a function of meridional chord is used.

NLITER  When NEVAL > 0, up to NLITER re-estimations of the loss coefficient
        will be made at a given station during any one pass through the
        overall iterative procedure. Less than NLITER re-estimations will be
        made if the velocity profile is unchanged by re-estimating the loss
        coefficients. (See discussion of tolerance scheme in Reference 4.)

NDEL    When NEVAL = 0, set NDEL to 0. When NEVAL does not equal 0, and NDEL
        > 0, a component of the re-estimated loss coefficient is a shock
        loss. The relative inlet Mach number is expanded (or compressed)
        through a Prandtl-Meyer expansion on the suction surface, and NDEL is
        the number of points at which the Prandtl-Meyer angle is given. If
        NDEL = 0, the shock loss is set at zero. Must satisfy 0 >= NDEL <=
        21, and also the sum of NDEL for all stations <= 100.

NOUT1   Set NOUT1 = 0

NOUT2   Set NOUT2 = 0

NOUT3   This data item controls the generation of NASTRAN-compatible
        temperature and pressure difference output for use in subsequent
        blade stress analyses. For details of the triangular mesh that is
        used, see Section 1.19.5.1.

        NOUT3 = XY, where

           if X = 1, the station is at a blade leading edge.
           if X = 2, the station is at a blade trailing edge.
           if Y = 0, then both temperature and pressure data will be
           generated.
           if Y = 1, then only pressure data will be generated.
           if Y = 2, then only temperature data will be generated.

        If NOUT3 = 0, the station may be between blade rows, or within a
        blade row for which output is required, depending upon the use of
        NOUT3 not equal to 0 elsewhere. See also description of NBLADE below.

NBLADE  This item is used in determining the pressure difference across the
        blade. The number of blades is |NBLADE|. If NBLADE is positive,
        "three-point averaging" is used to determine the pressure difference
        across each blade element. If NBLADE is negative, "four-point
        averaging" is used. (See Section 1.19.5.2.3.) If NBLADE is input as
        zero, a value of +10 is used. At a leading edge, the value for the
        following station is used; elsewhere the value at a station applies
        to the interval upstream of the station. Thus, by varying the sign of
        NBLADE, the averaging method used for the pressure forces may be
        varied for different axial segments of a blade row.

SPEED   The speed of rotation of the blade. At a blade leading edge, it
        should be set to zero. The product SPDFAC times SPEED has units of
        revolutions/(T x 60). This card is omitted if NDATA = 0.

DELC    The coordinate at which Prandtl-Meyer expansion angles are given. It
        defines the angle as a function of the dimensions of the leading edge
        station, in the manner specified by NDIMEN for the current, that is,
        trailing edge station. Must increase monotonically. For dimensional
        cases, units are L.

DELTA   The Prandtl-Meyer expansion angles. A positive value implies
        expansion. If blade angles are given at the leading edge, the
        incidence angles are added to the value specified by DELTA. Units: A.
        (Blade angles are measured in the cylindrical plane.)

WBLOCK  A blockage factor that is incorporated into the continuity equation
        to account for annulus wall boundary layers. It is expressed as the
        fraction of total area at the computing station that is blocked. If
        NBL = 1, values (except at Station 1) are revised during computation,
        involving data items VISK and SHAPE.

BBLOCK, A blockage factor is incorporated into the continuity equation that
BDIST   may be used to account for blade wakes or other effects. It varies
        linearly with distance along the computing station. BBLOCK is the
        value at mid-station (expressed as the fraction of the periphery
        blocked), and BDIST is the ratio of the value on the hub to the
        mid-value.

NDIFF   When NSET1 > 0, there are NDIFF points defining loss diffusion
        parameter as a function of diffusion factor. Must satisfy 1 <= NDIFF
        <= 15.

DIFF    The diffusion factor at which loss parameters are specified. Must
        increase monotonically.

FDHUB   Diffusion loss parameter at 10% of the radial blade height.

FDMID   Diffusion loss parameter at 50% of the radial blade height.

FDTIP   Diffusion loss parameter at 90% of the radial blade height.

NM      When NSET2 > 0, there are NM points defining the fraction of trailing
        edge loss coefficient as a function of meridional chord. Must satisfy
        1 <= NM <= 11.

NRAD    The number of radial locations where NM loss fraction/chord points
        are given. Must satisfy 1 <= NRAD <= 5.

TERAD   The fraction of radial blade height at the trailing edge where the
        following loss fraction/chord curve applies. If NRAD = 1, it has no
        significance.

DM      The location on the meridional chord where the loss fraction is
        given. Expressed as a fraction of meridional chord from the leading
        edge. Must increase monotonically.

WFRAC   Fraction of trailing edge loss coefficient that occurs at location
        DM.

DELF    The fraction of the total flow that is to occur between the hub and
        each streamline. The hub and casing are included, so that the first
        value must be 0.0, and the last (NSTRMS) value must be 1.0.

R       Estimated streamline radius. (This data is input from hub to tip for
        the first station, from hub to tip for the second station, and so
        on.) Units: L.

X       Estimated axial coordinate at intersection of streamline with
        computing station. Units: L.

XL      Estimated distance along computing station from hub to intersection
        of streamline with computing station. Units: L.

II, JJ  Station and streamline number. These are merely read in and printed
        out to give a check on the order of the cards.

## 1.19.5  Aerodynamic Output Data
### 1.19.5.1  Analytic Meanline Blade Section

   Printed output may be considered to consist of four sections: a printout of
the input data, details of the blade sections on each streamsurface, a listing
of quantities required for aerodynamic analysis, and details of the
manufacturing sections determined on the constant-z planes. These are briefly
described below. In the explanation which follows, parenthetical statements
are understood to refer to the particular case of the double-circular-arc
blade (ISECN = 2).

   The input data printout includes all quantities read in, and is
self-explanatory.

   Details of the streamsurface blade sections are printed if IPRINT = 0 or 1.
Listed first are the parameters defining the blade section. These are
interpolated at the streamsurface from the tables read in. Then follow details
of the blade section in "normalized" form. The blade section geometry is given
for the section specified, except that the meridional projection of the chord
is unity. For this section of the output, the coordinate origin is the blade
leading edge. The following quantities are given: blade chord, stagger angle,
camber angle, section area, location of the centroid of the section, second
moments of area of the section about the centroid, orientation of the
principal axes, and the principal second moments of area of the section about
the centroid. Then are listed the coordinates of the camber line, the camber
line angle, the section thickness, and the coordinates of the blade surfaces.
NPOINT values are given.

   A line printer plot of the normalized section follows. The scales for the
plot are arranged so that the section just fills the page; therefore the
scales will generally differ from one plot to another. "Dimensional" details
of the blade section are given next. The normalized data given previously is
scaled to give a blade section as defined by IFCORD and CORD. For this section
of the output, the coordinates are with respect to the blade stacking axis.
The following quantities are given: blade chord, radius and location of center
of leading and trailing edges, section area, the second moments of area of the
section about the centroid, and the principal second moments of area of the
section about the centroid. The coordinates of NPOINT points on the blade
surfaces are then listed, followed by the coordinates of 31 points distributed
at (roughly) six-degree intervals around the leading and trailing edges.
Finally, the coordinates of the blade surfaces and points around the leading
and trailing edges are shown in Cartesian form.

   The quantities required for aerodynamic analysis are printed at all
computing stations specified by the IFANGS parameter. The radius, blade
section angle, blade lean angle, blade blockage, and relative angular location
of the camber line are printed at each streamsurface intersection with the
particular computing station. The blade section angle is measured in the
cylindrical plane, and the blade lean angle is measured in the
constant-axial-coordinate plane.

   Details of the manufacturing sections are printed if IPRINT = 0 or 2. At
each value of z specified by ZINNER, ZOUTER, and NZ, section properties and
coordinates are given. The origin for the coordinates is the blade stacking
axis. The following quantities are given: section area, the location of the
centroid of the section, the second moments of area of the section about the
centroid, the principal second moments of area of the section about the
centroid, the orientation of the principal axes, and the section torsional
constant. Then the coordinates of NPOINT points on the blade section surfaces
are listed, followed by 31 points around the leading and trailing edges.

   The additional input and output required for, and generated by, the
interface are also printed. (Apart from the input data printout, this is the
only printed output when IPRINT = 3.)

   If the parameter PGEOM does not equal 1, then cards are punched that may be
used as input for subsequent NASTRAN runs. For the purpose of stress analysis,
the blade is divided into a number of triangular elements, each defined by
three grid points. The intersections between computing stations and
streamsurfaces are used as the grid points, and the grid points and element
numbering scheme adopted is illustrated in Figure 1.19-3.

                                   
               This figure is not included in the machine readable
               documentation because of complex graphics.

        Figure 1.19-3. Grid point and element numbering scheme.

### 1.19.5.2  Aerodynamic Section
#### 1.19.5.2.1  Normal Output

   The input data is first printed out in its entirety, and the results for
each running point follow. The output is generally self-explanatory and
definitions are given here for some derived quantities. Tabular output is
generally not started on a page unless it can be completed on the same page,
according to the maximum number of lines permitted by the input variable
NPAGE.

   The results of each running point are given under a heading giving the
running point number. Any diagnostics generated during the calculation will
appear first under the heading. (Diagnostics are described in the following
section.) Then, a station-by-station printout follows for each station through
to the last station, or to the station where the calculation failed, if this
occurred. One or more diagnostics will indicate the reason for the failure, in
this event. Included in the meshpoint coordinate data is the distance along
the computing station from the hub to the interception of the streamline with
the station (L), and the station lean angle (GAMA). Where the radius of
curvature of a streamline is shown as zero, the streamline has no curvature.
The whirl angle is defined by

               V
                �
      tan + = -----                                                 (2)
               V
                m

   For stations within a blade, or at a blade trailing edge, a relative total
pressure loss coefficient is shown. The loss of relative total pressure is
computed from the station defined by the input variable NL1. If a loss
coefficient was used in the input for the station (NLOSS = 1 or 4, or NWORK =
7), the input variable NL2 defines the station where the normalizing relative
dynamic head is taken; otherwise, it is taken at the station defined by NL1.
If the cascade solidity is given as anything but zero, it is used in the
determination of diffusion factors. The following definition is used:

                V         V    V
                 2r        �1r  �2r
      D = 1 -  -----  +  -----------                                (3)
                V         2+ V
                 1r           1r

   Inlet conditions (subscript 1) are taken from the station defined by the
input variable NL1.

   The last term in Equation 3 is multiplied by -1 if the blade speed is
greater than zero, or the blade speed is zero and the preceding rotating blade
row has negative rotation. This is necessary because relative whirl angles are
(generally) negative for rotor blades and for stator blades that follow a
rotor having "negative" wheel speed. Incidence and deviation angles are
treated in the same way, so that positive and negative values have their
conventional significance for all blades.

   If annulus wall boundary layer computations were made (NBL = 1), details
are shown for each station. Then, an overall result is given, including a
statement of the number of passes that have been performed and whether the
calculation has converged, unconverged, or failed. When the calculation is
unconverged, the number of mesh points where the meridional velocity component
has not remained constant to within the specified tolerance (TOLNCE) on the
last two passes is shown as IVFAIL. Similarly, the number of streamtubes,
defined by the hub and each streamline in turn, where the fraction of the flow
is not within the same tolerance of the target value, is shown as IFFAIL. If
these numbers are small, say less than 10% of the maximum possible values, the
results may generally be used. Otherwise, the computation should be rerun,
either for a greater number of passes, or with modified relaxation factor
constants. The default option relaxation constants will generally be
satisfactory but may need modification for some cases. If insufficient damping
is specified by the constants, the streamlines generated will tend to
oscillate, and this may be detected by observing a relatively small radius of
curvature for the mid-passage streamline that also changes sign from one
station to the next. This may be corrected by rerunning the problem (from
scratch) with a lower value input for RCONST, say, of 4.0 instead of 6.0. When
the damping is excessive, the velocities will tend to remain constant while
the streamlines will not adjust rapidly to the correct locations. This will be
indicated by a small IVFAIL and a relatively large IFFAIL. For optimum program
performance, RCONST should be increased, and the streamline pattern generated
thus far could be used as a starting point. The second constant XMMAX (the
maximum value of the square of Mach number used in the relaxation factor) is
incorporated so that in high subsonic or supersonic cases the damping does not
decrease unacceptably. The default value of 0.6 may be too low for rapid
program convergence in some such cases.

   If the generation of blade pressure load data for subsequent use in NASTRAN
is specified (by the input variable NOUT3), a self-explanatory printout is
also made. The blade element numbering scheme is the same as that incorporated
into both blading sections of the program, and illustrated in Figure 1.19-1.

   If the loss coefficient re-estimation routine has been used for any
bladerow(s) (NEVAL is not equal to 0), a printout summarizing the computations
made will follow. A heading indicating whether the re-estimation was
incorporated into the overall iterative procedure or whether it was merely
made "after the event" is first printed. Then follows a self-explanatory
tabulation of various quantities involved in the re-determination of the loss
coefficient on each streamline.

#### 1.19.5.2.2  Diagnostic Output

   The various diagnostic messages that may be produced by the aerodynamic
section of the program are all shown. Where a computed value will appear, "x"
is shown here.

1. JOB STOPPED - TOO MUCH INPUT DATA.

The above message will occur if the sum of NSPEC or NDATA or NDEL for all
stations is above the permitted limit. Execution ceases.

2. STATIC ENTHALPY BELOW LIMIT AT xxx.xxxxxExxx.

The output routine (subroutine ALG11) calculates static enthalpy at each
meshpoint when computing the various output parameters, and this message will
occur if a value below the limit (HMIN) occurs. The limiting value will be
used, and the results printed become correspondingly arbitrary. HMIN is set in
subroutine ALGAR, and should be maintained at some positive value well below
any value that will be validly encountered in calculation.

3. PASSxxx STATIONxxx STREAMLINExxx PRANDTL-MEYER
   FUNCTION NOT CONVERGED - USE INLET MACH NO.

The loss coefficient re-estimation procedure involves iteratively solving for
the Mach number in the Prandtl-Meyer function. If the calculation does not
converge in 20 attempts, the above message is printed, and, as indicated, the
Mach number following the expansion (or compression) is assumed to equal the
inlet value. (The routine only prints output following the completion of all
computations and printing of the station-by-station output data.)

4. PASSxxx STATIONxxx ITERATIONxxx STREAMLINExxx
   MERIDIONAL VELOCITY UNCONVERGED VM = xx.xxxxxxExx
   VM(OLD) = xx.xxxxxxExx.

For "analysis" cases, that is, at stations where relative flow angle is
specified, the calculation of meridional velocity proceeds iteratively at each
meshpoint from the mid-streamline to the case and then to the hub. The
variable IPMAX (set to 10 in subroutines ALG08 and ALG26) limits the maximum
number of iterations that may be made at a streamline without the velocity
being converged before the calculation proceeds to the next streamline. The
above message will occur if all iterations are used without achieving
convergence, and the pass number is greater than NFORCE. Convergence is here
defined as occurring when the velocity repeats to within TOLNCE/5.0, applied
nondimensionally. No other program action occurs.

5. PASSxxx STATIONxxx MOMENTUM AND/OR CONTINUITY
   UNCONVERGED W/W SPEC = xx.xxxxx VM/VM (OLD) HUB xx.xxxxx
   MID = xx.xxxxx TIP = xx.xxxxx.

If, following completion of all ITMAX iterations permitted for the flow rate
or meridional velocity, the simultaneous solution of the momentum and
continuity equations profile is unconverged, and the pass number is greater
than NFORCE, the above message occurs. Here converged means that the flow rate
equals the specified value, and the meridional velocity repeats, to within
TOLNCE/5.0, applied nondimensionally. If loss coefficient re-estimation is
specified (NEVAL > 0), an additional iteration is involved, and the tolerance
is halved. No further program action occurs.

6. PASSxxx STATIONxxx VM PROFILE NOT CONVERGED WITH LOSS RECALC
   VM NEW/VM PREV HUB = xx.xxxxxx MID = xx.xxxxxx CASE = xx.xxxxxx.

When loss re-estimation is specified (NEVAL > 0), up to NLITER solutions to
the momentum and continuity equations are completed, each with a revised loss
coefficient variation. If, when the pass number is greater than NFORCE, the
velocity profile is not converged after the NLITER cycles of calculation have
been performed, the above message is issued. For convergence, the meridional
velocities must repeat to within TOLNCE/5.0, applied nondimensionally. No
further program action occurs.

A further check on the convergence of this procedure is to compare the loss
coefficients used on the final pass of calculation, and thus shown in the
station-by-station results, with those shown in the output from the loss
coefficient re-estimation routine, which are computed from the final
velocities, etc.

7. PASSxxx STATIONxxx ITERATIONxxx STREAMTUBExxx STATIC ENTHALPY BELOW
   LIMIT IN MOMENTUM EQUATION AT xxx.xxxxxExxx.

The static enthalpy is calculated (to find the static temperature) during
computation of the "design" case momentum equation, that is, when whirl
velocity is specified. If a value lower than HMIN (see discussion of second
diagnostic message) is produced, the limiting value is inserted. If this
occurs when IPASS > NFORCE, the above message is printed. If this occurs on
the final iteration, the calculation is deemed to have failed, calculation
ceases, and results are printed out through to this station.

8. PASSxxx STATIONxxx ITERATIONxxx STREAMTUBExxx LOOPxxx
   STATIC H IN MOMENTUM EQUN. BELOW LIMIT AT xxx.xxxxxExxx.

This corresponds to the previous message, but for the "analysis" case. For
failure, it must occur on the final iteration and loop.

9. PASSxxx STATIONxxx ITERATIONxxx STREAMTUBExxx
   MERIDIONAL MACH NUMBER ABOVE LIMIT AT xxx.xxxxxExx.

When subroutine ALG08 is selected (NEQN = 0 or 1), the meridional Mach number
is calculated during computation of the design momentum equation, and a
maximum value of 0.99 is permitted. If a higher value is calculated, the
limiting value is inserted. If this occurs when IPASS > NFORCE, the above
message is printed. If this occurs on the final iteration, the calculation is
deemed to have failed, calculation ceases, and results are printed through to
this station.

10. PASSxxx STATIONxxx ITERATIONxxx STREAMTUBExxx LOOPxxx
    MERIDIONAL MACH NUMBER ABOVE LIMIT AT xxx.xxxxxExxx.

This corresponds to the previous message, but for the "analysis" case. For
failure, it must occur at the final iteration and loop.

11. PASSxxx STATIONxxx ITERATIONxxx STREAMTUBExxx
    MOMENTUM EQUATION EXPONENT ABOVE LIMIT AT xxx.xxxxxExxx.

An exponentiation is performed during the computation of the design case
momentum equation, and the maximum value of the exponent is limited to 88.0.
If this substitution is required when IPASS > NFORCE, the above message is
printed. If it occurs on the final iteration, the calculation is deemed to
have failed, calculation ceases, and results are printed through to this
station.

12. PASSxxx STATIONxxx ITERATIONSxxx STREAMLINExxx
    (MERIDIONAL VELOCITY) SQUARED BELOW LIMIT AT xxx.xxxxxExxx.

If a meridional velocity, squared, of less than 1.0 is calculated during
computation of the design case momentum equation, this limit is imposed. If
this occurs when IPASS > NFORCE, the above message is printed. If this occurs
on the final iteration, the calculation is deemed to have failed, calculation
ceases, and results are printed out through to this station.

13. PASSxxx STATIONxxx ITERATIONxxx STREAMIINExxx LOOPxxx
    (MERIDIONAL VELOCITY) SQUARED BELOW LIMIT AT xxx.xxxxxExxx.

This corresponds to the previous message, but for the "analysis" case. For
failure, it must occur on the last iteration and loop.

14. PASSxxx STATIONxxx ITERATIONxxx STREAMTUBExxx
    STATIC ENTHALPY BELOW LIMIT IN CONTINUITY EQUATION
    AT xxx.xxxxxExxx.

The static enthalpy is calculated during computation of the continuity
equation. If a value lower than HMIN (see discussion of second diagnostic
message) is produced, the limiting value Is imposed. If this occurs when IPASS
> NFORCE, the above message is printed. If this occurs on the final iteration,
the calculation is deemed to have failed, calculation ceases, and results are
printed out through to this station.

15. PASSxxx STATIONxxx ITERATIONxxx STREAMLINExxx
    MERIDIONAL VELOCITY BELOW LIMIT IN CONTINUITY AT
    xxx.xxxxxExxx.

If a meridional velocity of less than 1.0 is calculated when the velocity
profile is incremented by the amount estimated to be required to satisfy
continuity, this limit is imposed. If this occurs when IPASS > NFORCE, the
above message is printed. If this occurs on the final iteration, the
calculation is deemed to have failed, calculation ceases, and results are
printed through to this station.

16. PASSxxx STATIONxxx ITERATIONxxx OTHER CONTINUITY EQUATION
    BRANCH REQUIRED

If, when IPASS > NFORCE, a velocity profile is produced that corresponds to a
subsonic solution to the continuity equation when a supersonic solution is
required, or vice versa, the above message is printed. If this occurs on the
final iteration, failure is deemed to have occurred, calculation ceases, and
results are printed out through to this station.

17. PASSxxx STATIONxxx ITERATIONxxx STREAMLINExxx
    MERIDIONAL VELOCITY GREATER THAN TWICE MID VALUE

During integration of the "design" momentum equations, no meridional velocity
is permitted to be greater than twice the value on the mid-streamline. If this
occurs when IPASS > NFORCE, the above message is printed. If this occurs on
the final iteration, the calculation is deemed to have failed, calculation
ceases, and results are printed through to this station. In the event that
this limit interferes with a valid velocity profile, the constants that appear
on some of the input data cards may have to be modified accordingly. Note that
as the calculation is at this point working with the square of the meridional
velocity, the constant for a limit of, for instance, 2.0 times the
mid-streamline value appears as 4.0.

18. PASSxxx STATIONxxx ITERATIONxxx STREAMLINExxx LOOPxxx
    MERIDIONAL VELOCITY ABOVE LIMIT xxxxxExx LIMIT = xxxxxExx.

During integration of the "analysis" momentum equations, no meridional
velocity is permitted to be greater than three times the value on the
mid-streamline. If this occurs when IPASS > NFORCE, the above message is
printed. If this occurs on the final loop of the final iteration, the
calculation is deemed to have failed, calculation ceases, and results are
printed through to this station. In the event that the limit interferes with a
valid velocity profile, the constants that appear on some of the input data
cards may have to be modified accordingly. Note that the program is working
with meridional velocity squared, so that a limit of, for instance, 3.0 times
the mid-streamline value appears as 9.0.

19. PASSxxx STATIONxxx STREAMLINExxx LIMITING MERIDIONAL VELOCITY
    SQUARED = xxxxxExx.

In subroutine ALG08 (NEQN = 0 or 1), a maximum permissible meridional velocity
(equal to the speed of sound) is established for each streamline at the
beginning of each pass. The calculation yields the square of the velocity, and
if a value of less than 1.0 is obtained, a value of 6250000.0 is superimposed
(which corresponds to a meridional velocity of 2500.0). If this occurs when
IPASS > NFORCE, the above message is printed, and the calculation is deemed to
have failed. Calculation ceases after the station computations are made, and
results are printed through to this station.

20. PASSxxx STATIONxxx ITERATIONxxx STREAMLINExxx MERIDIONAL
    VELOCITY ABOVE SOUND SPEED VM = xxxx.xx A = xxxx.xx.

In subroutine ALG08 (NEQN = 0 or 1), no meridional velocity is permitted to be
larger than the speed of sound. The above message will occur if this limit is
violated during integration of the "design" momentum when IPASS > NFORCE. If
the limit is violated at any point when IPASS > NFORCE and on the last
permitted iteration (last permitted loop also in the case of the "analysis"
momentum equation), the calculation is deemed to have failed. Calculation
ceases, and the results are printed through to this station.

21. MIXING CALCULATION FAILURE NO. n

The above message occurs when flow mixing calculations are specified, and the
computation fails. The overall calculation is halted, and results are printed
through to the station that is the upstream boundary for the mixing interval
in which the failure occurred. The integer n takes on different values to
indicate specific problems as follows.

1  In solving for the static pressure distribution at the upstream boundary of
   each mixing step, the average static enthalpy is determined in each
   streamtube (defined by an adjacent pair of streamlines). This failure
   indicates that a value less than HMIN was determined.

2  Calculation of the static pressure distribution at the upstream boundary of
   the mixing step is iterative. This failure indicates that the procedure did
   not converge after 10 iterations.

3  The static enthalpy on each streamline at the mixing step upstream boundary
   is determined from the static pressure and entropy there. This failure
   indicates that a value less than HMIN was determined.

4  The axial velocity distribution at the mixing step upstream boundary is
   determined from the total enthalpy, static enthalpy, and tangential
   velocity distributions. This failure indicates that a value less than HMIN
   was determined.

5  In solving for the static pressure distribution at the downstream boundary
   of each mixing step, the average static enthalpy is determined in each
   streamtube (defined by an adjacent pair of streamlines). This failure
   indicates that a value less than HMIN was determined.

6  Calculation of the static pressure distribution at the downstream boundary
   of the mixing step is iterative. This failure indicates that the procedure
   did not converge after 10 iterations.

7  The static enthalpy distribution at the mixing step downstream boundary is
   found from the total enthalpy, axial velocity, and tangential velocity
   distributions. This failure indicates that a value less than HMIN was
   determined.

8  In order to satisfy continuity, the static pressure level at the mixing
   step downstream boundary is iteratively determined. This failure indicates
   that after 15 attempts, the procedure was unconverged.

#### 1.19.5.2.3  Aerodynamic Load and Temperature Output

   Four output options may result in cards being punched by the aerodynamic
section of the program. Use of the input item NOUT3 gives PLOAD2 and TEMP
cards punched in a format compatible with NASTRAN input data. For the purposes
of stress analysis, the blade is taken to be composed of a number of
triangular elements. Two such elements are formed by the quadrilateral defined
by two adjacent streamlines and two adjacent computing stations. The way that
each quadrilateral is divided into two triangles, and the element numbering
scheme that is used, are illustrated in Figure 1.19-3. The pressure difference
for each element is given by an average of either three or four values at
surrounding meshpoints. The pressure difference at each meshpoint is computed
from the equation

                 2+rp                        dS     Vm    d  (rV�)
      delta p = ------  { sin + cos + g J + ---- + ----  ----      }(4)
                  N                          dM     r     dm

and as follows. At the blade leading edge, a forward difference is used to
determine the meridional gradients. At the blade trailing edge, the pressure
difference is taken to be zero. At stations with the bladerow (following a
leading edge), mean central differences are used to determine the meridional
gradients. When the input item NBLADE is positive (or zero) for a particular
blade axial segment, then three-point averaging is used. For instance, for
element number 1 in Figure 1.19-3, pressure differences at grid points 1, 6,
and 7 would be used. If NBLADE is negative, four-point averaging is used. For
instance, for element number 1, pressure differences at grid points 1, 2, 6,
and 7 would be used. The same average would also apply to element number 2.
Relative total temperatures are output at the grid points on the blade. A
TEMPD value is also output, using the average temperature at the blade root
for the grid points on the rest of the structure.

REFERENCES

1. Elchuri, V., Smith, G. C. C., Gallo, A. M., and Dale, B. J., "NASTRAN Level
   16 Theoretical, User's, Programmer's, and Demonstration Manuals Updates for
   Aeroelastic Analysis of Bladed Discs," NASA CRs 159823-159826, March 1980.

2. Smith, G. C. C., and Elchuri, V., "Aeroelastic and Dynamic Finite Element
   Analysis of a Bladed Shrouded Disk," NASA CR 159728, March 1980.

3. Gallo, A. M., Elchuri, V. and Skalskl, S. C., "Bladed-Shrouded-Disc
   Aeroelastic Analyses: Computer Program Updates in NASTRAN Level 17.7," NASA
   CR-165428, December 1981.

4. Hearsey, R. M., "A Revised Computer Program for Axial Compressor Design,"
   ARL-75-0001, Vols. I and II, Wright-Patterson AFB, January 1975.

# 1.20  MODAL FLUTTER ANALYSIS OF AXIAL-FLOW TURBOMACHINES AND ADVANCED
TURBOPROPELLERS

## 1.20.1  Introduction

   Unstalled flutter boundaries of axial-flow turbomachines (compressors and
turbines) can be determined using the capability described in this section.
The aeroelastic stability of a given operating point of a given stage of the
turbomachine is investigated in terms of modal families of several
circumferential harmonic indices considered one at a time. This capability is
based on the work described in References 1 through 3.

   Unstalled flutter boundaries of multi-bladed advanced turbopropellers can
also be determined using this capability. Such propellers consist of thin
blades of low aspect ratio and varying sweep. The analysis is similar to that
for axial-flow turbomachines, with the exception that the effects of blade
sweep and its spanwise variation are taken into account in computing the
generalized unsteady aerodynamic loads. This capability is based on the work
described in References 4 and 5.

## 1.20.2  Problem Formulation

   Impellers, propellers, fans, and bladed discs of turbomachines are some
examples of structures that exhibit rotational cyclic symmetry in their
geometric, material, and constraint properties. The modal flutter behavior of
such tuned cyclic structures can be investigated by a modal formulation of the
following equations:

        n   ..n      n   . n       en      dn     n      n    n
      [M ] {u  } + [B ] {u  } + [[K  ] + [K  ]] {u } - [Q ] {u } = 0(1)

        n            n+1
      {u }       = {u   }                                           (2)
          side 2         side 1

for n = 1, 2,..., N,

where n is the cyclic sector number and N is the number of cyclic sectors in
the structure. (See Section 1.12 for a discussion of cyclic symmetry and the
meaning of sides 1 and 2 in reference to a cyclic sector.)

   In the above equations, {un} represents the vibratory displacements in the
nth cyclic sector superposed on the steady-state deformed shape. [Mn], [Bn],
[Ken], and [Qn] are the mass, damping, elastic stiffness, differential
stiffness, and aerodynamic matrices, respectively, referred to the nth cyclic
sector.

   The natural modes and frequencies of the tuned cyclic structure can be
grouped in terms of several uncoupled sets, with each set corresponding to a
permissible circumferential harmonic index, k. Except for k = 0 and k = N/2 (N
even), the cyclic modes can be further separated into cosine and sine
component modes. For k = 0 and k = N/2, only cosine modes are defined. (See
Section 4.5 of the Theoretical Manual.) For tuned cyclic structures, the modal
flutter problem can be posed in terms of either cosine or sine modes with
identical results (Reference 2). In the present capability, this selection of
mode type is provided as a user option.

## 1.20.3  NASTRAN Implementation

   A rigid format (AERO APP R.F. 9) has been developed specifically for the
modal flutter analysis of axial-flow turbomachines and advanced
turbopropellers. It features bulk data cards and parameters designed to meet
the specific needs of this flutter capability. A simplified flowchart of the
rigid format is given in Figure 1.20-1. Complete details of the implementation
in earlier versions of NASTRAN are given in References 1, 3, and 5.

   The rigid format integrates the cyclic modal computations for a given
circumferential harmonic index with available flutter solution techniques in
NASTRAN. The Mach number parameter used in wing flutter analysis is replaced
by the interblade phase angle parameter for blade flutter analysis.

   In a compressor, turbine, or advanced turbopropeller, an operating point is
defined in terms of flow properties such as density, velocity, Mach number,
flow angle, etc., that vary across the blade span. Blade properties like the
blade angles, stagger angle, chord, etc., also, in general, change from the
blade root to the tip. The resulting spanwise variation in the local reduced
frequency and the relative Mach number is accounted for in estimating the
chordwise generalized aerodynamic forces per unit span at each streamline.
Integration of these forces over the blade span yields the blade generalized
aerodynamic load matrix. In order to nondimensionalize this matrix, the flow
and blade properties at a reference streamline are used.

   The generalized aerodynamic loads matrix, [Q], is computed by
two-dimensional cascade unsteady subsonic and supersonic aerodynamic theories
of References 6 and 7, respectively, used in a strip theory manner from the
blade root to the blade tip, as shown in Figures 1.20-2 and 1.20-3. These
theories have been incorporated into the AMG (Aerodynamic Matrix Generator)
module in NASTRAN.

   For advanced turbopropellers, the unsteady aerodynamic theory of Reference
6 has been modified to include the effects of blade sweep and its radial
variability (Reference 4).

## 1.20.4  Usage of the Capability

   Due to rotational cyclic symmetry, only one cyclic sector need be modeled.
The structural model is prepared using the general capabilities of NASTRAN for
modeling rotationally cyclic structures (see Section 1.12). The basic
coordinate system is fixed to the rotor/stator or the rotating propeller so
that the X-axis coincides with the axis of rotation and is in the direction of
air flow. The location of the origin is arbitrary.

   The XZ plane is located so as to contain (approximately) the maximum
projected area of the blade being modeled. This orientation is consistent with
the internally generated chordline coordinate systems for the unsteady
aerodynamics.

   The aerodynamic model is defined by STREAML1 bulk data cards and comprises
a grid defined by the intersection of a series of chords and "computing
stations" (Figures 1.20-2 and 1.20-3). The chords are selected normal to any
spanwise reference curve such as the blade leading edge. The choice of the
number and location of the chords and the computing stations is dictated by
the expected variation of the relative flow properties across the blade span,
and the complexity of the mode shapes exhibited by the blade. The reference
streamline number (see Section 1.20.3 above) is specified on the PARAM IREF
bulk data card. Due to its resemblance to the structural model of the blade,
and the adequacy of a relatively coarse grid to describe the spanwise flow
variations, the aerodynamic model is generally chosen as a subset of the
structural model, as shown in Figures 1.20-2 and 1.20-3.

   STREAML2 bulk data cards are used to specify the parameters associated with
both swept and unswept blade aerodynamics at the blade streamlines. Figure
1.20-4 defines some of these parameters in the case of a swept blade. In this
figure, A-B-, AB, and A+B+ represent three successive chords with the point
A's on the leading edge. For the chord AB, at any operating condition, WA
represents the absolute inflow velocity, while AU (= � x RA) is the blade
(tangential) velocity. WA and AU uniquely define a plane in which the inflow
properties are defined.

   In the plane WAU, VA = WA - AU represents the relative inflow velocity. CA
represents the chordwise, cascade relative inflow velocity (field 2,
continuation of the STREAML2 bulk data card, see Section 2.4). Mach number in
field 8 of the STREAML2 bulk data card is based on CA. Al is the line of
intersection between the axial plane through point A and the plane WAU. Angle
IAV defines the relative inflow angle 8 (shown positive).
   The angle of sweep � is defined as the angle of inclination of the chord BA
with the plane WAU. � shown in Figure 1.20-2 is positive.

   AD is the projection of AC (BA extended to C) in the plane WAU. Angle lAD
represents the stagger angle �, and is shown positive.

                   +-----------------------------------------+
                   |    F. E. Model of one cyclic sector     |
                   |    of n-bladed turbomachine stage or    |
                   | advanced turboprop, and given operating |
                   |  conditions to be examined for flutter  |
                   +--------------------+--------------------+
                                        |
Oscillatory                             |                         Steady State
Aerodynamic   +-------------------------+-----------------------+ Centrifugal
Data          |                         |                       | Loads
              |                         |         +-------------+--------------+
              |                         |         |                          d |
+-------------+--------------+          |         | Differential Stiffness, K  |
|Generalized Oscillatory     |          |         +-------------+--------------+
|Aerodynamic Loads           |          |                       |
|                            |          |                       |
|    Q  (+,k)                |    �     |         +-------------+--------------+
|     ii                     +----------|---------+  Natural Frequencies and   |
|                            |          |         |          Modes, �          |
|* Subsonic Relative Inflow  |          |         +-------------+--------------+
|* Supersonic Relative Inflow|          |                       |
|* Subsonic Relative Inflow  |          |                       |
|  with Blade Sweep          |          |         +-------------+--------------+
+-------------+--------------+          |         |  Generalized Mass, Damping |
              |                         |         |        and Stiffness       |
              |                         |         +-------------+--------------+
              |                         |                       |
              |                         |                       |
              |                         |                       |
              |                         |                       |
              |           +-------------+--------------+        |
              |           |   Flutter Loop Parameters  |        |
              |           |         +, k, p            |        |
              |           +-------------+--------------+        |
              |                         |                       |
              |                         |                       |
              +-------------------------+-----------------------+
                                        |
                                        A


Figure 1.20-1a. Overall flowchart of blade cyclic modal flutter analysis rigid
format for axial-flow turbomachines and advanced turbopropellers

                                        A
                                        |
                                        |
                       +----------------+---------------+
    +------------------+            Select +            |
    |                  +----------------+---------------+
    |                                   |
    |                  +----------------+---------------+
    |     +------------+            Select k            |
    |     |            +----------------+---------------+
    |     |                             |
    |     |            +----------------+---------------+
    |     |     +------+            Select p            |
    |     |     |      +----------------+---------------+
    |     |     |                       |
    |     |     |      +----------------+---------------+
    |     |     |      | Select or Interpolate Q  (+,k) |
    |     |     |      |                        ii      |
    |     |     |      +----------------+---------------+
    |     |     |                       |
    |     |     |                       |
    |     |     |      +----------------+---------------+
    |     |     |      |   Formulate Flutter Equations  |
    |     |     |      +----------------+---------------+
    |     |     |                       |
    |     |     |      +----------------+---------------+   +------------------+
    |     |     |      |       Complex Eigenvalues      +---+ V-g and V-f Plots|
    |     |     |      +----------------+---------------+   +------------------+
    |     |     |                       |
    |     |     |               Yes
    |     |     +------------------- Other p?
    |     |
    |     |                             | No
    |     |                             |
    |     |                     Yes
    |     +------------------------- Other k?
    |
    |                                   | No
    |                                   |
    |                           Yes
    +------------------------------- Other +?

                                        | No
                                        |
                                        |
                                      STOP


Figure 1.20-1b. Overall flowchart of blade cyclic modal flutter analysis rigid
format for axial-flow turbomachines and advanced turbopropellers

               This figure is not included in the machine readable
               documentation because of complex graphics.

     Figure 1.20-2. Rotational cyclic sector of an axial-flow turbomachine

               This figure is not included in the machine readable
               documentation because of complex graphics.

Figure 1.20-3. NASTRAN structural and aerodynamic models of an advanced
turbopropeller for flutter analysis

               This figure is not included in the machine readable
               documentation because of complex graphics.

Figure 1.20-4. Definitions of some parameters for swept blade aerodynamics

   A local coordinate system xyz is internally defined at the leading edge
point A of the chord AB such that x is directed along AB. y is defined normal
to the "mean" surface containing the points A-, A, A+, B+, B, and B-. The unit
vector along y, for the sense of � shown in Figure 1.20-2, is given by

                 ___      __         __     ___
      ^         (A B ) x (AB)       (AB) x (A B )
      _    1  |   - +                        + -
      j = --- |----------------  +  --------------
           2  |   ___      __         __     ___
              ||J(A B ) x (AB)|     |(AB) x (A B )|
                   - +                        + -

   Modal translations along y and rotations about x are used in deriving the
generalized airforce matrix. For the opposite sense of rotation, xyz is
internally defined to be left handed with y reversing direction. The shaded
area about the chord AB represents the strip of integration associated with
AB.

   The interblade phase angles are specified by means of FLFACT, FLUTTER, and
MKAEROi bulk data cards (see Section 2.4). Referring to the sketch below, a
positive interblade phase angle implies that blade 1 of the two-dimensional
cascade leads the reference blade 0.

                             |                    |
                             |                   .|  Blade 1
                             |         1     .    |
                             |           .        |
                             |      .             |
                             | .                  |
                             |                    |
                             |                   .|  Blade 0 (ref.)
                             |         0     .    |
                             |           .        |
                             |      .             |
                             | .                  |
                             |                    |
                             |                   .|
                             |               .    |
                             |           .        |
                             |      .             |
                             | .       |          |
                             |         |          |
                                       |
                                       |

   The cascade relative inflow Mach number varies along the blade span. Based
on this number at a given streamline, either the subsonic or the supersonic
theory is used. You specify the transonic Mach number range by means of the
bulk data parameters MAXMACH and MINMACH. MAXMACH specifies the upper Mach
number limit below which the subsonic theory is to be used; MINMACH specifies
the lower Mach number limit above which the supersonic theory is to be used.
For streamlines with relative Mach numbers between the limits MAXMACH and
MINMACH, the aerodynamic matrix terms are obtained by linear interpolation
from the adjacent streamline values. No transonic cascade theories have been
incorporated.

   It should be noted that for a given interblade phase angle and reference
reduced frequency, chordwise generalized aerodynamic matrices corresponding to
local spacing, stagger, and Mach number at the selected operating point will
be generated for each streamline on the blade. This is an expensive operation
and should be carefully controlled to reduce the computational work. The
aerodynamic matrices are, therefore, computed at a few interblade phase angles
and reduced frequencies, and interpolated for others. These parameters are
selected on MKAERO1 and MKAERO2 bulk data cards. Matrix interpolation is an
automatic feature of the rigid format. Additional aerodynamic matrices may be
generated and appended to the previous group on restart with new MKAEROi
cards, provided the rest of the data used for the matrix calculation remain
unaltered.

   To save further computational time, the chordwise generalized aerodynamic
matrices are first computed for "aerodynamic modes". The aerodynamic matrices
for chordwise structural modes are then determined from bilinear
transformations along each streamline before the spanwise integration to
obtain the complete blade generalized aerodynamic matrix. This permits a
change in the structural mode shapes of the same or a different harmonic
number to be included in the flutter analysis without having to recompute the
modal aerodynamic matrices for aerodynamic modes. This can be achieved by
appropriate DMAP ALTERs to the rigid format.

   For non-zero harmonic numbers, the normal modes analysis using cyclic
symmetry results in both "sine" and "cosine" mode shapes (see Section 1.12).
The BCD value of the parameter MTYPE on a PARAM bulk data card selects the
type of mode shapes to be used in flutter calculations. It is immaterial which
is selected.

   The method of flutter analysis is specified on the FLUTTER bulk data card.
The parameters required for flutter analysis (density ratios, interblade phase
angles, and reduced frequencies) are listed on FLFACT bulk data cards.

   The parameter VREF may be used to scale the output velocity. This can be
used to convert from consistent units (for example, in/sec) to any units you
may desire (for example, mph), determined from Vout = V/VREF.

   If sweep aerodynamic effects are to be included, the NASTRAN card (see
Section 2.1) must be used in the data deck to turn on the 93rd word of COMMON
/SYSTEM/. This is accomplished as follows:

   NASTRAN SYSTEM (93) = 1

   In situations where you wish to consider the disc of a bladed disc, or the
hub of a turbopropeller, to be relatively much stiffer than the blades, the
blades can be regarded as structurally independent. In such cases, the
following modeling points should be noted:

   1. CYJOIN bulk data cards are required merely for their presence in the
      Bulk Data Deck.

   2. PARAM KINDEX should be set zero to save computational time in real
      eigenvalue extraction.

   3. PARAM MTYPE must be set to COSlNE (the default) as KINDEX = 0.

REFERENCES
==========
1. Elchuri, V., Smith, G. C. C., Gallo, A. M., and Dale, B. J., "NASTRAN Level
   16 Theoretical, User's, Programmer's, and Demonstration Manuals Updates for
   Aeroelastic Analysis of Bladed Discs," NASA CRs 159823-159826, March 1980.

2. Smith, G. C. C., and Elchuri, V., "Aeroelastic and Dynamic Finite Element
   Analysis of a Bladed Shrouded Disc," NASA CR 159728, March 1980.

3. Gallo, A. M., Elchuri, V., and Skalski, S. C., "Bladed-Shrouded-Disc
   Aeroelastic Analyses: Computer Program Updates in NASTRAN Level 17.7," NASA
   CR 165428, December 1981.

4. Elchuri, V., and Smith, G. C. C., "NASTRAN Flutter Analysis of Advanced
   Turbopropellers," NASA CR 167926, April 1982.

5. Elchuri, V., Gallo, A. M., and Skalski, S. C., "NASTRAN Documentation for
   Flutter Analysis of Advanced Turbopropellers," NASA CR 167927, April 1982.

6. Rao, B. M., and Jones, W. P., "Unsteady Airloads for a Cascade of Staggered
   Blades In Subsonic Flow," 46th Propulsion Energetics Review Meeting,
   Monterey, California, September 1975.

7. Adamczyk, J. J., and Goldstein, M. E., "Unsteady Flow in a Supersonic
   Cascade with Subsonic Leading-Edge Locus," AlAA Journal, Vol. 16, No. 12,
   December 1978, pp. 1248-1254.
