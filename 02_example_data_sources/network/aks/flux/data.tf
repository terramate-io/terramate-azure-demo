// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "terraform_remote_state" "cluster" {
  backend = "azurerm"
  config = {
    container_name       = "tfstate"
    key                  = "terraform/stacks/by-id/5d97b4f1-4e0a-4831-8ea8-ad2d1b90f7b5/terraform.tfstate"
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatexscz2"
  }
  depends_on = [
    null_resource.deployment_trigger,
  ]
}
resource "null_resource" "deployment_trigger" {
}
