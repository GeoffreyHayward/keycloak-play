## Build stage
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn -B -q -e -DskipTests dependency:go-offline
COPY src ./src
RUN mvn -B -q -DskipTests package

## Runtime stage
FROM eclipse-temurin:21-jre
ENV JAVA_OPTS=""
WORKDIR /app
COPY --from=build /build/target/*.jar app.jar

# Environment defaults (overridden by compose)
ENV SPRING_PROFILES_ACTIVE=docker \
    SERVER_PORT=8080 \
    KEYCLOAK_URL=http://keycloak:8080/auth \
    KEYCLOAK_REALM=play \
    KEYCLOAK_CLIENT_ID=spring-client \
    KEYCLOAK_CLIENT_SECRET=example-secret \
    POST_LOGOUT_REDIRECT_URI=http://localhost:8082/

EXPOSE 8080
ENTRYPOINT ["sh","-c","java $JAVA_OPTS -jar app.jar"]
