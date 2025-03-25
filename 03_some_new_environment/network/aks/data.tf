// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

data "terraform_remote_state" "vpc" {
  backend = "azurerm"
  config = {
    container_name       = "tfstate"
    key                  = "terraform/stacks/by-id/8ccdf7c4-b017-427d-b583-962e4e752322/terraform.tfstate"
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatexscz2"
  }
  depends_on = [
    null_resource.deployment_trigger,
  ]
}
resource "null_resource" "deployment_trigger" {
}
