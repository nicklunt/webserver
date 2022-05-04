#
# Standard / General variables
#

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

#
# Module specific variables
#

variable "vpc_function" {
  type        = string
  description = "one word describing what this vpc is for"
}

variable "vpc_cidr" {
  type        = string
  description = "the cidr of the this vpc"
}