stack {
  name        = "01_network"
  description = "Main VPC managed on Azure"
  id          = "f20c9067-70ef-4489-8a70-9d1580ab67f7"
}

output "vnet_subnet_id" {
  backend   = "terraform"
  value     = module.network.vnet_subnets_name_id["aks"]
  sensitive = false
}

output "aks_subnet_id" {
  backend   = "terraform"
  value     = module.network.vnet_subnets_name_id["aks"]
  sensitive = false
}

output "vnet_id" {
  backend   = "terraform"
  value     = module.network.vnet_id
  sensitive = false
}
