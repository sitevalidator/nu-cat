FROM tomcat:8.0.36-jre8

ENV VALIDATOR_NU_VERSION 16.6.29
ENV VALIDATOR_NU_ZIP vnu.war_${VALIDATOR_NU_VERSION}.zip
ENV VALIDATOR_NU_URL https://github.com/validator/validator/releases/download/${VALIDATOR_NU_VERSION}/${VALIDATOR_NU_ZIP}
ENV VALIDATOR_NU_DEST /usr/local/tomcat/webapps

ADD ${VALIDATOR_NU_URL} /tmp
RUN unzip -d /tmp /tmp/${VALIDATOR_NU_ZIP}
RUN mv /tmp/dist/vnu.war ${VALIDATOR_NU_DEST}/vnu.war
RUN rm -rf /tmp/*
