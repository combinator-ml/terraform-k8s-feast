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
  depends_on       = [kubernetes_secret.feast-postgres-secret]
  name             = var.name_prefix
  repository       = local.feast_chart_repository
  chart            = local.feast_chart_name
  version          = local.feast_chart_version
  namespace        = var.namespace
  wait             = true
  create_namespace = true
  lint             = true
  values = [
    yamlencode(local.feast_helm_values)
  ]
}
