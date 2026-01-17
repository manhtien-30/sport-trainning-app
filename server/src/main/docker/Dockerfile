FROM openjdk:23-jdk-slim
COPY target/server-*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]