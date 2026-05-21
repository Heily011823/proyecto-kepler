FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY ./src ./src

RUN javac -d bin src/main/java/com/kepler/atlas/*.java

CMD ["java", "-cp", "bin", "com.kepler.atlas.Main"]