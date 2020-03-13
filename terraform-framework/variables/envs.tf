# only env specifics go here - Change AWS account IDs to meet your environment
variable "envs" {
  type = map

  default = {

    dataops-dev = {
      account_id         = "111122223333"
      account            = "Dataops Dev Environment"
      workspace_iam_role = "arn:aws:iam::111122223333:role/administrator"
      region             = "eu-west-1"
      region_code        = "ew1"
      bucket_region      = "eu-west-1"
      bucket             = "dataops-dev-tf-infra-state"
      dynamodb           = "dataops-dev-tf-infra-state-lock"
    }

    dataops-staging = {
      account_id         = "222233334444"
      account            = "DataOps Staging Environment"
      workspace_iam_role = "arn:aws:iam::222233334444:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "dataops-staging-tf-infra-state"
      dynamodb           = "dataops-staging-tf-infra-state-lock"
    }

    dataops-prod = {
      account_id         = "333344445555"
      account            = "DataOps Production Environment"
      workspace_iam_role = "arn:aws:iam::333344445555:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "dataops-prod-tf-infra-state"
      dynamodb           = "dataops-prod-tf-infra-state-lock"
    }

    cloudops-dev = {
      account_id         = "444455556666"
      account            = "CloudOps Dev Environment"
      workspace_iam_role = "arn:aws:iam::444455556666:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "cloudops-dev-tf-infra-state"
      dynamodb           = "cloudops-dev-tf-infra-state-lock"
    }

  }
}
