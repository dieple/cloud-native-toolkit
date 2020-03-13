variable "cidr" {}
variable "public_subnet_suffix" {}
variable "private_subnet_suffix" {}
variable "database_subnet_suffix" {}
variable "enable_nat_gateway" {}
variable "one_nat_gateway_per_az" {}
variable "enable_dns_hostnames" {}
variable "enable_dns_support" {}
variable "enable_s3_endpoint" {}
variable "shared_tag" {}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "database_subnets" {
  type = list(string)
}
