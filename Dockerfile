# Usa una imagen base de Maven con JDK 21
FROM maven:3-jdk-21 as build

# Define las variables de entorno
ARG DB_HOST
ARG DB_PORT
ARG DB_NAME
ARG DB_USER
ARG DB_PASSWORD

# Establece las variables de entorno
ENV DB_HOST=$DB_HOST
ENV DB_PORT=$DB_PORT
ENV DB_NAME=$DB_NAME
ENV DB_USER=$DB_USER
ENV DB_PASSWORD=$DB_PASSWORD

# Establece el directorio de trabajo
WORKDIR /app

# Copia el código fuente al contenedor
COPY . /app

# Ejecuta Maven para construir el proyecto y deshabilitar las pruebas
RUN mvn clean install -DskipTests

# Usa una imagen base con OpenJDK 21 para ejecutar la aplicación
FROM openjdk:21-jdk-slim as runtime

# Copia el archivo JAR generado en el contenedor anterior
COPY --from=build /app/target/movies-backend-0.0.1-SNAPSHOT.jar /app/movies-backend.jar

# Establece el directorio de trabajo
WORKDIR /app

# Cambia los permisos del archivo JAR
RUN chmod +x movies-backend.jar

# Ejecuta el comando Java
CMD ["java", "-jar", "movies-backend.jar"]