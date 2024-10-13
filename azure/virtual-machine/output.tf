# Output do nome das VMs
output "vm_names" {
  description = "Nome das VMs criadas"
  value       = { for k, v in azurerm_linux_virtual_machine.this : k => v.name } # Para VMs Linux
}

output "windows_vm_names" {
  description = "Nome das VMs Windows criadas"
  value       = { for k, v in azurerm_windows_virtual_machine.this : k => v.name } # Para VMs Windows
}

# Output dos IPs públicos
output "public_ip_addresses" {
  description = "Endereços IP públicos das VMs"
  value       = { for k, v in azurerm_public_ip.this : k => v.ip_address }
}

# Output dos Network Interfaces
output "network_interface_ids" {
  description = "IDs das interfaces de rede associadas às VMs"
  value       = { for k, v in azurerm_network_interface.this : k => v.id }
}
