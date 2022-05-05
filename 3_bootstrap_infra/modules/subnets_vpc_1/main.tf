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
  vpc_cidr     = lower(var.vpc_cidr)
  vpc_function = lower(var.vpc_function)


}

resource "aws_subnet" "data" {
  count      = length(var.data_subnet_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.data_subnet_cidrs[count.index]
  # availability_zone = var.availability_zone

  tags = {
    Name = "aws-${local.environment}-${local.region_short}-z-z-datasubnet${count.index}-${local.product_name}-${local.vpc_function}-z"
  }
}

resource "aws_subnet" "app" {
  count      = length(var.app_subnet_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.app_subnet_cidrs[count.index]
  # availability_zone = var.availability_zone

  tags = {
    Name = "aws-${local.environment}-${local.region_short}-z-z-appsubnet${count.index}-${local.product_name}-${local.vpc_function}-z"
  }
}

resource "aws_subnet" "web" {
  count      = length(var.web_subnet_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.web_subnet_cidrs[count.index]
  # availability_zone = var.availability_zone

  tags = {
    Name = "aws-${local.environment}-${local.region_short}-z-z-websubnet${count.index}-${local.product_name}-${local.vpc_function}-z"
  }
}

resource "aws_subnet" "infra" {
  count      = length(var.infra_subnet_cidrs)
  vpc_id     = var.vpc_id
  cidr_block = var.infra_subnet_cidrs[count.index]
  # availability_zone = var.availability_zone

  tags = {
    Name = "aws-${local.environment}-${local.region_short}-z-z-infrasubnet${count.index}-${local.product_name}-${local.vpc_function}-z"
  }
}
