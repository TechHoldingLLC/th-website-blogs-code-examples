# Cognito
data "aws_ssm_parameter" "cognito_apple_client_id" {
  name = "${var.global_parameter_path}/cognito/COGNITO_APPLE_CLIENT_ID"
}

data "aws_ssm_parameter" "cognito_apple_team_id" {
  name = "${var.global_parameter_path}/cognito/COGNITO_APPLE_TEAM_ID"
}

data "aws_ssm_parameter" "cognito_apple_key_id" {
  name = "${var.global_parameter_path}/cognito/COGNITO_APPLE_KEY_ID"
}

data "aws_ssm_parameter" "cognito_apple_pvt_key" {
  name = "${var.global_parameter_path}/cognito/COGNITO_APPLE_PVT_KEY"
}

data "aws_ssm_parameter" "cognito_apple_authorize_url" {
  name = "${var.global_parameter_path}/cognito/COGNITO_APPLE_AUTHORIZE_URL"
}

data "aws_ssm_parameter" "cognito_facebook_client_id" {
  name = "${var.global_parameter_path}/cognito/COGNITO_FACEBOOK_CLIENT_ID"
}

data "aws_ssm_parameter" "cognito_facebook_client_secret" {
  name = "${var.global_parameter_path}/cognito/COGNITO_FACEBOOK_CLIENT_SECRET"
}

data "aws_ssm_parameter" "cognito_facebook_attributes_url" {
  name = "${var.global_parameter_path}/cognito/COGNITO_FACEBOOK_ATTRIBUTES_URL"
}

data "aws_ssm_parameter" "cognito_facebook_authorize_url" {
  name = "${var.global_parameter_path}/cognito/COGNITO_FACEBOOK_AUTHORIZE_URL"
}

data "aws_ssm_parameter" "cognito_google_client_id" {
  name = "${var.global_parameter_path}/cognito/COGNITO_GOOGLE_CLIENT_ID"
}

data "aws_ssm_parameter" "cognito_google_client_secret" {
  name = "${var.global_parameter_path}/cognito/COGNITO_GOOGLE_CLIENT_SECRET"
}

data "aws_ssm_parameter" "cognito_google_attributes_url" {
  name = "${var.global_parameter_path}/cognito/COGNITO_GOOGLE_ATTRIBUTES_URL"
}

data "aws_ssm_parameter" "cognito_google_authorize_url" {
  name = "${var.global_parameter_path}/cognito/COGNITO_GOOGLE_AUTHORIZE_URL"
}

## Lambda
data "aws_ssm_parameter" "lambda_subnet_ids" {
  name = "${var.global_parameter_path}/lambda/LAMBDA_SUBNET_IDS"
}

data "aws_ssm_parameter" "lambda_security_group_ids" {
  name = "${var.global_parameter_path}/lambda/LAMBDA_SECURITY_GROUP_IDS"
}

data "aws_ssm_parameter" "lmabda_artifacts_bucket_name" {
  name = "${var.global_parameter_path}/lambda/LAMBDA_ARTIFACTS_BUCKET_NAME"
}

locals {
  ## Cognito
  cognito_apple_client_id         = data.aws_ssm_parameter.cognito_apple_client_id.value
  cognito_apple_team_id           = data.aws_ssm_parameter.cognito_apple_team_id.value
  cognito_apple_key_id            = data.aws_ssm_parameter.cognito_apple_key_id.value
  cognito_apple_pvt_key           = data.aws_ssm_parameter.cognito_apple_pvt_key.value
  cognito_apple_authorize_url     = data.aws_ssm_parameter.cognito_apple_authorize_url.value
  cognito_facebook_client_id      = data.aws_ssm_parameter.cognito_facebook_client_id.value
  cognito_facebook_client_secret  = data.aws_ssm_parameter.cognito_facebook_client_secret.value
  cognito_facebook_attributes_url = data.aws_ssm_parameter.cognito_facebook_attributes_url.value
  cognito_facebook_authorize_url  = data.aws_ssm_parameter.cognito_facebook_authorize_url.value
  cognito_google_client_id        = data.aws_ssm_parameter.cognito_google_client_id.value
  cognito_google_client_secret    = data.aws_ssm_parameter.cognito_google_client_secret.value
  cognito_google_attributes_url   = data.aws_ssm_parameter.cognito_google_attributes_url.value
  cognito_google_authorize_url    = data.aws_ssm_parameter.cognito_google_authorize_url.value

  ## DB
  db_host    = "${var.global_parameter_path}/rds/default/endpoint"
  db_host_ro = "${var.global_parameter_path}/rds/default/reader_endpoint"
  db_name    = "${var.global_parameter_path}/rds/default/db_name"
  db_user    = "${var.global_parameter_path}/rds/default/db_master_username"
  db_pass    = "${var.global_parameter_path}/rds/default/db_master_password"
  db_port    = "${var.global_parameter_path}/rds/default/port"

  ## lambda
  lambda_subnet_ids            = data.aws_ssm_parameter.lambda_subnet_ids.value
  lambda_security_group_ids    = data.aws_ssm_parameter.lambda_security_group_ids.value
  lambda_artifacts_bucket_name = data.aws_ssm_parameter.lambda_artifacts_bucket_name.value
}