## Post sign up
module "lambda_post_confirmation" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-lambda-function.git?ref=v1.0.10"

  function_name  = "post-confirmation"
  description    = "Post confirmation"
  handler        = "index.handler"
  lambda_runtime = "nodejs22.x"
  lambda_timeout = 60

  security_group_ids = var.lambda_security_group_ids
  subnets            = var.lambda_subnet_ids

  source_file = "../src/post-confirmation"
  output_path = "post-confirmation.zip"

  allowed_triggers = {
    Cognito = {
      statement_id = "AllowCognitoLambdaInvoke"
      principal    = "cognito-idp.amazonaws.com"
      source_arn   = aws_cognito_user_pool.user_pool.arn
    }
  }

  env_vars_from_parameter_store = {
    DB_HOST    = var.db_host
    DB_HOST_RO = var.db_host_ro
    DB_NAME    = var.db_name
    DB_USER    = var.db_user
    DB_PASS    = var.db_pass
    DB_PORT    = var.db_port
  }
}

## Pre sign up
module "lambda_pre_sign_up" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-lambda-function.git?ref=v1.0.10"

  function_name  = "pre-sign-up"
  description    = "Pre sign up"
  handler        = "index.handler"
  lambda_runtime = "nodejs22.x"
  lambda_timeout = 60

  security_group_ids = var.lambda_security_group_ids
  subnets            = var.lambda_subnet_ids

  source_file = "../src/pre-sign-up"
  output_path = "pre-sign-up.zip"

  allowed_triggers = {
    Cognito = {
      statement_id = "AllowCognitoLambdaInvoke"
      principal    = "cognito-idp.amazonaws.com"
      source_arn   = aws_cognito_user_pool.user_pool.arn
    }
  }

  env_vars_from_parameter_store = {
    DB_HOST    = var.db_host
    DB_HOST_RO = var.db_host_ro
    DB_NAME    = var.db_name
    DB_USER    = var.db_user
    DB_PASS    = var.db_pass
    DB_PORT    = var.db_port
  }
}
