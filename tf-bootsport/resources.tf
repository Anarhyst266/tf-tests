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
  value = "${var.vault_url}"
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
