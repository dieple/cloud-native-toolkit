# repository

This module enforces some best github practices conventions.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| description |  | string | `` | no |
| enforce_admins |  | string | `true` | no |
| homepage_url | Home page URL for the Git repo | string | `` | no |
| name | name of the service/repo | string | - | yes |
| product_name | name of the product this sits under | string | `` | no |
| product_team | ID of the team that should own the repo, gives push access by default | string | - | yes |
| product_team_permission |  | string | `push` | no |
| require_ci_pass |  | string | `true` | no |
| status_checks |  | string | `<list>` | no |
| pr_webhook_url | URL for github's pull-request webhook event | string | `` | no |
| disable_branch_protection | Disable branch protection, so it won't require pull requests | boolean | false | no |

## Outputs

| Name | Description |
|------|-------------|
| full_name |  |
| git_clone_url |  |

