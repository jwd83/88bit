import os


def rename_sv_files():
    for filename in os.listdir("."):
        if filename.endswith(".sv") and not filename.startswith("00"):
            new_name = "0" + filename
            os.rename(filename, new_name)


def main():
    rename_sv_files()


if __name__ == "__main__":
    main()
