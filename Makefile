# Makefile for Maven, Docker, and Docker Compose automation

MAVEN_PROJECT_DIR = .
DOCKER_IMAGE_NAME = scorecard
JAR_FILE = ScoreCard-016-0.0.1-SNAPSHOT.jar
JAR_DIRECTORY = target/ScoreCard-016-0.0.1-SNAPSHOT.jar
.PHONY: clear_docker_cache clean package target build compose

all: clean package target build compose

#In case we choose to use the remove make command for our packaged jar
#remove:
#	@rm $(JAR_FILE)

#clears all docker images and containers to remove an old cached builds
clear_docker_cache:
	@docker stop $$(docker ps -a -q)
	@docker rm $$(docker ps -a -q)
	@docker rmi $$(docker images -a -q)

clean:
	@echo "Cleaning Maven project..."
	@cd $(MAVEN_PROJECT_DIR) && mvn clean

package:
	@echo "Packaging Maven project..."
	@cd $(MAVEN_PROJECT_DIR) && mvn package

target:
	@echo "Moving jar file to root directory..."
	@cp -f $(JAR_DIRECTORY) .

build:
	@echo "Building Docker image..."
	@docker build -t $(DOCKER_IMAGE_NAME) .

compose:
	@echo "Running Docker Compose..."
	@docker-compose up -d
	@echo "http://localhost:9060"


