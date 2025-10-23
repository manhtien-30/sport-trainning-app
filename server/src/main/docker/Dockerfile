# Use a JRE matching your build toolchain; adjust if you build for a different target
FROM eclipse-temurin:23-jre
ARG JAR_FILE=*.jar
COPY ${JAR_FILE} application.jar
ENTRYPOINT ["java", "-jar", "application.jar"]