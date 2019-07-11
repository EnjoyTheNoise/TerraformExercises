output "sql_server_id" {
  value = "${azurerm_sql_server.sql_server.id}"
}

output "sql_server_domain_name" {
  value = "${azurerm_sql_server.sql_server.fully_qualified_domain_name}"
}

output "sql_elastic_pool_id" {
  value = "${azurerm_sql_elasticpool.elastic_pool.id}"
}

output "sql_database_id" {
  value = "${azurerm_sql_database.sql_db.id}"
}
