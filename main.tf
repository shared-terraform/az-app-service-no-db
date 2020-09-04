
resource "random_uuid" "uuid" { }

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.az_app_name}${terraform.workspace == "default" ? "" : "-${terraform.workspace}"}-${var.deploy_env}"
  location = var.az_location
  tags     = var.az_tags
}