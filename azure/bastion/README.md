
# Módulo Terraform - Azure Bastion Host

Este módulo cria os seguintes recursos no Azure:
- Um IP público para o Azure Bastion
- Um Azure Bastion Host
- Um Network Security Group (NSG) para o Bastion
- Associação do NSG à sub-rede de Management

## Utilização

```hcl
module "bastion" {
  source              = "./bastion-module"
  public_ip_name      = "bastionPublicIP"
  bastion_name        = "myBastionHost"
  bastion_dns_name    = "my-bastion-host"
  bastion_scale_units = 2
  nsg_name            = "bastionNSG"
  resource_group_name = "myResourceGroup"
  location            = "East US"
  management_subnet_id = "subnet-id-management"
}
```

## Variáveis

| Nome                  | Descrição                                                 | Tipo   | Padrão              |
|-----------------------|-----------------------------------------------------------|--------|---------------------|
| `public_ip_name`       | Nome do IP público para o Bastion                         | string | `"bastionPublicIP"`  |
| `bastion_name`         | Nome do Bastion Host                                      | string | `"myBastionHost"`    |
| `bastion_dns_name`     | Nome DNS do Bastion                                       | string | `"my-bastion-host"`  |
| `bastion_scale_units`  | Número de unidades de escala do Bastion Host              | number | `2`                 |
| `nsg_name`             | Nome do Network Security Group                            | string | `"bastionNSG"`       |
| `resource_group_name`  | Nome do grupo de recursos no Azure                        | string | -                   |
| `location`             | Região do Azure onde os recursos serão criados            | string | -                   |
| `management_subnet_id` | ID da sub-rede Management onde o Bastion será implantado  | string | -                   |

## Saídas

| Nome                | Descrição                                |
|---------------------|------------------------------------------|
| `bastion_public_ip` | IP Público associado ao Azure Bastion     |
| `bastion_host_id`   | ID do Bastion Host criado                |
| `bastion_nsg_id`    | ID do Network Security Group do Bastion  |

