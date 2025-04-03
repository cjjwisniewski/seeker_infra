resource "azurerm_storage_account" "seeker" {
  name                            = "seekercityoftraitorscom"
  resource_group_name             = data.azurerm_resource_group.seeker_rg.name
  location                        = data.azurerm_resource_group.seeker_rg.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  allow_nested_items_to_be_public = false
  https_traffic_only_enabled      = false
}

resource "azurerm_storage_account_static_website" "seeker" {
  storage_account_id = azurerm_storage_account.seeker.id
  index_document     = "index.html"
  error_404_document = "index.html"
}