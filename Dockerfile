# Usa una imagen base de JDK 21
FROM openjdk:21-jdk-slim

# Establece el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo .jar de la aplicación al contenedor
COPY target/movies-backend-0.0.1-SNAPSHOT.jar /app/app.jar

# Expón el puerto en el que corre la aplicación
EXPOSE 8080

# Ejecuta la aplicación Spring Boot
CMD ["java", "-jar", "app.jar"]
