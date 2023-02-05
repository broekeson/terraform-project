#Provider Variables
variable "region" {
  description = "Region of the provider"
  type        = string
  default     = "us-east-1"
}

#Ec2 Security Group Variables
variable "sg_name" {
  description = "Name of the security group"
  type        = string
}


variable "sg_vpc_id" {
  description = "VPC ID of the security group"
  type        = string
}

variable "ec2_ingress" {
  description = "value of the ingress"
  type        = list(number)
}

variable "ec2_protocol" {
  description = "Protocol of the security group"
  type        = string
  default     = "tcp"
}

variable "ec2_cidr_blocks" {
  description = "CIDR blocks of the security group"
  type        = list(string)
}


variable "ec2_tags" {}

#Load Security Group Variables
variable "lb_sg_name" {
  description = "Name of the security group"
  type        = string
}

variable "lb_sg_description" {
  description = "Description of the security group"
  type        = string
}

variable "lb_sg_vpc_id" {
  description = "VPC ID of the security group"
  type        = string
}

variable "lb_sg_ingress" {
  description = "value of the ingress"
  type        = list(number)
}

variable "lb_protocol" {
  description = "Protocol of the security group"
  type        = string
}

variable "lb_sg_cidr_blocks" {
  description = "CIDR blocks of the security group"
  type        = list(string)
}


variable "lb_tags" {}

#Instance Access to Load Balancer Variables
variable "allow_lb_port" {
  type = number
}

variable "allow_lb_protocol" {}