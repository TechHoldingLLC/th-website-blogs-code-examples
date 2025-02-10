module "acm_example" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-acm.git?ref=v1.1.1"

  domain_config = [
    {
      hosted_zone_id = var.hosted_zone_id,
      domain_name = [
        "*.${var.domain_name}",
        var.domain_name
      ]
    }
  ]

  providers = {
    aws = aws.us-east-1
  }
}
