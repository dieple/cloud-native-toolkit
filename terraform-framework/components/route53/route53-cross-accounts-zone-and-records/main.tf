module "tag_label" {
  source = "../../../modules/core/tagging"

  enabled     = var.enabled
  customer    = var.customer
  product     = var.product
  environment = var.environment
  attributes  = []
  delimiter   = var.delimiter
  cost_centre = var.cost_centre
}

resource "aws_route53_zone" "default" {
  name          = var.zone_name
  tags          = module.tag_label.tags
  force_destroy = true
}

resource "aws_route53_record" "default" {
  name            = var.zone_name
  zone_id         = var.root_share_zone_id
  ttl             = 300
  type            = "NS"
  allow_overwrite = true

  # Assume role on platform-shared
  provider =  aws.share_r53_iam_role

  records = [
    aws_route53_zone.default.name_servers[0],
    aws_route53_zone.default.name_servers[1],
    aws_route53_zone.default.name_servers[2],
    aws_route53_zone.default.name_servers[3],
  ]
}