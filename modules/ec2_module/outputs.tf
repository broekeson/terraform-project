#Output for Ec2 Instances
output "ec2_instance_id" {
  value = aws_instance.ec2_instance.*.id
}

#Output Ec2 Public IPs
output "ec2_instance_public_ip" {
  value = aws_instance.ec2_instance.*.public_ip
}