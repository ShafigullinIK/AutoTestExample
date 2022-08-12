FROM openjdk:jdk

#RUN apt update
#RUN apt install maven

#RUN curl -L https://github.com/checkstyle/checkstyle/releases/download/checkstyle-8.31/checkstyle-8.31-all.jar > /opt/checkstyle.jar
#RUN chmod 777 /opt/checkstyle.jar

WORKDIR /exercise
COPY . /exercise

RUN ./mvnw -B compile