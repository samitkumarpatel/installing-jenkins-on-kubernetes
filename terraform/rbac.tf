# Service Account
resource "kubernetes_service_account" "jenkins" {
  metadata {
    name = var.name
    namespace = var.namespace
  }
}

# ClusterRole
resource "kubernetes_cluster_role" "jenkins" {
  metadata {
    name = var.name
    annotations = {
      "rbac.authorization.kubernetes.io/autoupdate" = "true"
    }
    labels = {
      "kubernetes.io/bootstrapping" = "rbac-defaults"
    }
  }
  rule {
    api_groups = ["*"]
    resources  = ["statefulsets"
      , "services"
      , "replicationcontrollers"
      , "replicasets"
      , "podtemplates"
      , "podsecuritypolicies"
      , "pods"
      , "pods/log"
      , "pods/exec"
      , "podpreset"
      , "poddisruptionbudget"
      , "persistentvolumes"
      , "persistentvolumeclaims"
      , "jobs"
      , "endpoints"
      , "deployments"
      , "deployments/scale"
      , "daemonsets"
      , "cronjobs"
      , "configmaps"
      , "namespaces"
      , "events"
      , "secrets"
    ]
    verbs      = ["create","delete","get","list","patch","update","watch","apply"]
  }
  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["get","list","watch", "update"]
  }

  # rule {
  #   api_groups = [""]
  #   resources  = ["pods"]
  #  verbs      = ["create","delete","get","list","patch","update","watch"]
  # }
  # rule {
  #   api_groups = [""]
  #   resources  = ["pods/exec"]
  #   verbs      = ["create","delete","get","list","patch","update","watch"]
  # }
  # rule {
  #   api_groups = [""]
  #   resources  = ["pods/log"]
  #   verbs      = ["get","list","watch"]
  # }
  # rule {
  #   api_groups = [""]
  #   resources  = ["secrets"]
  #   verbs      = ["create","delete","get","list","patch","update"]
  # }
  # rule {
  #   api_groups = [""]
  #   resources  = ["configmaps"]
  #   verbs      = ["create","delete","get","list","patch","update"]
  # }
  # rule {
  #   api_groups = [""]
  #   resources  = ["apps"]
  #   verbs      = ["create","delete","get","list","patch","update"]
  # }
  # rule {
  #   api_groups = [""]
  #   resources  = ["services"]
  #   verbs      = ["create","delete","get","list","patch","update"]
  # }
  # rule {
  #   api_groups = [""]
  #   resources  = ["ingresses"]
  #   verbs      = ["create","delete","get","list","patch","update"]
  # }
}

# ClusterRoleBinding
resource "kubernetes_cluster_role_binding" "jenkins" {
  metadata {
    name      = var.name
    annotations = {
      "rbac.authorization.kubernetes.io/autoupdate" = "true"
    }
    labels = {
      "kubernetes.io/bootstrapping" = "rbac-defaults"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = var.name
  }
  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Group"
    name      = "system:serviceaccounts:${var.name}"
  }
}