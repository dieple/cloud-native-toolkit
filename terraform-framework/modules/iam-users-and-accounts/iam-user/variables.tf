variable "user" {
  description = "User to create in AWS."
  type        = string
}

variable "pgp_key" {
  description = "pgp_key used to encrypt the user's password."
  type        = string
}
