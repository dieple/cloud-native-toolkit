#!/usr/bin/env bash

PROFILE=${1:-toolkit}

usage(){
cat <<!
$(basename $0) - check to see if a column exists in an object

Usage: $(basename $0) <Profile>
!
}

check_params(){

if [ $# -ne 1 ]
then
    echo "Error: Incorrect number of arguments" >&2
    usage >&2
    exit 1
fi
}


####
# Main
####

check_params $PROFILE
echo $PROFILE

# Modify to meet your env!
# --terraformVersion=0.11.14 \
python3 ./toolkit.py \
	--terraformVersion=0.12.19 \
	--installTerraform=true \
	--dockerAppUser=$PROFILE \
	--shareHostVolume=$HOME/repos \
	--imageName=$PROFILE
