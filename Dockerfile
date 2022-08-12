FROM ubuntu:focal
# setup ag reqs

RUN apt-get update --fix-missing
RUN apt-get install -y build-essential
RUN apt-get install -y python3 python3-pip wget unzip curl

RUN mkdir -p /home/autograder/working_dir/src/main/java
RUN mkdir -p /home/autograder/working_dir/src/test/java
RUN mkdir -p /home/autograder/mvn_tmp
RUN mkdir -p /home/autograder/.m2

RUN useradd autograder && \
   chown -R autograder:autograder /home/autograder

USER autograder

WORKDIR /home/autograder/mvn_tmp
RUN wget https://github.com/ShafigullinIK/AutoTestExample/archive/refs/heads/master.zip
RUN unzip -a ./master.zip

RUN mv ./AutoTestExample-master/.mvn ../working_dir
RUN mv ./AutoTestExample-master/pom.xml ../working_dir

WORKDIR /home/autograder/working_dir

USER root

# setup openjdk 18
ENV JAVA_HOME=/opt/java/openjdk
COPY --from=eclipse-temurin:11 $JAVA_HOME $JAVA_HOME
ENV PATH="${JAVA_HOME}/bin:${PATH}"

ARG MAVEN_VERSION=3.8.6
ARG USER_HOME_DIR="/home/autograder"
ARG SHA=f790857f3b1f90ae8d16281f902c689e4f136ebe584aba45e4b1fa66c80cba826d3e0e52fdd04ed44b4c66f6d3fe3584a057c26dfcac544a60b301e6d0f91c26
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

RUN cp /home/autograder/mvn_tmp/AutoTestExample-master/settings-docker.xml /usr/share/maven/ref/

USER autograder

RUN mvn dependency:go-offline
RUN mvn clean install

RUN cp /home/autograder/mvn_tmp/AutoTestExample-master/settings-docker.xml /home/autograder/.m2/settings.xml

USER root

CMD ["/bin/bash"]