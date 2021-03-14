# Azure Hub and Spoke deployment

This will deploy a spimple hub and spoke architectire. Greate for a quick PoC up and running.

# Requirements

* Terraform 0.14.x
* Hashicorp/azurerm 2.46.0
* Az CLI - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli

# Disclaimer 
This deployment will introduce a cost on your subscription

# Usage
```azurecli
Az login
Az account set -s <subscription id>
```

Change the variables in the terraform.tfvars file to you preference.

```
Terraform init
Terraform plan -out=<your plan name>
Terraform apply <your plan name>
```

# Clean up
Rember to clean up when you are done :-)

```
Terraform destroy
```