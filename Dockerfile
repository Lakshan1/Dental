# --- Stage 1: build the WAR with Maven ---
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn -B clean package -DskipTests

# --- Stage 2: just Tomcat + the WAR, nothing else ---
FROM tomcat:11-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /build/target/Dental.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]