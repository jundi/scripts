#/bin/bash
msg=$(transmission-remote -a "$1")
notify-send -t 6000 "$msg"
msg=$(transmission-remote -l | tail -n2 | head -n1)
notify-send -t 6000 "$msg"
