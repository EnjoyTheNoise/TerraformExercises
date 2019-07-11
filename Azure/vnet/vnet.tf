resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  address_space       = ["${var.address_space}"]
}

# frontend subnet + nsg association
resource "azurerm_subnet" "frontend" {
  name                 = "frontend-${var.env}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${var.frontend_prefix}"
}

resource "azurerm_subnet_network_security_group_association" "front_nsg" {
  network_security_group_id = "${azurerm_network_security_group.frontend-nsg.id}"
  subnet_id                 = "${azurerm_subnet.frontend.id}"
}

# backend subnet + nsg association
resource "azurerm_subnet" "backend" {
  name                 = "backend-${var.env}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${var.backend_prefix}"
}

resource "azurerm_subnet_network_security_group_association" "back_nsg" {
  network_security_group_id = "${azurerm_network_security_group.backend-nsg.id}"
  subnet_id                 = "${azurerm_subnet.backend.id}"
}

# database subnet + nsg association
resource "azurerm_subnet" "database" {
  name                 = "database-${var.env}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_network_name = "${azurerm_virtual_network.vnet.name}"
  address_prefix       = "${var.database_prefix}"
  service_endpoints    = ["Microsoft.Sql"]
}

resource "azurerm_subnet_network_security_group_association" "db_nsg" {
  network_security_group_id = "${azurerm_network_security_group.database-nsg.id}"
  subnet_id                 = "${azurerm_subnet.database.id}"
}
