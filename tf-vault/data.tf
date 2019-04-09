data "helm_repository" "stable" {
    name = "stable"
    url  = "https://kubernetes-charts.storage.googleapis.com"
}
data "helm_repository" "incubator" {
    name = "incubator"
    url  = "http://storage.googleapis.com/kubernetes-charts-incubator"
}
