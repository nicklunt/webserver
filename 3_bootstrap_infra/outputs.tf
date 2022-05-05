output "data_subnet_id" {
  value = module.subnets_vpc_1.data_subnet_id
}

output "app_subnet_id" {
  value = module.subnets_vpc_1.app_subnet_id
}

output "web_subnet_id" {
  value = module.subnets_vpc_1.web_subnet_id
}

output "infra_subnet_id" {
  value = module.subnets_vpc_1.infra_subnet_id
}