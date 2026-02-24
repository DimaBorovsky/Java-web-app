#!/bin/bash

sudo yum -y upgrade
sudo yum -y install docker

sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service
sudo usermod -aG docker ec2-user
