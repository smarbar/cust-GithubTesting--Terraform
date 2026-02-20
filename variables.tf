variable "SUBSCRIPTION_ID" {
  type        = string
  description = "The subscription ID for the Azure resources"
  default = "52d833a0-2430-4b44-8d96-60ba7d2e8e4f"
}

variable "resource_groups" {
  description = "A map of resource group configurations."
  type = map(object({
    name = string
  }))
}


variable "virtual_networks" {
  type = map(object({
    name           = string
    resource_group = string
    address_space  = list(string)
    dns_servers    = list(string)
  }))
}

variable "subnets" {
  type = map(object({
    name                              = string
    address_prefix                    = list(string)
    vnet                              = string
    private_endpoint_network_policies = optional(string, null)
    service_delegations               = optional(map(map(list(string))), {})
    service_endpoints                 = optional(list(string), [])
  }))
}
