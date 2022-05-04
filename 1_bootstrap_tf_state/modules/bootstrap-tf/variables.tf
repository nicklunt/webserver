variable "account_id" {
  description = "Account ID (number) of account in which to bootstrap the initial terraform resources"
}

variable "environment" {
  description = "Environment name to bootstrap (dev/qa/uat/prd)"
}

variable "product_name" {
  description = "Name of the account to bootstrap (product name like smonik)"
}

variable "product_owner" {
  description = "Owner of the product (person's short name)"
}

variable "region" {
  description = "Region being deployed (us-east-1)"
}

variable "region_short" {
  description = "Region being deployed (use1)"
}

# variable "aws_profile" {
#   type        = string
#   description = "aws profile see C:/Users/<user>/.aws/crededtials file if you have profile setup"
# }
