FROM adoptopenjdk/openjdk8:ubi
RUN mkdir /opt/app
ENV JAR_NAME=eureka-server-0.0.1-SNAPSHOT.jar
ADD target/$JAR_NAME /opt/app/app.jar
WORKDIR /opt/app
CMD ["java", "-jar", "/opt/app/app.jar"]
VOLUME /opt/app
EXPOSE 32000
