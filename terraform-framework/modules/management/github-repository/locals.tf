locals {
  homepage_url         = var.homepage_url
  default_description  = "Repository for ${var.name}"
  description          = var.description == "" ? local.default_description : var.description
  repository  = data.github_repository.repository.name

  label_data = {
    first_issue = {
      repository  = local.repository
      name        = "good first issue"
      color       = "159818"
      description = "Good for newcomers"
    },
    help_wanted = {
      repository  = local.repository
      name        = "help wanted"
      color       = "159818"
      description = "Extra attention is needed"
    },
    feature_request = {
      repository  = local.repository
      name       = "Type: Feature Request"
      color      = "86B7E9"
      description = "Feature request"
    },
    bug = {
      repository  = local.repository
      name       = "Type: Bug"
      color      = "b60205"
      description = "Bug"
    },
    documentation = {
      repository  = local.repository
      description = "Documentation"
      name       = "Type: Documentation"
      color      = "635d5c"
    },
    maintenance = {
      repository  = local.repository
      description = "Maintenance"
      name       = "Type: Maintenance"
      color      = "4e3e4e"
    },
    high = {
      repository  = local.repository
      description = "High Priority"
      name       = "Priority: High"
      color      = "b60205"
    },
    medium = {
      repository  = local.repository
      description = "Medium Priority"
      name       = "Priority: Medium"
      color      = "bf6f71"
    },
    low = {
      repository  = local.repository
      description = "Low Priority"
      name       = "Priority: Low"
      color      = "c2e0c6"
    },
    blocked = {
      repository  = local.repository
      description = "Block Status"
      name       = "Status: Blocked"
      color      = "131611"
    },
    in_progress = {
      repository  = local.repository
      description = "Status In Progress"
      name       = "Status: In Progress"
      color      = "159818"
    },
    on_hold = {
      repository  = local.repository
      description = "Status On Hold"
      name       = "Status: On Hold"
      color      = "675b28"
    },
    pending_feedback = {
      repository  = local.repository
      description = "Status Pending Contributor"
      name       = "Status: Pending Contributor"
      color      = "191919"
    },
    duplicate = {
      repository  = local.repository
      description = "This issue or pull request already exists"
      name       = "Duplicate"
      color      = "cccccc"
    }

  }
}



