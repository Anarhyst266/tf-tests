provider "helm" {
	kubernetes {
		config_path = "~/.kube/config"
	}
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "vault" {
  address = "${var.vault_url}"
  token = "${var.vault_token}"
}
