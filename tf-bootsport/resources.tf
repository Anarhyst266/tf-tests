resource "helm_release" "kubernetes-vault" {
 name = "kubernetes-vault"
 repository = "${data.helm_repository.incubator.metadata.0.name}"
 chart = "kubernetes-vault"

 set {
  name = "imageTag"
  value = "0.6.1"
 }
 set {
  name = "configMap.vault.addr"
  value = "http://${data.kubernetes_service.vault-server-vault.metadata.0.name}:8200"
 }
 set {
  name = "configMap.vault.token"
  value = "${var.vault_token}"
 }
 set {
  name = "serviceAccount.create"
  value = true
 }
 set {
  name = "rbac.create"
  value = true
 }
}
