resource "google_container_cluster" "gke" {
  name               = "gke-demo"
  location           = var.region
  initial_node_count = 1
}
