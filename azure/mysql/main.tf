# Generate random resource group name
resource "random_pet" "this" {}

# Generate random value for the name
resource "random_string" "this" {
  length  = 6
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Generate random value for the login password
resource "random_password" "this" {
  length           = 16
  lower            = true
  min_lower        = 1
  min_numeric      = 4
  min_special      = 1
  min_upper        = 1
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name_vnet
}

data "azurerm_subnet" "this" {
  name                 = var.subnet_name # Substitua pelo nome da sua Subnet
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name_vnet
}

# Enables you to manage Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "this" {
  name                = "${var.project}-${var.environment}-${random_string.this.result}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${var.project}-${var.environment}-${random_string.this.result}.com.br"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.this.id
  tags                  = var.tags
}

resource "azurerm_mysql_flexible_server" "this" {
  name                   = "db-${var.project}-${var.environment}-${random_string.this.result}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = data.azurerm_subnet.this.id
  private_dns_zone_id    = azurerm_private_dns_zone.this.id
  sku_name               = var.sku_name
  version                = var.mysql_version
  zone                   = 1

  dynamic "high_availability" {
    for_each = var.enable_high_availability ? [1] : []
    content {
      mode = var.ha_mode
    }
  }

  storage {
    iops    = var.storage_iops
    size_gb = var.storage_size_gb
  }

  maintenance_window {
    day_of_week  = var.maintenance_window_day_of_week
    start_hour   = var.maintenance_window_start_hour
    start_minute = var.maintenance_window_start_minute
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]
  tags       = var.tags
}

#resource "azurerm_mysql_flexible_database" "this" {
#  name                = "db-${var.project}"
#  resource_group_name = var.resource_group_name
#  server_name         = azurerm_mysql_flexible_server.this.name
#  charset             = "utf8mb4"
#  collation           = "utf8mb4_unicode_ci"
#}

resource "azurerm_mysql_flexible_database" "this" {
  for_each           = toset(var.databases)  # Iterar sobre a lista de nomes
  name               = format("%s-%s", var.db_prefix, var.databases, each.value)  # Concatenar prefixo, projeto e nome
  resource_group_name = var.resource_group_name
  server_name        = azurerm_mysql_flexible_server.this.name
  charset            = "utf8mb4"
  collation          = "utf8mb4_unicode_ci"
}

resource "azurerm_private_endpoint" "example" {
  name                = "${random_string.random.result}-endpoint"
  location            = "Australia East"
  resource_group_name = "MysqlResourceGroup"
  subnet_id           = azurerm_subnet.example.id

  private_service_connection {
    name                           = "${random_string.random.result}-privateserviceconnection"
    private_connection_resource_id = azurerm_mysql_server.example.id
    subresource_names              = [ "mysqlServer" ]
    is_manual_connection           = false
  }
}