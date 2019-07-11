output "dsc_endpoint" {
  value = "${azurerm_automation_account.automation_acc.dsc_server_endpoint}"
}

output "dsc_key" {
  value = "${azurerm_automation_account.automation_acc.dsc_primary_access_key}"
}
