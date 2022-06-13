FROM maven:3-openjdk-11 as build

WORKDIR /app
COPY . .
RUN mvn clean install
RUN mvn package
RUN cp target/*.jar spring-boot-docker-json-logging.jar

FROM openjdk:11-jre-slim-buster as release

WORKDIR /app
COPY --from=build /app/spring-boot-docker-json-logging.jar .

ENV SPRING_PROFILES_ACTIVE=docker

EXPOSE 8080

ENTRYPOINT ["java","-jar","spring-boot-docker-json-logging.jar"]
