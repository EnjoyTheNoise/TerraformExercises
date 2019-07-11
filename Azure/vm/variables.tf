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

variable "backend_subnet_id" {
  type        = "string"
  description = "Backend subnet id"
}

variable "identity_id" {
  type        = "string"
  description = "Identity id"
}

variable "admin_username" {
  type        = "string"
  description = "Admin UserName"
}

variable "admin_password" {
  type        = "string"
  description = "Admin password"
}
