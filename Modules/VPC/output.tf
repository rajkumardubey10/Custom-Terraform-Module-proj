output "vpc_id" {
  value = aws_vpc.custom_vpc.id
}

output "public_subnet_ids" {
  value = { for k, s in aws_subnet.subnet_public : k => s.id }
}

output "private_subnet_ids" {
  value = { for k, s in aws_subnet.subnet_private : k => s.id }
}
