// TERRAMATE: GENERATED AUTOMATICALLY DO NOT EDIT

terraform {
  backend "azurerm" {
    container_name       = "tfstate"
    key                  = "terraform/stacks/by-id/d6c3abcb-a820-432b-afbe-7742945f3245/terraform.tfstate"
    resource_group_name  = "tfstate"
    storage_account_name = "tfstatexscz2"
    use_oidc             = true
  }
}
