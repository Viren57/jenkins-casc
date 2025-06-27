FROM --platform=linux/x86-64 jenkins/jenkins:lts


# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.txt

ENV JENKINS_HOME /var/jenkins_home

ARG JAVA_OPTS
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false ${JAVA_OPTS:-}"
