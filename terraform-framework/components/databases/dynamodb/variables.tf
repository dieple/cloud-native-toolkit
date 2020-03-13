variable "hash_key" {}
variable "range_key" {}
variable "enable_autoscaler" {}
variable "autoscale_min_read_capacity" {}
variable "autoscale_min_write_capacity" {}

variable "dynamodb_attributes" {
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "local_secondary_index_map" {
  type = list(object({
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
  }))
  default = []
}

variable "global_secondary_index_map" {
  type = list(object({
    hash_key           = string
    name               = string
    non_key_attributes = list(string)
    projection_type    = string
    range_key          = string
    read_capacity      = number
    write_capacity     = number
  }))
  default = []
}
