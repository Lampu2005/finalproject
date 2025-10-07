resource_group_name = "rg-aks-demo"
location            = "East US"
aks_cluster_name    = "aks-demo-cluster"
node_count          = 2
node_vm_size        = "Standard_DS2_v2"
kubernetes_version  = "1.31.10"

apply_manifests = true
yaml_manifests = [
  {
    name = "finalproject-app"
    url  = "https://raw.githubusercontent.com/Lampu2005/finalproject/db0de5e7e9ca2879cf704be3eac3d45203103a98/multi-cloud-k8s/k8s/app-deployment.yaml"
  }
]
# Aggiungi alla fine del tuo FINAL-terraform.tfvars esistente

# Configurazione cert-manager
install_cert_manager   = true
cert_manager_version   = "v1.18.2"
cert_manager_email     = "tuaemail@dominio.com"  # CAMBIA CON LA TUA EMAIL
cert_manager_namespace = "cert-manager"
