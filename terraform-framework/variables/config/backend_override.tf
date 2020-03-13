terraform {
  required_version = ">= 0.12.6"

  backend "s3" {
    encrypt = true
  }
}
