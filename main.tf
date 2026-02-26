resource "azurerm_resource_group" "rg" {
  #sec test 9
  for_each = var.resource_groups
  name     = each.value.name
  location = local.location
  tags     = local.tags
}

resource "azurerm_virtual_network" "vnets" {
  #checkov:skip=CKV_AZURE_183: "Ensure that VNET uses local DNS addresses"
  for_each            = var.virtual_networks
  name                = each.value.name
  location            = local.location
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group].name
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = local.tags
}

resource "azurerm_subnet" "subnets" {
  #checkov:skip=CKV2_AZURE_31: "Ensure VNET subnet is configured with a Network Security Group (NSG)"
  for_each                          = var.subnets
  name                              = each.value.name
  resource_group_name               = azurerm_virtual_network.vnets[each.value.vnet].resource_group_name
  virtual_network_name              = azurerm_virtual_network.vnets[each.value.vnet].name
  address_prefixes                  = each.value.address_prefix
  private_endpoint_network_policies = each.value.private_endpoint_network_policies
  service_endpoints                 = each.value.service_endpoints

  dynamic "delegation" {
    for_each = each.value.service_delegations
    content {
      name = delegation.key

      dynamic "service_delegation" {
        for_each = delegation.value
        content {
          name = service_delegation.key
          # actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
          actions = service_delegation.value
        }
      }
    }
  }
}
