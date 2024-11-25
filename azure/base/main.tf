# Generates a random string for resource naming to ensure uniqueness
resource "random_string" "this" {
  length  = 6
  special = false
  upper   = false
}

# Virtual Network (VNet) configuration
resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = [var.vnet_cidr]  # Address range for the VNet
  tags                = var.tags  # Tags for resource management
}

# Subnet creation within the VNet
resource "azurerm_subnet" "subnets" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.cidr]  # Address range for the subnet

  # Delegation block, applied only if delegation is defined for the subnet
  dynamic "delegation" {
     for_each = each.value.delegation != null ? [each.value.delegation] : []
    content {
      name = delegation.value.name

      # Service delegation actions
      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = try(delegation.value.service_delegation.actions)
      }
    }
  }
}

## NAT Gateway Configuration

# Public IP for the NAT Gateway
resource "azurerm_public_ip" "this" {
  count               = var.create_nat_gateway ? 1 : 0  # Create Public IP only if NAT Gateway is enabled
  name                = "nat-gtw-${var.project}-${var.environment}-${random_string.this.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"  # Static IP allocation for the NAT Gateway
  sku                 = "Standard"
  tags                = var.tags
}

# NAT Gateway resource
resource "azurerm_nat_gateway" "this" {
  count               = var.create_nat_gateway ? 1 : 0  # Create NAT Gateway only if enabled
  name                = "nat-gtw-${var.project}-${var.environment}-${random_string.this.result}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags  # Tags for resource management
}

# Associate Public IP with NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "this" {
  count                = var.create_nat_gateway ? 1 : 0  # Associate only if NAT Gateway is created
  nat_gateway_id       = azurerm_nat_gateway.this[0].id  # NAT Gateway ID
  public_ip_address_id = azurerm_public_ip.this[0].id  # Public IP ID
}

# Associate Subnets with NAT Gateway
resource "azurerm_subnet_nat_gateway_association" "nat_association" {
  for_each       = { for key, value in var.subnets : key => value if value.use_nat_gateway }  # Associate only subnets that require NAT Gateway
  subnet_id      = azurerm_subnet.subnets[each.key].id  # Subnet ID
  nat_gateway_id = azurerm_nat_gateway.this[0].id  # NAT Gateway ID
}
