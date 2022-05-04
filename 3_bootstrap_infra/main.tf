terraform {

  backend "s3" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.55"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
  }

  required_version = ">= 0.14.7"
}

provider "aws" {
  region = var.env_vars[var.environment].region
}

module "vpc_1" {
  source        = "./modules/vpc_1"
  #
  # "Standard"/"Global" variables
  #
  product_name  = lower(var.env_vars[var.environment].product_name)
  product_owner = lower(var.env_vars[var.environment].product_owner)
  environment   = lower(var.environment)
  region        = lower(var.env_vars[var.environment].region)
  region_short  = lower(var.env_vars[var.environment].region_short)

  #
  # module specific variables
  #
  vpc_cidr = lower(var.env_vars[var.environment].vpc_1.vpc_cidr)
  vpc_function = lower(var.env_vars[var.environment].vpc_1.vpc_function)
}
