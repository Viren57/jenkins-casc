#!/bin/bash

# Update system
sudo yum update -y

# Enable docker from amazon-linux-extras
sudo amazon-linux-extras enable docker
sleep 2
sudo yum clean metadata
sleep 2
sudo yum install -y docker
sleep 5

# Start docker
sudo systemctl enable docker
sudo systemctl start docker

# Add ec2-user to docker group
sudo usermod -aG docker ec2-user

# Install Docker Compose v2
DOCKER_CONFIG=/usr/libexec/docker
sudo mkdir -p $DOCKER_CONFIG/cli-plugins
sudo curl -SL https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
sudo chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Verify docker & docker compose
docker --version
docker compose version

# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo amazon-linux-extras enable corretto17
sudo yum install java-17-amazon-corretto jenkins -y
sudo systemctl enable jenkins
sudo systemctl restart jenkins

# Install Git
sudo yum install git -y

# Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/

# Install tfsec
curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

# clone the jcasc git repo
sudo git clone https://github.com/Viren57/jenkins-casc.git && 
sudo chown ec2-user /home/ec2-user/jenkins-casc &&
sudo chgrp ec2-user /home/ec2-user/jenkins-casc &&
echo "JCASC repo has been cloned" >> /home/ec2-user/setup.log

# Create docker-compose file
cat > /home/ec2-user/docker-compose.yaml <<EOF
version: '3'
services:
  jenkins:
    container_name: jenkins-server
    image: jenkins/jenkins
    build:
      context: ./jenkins-casc
    ports:
      - "8080:8080"
    volumes:
      - ./jenkins_home:/var/jenkins_home
    restart: always
EOF

# Start Jenkins container
cd /home/ec2-user
sudo docker compose up -d

echo "Docker + Jenkins setup complete" >> /home/ec2-user/setup.log
