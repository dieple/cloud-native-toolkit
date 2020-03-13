variable "sns_minor_topic_arn" {
  description = "The arn of the minor sns topic"
}

variable "sns_major_topic_arn" {
  description = "The arn of the major sns topic"
}

variable "function_name" {
  description = "The name of the function to monitor"
}

variable "log_group_name" {
  description = "The name of the log group to monitor for errors, fatals and panics"
}

variable "exclude_log_alerts" {
  default     = "false"
  description = "Specify whether you want to exclude logging alerts"
}
