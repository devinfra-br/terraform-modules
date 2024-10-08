# Description: Variables for the Azure Kubernetes Service (AKS) module
# Author: Wilton Guilherme
# Date: 2024-10-08

# Default location for deploying resources in Azure
variable "default_location" {
  type        = string
  description = "Default location for deploying resources in Azure"
  default     = "westus3"
}

# Flag to use 'for_each' in resource creation
variable "use_for_each" {
  type        = bool
  description = "Boolean flag to use 'for_each' in resource creation (true/false)"
  default     = true
}

# Name of the resource group
variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources for categorization or billing"
  default     = {}
}

# Map of labels to be applied to all Kubernetes nodes for resource identification
variable "node_labels" {
  type        = map(string)
  description = "Labels to be applied to all Kubernetes nodes for resource identification"
  default     = {}
}

# Name of the project to associate with the resources
variable "project" {
  type        = string
  description = "Name of the project to associate with the resources"
  default     = ""
}

# Environment name (e.g., dev, staging, prod)
variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod) where the resources will be deployed"
  default     = ""
}

# Name of the AKS cluster
variable "vm_size" {
  description = "Size of the Virtual Machine for AKS nodes"
  type        = string
  default     = "Standard_D2_v2"
}

# Minimum number of nodes in the AKS node pool
variable "min_node_count" {
  description = "Minimum number of nodes in the AKS node pool"
  type        = number
  default     = 1
}

# Maximum number of nodes in the AKS node pool
variable "max_node_count" {
  description = "Maximum number of nodes in the AKS node pool"
  type        = number
  default     = 3
}

# OS disk size in GB for the Kubernetes nodes
variable "os_disk_size_gb" {
  description = "OS disk size in GB for the Kubernetes nodes"
  type        = number
  default     = 30
}

# Number of days for retaining logs in Log Analytics
variable "logs_retention_days" {
  description = "Number of days for retaining logs in Log Analytics"
  type        = number
}

# Map of node pools for the AKS cluster
variable "node_pools" {
  description = "A map of node pool configurations"
  type = map(object({
    enable_auto_scaling = bool
    max_count           = number
    min_count           = number
    node_count          = number
    vm_size             = string
    os_disk_size_gb     = number
    node_labels         = map(string)  # Labels for each node pool
    tags                = map(string)    # Tags for each node pool
  }))
  default = {}
}

# Subnet ID for the AKS nodes
variable "subnet_id" {
  description = "ID of the subnet where the AKS nodes will be deployed"
  type        = string
}

# Resource Group Name
variable "resource_group_name" {
  description = "Name of the resource group in Azure"
  type        = string
}

# Enable auto-scaling for the AKS node pool
variable "enable_auto_scaling" {
  description = "Enable auto-scaling for the AKS node pool"
  type        = bool
  default     = true
}

# SSH Public Key for Linux Kubernetes worker nodes
variable "ssh_public_key" {
  description = "SSH Public Key for Linux Kubernetes worker nodes"
  type        = string
}