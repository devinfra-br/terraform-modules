output "vnet_id" {
  description = "ID da VNet criada"
  value       = azurerm_virtual_network.vnet.id
}

output "frontend_subnet_id" {
  description = "ID da sub-rede Frontend"
  value       = azurerm_subnet.frontend.id
}

output "backend_subnet_id" {
  description = "ID da sub-rede Backend"
  value       = azurerm_subnet.backend.id
}

output "data_subnet_id" {
  description = "ID da sub-rede Data"
  value       = azurerm_subnet.data.id
}
