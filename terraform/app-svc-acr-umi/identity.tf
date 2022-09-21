resource "azurerm_user_assigned_identity" "uami" {
  name                = "idacrappsvctest-${random_string.build-index.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}
