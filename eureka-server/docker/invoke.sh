#!/usr/bin/env bash

#######################################自定义变量
JAR_PORT=32000
DOCKER_REPO_URI=172.25.112.27:31001
DOCKER_USERNAME=dev_user
DOCKER_PASSWD=dev_user
NAME=$(mvn help:evaluate "-Dexpression=project.name" | grep "^[^\[]")
VERSION=$(mvn help:evaluate -Dexpression=project.version | grep "^[^\[]")
PORT_MAPPING="$JAR_PORT:$JAR_PORT"
VOLUME_MAPPING="/var/log/$NAME:/opt/app/logs"
#######################################自定义变量end

#生成Dockerfile文件
function generateDockerfile() {
  cat >>Dockerfile <- EOF
  FROM openjdk:8u332-jre
  RUN mkdir /opt/app
  ADD target/$NAME-$VERSION /opt/app/app.jar
  WORKDIR /opt/app
  CMD ["java", "-jar", "/opt/app/app.jar"]
  VOLUME /opt/app/logs
  EXPOSE $JAR_PORT
  EOF

}

function dockerLogin() {
  docker logout
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWD $DOCKER_REPO_URI
}

## 构建docker镜像
function buildImage() {
  DOCKER_IMAGE=$1
  echo "build image ..."
  docker build -t $DOCKER_IMAGE -f Dockerfile

}

## 推送docker镜像到仓库
function pushImageToRepo() {
  DOCKER_IMAGE=$1
  echo "pushing image ..."
  dockerLogin
  docker push $DOCKER_IMAGE

}

# 运行docker容器
function runContainer() {
  DOCKER_IMAGE=$1
  echo "pulling image ..."
  dockerLogin
  docker pull $DOCKER_IMAGE

  echo "docker run image ..."
  docker run $DOCKER_IMAGE --name $NAME -p $PORT_MAPPING -v $VOLUME_MAPPING
}
