#Output Route53 Zone ID
output "route53_zone_id" {
  value = aws_route53_zone.route53_zone.zone_id
}