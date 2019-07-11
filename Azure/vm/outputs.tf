output "vm_id" {
  value = "${azurerm_virtual_machine.vm.id}"
}

output "vm_name" {
  value = "${azurerm_virtual_machine.vm.name}"
}
output "vm_public_ip" {
  value = "${azurerm_public_ip.public_ip.ip_address}"
}
output "vm_public_address" {
  value = "${azurerm_public_ip.public_ip.fqdn}"
}
