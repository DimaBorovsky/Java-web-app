terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    awscc = {
      source  = "hashicorp/awscc"
      version = "1.23.0"
    }
  }
}
data "aws_ami" "ami" {
  most_recent = true
}

resource "aws_instance" "tf-test" {
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"

}

resource "aws_security_group" "allow_ssh" {
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


