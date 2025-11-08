# Multi-stage Dockerfile for Spring Boot backend
# Build stage
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /workspace

# copy project files (assumes backend/ subfolder in repo)
COPY backend/ ./backend/

WORKDIR /workspace/backend
RUN mvn -B -DskipTests package

# Runtime stage
FROM eclipse-temurin:17-jre
WORKDIR /app

# copy the jar produced by maven
COPY --from=build /workspace/backend/target/*.jar /app/app.jar

EXPOSE 2025
ENTRYPOINT ["java","-jar","/app/app.jar"]
