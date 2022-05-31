#!/usr/bin/env bash


JAR_PORT=$(cat commonEnv | grep ^JAR_PORT= | awk -F= '{print $2}')
DOCKER_REPO_URI=$(cat commonEnv | grep ^DOCKER_REPO_URI= | awk -F= '{print $2}')
DOCKER_USERNAME=$(cat commonEnv | grep ^DOCKER_USERNAME= | awk -F= '{print $2}')
DOCKER_PASSWD=$(cat commonEnv | grep ^DOCKER_PASSWD= | awk -F= '{print $2}')
NAME=$(cat commonEnv | grep ^NAME= | awk -F= '{print $2}')
VERSION=$(cat commonEnv | grep ^VERSION= | awk -F= '{print $2}')
PORT_MAPPING=$(cat commonEnv | grep ^PORT_MAPPING= | awk -F= '{print $2}')
VOLUME_MAPPING=$(cat commonEnv | grep ^VOLUME_MAPPING= | awk -F= '{print $2}')

#停止容器
function stopAndRmContainer() {
  KEY_WORD=$1
  echo "remove container of docker "
  CONTAINER_ID=$(docker ps -a | grep $KEY_WORD | awk '{print $1}')
  docker stop $CONTAINER_ID
  docker rm $CONTAINER_ID
}

function rmImage() {
    IMAGE_NAME=$1
    echo "remove image of docker"
    docker rmi $IMAGE_NAME
}

# 运行docker容器
function runContainer() {
  DOCKER_IMAGE=$1
  echo "pulling image ..."

  docker pull $DOCKER_IMAGE

  echo "docker run image ..."

  docker run -d --name $2 -p $3 -v $4 $DOCKER_IMAGE

  if [ $(echo $?) -eq 0 ]; then
    echo "run image of docker to repo  SUCCESS"
    return 0
  else
    echo "run image of docker to repo FAILD"
    exit 1
  fi
}



function main() {
  IMAGE_NAME_LOWERCASE=$(echo "$DOCKER_REPO_URI/$NAME:$VERSION" | tr 'A-Z' 'a-z')
  stopAndRmContainer $NAME
  rmImage $IMAGE_NAME_LOWERCASE
  runContainer $IMAGE_NAME_LOWERCASE $NAME $PORT_MAPPING $VOLUME_MAPPING
}

main
