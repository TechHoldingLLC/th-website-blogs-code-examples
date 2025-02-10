module "cloudfront_example" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-cloudfront.git?ref=v1.0.8"

  comment = "example-function"

  origin = [
    {
      domain_name              = module.s3_example.bucket_regional_domain_name
      origin_id                = module.s3_example.bucket_name
      origin_access_control_id = module.s3_example.origin_access_control_id

      # Set X-Env-S3-Bucket-Regional-Domain-Name custom header to use it in origin request Lambda
      custom_header = [
        {
          name  = "X-Env-S3-Bucket-Regional-Domain-Name"
          value = module.s3_example.bucket_regional_domain_name
        }
      ]
    }
  ]

  domain_aliases = local.domain_names

  acm_arn                                  = module.acm_example.arn
  default_cache_behaviour_target_origin_id = module.s3_example.bucket_name
  allowed_methods                          = ["GET", "HEAD"]

  # These values are default
  ttl_values = {
    min_ttl     = 0
    max_ttl     = 31536000 # 365 Days
    default_ttl = 86400    # 1 Day
  }

  # Cache host header to cache based on host value
  # Must declare, can be empty map
  default_cache_forwarded_values = {}

  lambda_function_association = [
    # Use viewer request block to configura a Lambda@Edge to set the host header for origin request when Host header is not cached in CloudFront.
    {
      event_type   = "origin-request"
      lambda_arn   = aws_lambda_function.example_origin_request.qualified_arn
      include_body = true
    }
  ]
}