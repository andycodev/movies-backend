# Usa la imagen oficial de OpenJDK 21 y Maven
FROM openjdk:21-jdk as build

# Instala Maven manualmente
RUN apt-get update && apt-get install -y maven

# Establece el directorio de trabajo
WORKDIR /app

# Copia el código fuente al contenedor
COPY . /app

# Ejecuta el comando Maven para construir el archivo JAR
RUN mvn clean install

# Usa una imagen base de JDK 21 para ejecutar la aplicación
FROM openjdk:21-jdk-slim as runtime

# Copia el archivo JAR del contenedor anterior
COPY --from=build /app/target/movies-backend-0.0.1-SNAPSHOT.jar /app/movies-backend.jar

# Expone el puerto
EXPOSE 8080

# Comando para ejecutar la aplicación
CMD ["java", "-jar", "movies-backend.jar"]



