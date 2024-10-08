# AKS Terraform Module

This module automates the deployment of an Azure Kubernetes Service (AKS) cluster along with necessary resources like Log Analytics, network security groups, and more.

## Table of Contents

- [Requirements](#requirements)
- [Usage](#usage)
- [Inputs](#inputs)
- [Outputs](#outputs)
- [License](#license)
- [Author Information](#author-information)

## Requirements

- Terraform >= 1.0
- Azure CLI
- Azure Provider

## Usage

To use this module, you will need to include it in your Terraform configuration as follows:

```hcl
module "aks" {
  source  = "path_to_module"
  
  project            = "my-project"
  environment        = "dev"
  default_location   = "East US"
  subnet_id          = azurerm_subnet.my_subnet.id
  vm_size            = "Standard_D2_v2"
  min_node_count     = 1
  max_node_count     = 3
  os_disk_size_gb    = 30
  logs_retention_days = 30

  node_labels = {
    "environment" = "dev"
  }

  tags = {
    "environment" = "dev"
  }

  node_pools = {
    services = {
      enable_auto_scaling = true
      max_count           = 10
      min_count           = 1
      vm_size             = "standard_d11_v2_promo"
      os_disk_size_gb     = 60
      node_labels = {
        "nodepool-type" = "services"
        "app"           = "shared-services"
      }
      tags = {
        "nodepool-type" = "services"
        "app"           = "shared-services"
      }
    }
  }
}


## Inputs

The module accepts the following input variables:

| Variable               | Description                                                       | Type                    | Default                                           |
|------------------------|-------------------------------------------------------------------|-------------------------|---------------------------------------------------|
| `default_location`     | Default location for deploying resources in Azure                 | `string`                | `"westus3"`                                       |
| `use_for_each`         | Boolean flag to use 'for_each' in resource creation (true/false) | `bool`                  | `true`                                            |
| `vnet_location`        | Location for the virtual network (VNet)                           | `string`                | `"westus3"`                                       |
| `ssh_public_key`       | SSH Public Key for Linux Kubernetes worker nodes                  | `string`                | `"~/.ssh/aks-prod-sshkeys-terraform/aksprodsshkey.pub"` |
| `tags`                 | Tags to be applied to all resources                                | `map(string)`           | `{}`                                              |
| `node_labels`          | Labels to be applied to all Kubernetes nodes                      | `map(string)`           | `{}`                                              |
| `project`              | Name of the project to associate with the resources               | `string`                | `""`                                              |
| `environment`          | Environment name (e.g., dev, staging, prod)                      | `string`                | `""`                                              |
| `vm_size`              | Size of the Virtual Machine for AKS nodes                         | `string`                | `"Standard_D2_v2"`                               |
| `min_node_count`       | Minimum number of nodes in the AKS node pool                      | `number`                | `1`                                               |
| `max_node_count`       | Maximum number of nodes in the AKS node pool                      | `number`                | `3`                                               |
| `os_disk_size_gb`      | OS disk size in GB for the Kubernetes nodes                      | `number`                | `30`                                              |
| `logs_retention_days`  | Number of days for retaining logs in Log Analytics                | `number`                | `30`                                              |
| `node_pools`           | A map of node pool configurations                                  | `map(object({...}))`    | N/A                                               |


## Outputs

This module provides the following outputs:

| Output Name                  | Description                                           |
|------------------------------|-------------------------------------------------------|
| `kubernetes_cluster_id`      | The ID of the created AKS cluster                     |
| `log_analytics_workspace_id` | The ID of the Log Analytics workspace                 |
| `admin_group_id`             | The ID of the Azure AD group for AKS administrators   |
| `network_security_group_id`  | The ID of the Network Security Group                  |

License
This project is licensed under the MIT License - see the LICENSE file for details.

Author Information
Created by [Your Name] - [Your Contact Information]


Esse arquivo `README.md` inclui a descrição do módulo Terraform para o AKS, juntamente com tabelas formatadas em Markdown para inputs e outputs. Você pode personalizar os campos como o nome do autor e a informação de contato conforme necessário.
