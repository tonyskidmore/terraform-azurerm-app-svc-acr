data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "rg-acrappsvctest-${random_string.build-index.result}"
  location = var.location
}

resource "random_string" "build-index" {
  length  = 6
  special = false
  upper   = false
}
