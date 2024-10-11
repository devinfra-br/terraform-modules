
# Terraform Modules Repository

Este repositório contém módulos do Terraform para diferentes provedores de nuvem (AWS, Azure, GCP). Cada módulo é projetado para ser reutilizável e facilitar a criação de infraestrutura escalável e consistente.

## Estrutura do Repositório

A estrutura do repositório está organizada por provedores de nuvem e módulos específicos. Abaixo está a hierarquia dos módulos disponíveis:

```
├───aws
│   ├───ec2
│   ├───s3
│   └───vpc
├───azure
│   ├───base
│   ├───bastion
│   ├───container-registry
│   ├───k8s
│   ├───mysql
│   ├───resource-group
│   ├───security-group
│   └───virtual-machine
└───gcp
```

## Módulos Disponíveis

### AWS
- **EC2**: Configura instâncias EC2.
- **S3**: Gerencia buckets S3.
- **VPC**: Criação e configuração de redes VPC.

### Azure
- **base**: Configuração básica de infraestrutura, como redes e recursos iniciais.
- **bastion**: Configura Azure Bastion para conexão segura a VMs.
- **container-registry**: Configura Azure Container Registry.
- **k8s**: Cria e configura clusters AKS com suporte para múltiplos node pools.
- **mysql**: Configura servidores MySQL no Azure.
- **resource-group**: Gerencia grupos de recursos no Azure.
- **security-group**: Configura grupos de segurança.

### GCP
- Em desenvolvimento.

## Exemplo de Uso: AKS (Azure Kubernetes Service)

Abaixo está um exemplo de uso do módulo de AKS para criar um cluster Kubernetes no Azure, com múltiplos node pools e autoescalabilidade configurada.

```hcl
locals {
  # Combinando as tags recebidas com a tag last_updated
  merged_tags = merge(
    var.tags,
    {
      last_updated     = timestamp()
      project          = var.project
      environment      = var.environment
      owner            = var.owner
      cost_center      = var.cost_center
      team             = var.team
      tier             = var.tier
      automation_level = var.automation_level
      department       = var.department
    }
  )
}

module "aks" {
  source = "../../../../../codeviewbr/terraform-modules/azure/k8s"

  project             = var.project
  environment         = var.environment
  default_location    = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.aks_subnet.id
  vm_size             = "Standard_B2pls_v2"
  ssh_public_key      = "./ssh/aks_id_rsa.pub"
  min_node_count      = 1
  max_node_count      = 10
  os_disk_size_gb     = 30
  logs_retention_days = 30

  node_labels = {
    "environment"   = var.environment
    "app"           = "shared"
    "nodepool-type" = "applications"
    "role"          = "system"
    "team"          = "devops"
  }

  tags = local.merged_tags

  node_pools = {
    services = {
      enable_auto_scaling   = true
      enable_node_public_ip = false
      max_count             = 10
      min_count             = 1
      node_count            = 2
      vm_size               = "Standard_B2pls_v2"
      os_disk_size_gb       = 30
      node_labels = {
        "environment"   = var.environment
        "nodepool-type" = "services"
        "app"           = "shared-services"
        "team"          = "devops"
      }
      tags = merge(
        local.merged_tags,
        {
          "nodepool-type" = "services"
          "app"           = "shared-services"
        }
      )
    }
    applications = {
      enable_auto_scaling   = true
      enable_node_public_ip = false
      max_count             = 10
      min_count             = 1
      node_count            = 2
      vm_size               = "Standard_B2pls_v2"
      os_disk_size_gb       = 30
      node_labels = {
        "environment"   = var.environment
        "nodepool-type" = "applications"
        "app"           = "shared-applications"
        "team"          = "devops"
      }
      tags = merge(
        local.merged_tags,
        {
          "nodepool-type" = "applications"
          "app"           = "shared-applications"
        }
      )
    }
  }
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vmnet_name
  address_prefixes     = ["10.20.16.0/20"]
}
```

## Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests para melhorias nos módulos.

## Licença

Este repositório está licenciado sob a licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.
