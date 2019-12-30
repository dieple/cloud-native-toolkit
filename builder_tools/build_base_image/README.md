## Build and Push to Docker Hub

To build the base imageand push to dockerhub
```
$> ./build_image.sh <dockerhub_userid> <image_tag_version>
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
