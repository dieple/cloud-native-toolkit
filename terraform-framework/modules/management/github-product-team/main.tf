resource "github_team" "default" {
  for_each = var.product_team_data

  name        = each.value["name"]
  description = each.value["description"]
  privacy     = each.value["privacy"]
}
