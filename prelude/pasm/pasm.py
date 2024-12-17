# my assembler for the prelude ISA (aka Overture from Turing Complete)
# take in a prelude assembly file and output a 256 byte binary file
# along with verilog LUT of the ROM image

# prelude assembly file format:
# ------------------------------
# every line of code is either a label, instruction or constant. it may optionally include a comment
# comments begin with ;
# instructions, labels and constants are on their own lines
# labels end with a colon
# code is case INSENSITIVE
# constants are in the format CONST <label> <value> (for example: CONST MYCONST 42)
#
# TODO: Helper function to detect line types


import sys
import os


def main():
    # check if we have the correct number of arguments (1)
    if len(sys.argv) != 2:
        print("Usage: python3 pasm.py <input_file>")
        sys.exit(1)

    # check if the input file exists
    try:
        with open(sys.argv[1], "r") as f:
            rom = parse_assembly_file(f)
            write_binary_file(rom, f"{sys.argv[1]}.bin")
            write_verilog_file(rom, f"{sys.argv[1]}.sv")
            write_turing_complete_file(rom, f"{sys.argv[1]}.tc.txt")
            write_program_rom(rom, f"{sys.argv[1]}.rom.txt")
    except FileNotFoundError:
        print(f"File '{sys.argv[1]}' not found")
        sys.exit(1)


def parse_assembly_file(file):
    rom = []
    labels_and_constants = {}

    lines = file.readlines()
    cleaned_lines = []

    print("Reading assembly file listing...")
    print("-" * 80)

    # remove comments and empty lines
    for line in lines:
        print(line.strip())

        # remove comments and white space
        # comments begin with ;
        line = line.split(";")[0].strip()

        # replace tabs with a single space
        line = line.replace("\t", " ")

        # replace all whitespace with a single space
        line = " ".join(line.split())

        # uppercase everything for consistency
        line = line.upper()

        # only add lines that still have content
        if line:
            cleaned_lines.append(line)

    print("-" * 80)
    print("Cleaned assembly listing...")
    print("-" * 80)

    for line in cleaned_lines:
        print(line)

    # next pass: find all labels

    print("-" * 80)
    print("Finding labels and calculating addresses ...")
    print("-" * 80)

    address = 0

    for line in cleaned_lines:
        # check for labels
        if line[-1] == ":":
            label = line[:-1]
            # check if the label is a duplicate
            if label in labels_and_constants:
                print(
                    f"ERROR: Duplicate label '{label}' at address {address} and {labels_and_constants[label]}"
                )
                sys.exit(2)
            labels_and_constants[label] = address
            print(f"> LABEL: '{label}' at address {address}")
        else:
            # check for constants
            if line.split(" ")[0] == "CONST":
                tokens = line.split(" ")
                if len(tokens) != 3:
                    print(f"ERROR: CONST directive requires two tokens")
                    sys.exit(2)
                labels_and_constants[tokens[1]] = int(tokens[2])
                print(f"> CONSTANT: '{tokens[1]}' with value {int(tokens[2])}")
            else:
                # otherwise increment the address
                print(f"{address:03X}: {line}")
                address += 1

    print("-" * 80)
    print("Generating instructions ...")
    print("-" * 80)

    register_names = {
        "R0": "000",
        "R1": "001",
        "R2": "010",
        "R3": "011",
        "R4": "100",
        "R5": "101",
        "R6": "110",
        "R7": "111",
        # register alias names
        "RIO": "110",
    }

    base_opcodes = {
        # load IMMEDIATE
        "LOAD": "00000000",
        # ALU calculate
        "OR": "01000000",
        "NAND": "01000001",
        "NOR": "01000010",
        "AND": "01000011",
        "ADD": "01000100",
        "SUB": "01000101",
        "XOR": "01000110",
        "SHL": "01000111",
        # register COPY
        "COPY": "10000000",
        # BRANCH
        # 000|Never|No op, never take branch
        # 001|R3 ==  0
        # 010|R3 < 0|signed
        # 011|R3 <= 0|signed
        # 100|Always
        # 101|R3 != 0
        # 110|R3 >= 0|signed
        # 111|R3 > 0|signed
        "BRN": "11000000",  # branch never (nop)
        "NOP": "11000000",  # branch never (nop alias)
        # branch instructions
        "BZ": "11000001",  # branch if equal zero
        "BLT": "11000010",  # branch if less than zero (signed)
        "BLE": "11000011",  # branch if less than or equal to zero (signed)
        "BRA": "11000100",  # branch always
        "BNZ": "11000101",  # branch if not equal zero
        "BGE": "11000110",  # branch if greater than or equal to zero (signed)
        "BGT": "11000111",  # branch if greater than zero (signed)
        # jump aliases
        "JZ": "11000001",  # branch if equal zero
        "JLT": "11000010",  # branch if less than zero (signed)
        "JLE": "11000011",  # branch if less than or equal to zero (signed)
        "JUMP": "11000100",  # branch always (alias)
        "JMP": "11000100",  # branch always (alias)
        "JNZ": "11000101",  # branch if not equal zero
        "JGE": "11000110",  # branch if greater than or equal to zero (signed)
        "JGT": "11000111",  # branch if greater than zero (signed)
    }

    address = 0
    for line in cleaned_lines:
        # split the line into tokens
        tokens = line.split(" ")

        # if a line is a label ignore it for this pass
        if line[-1] == ":":
            print(f"> LABEL: '{label}' at address {address}")

            continue
        elif tokens[0] == "CONST":
            # if a line is a constant ignore it for this pass

            print(f"> CONSTANT: '{tokens[1]}' with value {int(tokens[2])}")
            continue
        else:

            # determine opcode or exit if invalid
            if tokens[0] not in base_opcodes:
                print(f"ERROR: Invalid opcode '{tokens[0]}'")
                sys.exit(3)

            # get the base opcode
            opcode = base_opcodes[tokens[0]]

            # special logic for load and copy instructions

            if tokens[0] == "LOAD":
                # check for two tokens
                if len(tokens) != 2:
                    print(f"ERROR: LOAD instruction requires immediate value")
                    sys.exit(4)

                # check if the immediate value is a label
                if tokens[1] in labels_and_constants:
                    immediate = labels_and_constants[tokens[1]]
                else:
                    try:
                        immediate = int(tokens[1])
                    except ValueError:
                        print(f"ERROR: Invalid immediate value '{tokens[1]}'")
                        sys.exit(5)

                if immediate > 63 or immediate < 0:
                    print(f"ERROR: Immediate value '{immediate}' out of range")
                    sys.exit(6)

                # convert the immediate value to an 8 bit binary string
                immediate = format(immediate, "08b")
                opcode = immediate

            if tokens[0] == "COPY":
                # check for three tokens
                if len(tokens) != 3:
                    print(f"ERROR: COPY instruction requires two registers")
                    sys.exit(7)

                # copy instruction
                # copy mode
                # |   src
                # |   |   dst
                # |   |   |
                # 10 xxx yyy

                # check if source and destination are valid registers
                if tokens[1] not in register_names or tokens[2] not in register_names:
                    print(f"ERROR: Invalid registers named in COPY instruction")
                    sys.exit(8)

                opcode = "10" + register_names[tokens[1]] + register_names[tokens[2]]

            rom.append(opcode)

            print(f"{address:03X}:{opcode}:{line}")

            address += 1

    print("-" * 80)
    print("ROM Image")
    print("-" * 80)
    for instruction in rom:
        print(instruction)

    return rom


