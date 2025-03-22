terraform {
    backend "azurerm" {
        resource_group_name  = "seeker-rg"
        storage_account_name = "seekerinfrastorage"
        container_name       = "seeker-infra-container"
        key                  = "seeker-infra/resource_group.tfstate"
    }
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.0"
        }
    }
}

provider "azurerm" {
    features {}
    subscription_id = var.subscription_id
}