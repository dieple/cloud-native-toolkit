#!/usr/bin/env bash

#set -x

PROG="`basename $0`"

usage() {
	echo ""
	echo "Usage: $PROG [options]"
	echo ""
	echo "[-v]  Image tag version"
	echo
}


check_params(){

  if [ "$BASE_IMAGE_VERSION" = "" ]; then
      echo ""
      echo "$PROG: \$VERSION not set! (e.g. 0.0.5)"
      echo ""
      usage
      exit 0
  fi
}

####
# Main
####

while getopts v:? 2> /dev/null ARG
do
	case $ARG in
		v)	BASE_IMAGE_VERSION=$OPTARG;;

		?)	usage
			exit 0;;
	esac
done

check_params


# Modify to meet your env!
# --terraformVersion=0.11.14 \
python3 ./toolkit.py \
	--terraformVersion=0.12.24 \
	--installTerraform=true \
	--cloudflareApiToken="$CLOUDFLARE_API_TOKEN" \
	--shareHostVolume="$HOME/repos" \
	--baseImageName="dieple/cloud-native-toolkit" \
	--baseImageVersion="$BASE_IMAGE_VERSION" \
	--toolkitImageName="toolkit"
