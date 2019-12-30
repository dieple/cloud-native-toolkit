# cloud-native-toolkit

## Introduction

A python script to create, build and run the docker image. Once the docker image is up and running you'll get a bash shell as a local development environment on your host PC.
Within this repo you can perform Infrastructure as Code (IaC) using 
* [terrascript](https://github.com/mjuenema/python-terrascript)
* Ansible
* Kubernetes
* Helm
* Terraform
* AWS CLI
* coinbase/assume-role
* etc...

## Why would I wanna use this?

* Quick, easy and repeatable method to setup your local development environment.
* Isolated from your host PC. Don't have to worry about software version conflicts with your host environment. 
* Every developer using this tool will have the same version of software
* No more issues of "It works on my environment but not yours"

## Software installed
* Python3
* python-terraform --> provides a wrapper of `terraform` command line tool
* python-terrascript --> generates terraform code using python.
* Terraform binary (defaults to v0.11.7 for enactor development but can be overidden)
* Ansible  (defaults to v2.5.0 but can be overidden)
* AWS CLI
* AWS Vault --> Profiles, MFA and roles switching capability
* Kubectl
* Helm
* etc...

The packages are build using pip install if possible, further addons can be included during docker image build stage.

## Prerequisites

* Install docker on the host machine
* Python3 on host machine
* Create developer AWS IAM account, setup MFA on AWS console and noted down the MFA ARN.
* A note of your MFA ARN for use below
* A note of your AWS access keys which you created above for your IAM user in the AWS root account
* AWS client on your host machine
* aws-vault on your host machine
* Manually create file `$HOME/.aws/config` on your host machine with entries for the 
AWS accounts you want to access - see below
* Manually create `$HOME/{.kube, .aws, .terraform.d/plugin-cache, repos/golib, repos/go-workspace}` directory for external host volume links
* Personal SSH keys created on your host machine and added to your GitHub settings (the ability to clone repos using SSH)  

__`$HOME/.aws/config`__ 

To get started with this file, take the entries shown below 
and edit to match your IAM user, MFA and account IDs  

```
[default]
region=eu-west-1

[profile dev]
mfa_serial=arn:aws:iam::<mfa-aws-account-id>:mfa/aws_iam_account
role_arn=arn:aws:iam::<switch-role-aws-account-id>:role/developers

[profile staging]
mfa_serial=arn:aws:iam::<mfa-aws-account-id>:mfa/aws_iam_account
role_arn=arn:aws:iam::<switch-role-aws-account-id>:role/developers
```


### Steps

First, clone this repo:

```bash
$> mkdir -p $HOME/{.kube, .aws, .terraform.d/plugin-cache, repos/golib, repos/go-workspace/src, repos/go-workspace/bin, repos/go-workspace/pkg}
$> cd $HOME/repos
$> git clone https://github.com/dieple/cloud-native-toolkit.git toolkit
$> cd toolkit
$> ./run_toolkit.sh
```


### Assume Roles
```bash

#$> eval $(assume-role <aws-account-alias> <role-to-assume> YOUR-MFA-CODE)
$> eval $(assume-role dataops-staging administrator YOUR-MFA-CODE)
```

