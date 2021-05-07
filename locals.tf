locals {
  feast_chart_repository     = "https://feast-helm-charts.storage.googleapis.com"
  feast_chart_name           = "feast"
  feast_chart_version        = "0.100.4"
  feast_postgres_secret_name = "${var.name_prefix}-postgres-secret"
  feast_helm_values = {
    redis = {
      enabled = true
    }
    kafka = {
      enabled = false
    }
    grafana = {
      enabled = false
    }
    postgresql = {
      existingSecret = local.feast_postgres_secret_name
    }
    feast-core = {
      postgresql = {
        existingSecret = local.feast_postgres_secret_name
      }
    }
    feast-serving = {
      enabled = true
    }
    feast-jupyter = {
      enabled = true
    }
  }
}
