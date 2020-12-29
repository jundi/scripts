#!/bin/bash
set -e
#
# pacman like wrapper script for yum, repoquery, rpm, etc.
#

usage="\n
Usage: \n
\t$(basename $0) [OPTION...] [PACKAGE1,PACKAGE2,...] \n
\n
Example: \n
\t$(basename $0) -Qs vim \n
\n
Options: \n
\t-Qs \t search installed packages\n
\t-Ql \t list files provieded by installed package\n
\t-Qo \t find package that owns a file\n
\t-Ss \t search packages\n
\n
"
if [[ $# -lt 1 ]]; then
    echo "Not enough input parameteres."
    exit 1
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    -Qs)
	if  [[ $# -gt 2 ]]; then
	    echo -e $usage
	    exit 3
	else
	    yum list installed | grep $2
	    exit 0
	fi
      ;;
    -Ql)
	if  [[ $# -gt 2 ]]; then
	    echo -e $usage
	    exit 3
	else
	    repoquery -l --installed $2
	    exit 0
	fi
      ;;
    -Qo)
	if  [[ $# -gt 2 ]]; then
	    echo -e $usage
	    exit 3
	else
	    yum provides `realpath $2`
	    exit 0
	fi
      ;;
    -Ss)
	if  [[ $# -gt 2 ]]; then
	    echo -e $usage
	    exit 3
	else
	    yum search  $2
	    exit 0
	fi
      shift
      ;;
    *)
      echo -e $usage
      exit 2
      ;;
  esac
  shift
done

# vim: ft=sh:sw=4
