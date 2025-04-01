data "azurerm_resource_group" "seeker_rg" {
  name = "seeker-rg"
}

data "azurerm_linux_function_app" "seeker_functions" {
  name                = "seeker-functions"
  resource_group_name = data.azurerm_resource_group.seeker_rg.name
}

data "azapi_resource_list" "seeker_function_app_functions" {
  type      = "Microsoft.Web/sites/functions@2022-09-01"
  parent_id = data.azurerm_linux_function_app.seeker_functions.id
}

data "azurerm_api_management" "seeker_apim" {
  name                = azurerm_api_management.seeker_apim.name
  resource_group_name = azurerm_api_management.seeker_apim.resource_group_name
}