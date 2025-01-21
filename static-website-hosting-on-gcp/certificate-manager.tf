locals {
  domain = "example.com"
}

resource "google_certificate_manager_dns_authorization" "static_website" {
  name        = "static-website-dns-authorization"
  description = "DNS authorization for a wildcard certificate"
  domain      = local.domain
}

# automatically attach the SSL to sub-domains
resource "google_certificate_manager_certificate" "root_cert" {
  name        = "root-cert"
  description = "The wildcard cert"
  managed {
    domains = [local.domain, "*.${local.domain}"]
    dns_authorizations = [
      google_certificate_manager_dns_authorization.static_website.id
    ]
  }
}

resource "google_certificate_manager_certificate_map" "certificate_map" {
  name = "certificate-map"
}

resource "google_certificate_manager_certificate_map_entry" "map_entry" {
  name         = "map-entry"
  map          = google_certificate_manager_certificate_map.certificate_map.name
  certificates = [google_certificate_manager_certificate.root_cert.id]
  hostname     = "*.${local.domain}"
}
