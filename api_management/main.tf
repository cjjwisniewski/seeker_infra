##########################################################################
# Configure APIM
##########################################################################

resource "azurerm_api_management" "seeker_apim" {
  name                = "seeker-apim"
  location            = data.azurerm_resource_group.seeker_rg.location
  resource_group_name = data.azurerm_resource_group.seeker_rg.name
  publisher_name      = "City of Traitors"
  publisher_email     = "cameron@undo.is"
  sku_name            = "Consumption_0"
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_api_management_product" "seeker" {
  product_id            = "seeker"
  api_management_name   = azurerm_api_management.seeker_apim.name
  resource_group_name   = azurerm_api_management.seeker_apim.resource_group_name
  display_name          = "Seeker"
  description           = "Seeker API"
  subscription_required = true
  subscriptions_limit   = 1
  approval_required     = true
  published             = true
}

resource "azurerm_api_management_subscription" "seeker_subscription" {
  subscription_id     = "seeker-subscription"
  api_management_name = azurerm_api_management.seeker_apim.name
  resource_group_name = azurerm_api_management.seeker_apim.resource_group_name
  display_name        = "Seeker Subscription"
  product_id          = azurerm_api_management_product.seeker.id
  state               = "active"
}

resource "azurerm_api_management_api" "seeker_functions" {
  name                = "seeker-functions"
  api_management_name = azurerm_api_management.seeker_apim.name
  resource_group_name = azurerm_api_management.seeker_apim.resource_group_name
  revision            = "1"
  display_name        = "seeker-functions"
  path                = "seeker-functions"
  protocols           = ["https"]
  service_url         = "https://${data.azurerm_linux_function_app.seeker_functions.default_hostname}"
}


##########################################################################
# I could not figure out how to properly handle this so I just did it manually, need to revisit in the future. 
##########################################################################

#import {
#  for_each = { for item in local.filtered_http_triggered_functions : "${item.function_name}-${item.method}" => item }
#  to = azurerm_api_management_api_operation.function_operations[each.key]
#  id = "/subscriptions/048a0e12-7cce-4f7f-9585-5d0104767835/resourceGroups/seeker-rg/providers/Microsoft.ApiManagement/service/seeker-apim/apis/seeker-functions/operations/options-${each.key}"
#}
#
#resource "azurerm_api_management_api_operation" "function_operations" {
#  for_each = { for item in local.filtered_http_triggered_functions : "${item.function_name}-${item.method}" => item }
#
#  operation_id        = each.key
#  api_name            = azurerm_api_management_api.seeker_functions.name
#  api_management_name = azurerm_api_management_api.seeker_functions.api_management_name
#  resource_group_name = azurerm_api_management_api.seeker_functions.resource_group_name
#  display_name        = "${each.value.function_name}"
#  method              = each.value.method
#  url_template        = "/${each.value.function_name}"
#  description         = "Imported from function: ${each.value.function_name} - ${each.value.method}"
#}