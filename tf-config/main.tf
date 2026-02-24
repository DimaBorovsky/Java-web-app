terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"

    }
  }
}

provider "aws" {
  shared_config_files = ["/{your path}}.aws/config"]
  shared_credentials_files = ["/{Your path }}/.aws/credentials"]
}


data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


resource "aws_instance" "tf-test" {
  ami  = data.aws_ssm_parameter.amazon_linux.value
  instance_type = "t3.micro"
  user_data = file("./config-instance.sh")
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  key_name = "EC2-Tutorial"


}

resource "aws_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = "vpc-0911e37e84aad38b1"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["x.x.x.x/x"] # update your IP as necessary/IP of company VPN etc...
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


