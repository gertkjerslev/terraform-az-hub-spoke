# Hub network
module "hubnetwork" {
    source              = "./modules/network"
    vnet_name           = var.hub_vnet_name
    resource_group_name = "homelab-${var.hub_vnet_name}-rg"
    location            = "westeurope"
    address_space       = "10.0.0.0/16"
    subnet_prefixes     = ["10.0.1.0/26", "10.0.2.0/24", "10.0.3.0/24"]
    subnet_names        = ["AzureFirewallSubnet", "ManagementSubnet", "SharedServices"]
}

# Spoke1 network
module "spoke1network" {
    source              = "./modules/network"
    vnet_name           = var.spoke1_vnet_name
    resource_group_name = "homelab-${var.spoke1_vnet_name}-rg"
    location            = "westeurope"
    address_space       = "10.100.0.0/16"
    subnet_prefixes     = ["10.100.1.0/24", "10.100.2.0/24"]
    subnet_names        = ["spokesubnet1", "spokesubnet2"]
}


# Peerings
resource "azurerm_virtual_network_peering" "hubspoke1" {
  name                      = "hubspoke1"
  resource_group_name       = "homelab-${module.hubnetwork.vnet_name}-rg"
  virtual_network_name      = module.hubnetwork.vnet_name
  remote_virtual_network_id = module.spoke1network.vnet_id
}

resource "azurerm_virtual_network_peering" "spoke1hub" {
  name                      = "spoke1hub"
  resource_group_name       = "homelab-${module.spoke1network.vnet_name}-rg"
  virtual_network_name      = module.spoke1network.vnet_name
  remote_virtual_network_id = module.hubnetwork.vnet_id
  allow_forwarded_traffic   = true
}