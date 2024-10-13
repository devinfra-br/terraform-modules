# Specifies the location where Azure resources will be created (e.g., East US, West Europe)
variable "location" {
  description = "Azure region where resources will be deployed (e.g., East US, West Europe)"
  default     = ""
}

# Defines the name of the Azure Resource Group to hold all the resources
variable "resource_group_name" {
  description = "Name of the Azure Resource Group to create or use"
  default     = "rg-network"
}

# Defines the name of the Virtual Network (VNet)
variable "vnet_name" {
  description = "Name of the Virtual Network (VNet)"
  default     = ""
}

# Specifies the address space (CIDR block) for the Virtual Network
variable "vnet_cidr" {
  description = "CIDR block defining the address space for the Virtual Network (VNet)"
  default     = ""
}

# List of subnets to be created within the VNet, along with optional NAT Gateway and service delegation settings
variable "subnets" {
  description = "Map of subnets to be created in the VNet with options for NAT Gateway and service delegation"
  type = map(object({
    name    = string  # Name of the subnet
    cidr    = string  # CIDR block for the subnet
    use_nat_gateway = bool  # Determines whether the subnet should be associated with a NAT Gateway
    delegation = optional(object({
      name    = string  # Name of the delegation (optional)
      service_delegation = object({
        name    = string  # Service for delegation (e.g., Microsoft.DBforMySQL/flexibleServers)
        actions = list(string)  # List of actions permitted for the service delegation
      })
    }))
  }))
}

# Flag to determine if a NAT Gateway should be created
variable "create_nat_gateway" {
  description = "Boolean flag to control whether a NAT Gateway is created and associated with specific subnets"
  type        = bool
  default     = false
}

# Map of tags to be applied to all resources for identification and management purposes
variable "tags" {
  description = "Map of key-value pairs to associate tags with resources for identification and management"
  type        = map(string)
  default     = {}
}

# Name of the project to be used in naming conventions and tagging
variable "project" {
  description = "Project name to be used in resource naming and tagging"
  default     = ""
}

# Environment name to distinguish between different environments (e.g., dev, staging, prod)
variable "environment" {
  description = "Name of the environment (e.g., dev, staging, prod) to distinguish resource deployment environments"
  default     = ""
}
