data "aws_iam_policy_document" "administrators_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_iam_root_account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "developers_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_iam_root_account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "operations_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.aws_iam_root_account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_assume_role_policy" {
  count = length(var.aws_monitoring_account_ids) == 0 ? 0 : 1

  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "AWS"
      identifiers = [formatlist("arn:aws:iam::%s:root", var.aws_monitoring_account_ids)]
    }
  }
}

data "aws_iam_policy_document" "base" {
  statement {
    effect = "Allow"

    actions = [
      "support:*",
      "aws-portal:View*",
    ]

    resources = [
      "*",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "kms:Encrypt",
      "acm:RequestCertificate",
      "cloudwatch:DisableAlarmActions",
      "cloudwatch:EnableAlarmActions",
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "allow_all" {
  statement {
    effect = "Allow"

    actions = [
      "*",
    ]

    resources = [
      "*",
    ]
  }
}

// we must use a custom policy as the canned polices are used by the aws OrganizationAccountAccessRole which we need to use for now.
data "aws_iam_policy_document" "cloudwatch_allow_read" {
  count = length(var.aws_monitoring_account_ids) == 0 ? 0 : 1
  statement {
    effect = "Allow"

    actions = [
      "autoscaling:Describe*",
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*",
      "logs:Get*",
      "logs:Describe*",
      "sns:Get*",
      "sns:List*",
      "aws-portal:View*",
    ]

    resources = [
      "*",
    ]
  }

}

