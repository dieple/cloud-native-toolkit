# terraform-framework

### Intro
The aim of this repo is to reduce the terraform boiler plate code by using modules. All hard coded values
between environments are extracted out into tfvars files. The concept is to develop the terraform
module once and have it deploy everywhere without changing the underline terraform codes.

When a new environment is required the consumers of this repo can create a couple of tfvars files
and re-used existing terraform code to build on the new environment.

###  To build a new VPC on new-env-name:
* Edit the file variables/envs.tf and add the following section as shown below.
Note that the new-env-name label is the new terraform "workspace" (environment) you wanted to build
```hcl-terraform
new-env-name = {
      account_id         = "111111111111"
      account            = "New Environment Description"
      workspace_iam_role = "arn:aws:iam::111111111111:role/administrator"
      region_code        = "ew1"
      region             = "eu-west-1"
      bucket_region      = "eu-west-1"
      bucket             = "new-env-tf-infra-state"
      dynamodb           = "new-env-tf-infra-state-lock"
    }
```
* Create a file tfvars/vpc/<new-env-name>.tfvars to contain the following entries
(modified the values according to meet your environment);
```hcl-terraform
cidr                    = "10.0.0.0/16"
public_subnets          = ["10.0.0.0/22", "10.0.4.0/22", "10.0.8.0/22"]
private_subnets         = ["10.0.16.0/22", "10.0.20.0/22", "10.0.24.0/22"]
database_subnets        = ["10.0.32.0/22", "10.0.36.0/22", "10.0.40.0/22"]
public_subnet_suffix    = "public"
private_subnet_suffix   = "private"
database_subnet_suffix  = "database"
enable_nat_gateway      = true
one_nat_gateway_per_az  = true
enable_dns_hostnames    = true
enable_dns_support      = true
# VPC endpoint for S3
enable_s3_endpoint      = true
shared_tag = "shared"
```

* Create a file tfvars/taggings/<new-env-name>.tfvars to contains the following entries: (Modified to meet you actual env)
Note that this is used for consistent naming and taggings of resources.

```hcl-terraform
###############################
# Variables added to aws tags #
###############################
customer    = "data"
product     = "ops"
environment = "dev"
cost_centre = "platform-engineering"
################################

```
* Use the tfplan.py script to build your VPC
```bash
# to display help message:
.tfplan.py --help
usage: tfplan.py [-h] -a ACTION [-c CICD] [-p APPROVE]

Required arguments:
  -a ACTION, --action ACTION
                        Terraform action:--> plan, apply, plan-destroy, or
                        apply-destroy

optional arguments:
  -h, --help            show this help message and exit
  -c CICD, --cicd CICD  CI mode?
  -p APPROVE, --approve APPROVE
                        Auto approve?

$ #to plan a module and follow the on screen prompt
$ ./tfplan.py -a plan
# select the account to build
# select module(s) to build
# follow instructions on screen
```

Similarly, follow the same concept to build the EKS, modules, etc on your new workspace <new-env-name>

