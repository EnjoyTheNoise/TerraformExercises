provider "azurerm" {
  version         = "~> 1.31"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

provider "azuread" {
  version         = "~> 0.3"
  subscription_id = "${var.subscription_id}"
  tenant_id       = "${var.tenant_id}"
}

provider "random" {
  version = "~> 2.1"
}

provider "null" {
  version = "~> 2.1"
}
