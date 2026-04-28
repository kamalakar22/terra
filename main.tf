terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
}

provider "azurerm" {
  features {}
}


# Generate random suffix
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "tf-rg-centralindia"
  location = "Central India"
}

# Storage Account
resource "azurerm_storage_account" "sa" {
  name                     = "tfstorage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "dev"
    location    = "centralindia"
    team        = "platform"
  }
  lifecycle {
    prevent_destroy = true
  }
}
