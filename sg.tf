# https://www.terraform.io/docs/providers/cloudflare/d/ip_ranges.html
# IPs Cloudflare
data "cloudflare_ip_ranges" "cloudflare" {}

###########################
#      LOAD BALANCER      #
###########################

# https://www.terraform.io/docs/providers/scaleway/r/security_group.html
# Security Group - Load-Balancer
resource "scaleway_security_group" "load-balancer" {
  name                    = "sg.needpc.lb"
  description             = "Security Group NeedPC Load Balancer"
  enable_default_security = true
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule ICMP - Load-Balancer
resource "scaleway_security_group_rule" "load-balancer-icmp" {
  security_group = "${scaleway_security_group.load-balancer.id}"
  action         = "accept"
  direction      = "inbound"
  ip_range       = "10.0.0.0/8"
  protocol       = "ICMP"
  port           = 0
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule SSH - Load-Balancer
resource "scaleway_security_group_rule" "load-balancer-ssh" {
  security_group = "${scaleway_security_group.load-balancer.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 22
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule HTTP - Load-Balancer
resource "scaleway_security_group_rule" "load-balancer-http" {
  count          = "${length(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks)}"
  security_group = "${scaleway_security_group.load-balancer.id}"
  action         = "accept"
  direction      = "inbound"
  ip_range       = "${element(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks, count.index)}"
  protocol       = "TCP"
  port           = 80
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule HTTPS - Load-Balancer
resource "scaleway_security_group_rule" "load-balancer-https" {
  count          = "${length(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks)}"
  security_group = "${scaleway_security_group.load-balancer.id}"
  action         = "accept"
  direction      = "inbound"
  ip_range       = "${element(data.cloudflare_ip_ranges.cloudflare.ipv4_cidr_blocks, count.index)}"
  protocol       = "TCP"
  port           = 443
}

###########################
#         DATABASE        #
###########################

# https://www.terraform.io/docs/providers/scaleway/r/security_group.html
# Security Group - Database
resource "scaleway_security_group" "database" {
  name                    = "sg.needpc.db"
  description             = "Security Group NeedPC Database"
  enable_default_security = true
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule ICMP - Load-Balancer
resource "scaleway_security_group_rule" "database-icmp" {
  security_group = "${scaleway_security_group.database.id}"
  action         = "accept"
  direction      = "inbound"
  ip_range       = "10.0.0.0/8"
  protocol       = "ICMP"
  port           = 0
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule SSH - Load-Balancer
resource "scaleway_security_group_rule" "database-ssh" {
  security_group = "${scaleway_security_group.database.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 22
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule SSH - Load-Balancer
resource "scaleway_security_group_rule" "database-postgresql" {
  security_group = "${scaleway_security_group.database.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 5432
}


###########################
#        KUBERNETES       #
###########################

# https://www.terraform.io/docs/providers/scaleway/r/security_group.html
# Security Group - Kubernetes Master
resource "scaleway_security_group" "kubernetes-master" {
  name                    = "sg.needpc.k8s"
  description             = "Security Group NeedPC Kubernetes"
  enable_default_security = true
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule ICMP - Kubernetes Master
resource "scaleway_security_group_rule" "kubernetes-icmp" {
  security_group = "${scaleway_security_group.kubernetes-master.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "ICMP"
  port      = 0
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule SSH - Kubernetes Master
resource "scaleway_security_group_rule" "kubernetes-ssh" {
  security_group = "${scaleway_security_group.kubernetes-master.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 22
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule HTTP - Kubernetes Master
resource "scaleway_security_group_rule" "kubernetes-http" {
  security_group = "${scaleway_security_group.kubernetes-master.id}"
  action         = "accept"
  direction      = "inbound"
  ip_range       = "10.0.0.0/8"
  protocol       = "TCP"
  port           = 80
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule HTTPS - Kubernetes Master
resource "scaleway_security_group_rule" "kubernetes-https" {
  security_group = "${scaleway_security_group.kubernetes-master.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 443
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule HTTP LB - Kubernetes Master
resource "scaleway_security_group_rule" "kubernetes-lb-http" {
  security_group = "${scaleway_security_group.kubernetes-master.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 31372
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule HTTP ETCD Reader - Kubernetes Master
resource "scaleway_security_group_rule" "kubernetes-etcd-read" {
  security_group = "${scaleway_security_group.kubernetes-master.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 2379
}

# https://www.terraform.io/docs/providers/scaleway/r/security_group_rule.html
# Security Group Rule ETCD Writter - Kubernetes Master
resource "scaleway_security_group_rule" "kubernetes-etcd-write" {
  security_group = "${scaleway_security_group.kubernetes-master.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "10.0.0.0/8"
  protocol  = "TCP"
  port      = 2380
}
