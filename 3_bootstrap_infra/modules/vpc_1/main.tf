locals {
  #
  # "Standard"/"Global" variables
  #
  environment   = lower(var.environment)
  region        = lower(var.region)
  region_short  = lower(var.region_short)
  product_name  = lower(var.product_name)
  product_owner = lower(var.product_owner)

  #
  # module specific variables
  #
  vpc_cidr = lower(var.vpc_cidr)
  vpc_function = lower(var.vpc_function)

}

resource "aws_vpc" "this" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "aws-${local.environment}-${local.region_short}-z-z-vpc-${local.product_name}-${local.vpc_function}-z"
    Owner       = local.product_owner
    Environment = local.environment
    Product     = local.product_name
  }
}

