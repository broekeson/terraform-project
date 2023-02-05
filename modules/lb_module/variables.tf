#Variable for lb
variable "lb_name" {}
variable "lb_internal" {
  type = bool
  default = false
}
variable "lb_load_balancer_type" {}
variable "lb_security_groups" {
  type = list(string)
}
variable "lb_subnets" {
  type = list(string)
}
variable "lb_enable_deletion_protection" {
  type = bool
  default = false
}

variable "lb_tags" {
  type = map(string)
}

#variable for lb listener
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}

#variable for lb target group
variable "lb_target_group_name" {}
variable "lb_target_group_port" {}
variable "lb_target_group_protocol" {}
variable "vpc_id" {}

#variable for lb target group health check
variable "check_healthy_threshold" {
  type = number
  default = 2
}
variable "check_unhealthy_threshold" {
  type = number
  default = 3
}
variable "check_timeout" {
  type = number
  default = 5
}
variable "check_interval" {
  type = number
  default = 30
}

#variable for lb target group attachment
variable "lb_target_group_attachment_port" {
  type = number
}

variable "lb_target_group_attachment_target_id" {
  type = list(string)
}