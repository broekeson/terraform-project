#Variables for Main Project

#Provider block
variable "region" {
  type    = string
  default = "us-east-1"
}

#VPC variable block
variable "cidr_block" {
  type    = string
  default = "10.1.0.0/16"
}

variable "tenancy" {
  type    = string
  default = "default"
}

variable "tags" {
  type    = string
  default = "starlight_vpc"
}

#Subnet variable block
variable "subnet_cidr_block" {
  type    = list(any)
  default = ["10.1.0.0/24", "10.1.4.0/24"]
}

variable "availability_zone" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}

variable "subnet_tag" {
  type    = string
  default = "starlight_subnet"
}

#Internet Gateway variable block
variable "internet_gateway_tag" {
  type    = string
  default = "starlight_igw"
}

#Route Table variable block
variable "route_table_tags" {
  type    = string
  default = "starlight_route_table"
}

variable "internet_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}

#Security Group variable block
#EC2 Security Group variable
variable "sg_name" {
  type    = string
  default = "starlight_sg"
}

variable "sg_description" {
  type    = string
  default = "VPC Security Group to allow SSH on port 22"
}

variable "ec2_ingress" {
  type    = list(any)
  default = [22]
}

variable "ec2_protocol" {
  type    = string
  default = "tcp"
}


variable "ec2_tags" {
  type    = string
  default = "starlight_ec2_sg"
}

#Load Balancer Security Group variable
variable "lb_sg_name" {
  type    = string
  default = "starlight_lb_sg"
}

variable "lb_sg_description" {
  type    = string
  default = "VPC Security Group to allow HTTP on port 80"
}


variable "lb_ingress" {
  type    = list(number)
  default = [80]
}

variable "lb_protocol" {
  type    = string
  default = "tcp"
}

variable "lb_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "lb_tags" {
  type    = string
  default = "starlight_lb_sg"
}

#Security Group Rule variable block
variable "allow_lb_ingress" {
  type    = number
  default = 80
}

variable "allow_lb_protocol" {
  type    = string
  default = "tcp"
}

#EC2 Instance variable block
variable "ec2_instance_count" {
  type    = number
  default = 3
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_instance_ami" {
  type    = string
  default = "ami-052465340e6b59fc0"
}

variable "ec2_instance_tags" {
  type = map(string)
  default = {
    Name = "starlight_ec2"
  }
}

variable "ec2_instance_key_name" {
  type    = string
  default = "ekene"
}

#Load Balancer variable block
variable "lb_name" {
  type    = string
  default = "starlight-lb"
}


#Variable for load balancer listener
variable "lb_listener_port" {
  type    = number
  default = 80
}

variable "lb_listener_protocol" {
  type    = string
  default = "HTTP"
}

#Variable for load balancer target group
variable "lb_target_group_name" {
  type    = string
  default = "starlight-target-group"
}

variable "lb_target_group_port" {
  type    = number
  default = 80
}

variable "lb_target_group_protocol" {
  type    = string
  default = "HTTP"
}

variable "attachment_port" {
  type    = number
  default = 80
}

variable "lb_tag" {
  type = map(any)
  default = {
    Name = "starlight_lb"
  }
}

#Variable for Route53
variable "route53_zone_name" {
  type    = string
  default = "ekene.tech"
}

variable "route53_zone_tags" {
  type = map(string)
  default = {
    Name = "starlight_route53_zone"
  }
}

variable "route53_record_name" {
  type    = string
  default = "terraform-test.ekene.tech"
}

variable "route53_record_type" {
  type    = string
  default = "A"
}

