# Usa la imagen base de Maven con OpenJDK
FROM maven:3.8.6-jdk-11 as build

# Establece el directorio de trabajo
WORKDIR /app

# Copia el código fuente al contenedor
COPY . /app

# Instala el JDK 21 (ya que la imagen base tiene OpenJDK, pero no especifica la versión)
RUN apt-get update && apt-get install -y openjdk-21-jdk

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




