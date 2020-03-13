# Usage:
# BUCKET_NAME=platform-tf-platform-testing-infra-state REGION=eu-west-1 make plan
# to apply the above plan:
# BUCKET_NAME=platform-tf-platform-testing-infra-state REGION=make apply

REGION ?= eu-west-1
REGION_CONFIG = "region=$(REGION)"
VAR_CONFIG = "bucket_name=$(BUCKET_NAME)"
PLAN_FILE = tfplan
TF_PLAN_CMD = terraform plan -out $(PLAN_FILE) -var $(VAR_CONFIG) -var $(REGION_CONFIG)
TF_APPLY_CMD = terraform apply $(PLAN_FILE)

.PHONY: display-info
display-info:
	$(info *** TF_PLAN_CMD: $(TF_PLAN_CMD))

.PHONY: check-bucket
check-bucket:
ifndef BUCKET_NAME
  $(error BUCKET_NAME is not set. Set BUCKET_NAME=platform-tf-platform-testing-infra-state)
endif

.PHONY: check-region
check-region:
ifndef REGION
  $(error REGION is not set. Set REGION=eu-west-1)
endif

.PHONY: plan
plan: check-bucket check-region display-info
	@rm -f $(PLAN_FILE) && rm -rf .terraform
	@echo "Running terraform from CLI..."
	terraform init && $(TF_PLAN_CMD)


.PHONY: apply
apply: check-bucket check-region
	$(TF_APPLY_CMD)

