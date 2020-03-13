product_team_data = {
  dataops_team_main = {
    name        = "DataOps"
    description = "This is the main product team group. No one needs to be a member of this"
    privacy     = "closed"
  },
  dataops_team_admin = {
    name        = "DataOps Admin"
    description = "Admin access to all product repos"
    privacy     = "closed"
  },
  dataops_team_read = {
    name        = "DataOps Read"
    description = "Read only access to all product repos"
    privacy     = "closed"
  },
  dataops_team_write = {
    name        = "DataOps Write"
    description = "Write access to all product repos"
    privacy     = "closed"
  }
  dataops_team_cd = {
    name        = "DataOps CD"
    description = "Write access to all product repos for CI/CD"
    privacy     = "closed"
  }
}