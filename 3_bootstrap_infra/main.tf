
module "vpc_1" {
  source = "./modules/vpc_1"
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
  vpc_cidr     = lower(var.infra_vars[var.environment].vpc_1.vpc_cidr)
  vpc_function = lower(var.infra_vars[var.environment].vpc_1.vpc_function)
}

module "subnets_vpc_1" {
  source = "./modules/subnets_vpc_1"
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
  vpc_cidr           = lower(var.infra_vars[var.environment].vpc_1.vpc_cidr)
  vpc_function       = lower(var.infra_vars[var.environment].vpc_1.vpc_function)
  vpc_id             = module.vpc_1.vpc_id
  data_subnet_cidrs  = var.infra_vars[var.environment].vpc_1.data_subnet_cidr
  app_subnet_cidrs   = var.infra_vars[var.environment].vpc_1.app_subnet_cidr
  web_subnet_cidrs   = var.infra_vars[var.environment].vpc_1.web_subnet_cidr
  infra_subnet_cidrs = var.infra_vars[var.environment].vpc_1.infra_subnet_cidr
}

# module "security_groups" {
#   source = "./modules/security_groups"
#   #
#   # "Standard"/"Global" variables
#   #
#   # product_name  = lower(var.env_vars[var.environment].product_name)
#   # product_owner = lower(var.env_vars[var.environment].product_owner)
#   # environment   = lower(var.environment)
#   # region        = lower(var.env_vars[var.environment].region)
#   # region_short  = lower(var.env_vars[var.environment].region_short)

#   product_name  = lower(var.env_vars[var.environment].product_name)
#   product_owner = lower(var.env_vars[var.environment].product_owner)
#   environment   = lower(var.environment)
#   region        = lower(var.env_vars[var.environment].region)
#   region_short  = lower(var.env_vars[var.environment].region_short)

#   #
#   # module specific variables
#   #
#   security_groups = [
#     ["sg1", module.vpc_1.vpc_id],
#     ["sg2", module.vpc_1.vpc_id], 
#     ["sg3", module.vpc_1.vpc_id],
#   ]

#   #   sg     type      from   to      prot cidr_blocks
#   security_group_rules = [
#     ["sg1", "ingress", "443", "443", "tcp", "0.0.0.0/0"],
#     ["sg1", "ingress", "80", "80", "tcp", "0.0.0.0/0"],
#   ]
# }