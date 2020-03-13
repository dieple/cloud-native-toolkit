output "administrators_role_arn" {
  value       = aws_iam_role.administrators.arn
  description = "Administrators role ARN"
}

output "developers_role_arn" {
  value       = aws_iam_role.developers.arn
  description = "Developers role ARN"
}

output "operations_role_arn" {
  value       = aws_iam_role.operations.arn
  description = "Operations role ARN"
}

output "cloudwatch_allow_read_role_arn" {
  value       = aws_iam_role.cloudwatch_allow_read.arn
  description = "CloudWatch allow read role ARN"
}
