output "account_ids" {
  // edit to meet your actual env
  value = {
    "root"                  = "000000000000"
    "iam"                   = "111111111111"
    "management"            = "222222222222"
    "payment_dev"           = "333333333333"
    "payment_staging"       = "444444444444"
    "payment_prod"          = "555555555555"
    "dataops_dev"           = "666666666666"
    "dataops_stage"         = "777777777777"
    "dataops_prod"          = "888888888888"
    "cloudops_dev"          = "999999999999"
    "cloudops_stage"        = "101010101010"
    "cloudops_prod"         = "202020202020"
    "platform_dev"          = "303030303030"
    "platform_stage"        = "404040404040"
    "platform_prod"         = "505050505050"
    "monitoring"            = "606060606060"
  }
}
