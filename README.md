Legend has it that if you can synthesize this core to run at exactly 88 MHz, it
can resonate with the fabric of time and allow your Field Programmable Gate
Array to tap into the echoes of gaming's past, conjuring a bygone era where
classic games roam free, untethered from the shackles of DRM.

...or at least my FPGA playground for now.


TODO:

* Prelude - A single cycle 8 bit CPU based around overture from turing complete
* Single cycle 8 bit CPU based around leg from turing complete
* Multi cycle 8 bit CPU
* Multi cycle RISC-V RV32I CPU


# Prelude (Overture)
8 bit single cycle processor
8 bit instruction words
6 general purpose registers (r0-r5)
1 i/o register (r6/rio)
1 program counter (pc) register
256 bytes of program ROM

## Instruction Types
00 - IMMEDIATE (load lower bits into r0)
01 - CALCULATE (see calc ops)
10 - COPY (see copy ops)
11 - BRANCH

### 00 - IMMEDIATE
Set R0 = lower 6 bit of instruction

### 01 - CALCULATE
Lower 6 bits specify ALU operation. R3 = R1 (calc op) R2

#### CALCUATE Ops
ALU Operation Bits|Operation|Notes
-|-|-
000000|OR|R3 = R1 or R2
000001|NAND|R3 = ~(R1 and R2)
000010|NOR|R3 = ~(R1 or R2)
000011|AND|R3 = R1 and R2
000100|ADD|R3 = R1 + R2
000101|SUB|R3 = R1 - R2
000110|XOR|R3 = R1 ^ R2, Prelude specific

### 10 - COPY
Copy instructions use the lower 6 bits to specify source and destination registers.

Register Address|Register Name|Description
-|-|-
000|R0|IMMEDIATE destination, BRANCH destination
001|R1|CALCUATE source 1
010|R2|CALCUATE source 2
011|R3|CALCUATE destination, BRANCH comparison value
100|R4|General purpose
101|R5|General purpose
110|R6|General purpose
111|R7|Special I/O register

### 11 - BRANCH
Condition bits|Condition|Notes
-|-|-
000|Never|No op, never take branch
001|R3 ==  0
010|R3 < 0
011|R3 <= 0
100|Always
101|R3 != 0
110|R3 >= 0
111|R3 > 0
