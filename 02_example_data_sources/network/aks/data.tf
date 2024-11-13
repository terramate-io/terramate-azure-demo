// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "terraform_remote_state" "vpc" {
  backend = "azurerm"
  config = {
    container_name       = "tfstate"
    key                  = "terraform/stacks/by-id/5999e860-86d6-49b6-aa18-c91df7586483/terraform.tfstate"
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatexscz2"
  }
  depends_on = [
    null_resource.deployment_trigger,
  ]
}
resource "null_resource" "deployment_trigger" {
}
