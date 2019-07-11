resource "azurerm_virtual_machine_extension" "dsc" {
  name                 = "configure-vm"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${var.vm_name}"
  publisher            = "Microsoft.Powershell"
  type                 = "DSC"
  type_handler_version = "2.76"

  settings = <<SETTINGS
        {
          "wmfVersion": "latest",
          "configurationArguments": {
              "RegistrationUrl": "${var.dsc_endpoint}",
              "NodeConfigurationName": "VMConfig.localhost",
              "RebootNodeIfNeeded": true
          }
        }
        SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
        {
                "configurationArguments": {
                  "registrationKey": {
                    "userName": "NOT_USED",
                    "Password": "${var.dsc_key}"
                  }
                }
        }
        PROTECTED_SETTINGS
}
