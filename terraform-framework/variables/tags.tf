# common everywhere defined variables - to reduce DRY
variable "enabled" {}
variable "customer" {}
variable "product" {}
variable "environment" {}
variable "delimiter" {}
variable "cost_centre" {}
variable "attributes" {
  default = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
