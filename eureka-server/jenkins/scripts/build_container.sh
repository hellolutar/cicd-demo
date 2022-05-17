#!/usr/bin/env bash
DOCKER_OUTER_PORT=$(cat .env | grep ENV_EXPOSE_PORT | awk -F= '{print $2}')
DOCKER_SERVICE_ID=$(docker ps -a | grep $DOCKER_OUTER_PORT | awk {'print $1'})
DOCKER_IMAGE_NAME=$(docker ps -a | grep $DOCKER_OUTER_PORT | awk {'print $2'})

function stopAndRemoveDokcerService() {
  if [ -n "$DOCKER_SERVICE_ID" ]; then
    echo -e "service[$DOCKER_SERVICE_ID] exist, stoping... \n"
    docker stop $DOCKER_SERVICE_ID

    echo -e "service[$DOCKER_SERVICE_ID] exist, removing... \n"
    docker rm $DOCKER_SERVICE_ID

  else
    echo -e "service[$DOCKER_SERVICE_ID] not exist, skiping...\n"
  fi
}

function removeDockerImage() {
  if [ -n "$DOCKER_IMAGE_NAME" ]; then
    echo -e "image[$DOCKER_IMAGE_NAME] exist, removing... \n"
    docker rm $DOCKER_IMAGE_NAME

  else
    echo -e "image[$DOCKER_IMAGE_NAME] not exist, skiping...\n"
  fi
}

#利用docker-compose一键构建并启动docker服务
function upFunc() {
  docker-compose up -d
}

echo -e '\n============stop and remove service============\n'
stopAndRemoveDokcerService

echo -e '\n============remove image============\n'
removeDockerImage

echo -e '\n============build image and startup service============\n'
upFunc

docker-compose logs --tail="100"


