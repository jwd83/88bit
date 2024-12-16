# [88bit](https://github.com/jwd83/88bit)

Legend has it that if you can synthesize these cores to run at exactly 88 MHz, they will resonate with the fabric of time and allow your Field Programmable Gate
Array to tap into the echoes of gaming's past, conjuring a bygone era where
classic games roam free, untethered from the shackles of DRM.

...or at least this is my FPGA playground for now.
## Table of Contents
* Current & Future [Architectures](#architectures)
* [Prelude](#prelude)
  * [PASM](#pasm) - the Prelude ASseMbler

## Architectures
### In Progress
* Prelude - A single cycle 8 bit CPU inspired by the "Overture" architecture from  [Turing Complete](https://store.steampowered.com/app/1444480/Turing_Complete/).
### Future
* Great Scott! - A single cycle 8 bit CPU inspired by the "LEG" architecture from  [Turing Complete](https://store.steampowered.com/app/1444480/Turing_Complete/), which was in turn inspired by the real world ARM architecture.
* ShinyRock16 - A completely bespoke 16 bit CPU supporting variable length instructions that I originally designed in the game "Turing Complete"
* Marty - A simple as possible single cycle RISC-V 32 bit (RV32I compliant as possible) core
* TBD - Multi cycle 8 bit CPU
* McFly - Multi cycle RISC-V RV32I CPU
* Seymour - SIMD vector unit

# Prelude
```
        ##### ##                       ###                     ##
     ######  /###                       ###                     ##
    /#   /  /  ###                       ##                     ##
   /    /  /    ###                      ##                     ##
       /  /      ##                      ##                     ##
      ## ##      ## ###  /###     /##    ##  ##   ####      ### ##    /##
      ## ##      ##  ###/ #### / / ###   ##   ##    ###  / ######### / ###
    /### ##      /    ##   ###/ /   ###  ##   ##     ###/ ##   #### /   ###
   / ### ##     /     ##       ##    ### ##   ##      ##  ##    ## ##    ###
      ## ######/      ##       ########  ##   ##      ##  ##    ## ########
      ## ######       ##       #######   ##   ##      ##  ##    ## #######
      ## ##           ##       ##        ##   ##      ##  ##    ## ##
      ## ##           ##       ####    / ##   ##      /#  ##    /# ####    /
      ## ##           ###       ######/  ### / ######/ ##  ####/    ######/
 ##   ## ##            ###       #####    ##/   #####   ##  ###      #####
###   #  /
 ###    /           Prelude
  #####/            ... A tribute to "Overture"
    ###
```

Inspired by Overture from the game Turing Complete
* 8 bit single cycle processor
* 8 bit instruction words
* 6 general purpose registers (r0-r5)
* 1 i/o register (r6/rio)
* 1 program counter (pc) register
* 256 bytes of program ROM

## Instruction Types

upper 2 bits|instruction type
-|-
00zzzzzz|IMMEDIATE (load lower bits into r0)
01zzzzzz|CALCULATE (see calc ops)
10zzzzzz|COPY (see copy ops)
11zzzzzz|BRANCH

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

## PASM
### the Prelude ASseMbler

See [`./prelude/pasm/pasm.py`](prelude/pasm/pasm.py)

I have written an assembler for Prelude that generates three output targets - a raw binary file, a Turing Complete compatible .txt file and a SystemVerilog Look-Up-Table (LUT)

As of 12/12/2024 all turing complete Overture levels have had solutions assembled and tested in game.

The guide will help you use the Prelude Assembler to convert your Prelude assembly files into binary, Verilog, and Turing Complete ROM images.

## Prerequisites

- Python 3.x installed on your system
- Basic knowledge of Prelude assembly language

## Usage

1. **Prepare your assembly file**: Create a text file with your Prelude assembly code. Ensure the file follows the format described below.

2. **Run the assembler**: Use the following command to run the assembler:
    ```sh
    python3 pasm.py <input_file>
    ```
    Replace `<input_file>` with the path to your assembly file.

3. **Output files**: The assembler will generate three output files in the same directory as your input file:
    - `<input_file>.bin`: Binary file
    - `<input_file>.sv`: Verilog file
    - `<input_file>.txt`: Turing Complete ROM image

## Assembly File Format

- **Labels**: End with a colon (`:`) and are used to mark addresses.
- **Instructions**: Case insensitive and must be on their own lines.
- **Constants**: Defined using the `CONST` directive (e.g., `CONST MYCONST 42`).
- **Comments**: Begin with a semicolon (`;`) and can be placed at the end of a line.

### Example

```
; full line comment
const five 5
const THREE 3 ; in-line comment

start:
    LOAD five       ; load 5 into R0
    COPY     R0 R1  ; R1 = R0 (5)
    LOAD tHrEe      ; load THREE into R0
    COPY    R0  R2  ; R2 = R0 (3)

add_more:
    ADD             ; R3 = R1 + R2
    COPY R3 RIO     ; RIO = R3
    COPY R3 R1      ; R1 = R3
    LOAD add_more   ; load add_more into R0
    BRA             ; branch always to address in R0
```

## Notes

- The assembler will prompt you to overwrite existing output files if they already exist.
- Ensure that immediate values for the `LOAD` instruction are within the range 0-63.

For more information, visit the [GitHub repository](https://github.com/jwd83/88bit).

## Appendix: Full List of Instructions

### Load Instructions
- `LOAD <immediate>`: Load an immediate value into R0 (0-63).

### ALU Instructions
- `OR`: R3 = R1 OR R2
- `NAND`: R3 = R1 NAND R2
- `NOR`: R3 = R1 NOR R2
- `AND`: R3 = R1 AND R2
- `ADD`: R3 = R1 + R2
- `SUB`: R3 = R1 - R2
- `XOR`: R3 = R1 XOR R2
- `SHL`: R3 = R1 << R2

### Register Copy Instructions
- `COPY <src> <dst>`: Copy the value from the source register to the destination register.

### Branch Instructions
- `BRN`: Branch never (NOP)
- `NOP`: No operation (alias for BRN)
- `BZ`: Branch if R3 == 0
- `BLT`: Branch if R3 < 0 (signed)
- `BLE`: Branch if R3 <= 0 (signed)
- `BRA`: Branch always
- `BNZ`: Branch if R3 != 0
- `BGE`: Branch if R3 >= 0 (signed)
- `BGT`: Branch if R3 > 0 (signed)

### Jump Aliases
- `JZ`: Jump if R3 == 0
- `JLT`: Jump if R3 < 0 (signed)
- `JLE`: Jump if R3 <= 0 (signed)
- `JUMP`: Jump always (alias for BRA)
- `JMP`: Jump always (alias for BRA)
- `JNZ`: Jump if R3 != 0
- `JGE`: Jump if R3 >= 0 (signed)
- `JGT`: Jump if R3 > 0 (signed)