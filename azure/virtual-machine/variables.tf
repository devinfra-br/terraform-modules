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

variable "vnet_cidr" {
  description = "The CIDR block for the Virtual Network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the Virtual Machine (e.g., Standard_B2s)"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Admin username for the Virtual Machine"
  type        = string
}

variable "ssh_public_key" {
  description = "The path to the SSH public key to be used for the VM"
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
}

variable "os_type" {
  description = "The operating system type for the VM (Linux or Windows)."
  type        = string
}

variable "network_security_group_id" {
  description = "The ID of the network security group to associate with the VM."
  type        = string
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

variable "admin_password" {
  description = "Admin password for the Windows Virtual Machine"
  type        = string
}