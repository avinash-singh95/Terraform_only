#!/bin/bash
sudo yum update -y
sudo su
yum install docker -y
systemctl start docker
usermod -aG docker ec2-user
docker run -itd --name c1 -p 8080:80 nginx
                
