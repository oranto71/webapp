# pull base image
FROM tomcat:8-jre8
# maintainer
MAINTAINER "Tangko"
COPY ./tt.test.war /usr/local/tomcat/webapps
