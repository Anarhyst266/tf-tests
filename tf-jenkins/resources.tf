resource "kubernetes_service_account" "jenkins" {
  metadata {
    name = "jenkins"
  }
}
resource "kubernetes_cluster_role" "jenkins" {
  metadata {
    name = "jenkins"
  }

  rule {
      api_groups = [""]
      resources = ["services", "endpoints", "pods", "secrets", "deployments"]
      verbs = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}
resource "kubernetes_cluster_role_binding" "jenkins" {
  metadata {
    name = "jenkins"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "${kubernetes_cluster_role.jenkins.metadata.0.name}"
  }
  subject {
    kind = "ServiceAccount"
    name = "${kubernetes_service_account.jenkins.metadata.0.name}"
    namespace = "default"
  }
  depends_on = ["kubernetes_service_account.jenkins","kubernetes_cluster_role.jenkins"]
}

resource "vault_generic_secret" "jenkins" {
  path = "secret/jenkins"
  depends_on = ["data.kubernetes_secret.jenkins"]
  data_json = <<EOT
  {
    "kubernetes_url": "https://kubernetes.default",
    "kubernetes_token": "${lookup(data.kubernetes_secret.jenkins.data, "token")}"
  }
  EOT
}


resource "helm_release" "jenkins" {
  name = "jenkins"
  repository = "${data.helm_repository.local.metadata.0.name}"
  chart = "jenkins"
  version = "0.39.1"

  values = [
    "${file("jenkins_values.yaml")}",
    "Master:\n  InitContainerEnv:\n    - name: CASC_VAULT_FILE\n      value: \"/var/jenkins_home/VAULT_FILE\"",
    "Master:\n  ContainerEnv:\n    - name: CASC_VAULT_FILE\n      value: \"/var/jenkins_home/VAULT_FILE\"",
    "Master:\n  JCasC:\n    ConfigScripts:\n      datadog-config: |\n        unclassified:\n          datadogBuildListener:\n            apiKey: \"${lookup(data.kubernetes_secret.datadog.data, "api-key")}\""
  ]
  depends_on = ["vault_generic_secret.jenkins"]
}
