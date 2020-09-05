
# We follow Microsoft's naming and tagging conventions to create our resources.
# Refer to the documentation, here:
# https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging

# To avoid collisions of combinations of plain strings for various resources 
# which require either subscription or globally unique names, we generate a GUID
# in every instance of Terraform state that uses this module.
resource "random_uuid" "uuid" { }

# Create a local variable that holds the a composite of the application name,
# deployment environment, and current workspace name (if it exists).
locals {
  composite_name = "${var.az_app_name}-${var.az_deploy_env}${terraform.workspace == "default" ? "" : "-${terraform.workspace}"}"
  
  reserved = var.az_asp_reserved || var.az_asp_kind == "Linux" ? true : false
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${local.composite_name}-${random_uuid.uuid.result}"

  location = var.az_location
  tags     = var.az_tags
}

resource "azurerm_app_service_plan" "asp" {
  name                = "asp-${local.composite_name}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  kind                = var.az_asp_kind
  # When creating a Linux App Service Plan, reserved must be set to true!
  reserved            = local.reserved
  # maximum_elastic_worker_count
  # app_service_environment_id
  # per_site_scaling
  tags                = var.az_tags

  sku {
    tier = var.az_asp_sku_tier
    size = var.az_asp_sku_size
    # capacity
  }
}

resource "azurerm_app_service" "app" {
  name = "app-${local.composite_name}-${random_uuid.uuid.result}"
  resource_group_name     = azurerm_resource_group.rg.name
  location                = azurerm_resource_group.rg.location
  app_service_plan_id     = azurerm_app_service_plan.asp.id
  client_affinity_enabled = var.az_app_client_affinity_enabled
  client_cert_enabled     = var.az_app_client_cert_enabled
  enabled                 = var.az_app_enabled
  https_only              = var.az_app_https_only
  tags                    = var.az_tags

  # app_settings {}
  # auth_settings {}
  # backup {}
  # connection_string {}
  # identity {}
  # logs {}
  # storage_accout {}
  # site_config {
    # cors {}

  #   ftps_state = "Disabled"
  # }
  # source_control {}
}

resource "azurerm_app_service_custom_hostname_binding" "custom_domain" {
  count               = length(var.az_custom_domain_hostname)
  hostname            = var.az_custom_domain_hostname[count.index]
  app_service_name    = azurerm_app_service.app.name
  resource_group_name = azurerm_resource_group.rg.name
}