locals {
  master_password = var.password != "" && var.kms_key_id != "" && var.asm_encrypted_password && var.asm_secret_name != "" ? data.aws_kms_secrets.aurora.plaintext["master_password"] : var.password
  name = var.name == "" ? module.tag_label.id : var.name
  database_name = var.database_name == "" ? module.dbname_label.id : var.database_name
}

data "aws_kms_secrets" "aurora" {
  secret {
    name    = "master_password"
    payload = var.password
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = lookup(var.envs[terraform.workspace], "bucket")
    key            = format("env:/%s/%s/%s", terraform.workspace, "vpc", "terraform.tfstate")
    region         = lookup(var.envs[terraform.workspace], "bucket_region")
    dynamodb_table = lookup(var.envs[terraform.workspace], "dynamodb")
  }
}

module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["rds"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "dbname_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["rds"]
  delimiter   = "_" # Overcome error: "DatabaseName must begin with a letter and contain only alphanumeric characters"
  cost_centre = var.cost_centre
  tags        = {}
}
module rds_cluster_aurora {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-rds-aurora.git?ref=tags/v2.15.0"

  name                         = local.name
  apply_immediately            = var.apply_immediately
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  backup_retention_period      = var.backup_retention_period
  database_name                = local.database_name
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_type                = var.instance_type
  kms_key_id                   = var.kms_key_id
  password                     = local.master_password
  username                     = var.username
  monitoring_interval          = var.monitoring_interval
  port                         = var.port
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  replica_count                = var.replica_count
  replica_scale_enabled        = var.replica_scale_enabled
  replica_scale_max            = var.replica_scale_max
  replica_scale_min            = var.replica_scale_min
  skip_final_snapshot          = var.skip_final_snapshot
  subnets                      = data.terraform_remote_state.vpc.outputs.private_subnets
  vpc_id                       = data.terraform_remote_state.vpc.outputs.vpc_id
  tags                         = module.tag_label.tags
}
