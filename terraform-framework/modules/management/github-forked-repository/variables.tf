variable "github_owner" {
  type = string
}

variable "name" {
  description = "name of the service/repo"
  type        = string
}

variable "product_name" {
  description = "name of the product this sits under"
  type        = string
  default     = ""
}

variable "description" {
  default = ""
  type    = string
}

variable "product_team" {
  description = "ID of the team that should own the repo, gives push access by default"
  type        = string
}

variable "product_team_permission" {
  default = "push"
  type    = string
}

variable "write_teams" {
  description = "a list of teams that can write to the repo"
  type        = list(string)
}

variable "write_teams_count" {
  description = "a count to be paired with the list variable with the same name"
}

variable "homepage_url" {
  default     = ""
  description = "Home page URL for the Git repo"
}

variable "enforce_admins" {
  default = true
  type    = bool
}

variable "require_ci_pass" {
  default = true
  type    = bool
}

variable "status_checks" {
  type    = list(string)
  default = []
}

variable "pr_webhook_url" {
  description = "URL for github's pull-request webhook event"
  default     = ""
  type        = string
}

variable "disable_branch_protection" {
  description = "Disable branch protection, so it won't require pull requests"
  default     = false
  type        = bool
}

variable "archived" {
  type    = bool
  default = false
}

variable "allow_merge_commit" {
  type    = bool
  default = false
}

