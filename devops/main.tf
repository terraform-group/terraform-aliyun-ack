provider "kubernetes" {
  # Configuration options
  config_path    = "../config/clustera.config"
  config_context = "kubernetes-admin-cf1aa641cfb1942c693960bca49925eb7"
  alias          = "clustera"
  insecure       = true
}

resource "kubernetes_namespace" "jenkins" {
  provider = kubernetes.clustera
  metadata {
    name = "devops"
  }
}