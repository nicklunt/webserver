# terraform {

#   backend "s3" {}

#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "3.55"
#     }
#     tls = {
#       source  = "hashicorp/tls"
#       version = "3.1.0"
#     }
#   }

#   required_version = ">= 0.14.7"
# }

# provider "aws" {
#   region = var.env_vars[var.environment].region
# }

#
# SET permissions for Jenkins
#

module "iam" {
  source = "./modules/iam"

  account_id    = var.env_vars[var.environment].account_id
  product_name  = var.env_vars[var.environment].product_name
  product_owner = var.env_vars[var.environment].product_owner
  environment   = var.environment
  region        = var.env_vars[var.environment].region
  region_short  = var.env_vars[var.environment].region_short

  jenkins_controller_pub_cidr_blocks = var.env_vars[var.environment].jenkins_controller_pub_cidr_blocks
}

#
#  Set KMS
#

module "kms" {
  source = "./modules/kms"

  account_id    = var.env_vars[var.environment].account_id
  product_name  = var.env_vars[var.environment].product_name
  product_owner = var.env_vars[var.environment].product_owner
  environment   = var.environment
  region        = var.env_vars[var.environment].region
  region_short  = var.env_vars[var.environment].region_short
}

#
# Set SSH key
#
module "ssh" {
  source = "./modules/ssh"

  account_id    = var.env_vars[var.environment].account_id
  product_name  = var.env_vars[var.environment].product_name
  product_owner = var.env_vars[var.environment].product_owner
  environment   = var.environment
  region        = var.env_vars[var.environment].region
  region_short  = var.env_vars[var.environment].region_short

  breakglass_ssh_key_path = var.env_vars[var.environment].breakglass_ssh_key_path
}

