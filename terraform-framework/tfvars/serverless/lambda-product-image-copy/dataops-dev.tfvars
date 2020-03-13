lambda_src_artifact_filename       = "product-image-copy.zip"
lambda_src_artifact_path           = "../../../lambda_artifacts"
function_name                      = "product-image-copy"
handler                            = "product-image-copy.lambda_handler"
description                        = "Product image copy"
memory_size                        = 128
runtime                            = "python3.7"
timeout                            = 300
publish                            = false
enable_cloudwatch_log_subscription = false
cloudwatch_log_subscription        = {}
reserved_concurrent_executions     = "-1"
cloudwatch_log_retention           = 90



trigger = {
  type       = "s3",
  bucket     = "product-images-dev",
  events     = "s3:ObjectCreated:Copy",
  principal  = "s3.amazonaws.com",
  source_arn = "arn:aws:s3:::product-images-dev"
}
