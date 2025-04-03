data "azurerm_resource_group" "seeker_rg" {
  name = "seeker-rg"
}

data "azurerm_client_config" "current" {}