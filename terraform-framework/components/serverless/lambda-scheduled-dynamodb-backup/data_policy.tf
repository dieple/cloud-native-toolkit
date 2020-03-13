data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]
    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
  statement {
    actions = [
      "dynamodb:CreateBackup",
      "dynamodb:DeleteBackup",
      "dynamodb:ListBackups",
    ]
    resources = [
      "*",
    ]
  }
}
