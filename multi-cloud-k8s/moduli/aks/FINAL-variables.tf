variable "resource_group_name" {
  description = "Nome del Resource Group"
  type        = string
}

variable "location" {
  description = "Regione Azure in cui creare le risorse"
  type        = string
  default     = "East US"
}

variable "aks_cluster_name" {
  description = "Nome del cluster AKS"
  type        = string
}

variable "node_count" {
  description = "Numero di nodi nel cluster"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "Tipo di VM per i nodi"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "kubernetes_version" {
  description = "Versione di Kubernetes da usare"
  type        = string
  default     = "1.31.10"
}

variable "yaml_manifests" {
  description = "List of YAML manifest URLs from GitHub to apply to the cluster"
  type = list(object({
    name = string
    url  = string
  }))
  default = []
}

variable "apply_manifests" {
  description = "Whether to apply YAML manifests to the cluster"
  type        = bool
  default     = false
}
# Aggiungi queste variabili al tuo FINAL-variables.tf esistente

# Variabili per cert-manager
variable "install_cert_manager" {
  description = "Whether to install cert-manager via Helm"
  type        = bool
  default     = true
}

variable "cert_manager_version" {
  description = "Version of cert-manager Helm chart"
  type        = string
  default     = "v1.18.2"
}

variable "cert_manager_email" {
  description = "Email for Let's Encrypt certificate issuer"
  type        = string
  default     = "admin@example.com"
}

variable "cert_manager_namespace" {
  description = "Namespace for cert-manager installation"
  type        = string
  default     = "cert-manager"
}
