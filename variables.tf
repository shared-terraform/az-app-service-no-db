
# Required variables

variable "az_app_name" {
  type = string
  description = "The name of the application for which this infrastructure is being deployed."
}

variable "az_tags" {
  type = map(string)
  description = "Tags which are applied to all resources created using this module."
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

variable "az_asp_kind" {
  type = string
  description = "The type of apps to be deployed into this app service plan (Windows, Linux, elastic, and FunctionApp)."
  default = "Linux"
}

variable "az_asp_reserved" {
  type = bool
  default = false
}

variable "az_asp_sku_tier" {
  type = string
  description = "The pricing tier to use in Azure for the app service plan (Free, Basic, Standard, Premium, and Isolated)."
  default = "Free"
}

variable "az_asp_sku_size" {
  type = string
  description = "The size of the app service plan based on the tier (Free: F1; Basic: B1, B2, B3; Standard: S1, S2, S3; Premium: P1v2, P2v2, P3v2; Isolated: I1, I2, I3)."
  default = "F1"
}

variable "az_app_client_affinity_enabled" {
  type = bool
  description = "Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
  default = false
}

variable "az_app_client_cert_enabled" {
  type = bool
  description = "Does the App Service require client certificates for incoming requests?"
  default = false
}

variable "az_app_enabled" {
  type = bool
  description = "Should the app service be enabled immediately?"
  default = true
}

variable "az_app_https_only" {
  type = bool
  description = "Should Azure enforce HTTPS traffic only (rather than the app itself)?"
  default = false
}

variable "az_custom_domain_hostname" {
  type = list(string)
  description = "A list of custom hostnames to apply to the app."
  default = []
}