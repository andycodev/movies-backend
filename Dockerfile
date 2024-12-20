# Usa una imagen con Maven y JDK 21
FROM maven:3.9.1-eclipse-temurin-21 as build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el código fuente al contenedor
COPY . /app

# Ejecuta el comando Maven para construir el archivo JAR
RUN mvn clean install

# Usa una imagen de JDK 21 para ejecutar la aplicación
FROM openjdk:21-jdk-slim

# Copia el archivo JAR del contenedor anterior
COPY --from=build /app/target/movies-backend-0.0.1-SNAPSHOT.jar /app/movies-backend.jar

# Expone el puerto
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "movies-backend.jar"]
