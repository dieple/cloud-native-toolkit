variable "enabled" {
  description = "Set to false to prevent the module from creating any resources"
  default     = true
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `namespace`, `name`, `stage` and `attributes`"
}

variable "customer" {
}

variable "product" {
}

variable "environment" {
  description = "`prod`, `staging`, `dev`, or `test`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes, e.g. `1`"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map(`BusinessUnit`,`XYZ`)"
}

variable "convert_case" {
  description = "Convert fields to lower case"
  default     = true
}

variable "cost_centre" {
  default = ""
}
