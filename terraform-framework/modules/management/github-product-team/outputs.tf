output "gh_product_team" {
  value = github_team.default.*.id
}
