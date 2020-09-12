#!/bin/bash

REMOTEURL="https://cloud.woelkli.com/"
NEXTCLOUDDIR="/mnt/manu/home/kuvat/nextcloud"
REMOTEPHOTODIR="/"
LOCALPHOTODIR="/mnt/manu/home/valokuvat"
USER=$1
PASSWORD=$2

stdout=$(nextcloudcmd --user $USER --password $PASSWORD $NEXTCLOUDDIR $REMOTEURL 2>&1)
if [[ $? != 0 ]]; then
	echo $stdout
else
	/usr/bin/vendor_perl/exiftool '-Directory<CreateDate' -d "${LOCALPHOTODIR}/%Y/%m/%d" -r "${NEXTCLOUDDIR}${REMOTEPHOTODIR}" > /dev/null
fi
