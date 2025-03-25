// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "terraform_remote_state" "cluster" {
  backend = "azurerm"
  config = {
    container_name       = "tfstate"
    key                  = "terraform/stacks/by-id/537a789c-8f57-487e-bd26-9e6a43366c1b/terraform.tfstate"
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatexscz2"
  }
  depends_on = [
    null_resource.deployment_trigger,
  ]
}
resource "null_resource" "deployment_trigger" {
}
