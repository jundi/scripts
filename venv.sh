#!/bin/bash

VENV_HOME=~/.venv
DEFAULT_PACKAGES="pip pytest"

original_pwd=$PWD

while [[ $PWD != "/" ]]; do

	venv=$VENV_HOME/$PWD

	if [[ -d $venv ]]; then
		echo "Found virtualenv in $PWD"
		source $venv/bin/activate
		break
	fi

	cd ..
done

cd $original_pwd

if [[ -z "$VIRTUAL_ENV" ]]; then
	cd $original_pwd
	venv=$VENV_HOME/$PWD
	read -p "Create new virtualenv for $PWD? [Y/n]: " answer
	answer=${answer:-Y}

	case $answer in y|Y|yes|Yes)
		echo "Creating new virtualenv in $PWD"
		virtualenv $venv
		source $venv/bin/activate
		pip install $DEFAULT_PACKAGES --upgrade
		;;

		*)
		echo "Virtualenv not created"
	esac
fi
