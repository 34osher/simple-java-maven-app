# Use Maven image to build the application
FROM maven:3.8.6-openjdk-11-slim AS build
WORKDIR /src
COPY ./src /src
COPY pom.xml /src
RUN mvn -B -DskipTests clean package

# Use a slim Java image to run the application
FROM openjdk:11-jre-slim
WORKDIR /src
COPY --from=build /app/target/*.jar /app/my-app.jar
CMD ["java", "-jar", "my-app.jar"]