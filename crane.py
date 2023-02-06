#!/usr/bin/env python3
import subprocess
import sys


def italic(string: str) -> str:
    return "\x1b[3m" + string + "\x1b[0m"


def success(string: str) -> str:
    return "\x1b[32m" + string + "\x1b[0m"


def execute_script(file: str, sudo=True):
    print(f"{file}: Running...", end="")
    sys.stdout.flush()

    if not sudo:
        subprocess.check_call([file], shell=True, stdout=None)
    else:
        subprocess.check_call(["sudo", file], shell=True, stdout=None)

    print("\r{}: {}   ".format(file, success("Success")))


def get_options() -> dict:
    devel = True
    desktop = True
    print(
        "Steps:\n\
        {}\t-- Install and configure development software\n\
        {}\t-- Install and configure a desktop interface".format(
            italic("devel"), italic("desktop")
        )
    )

    omit = input("Enter a space-separated list of steps to omit: ").split(" ")

    if len(omit) != 0:
        for ommitted in omit:
            if ommitted == "devel":
                devel = False
            elif ommitted == "desktop":
                desktop = False

    return {"Devel": devel, "Desktop": desktop}


def run(steps: dict):
    # The base setup will always run
    execute_script("src/setup_base.sh")

    if steps.get("Devel"):
        execute_script("src/setup_devel.sh")
    if steps.get("Desktop"):
        execute_script("src/setup_desktop.sh", sudo=False)


options = get_options()
if input("Are you sure you want to continue [y/N]: ") == "y":
    run(options)
