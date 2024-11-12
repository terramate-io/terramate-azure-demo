stack {
  name        = "01_aks"
  description = "Managed Kubernetes cluster on Azure"
  id          = "d0901d9c-0854-4af8-b0ca-813a63d1aaac"

  after = ["../network"]
}

globals {
  dependend_stack_id = "f20c9067-70ef-4489-8a70-9d1580ab67f7"
}

# Generated Inputs for this stack

input "vnet_id" {
  backend = "terraform"
  value   = outputs.vnet_id.value
  mock    = "7a967208-8745-4f11-bae0-ca28de7f20a0"
  # from_stack_id = "f20c9067-70ef-4489-8a70-9d1580ab67f7" # Just use a global...
  from_stack_id = global.dependend_stack_id
}

input "aks_subnet_id" {
  backend       = "terraform"
  value         = outputs.aks_subnet_id.value
  mock          = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
  from_stack_id = global.dependend_stack_id
}

input "vnet_subnet_id" {
  backend       = "terraform"
  value         = outputs.vnet_subnet_id.value
  mock          = "/subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/example-resource-group/providers/Microsoft.Network/virtualNetworks/virtualNetworksValue/subnets/subnetValue"
  from_stack_id = global.dependend_stack_id
}

# Generated Outputs for this stack

output "host" {
  backend   = "terraform"
  value     = module.cluster.cluster_fqdn
  sensitive = false
}

output "client_certificate" {
  backend   = "terraform"
  value     = module.cluster.client_certificate
  sensitive = true
}

output "client_key" {
  backend   = "terraform"
  value     = module.cluster.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  backend   = "terraform"
  value     = module.cluster.cluster_ca_certificate
  sensitive = true
}
