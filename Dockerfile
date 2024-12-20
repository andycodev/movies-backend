# Usa la imagen base de Eclipse Temurin con JDK 21
FROM eclipse-temurin:21-jdk as build

# Instala Maven
RUN apt-get update && apt-get install -y maven

# Establece el directorio de trabajo
WORKDIR /app

# Copia el código fuente al contenedor
COPY . /app

# Ejecuta Maven para construir el proyecto y deshabilitar las pruebas
RUN mvn clean install -DskipTests

# Ejecuta el comando Maven para construir el archivo JAR
RUN mvn clean install

# Usa una imagen base con OpenJDK 21 para ejecutar la aplicación
FROM openjdk:21-jdk-slim as runtime

# Copia el archivo JAR generado en el contenedor anterior
COPY --from=build /app/target/movies-backend-0.0.1-SNAPSHOT.jar /app/movies-backend.jar

# Expone el puerto 8080
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "movies-backend.jar"]




