# For each 60 seconds, get the stat. Sum the number previous evaluation_periods (every 60 seconds) and compare to the threshold
# foreach lambda, alert on lambda failures
resource "aws_cloudwatch_metric_alarm" "lambda_failures_minor" {
  alarm_name          = "${var.function_name}_lambda_failures_minor"
  alarm_actions       = [
    var.sns_minor_topic_arn]
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  period              = 60
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  threshold           = 1
  alarm_description   = "Lambda ${var.function_name} is failing"

  dimensions {
    FunctionName = var.function_name
  }
}

# alert on log errors
resource "aws_cloudwatch_log_metric_filter" "log_errors_filter" {
  count          = var.exclude_log_alerts ? 0 : 1
  name           = "${var.function_name}-error-log-filter"
  pattern        = "{ ($$.level = \"error\" ) }"
  log_group_name = var.log_group_name

  metric_transformation {
    name      = "${var.function_name}_log_error_count"
    namespace = "CustomLogs"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "log_errors_minor" {
  count               = var.exclude_log_alerts ? 0 : 1
  alarm_name          = "${var.function_name}_log_errors_minor"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "${var.function_name}_log_error_count"
  namespace           = "CustomLogs"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Lambda ${var.function_name} is erroring"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [
    var.sns_minor_topic_arn
  ]
}

# alert on log fatals
resource "aws_cloudwatch_log_metric_filter" "log_fatal_filter" {
  count          = var.exclude_log_alerts ? 0 : 1
  name           = "${var.function_name}-fatal-log-filter"
  pattern        = "{ ($$.level = \"fatal\" ) }"
  log_group_name = var.log_group_name

  metric_transformation {
    name      = "${var.function_name}_log_fatals_count"
    namespace = "CustomLogs"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "log_fatal_major" {
  count               = var.exclude_log_alerts ? 0 : 1
  alarm_name          = "${var.function_name}_log_fatals_major"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "${var.function_name}_log_fatals_count"
  namespace           = "CustomLogs"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Lambda ${var.function_name} is fataling"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [var.sns_major_topic_arn]
}

# alert on log panics
resource "aws_cloudwatch_log_metric_filter" "log_panic_filter" {
  count          = var.exclude_log_alerts ? 0 : 1
  name           = "${var.function_name}-panic-log-filter"
  pattern        = "?panic ?PANIC ?Panic"
  log_group_name = var.log_group_name

  metric_transformation {
    name      = "${var.function_name}_log_panics_count"
    namespace = "CustomLogs"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "log_panic_major" {
  count               = var.exclude_log_alerts ? 0 : 1
  alarm_name          = "${var.function_name}_log_panics_major"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "${var.function_name}_log_panics_count"
  namespace           = "CustomLogs"
  period              = 60
  statistic           = "Sum"
  threshold           = 1
  alarm_description   = "Lambda ${var.function_name} is panicking"
  treat_missing_data  = "notBreaching"
  alarm_actions       = [var.sns_major_topic_arn]
}

resource "aws_cloudwatch_metric_alarm" "throttling" {
  alarm_name          = "${var.function_name}_throttles"
  alarm_actions       = [var.sns_minor_topic_arn]
  metric_name         = "Throttles"
  namespace           = "AWS/Lambda"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 10
  period              = 120
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
  alarm_description   = "Lambda ${var.function_name} is throttling"
  threshold           = 1

  dimensions {
    FunctionName = var.function_name
  }
}
