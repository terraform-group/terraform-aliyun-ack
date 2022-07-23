resource "kubernetes_deployment_v1" "jenkins" {
  provider = kubernetes.clustera
  metadata {
    name = "jenkins"
    labels = {
      app = "jenkins"
    }
    namespace = kubernetes_namespace.jenkins.id
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "jenkins"
      }
    }

    template {
      metadata {
        labels = {
          app = "jenkins"
        }
      }

      spec {
        container {
          image             = "jenkins/jenkins:2.332.2-centos7-jdk8"
          name              = "jenkins"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "1000m"
              memory = "4096Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "1024Mi"
            }
          }
          #   liveness_probe {
          #     http_get {
          #       path = "/"
          #       port = 8080
          #     }
          #     initial_delay_seconds = 30
          #     period_seconds        = 3
          #   }
        }
      }
    }
  }
}


resource "kubernetes_service_v1" "jenkins" {
  provider = kubernetes.clustera
  metadata {
    name      = "jenkins-service"
    namespace = kubernetes_namespace.jenkins.id
  }
  spec {
    selector = {
      app = kubernetes_deployment_v1.jenkins.metadata[0].labels.app
    }
    port {
      port        = 8080
      target_port = 8080
    }

    type = "ClusterIP"
  }
}


resource "kubernetes_ingress_v1" "jenkins_ingress" {
  provider = kubernetes.clustera
  metadata {
    name      = "jenkins-ingress"
    namespace = kubernetes_namespace.jenkins.id
  }

  spec {
    rule {
      host = "jenkins.zeyang.site"
      http {
        path {
          backend {
            service {
              name = kubernetes_service_v1.jenkins.metadata[0].name
              port {
                number = 8080
              }
            }
          }
          path_type = "Prefix"
          path      = "/"
        }
      }
    }
  }
}