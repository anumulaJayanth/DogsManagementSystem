# Use the specified Maven image with JDK 11 for the build stage
FROM maven:3.8.2-jdk-11 AS build

# Copy the application source code into the container
COPY . .

# Run Maven to clean and package the application, skipping tests
RUN mvn clean package -Pprod -DskipTests

# Use OpenJDK 17 for the runtime stage
FROM adoptopenjdk/openjdk17:jdk-17.0.0_35-alpine-slim

# Copy the built JAR file from the build stage into the runtime stage
COPY --from=build /target/DogsManagementSystem-0.0.1-SNAPSHOT.jar DogsManagementSystem.jar

# Specify the command to run the application when the container starts
CMD ["java", "-jar", "DogsManagementSystem.jar"]
