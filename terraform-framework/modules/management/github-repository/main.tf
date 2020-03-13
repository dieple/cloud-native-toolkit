resource "github_repository" "repository" {
  name               = var.name
  description        = local.description
  homepage_url       = local.homepage_url
  private            = true
  has_issues         = true
  has_wiki           = false
  allow_merge_commit = var.allow_merge_commit
  allow_squash_merge = true
  allow_rebase_merge = true
  has_downloads      = false
  auto_init          = true
  archived           = var.archived
}

resource "github_branch_protection" "repository_master" {
  count      = var.disable_branch_protection ? 0 : 1

  repository     = var.name
  branch         = "master"
  enforce_admins = var.enforce_admins

  required_status_checks {
    strict   = var.require_ci_pass
    contexts = [
      var.status_checks]
  }

  required_pull_request_reviews {
    dismiss_stale_reviews = false
  }

  depends_on = ["github_repository.repository"]
}

resource "github_team_repository" "restricted_access" {
  team_id    = var.product_team
  repository = github_repository.repository.name
  permission = var.product_team_permission
}

resource "github_team_repository" "write" {
  count = var.write_teams_count

  team_id    = element(var.write_teams, count.index)
  repository = github_repository.repository.name
  permission = "push"
}

resource "github_repository_webhook" "pr_webhook" {
  count = var.pr_webhook_url == "" ? 0 : 1

  repository = github_repository.repository.name
  name       = "web"
  events     = ["pull_request"]

  configuration {
    url          = var.pr_webhook_url
    content_type = "application/json"
    insecure_ssl = false
  }
}
