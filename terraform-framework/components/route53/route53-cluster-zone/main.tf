locals {
  workspace = format("%v", terraform.workspace)
}
module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["r53"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "route53" {
  source = "../../../modules/route53/route53-cluster-zone"

  environment      = local.workspace
  name             = var.name
  parent_zone_name = var.parent_zone_name
  parent_zone_id   = var.parent_zone_id
  zone_name        = "$${name}.$${environment}.$${parent_zone_name}"
  tags             = module.tag_label.tags
}
