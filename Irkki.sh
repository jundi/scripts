#/bin/bash
skriini=`screen -ls | grep "\.irk"`
if [ -z "$skriini" ]; then
  screen -dmS irk weechat-curses
fi
