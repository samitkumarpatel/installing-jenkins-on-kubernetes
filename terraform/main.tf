resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.namespace
  }
}

# ConfigMap
resource "kubernetes_config_map" "jenkins" {
  metadata {
    name = var.name
    namespace = var.namespace
  }

  data = {
    "jcac.yaml" = file("${path.module}/jcac.yml")
  }
}


# Deployment
resource "kubernetes_deployment" "jenkins" {
  metadata {
    name = var.name
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = var.name
      }
    }

    template {
      metadata {
        labels = {
          app = var.name
        }
      }

      spec {
        service_account_name = var.name
        container {
          image = "samitkumarpatel/jenkins:lts"
          name  = var.name
          env {
              name = "JAVA_OPTS"
              value = "-Djenkins.install.runSetupWizard=false"
          }
          env {
              name = "CASC_JENKINS_CONFIG"
              value = "/var/jenkins_home/casc_configs/jcac.yaml"
          }
          port {
              name = "http"
              container_port = 8080
          }
          port {
              name = "jnlp"
              container_port = 50000
          }
          volume_mount {
            name = "jenkins-home"
            mount_path = "/var/jenkins_home"
          }
          volume_mount {
            name = "jcac"
            mount_path = "/var/jenkins_home/casc_configs"
          }
        }
        volume {
            name = "jenkins-home"
            empty_dir {}
        }
        volume {
            name = "jcac"
            config_map {
              name = var.name
            }
        }
      }
    }

  }
}

# Service
resource "kubernetes_service" "jenkins" {
  metadata {
    name = var.name
    namespace = var.namespace
  }
  spec {
    type = "NodePort"
    selector = {
      app = var.name
    }
    port {
      name = "http"
      port        = 8080
      target_port = 8080
    }
    port {
      name = "jnlp"
      port        = 50000
      target_port = 50000
    }
    
  }
}