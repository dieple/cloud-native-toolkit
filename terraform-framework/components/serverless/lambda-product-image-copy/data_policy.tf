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
      "cloudwatch:*",
      "s3:Get*",
      "s3:List*",
      "s3:Put*",
    ]
    resources = [
      "arn:aws:s3:::product-images-*",
      "arn:aws:s3:::product-images-*/*",
    ]
  }
}
