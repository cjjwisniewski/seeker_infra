data "azurerm_resource_group" "seeker_rg" {
  name = "seeker-rg"
}

data "azurerm_storage_account" "seeker_storage_account" {
  name                = "seekerinfrastorage"
  resource_group_name = data.azurerm_resource_group.seeker_rg.name
}

data "azurerm_service_plan" "seeker_service_plan" {
  name                = "ASP-seekerrg-8255"
  resource_group_name = data.azurerm_resource_group.seeker_rg.name
}