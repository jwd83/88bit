# HDLBits

## [https://github.com/jwd83/hdlbits](https://github.com/jwd83/hdlbits)

This repo contains my personal solutions while working through the
[problems on HDLBits](https://hdlbits.01xz.net/wiki/Problem_sets) as well as some notes on
Verilog in late 2024. ([see my stats](https://hdlbits.01xz.net/wiki/Special:VlgStats/5CBCEE65CFD17EBB))

## Blocking vs. Non-Blocking Assignment

There are three types of assignments in Verilog:

* **Continuous** assignments (assign x = y;). Can only be used when **not**
  inside a procedure ("always block").
* Procedural **blocking** assignment: (x = y;). Can only be used inside a
  procedure.
* Procedural **non-blocking** assignment: (x <= y;). Can only be used inside a
  procedure.

## Avoid creating latches

* See 32-AlwaysIf2
* <https://hdlbits.01xz.net/wiki/Always_if2>
* "Watch out for Warning (10240): ... inferring latch(es)" messages. Unless the
  latch was intentional, it almost always indicates a bug"

## TODO

Revisit lessons

* 103 was not well explained. I need to revisit this one.
Expand notes on...
* creating variables
* number types !b, !d, etc.
* concatenation & sign extension
* wire vs reg vs logic
* creating a module
* out vs reg module types
* using modules by name or position
* reduction operators
* ternary operators
* casez/casex
* datatypes. integer vs int
* generate blocks
* [sum of products vs product of sums](https://www.youtube.com/watch?v=t_1yugHFD0A)
  * product of sums: typically used when you have fewer 0s than 1s to solve for.
    * OR together bits of terms that produce a 0 output, inverting as necessary for false result case then AND together ORed terms.
  * sum of products: typically used when you have fewer 1s than 0s to solve for.
    * AND together bits of term that produce a 1 output, inverting as necessary for true result case then OR together ANDed results
  * rule of thumbs if you have more 1s than 0s in your desired output
* bit slicing. See HDLbits lesson Mux256to1v and solution 65 in this repo.
* ++ operator (allowed in loop controls, but not everywhere. 4o claimed it
  should not be used on signals that are part of the design's interface (e.g.,
  output signals) as it can lead to synthesis issues.)
* SystemVerilog's primary `always` / `assign` blocks:
  * `assign` *(outside of always blocks)*
    * When outside of an always blocks use `assign` to model simple combinational
        logic.
  * `always_comb`
    * `always_comb` and `always @(*)` are equivalent in SystemVerilog but
        `always_comb` is preferred per H&H. Use `always_comb` to model more
        complex combinational logic.
  * `always_ff`
    * `always_ff` behaves like always but is used exclusively to imply
        flipflops and may cause tools to throw warnings if anything else is
        implied. Use `always_ff @(posedge clk)` and non-blocking assignments (
        <= ) to model synchronous sequential logic.
* Linear Feedback Shift Register <https://www.youtube.com/watch?v=Ks1pw1X22y4>

## Supplemental Resources & Further Reading

### Books

[Digital Design and Computer Architecture: RISC-V Edition by David Harris and Sarah L. Harris](https://pages.hmc.edu/harris/ddca/ddcarv.html) - This book covers RISC-V but there are editions for MIPS and ARM by the same authors. They are very similar with architecture specific information differences in later parts of the book. This book covers design in both SystemVerilog and VHDL. It is widely referenced in Onur Mutlu's courses and lectures at ETH in Zurich which are streamed and archived online.

[Introduction to Computing Systems by Yale N. Patt and Sanjay J. Patel](https://www.amazon.com/Introduction-Computing-Systems-Gates-Beyond/dp/0072467509) - The other heavily referenced book in Onur Mutlu's ETH lectures. Similar to the above DDCA by H&H but they both fill in each other's gaps.

[Introduction to VLSI Systems by Lynn Conway and Carver Mead](https://www.amazon.com/Introduction-VLSI-Systems-Carver-Mead/dp/0201043580) - The book that started the Conway-Mead revolution.

[Computer Organization and Design RISC-V Edition by David A. Patterson and John L. Hennessy](https://www.amazon.com/Computer-Organization-Design-RISC-V-Architecture/dp/0128203315)

### Resources

[HDLBits course on Verilog](https://hdlbits.01xz.net/wiki/)

[tilk.ue's Verilog circuit viewer](https://digitaljs.tilk.eu/)

[IEEE Standard for SystemVerilog 1800-2009](https://www.google.com/search?q=1800-2009+pdf+-site%3Aieee.org)

[PicoRV32 - A Size-Optimized RISC-V CPU in Verilog](https://github.com/YosysHQ/picorv32) See folder 999-ReferenceMisc for a copy of this.

[Sahaj Sarup's Simple 8 Bit CPU](https://gitlab.com/ric96/ice-core/-/blob/8bit/core.v)

...and lastly [my initial softcore CPU projects](https://github.com/jwd83/88bit)