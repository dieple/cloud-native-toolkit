// create iam group and policy for administrators and assign members
resource "aws_iam_group" "administrators" {
  name = "${var.project_name}-administrators"
}

resource "aws_iam_group_membership" "administrators" {
  name = "${var.project_name}-administrator-access-group"
  group = aws_iam_group.administrators.name

  users = [
    var.administrator_group_membership,
  ]
}

resource "aws_iam_group_policy" "administrators" {
  name   = "${var.project_name}-administrators-access-group"
  group  = aws_iam_group.administrators.id
  policy = data.aws_iam_policy_document.administrators_assume_role_policy.json
}

// create iam group and policy for developers and assign members
resource "aws_iam_group" "developers" {
  name = "${var.project_name}-developers"
}

resource "aws_iam_group_membership" "developers" {
  name  = "${var.project_name}-developer-access-group"
  group = aws_iam_group.developers.name

  users = [
    var.developer_group_membership,
  ]
}

resource "aws_iam_group_policy" "developers" {
  name   = "${var.project_name}-developers-access-group"
  group  = aws_iam_group.developers.id
  policy = data.aws_iam_policy_document.developers_assume_role_policy.json
}

// create iam group and policy for operations and assign members
resource "aws_iam_group" "operations" {
  name = "${var.project_name}-operations"
}

// assign users membership to groups
resource "aws_iam_group_membership" "operations" {
  name  = "${var.project_name}-administrator-access-group"
  group = aws_iam_group.operations.name

  users = [
    var.operations_group_membership,
  ]
}

resource "aws_iam_group_policy" "operations" {
  name   = "${var.project_name}-operations-access-group"
  group  = aws_iam_group.operations.id
  policy = data.aws_iam_policy_document.operations_assume_role_policy.json
}


