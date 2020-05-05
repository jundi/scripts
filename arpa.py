#!/bin/env python
"""Print text file lines in random order"""

import random
import argparse


def main():
    """Main function"""
    parser = argparse.ArgumentParser()
    parser.add_argument("input")
    args = parser.parse_args()
    with open(args.input, "r") as input_stream:
        lines = input_stream.readlines()

    i = 1
    while lines:
        randint = random.randint(0, len(lines)-1)
        print("{}. {}".format(str(i), lines[randint].strip()))
        lines.remove(lines[randint])
        i = i+1


if __name__ == "__main__":
    main()
