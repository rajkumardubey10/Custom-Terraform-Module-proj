output "instance_id" {
  value = aws_instance.my_instance.id
}

output "public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "ec2_DNS" {
  value = aws_instance.my_instance.public_dns
}