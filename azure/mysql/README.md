# Azure MySQL Flexible Server Module

Este módulo Terraform cria um servidor MySQL flexível no Azure com configurações de DNS privado e um banco de dados inicial.

## Exemplo de Uso

```hcl
module "mysql_server" {
  source              = "./path/to/module"
  project             = "my_project"
  environment         = "dev"
  resource_group_name = "my-resource-group"
  location            = "East US"
  admin_username      = "adminuser"
  backup_retention_days = 7
  azurerm_subnet_id   = "subnet-id"
  vnet_name           = "vnet-id"
  sku_name            = "Standard_D2s_v3"
  mysql_version       = "8.0"
  ha_mode             = "Disabled"
  tags                = {
    Environment = "Dev"
    Project     = "My Project"
  }
}
```

### Variáveis

| Nome                    | Tipo   | Descrição                                                    |
|-------------------------|--------|------------------------------------------------------------|
| `project`               | string | Nome do projeto                                            |
| `environment`           | string | Ambiente (ex: dev, test, prod)                            |
| `resource_group_name`   | string | Nome do grupo de recursos                                  |
| `location`              | string | Localização para os recursos                               |
| `admin_username`        | string | Nome de usuário do administrador do MySQL                   |
| `backup_retention_days` | number | Número de dias de retenção de backup                       |
| `azurerm_subnet_id`     | string | ID da sub-rede onde o servidor MySQL será colocado       |
| `vnet_name`             | string | ID da Virtual Network                                      |
| `sku_name`              | string | SKU do servidor MySQL                                      |
| `mysql_version`         | string | Versão do MySQL                                           |
| `ha_mode`               | string | Modo de alta disponibilidade                               |
| `tags`                  | map    | Tags para os recursos                                      |
