# IAM Groups Module

This module creates groups per product in the IAM AWS account (1111111111111) thus granting users access to the relevant product AWS accounts.

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| aws_account_ids | AWS account IDs that users should be allowed access to | - | yes |
| administrator_group_membership | list of members of the administrator group | - | yes |
| developer_group_membership | list of members of the developer group | - | yes |
| operations_group_membership | list of members of the operations group | - | yes |
| project_name | name of the project | - | yes |
