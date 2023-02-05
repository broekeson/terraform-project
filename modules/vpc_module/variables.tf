#Variables for VPC
variable "vpc_cidr_block" {}
variable "vpc_tenancy" {}
variable "vpc_tags" {}

#Variables for Subnet
variable "subnet_cidr_block" {
  type = list(any)
}
variable "subnet_availability_zone" {
  type = list(any)
}
variable "subnet_tags" {}

#Variables for Internet Gateway
variable "internet_gateway_tags" {}

#Variables for Route Table
variable "route_table_tags" {}
variable "route_table_cidr_block" {}