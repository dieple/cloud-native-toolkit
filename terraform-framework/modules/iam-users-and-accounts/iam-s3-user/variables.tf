variable "name" {
  type        = string
  description = "Application or solution name (e.g. `app`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)"
}

variable "s3_actions" {
  type        = list(string)
  default     = ["s3:GetObject"]
  description = "Actions to allow in the policy"
}

variable "s3_resources" {
  type        = list(string)
  description = "S3 resources to apply the actions specified in the policy"
}

variable "force_destroy" {
  default     = false
  type        = bool
  description = "Destroy even if it has non-Terraform-managed IAM access keys, login profiles or MFA devices"
}

variable "path" {
  default     = "/"
  type        = string
  description = "Path in which to create the user"
}

variable "enabled" {
  default     = true
  type        = bool
  description = "Set to false to prevent the module from creating any resources"
}

variable "pgp_key" {
  default = "dummy"
  type    = string
}
