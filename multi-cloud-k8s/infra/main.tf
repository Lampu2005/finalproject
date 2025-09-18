terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    aws = {
      source = "hashicorp/aws"
    }
    google = {
      source = "hashicorp/google"
    }
  }
}

# =================== PROVIDERS ===================

# Azure
provider "azurerm" {
  features {}
  # opzionale: se vuoi vincolare la versione
  # version = "~> 3.64"
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
}

# AWS
provider "aws" {
  region     = var.region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# GCP
provider "google" {
  project     = var.gcp_project
  region      = var.region
  credentials = file(var.gcp_credentials_file)
}

# =================== MODULE MULTI-CLOUD ===================

module "k8s" {
  source = "../modules/${var.cloud}"
  region = var.region

  # Azure
  azure_subscription_id = var.azure_subscription_id
  azure_tenant_id       = var.azure_tenant_id
  azure_client_id       = var.azure_client_id
  azure_client_secret   = var.azure_client_secret

  # AWS
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key

  # GCP
  gcp_project          = var.gcp_project
  gcp_credentials_file = var.gcp_credentials_file
}
