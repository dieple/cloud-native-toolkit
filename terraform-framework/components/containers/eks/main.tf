provider "tls" {
  version = "~> 2.1"
}

provider "kubernetes" {
  version                = "1.10"
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket         = lookup(var.envs[terraform.workspace], "bucket")
    key            = format("env:/%s/%s/%s", terraform.workspace, "vpc", "terraform.tfstate")
    region         = lookup(var.envs[terraform.workspace], "bucket_region")
    dynamodb_table = lookup(var.envs[terraform.workspace], "dynamodb")
  }
}

module "tag_label_key" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = []
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "tag_label_eks" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["eks"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "8.0.0"

  cluster_name              = module.tag_label_eks.id
  cluster_enabled_log_types = var.cluster_enabled_log_types
  vpc_id                    = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets                   = data.terraform_remote_state.vpc.outputs.private_subnets
  enable_irsa               = var.enable_irsa

  node_groups_defaults      = {
    disk_size = var.worker_disk_size
    ami_type  = var.worker_ami_type
  }

  node_groups               = var.node_groups
  map_roles                 = var.map_roles
  tags                      = module.tag_label_eks.tags
}
