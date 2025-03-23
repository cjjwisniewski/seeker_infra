resource "azurerm_app_service_plan" "seeker_asp" {
  name                = "ASP-seekerrg-8255"
  location            = data.azurerm_resource_group.seeker_rg.location
  resource_group_name = data.azurerm_resource_group.seeker_rg.name
  kind                = "FunctionApp"
  per_site_scaling    = false
  reserved            = true
  zone_redundant      = false
  sku {
    tier     = "Dynamic"
    size     = "Y1"
    capacity = 0
  }
}