module "feast" {
  source = "combinator-ml/feast/k8s"
}

resource "kubernetes_service" "jupyter" {
  metadata {
    name = "testfaster-jupyter"
  }
  spec {
    selector = {
      app = "feast-jupyter"
    }
    port {
      port        = 31888
      target_port = 8888
    }
    type = "NodePort"
  }
}
