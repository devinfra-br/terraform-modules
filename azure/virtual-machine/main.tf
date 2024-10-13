# Generate a random string for resource names
resource "random_string" "random_name" {
  for_each = var.vms
  length   = 6
  special  = false
  upper    = false
}

data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name_vnet
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = var.resource_group_name_vnet
}

# Create public IPs for each VM
resource "azurerm_public_ip" "this" {
  for_each            = var.vms
  name                = "public-ip-vm-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
  location            = var.default_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  tags                = var.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "this" {
  for_each            = var.vms
  name                = "net-sg-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
  location            = var.default_location
  resource_group_name = var.resource_group_name
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags
}

# Create a network interface for each VM
resource "azurerm_network_interface" "this" {
  for_each            = var.vms
  name                = "nic-vm-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
  location            = var.default_location
  resource_group_name = var.resource_group_name
  ip_configuration {
    name                          = "ipconfig-vm-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
    subnet_id                     = data.azurerm_subnet.this.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.this[each.key].id
  }
  tags = var.tags
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "this" {
  for_each                  = var.vms
  network_interface_id      = azurerm_network_interface.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}

# Create Linux VMs
resource "azurerm_linux_virtual_machine" "this" {
  for_each            = { for key, vm in var.vms : key => vm if vm.os_type == "Linux" }
  name                = "vm-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
  computer_name       = "vm-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
  resource_group_name = var.resource_group_name
  location            = var.default_location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username

  network_interface_ids = [
    azurerm_network_interface.this[each.key].id,
  ]
  admin_ssh_key {
    username   = each.value.admin_username
    public_key = file(each.value.ssh_public_key)
  }

  os_disk {
    name                 = "osdisk-vm-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.linux_image_publisher
    offer     = var.linux_image_offer
    sku       = var.linux_image_sku
    version   = "latest"
  }

  tags = var.tags

}

# Create Windows VMs
resource "azurerm_windows_virtual_machine" "this" {
  for_each            = { for key, vm in var.vms : key => vm if vm.os_type == "Windows" }
  name                = "vm-${each.value.prefix}-${var.project}-${var.environment}-${random_string.random_name[each.key].result}"
  resource_group_name = var.resource_group_name
  location            = var.default_location
  size                = each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password      = each.value.admin_password
  network_interface_ids = [
    azurerm_network_interface.this[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.windows_image_publisher
    offer     = var.windows_image_offer
    sku       = var.windows_image_sku
    version   = "latest"
  }

  tags = var.tags

}
