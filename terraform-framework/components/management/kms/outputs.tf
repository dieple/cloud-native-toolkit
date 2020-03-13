output "key_arn" {
  value = module.vault_kms.key_arn
}

output "key_id" {
  value = module.vault_kms.key_id
}

output "alias_arn" {
  value = module.vault_kms.alias_arn
}

output "alias_name" {
  value = module.vault_kms.alias_name
}
