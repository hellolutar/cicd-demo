FROM adoptopenjdk/openjdk8:ubi
RUN mkdir /opt/app
ENV JAR_NAME=$(ll target | grep *.jar)
ADD target/$JAR_NAME /opt/app/app.jar
WORKDIR /opt/app
CMD ["java", "-jar", "/opt/app/app.jar"]
VOLUME /opt/app
EXPOSE 32000
