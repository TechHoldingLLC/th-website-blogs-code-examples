locals {
  domain_names = [
    "*.${var.domain_name}",
    var.domain_name,
  ]
}
