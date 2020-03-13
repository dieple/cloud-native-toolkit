provider "aws" {
  version = "~> 2.49"
  region  = lookup(var.envs[terraform.workspace], "region")

  assume_role {
    role_arn = lookup(var.envs[terraform.workspace], "workspace_iam_role")
  }
}

provider "aws" {
  alias   = "share_r53_iam_role"
  version = "~> 2.49"
  region  = lookup(var.envs[terraform.workspace], "region")

  assume_role {
    role_arn = lookup(var.envs[terraform.workspace], "share_r53_iam_role")
  }
}

provider "null" {
  version = "~> 2.0"
}

provider "local" {
  version = "~> 1.4"
}

provider "template" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}

provider "external" {
  version = "~> 1.2"
}
