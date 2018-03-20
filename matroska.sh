#!/bin/bash


# variables
CRF="18"
AUDIOQUALITY="2"
FRAMERATE="29.97"
ASPECT=""
PRESET="slower" #ultrafast,superfast,veryfast,faster,fast,medium,slow,slower,veryslow,placebo
SAMPLERATE="48000"
SETTINGS=""
#SETTINGS="-vf yadif"
ASK="y"
NICE=18



# constants
ERROR="Error: Something wrong with parameters."
HELP=" Usage: file [OPTIONS]
-c, --bitrate        (default: $CRF)
-q, --audioquality   (default: $AUDIOQUALITY)
-p, --preset, --vpre (default: $PRESET)
-a, --aspect         (default: auto)
-r, --framerate      (default: $FRAMERATE)
-s, --settings       (default: )
-o, --out            (default: current dir)
-n, --nice           (default: $NICE)"



# help
if [ -z $1 ] || [ $1 = "-h" ] || [ $1 = "--help" ]; then
  echo "$HELP"
  exit 0
fi



# file in/out
DIR=""
FILE=""
OUTDIR=""
NAME=""
OUTFILE=""



# check parameters
while [ $# -gt 0 ]; do    
  case "$1" in
    -c|--crf)
      CRF="$2"
      shift
      ;;
    -q|--audioquality)
      AUDIOQUALITY="$2"
      shift
      ;;
    -p|--preset|--vpre)
      PRESET="$2"
      shift
      ;;
    -a|--aspect)
      ASPECT="-aspect $2"
      shift
      ;;
    -r|--framerate)
      FRAMERATE="$2"
      shift
      ;;
    -s|--settings)
      SETTINGS="$2"
      shift
      ;;
    -o|--out)
      if [ -d $2 ]; then
        OUTDIR="$2"
      else
        OUTDIR="$(dirname $2)"
        OUTFILE="$(basename $2)"
      fi
      shift
      ;;
    -n|--nice)
      NICE="$2"
      shift
      ;;
    -s|--silent)
      ASK=""
      ;;
    -h|--help)
      echo "$HELP"
      exit 0
      ;;
    *)
      if [[ -f $1 ]]; then
        INPUT=$1
      else
        echo "$ERROR"
        exit 1
      fi
  esac
  shift
done

if [[ -z "$INPUT" ]]; then
  echo $ERROR
  exit 1
fi



# file in/out
DIR="$(dirname $INPUT)"
FILE="$(basename $INPUT)"
NAME="$(echo "$FILE" | cut -f1 -d.)"

if [[ -z $OUTDIR ]]; then
  OUTDIR="$(pwd)"
fi

if [[ -z $OUTFILE ]]; then
  OUTFILE="$NAME.mkv"
fi



# print parameters
echo "$0: CRF = $CRF"
echo "$0: AUDIOQUALITY = $AUDIOQUALITY"
echo "$0: ASPECT = $ASPECT"
echo "$0: PRESET = $PRESET"
echo "$0: DIR = $DIR"
echo "$0: FILE = $FILE"
echo "$0: OUTDIR = $OUTDIR"
echo "$0: NAME = $NAME"
echo "$0: OUTFILE = $OUTFILE"
echo ""



# print ffmpeg commands
COMMAND="nice -n $NICE ffmpeg -async 1 -i $INPUT -c:a libvorbis -aq $AUDIOQUALITY -ar $SAMPLERATE -c:v libx264 -preset $PRESET -crf $CRF -r $FRAMERATE $ASPECT $SETTINGS -threads 0 $OUTDIR/$OUTFILE"

echo $COMMAND
echo ""



# ok?
if [[ $ASK == y ]]; then
  echo "Start encoding? [y/n]"
  read confirm
else
  confirm="y"
fi


# start encoding
case $confirm in
  y|Y|yes|Yes|YES) 
    $COMMAND
    ;;
esac
