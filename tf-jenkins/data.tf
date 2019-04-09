data "helm_repository" "stable" {
    name = "stable"
    url  = "https://kubernetes-charts.storage.googleapis.com"
}
data "helm_repository" "incubator" {
    name = "incubator"
    url  = "http://storage.googleapis.com/kubernetes-charts-incubator"
}
data "kubernetes_secret" "jenkins" {
  metadata {
    name = "${kubernetes_service_account.jenkins.default_secret_name}"
  }
  depends_on = ["kubernetes_service_account.jenkins"]
}
