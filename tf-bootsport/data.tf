data "kubernetes_service" "vault-server-vault" {
  metadata {
    name = "vault-server-vault"
  }
}
data "helm_repository" "incubator" {
    name = "incubator"
    url  = "http://storage.googleapis.com/kubernetes-charts-incubator"
}
