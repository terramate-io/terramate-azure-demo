provider "azurerm" {
  features {}
}

data "terraform_remote_state" "cluster" {
  backend = "local"

  config = {
    path = "../terraform.tfstate"
  }

  depends_on = [null_resource.deployment_trigger]
}

# data "azurerm_kubernetes_cluster" "cluster" {
#   name                = "dev2-aks-cluster-aks"
#   resource_group_name = "${var.environment}-aks-env-out"

#   depends_on = [null_resource.deployment_trigger]
# }

resource "null_resource" "deployment_trigger" {}

provider "helm" {
  kubernetes {
    host                   = "https://${data.terraform_remote_state.cluster.outputs.host}"
    client_certificate     = base64decode(data.terraform_remote_state.cluster.outputs.client_certificate)
    client_key             = base64decode(data.terraform_remote_state.cluster.outputs.client_key)
    cluster_ca_certificate = base64decode(data.terraform_remote_state.cluster.outputs.cluster_ca_certificate)
  }
}

resource "helm_release" "flux" {
  repository       = "https://fluxcd-community.github.io/helm-charts"
  chart            = "flux2"
  name             = "flux2"
  namespace        = "flux-system"
  create_namespace = true

}
