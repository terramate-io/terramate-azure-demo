stack {
  name        = "02_flux"
  description = "Flux Controller deployed via Helm in Kubernetes"
  id          = "a439892f-be31-46b7-a5eb-40799eee97f0"
}

globals "terraform" "providers" "helm" {
  source  = "hashicorp/helm"
  version = "~> 2.17"
}
