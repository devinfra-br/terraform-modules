# IP Público para o Bastion Host
resource "azurerm_public_ip" "bastion_public_ip" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  #sku                 = "Basic"
  tags                = var.tags
}

resource "azurerm_virtual_network" "bastion_vnet" {
  name                = "mngvnet"
  address_space       = ["192.168.1.0/24"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.bastion_vnet.name
  address_prefixes     = ["192.168.1.224/27"]

}

# Azure Bastion Host (implantado na subnet 'management')
resource "azurerm_bastion_host" "bastion" {
  name                = var.bastion_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Developer"

  ip_configuration {
    name                 = "bastion_ip_config"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.bastion_public_ip.id
  }

  depends_on = [
    azurerm_public_ip.bastion_public_ip
  ]
  tags = var.tags
}

# Network Security Group (NSG) para o Bastion
resource "azurerm_network_security_group" "bastion_nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-Bastion-SSH-RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags
}

# Associar NSG à sub-rede Management
resource "azurerm_subnet_network_security_group_association" "bastion_nsg_association" {
  subnet_id                 = var.management_subnet_id
  network_security_group_id = azurerm_network_security_group.bastion_nsg.id

}
