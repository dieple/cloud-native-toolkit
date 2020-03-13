locals {
  workspace = format("%v", terraform.workspace)
}
module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["kms"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "vault_kms" {
  source = "../../../modules/management/kms"

  enabled    = var.create_vault_kms
  alias_name = "${module.tag_label.id}-vault"
  policy     = data.aws_iam_policy_document.vault_kms.json
  tags       = module.tag_label.tags
}

data "aws_iam_policy_document" "vault_kms" {
  statement {
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}
