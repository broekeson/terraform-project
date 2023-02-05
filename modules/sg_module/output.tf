#Output Ec2 Security Group ID
output "ec2_sg_id" {
  value = "${aws_security_group.ec2_sg.id}"
}

#Output Load Security Group ID
output "load_sg_id" {
  value = aws_security_group.load_sg.id
}

