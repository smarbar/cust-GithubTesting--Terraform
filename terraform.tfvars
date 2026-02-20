resource_groups = {
  hub = {
    name = "TDR-DS-Hub-Network-rg"
  }
}

virtual_networks = {
  hub_vnet = {
    name           = "TDR-DS-Hub-VNet"
    resource_group = "hub"
    address_space  = ["10.100.0.0/20"]
    dns_servers    = ["10.100.0.4"]
  }
}

subnets = {
  firewall = {
    name           = "AzureFirewallSubnet"
    address_prefix = ["10.100.0.0/26"]
    vnet           = "hub_vnet"
  }
  bastion = {
    name           = "AzureBastionSubnet"
    address_prefix = ["10.100.0.64/26"]
    vnet           = "hub_vnet"
  }
  gateway = {
    name           = "GatewaySubnet"
    address_prefix = ["10.100.1.0/26"]
    vnet           = "hub_vnet"
  }
  zpa = {
    name           = "ZPA-Subnet"
    address_prefix = ["10.100.1.64/26"]
    vnet           = "hub_vnet"
  }
}
