// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "terraform/stacks/by-id/dafc1b6e-d5d3-42df-ae1f-da762bc5f8f8/terraform.tfstate"
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatexscz2"
    use_oidc             = true
  }
}
