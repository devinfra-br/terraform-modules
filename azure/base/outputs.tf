# Outputs the ID of the created Virtual Network (VNet)
output "vnet_id" {
  description = "ID of the created Virtual Network (VNet)"
  value       = azurerm_virtual_network.vnet.id
}
