#Create Ec2 Instance
resource "aws_instance" "ec2_instance" {
  count                       = var.ec2_instance_count
  ami                         = var.ec2_instance_ami
  instance_type               = var.ec2_instance_type
  key_name                    = var.ec2_instance_key_name
  subnet_id                   = var.ec2_instance_subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  associate_public_ip_address = var.ec2_instance_associate_public_ip_address
  tags                        = var.ec2_instance_tags
}



