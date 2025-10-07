output "kube_config" {
  description = "Kubeconfig per connettersi al cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "aks_cluster_name" {
  description = "Nome del cluster AKS creato"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "resource_group" {
  description = "Resource Group in cui è stato creato il cluster"
  value       = azurerm_resource_group.rg.name
}

output "cluster_endpoint" {
  description = "Endpoint del cluster AKS"
  value       = azurerm_kubernetes_cluster.aks.kube_config.0.host
  sensitive = true
}

output "applied_manifests" {
  description = "Status of applied manifests"
  value = var.apply_manifests ? [
    for i, manifest in var.yaml_manifests : {
      name = manifest.name
      url  = manifest.url
      applied = "deployed via null_resource"
    }
  ] : []
}

output "deployment_status" {
  description = "Overall deployment status"
  value = {
    cluster_ready = "ready"
    manifests_applied = var.apply_manifests
    total_manifests = length(var.yaml_manifests)
  }
}
# Aggiungi alla fine del tuo FINAL-outputs.tf esistente

# Output cert-manager
output "cert_manager_installed" {
  description = "Whether cert-manager is installed"
  value       = var.install_cert_manager
}

output "cert_manager_namespace" {
  description = "Namespace where cert-manager is installed"
  value       = var.install_cert_manager ? var.cert_manager_namespace : null
}

output "cert_manager_version" {
  description = "Version of cert-manager installed"
  value       = var.install_cert_manager ? var.cert_manager_version : null
}

output "letsencrypt_issuers" {
  description = "Available Let's Encrypt cluster issuers"
  value = var.install_cert_manager ? [
    "letsencrypt-staging",
    "letsencrypt-prod"
  ] : []
}

output "cert_manager_usage" {
  description = "How to use cert-manager in your Ingress"
  value = var.install_cert_manager ? "Add annotation: cert-manager.io/cluster-issuer: letsencrypt-staging" : "cert-manager not installed"
}
