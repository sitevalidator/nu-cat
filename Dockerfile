FROM tomcat:8.0.43-jre8
MAINTAINER Jaime Iniesta <jaimeiniesta@gmail.com>

# Remove unneeded Tomcat apps
ENV WEBAPPS_DIR /usr/local/tomcat/webapps

RUN rm -rf ${WEBAPPS_DIR}/ROOT
RUN rm -rf ${WEBAPPS_DIR}/docs
RUN rm -rf ${WEBAPPS_DIR}/examples
RUN rm -rf ${WEBAPPS_DIR}/host-manager
RUN rm -rf ${WEBAPPS_DIR}/manager

# Install the validator as root
ENV VALIDATOR_NU_VERSION 17.3.0
ENV VALIDATOR_NU_ZIP vnu.war_${VALIDATOR_NU_VERSION}.zip
ENV VALIDATOR_NU_URL https://github.com/validator/validator/releases/download/${VALIDATOR_NU_VERSION}/${VALIDATOR_NU_ZIP}
ENV VALIDATOR_NU_SHA1 3d84fd112de6965131b6560cead53f4fac74bdd7

ADD ${VALIDATOR_NU_URL} /tmp
RUN echo "${VALIDATOR_NU_SHA1} /tmp/${VALIDATOR_NU_ZIP}" | sha1sum -c -
RUN unzip -d /tmp /tmp/${VALIDATOR_NU_ZIP}
RUN mv /tmp/dist/vnu.war ${WEBAPPS_DIR}/ROOT.war
RUN rm -rf /tmp/*

# Turn off SSL/TLS certificate trust checking because of:
# https://github.com/validator/validator/issues/345
RUN echo nu.validator.xml.promiscuous-ssl=true >> /usr/local/tomcat/conf/catalina.properties

# Set a custom timeout of 10 seconds, by default these are 5 seconds
RUN echo nu.validator.servlet.connection-timeout=10000 >> /usr/local/tomcat/conf/catalina.properties
RUN echo nu.validator.servlet.socket-timeout=10000 >> /usr/local/tomcat/conf/catalina.properties

# Expose web port
EXPOSE 8080
