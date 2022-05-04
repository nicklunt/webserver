#
# This file is sym linked to 
#   1_bootstrap_tf_state/global_vars.tf
#   2_bootstrap_secrets/global_vars.tf
#   3_bootstrap_product/global_vars.tf
#   4_product_name/global_vars.tf
#


variable "environment" {
  description = "Environment name to bootstrap (dev/qa/uat/prd)"
  type        = string
  default     = "dev"
  validation {
    condition     = var.environment == "dev" || var.environment == "qa" || var.environment == "uat" || var.environment == "prd"
    error_message = "The environment value must be one of dev, qa, uat, prd."
  }
}

variable "env_vars" {
  description = "Variables for each environment"

  type = map(any)

  default = {
    "dev" = {
      account_id                         = "721826909603"
      product_name                       = "webserver"
      product_owner                      = "dvagner"
      region                             = "us-east-1"
      region_short                       = "use1"
      jenkins_access                     = false # Not currently deployed from jenkins
      jenkins_controller_pub_cidr_blocks = ["69.176.99.242/32", "100.37.24.191"]
      breakglass_ssh_key_path            = "./aws-dev-templateproduct-keyPair.pub"
    }
    "qa" = {
      account_id                         = "721826909603"
      product_name                       = "webserver"
      product_owner                      = "dvagner"
      region                             = "us-east-1"
      region_short                       = "use1"
      jenkins_access                     = false # Not currently deployed from jenkins
      jenkins_controller_pub_cidr_blocks = ["69.176.99.242/32", "100.37.24.191"]
      breakglass_ssh_key_path            = "./aws-qa-templateproduct-keyPair.pub"
    }
    "uat" = {
      account_id                         = "721826909603"
      product_name                       = "webserver"
      product_owner                      = "dvagner"
      region                             = "us-east-1"
      region_short                       = "use1"
      jenkins_access                     = false # Not currently deployed from jenkins
      jenkins_controller_pub_cidr_blocks = ["69.176.99.242/32", "100.37.24.191"]
      breakglass_ssh_key_path            = "./aws-uat-templateproduct-keyPair.pub"
    }
    "prd" = {
      account_id                         = "721826909603"
      product_name                       = "webserver"
      product_owner                      = "dvagner"
      region                             = "us-east-1"
      region_short                       = "use1"
      jenkins_access                     = false # Not currently deployed from jenkins
      jenkins_controller_pub_cidr_blocks = ["69.176.99.242/32", "100.37.24.191"]
      breakglass_ssh_key_path            = "./aws-prd-templateproduct-keyPair.pub"
    }
    # "vpc_1" = {
    #   vpc_function     = "test" # one word describing what this vpc is for
    #   vpc_cidr         = "10.140.16.0/20"
    #   data_subnet_cidr = ["10.140.20.0/23", "10.140.22.0/23"]
    # }
  }
}

variable "infra_vars" {
  description = "Variables for bootstrap_product infra"

  type = map(any)

  default = {
    "dev" = {
      vpc_cidr         = "10.140.16.0/20"
      data_subnet_cidr = ["10.140.20.0/23", "10.140.22.0/23"]
    }
    "qa" = {
      vpc_cidr         = "10.140.16.0/20"
      data_subnet_cidr = ["10.140.24.0/23", "10.140.26.0/23"]
    }
    "uat" = {
      vpc_cidr         = "10.140.16.0/20"
      data_subnet_cidr = ["10.140.28.0/23", "10.140.30.0/23"]
    }
    "prd" = {
      vpc_cidr         = "10.140.16.0/20"
      data_subnet_cidr = ["10.140.32.0/23", "10.140.34.0/23"]
    }
  }
}