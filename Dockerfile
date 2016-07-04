FROM tomcat:8.0.36-jre8
MAINTAINER Jaime Iniesta <jaimeiniesta@gmail.com>

# Remove unneeded Tomcat apps
ENV WEBAPPS_DIR /usr/local/tomcat/webapps

RUN rm -rf ${WEBAPPS_DIR}/ROOT
RUN rm -rf ${WEBAPPS_DIR}/docs
RUN rm -rf ${WEBAPPS_DIR}/examples
RUN rm -rf ${WEBAPPS_DIR}/host-manager
RUN rm -rf ${WEBAPPS_DIR}/manager

# Install the validator as root
ENV VALIDATOR_NU_VERSION 16.6.29
ENV VALIDATOR_NU_ZIP vnu.war_${VALIDATOR_NU_VERSION}.zip
ENV VALIDATOR_NU_URL https://github.com/validator/validator/releases/download/${VALIDATOR_NU_VERSION}/${VALIDATOR_NU_ZIP}

ADD ${VALIDATOR_NU_URL} /tmp
RUN unzip -d /tmp /tmp/${VALIDATOR_NU_ZIP}
RUN mv /tmp/dist/vnu.war ${WEBAPPS_DIR}/ROOT.war
RUN rm -rf /tmp/*
