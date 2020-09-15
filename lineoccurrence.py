"""Count occurrence of lines in file"""

import sys


def main():
    """Print occurrence of each different line in file."""
    input_file = sys.argv[1]

    with open(input_file) as file_:
        occurrences = {}
        for line in file_:
            line = line.strip()
            if line in occurrences:
                occurrences[line] += 1
            else:
                occurrences[line] = 1

    for word, occurrence in sorted(occurrences.items(),
                                   key=lambda x: x[1],
                                   reverse=True):
        print("{}: {}".format(word, occurrence))


if __name__ == "__main__":
    main()
