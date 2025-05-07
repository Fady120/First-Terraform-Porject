#!/bin/bash
dnf update -y
dnf install docker -y
systemctl enable --now docker
usermod -a -G docker ec2-user
docker run -d --name my_mysql \
  -e MYSQL_ROOT_PASSWORD=supersecret \
  -e MYSQL_DATABASE=testdb \
  -e MYSQL_USER=testuser \
  -e MYSQL_PASSWORD=testpass \
  -p 3306:3306 \
  mysql:latest