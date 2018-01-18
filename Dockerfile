FROM tomcat:8.0.43-jre8
MAINTAINER Jaime Iniesta <jaimeiniesta@gmail.com>

# Remove unneeded Tomcat apps
ENV WEBAPPS_DIR /usr/local/tomcat/webapps

RUN rm -rf ${WEBAPPS_DIR}/ROOT \
 && rm -rf ${WEBAPPS_DIR}/docs \
 && rm -rf ${WEBAPPS_DIR}/examples \
 && rm -rf ${WEBAPPS_DIR}/host-manager \
 && rm -rf ${WEBAPPS_DIR}/manager

# Set up a faster SecureRandom as per https://wiki.apache.org/tomcat/HowTo/FasterStartUp
ENV JAVA_OPTS "-Djava.security.egd=file:/dev/urandom"

# Install the validator as root
ENV VALIDATOR_NU_VERSION 17.11.1
ENV VALIDATOR_NU_ZIP vnu.war_${VALIDATOR_NU_VERSION}.zip
ENV VALIDATOR_NU_URL https://github.com/validator/validator/releases/download/${VALIDATOR_NU_VERSION}/${VALIDATOR_NU_ZIP}
ENV VALIDATOR_NU_SHA1 fd02af604d279ebb3c756c5cbd7212ca76949e7a

ADD ${VALIDATOR_NU_URL} /tmp
RUN echo "${VALIDATOR_NU_SHA1} /tmp/${VALIDATOR_NU_ZIP}" | sha1sum -c - \
 && unzip -d /tmp /tmp/${VALIDATOR_NU_ZIP} \
 && mv /tmp/dist/vnu.war ${WEBAPPS_DIR}/ROOT.war \
 && rm -rf /tmp/*

# Set a custom timeout of 10 seconds, by default these are 5 seconds
RUN echo nu.validator.servlet.connection-timeout=10000 >> /usr/local/tomcat/conf/catalina.properties \
 && echo nu.validator.servlet.socket-timeout=10000 >> /usr/local/tomcat/conf/catalina.properties

# Expose web port
EXPOSE 8080
