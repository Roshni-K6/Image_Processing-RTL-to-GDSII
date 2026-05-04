**RTL to GDSII Flow**

**RTL (Register Transfer Level)**:
RTL describes:
Data movement
Logic operations
Clock behaviour

It is written in Verilog and defines how data flows and how logic is implemented.

**GDSII (Graphic Design System II)**:
GDSII is the final layout file of the chip.
It contains:
All layers (metal, poly, diffusion, etc.)
Exact physical geometry of the design

This file is sent for fabrication.


***📌1. RTL Design***
Written in Verilog
Describes functionality of the circuit

Output:RTL code


***📌2. Simulation (VCS)***
Steps:
Run testbench
Verify correctness
Observe output waveforms (in Verdi)

Output:
Waveforms
Console outputs

Purpose: Ensure the design works correctly before synthesis


***📌3. Synthesis (Design Compiler)***
RTL is converted into logic gates.

Example:(R + G + B) / 3
becomes adders, dividers and logic gates

The tool decides:
Which gates to use
Gate sizes
Timing constraints
Optimized path

***Key Concepts***

**🔹Netlist**
A netlist is a description of how components are connected.


**🔹SDC (Synopsys Design Constraints)**
Defines timing constraints.
How fast should the circuit run?


**🔹DDC (Design Database)**
Binary format of the design
Internal to synthesis tool


**🔹VS (Technology Independent Netlist)**
No real gates
Logical representation only
Used for logic optimization

Example:
y = a & b
z = a & b
→ optimized to share one AND gate


**🔹VG (Technology Dependent Netlist / Mapped Netlist)**
Real standard cells are used
Based on standard cell library

Difference:
VS → no real hardware
VG → real hardware implementation

Outputs of Synthesis
Gate-level netlist (mapped file)
Timing report
Area report
Constraints file (SDC)

Important Note
Only the following are used for physical design:
-Mapped netlist
-SDC file
Because they define:
-Connections
-Timing behaviour


***📌4. Physical Design (IC Compiler II)***

**🔹4.1 Floorplanning**

Defines:
Chip size
Core area
I/O pin positions

Determines where everything will be placed roughly.

**🔹4.2 Power Planning**
Builds power network
VDD and GND lines

Every gate requires power to operate.

**🔹4.3 Placement**
Places all gates on the chip

Input:Mapped netlist
Output:Coordinates of each gate

**🔹4.4 Clock Tree Synthesis (CTS)**
Distributes clock signal evenly

Requirement:
All flip-flops must receive clock at the same time

Uses:
Buffers
Inverters

**🔹4.5 Routing**
Connects all gates using metal wires

Types:
Global routing
Detailed routing

Output:
Complete connections


***📌5. GDSII Generation***

Final output file containing:
All layers
Wires
Transistor shapes

This file is sent for fabrication.
