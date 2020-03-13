lambda_src_artifact_filename       = "enable-vpc-flow-logs.zip"
lambda_src_artifact_path           = "../../../lambda_artifacts"
function_name                      = "enable-vpc-flow-logs"
//layers                             = []
handler                            = "enable-vpc-flow-logs.lambda_handler"
description                        = "Search and enable VPC flow logs"
memory_size                        = 128
runtime                            = "python3.7"
timeout                            = 300
publish                            = false
enable_cloudwatch_log_subscription = false
cloudwatch_log_subscription        = {}
reserved_concurrent_executions     = "-1"
cloudwatch_log_retention           = 90

//vpc_config = {
//  security_group_ids = [],
//  subnet_ids         = []
//}

trigger = {
  type                = "cloudwatch-event-schedule",
  schedule_expression = "cron(0 10 * * ? *)"
}
