resource "helm_release" "consul" {
	name = "vault-consul"
	repository = "${data.helm_repository.stable.metadata.0.name}"
  chart = "consul"

  set {
    name = "Replicas"
    value = "1"
  }
}

resource "helm_release" "vault" {
  name = "vault-server"
  repository = "${data.helm_repository.incubator.metadata.0.name}"
  chart = "vault"

  set {
    name = "vault.dev"
    value = "true"
  }
  set {
    name = "vault.config.storage.consul.address"
    value = "vault-consul:8500"
  }
  set {
    name = "vault.config.storage.consul.path"
    value = "vault"
  }
  set {
    name = "service.type"
    value = "NodePort"
  }
  set {
    name = "replicaCount"
    value = "1"
  }
  set {
    name = "vault.config.listener.tcp.address"
    value = "0.0.0.0:8200"
  }
  depends_on = ["helm_release.consul"]
}
