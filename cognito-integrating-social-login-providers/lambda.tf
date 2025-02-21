## Post sign up
module "lambda_post_sign_up" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-lambda-function.git?ref=v1.0.10"

  function_name  = "post-sign-up"
  description    = "Post sign up"
  handler        = "index.handler"
  lambda_runtime = "nodejs22.x"
  lambda_timeout = 60

  security_group_ids = "security_group_id_for_lambda"
  subnets            = "subnet_id"

  s3_bucket = "lambda_artifacts_bucket_name"
  s3_key    = "post-sign-up.zip"

  allowed_triggers = {
    Cognito = {
      statement_id = "AllowCognitoLambdaInvoke"
      principal    = "cognito-idp.amazonaws.com"
      source_arn   = aws_cognito_user_pool.user_pool.arn
    }
  }

  env_vars_from_parameter_store = {
    DB_HOST    = local.db_host
    DB_HOST_RO = local.db_host_ro
    DB_NAME    = local.db_name
    DB_USER    = local.db_user
    DB_PASS    = local.db_pass
    DB_PORT    = local.db_port
  }
}

## Pre sign up
module "lambda_pre_sign_up" {
  source = "git::https://github.com/TechHoldingLLC/terraform-aws-lambda-function.git?ref=v1.0.10"

  function_name      = "pre-sign-up"
  description        = "Pre sign up"
  handler            = "index.handler"
  lambda_runtime     = "nodejs22.x"
  security_group_ids = "security_group_id_for_lambda"
  subnets            = "subnet_id"
  lambda_timeout     = 60

  s3_bucket = "lambda_artifacts_bucket_name"
  s3_key    = "pre-sign-up.zip"

  allowed_triggers = {
    Cognito = {
      statement_id = "AllowCognitoLambdaInvoke"
      principal    = "cognito-idp.amazonaws.com"
      source_arn   = aws_cognito_user_pool.user_pool.arn
    }
  }

  env_vars_from_parameter_store = {
    DB_HOST    = local.db_host
    DB_HOST_RO = local.db_host_ro
    DB_NAME    = local.db_name
    DB_USER    = local.db_user
    DB_PASS    = local.db_pass
    DB_PORT    = local.db_port
  }
}
