# Creazione del Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Creazione del cluster AKS
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.aks_cluster_name

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = var.kubernetes_version
}

# Get cluster credentials automatically
resource "null_resource" "get_credentials" {
  depends_on = [azurerm_kubernetes_cluster.aks]

  triggers = {
    cluster_id = azurerm_kubernetes_cluster.aks.id
  }

  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.rg.name} --name ${azurerm_kubernetes_cluster.aks.name} --overwrite-existing"
  }
}

# Installazione cert-manager usando il comando richiesto
resource "null_resource" "install_cert_manager" {
  count = var.install_cert_manager ? 1 : 0

  depends_on = [null_resource.get_credentials]

  triggers = {
    cluster_id = azurerm_kubernetes_cluster.aks.id
    version    = var.cert_manager_version
  }

  provisioner "local-exec" {
    command = "helm repo add jetstack https://charts.jetstack.io --force-update && helm repo update && helm install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --version ${var.cert_manager_version} --set installCRDs=true"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "helm uninstall cert-manager --namespace cert-manager || true"
    on_failure = continue
  }
}

# Apply YAML manifests
resource "null_resource" "apply_manifests" {
  count = var.apply_manifests ? length(var.yaml_manifests) : 0

  depends_on = [null_resource.get_credentials, null_resource.install_cert_manager]

  triggers = {
    cluster_id = azurerm_kubernetes_cluster.aks.id
    manifest_url = var.yaml_manifests[count.index].url
  }

  provisioner "local-exec" {
    command = "kubectl apply -f \"${var.yaml_manifests[count.index].url}\""
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f '${self.triggers.manifest_url}' --ignore-not-found=true"
    on_failure = continue
  }
}
