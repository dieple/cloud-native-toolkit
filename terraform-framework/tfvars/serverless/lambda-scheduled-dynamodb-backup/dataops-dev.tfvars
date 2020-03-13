lambda_src_artifact_filename       = "scheduled-dynamodb-backup.zip"
lambda_src_artifact_path           = "../../../lambda_artifacts"
function_name                      = "scheduled-dynamodb-backup"
handler                            = "scheduled-dynamodb-backup.lambda_handler"
description                        = "scheduled dynamodb backups"
memory_size                        = 128
runtime                            = "python3.7"
timeout                            = 300
publish                            = false
enable_cloudwatch_log_subscription = false
cloudwatch_log_subscription        = {}
reserved_concurrent_executions     = "-1"
cloudwatch_log_retention           = 90
max_backups_to_retain              = 3

//vpc_config = {
//  security_group_ids = [],
//  subnet_ids         = []
//}

trigger = {
  type                = "cloudwatch-event-schedule",
  schedule_expression = "cron(0 10 * * ? *)"
}
