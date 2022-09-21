resource "azurerm_container_registry" "acr" {
  name                = "acracrappsvctest${random_string.build-index.result}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Premium"
  admin_enabled       = true

}

resource "azapi_resource" "run_acr_task" {
  name      = azurerm_container_registry.acr.name
  location  = azurerm_resource_group.rg.location
  parent_id = azurerm_container_registry.acr.id
  type      = "Microsoft.ContainerRegistry/registries/taskRuns@2019-06-01-preview"
  body = jsonencode({
    properties = {
      runRequest = {
        type           = "DockerBuildRequest"
        sourceLocation = "https://github.com/Azure-Samples/docker-django-webapp-linux.git#master"
        dockerFilePath = "Dockerfile"
        platform = {
          os = "Linux"
        }
        imageNames = ["helloworld:{{.Run.ID}}", "helloworld:latest"]
      }
    }
  })
  ignore_missing_property = true
}

resource "azurerm_role_assignment" "acrpull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_linux_web_app.app.identity.0.principal_id
}
