output "account_ids" {
  description = "A list of account IDs"
  value       = module.aws_accounts.ids
}
output "account_arn" {
  description = "A list of account ARNs"
  value       = module.aws_accounts.arns
}
