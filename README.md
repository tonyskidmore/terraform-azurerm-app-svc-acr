# Overview

Examples of Azure App Service with Azure Container Registry as the container registry to serve up container images.  Each directory represents a different method of authenticating to ACR form App Service.

## Prerequisites

* Azure Subscription
* [Terraform CLI](https://www.terraform.io/downloads)
* [Authenticate Terraform to Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash)

Running from [Azure Cloud Shell](https://shell.azure.com) will meet all of the above requirements

_Note:_  
`Owner` or `Contributor` + `User Access Administrator` permissions on the target subscription is required.

| directory                | description                                                           |
|--------------------------|-----------------------------------------------------------------------|
| app-svc-acr-admin-creds  | Using ACR with admin credentials and use those to authenticate to ACR |
| app-svc-acr-smi          | Uses System Assigned Managed Identity to authenticate to ACR          |
| app-svc-acr-umi          | Using User Assigned Managed Identity to authenticate to ACR           |


````bash

git clone https://github.com/tonyskidmore/terraform-azurerm-app-svc-acr.git
cd terraform-azurerm-app-svc-acr/terraform

cd /terraform/<one-of-the-above-directories>

terraform init
terraform plan -out tfplan
terraform apply tfplan

````

Test accessing the website using the `website` value from Terraform outputs and review the created Azure resources.  

Remember to destroy the resources created.

````bash


terraform plan -destroy -out tfplan
terraform apply tfplan

````

_Note:_

This is only for demonstration purposes and does not represent good practice in terms of Terraform code construction or securely setting up Azure resources.
