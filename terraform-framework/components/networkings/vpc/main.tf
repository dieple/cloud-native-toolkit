module "tag_label_vpc" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = ["vpc"]
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

module "vpc" {
  source = "../../../modules/networkings/vpc"

  name                   = module.tag_label_vpc.id
  cidr                   = var.cidr
  azs                    = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnet_suffix   = var.public_subnet_suffix
  private_subnet_suffix  = var.private_subnet_suffix
  database_subnet_suffix = var.database_subnet_suffix
  public_subnets         = var.public_subnets
  private_subnets        = var.private_subnets
  database_subnets       = var.database_subnets
  enable_nat_gateway     = var.enable_nat_gateway
  one_nat_gateway_per_az = var.one_nat_gateway_per_az
  enable_dns_hostnames   = var.enable_dns_hostnames
  enable_dns_support     = var.enable_dns_support
  enable_s3_endpoint     = var.enable_s3_endpoint
  region_code            = lookup(var.envs[terraform.workspace], "region_code")

  tags = module.tag_label_vpc.tags

  vpc_tags = {
    "kubernetes.io/cluster/${module.tag_label_eks.id}" = var.shared_tag
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${module.tag_label_eks.id}" = var.shared_tag
    "kubernetes.io/role/elb"                           = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${module.tag_label_eks.id}" = var.shared_tag
    "kubernetes.io/role/internal-elb"                  = "1"
  }
}
