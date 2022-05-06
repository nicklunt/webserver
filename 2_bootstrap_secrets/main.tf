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

