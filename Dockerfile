# Use a Maven image with the appropriate JDK version
FROM maven:3.8.2-jdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the entire project directory into the container
COPY . .

# Run Maven to clean and package the application, skipping tests
RUN mvn clean package -DskipTests

# Start a new stage for the runtime image
FROM openjdk:11-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/DogsManagementSystem-0.0.1-SNAPSHOT.jar DogsManagementSystem.jar

# Specify the command to run on container start
CMD ["java", "-jar", "DogsManagementSystem.jar"]
