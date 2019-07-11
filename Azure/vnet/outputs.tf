output "vnet_id" {
  value = "${azurerm_virtual_network.vnet.id}"
}

output "fe_subnet_id" {
  value = "${azurerm_subnet.frontend.id}"
}

output "be_subnet_id" {
  value = "${azurerm_subnet.backend.id}"
}

output "db_subnet_id" {
  value = "${azurerm_subnet.database.id}"
}
