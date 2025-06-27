FROM --platform=linux/x86-64 jenkins/jenkins:lts

USER root

# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.txt


# Switch back to the Jenkins user
USER jenkins
