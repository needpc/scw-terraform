data "scaleway_image" "x86_ubuntu-xenial" {
  architecture = "x86_64"
  name         = "Ubuntu Xenial"
}

# https://www.terraform.io/docs/providers/scaleway/r/ip.html
# IP allocated - Load-Balancer
resource "scaleway_ip" "load-balancer" {}