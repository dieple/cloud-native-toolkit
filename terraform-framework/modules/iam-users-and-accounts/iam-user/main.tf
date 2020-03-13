resource "aws_iam_user" "user" {
  name          = var.user
  force_destroy = true
}

resource "aws_iam_user_login_profile" "user" {
  user    = var.user
  pgp_key = var.pgp_key
}

data "aws_caller_identity" "current" {}

data "template_file" "base_policy" {
  template = file("${path.module}/policies/base_policy.json.tpl")

  vars {
    account_id = data.aws_caller_identity.current.account_id
  }
}

resource "aws_iam_user_policy" "base" {
  name       = "base-policy"
  user       = var.user
  policy     = data.template_file.base_policy.rendered
  depends_on = ["aws_iam_user.user"]
}
