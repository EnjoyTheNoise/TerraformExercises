variable "location" {
  type        = "string"
  description = "Resource location"
}

variable "resource_group_name" {
  type        = "string"
  description = "Resource group name"
}

variable "address_space" {
  type        = "string"
  description = "vnet address space"
  default     = "10.0.0.0/16"
}

variable "frontend_prefix" {
  type        = "string"
  description = "Frontend subnet prefix"
  default     = "10.0.1.0/24"
}

variable "backend_prefix" {
  type        = "string"
  description = "Backend subnet prefix"
  default     = "10.0.2.0/24"
}

variable "database_prefix" {
  type        = "string"
  description = "Database subnet prefix"
  default     = "10.0.3.0/24"
}

variable "env" {
  type        = "string"
  description = "Target environment"
}
