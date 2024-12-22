# limb assembler is a simple assembler for the limb architecture
# by default it assembles rom.s to rom.sv

import sys
import os


def help():
    print("limb assembler")
    print("-" * 80)
    print("limb assembler is a simple assembler for the limb architecture")
    print("by default it assembles rom.s to rom.sv and rom.txt")
    print("\nOptions:")
    print("-h, --help, help\t\t\tDisplay this help message")
    print("\nOptional Arguments:")
    print("input file\t\t\tThe file to assemble. Defaults to rom.s")
    print("output file\t\t\tThe assembled file. Defaults to rom.sv")

    print("\nUsage:")
    print("python lasm.py [input file] [output file]")
    pass


def main():
    # default to rom.s and rom.sv
    in_file = "rom.s"
    out_file = "rom.sv"

    # check if we received any arguments.
    if len(sys.argv) > 1:
        if sys.argv[1] == "-h" or sys.argv[1] == "--help" or sys.argv[1] == "help":
            help()
            return
        in_file = sys.argv[1]
        if len(sys.argv) > 2:
            out_file = sys.argv[2]

    if len(sys.argv) > 3:
        print("Usage: lasm.py [input file] [output file]")
        return


if __name__ == "__main__":
    main()
