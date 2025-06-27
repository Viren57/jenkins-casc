FROM --platform=linux/x86-64 jenkins/jenkins:lts

USER root

# Install plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.txt

# Copy the Jenkins Configuration as Code YAML file
COPY jenkins_casc.yaml /var/jenkins_home/jenkins.yaml

# Set environment variable for JCasC
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/jenkins.yaml

# Switch back to the Jenkins user
USER jenkins
