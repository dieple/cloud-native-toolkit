variable "name" {
  description = "The Name of the application or solution  (e.g. `bastion` or `portal`)"
  default     = "dns"
  type        = string
}

variable "zone_id" {
  default     = ""
  type        = string
  description = "Route53 DNS Zone id"
}

variable "records" {
  type        = list(string)
  description = "Records"
}

variable "type" {
  default     = "CNAME"
  description = "Type"
  type        = string
}

variable "ttl" {
  default     = 300
  type        = number
  description = "The TTL of the record to add to the DNS zone to complete certificate validation"
}
