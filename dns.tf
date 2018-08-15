resource "cloudflare_record" "load-balancer" {
  domain = "needpc.fr"
  name   = "needpc.fr"
  value  = "${scaleway_ip.load-balancer.ip}"
  type   = "A"
  ttl    = 1
  proxied = true
}

resource "cloudflare_record" "api" {
  domain = "needpc.fr"
  name   = "api"
  value  = "${cloudflare_record.load-balancer.hostname}"
  type   = "CNAME"
  ttl    = 1
  proxied = true
}

resource "cloudflare_record" "mobile" {
  domain = "needpc.fr"
  name   = "m"
  value  = "${cloudflare_record.load-balancer.hostname}"
  type   = "CNAME"
  ttl    = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  domain = "needpc.fr"
  name   = "www"
  value  = "${cloudflare_record.load-balancer.hostname}"
  type   = "CNAME"
  ttl    = 1
  proxied = true
}

resource "cloudflare_record" "status" {
  domain = "needpc.fr"
  name   = "status"
  value  = "stats.uptimerobot.com"
  type   = "CNAME"
  ttl    = 3600
  proxied = false
}