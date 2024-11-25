output "mysql_server_name" {
  description = "Nome do servidor MySQL flexível"
  value       = azurerm_mysql_flexible_server.this.name
}