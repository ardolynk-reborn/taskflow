FROM openjdk:21-jdk as build
WORKDIR /app
COPY . .
RUN microdnf install findutils
RUN ./gradlew clean bootJar -x test

FROM openjdk:21-jdk-slim
WORKDIR /dir
COPY --from=build /app/build/libs/*.jar app.jar


EXPOSE 8080
CMD ["java", "-jar", "/dir/app.jar"]
