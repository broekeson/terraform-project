#Create Route53 Zone
resource "aws_route53_zone" "route53_zone" {
  name = var.route53_zone_name
  tags = var.route53_zone_tags
}

#Create A subdomain
resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.route53_zone.zone_id
  name    = var.route53_record_name
  type    = var.route53_record_type

  alias {
    name                   = var.route53_alias_name
    zone_id                = var.route53_alias_zone_id
    evaluate_target_health = true
  }
}

