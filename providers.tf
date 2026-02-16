terraform{
  required_providers{
    azurerm ={
      source  ="hashicorp/azurerm"
      version ="~>4.52.0"
    }
  }
}

provider"azurerm"{
  features{}
  subscription_id = var.PLATFORM1_SUBSCRIPTION_ID
}
provider "azurerm" {
  alias = "mgmt"
  subscription_id = var.MANAGEMENT_SUBSCRIPTION_ID
  features {}
}
provider "azurerm" {
  alias = "idty"
  subscription_id = var.IDENTITY_SUBSCRIPTION_ID
  features {}
}
provider "azurerm" {
  alias = "cnct"
  subscription_id = var.CONNECTIVITY_SUBSCRIPTION_ID
  features {}
}
# provider "azurerm" {
#   alias = "plat2"
#   subscription_id = var.PLATFORM2_SUBSCRIPTION_ID
#   features {}
# }
# provider "azurerm" {
#   alias = "app1"
#   subscription_id = var.APP1_SUBSCRIPTION_ID
#   features {}
# }
# provider "azurerm" {
#   alias = "app2"
#   subscription_id = var.APP2_SUBSCRIPTION_ID
#   features {}
# }