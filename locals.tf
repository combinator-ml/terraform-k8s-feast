locals {
  feast_postgres_secret_name = "${var.name_prefix}-postgres-secret"
  feast_helm_values = {
    redis = {
      enabled = false
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
      enabled = false
    }

    feast-jupyter = {
      enabled = true
    }
  }
}
