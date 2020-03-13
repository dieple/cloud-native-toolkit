# route53-cluster-hostname

Terraform module to define a consistent AWS Route53 hostname


---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The Name of the route53 record | string | `dns` | no |
| records | Records | list | - | yes |
| ttl | The TTL of the record to add to the DNS zone to complete certificate validation | string | `300` | no |
| type | Type | string | `CNAME` | no |
| zone_id | Route53 DNS Zone id | string | `` | no |

## Outputs

| Name | Description |
|------|-------------|
| hostname | DNS hostname |


