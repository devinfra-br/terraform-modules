output "bastion_public_ip" {
  description = "IP Público associado ao Azure Bastion"
  value       = azurerm_public_ip.bastion_public_ip.ip_address
}

output "bastion_host_id" {
  description = "ID do Bastion Host criado"
  value       = azurerm_bastion_host.bastion.id
}

output "bastion_nsg_id" {
  description = "ID do Network Security Group do Bastion"
  value       = azurerm_network_security_group.bastion_nsg.id
}
