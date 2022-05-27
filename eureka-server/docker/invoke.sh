#!/usr/bin/env bash

NAME=` mvn  help:evaluate "-Dexpression=project.name" | grep "^[^\[]"`
VERSION=` mvn  help:evaluate -Dexpression=project.version | grep "^[^\[]"`


#生成Dockerfile文件
function generateDockerfile() {
  JAR_NAME=$1

cat >> docker/Dockerfile <- EOF
FROM openjdk:8u332-jre
RUN mkdir /opt/app
ADD target/$JAR_NAME /opt/app/app.jar
WORKDIR /opt/app
CMD ["java", "-jar", "/opt/app/app.jar"]
VOLUME /opt/app/logs
EXPOSE 32000
EOF

}

## 构建docker镜像
function buildImage() {
   echo "bui image ..."
    DOCKER_DIR=$1
    if [ -z "$DOCKER_DIR" ]; then
        echo "buildImage() param1 DOCKER_DIR is empty!"
        return 1;
    fi

}

## 推送docker镜像到仓库
function pushImageToRepo() {
    echo "pushing image ..."

}

function runContainer() {
    echo "pulling image ..."


}




