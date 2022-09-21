terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.1.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = ">=0.6.0"
    }
  }
}

provider "azurerm" {
  features {}
}
