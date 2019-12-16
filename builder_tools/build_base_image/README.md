## Build and Push to Docker Hub

To build the base image:
```
$> docker build -t dieple/cloud-native-toolkit -t dieple/cloud-native-toolkit:latest .
$> docker push dieple/cloud-native-toolkit
```

## Tidy up

Prune images
```
docker image prune -a
```

Prune containers
```
docker container prune
```
