
// This is just definition.
// The actual values should be set in ./env_vars/<env>.tfvars

variable "account_id" {
  description = "AWS Account ID for the account to be dpeloyed to"
}

variable "environment" {
  description = "The account environment name, e.g. dev/qa/uat/prd"
  validation {
    condition     = var.environment == "dev" || var.environment == "qa" || var.environment == "uat" || var.environment == "prd"
    error_message = "The environment value must be one of dev, qa, uat, prd."
  }
}

variable "product_name" {
  description = "Name of the product being deployed"
}

variable "product_owner" {
  description = "Owner of the product (person's short name)"
}

variable "region" {
  description = "Region being deployed (us-east-1)"
}

variable "region_short" {
  description = "Shortened region name (use1)"
}

variable "jenkins_controller_pub_cidr_blocks" {
  description = "CIDR blocks of jenkins controller public ip's for AWS API access"
}
