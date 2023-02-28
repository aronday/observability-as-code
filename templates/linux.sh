#! /bin/bash
sudo yum update -y
sudo yum install -y git
git clone https://github.com/DataDog/ecommerce-workshop.git /tmp/ecommerce-workshop
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose