variable "namespace" {
  description = "(Optional) The namespace to install into. Defaults to feast."
  type        = string
  default     = "feast"
}

module "feast" {
  source    = "combinator-ml/feast/k8s"
  namespace = var.namespace
}

resource "kubernetes_service" "jupyter" {
  metadata {
    name      = "testfaster-jupyter"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "feast-jupyter"
    }
    port {
      port        = 8888
      target_port = 8888
      node_port   = 31888
    }
    type = "NodePort"
  }
}
