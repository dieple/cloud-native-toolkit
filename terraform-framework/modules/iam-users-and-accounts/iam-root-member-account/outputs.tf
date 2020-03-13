// create switch role links for all accounts by using a crazy amount of interpolation
output "iam_switch_role_links" {
  value = merge(
      zipmap(
        formatlist("administrators-%s", keys(var.aws_account_ids)),
        formatlist("https://signin.aws.amazon.com/switchrole?account=%s&roleName=administrators", values(var.aws_account_ids))
      ),
      zipmap(
        formatlist("developers-%s", keys(var.aws_account_ids)),
        formatlist("https://signin.aws.amazon.com/switchrole?account=%s&roleName=developers", values(var.aws_account_ids))
      ),
      zipmap(
        formatlist("operations-%s", keys(var.aws_account_ids)),
        formatlist("https://signin.aws.amazon.com/switchrole?account=%s&roleName=operations", values(var.aws_account_ids))
      )
    )
}
