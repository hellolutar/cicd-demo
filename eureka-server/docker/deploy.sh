#!/usr/bin/env bash

#停止容器
function stopAndRmContainer() {
  KEY_WORD=$1
  echo "remove image of docker "
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
  #todo 20220530 这里要做更改
  docker run -d --name $NAME -p $PORT_MAPPING -v $VOLUME_MAPPING $DOCKER_IMAGE

  if [ $(echo $?) -eq 0 ]; then
    echo "run image of docker to repo  SUCCESS"
    return 0
  else
    echo "run image of docker to repo FAILD"
    exit 1
  fi
}



function main() {
  stopAndRmContainer
}

main
