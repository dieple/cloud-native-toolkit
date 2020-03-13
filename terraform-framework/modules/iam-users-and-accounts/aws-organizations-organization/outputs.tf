output "accounts" {
  value       = aws_organizations_organization.organization.accounts
  description = "List of organization accounts including the master account. For a list excluding the master account, see the non_master_accounts attribute. All elements have these attributes: 'arn' - ARN of the account, 'email' - Email of the account, 'id' - Identifier of the account, 'name' - Name of the account"
}

output "non_master_accounts" {
  value       = aws_organizations_organization.organization.non_master_accounts
  description = "List of organization accounts excluding the master account. For a list including the master account, see the accounts attribute. All elements have these attributes: 'arn' - ARN of the account, 'email' - Email of the account, 'id' - Identifier of the account, 'name' - Name of the account"
}

output "arn" {
  value       = aws_organizations_organization.organization.arn
  description = "ARN of the organization"
}

output "id" {
  value       = aws_organizations_organization.organization.id
  description = "Identifier of the organization"
}

output "master_account_arn" {
  value       = aws_organizations_organization.organization.master_account_arn
  description = "ARN of the master account"
}

output "master_account_email" {
  value       = aws_organizations_organization.organization.master_account_email
  description = "Email address of the master account"
}

output "master_account_id" {
  value       = aws_organizations_organization.organization.master_account_id
  description = "Identifier of the master account"
}

output "roots" {
  value       = aws_organizations_organization.organization.roots
  description = "List of organization roots. All elements have these attributes: 'arn' - ARN of the root, id - Identifier of the root, 'name' - Name of the root, 'policy_types' - List of policy types enabled for this root. All elements have these attributes: 'name' - The name of the policy type, 'status' - The status of the policy type as it relates to the associated root"
}
