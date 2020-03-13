variable "aws_account_ids" {
  type        = map(string)
  description = "AWS account IDs that users should be allowed access to"
}

variable "administrator_group_membership" {
  type        = list(string)
  description = "list of members of the administrator group"
  default     = []
}

variable "developer_group_membership" {
  type        = list(string)
  description = "list of members of the developer group"
  default     = []
}

variable "operations_group_membership" {
  type        = list(string)
  description = "list of members of the operations group"
  default     = []
}

variable "project_name" {
  type        = string
  description = "name of the project"
}
