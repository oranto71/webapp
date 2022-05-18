# pull base image
FROM tomcat:8-jre8
# maintainer
MAINTAINER "Tangko"
COPY /home/ubuntu/.jenkins/workspace/again/target/tt.test.war /usr/local/tomcat/webapps
