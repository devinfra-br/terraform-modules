# Tipo de banco de dados (MySQL ou MySQL Flexível)

# Nome do projeto
variable "project" {
  description = "Nome do projeto"
  type        = string
}

# Ambiente (ex: dev, prod, homolog)
variable "environment" {
  description = "Ambiente (ex: dev, prod, homolog)"
  type        = string
}

# Nome do VNet
variable "vnet_name" {
  description = "Nome da Virtual Network"
  type        = string
}

# Nome da Subnet
variable "subnet_name" {
  description = "Nome da Subnet onde o banco será criado"
  type        = string
}

# Resource group da VNet
variable "resource_group_name_vnet" {
  description = "Nome do Resource Group da VNet"
  type        = string
}

# Resource group do banco de dados
variable "resource_group_name" {
  description = "Nome do Resource Group onde o banco será criado"
  type        = string
}

# Localização (Região) do Azure
variable "location" {
  description = "Localização (região) do Azure"
  type        = string
}

# Nome de usuário administrador do banco de dados
variable "admin_username" {
  description = "Nome de usuário do administrador do banco de dados"
  type        = string
}

# Senha do administrador do banco de dados
variable "admin_password" {
  description = "Senha do administrador do banco de dados"
  type        = string
}

# Nome do banco de dados
variable "name" {
  description = "Nome do banco de dados (somente para MySQL tradicional)"
  type        = string
  default     = null
}

# Backup retention (em dias)
variable "backup_retention_days" {
  description = "Dias de retenção de backup"
  type        = number
  default     = 7
}

# SKU do banco de dados
variable "sku_name" {
  description = "SKU do banco de dados (ex: B_Gen5_1, GP_Gen5_2)"
  type        = string
}

# Versão do MySQL
variable "mysql_version" {
  description = "Versão do MySQL (ex: 5.7, 8.0)"
  type        = string
  default     = "8.0"
}

# Tamanho de armazenamento (em GB)
variable "storage_size_gb" {
  description = "Tamanho do armazenamento (em GB)"
  type        = number
  default     = 20
}

# IOPS para o armazenamento
variable "storage_iops" {
  description = "Número de IOPS para o armazenamento"
  type        = number
  default     = 300
}

# Public network access enabled
variable "public_network_access_enabled" {
  description = "Habilitar o acesso de rede pública ao banco de dados (somente para MySQL)"
  type        = bool
  default     = false
}

# Auto grow enabled
variable "auto_grow_enabled" {
  description = "Habilitar crescimento automático de armazenamento"
  type        = bool
  default     = true
}

# Geo-redundant backup enabled
variable "geo_redundant_backup_enabled" {
  description = "Habilitar backups geo-redundantes"
  type        = bool
  default     = false
}

# Infrastructure encryption enabled
variable "infrastructure_encryption_enabled" {
  description = "Habilitar criptografia de infraestrutura"
  type        = bool
  default     = false
}

# High availability enabled
variable "enable_high_availability" {
  description = "Habilitar alta disponibilidade para o MySQL Flexível"
  type        = bool
  default     = false
}

# HA mode
variable "ha_mode" {
  description = "Modo de alta disponibilidade (ZoneRedundant, SameZone)"
  type        = string
  default     = "ZoneRedundant"
}

# Maintenance window
variable "maintenance_window_day_of_week" {
  description = "Dia da semana para janela de manutenção"
  type        = number
  default     = 1
}

variable "maintenance_window_start_hour" {
  description = "Hora de início da janela de manutenção"
  type        = number
  default     = 0
}

variable "maintenance_window_start_minute" {
  description = "Minuto de início da janela de manutenção"
  type        = number
  default     = 0
}

# Tags
variable "tags" {
  description = "Tags associadas aos recursos"
  type        = map(string)
  default     = {}
}

variable "db_prefix" {
  description = "Prefixo do nome do banco de dados"
  type        = string
  default     = "db"
}

variable "databases" {
  description = "Lista de nomes dos bancos de dados"
  type        = list(string)
  default     = []
}

variable "public_access" {
  description = "Habilitar acesso público ao banco de dados"
  type        = bool
  default     = false
}