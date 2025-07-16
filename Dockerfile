# Etapa 1: Construcción
FROM maven:3.9.4-eclipse-temurin-21-alpine AS build

# Directorio de trabajo
WORKDIR /app

# Copiar todo el proyecto
COPY . .

# Construir el proyecto sin ejecutar tests
RUN mvn clean package -DskipTests

# Etapa 2: Imagen liviana de ejecución
FROM eclipse-temurin:21-jdk-alpine

# Directorio de trabajo
WORKDIR /app

# Copiar el .jar generado
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto de Eureka Server
EXPOSE 8761

# Ejecutar el servicio
ENTRYPOINT ["java", "-jar", "app.jar"]