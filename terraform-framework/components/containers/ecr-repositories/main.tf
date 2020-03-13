module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = []
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
}

# the name of the created dynamodb will be the result of module.tag_label.id
module "ecr_repos" {
  source = "../../../modules/containers/ecr-repositories"

  allowed_account_ids = var.allowed_account_ids
  repository_names    = var.repository_names
  allow_push          = var.allow_push
  repo_lifecycle_info = var.repo_lifecycle_info
  tags                = module.tag_label.tags
}
