variable "location" {
  type        = "string"
  description = "Resource location"
}

variable "env" {
  type        = "string"
  description = "Target environment"
}

variable "resource_group_name" {
  type        = "string"
  description = "Resource group name"
}

variable "db_subnet_id" {
  type        = "string"
  description = "Database subnet id"
}

variable "tenant_id" {
  type        = "string"
  description = "Azure tenant id"
}

variable "service_principal" {
  type        = "string"
  description = "Service principal id"
}

variable "admin_password" {
  type        = "string"
  description = "SQL db admin password"
}
