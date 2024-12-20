FROM maven:3.9.1-openjdk-21 as build
WORKDIR /app
COPY . /app
RUN mvn clean install

FROM openjdk:21-jdk-slim as runtime
COPY --from=build /app/target/movies-backend-0.0.1-SNAPSHOT.jar /app/movies-backend.jar
EXPOSE 8080
CMD ["java", "-jar", "movies-backend.jar"]


