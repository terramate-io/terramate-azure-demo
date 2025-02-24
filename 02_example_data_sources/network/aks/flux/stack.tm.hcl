stack {
  name        = "02_flux"
  description = "Flux Controller deployed via Helm in Kubernetes"
  id          = "2ac5c655-b876-44dd-8ab7-137d07e67097"
}

globals "terraform" "providers" "helm" {
  source   = "hashicorp/helm"
  version  = "~> 2.17"
}
