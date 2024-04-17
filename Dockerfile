# Use a newer Maven image
FROM maven:3.8.5-jdk-11 AS build

# Set working directory
WORKDIR /app

# Copy only the pom.xml to leverage Docker cache for dependencies
COPY pom.xml .

# Fetch dependencies
RUN mvn dependency:go-offline -B

# Copy the rest of the application source code
COPY . .

# Build the application
RUN mvn package -Pprod

# Start a new stage for the runtime image
FROM openjdk:11-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/DogsManagementSystem-0.0.1-SNAPSHOT.jar DogsManagementSystem.jar

# Specify the command to run on container start
CMD ["java", "-jar", "DogsManagementSystem.jar"]
