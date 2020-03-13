module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["lambda"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "lambda_role" {
  source = "../../../modules/iam-users-and-accounts/iam-role"

  enabled                = true
  name                   = format("%s-%s", module.tag_label.id, var.function_name)
  policy_description     = "Lambda policy"
  role_description       = "IAM role for lambda function ${var.function_name}"
  policy_documents       = [data.aws_iam_policy_document.default.json]
  additional_policy_arns = var.additional_policy_arns
  tags                   = module.tag_label.tags

  principals = {
    Service = ["lambda.amazonaws.com"]
  }
}

module "source_zip_file" {
  source = "../../../modules/serverless/lambda-archive-util"

  enabled     =  true
  empty_dirs  = false
  output_path = "${var.lambda_src_artifact_path}/${var.function_name}/${var.lambda_src_artifact_filename}"
  source_dir  = "${var.lambda_src_artifact_path}/${var.function_name}"
}

module "lambda_stopping_ec2_instances_nightly" {
  source = "../../../modules/serverless/lambda"

  file_name                          = var.lambda_src_artifact_filename
  lambda_src_artifact_path           = var.lambda_src_artifact_path
  function_name                      = var.function_name
  source_code_hash                   = module.source_zip_file.output_base64sha256
  layers                             = var.layers
  handler                            = var.handler
  role_arn                           = module.lambda_role.arn
  description                        = var.description
  memory_size                        = var.memory_size
  runtime                            = var.runtime
  timeout                            = var.timeout
  publish                            = var.publish
  vpc_config                         = var.vpc_config
  trigger                            = var.trigger
  enable_cloudwatch_log_subscription = var.enable_cloudwatch_log_subscription
  cloudwatch_log_subscription        = var.cloudwatch_log_subscription
  reserved_concurrent_executions     = var.reserved_concurrent_executions
  region                             = lookup(var.envs[terraform.workspace], "region")
  cloudwatch_log_retention           = var.cloudwatch_log_retention
}
