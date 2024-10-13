# Generates a random string to use in resource names
resource "random_string" "this" {
  length  = 6
  lower   = true
  numeric = false
  special = false
  upper   = false
}


# Data source to retrieve existing Virtual Network details
data "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name_vnet
}

# Data source to retrieve an existing Subnet in the specified Virtual Network
data "azurerm_subnet" "this" {
  name                 = var.subnet_name  # Name of the subnet
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name_vnet
}

# Create a Private DNS Zone for MySQL
resource "azurerm_private_dns_zone" "this" {
  name                = "${var.project}-${var.environment}-${random_string.this.result}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

# Links the Private DNS Zone to the specified Virtual Network
resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = "${var.project}-${var.environment}-${random_string.this.result}.com.br"
  private_dns_zone_name = azurerm_private_dns_zone.this.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = data.azurerm_virtual_network.this.id
  tags                  = var.tags
}

# Creates an Azure MySQL Flexible Server with necessary configurations
resource "azurerm_mysql_flexible_server" "this" {
  name                   = "db-${var.project}-${var.environment}-${random_string.this.result}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = var.admin_username
  administrator_password = var.admin_password
  backup_retention_days  = var.backup_retention_days
  delegated_subnet_id    = data.azurerm_subnet.this.id  # Uses the retrieved subnet
  private_dns_zone_id    = azurerm_private_dns_zone.this.id
  sku_name               = var.sku_name  # SKU for the MySQL instance
  version                = var.mysql_version
  zone                   = 1

  # Configures High Availability only if enabled
  dynamic "high_availability" {
    for_each = var.enable_high_availability ? [1] : []
    content {
      mode = var.ha_mode
    }
  }

  # Configures the storage settings for the MySQL server
  storage {
    iops    = var.storage_iops
    size_gb = var.storage_size_gb
  }

  # Sets the maintenance window for the server
  maintenance_window {
    day_of_week  = var.maintenance_window_day_of_week
    start_hour   = var.maintenance_window_start_hour
    start_minute = var.maintenance_window_start_minute
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.this]
  tags       = var.tags
}

# Creates MySQL databases using a flexible server, iterating over a list of databases
resource "azurerm_mysql_flexible_database" "this" {
  for_each           = toset(var.databases)  # Iterates over the list of database names
  name               = format("%s_%s", var.db_prefix, each.value)  # Concatenates the prefix and database name
  resource_group_name = var.resource_group_name
  server_name        = azurerm_mysql_flexible_server.this.name
  charset            = "utf8mb4"  # Specifies character set for the database
  collation          = "utf8mb4_unicode_ci"  # Specifies collation for the database
}
