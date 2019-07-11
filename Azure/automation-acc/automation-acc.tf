resource "azurerm_automation_account" "automation_acc" {
  name                = "automation-acc-${var.env}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku_name            = "Basic"
}

resource "azurerm_automation_module" "xStorage" {
  name                    = "xStorage"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.automation_acc.name}"

  module_link {
    uri = "https://psg-prod-eastus.azureedge.net/packages/xstorage.3.4.0.nupkg"
  }
}

resource "azurerm_automation_module" "xWebAdministration" {
  name                    = "xWebAdministration"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.automation_acc.name}"

  module_link {
    uri = "https://psg-prod-eastus.azureedge.net/packages/xwebadministration.2.6.0.nupkg"
  }
}

resource "azurerm_automation_module" "cChoco" {
  name                    = "cChoco"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.automation_acc.name}"

  module_link {
    uri = "https://psg-prod-eastus.azureedge.net/packages/cchoco.2.4.0.nupkg"
  }
}

resource "azurerm_automation_dsc_configuration" "VmConfig" {
  name                    = "VmConfig"
  resource_group_name     = "${var.resource_group_name}"
  automation_account_name = "${azurerm_automation_account.automation_acc.name}"
  location                = "${var.location}"
  content_embedded        = "${file("${path.module}/vm-config.ps1")}"
  depends_on = [
    "azurerm_automation_account.automation_acc"
  ]
}
