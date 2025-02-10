module "s3_example" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-s3-bucket.git?ref=v1.0.4"

  name                  = var.domain_name
  origin_access_control = true
  cloudfront_arn        = module.cloudfront_example.arn
}
