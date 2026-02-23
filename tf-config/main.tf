terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
  }
}
resource "aws_ami" "ami" {
  name = "my_ami"
}

resource "aws_instance" "tf-test" {
  ami = aws_ami.ami.name
  instance_type = "t3.micro"
}