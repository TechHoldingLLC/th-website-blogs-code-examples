# Reserve static external IP address for load balancer
resource "google_compute_global_address" "static_ip" {
  provider = google-beta.google-beta

  name    = "static-ip"
  project = var.gcp_project_id
}

# Get the managed DNS zone
data "google_dns_managed_zone" "dns_zone" {
  provider = google-beta.google-beta

  name = "static-website"
}

# Add the static IP address to the DNS
resource "google_dns_record_set" "static_website" {
  provider = google-beta.google-beta

  name         = "static-website.${data.google_dns_managed_zone.dns_zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.dns_zone.name
  rrdatas      = [google_compute_global_address.static_ip.address]
}

# Add bucket as CDN backend for load balancer
resource "google_compute_backend_bucket" "static_website" {
  provider = google-beta.google-beta

  name        = "static-website-backend"
  bucket_name = google_storage_bucket.static_website.name
  enable_cdn  = true
}

# Load balancer
# Create a partial load balancer for HTTPS redirect
resource "google_compute_url_map" "application_load_balancer_http" {
  name = "partial-http-load-balancer"
  default_url_redirect {
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT" # 301 redirect
    strip_query            = false
    https_redirect         = true
  }
}

resource "google_compute_url_map" "application_load_balancer_https" {
  provider = google-beta.google-beta

  project         = var.gcp_project_id
  name            = "https-load-balancer"
  default_service = google_compute_backend_bucket.static_website.self_link

  host_rule {
    hosts        = ["static-website.${local.domain}"]
    path_matcher = "static-website"
  }

  path_matcher {
    name            = "static-website"
    default_service = google_compute_backend_bucket.static_website.self_link
  }
}

# Target proxy
resource "google_compute_target_http_proxy" "http_redirect_proxy" {
  name    = "http-proxy-redirect"
  url_map = google_compute_url_map.application_load_balancer_http.self_link
}

resource "google_compute_target_https_proxy" "https_proxy" {
  name            = "https-proxy"
  url_map         = google_compute_url_map.application_load_balancer_https.id
  certificate_map = "//certificatemanager.googleapis.com/${google_certificate_manager_certificate_map.certificate_map.id}"
}

# Forwarding rule
resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  provider = google-beta.google-beta

  project               = var.gcp_project_id
  name                  = "http-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_target_http_proxy.http_redirect_proxy.self_link
  ip_address            = google_compute_global_address.static_ip.address # If HTTP-lb and HTTPS-lb don't have the same IP address, the redirect won't work. 
}

resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  provider = google-beta.google-beta

  project               = var.gcp_project_id
  name                  = "https-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_target_https_proxy.https_proxy.self_link
  ip_address            = google_compute_global_address.static_ip.address
}
