variable "project" {
  description = "Nome do projeto"
  type        = string
}

variable "environment" {
  description = "Ambiente (ex: dev, test, prod)"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  type        = string
}

variable "location" {
  description = "Localização para os recursos"
  type        = string
}

variable "admin_username" {
  description = "Nome de usuário do administrador do MySQL"
  type        = string
}

variable "backup_retention_days" {
  description = "Número de dias de retenção de backup"
  type        = number
}

variable "subnet_name" {
  description = "Subnet para o servidor MySQL"
  type        = string
}

variable "vnet_name" {
  description = "ID da Virtual Network"
  type        = string
}

variable "sku_name" {
  description = "SKU do servidor MySQL"
  type        = string
}

variable "mysql_version" {
  description = "Versão do MySQL"
  type        = string
}

variable "ha_mode" {
  description = "Modo de alta disponibilidade"
  type        = string
}

variable "tags" {
  description = "Tags para os recursos"
  type        = map(string)
  default     = {}
}

variable "admin_password" {
  description = "Senha do administrador do MySQL"
  type        = string
}

variable "resource_group_name_vnet" {
  description = "Nome do grupo de recursos da Virtual Network"
  type        = string 
}