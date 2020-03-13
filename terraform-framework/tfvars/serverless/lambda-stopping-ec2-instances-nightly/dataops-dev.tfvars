lambda_src_artifact_filename       = "stopping-ec2-instances-nightly.zip"
lambda_src_artifact_path           = "../../../lambda_artifacts"
function_name                      = "stopping-ec2-instances-nightly"
//layers                             = []
handler                            = "stopping-ec2-instances-nightly.lambda_handler"
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
  schedule_expression = "cron(30 23 * * ? *)"
}
