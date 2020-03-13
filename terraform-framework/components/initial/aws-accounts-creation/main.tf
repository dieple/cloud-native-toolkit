module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = [""]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}


module "aws_accounts" {
  source = "../../../modules/iam-users-and-accounts/aws-accounts-creation"

  account_data = var.account_data
  tags         = module.tag_label.tags
}
