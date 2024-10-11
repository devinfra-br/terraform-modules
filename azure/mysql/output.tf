output "mysql_server_name" {
  description = "Nome do servidor MySQL flexível"
  value       = azurerm_mysql_flexible_server.this.name
}

output "mysql_database_name" {
  description = "Nome do banco de dados criado"
  value       = azurerm_mysql_flexible_database.this.name
}

output "mysql_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) do servidor MySQL"
  value       = azurerm_mysql_flexible_server.this.fqdn
}

output "mysql_private_dns_zone_id" {
  description = "ID da zona DNS privada"
  value       = azurerm_private_dns_zone.this.id
}