def write_binary_file(rom, path):
    # check if file already exists, if so prompt to overwrite
    # if not, write the binary file
    if os.path.exists(path):
        print(f"File '{path}' already exists. Overwrite? [y/n]")
        response = input()
        if response.lower() != "y":
            print("Skipping...")
            return
        else:
            # delete the existing file
            os.remove(path)

    with open(path, "wb") as f:
        for instruction in rom:
            f.write(bytes([int(instruction, 2)]))

    print(f"Binary file written to '{path}'")


def write_verilog_file(rom, path):
    # check if file already exists, if so prompt to overwrite
    # if not, write the binary file
    if os.path.exists(path):
        print(f"File '{path}' already exists. Overwrite? [y/n]")
        response = input()
        if response.lower() != "y":
            print("Skipping...")
            return
        else:
            # delete the existing file
            os.remove(path)

    with open(path, "w") as f:
        f.write(
            """
module rom (
    input logic [7:0] address,
    output logic [7:0] data
);

    always_comb begin
        case (address)
"""
        )

        address = 0
        for instruction in rom:
            f.write(" " * 12 + f"8'h{address:02X}: data = 8'b{instruction};\n")

            address += 1

        f.write(
            """
            default: data = 8'b00000000;
        endcase
    end
endmodule
"""
        )


def write_program_rom(rom, path):
    # check if file already exists, if so prompt to overwrite
    # if not, write the binary file
    if os.path.exists(path):
        print(f"File '{path}' already exists. Overwrite? [y/n]")
        response = input()
        if response.lower() != "y":
            print("Skipping...")
            return
        else:
            # delete the existing file
            os.remove(path)

    with open(path, "w") as f:
        f.write("\n".join(rom))

    print(f"Program ROM file written to '{path}'")


def write_turing_complete_file(rom, path):
    # check if file already exists, if so prompt to overwrite
    # if not, write the binary file
    if os.path.exists(path):
        print(f"File '{path}' already exists. Overwrite? [y/n]")
        response = input()
        if response.lower() != "y":
            print("Skipping...")
            return
        else:
            # delete the existing file
            os.remove(path)

    with open(path, "w") as f:
        f.write("# Generated by the Prelude Assembler\n")
        f.write("# https://github.com/jwd83/88bit\n")
        f.write("# ----------------------------------\n")
        for instruction in rom:
            f.write(f"0b{instruction}\n")

    print(f"Turing complete file written to '{path}'")


if __name__ == "__main__":
    main()
