#variable for Ec2
variable "ec2_instance_count" {
  description = "Number of Ec2 instances to create"
  type        = number
}
variable "ec2_instance_ami" {
  description = "AMI ID for Ec2 instance"
  type        = string
}
variable "ec2_instance_type" {
  description = "Type of Ec2 instance"
  type        = string
}
variable "ec2_instance_key_name" {
  description = "Key name for Ec2 instance"
  type        = string
}
variable "ec2_instance_subnet_id" {
  description = "Subnet ID for Ec2 instance"
  type        = string
 }

variable "vpc_security_group_ids" {
  description = "Security group ID for Ec2 instance"
  type        = list(string)
}
variable "ec2_instance_associate_public_ip_address" {
  description = "Associate public IP address for Ec2 instance"
  type        = bool
}

variable "ec2_instance_tags" {
  description = "Tags for Ec2 instance"
  type        = map(string)
}

