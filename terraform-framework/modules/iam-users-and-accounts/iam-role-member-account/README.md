# IAM Member Account Module

This module creates IAM roles and policies in the organisation member accounts.

It creates the following:
- administrator role
- developer role
- read only access policy
- allow all access policy

For test runs all policies & roles have "-test" appended to them. This is to
avoid problems with the new policies having the same name as existing
managed policies that allow people to have access to the test account.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws\_iam\_root\_account\_id | account id of the root IAM account | string | `"667800118351"` | no |
| aws\_management\_account\_id | This is the management account id where the continuous delivery server sits | string | `"002540887416"` | no |
| aws\_monitoring\_account\_ids | account id allowed to assume the CloudWatch role and monitor it. for now shared transit account. | list | `<list>` | no |
| aws\_product\_management\_account\_id | This is the management account id of the product/project where the continuous delivery server sits | string | `""` | no |
| developers\_full\_access | give the developers group full access to this account | string | `"false"` | no |
| operations\_full\_access | give the developers group full access to this account | string | `"false"` | no |
| override\_administrator\_policy | override the policy | string | `"false"` | no |
| override\_administrator\_policy\_arn | name of the policy to override | string | `""` | no |
| override\_administrator\_role\_policy | override the policy | string | `"false"` | no |
| override\_administrator\_role\_policy\_arn | name of the policy to override | string | `""` | no |
| override\_developer\_role\_policy | override the policy | string | `"false"` | no |
| override\_developer\_role\_policy\_arn | name of the policy to override | string | `""` | no |
| override\_operations\_role\_policy | name of the policy to override | string | `"false"` | no |
| override\_operations\_role\_policy\_arn | name of the policy to override | string | `""` | no |
| override\_read\_only\_policy | override the policy | string | `"false"` | no |
| override\_read\_only\_policy\_arn | name of the policy to override | string | `""` | no |
| test\_environment | describe your variable | string | `"false"` | no |

## Outputs

| Name | Description |
|------|-------------|
| administrators\_role\_arn | Administrators role ARN |
| cloudwatch\_allow\_read\_role\_arn | CloudWatch allow read role ARN |
| continuous\_delivery\_role\_arn | Continuous delivery role ARN |
| operations\_role\_arn | Operations role ARN |
