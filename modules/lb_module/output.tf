#Output for ELB
output "lb_dns_name" {
  value = aws_lb.lb.dns_name
}
output "lb_name" {
  value = aws_lb.lb.name
}
output "lb_zone_id" {
  value = aws_lb.lb.zone_id
}
output "arn" {
  value = aws_lb.lb.arn
}