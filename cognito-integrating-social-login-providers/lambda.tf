## Post sign up
module "lambda_post_confirmation" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-lambda-function.git?ref=v1.0.10"

  function_name  = "post-confirmation"
  description    = "Post confirmation"
  handler        = "index.handler"
  lambda_runtime = "nodejs22.x"

  security_group_ids = ["lambda_security_group_ids"]
  subnets            = ["lambda_subnet_ids"]

  source_file = "../src/post-confirmation"
  output_path = "post-confirmation.zip"

  allowed_triggers = {
    Cognito = {
      statement_id = "AllowCognitoLambdaInvoke"
      principal    = "cognito-idp.amazonaws.com"
      source_arn   = aws_cognito_user_pool.user_pool.arn
    }
  }

  environment_variables = {
    DB_URL = "database_url"
  }
}

## Pre sign up
module "lambda_pre_sign_up" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-lambda-function.git?ref=v1.0.10"

  function_name  = "pre-sign-up"
  description    = "Pre sign up"
  handler        = "index.handler"
  lambda_runtime = "nodejs22.x"

  security_group_ids = ["lambda_security_group_ids"]
  subnets            = ["lambda_subnet_ids"]

  source_file = "../src/pre-sign-up"
  output_path = "pre-sign-up.zip"

  allowed_triggers = {
    Cognito = {
      statement_id = "AllowCognitoLambdaInvoke"
      principal    = "cognito-idp.amazonaws.com"
      source_arn   = aws_cognito_user_pool.user_pool.arn
    }
  }

  environment_variables = {
    DB_URL = "database_url"
  }
}
