variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "default_location" {
  description = "The Azure location where the resources will be deployed"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}


variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "project" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "value"
}

variable "os_type" {
  description = "The operating system type for the VM (Linux or Windows)."
  type        = string
  default     = "Linux"
}

variable "linux_image_publisher" {
  description = "The image publisher for the Linux VM."
  type        = string
  default     = "Canonical"
}

variable "linux_image_offer" {
  description = "The image offer for the Linux VM."
  type        = string
  default     = "UbuntuServer"
}

variable "linux_image_sku" {
  description = "The image SKU for the Linux VM."
  type        = string
  default     = "20.04-LTS"
}

variable "windows_image_publisher" {
  description = "The image publisher for the Windows VM."
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "windows_image_offer" {
  description = "The image offer for the Windows VM."
  type        = string
  default     = "WindowsServer"
}

variable "windows_image_sku" {
  description = "The image SKU for the Windows VM."
  type        = string
  default     = "2019-Datacenter"
}

variable "subnet_name" {
  description = "The name of the subnet to deploy the VMs"
  type        = string
}

variable "vms" {
  type = map(object({
    prefix         = string
    vm_size        = string
    os_type        = string
    admin_username = string
    admin_password = string # Only for Windows
    ssh_public_key = string # Only for Linux
  }))
  description = "A map of virtual machines to create"
}

variable "resource_group_name_vnet" {
  description = "The name of the resource group where the Virtual Network is located"
  type        = string
}