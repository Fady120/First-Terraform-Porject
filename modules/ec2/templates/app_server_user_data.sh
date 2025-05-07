#!/bin/bash
dnf update -y
dnf install docker -y
systemctl enable --now docker
usermod -a -G docker ec2-user
DB_HOST=${db_host}
docker run -d --name my_phpmyadmin \
  -e PMA_HOST=$DB_HOST \
  -e PMA_PORT=3306 \
  -p 80:80 \
  phpmyadmin/phpmyadmin