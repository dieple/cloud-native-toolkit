data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket         = lookup(var.envs[terraform.workspace], "bucket")
    key            = format("env:/%s/%s/%s", terraform.workspace, "eks", "terraform.tfstate")
    region         = lookup(var.envs[terraform.workspace], "bucket_region")
    dynamodb_table = lookup(var.envs[terraform.workspace], "dynamodb")
  }
}

data "terraform_remote_state" "dynamodb" {
  backend = "s3"
  config = {
    bucket         = lookup(var.envs[terraform.workspace], "bucket")
    key            = format("env:/%s/%s/%s", terraform.workspace, "dynamodb", "terraform.tfstate")
    region         = lookup(var.envs[terraform.workspace], "bucket_region")
    dynamodb_table = lookup(var.envs[terraform.workspace], "dynamodb")
  }
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["iam-role"]
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
  tags        = {}
}

module "external_dns_role" {
  source = "../../../modules/containers/eks-sa-iam-role"

  enabled            = var.create_ext_dns_role
  name               = var.ext_dns_role
  cluster_name       = data.aws_eks_cluster.cluster.name
  oidc_provider      = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  sa_ns              = var.ext_dns_ns
  sa_iam_policy_json = data.aws_iam_policy_document.ext_dns.json
  tags               = module.tag_label.tags
}

module "cert_manager_role" {
  source = "../../../modules/containers/eks-sa-iam-role"

  enabled            = var.create_cert_manager_role
  name               = var.cert_manager_role
  cluster_name       = data.aws_eks_cluster.cluster.name
  oidc_provider      = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  sa_ns              = var.cert_manager_ns
  sa_iam_policy_json = data.aws_iam_policy_document.letsencrypt.json
  tags               = module.tag_label.tags
}

module "autoscaler_role" {
  source = "../../../modules/containers/eks-sa-iam-role"

  enabled            = var.create_autoscaler_role
  name               = var.autoscaler_role
  cluster_name       = data.aws_eks_cluster.cluster.name
  oidc_provider      = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  sa_ns              = var.autoscaler_ns
  sa_iam_policy_json = data.aws_iam_policy_document.autoscaler.json
  tags               = module.tag_label.tags
}

module "vault_dynamodb_role" {
  source = "../../../modules/containers/eks-sa-iam-role"

  enabled            = var.create_vault_dynamodb_role
  name               = var.vault_dynamodb_role
  cluster_name       = data.aws_eks_cluster.cluster.name
  oidc_provider      = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  sa_ns              = var.vault_dynamodb_ns
  sa_iam_policy_json = data.aws_iam_policy_document.vault_dynamodb.json
  tags               = module.tag_label.tags
}

module "alb_ing_controller_role" {
  source = "../../../modules/containers/eks-sa-iam-role"

  enabled            = var.create_alb_ing_controller_role
  name               = var.alb_ing_controller_role
  cluster_name       = data.aws_eks_cluster.cluster.name
  oidc_provider      = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
  sa_ns              = var.alb_ing_controller_ns
  sa_iam_policy_json = data.aws_iam_policy_document.alb_ing_controller.json
  tags               = module.tag_label.tags
}

module "vault_iam_role" {
  source = "../../../modules/iam-users-and-accounts/iam-role"

  enabled            = var.create_vault_iam_role
  name               = format("%s-%s", module.tag_label.id, "vault")
  policy_description = "Allow Vault to Access Dynamodb"
  role_description   = "IAM role with permissions to perform actions on dynamodb resources"
  policy_documents   = [data.aws_iam_policy_document.vault_dynamodb.json]

  principals = {
    Service = ["ec2.amazonaws.com", "eks.amazonaws.com"]
  }

  tags = module.tag_label.tags
}
