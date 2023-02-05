#Provider
provider "aws" {
  region = var.region
}

#Create VPC and Subnets using modules
module "vpc" {
  source         = "./modules/vpc_module"
  vpc_cidr_block = var.cidr_block
  vpc_tenancy    = var.tenancy
  vpc_tags       = var.tags

  subnet_availability_zone = var.availability_zone
  subnet_cidr_block        = var.subnet_cidr_block
  subnet_tags              = var.subnet_tag

  internet_gateway_tags = var.internet_gateway_tag

  route_table_tags       = var.route_table_tags
  route_table_cidr_block = var.internet_cidr_block
}

#Create Security Groups using modules
module "sg" {
  source = "./modules/sg_module"

  sg_name   = var.sg_name
  sg_vpc_id = module.vpc.vpc_id

  ec2_ingress     = var.ec2_ingress
  ec2_protocol    = var.ec2_protocol
  ec2_cidr_blocks = var.lb_cidr_blocks

  ec2_tags = var.ec2_tags

  lb_sg_name        = var.lb_sg_name
  lb_sg_description = var.lb_sg_description
  lb_sg_vpc_id      = module.vpc.vpc_id

  lb_sg_ingress     = var.lb_ingress
  lb_protocol       = var.lb_protocol
  lb_sg_cidr_blocks = var.lb_cidr_blocks

  lb_tags = var.lb_tags

  allow_lb_port     = var.allow_lb_ingress
  allow_lb_protocol = var.allow_lb_protocol
}

#Create EC2 Instance using modules
module "ec2" {
  source = "./modules/ec2_module"
  depends_on = [
    module.vpc,
    module.sg
  ]

  ec2_instance_count                       = var.ec2_instance_count
  ec2_instance_ami                         = var.ec2_instance_ami
  ec2_instance_type                        = var.ec2_instance_type
  ec2_instance_key_name                    = var.ec2_instance_key_name
  ec2_instance_subnet_id                   = module.vpc.subnet_id.0
  vpc_security_group_ids                   = [module.sg.ec2_sg_id]
  ec2_instance_associate_public_ip_address = true
  ec2_instance_tags                        = var.ec2_instance_tags
}

#Create Load Balancer using modules
module "lb" {
  source = "./modules/lb_module"
  depends_on = [
    module.vpc,
    module.sg
  ]

  lb_name               = var.lb_name
  lb_internal           = false
  lb_load_balancer_type = "application"
  lb_subnets            = [module.vpc.subnet_id.0, module.vpc.subnet_id.1]
  lb_security_groups    = [module.sg.load_sg_id]
  lb_tags               = var.lb_tag

  lb_listener_port     = var.lb_listener_port
  lb_listener_protocol = var.lb_listener_protocol

  lb_target_group_name     = var.lb_target_group_name
  lb_target_group_port     = var.lb_target_group_port
  lb_target_group_protocol = var.lb_target_group_protocol
  vpc_id                   = module.vpc.vpc_id

  lb_target_group_attachment_port      = var.attachment_port
  lb_target_group_attachment_target_id = [module.ec2.ec2_instance_id.0, module.ec2.ec2_instance_id.1, module.ec2.ec2_instance_id.2]
}

#Create Route53 Zone and Record using modules
module "route53" {
  source = "./modules/route53_module"

  route53_zone_name = var.route53_zone_name
  route53_zone_tags = var.route53_zone_tags

  route53_record_name = var.route53_record_name
  route53_record_type = var.route53_record_type

  route53_alias_name    = module.lb.lb_dns_name
  route53_alias_zone_id = module.lb.lb_zone_id
}

#Create a local file to store the public instance private IP
resource "template_file" "inventory" {
  template = <<EOF
  [web]
  ${module.ec2.ec2_instance_public_ip.0}
  ${module.ec2.ec2_instance_public_ip.1}
  ${module.ec2.ec2_instance_public_ip.2}
  EOF

  provisioner "local-exec" {
    command = "echo '${template_file.inventory.rendered}' > ansible/inventory"
  }
}

#Run Ansible Playbook using pem file
resource "null_resource" "ansible" {
  depends_on = [
    module.ec2,
    module.lb,
    module.route53,
    template_file.inventory
  ]

  provisioner "local-exec" {
    command = "ansible-playbook -i ansible/inventory ansible/playbook.yml --private-key /ansible/ekene.pem"
  }
}


#Output