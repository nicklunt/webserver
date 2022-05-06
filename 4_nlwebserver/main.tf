locals {
  product_name  = lower(var.env_vars[var.environment].product_name)
  product_owner = lower(var.env_vars[var.environment].product_owner)
  environment   = lower(var.environment)
  region        = lower(var.env_vars[var.environment].region)
  region_short  = lower(var.env_vars[var.environment].region_short)

  data_subnet_id    = data.terraform_remote_state.infra_state.outputs.data_subnet_id
  ssh_key_pair_name = data.terraform_remote_state.secrets_state.outputs.ssh_key_pair_name
}

# Need to get outputs from other projects with terraform_remote_state 

data "terraform_remote_state" "infra_state" {
  backend = "s3"
  config = {
    bucket = "aws-${local.environment}-${local.region_short}-z-z-s3-${local.product_name}-terraformstate-z"
    key    = "${local.environment}-${local.product_name}-bootstrap-infra/terraform.tfstate"
    region = local.region
  }
}

data "terraform_remote_state" "secrets_state" {
  backend = "s3"
  config = {
    bucket = "aws-${local.environment}-${local.region_short}-z-z-s3-${local.product_name}-terraformstate-z"
    key    = "${local.environment}-${local.product_name}-bootstrap_secrets/terraform.tfstate"
    region = local.region
  }
}

module "test_linux_instance" {
  product_name  = lower(var.env_vars[var.environment].product_name)
  product_owner = lower(var.env_vars[var.environment].product_owner)
  environment   = lower(var.environment)
  region        = lower(var.env_vars[var.environment].region)
  region_short  = lower(var.env_vars[var.environment].region_short)

  source    = "./modules/ec2"
  ami       = "ami-0a1a5eea3d0f8c19e"
  subnet_id = local.data_subnet_id
  key_name  = local.ssh_key_pair_name
}