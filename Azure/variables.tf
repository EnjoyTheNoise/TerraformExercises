variable "location" {
  type        = "string"
  description = "Resource group location"
}

variable "resource_group_name" {
  type        = "string"
  description = "Resource Group name"
}

variable "env" {
  type        = "string"
  description = "Target environment"
}
variable "tenant_id" {
  type = "string"
}

variable "subscription_id" {
  type = "string"
}

variable "vm_admin_username" {
  type        = "string"
  description = "Username for vm admin"
}

variable "vm_admin_password" {
  type        = "string"
  description = "Password for vm admin"
}

variable "sql_admin_password" {
  type        = "string"
  description = "Password for sql admin"
}

variable "dsc_endpoint" {
  type = "string"
}

variable "dsc_key" {
  type = "string"
}
