// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

output "vnet_subnet_id" {
  value     = module.network.vnet_subnets_name_id["aks"]
  sensitive = false
}
output "aks_subnet_id" {
  value     = module.network.vnet_subnets_name_id["aks"]
  sensitive = false
}
output "vnet_id" {
  value     = module.network.vnet_id
  sensitive = false
}
