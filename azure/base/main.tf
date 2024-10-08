# Grupo de recursos
# Rede Virtual
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

# Sub-rede applications
resource "azurerm_subnet" "applications" {
  name                 = var.subnets.frontend.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.frontend.cidr]
}

# Sub-net kubernetes
resource "azurerm_subnet" "kubernetes" {
  name                 = var.subnets.backend.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.backend.cidr]
}

# Sub-net Databases
resource "azurerm_subnet" "databases" {
  name                 = var.subnets.data.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.data.cidr]
}

# Sub-net management
resource "azurerm_subnet" "management" {
  name                 = var.subnets.data.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.data.cidr]
}

# Sub-net public
resource "azurerm_subnet" "public" {
  name                 = var.subnets.data.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.data.cidr]
}
