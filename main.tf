
resource "random_uuid" "uuid" { }

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.az_app_name}-${var.az_deploy_env}${terraform.workspace == "default" ? "" : "-${terraform.workspace}"}-${random_uuid.uuid.result}"
  location = var.az_location
  tags     = var.az_tags
}