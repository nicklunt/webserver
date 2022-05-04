locals {
  account_id = lower(var.account_id)
  environment    = lower(var.environment)
  region         = lower(var.region)
  region_short   = lower(var.region_short)
  product_name   = lower(var.product_name)
  product_owner  = lower(var.product_owner)
}

resource "aws_key_pair" "breakglass_keypair" {
  public_key = file(var.breakglass_ssh_key_path)
  key_name   = "aws-${local.environment}-z-z-z-keypair-z-breakglass-z"
  tags = {
    Name        = "aws-${local.environment}-z-z-z-keypair-z-breakglass-z"
    Product     = "${local.product_name}"
    Environment = "${local.environment}"
    Owner       = "${local.product_owner}"
  }
}

