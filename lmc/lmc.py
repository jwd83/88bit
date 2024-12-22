# a simulated "little man computer" (LMC) written in Python
# https://en.wikipedia.org/wiki/Little_man_computer


import sys
import os


def help():

    pass


def main():

    src = "program.s"

    if len(sys.argv) > 1:
        arg1 = sys.argv[1].lower()
        if arg1 == "-h" or arg1 == "--help" or arg1 == "help":
            help()
            return
        src = sys.argv[1]

    mailboxes = [0] * 999


if __name__ == "__main__":

    main()
