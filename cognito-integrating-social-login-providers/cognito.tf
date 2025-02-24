## Cognito user pool
resource "aws_cognito_user_pool" "user_pool" {
  name = "example-user-pool"

  deletion_protection = "ACTIVE"

  auto_verified_attributes = [
    "email"
  ]

  password_policy {
    minimum_length                   = 8
    password_history_size            = 3
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days = 7
  }

  lambda_config {
    post_confirmation = module.lambda_post_sign_up.arn
    pre_sign_up       = module.lambda_pre_sign_up.arn
  }
}

## Cognito user pool domain
resource "aws_cognito_user_pool_domain" "domain" {
  # to use custom domain, enter the full domain name here. for example: "cognito.example-app.com"
  # to use cognito domain, enter only subdomain. for example: "example-app"
  domain       = "example-app"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}
