output "vm_id" {
  description = "The ID of the virtual machine."
  value       = azurerm_linux_virtual_machine.this.*.id
}

output "public_ip" {
  description = "The public IP address of the virtual machine."
  value       = azurerm_public_ip.this.ip_address
}

output "admin_username" {
  description = "The admin username for the virtual machine."
  value       = var.admin_username
}