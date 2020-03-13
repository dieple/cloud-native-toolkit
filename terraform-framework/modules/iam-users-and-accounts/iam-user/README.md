# IAM User Module

This module creates a new IAM user, generates their temporary password and
encrypts it with the provided public PGP key before saving it to an output
variable.

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| user | Username | - | yes |
| pgp_key | Base64-encoded PGP key | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws_iam_user_encrypted_password | Temporary password encrypted with the PGP key provided above |
