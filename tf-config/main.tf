terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"

    }
  }
}

provider "aws" {
  shared_config_files = ["/Users/dima.borovsky/.aws/config"]
  shared_credentials_files = ["/Users/dima.borovsky/.aws/credentials"]
}


data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}


resource "aws_instance" "tf-test" {
  ami  = data.aws_ssm_parameter.amazon_linux.value
  instance_type = "t3.micro"
  user_data = "/Users/dima.borovsky/Desktop/Java-CI-CD/config-instance.sh"


}

resource "aws_security_group" "allow_ssh" {
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["x.x.x.x/x"] # update your IP as necessary/IP of company VPN etc...
  }
}


