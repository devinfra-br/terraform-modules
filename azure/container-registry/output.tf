# outputs.tf do módulo container_registry
output "registry_id" {
  description = "ID do Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "registry_url" {
  description = "URL do Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "admin_username" {
  description = "Nome de usuário administrativo para autenticação"
  value       = azurerm_container_registry.acr.admin_username
}

output "admin_password" {
  description = "Senha administrativa para autenticação"
  value       = azurerm_container_registry.acr.admin_password
}
