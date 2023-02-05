#Output VPC ID from VPC module
output "vpc_id_output" {
  value = module.vpc.vpc_id
}

#Output Subnet ID from VPC module
output "subnet_id_output" {
  value = module.vpc.subnet_id
}

#Output EC2 Instance Public IP from EC2 module
output "ec2_instance_public_ip" {
  value = module.ec2.ec2_instance_public_ip
}