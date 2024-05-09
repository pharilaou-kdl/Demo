FROM maven:3.8.4-amazoncorretto-17 AS build

WORKDIR /build

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

FROM amazoncorretto:17

ARG APP_VERSION=1.0.0

WORKDIR /app

COPY --from=build /build/target/demo-*.jar /app/

EXPOSE 8080

ENV JAR_VERSION=${APP_VERSION}

CMD java -jar demo-${JAR_VERSION}.jar