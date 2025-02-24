# globals "tofu" {
#   version = "1.8.5"
# }

# globals "terraform" {
#   version = "1.9.8"
# }

globals "terraform" "providers" "azurerm" {
  source   = "hashicorp/azurerm"
  version  = "~> 3.0"
  features = {}
}

globals "terraform" "backend" "azurerm" {
  resource_group_name  = "tfstate"
  storage_account_name = "tfstatexscz2"
  container_name       = "tfstate"
}
