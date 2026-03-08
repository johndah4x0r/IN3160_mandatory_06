# VHDL Design with modules -  Control of seven-segments
IN3160/4160
Version 2026-1

## Overview ##
> [!NOTE]
> Read both the theory and the task description before starting the task.
> 
> You will need to use the data sheets to complete this assignment.

[Theory](theory.md)

[Task description](task.md)

### Data sheets ###
[PMOD Seven segment reference manual](pmodssd_rm.pdf)

[Zedboard v_2.2 users guide](ZedBoard_HW_UG_v2_2.pdf)

[Zedboard v_1.1 users guide](ZedBoard_HW_UG_v1_1.pdf) (for Zedboards older than 2014)

## Delivery checklist

> [!IMPORTANT]
> A brief report that sums up what has been done and includes problems/challenges.
> It may be a good idea to draw figures with block diagrams, for example.
> Diagrams can be made in any capable tool[^1].
> 
> The python and VHDL code in task d) and e) can be delivered as two separate (.py and .vhd) files.
>
> **Delivery requirements:**
> *	All VHDL source file(s)
>	* Python test bench for b) and c)
> *	Makefile the testbenches (comment out changes/replacements)
> *	Waveforms (.ghw)
> *	Utilization report and Timing summary report for d)
> *	The .bit file used for programming the board.
>
> All the submitted VHDL files shall follow the naming guidelines for VHDL files and use indentation consistently to ensure good readability.
>
> _This assignment may be demonstrated for approval in lab._
>
> When approved in lab, comments and feedback are given orally, and there is no need for uploading content.
>
> The lab supervisor shall mark the assignments demonstrated in the learning platform (Canvas).

The seg7ctrl module will be used in assignment 8, to display motor velocities. 

[^1]: We recommend using https://www.drawio.com or https://app.diagrams.net  
  These are online/download versions of the same tool that will be available for the course exam.  

## Supervision guide 
(for lab supervisors)

> [!NOTE]
> **Approval:**
> * The seven segment should display the output without flickering.
>   * Both too low and too high refresh/ c- toggle frequency will cause flicker or characters mixing and weak output.
> * The character update should happen in a readable timeframe
>   * Generally each character should be visible between about 0.5 and 2s  
> * Seven segment that are consequent wrong must be fixed.
>   * Check constraint file - this must be correct (errors here will propagate to assignment 8). 
>   * Single segment faults from character table is not a big deal.      
> * **Templates are not considered a delivery = hard fail.**
>
> Mark/Comment assignments demonstrated in the learning platform (Canvas). 
