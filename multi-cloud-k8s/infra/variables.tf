variable "cloud" {
  description = "Cloud provider to use: aks | eks | gke"
  type        = string
}

variable "region" {
  description = "Region/Location of the cluster"
  type        = string
}

# Azure
variable "azure_subscription_id" { type = string }
variable "azure_tenant_id"       { type = string }
variable "azure_client_id"       { type = string }
variable "azure_client_secret"   { type = string }

# AWS
variable "aws_access_key" { type = string }
variable "aws_secret_key" { type = string }

# GCP
variable "gcp_project"          { type = string }
variable "gcp_credentials_file" { type = string }
