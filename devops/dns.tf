resource "alicloud_dns_record" "record" {
  name        = "zeyang.site"
  host_record = "jenkins"
  type        = "A"
  value       =  kubernetes_ingress_v1.jenkins_ingress.status[0].load_balancer[0].ingress[0].ip
}