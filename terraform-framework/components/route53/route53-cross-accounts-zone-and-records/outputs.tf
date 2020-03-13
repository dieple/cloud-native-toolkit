output "zone_name" {
  value = var.zone_name
}

output "zone_id" {
  value = aws_route53_zone.default.zone_id
}

output "records" {
  value = aws_route53_zone.default.name_servers
}