USERID=${1:-dieple}
VERSION=${2:-v0.0.1}

docker build -t ${USERID}/cloud-native-toolkit:${VERSION} -t ${USERID}/cloud-native-toolkit:latest .
docker push ${USERID}/cloud-native-toolkit:${VERSION}
docker push ${USERID}/cloud-native-toolkit:latest
