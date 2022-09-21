resource "azurerm_service_plan" "asp" {
  name                = "aspacrappsvctest-${random_string.build-index.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

resource "azurerm_linux_web_app" "app" {
  name                = "appacrappsvctest-${random_string.build-index.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  app_settings = {
    "DOCKER_REGISTRY_SERVER_URL"      = azurerm_container_registry.acr.login_server
    "DOCKER_REGISTRY_SERVER_USERNAME" = azurerm_container_registry.acr.admin_username
    "DOCKER_REGISTRY_SERVER_PASSWORD" = azurerm_container_registry.acr.admin_password
    "DOCKER_ENABLE_CI"                = true
    "WEBSITES_PORT"                   = "8000"
  }

  site_config {

    always_on = "true"

    application_stack {
      docker_image     = "${azurerm_container_registry.acr.login_server}/helloworld"
      docker_image_tag = "latest"
    }
  }

  logs {
    application_logs {
      file_system_level = "Error"
    }
    http_logs {
      file_system {
        retention_in_days = "30"
        retention_in_mb   = "100"
      }
    }
  }

  identity {
    type = "SystemAssigned"
  }

  depends_on = [
    azapi_resource.run_acr_task
  ]
}
