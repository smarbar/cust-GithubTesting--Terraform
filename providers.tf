terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.52.0"
    }
  }
  backend "azurerm" {
    use_oidc         = true
    use_azuread_auth = true
    # resource_group_name  = "rg"                    #resource group which is associated with the storage account
    # storage_account_name = "thisisatestsaacc"      #storage account name
    # container_name       = "tfstatefiles"          #container name
    key = "terraform.tfstate" #path and file name
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}
