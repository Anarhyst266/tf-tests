resource "helm_release" "datadog" {
  name = "datadog"
  repository = "${data.helm_repository.stable.metadata.0.name}"
  chart = "datadog"

  set {
    name = "datadog.apiKey"
    value = "${var.api_key}"
  }
}
