FROM --platform=linux/x86-64 jenkins/jenkins:lts

USER root

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.txt

COPY jenkins_casc.yaml /var/jenkins_casc.yaml
ENV CASC_JENKINS_CONFIG=/var/jenkins_casc.yaml

USER jenkins
