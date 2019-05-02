#!/bin/bash

PHOTODIR=$HOME/valokuvat
GOOGLEROOTDIR=$HOME/kuvat/grive
GOOGLEPHOTODIR=$HOME"/kuvat/grive/Google Photos"

stdout=$(grive -p "${GOOGLEROOTDIR}" 2>&1)
if [[ $? != 0 ]]; then
	echo $stdout
else
	/usr/bin/vendor_perl/exiftool '-Directory<CreateDate' -d "${PHOTODIR}/%Y/%m/%d" -r "${GOOGLEPHOTODIR}" > /dev/null
fi
