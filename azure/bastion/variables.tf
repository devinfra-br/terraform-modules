variable "public_ip_name" {
  description = "Nome do IP público para o Bastion"
  type        = string
  default     = "bastionPublicIP"
}

variable "bastion_name" {
  description = "Nome do Bastion Host"
  type        = string
  default     = "myBastionHost"
}

variable "bastion_dns_name" {
  description = "Nome DNS do Bastion"
  type        = string
  default     = "my-bastion-host"
}

variable "bastion_scale_units" {
  description = "Número de unidades de escala do Bastion Host"
  type        = number
  default     = 2
}

variable "nsg_name" {
  description = "Nome do Network Security Group"
  type        = string
  default     = "bastionNSG"
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos no Azure"
  type        = string
}

variable "location" {
  description = "Região do Azure onde os recursos serão criados"
  type        = string
}

variable "management_subnet_id" {
  description = "ID da sub-rede Management onde o Bastion será implantado"
  type        = string
}

variable "tags" {
  description = "Tags associadas aos recursos"
  type        = map(string)
  default     = {}
}
