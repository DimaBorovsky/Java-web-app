output "public_ip" {
  value = aws_instance.tf-test.public_ip
}

output "az" {
  value = aws_instance.tf-test.availability_zone
}