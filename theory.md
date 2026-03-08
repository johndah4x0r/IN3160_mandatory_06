## Procedure for VHDL design
Here is a brief overview on how to work with VHDL designs (test driven methodology):

*	Try to form an idea of what type of solution is required.
    *	Read the exercise text carefully.
    *	Study the documentation for the involved components or hardware (here: test board).
    *	Create a block diagram for the inputs and outputs to be created for each module.
    *	Create other diagrams needed for the design (not a topic for this assignment)
*	Create the VHDL design entity first (one module at a time)
    * How does each module connect to other modules or environment. 
* Write a small testbench template that can provide some input to the module.  
    * Clock generation for sequential designs  
    * Some initial input that can be tested (reset / or a couple of data points)
        * Don't overdo this, the first iteration is just to get started.
        * A basic template can easily be copied to several modules
* Write the first part of the VHDL architecture of one module
    * Add as little functionality as possible before compiling.
        * Making small steps between compiling reduces the number of possible errors each time.
* Compile and run the current testbench
* Fix errors _if any_.
* For each new functionality to be added:
    * Create the necessary checks for that part in the testbench first
    * Then create the VHDL code that has the planned functionality
    * Recompile and run the testbench
    * Fix errors (in both testbench and module)
    * Reiterate for the next functionality, etc., until complete. 
 
## Structuring of a solution ##
The construction you will be implementing in the FPGA has an external interface to the other components on the test board and an internal structure. 
The external interface, in the form of input and output signals, corresponds to the entity declaration in a VHDL description. 
The internal structure corresponds to the architecture part of the VHDL description. 

It is often benificial to divide the internal structure into a data path structure and a control structure.
The data path structure contains elements such as registers, adders, multiplexers that are connected to data buses. 
The control structure consists of state machines or logic that is used to select data for input and output of the data path. 

This data path is well suited for description by a block diagram. 
If the structure is complex, it is a good idea to divide it into smaller blocks.

The control logic’s input and output signals can be described by a block diagram together with the data path structure. 
The internal structure of the control logic is described best in the form of truth-value tables, boolean equations and state diagrams. 
Comments in the code can be used to help structuring your solution while working with it.

Another rule of thumb is to keep code at the same level within each module. 
We often use a structural top-layer that connects modules of RTL or dataflow-descriptions. 
Code the structured solution in VHDL.
With a well-documented structure as the starting point, it is normally an easy job to create functioning code. 


## Naming guidelines for VHDL design files ##
To identify VHDL source files, it is a good idea to have certain naming conventions and rules for what the various files should contain. 
In all of the designs you create starting with part 2 of the exercise, we will save the entity and architecture in different files and follow the naming rules given in the following table:

| File content	| File name |
| :--- | :--- |
| Entity and architecture	| \<design_unit>.vhdl |
| Standalone entity	| \<design_unit>_ent.vhdl |
| Standalone architecture |	\<design_unit>_arch.vhdl |
| Package	| \<packagename>_pkg.vhdl |
| Behavioral architecture (simulation model)	| \<design_unit>_beh.vhdl |
| Test bench  |	tb_\<design_unit>.py |

<sup>Naming guidelines for source files</sup>

<design_unit> should be names that identify the function/content of the file 
(for example: `seg7ctrl_ent.vhdl`, `seg7ctrl_arch.vhdl`, `tb_seg7ctrl.py`).  

In many cases, it may be beneficial to keep both entity and architecture in a single file to avoid having too many files. 
It is also possible to separate each compilation unit to avoid spending time on compiling code that has not been changed. 
It is common to have a small number of design packages, often just one, that is synthesizable (for example: mydesign_pck.vhdl and mydesign_bdy.vhdl). 

## Testbenches ##
The first question when designing a test bench is what test vectors must be generated for a complete simulation of the chip’s behavior.
Applying test vectors is called stimuli or stimuli generation.

The next question is how we check that the module responds to the stimuli. 
It is often useful to let the checkers respond to the stimuli provided to the module ("DUT"), rather than creating one check per stimuli input. 

Depending on the complexity of the chip, this may be a very easy or a very difficult task. 
In many cases, it is a good idea to start with a table with all the relevant input signal combinations and expected output signal values.

## Self-test vs testbench ##
Normally we talk of running _testbenches_ as a means of _verification_, while a _self-test_ is one way of "_testing_"[^1].

While a _testbench_ _verifies functionality_ by providing stimuli and checking output values before implementation, a _self-test_ does _physically test a system_, after implementation on physical hardware. 
In many complex systems in use today, it is usual to have _self-tests_ implemented[^2]. 
Examples of _self-test_ modules can be _built in self-tests_ for RAM in PCs, simple test such as all the dashboard lights being lit when turning on a vehicle, or other diagnostic tests that can be accessed through menus. 
Advanced _self-tests_ are often hidden from the end-user, but available to service personnel when it is needed to perform necessary diagnostics. 

[Back](readme.md)
 
[^1]: The word “testing” often implies testing on physical hardware, while “verification” normally describes what is done to verify functionality before implementation.
      In other words: _Verification_ is running RTL-tests (testbenches), static timing analysis (using tools such as vivado), gate level or timing simulation. 
[^2]: A self-checking testbench is a testbench that uses assertions and reports in a way that the user can avoid checking waveforms unless there are errors. 
