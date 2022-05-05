terraform {

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

  default_tags {
    tags = {
      Product     = lower(var.env_vars[var.environment].product_name)
      Owner       = lower(var.env_vars[var.environment].product_owner)
      Environment = lower(var.environment)
    }
  }
}
