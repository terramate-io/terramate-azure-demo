stack {
  name        = "01_flux"
  description = "Flux Controller deployed via Helm in Kubernetes"
  id          = "6cd87f96-218f-4a72-8be1-88104b460c05"

  after = ["../network", "../aks"]
}

globals "terraform" "providers" "helm" {
  source  = "hashicorp/helm"
  version = "~> 2.17"
}

# Generated Inputs for this stack

globals {
  dependend_stack_id = "d0901d9c-0854-4af8-b0ca-813a63d1aaac"
}

input "cluster_fqdn" {
  backend = "terraform"
  value   = outputs.host.value
  mock    = "some-id.hcp.eastus.azmk8s.io"
  # from_stack_id = "f20c9067-70ef-4489-8a70-9d1580ab67f7" # Just use a global...
  from_stack_id = global.dependend_stack_id
}

input "client_certificate" {
  backend       = "terraform"
  value         = outputs.client_certificate.value
  mock          = "c29tZS1rZXk="
  from_stack_id = global.dependend_stack_id
}

input "client_key" {
  backend       = "terraform"
  value         = outputs.client_key.value
  mock          = "c29tZS1rZXk="
  from_stack_id = global.dependend_stack_id
}

input "cluster_ca_certificate" {
  backend       = "terraform"
  value         = outputs.cluster_ca_certificate.value
  mock          = "c29tZS1rZXk="
  from_stack_id = global.dependend_stack_id
}
