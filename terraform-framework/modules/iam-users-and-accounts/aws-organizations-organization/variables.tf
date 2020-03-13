variable "aws_service_access_principals" {
  type    = list(string)
  default = null
  description = "List of AWS service principal names for which you want to enable integration with your organization. This is typically in the form of a URL, such as service-abbreviation.amazonaws.com. Organization must have feature_set set to ALL. For additional information, see the AWS Organizations User Guide."
}

variable "enabled_policy_types" {
  type    = list(string)
  default = null
  description = "List of Organizations policy types to enable in the Organization Root. Organization must have feature_set set to ALL. For additional information about valid policy types (e.g. SERVICE_CONTROL_POLICY), see the AWS Organizations API Reference."
}

variable "feature_set" {
  type    = string
  default = "ALL"
  description = "Specify 'ALL' (default) or 'CONSOLIDATED_BILLING'"
}
