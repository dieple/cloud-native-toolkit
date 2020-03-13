variable "lambda_src_artifact_filename" {
  type = string
}

variable "function_name" {}

variable "layers" {
  description = "List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function."
  type        = list(string)
  default     = null
}

variable "handler" {
  type = string
}

variable "description" {
  type = string
}

variable "memory_size" {
  type = number
}

variable "runtime" {
  type = string
}

variable "timeout" {
  type = number
}

variable "publish" {
  type    = bool
  default = false
}

variable "vpc_config" {
  description = "Provide this to allow your function to access your VPC."
  type = object({
    security_group_ids = list(string)
    subnet_ids         = list(string)
  })
  default = null
}

variable "trigger" {
  type = map(string)
}

variable "enable_cloudwatch_log_subscription" {
  type    = bool
  default = false
}

variable "cloudwatch_log_subscription" {
  type    = map(string)
  default = {}
}

variable "reserved_concurrent_executions" {
  type = number
}

variable "cloudwatch_log_retention" {
  type = number
}

variable "additional_policy_arns" {
  description = "Optional additional attached IAM policy ARNs."
  type        = list(string)
  default     = []
}

variable "lambda_src_artifact_path" {
  type    = string
}

variable "source_code_hash" {
  description = "Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key."
  type        = string
  default     = null
}