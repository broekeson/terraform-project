#variable for Route53
variable "route53_zone_name" {
  type    = string
}

variable "route53_zone_tags" {
  type = map(string)
}

variable "route53_record_name" {
  type    = string
}

variable "route53_record_type" {
  type    = string
}

variable "route53_alias_name" {
  type    = string
}

variable "route53_alias_zone_id" {
  type    = string
}

