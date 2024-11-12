// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

variable "vnet_id" {
  type = any
}
variable "aks_subnet_id" {
  type = any
}
variable "vnet_subnet_id" {
  type = any
}
output "host" {
  value     = module.cluster.cluster_fqdn
  sensitive = false
}
output "client_certificate" {
  value     = module.cluster.client_certificate
  sensitive = true
}
output "client_key" {
  value     = module.cluster.client_key
  sensitive = true
}
output "cluster_ca_certificate" {
  value     = module.cluster.cluster_ca_certificate
  sensitive = true
}
