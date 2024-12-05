# my assembler for the prelude ISA (aka Overture from Turing Complete)
# take in a prelude assembly file and output a 256 byte binary file
# along with verilog LUT of the ROM image

# prelude assembly file format:
# ------------------------------
# comments begin with ;
# instructions and labels are on their own lines
# labels end with a colon


import sys

current_address = 0
labels = {}
instructions = []
rom = []


def main():
    # check if we have the correct number of arguments (1)
    if len(sys.argv) != 2:
        print("Usage: python3 assembler.py <input_file>")
        sys.exit(1)

    # check if the input file exists
    try:
        with open(sys.argv[1], "r") as f:
            rom = parse_assembly_file(f)
            write_binary_file(rom, f"{sys.argv[1]}.bin")
            write_verilog_file(rom, f"{sys.argv[1]}.sv")
    except FileNotFoundError:
        print(f"File '{sys.argv[1]}' not found")
        sys.exit(1)


def parse_assembly_file(file):
    instructions = []
    rom = [0] * 256
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
        if line[-1] == ":":
            label = line[:-1]
            # check if the label is a duplicate
            if label in labels:
                print(
                    f"ERROR: Duplicate label '{label}' at address {address} and {labels[label]}"
                )
                sys.exit(2)
            labels[label] = address
            print(f"> LABEL: '{label}' at address {address}")
        else:
            print(f"{address:03X}: {line}")
            address += 1


def write_binary_file(rom, path):
    pass


def write_verilog_file(rom, path):
    pass


if __name__ == "__main__":
    main()
