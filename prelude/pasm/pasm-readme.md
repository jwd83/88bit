# Prelude Assembler Guide

This guide will help you use the Prelude Assembler to convert your Prelude assembly files into binary, Verilog, and Turing Complete ROM images.

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

```