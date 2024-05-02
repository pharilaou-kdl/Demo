FROM maven:3.8.4-amazoncorretto-17 AS build

WORKDIR /build

COPY pom.xml .

RUN mvn dependency:go-offline

COPY src ./src

RUN mvn clean package -DskipTests

FROM amazoncorretto:17

#ARG PROFILE=dev
ARG APP_VERSION=0.0.1

WORKDIR /app

COPY --from=build /build/target/demo-*.jar /app/

EXPOSE 8080

#ENV ACTIVE_PROFILE=${PROFILE}
ENV JAR_VERSION=${APP_VERSION}
ENV EMAIL_HOSTNAME=missing_host_name
ENV EMAIL_USER_NAME=missing_USER_name
ENV EMAIL_PASSWORD=missing_user_pasword

CMD java -jar demo-${JAR_VERSION}.jar