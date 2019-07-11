resource "random_integer" "srv-no" {
  min = 1
  max = 1024
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "sql-server-${var.env}-${random_integer.srv-no.result}"
  resource_group_name          = "${var.resource_group_name}"
  location                     = "${var.location}"
  version                      = "12.0"
  administrator_login          = "sysadmin"
  administrator_login_password = "${var.admin_password}"
}

resource "azurerm_sql_elasticpool" "elastic_pool" {
  name                = "sql-elastic-pool-${var.env}"
  resource_group_name = "${var.resource_group_name}"
  location            = "${var.location}"
  server_name         = "${azurerm_sql_server.sql_server.name}"
  edition             = "Basic"
  dtu                 = 50
  db_dtu_min          = 0
  db_dtu_max          = 5
  pool_size           = 5000
  depends_on          = ["azurerm_sql_server.sql_server"]
}

resource "azurerm_sql_database" "sql_db" {
  name                             = "sql-database-${var.env}"
  resource_group_name              = "${var.resource_group_name}"
  location                         = "${var.location}"
  server_name                      = "${azurerm_sql_server.sql_server.name}"
  edition                          = "Basic"
  elastic_pool_name                = "${azurerm_sql_elasticpool.elastic_pool.name}"
  requested_service_objective_name = "ElasticPool"
  depends_on                       = ["azurerm_sql_elasticpool.elastic_pool"]
}

resource "azurerm_sql_firewall_rule" "sql_firewall" {
  name                = "AlllowAzureServices"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.sql_server.name}"
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_sql_virtual_network_rule" "sql_vnet_rule" {
  name                = "sql-vnet-rule-${var.env}"
  resource_group_name = "${var.resource_group_name}"
  server_name         = "${azurerm_sql_server.sql_server.name}"
  subnet_id           = "${var.db_subnet_id}"
}

resource "azurerm_sql_active_directory_administrator" "sql_admin" {
  server_name         = "${azurerm_sql_server.sql_server.name}"
  resource_group_name = "${var.resource_group_name}"
  login               = "principal-admin"
  tenant_id           = "${var.tenant_id}"
  object_id           = "${var.service_principal}"
  depends_on          = ["azurerm_sql_server.sql_server"]
}
