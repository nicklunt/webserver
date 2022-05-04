variable "account_id" {
  description = "Account ID (number) of account in which to bootstrap the initial terraform resources"
  type        = string
}

variable "environment" {
  description = "Environment name to bootstrap (dev/qa/uat/prd)"
  type        = string
  validation {
    condition     = var.environment == "dev" || var.environment == "qa" || var.environment == "uat" || var.environment == "prd"
    error_message = "The environment value must be one of dev, qa, uat, prd."
  }
}

variable "product_name" {
  description = "Name of the account to bootstrap (product name like smonik)"
  type        = string
}

variable "product_owner" {
  description = "Owner of the product (person's short name)"
  type        = string
}

variable "region" {
  description = "Region being deployed (us-east-1)"
  type        = string
}

variable "region_short" {
  description = "Region being deployed (use1)"
  type        = string
}

variable "breakglass_ssh_key_path" {
  description = "File path for the breakglass ssh public key"
  type        = string
  sensitive   = true
}
