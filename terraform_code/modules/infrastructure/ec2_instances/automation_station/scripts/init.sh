#!/usr/bin/env bash
set -eux

# 1) Update OS and install Java (for Jenkins) + Ansible + Git
yum update -y
amazon-linux-extras install java-openjdk11 -y
yum install -y ansible git

# 2) Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins

# 3) Enable & start services
systemctl enable jenkins
systemctl start jenkins
