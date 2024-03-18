FROM ubuntu:lastest AS build

RUN apt-get update
RUN apt-get install openjdk-17-jdk -y
COPY . .

RUN apt-get install mvn -y
RUN mvn clean install

FROM open-jdk:17-jdk-slim
EXPOSE 8080

COPY --from=build /target/gestao_vagas-0.0.1.jar app.jar

ENTRYPOINT [ "java", "-jar", "app.jar" ]