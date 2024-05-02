FROM maven:3.8.4-amazoncorretto-17 AS build

WORKDIR /build

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

FROM amazoncorretto:17

WORKDIR /app

COPY --from=build /build/target/demo-*.jar /app/

EXPOSE 8080

CMD java -jar demo-0.0.1.jar