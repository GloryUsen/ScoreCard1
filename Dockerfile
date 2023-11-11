FROM openjdk:17
LABEL author="decagon"
WORKDIR /app
EXPOSE 9060
COPY ScoreCard-016-0.0.1-SNAPSHOT.jar scorecard.jar
ENTRYPOINT ["java", "-jar", "scorecard.jar"]