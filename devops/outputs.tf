output "service_name" {
  value = kubernetes_service_v1.jenkins.metadata[0].name

}

output "ingress_ip" {
  value = kubernetes_ingress_v1.jenkins_ingress.status[0].load_balancer[0].ingress[0].ip
  
}