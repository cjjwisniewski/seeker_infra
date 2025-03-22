resource "azurerm_storage_account" "seeker_infra_storage" {
  name                     = "seekerinfrastorage"
  resource_group_name      = data.azurerm_resource_group.seeker_rg.name
  location                 = data.azurerm_resource_group.seeker_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "seeker_infra_container" {
  name                  = "seeker-infra-container"
  storage_account_id    = azurerm_storage_account.seeker_infra_storage.id
  container_access_type = "private"
}