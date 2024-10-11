# Azure VM Terraform Module

This Terraform module automates the creation and management of Virtual Machines (VMs) in Microsoft Azure. It supports various configurations, including VM size, storage options, and networking configurations.

## Table of Contents

- [Requirements](#requirements)
- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [License](#license)
- [Author Information](#author-information)

## Requirements

- Terraform >= 1.0
- Azure CLI
- Azure Provider

## Usage

To use this module, include it in your Terraform configuration as follows:

```hcl
module "azure_vm" {
  source                  = "./path_to_module/azure-vm-module"
  resource_group_name     = "my-resource-group"
  location                = "East US"
  vm_name                 = "myVM"
  os_type                 = "Linux"  # Ou "Windows"
  vm_size                 = "Standard_DS1_v2"
  admin_username          = "azureuser"
  admin_password          = "YourPassword123!"
  subnet_id               = azurerm_subnet.my_subnet.id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}
```

## Inputs

| Variable                       | Description                                               | Type        | Default                             |
|--------------------------------|-----------------------------------------------------------|-------------|-------------------------------------|
| `resource_group_name`          | The name of the resource group.                           | `string`    |                                     |
| `location`                     | The Azure location where the resources will be created.  | `string`    |                                     |
| `vm_name`                      | The name of the virtual machine.                          | `string`    |                                     |
| `os_type`                      | The operating system type for the VM (Linux or Windows). | `string`    |                                     |
| `vm_size`                      | The size of the virtual machine.                          | `string`    |                                     |
| `admin_username`               | The admin username for the VM.                            | `string`    |                                     |
| `admin_password`               | The admin password for the VM.                            | `string`    |                                     |
| `subnet_id`                    | The ID of the subnet where the VM will be deployed.      | `string`    |                                     |
| `network_security_group_id`    | The ID of the network security group to associate with the VM. | `string` |                                     |
| `linux_image_publisher`        | The image publisher for the Linux VM.                     | `string`    | `"Canonical"`                      |
| `linux_image_offer`            | The image offer for the Linux VM.                         | `string`    | `"UbuntuServer"`                   |
| `linux_image_sku`              | The image SKU for the Linux VM.                           | `string`    | `"20.04-LTS"`                      |
| `windows_image_publisher`      | The image publisher for the Windows VM.                   | `string`    | `"MicrosoftWindowsServer"`         |
| `windows_image_offer`          | The image offer for the Windows VM.                       | `string`    | `"WindowsServer"`                  |
| `windows_image_sku`            | The image SKU for the Windows VM. 

## Outputs

| Output Name      | Description                                           |
|------------------|-------------------------------------------------------|
| `vm_id`          | The ID of the virtual machine.                        |
| `public_ip`      | The public IP address of the virtual machine.        |
| `admin_username`  | The admin username for the virtual machine.          |

License
This project is licensed under the MIT License - see the LICENSE file for details.

Author Information
Created by Wilton Guilherme - wiltoninfra@gmail.com