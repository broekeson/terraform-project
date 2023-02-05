#Output VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

#Output All Subnet ID
output "subnet_id" {
  value = aws_subnet.public.*.id
}
