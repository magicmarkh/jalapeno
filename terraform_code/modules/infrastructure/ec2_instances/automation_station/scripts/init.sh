#!/usr/bin/env bash
set -eux

# 1) Update OS and install Java (for Jenkins) + Ansible + Git
sudo yum update -y
sudo yum install java-17-amazon-corretto-devel -y
sudo yum install -y ansible git

# 2) Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins

# 3) Enable & start services
sudo systemctl enable jenkins
sudo systemctl start jenkins
