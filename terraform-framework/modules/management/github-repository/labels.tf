resource "github_issue_label" "default" {
  for_each = local.label_data

  repository  = local.repository
  name        = each.value["name"]
  color       = each.value["color"]
  description = each.value["description"]
}