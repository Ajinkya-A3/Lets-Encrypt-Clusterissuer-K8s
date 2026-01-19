resource "helm_release" "cert_manager" {
  name      = "cert-manager"
  namespace = kubernetes_namespace.cert_manager.metadata[0].name

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  # 🔒 FIXED chart version (matches existing cluster)
  version = "1.19.2"

  values = [
    file("${path.module}/values-cert-manager.yaml")
  ]

  wait    = true
  timeout = 600

  force_update  = true
  recreate_pods = true

  depends_on = [
    kubernetes_namespace.cert_manager
  ]
}
