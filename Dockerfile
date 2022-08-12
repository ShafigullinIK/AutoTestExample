FROM ubuntu:focal
# setup ag reqs

RUN apt-get update --fix-missing
RUN apt-get install -y build-essential
RUN apt-get install -y python3 python3-pip

RUN mkdir -p /home/autograder/working_dir/GBAutoTest/src/main/java
RUN mkdir -p /home/autograder/working_dir/GBAutoTest/src/test/java
RUN mkdir -p /home/autograder/mvn_tmp

WORKDIR /home/autograder/mvn_tmp
RUN apt-get install -y wget unzip
RUN wget https://github.com/ShafigullinIK/AutoTestExample/archive/refs/heads/master.zip
RUN unzip -a ./master.zip

RUN mv ./AutoTestExample-master/.mvn ../working_dir
RUN mv ./AutoTestExample-master/mvnw ../working_dir
RUN mv ./AutoTestExample-master/pom.xml ../working_dir

RUN useradd autograder && \
   chown -R autograder:autograder /home/autograder

WORKDIR /home/autograder/working_dir

# setup openjdk 18
ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:11 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN ./mvnw dependency:go-offline
RUN ./mvnw clean install
RUN ./mvnw -o test

RUN echo "127.0.0.1   repo.maven.apache.org" >> /etc/hosts

CMD ["/bin/bash"]