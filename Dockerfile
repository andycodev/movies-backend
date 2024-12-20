# Usa una imagen con Maven y OpenJDK 21
FROM maven:3.8.6-openjdk-21 as build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el contenido de tu proyecto al contenedor
COPY . /app

# Ejecuta Maven para construir el proyecto y deshabilitar las pruebas
RUN mvn clean install -DskipTests

# Usa una imagen base con OpenJDK 21 para ejecutar la aplicación
FROM openjdk:21-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo JAR generado desde el contenedor anterior
COPY --from=build /app/target/movies-backend-0.0.1-SNAPSHOT.jar /app/movies-backend.jar

# Exponer el puerto en el que la aplicación Spring Boot escuchará (por defecto, 8080)
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "/app/movies-backend.jar"]




