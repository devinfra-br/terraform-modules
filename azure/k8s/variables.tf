variable "default_location" {
  type        = string
  description = "Default location for deploying resources in Azure"
  default     = "westus3"
}

variable "use_for_each" {
  type        = bool
  description = "Boolean flag to use 'for_each' in resource creation (true/false)"
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to all resources for categorization or billing"
  default     = {}
}

variable "node_labels" {
  type        = map(string)
  description = "Labels to be applied to all Kubernetes nodes for resource identification"
  default     = {}
}

variable "project" {
  type        = string
  description = "Name of the project to associate with the resources"
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, staging, prod) where the resources will be deployed"
  default     = ""
}

variable "vm_size" {
  description = "Size of the Virtual Machine for AKS nodes"
  type        = string
  default     = "Standard_D2_v2"
}

variable "min_node_count" {
  description = "Minimum number of nodes in the AKS node pool"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes in the AKS node pool"
  type        = number
  default     = 3
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB for the Kubernetes nodes"
  type        = number
  default     = 30
}

variable "logs_retention_days" {
  description = "Number of days for retaining logs in Log Analytics"
  type        = number
}

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
  default = {}  # Você pode deixar vazio para ser preenchido dinamicamente
}

variable "subnet_id" {
  description = "ID of the subnet where the AKS nodes will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in Azure"
  type        = string
}

variable "enable_auto_scaling" {
  description = "Enable auto-scaling for the AKS node pool"
  type        = bool
  default     = true
}

variable "ssh_public_key" {
  description = "SSH Public Key for Linux Kubernetes worker nodes"
  type        = string
}