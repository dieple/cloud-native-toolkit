variable "product_team_data" {
  type = map(object({
    name        = string
    description = string
    privacy     = string
  }))
}