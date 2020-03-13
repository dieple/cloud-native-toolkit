file_name                          = "product_image_copy.zip"
lambda_src_artifact_path           = "../../../lambda_artefacts"
function_name                      = "product_image_copy"
layers                             = []
handler                            = "product_image_copy.lambda_handler"
role_arn                           = "arn:aws:iam::444455556666:role/cloud-ops-dev-iam-role-lambda"
description                        = "Product Sketch Copy Lambda"
memory_size                        = 128
runtime                            = "python3.7"
timeout                            = 300
publish                            = false
enable_cloudwatch_log_subscription = false
cloudwatch_log_subscription        = {}
reserved_concurrent_executions     = "-1"
region                             = "eu-west-1"
cloudwatch_log_retention           = 90


vpc_config = {
  security_group_ids : [],
  subnet_ids : []
}

trigger = {
  type   = "s3",
  bucket = "product-bi-images-dev",
  # Workaraound for tf error: lookup() may only be used with flat maps, this map contains elements of type list in
  # use comma separated strings of events like "evennt1,event2,event3..."
  events     = "s3:ObjectCreated:Copy",
  principal  = "s3.amazonaws.com",
  source_arn = "arn:aws:s3:::product-bi-images-dev"
}

env_vars = {
  region             = "eu-west-1",
  destination_bucket = "product-bi-images-dev",
  image_prefix       = "image"
}
