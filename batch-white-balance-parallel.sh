#!/bin/bash
#
# Give filenames as parameters, and the script will auto-whitebalance them
# using gimp batch-white-balance function. Suffix "-avb" is added to each
# result filename, for example:
#
#   IMG0123.jpg -> IMG0123-avb.jpg
#
# GNU parallel (the sem command) is used for running gimp in parallel. The
# batch-white-balance script must be installed to GIMP script directory:
# ~/.gimp-2.8/scripts/batch-white-balance.scm
#

# Number of parallel jobs
JOBS=4

while [ $# -gt 0 ]; do

  # new filename
  fname=$(echo "$1" | cut -d. -f1)
  ftype=$(echo "$1" | cut -d. -f2)
  newfile=$fname-avb.$ftype

  # dublicate file
  cp $1 $newfile

  # batch command 
  batchcmd="'(batch-white-balance \"$newfile\")'"
  # quit gimp
  quitcmd="'(gimp-quit 0)'"

  # print whats happening
  echo "sem -j 4 gimp -i -b $batchcmd -b $quitcmd"

  # run batch commands parallel
  sem -j 4 gimp -i -b "$batchcmd" -b "$quitcmd"

  # next file
  shift

done

echo ""
echo ""
echo "All done!"
