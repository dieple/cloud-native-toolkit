data "github_repository" "repository" {
  full_name = format("%s/%s", var.github_owner, var.name)
}

resource "github_branch_protection" "repository_master" {
  count = var.disable_branch_protection ? 0 : 1

  repository     = data.github_repository.repository.name
  branch         = "master"
  enforce_admins = var.enforce_admins

  required_status_checks {
    strict   = var.require_ci_pass
    contexts = [var.status_checks]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = false
  }
}

resource "github_team_repository" "restricted_access" {
  team_id    = var.product_team
  repository = data.github_repository.repository.name
  permission = var.product_team_permission
}

resource "github_team_repository" "write" {
  count = var.write_teams_count

  team_id    = element(var.write_teams, count.index)
  repository = data.github_repository.repository.name
  permission = "push"
}

resource "github_repository_webhook" "pr_webhook" {
  count = var.pr_webhook_url == "" ? 0 : 1

  repository = data.github_repository.repository.name
  name       = "web"
  events     = ["pull_request"]

  configuration {
    url          = var.pr_webhook_url
    content_type = "application/json"
    insecure_ssl = false
  }
}
