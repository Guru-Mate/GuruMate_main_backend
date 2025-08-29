FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# 로컬에서 gradle로 빌드한 jar를 도커에 복사
COPY build/libs/*.jar app.jar

ENV TZ=Asia/Seoul
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]