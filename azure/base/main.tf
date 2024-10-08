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
  name                 = var.subnets.applications.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.applications.cidr]
}

# Sub-net kubernetes
resource "azurerm_subnet" "kubernetes" {
  name                 = var.subnets.kubernetes.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.kubernetes.cidr]
}

# Sub-net Databases
resource "azurerm_subnet" "databases" {
  name                 = var.subnets.databases.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.databases.cidr]
}

# Sub-net management
resource "azurerm_subnet" "management" {
  name                 = var.subnets.management.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.management.cidr]
}

# Sub-net public
resource "azurerm_subnet" "public" {
  name                 = var.subnets.public.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.public.cidr]
}
