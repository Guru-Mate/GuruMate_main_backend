# 1) 빌드 단계
FROM gradle:8.9-jdk17-alpine AS build
WORKDIR /app

# gradle 캐시 최적화
COPY build.gradle* settings.gradle* ./
COPY gradle gradle
RUN gradle clean build -x test --no-daemon || return 0

# 전체 소스 복사
COPY . .

# JAR 생성
RUN gradle clean bootJar --no-daemon

# 2) 실행 단계
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# 빌드된 JAR 복사
COPY --from=build /app/build/libs/*SNAPSHOT.jar app.jar

ENV TZ=Asia/Seoul
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
