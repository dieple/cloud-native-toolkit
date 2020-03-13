# settings for vault-dynamodb: https://www.vaultproject.io/docs/configuration/storage/dynamodb/
enable_autoscaler            = false
hash_key                     = "Path"
range_key                    = "Key"
autoscale_min_read_capacity  = 1
autoscale_min_write_capacity = 1
