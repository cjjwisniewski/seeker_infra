resource "azurerm_linux_function_app" "createUserTable" {
  name                       = "seeker-createUserTable"
  location                   = data.azurerm_resource_group.seeker_rg.location
  resource_group_name        = data.azurerm_resource_group.seeker_rg.name
  storage_account_name       = data.azurerm_storage_account.seeker_storage_account.name
  storage_account_access_key = data.azurerm_storage_account.seeker_storage_account.primary_access_key
  service_plan_id            = data.azurerm_service_plan.seeker_service_plan.id
  https_only                 = true
  builtin_logging_enabled = false
  client_certificate_mode = "Required"
  ftp_publish_basic_authentication_enabled = false
  webdeploy_publish_basic_authentication_enabled = false
  app_settings = {
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
    "WEBSITE_RUN_FROM_PACKAGE"        = var.website_run_from_package
  }
  site_config {
    always_on = false
    ftps_state = "FtpsOnly"
    application_stack {
      python_version = "3.11"
    }
    cors {
      allowed_origins = [
        "https://portal.azure.com",
        "https://seeker.cityoftraitors.com"
      ]
      support_credentials = false
    }
  }
}