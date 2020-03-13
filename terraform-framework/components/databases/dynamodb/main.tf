module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["vault"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
}

# the name of the created dynamodb will be the result of module.tag_label.id
module "vault_dynamodb_table" {
  source = "../../../modules/databases/dynamodb"

  name                       = module.tag_label.id
  hash_key                   = var.hash_key
  range_key                  = var.range_key
  enable_autoscaler          = var.enable_autoscaler
  dynamodb_attributes        = var.dynamodb_attributes
  local_secondary_index_map  = var.local_secondary_index_map
  global_secondary_index_map = var.global_secondary_index_map
  tags                       = module.tag_label.tags
}
