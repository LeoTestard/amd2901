# AMD Am2901

![](http://placeholder.fr/~leo/cpu.png)

This is a complete implementation of an [Am2901](http://en.wikipedia.org/wiki/AMD_Am2900)
4-bit ALU slice.

This implementation is done using VLSI techniques and targeted at creating ASICs.
It was done as part of an introductory VLSI course in university. It can be
either simulated using [GHDL](https://gna.org/projects/ghdl/) or converted to
a layout describing the physical placement and connections between all components
at the gate transistor level (see picture above).

## How to use

Building requires the following tools:

* GHDL, a VHDL compiler based on GCC.
* Alliance, an open source toolchain for VLSI conception.
* Coriolis, another VLSI toolchain based on Alliance.

### Simulation

    make run

This will compile all the code down to native code and run a test bench.
The results can be observed using [GTKWave](http://gtkwave.sourceforge.net/)

    gtkwave amd_tb.vcd

### Layout 

To be able to generate the layout, you have to compile the code first. If you
did the "Simulations" step, this should already be done, otherwise, run:

    make

Copy the placement/routing script and change directory to the build directory:

    cp src/amd2901_chip.py build/
    cd build/

Placement is done using the `Cgt` tool from Coriolis:

    cgt

Use "File" -> "Open Cell" and type `amd2901`. Then use "Plugins" -> "Chip
Placement" to run the placement step, and finally "P&R" -> "Kite" - "Route" to
run the routing step. You should get more or less the same thing that the
picture above.
