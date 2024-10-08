# variables.tf do módulo container_registry
variable "registry_name" {
  description = "Nome do Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos onde o Container Registry será criado"
  type        = string
}

variable "location" {
  description = "Localização do Container Registry"
  type        = string
}

variable "sku" {
  description = "SKU do Container Registry"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Habilitar acesso administrativo ao Container Registry"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags para o Container Registry"
  type        = map(string)
  default     = {}
}
