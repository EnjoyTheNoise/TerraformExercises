resource "azurerm_resource_group" "vnet_group" {
  name     = "${var.resource_group_name}-${var.env}"
  location = "${var.location}"
}

module "service-principal" {
  source              = "./service-principal"
  resource_group_name = "${azurerm_resource_group.vnet_group.name}"
  location            = "${var.location}"
  env                 = "${var.env}"
}

module "vnet" {
  source              = "./vnet"
  resource_group_name = "${azurerm_resource_group.vnet_group.name}"
  location            = "${var.location}"
  env                 = "${var.env}"
}

module "database" {
  source              = "./database"
  resource_group_name = "${azurerm_resource_group.vnet_group.name}"
  location            = "${var.location}"
  env                 = "${var.env}"
  db_subnet_id        = "${module.vnet.db_subnet_id}"
  tenant_id           = "${var.tenant_id}"
  service_principal   = "${module.service-principal.principal_id}"
  admin_password      = "${var.sql_admin_password}"
}

module "vm" {
  source              = "./vm"
  resource_group_name = "${azurerm_resource_group.vnet_group.name}"
  location            = "${var.location}"
  env                 = "${var.env}"
  backend_subnet_id   = "${module.vnet.be_subnet_id}"
  identity_id         = "${module.service-principal.identity_id}"
  admin_username      = "${var.vm_admin_username}"
  admin_password      = "${var.vm_admin_password}"
}

# module "automation-acc" {
#   source              = "./automation-acc"
#   resource_group_name = "${azurerm_resource_group.vnet_group.name}"
#   location            = "${var.location}"
#   env                 = "${var.env}"
# }

module "vm-extension" {
  source              = "./vm-extension"
  resource_group_name = "${azurerm_resource_group.vnet_group.name}"
  location            = "${var.location}"
  vm_name             = "${module.vm.vm_name}"
  dsc_endpoint        = "${var.dsc_endpoint}"
  dsc_key             = "${var.dsc_key}"
}
