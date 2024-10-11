# Generate a random string for resource names
resource "random_string" "random_name" {
  length  = 6
  special = false
  upper   = false
}

# Create a network interface for the virtual machine
resource "azurerm_network_interface" "nic" {
  name                = "${random_string.random_name.result}-${var.project}-${var.environment}-nic"
  location            = var.default_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${random_string.random_name.result}-${var.project}-${var.environment}-ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# Create a public IP address for the virtual machine
resource "azurerm_public_ip" "public_ip" {
  name                = "${random_string.random_name.result}-${var.project}-public-ip"
  location            = var.default_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  tags                = var.tags
}

# Create a Linux virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  count               = var.os_type == "Linux" ? 1 : 0
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.default_location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_public_key)
  }

  os_disk {
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

# Create a Windows virtual machine
resource "azurerm_windows_virtual_machine" "this" {
  count                 = var.os_type == "Windows" ? 1 : 0
  name                  = var.vm_name
  resource_group_name   = azurerm_resource_group.this.name
  location              = azurerm_resource_group.this.location
  size                  = var.vm_size
  admin_username        = var.admin_username
  admin_password        = var.admin_password
  network_interface_ids = [azurerm_network_interface.this.id]

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