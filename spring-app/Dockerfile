FROM eclipse-temurin:21-jdk as build
WORKDIR /app
# Copy Maven Wrapper and configuration explicitly so the wrapper can run
COPY mvnw ./mvnw
COPY .mvn .mvn
COPY pom.xml ./
# Normalize line endings on Windows checkouts and pre-fetch dependencies
RUN sed -i 's/\r$//' mvnw && chmod +x mvnw && ./mvnw -q -DskipTests dependency:go-offline
COPY src ./src
RUN ./mvnw -q -DskipTests package

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","/app/app.jar"]
