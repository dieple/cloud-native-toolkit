ext_dns_ns                     = "external-dns"
ext_dns_role                   = "external-dns"
letsencrypt_role               = "letsencrypt"
letsencrypt_ns                 = "letsencrypt"
autoscaler_role                = "autoscaler"
autoscaler_ns                  = "autoscaler"
eks_cluster_id                 = "data-ops-dev-eks"
vault_dynamodb_table           = "data-ops-dev-db"
vault_dynamodb_role            = "vault"
vault_dynamodb_ns              = "vault"
hosted_zone_id                 = "*"
create_ext_dns_role            = true
create_vault_dynamodb_role     = true
create_letsencrypt_role        = true
create_autoscaler_role         = true
create_vault_iam_role          = true
create_rds_monitoring_iam_role = true
create_alb_ing_controller_role = false
lambda_additional_policy_arns  = ["arn:aws:iam::aws:policy/service-role/AWSLambdaKinesisExecutionRole",
                                  "arn:aws:iam::aws:policy/service-role/AWSLambdaDynamoDBExecutionRole",
                                  "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
                                  "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"]
