path "auth/approle/role/jenkins/secret-id" {
  capabilities = ["update"]
}
path "intermediate-ca/issue/kubernetes-vault" {
  capabilities = ["update"]
}
path "auth/token/roles/kubernetes-vault" {
  capabilities = ["read"]
}
path "/secret/jenkins" {
  capabilities = ["read"]
}
