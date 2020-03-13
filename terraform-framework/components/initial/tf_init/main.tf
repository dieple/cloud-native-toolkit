provider "aws" {
  version = "2.45"
  region  = var.region
}

resource "aws_s3_bucket" "tfstate" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "tflocks" {
  name         = format("%s-%s", var.bucket_name, "lock")
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
