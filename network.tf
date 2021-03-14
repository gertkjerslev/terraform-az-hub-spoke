module "hubnetwork" {
    source              = "./modules/network"
    vnet_name           = var.hub_vnet_name
    resource_group_name = "homelab-${var.hub_vnet_name}-rg"
    location            = "westeurope"
    address_space       = "10.0.0.0/16"
    subnet_prefixes     = ["10.0.1.0/26", "10.0.2.0/24", "10.0.3.0/24"]
    subnet_names        = ["AzureFirewallSubnet", "ManagementSubnet", "SharedServices"]
}