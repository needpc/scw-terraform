provider "scaleway" {
  organization = "${var.scw_organisation}"
  token        = "${var.scw_token}"
  region       = "${var.scw_region}"
  version      = "~> 1.5"
}

provider "cloudflare" {
  email   = "${var.cf_email}"
  token   = "${var.cf_token}"
  version = "~> 1.2"
}
