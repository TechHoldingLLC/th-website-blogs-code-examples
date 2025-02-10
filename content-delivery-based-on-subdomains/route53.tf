resource "aws_route53_record" "example" {
  count   = length(local.domain_names)
  zone_id = "Z0209855HQNYJ43CRP7D"
  name    = local.domain_names[count.index]
  type    = "A"

  alias {
    name                   = module.cloudfront_example.domain_name
    zone_id                = module.cloudfront_example.hosted_zone_id
    evaluate_target_health = true
  }
}