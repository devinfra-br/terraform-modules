variable "location" {
  description = "Localização dos recursos no Azure"
  default     = ""
}

variable "resource_group_name" {
  description = "Nome do grupo de recursos"
  default     = "rg-network"
}

variable "vnet_name" {
  description = "Nome da rede virtual"
  default     = ""
}

variable "vnet_cidr" {
  description = "Espaço de endereçamento da VNet"
  default     = ""
}

variable "subnets" {
  description = "Configurações das sub-redes"
  type = map(object({
    name = string
    cidr = string
  }))

  default = {
    applications = {
      name = "applications-subnet"
      cidr = ""
    }
    databases = {
      name = "databases-subnet"
      cidr = ""
    }
    management = {
      name = "management-subnet"
      cidr = ""
    }
    public = {
      name = "public-subnet"
      cidr = ""
    }
    kubernetes = {
      name = "kubernetes-subnet"
      cidr = ""
    }
  }
}





variable "tags" {
  description = "Mapeamento das tags associadas ao recurso."
  type        = map(string)
  default     = {}
}
