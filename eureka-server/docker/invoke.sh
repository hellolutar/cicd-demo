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
  cat >docker/Dockerfile <<EOF
FROM openjdk:8u332-jre
RUN mkdir /opt/app
ADD target/$NAME-$VERSION.jar /opt/app/app.jar
WORKDIR /opt/app
CMD ["java", "-jar", "/opt/app/app.jar"]
VOLUME /opt/app/logs
EXPOSE $JAR_PORT
EOF

  if [ -f "docker/Dockerfile" ]; then
    echo "create Dockerfile SUCCESS"
  else
    echo "create Dockerfile FAILD"
  fi

}

function dockerLogin() {
  docker logout
  docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWD $DOCKER_REPO_URI

  if [ $(echo $?) -gt 0 ]; then
    echo "docker login SUCCESS"
    return 0
  else
    echo "docker login FAILD"
    exit 1
  fi
}

## 构建docker镜像
function buildImage() {
  DOCKER_IMAGE=$1
  echo "build image ..."
  docker build -t $DOCKER_IMAGE -f docker/Dockerfile

  if [ $(echo $?) -eq 0 ]; then
    echo "build docker image SUCCESS"
    return 0
  else
    echo "build docker image FAILD"
    exit 1
  fi
}

## 推送docker镜像到仓库
function pushImageToRepo() {
  DOCKER_IMAGE=$1
  echo "pushing image ..."

  docker push $DOCKER_IMAGE

  if [ $(echo $?) -eq 0 ]; then
    echo "push image of docker to repo  SUCCESS"
    return 0
  else
    echo "push image of docker to repo FAILD"
    exit 1
  fi

}

# 运行docker容器
function runContainer() {
  DOCKER_IMAGE=$1
  echo "pulling image ..."

  docker pull $DOCKER_IMAGE

  echo "docker run image ..."
  docker run $DOCKER_IMAGE --name $NAME -p $PORT_MAPPING -v $VOLUME_MAPPING

  if [ $(echo $?) -eq 0 ]; then
    echo "run image of docker to repo  SUCCESS"
    return 0
  else
    echo "run image of docker to repo FAILD"
    exit 1
  fi
}

function main() {
  generateDockerfile
  dockerLogin
  buildImage $NAME-$VERSION
  pushImageToRepo $NAME-$VERSION
  runContainer $NAME-$VERSION
}

main
