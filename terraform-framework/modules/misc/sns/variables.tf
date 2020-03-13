variable "create_sns_topic" {
  description = "Whether to create the SNS topic"
  type        = bool
  default     = true
}

variable "sns_topic_name" {
  description = "The name of the SNS topic to create"
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "display_name" {}
