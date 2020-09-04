
# We follow Microsoft's naming and tagging conventions to create our resources.
# Refer to the documentation, here:
# https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/naming-and-tagging

# To avoid collisions of combinations of plain strings for various resources 
# which require either subscription or globally unique names, we generate a GUID
# in every instance of Terraform state that uses this module.
resource "random_uuid" "uuid" { }

resource "azurerm_resource_group" "rg" {
  name = <<-EOT
    rg-~
    ${var.az_app_name}-~
    ${var.az_deploy_env}-~
    %{ if terraform.workspace != "default" }${terraform.workspace}-%{endif}~
    ${random_uuid.uuid.result}~
    EOT
  
  location = var.az_location
  tags     = var.az_tags
}

