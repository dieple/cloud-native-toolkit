data "aws_iam_policy_document" "administrators_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = formatlist("arn:aws:iam::%s:role/administrators", values(var.aws_account_ids))
  }
}

data "aws_iam_policy_document" "developers_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = formatlist("arn:aws:iam::%s:role/developers", values(var.aws_account_ids))
  }
}

data "aws_iam_policy_document" "operations_assume_role_policy" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole",
    ]

    resources = formatlist("arn:aws:iam::%s:role/operations", values(var.aws_account_ids))
  }
}