resource "random_password" "feast-postgres-password" {
  length  = 16
  special = false
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_secret" "feast-postgres-secret" {
  depends_on = [kubernetes_namespace.namespace]
  metadata {
    name      = local.feast_postgres_secret_name
    namespace = var.namespace
  }
  data = {
    postgresql-password = random_password.feast-postgres-password.result
  }
}

resource "helm_release" "feast" {
  depends_on = [kubernetes_secret.feast-postgres-secret]

  name             = var.name_prefix
  chart            = "https://feast-helm-charts.storage.googleapis.com/feast-0.100.4.tgz"
  namespace        = var.namespace
  wait             = true
  create_namespace = true
  values = [
    yamlencode(local.feast_helm_values)
  ]
}
