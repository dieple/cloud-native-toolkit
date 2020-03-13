output "hostname" {
  value       = aws_route53_record.default.fqdn
  description = "DNS hostname"
}
