terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.52.0"
    }
  }
  # required_version = "1.2"
}

provider "azurerm" {
  features {}
  subscription_id = var.SUBSCRIPTION_ID
}
