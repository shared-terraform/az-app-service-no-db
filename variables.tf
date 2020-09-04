
# Required variables

variable "az_app_name" {
  type = string
  description = "The name of the application for which this infrastructure is being deployed."
}

# Configurable variables

variable "az_location" {
  type = string
  description = "The Azure region to which the resources will be deployed."
  default = "southcentralus"
}

variable "az_deploy_env" {
  type = string
  description = "The deployment type for the resources being deployed (usually dev, test, or prod)."
  default = "dev"
}

variable "az_tags" {
  type = map(string)
  description = "Tags which are applied to all resources created using this module."
}