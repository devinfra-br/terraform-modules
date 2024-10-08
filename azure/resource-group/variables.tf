# Localização (Região)
variable "location" {
  description = "A localização/região do Azure para os recursos."
  type        = string
  default     = ""
}

# Nome do grupo de recursos
variable "name" {
  description = "O nome do grupo de recursos."
  type        = string
  
}

# Tags para os recursos
variable "tags" {
  description = "Tags associadas aos recursos."
  type        = map(string)
  default     = {}
}
