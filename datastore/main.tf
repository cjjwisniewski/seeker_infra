resource "azurerm_storage_account" "seeker_datastore" {
  name                     = "seekerdatastore"
  resource_group_name      = data.azurerm_resource_group.seeker_rg.name
  location                 = data.azurerm_resource_group.seeker_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}