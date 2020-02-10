#!/usr/bin/env bash

#set -x
PROG="`basename $0`"


usage() {
	echo ""
	echo "Usage: $PROG [options]"
	echo ""
	echo "[-u]  Docker hub user id"
	echo "[-v]  Image tag version"
	echo
}


check_params(){

  if [ "$USERID" = "" ]; then
    echo ""
    echo "$PROG: \$USERID not set! (e.g. dockerhub user: dieple)"
    echo ""
    usage
    exit 0
	fi

	if [ "$VERSION" = "" ]; then
		echo ""
		echo "$PROG: \$VERSION not set! (e.g. image tag version: 0.0.1)"
		echo ""
		usage
		exit 0
	fi
}

####
# Main
####

while getopts u:v:? 2> /dev/null ARG
do
	case $ARG in
		u)	USERID=$OPTARG;;

		v)	VERSION=$OPTARG;;

		?)	usage
			exit 0;;
	esac
done

check_params

docker build -t ${USERID}/cloud-native-toolkit:${VERSION} .
docker tag ${USERID}/cloud-native-toolkit:${VERSION} ${USERID}/cloud-native-toolkit:latest
docker push ${USERID}/cloud-native-toolkit:${VERSION}
docker push ${USERID}/cloud-native-toolkit:latest
