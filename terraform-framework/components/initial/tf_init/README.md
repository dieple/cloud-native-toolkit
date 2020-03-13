# Usage

Current bucket naming convention we're are using for state file buckets name are:
* <account-name>-tf-infra-state

For example:
* dataops-dev-tf-infra-state
* dataops-staging-tf-infra-state
* dataops-prod-tf-infra-state
* cloudops-dev-tf-infra-state
* and so on

 Note that the dynamodb table created will be defaulted to
 "<above-bucket_name>-lock"

# Use the Makefile to build:

```bash
# to create initial Bucket for the Platform Testing account (region is optional and defaulted to eu-west-1):

# to plan & apply for the dataops-dev-tf-infra-state bucket:
BUCKET_NAME=dataops-dev-tf-infra-state REGION=eu-west-1 make plan
BUCKET_NAME=dataops-dev-tf-infra-state REGION=eu-west-1 make apply


# to plan & apply for the dataops-staging-tf-infra-state bucket:
BUCKET_NAME=dataops-staging-tf-infra-state REGION=eu-west-1 make plan
BUCKET_NAME=dataops-staging-tf-infra-state REGION=eu-west-1 make apply
```
