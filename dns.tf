#############################
#     CLOUDFLARE DNS LB     #
#############################

# https://www.terraform.io/docs/providers/cloudflare/r/record.html
# DNS Record - Load-Balancer
resource "cloudflare_record" "load-balancer" {
  domain = "needpc.fr"
  name   = "needpc.fr"
  value  = "${scaleway_ip.load-balancer.ip}"
  type   = "A"
  ttl    = 1
  proxied = true
}


#############################
#     CLOUDFLARE DNS API    #
#############################

# https://www.terraform.io/docs/providers/cloudflare/r/record.html
# DNS Record - api
resource "cloudflare_record" "api" {
  domain = "needpc.fr"
  name   = "api"
  value  = "${cloudflare_record.load-balancer.hostname}"
  type   = "CNAME"
  ttl    = 1
  proxied = true
}


#############################
#   CLOUDFLARE DNS MOBILE   #
#############################

# https://www.terraform.io/docs/providers/cloudflare/r/record.html
# DNS Record - m
resource "cloudflare_record" "mobile" {
  domain = "needpc.fr"
  name   = "m"
  value  = "${cloudflare_record.load-balancer.hostname}"
  type   = "CNAME"
  ttl    = 1
  proxied = true
}


##########################
#   CLOUDFLARE DNS WWW   #
##########################

# https://www.terraform.io/docs/providers/cloudflare/r/record.html
# DNS Record - www
resource "cloudflare_record" "www" {
  domain = "needpc.fr"
  name   = "www"
  value  = "${cloudflare_record.load-balancer.hostname}"
  type   = "CNAME"
  ttl    = 1
  proxied = true
}

# https://www.terraform.io/docs/providers/cloudflare/r/page_rule.html
# Forwarding rules - www
resource "cloudflare_page_rule" "www" {
  zone = "${cloudflare_record.load-balancer.hostname}"
  target = "https://${cloudflare_record.load-balancer.hostname}"
  priority = 1

  actions = {
    forwarding_url {
      url = "https://${cloudflare_record.www.hostname}"
      status_code = 301
    } 
  }
}


##########################
# CLOUDFLARE DNS STATUS  #
##########################

# https://www.terraform.io/docs/providers/cloudflare/r/record.html
# DNS Record - status
resource "cloudflare_record" "status" {
  domain = "needpc.fr"
  name   = "status"
  value  = "stats.uptimerobot.com"
  type   = "CNAME"
  ttl    = 3600
  proxied = false
}