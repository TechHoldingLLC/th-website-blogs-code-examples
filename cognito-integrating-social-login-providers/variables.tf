variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_profile" {
  description = "AWS profile"
  type        = string
}

variable "cognito_apple_authorize_url" {
  description = "Cognito apple authorize url"
  type        = string
}

variable "cognito_apple_client_id" {
  description = "Cognito apple client id"
  type        = string
}

variable "cognito_apple_key_id" {
  description = "Cognito apple key id"
  type        = string
}

variable "cognito_apple_private_key" {
  description = "Cognito apple private key"
  type        = string
}

variable "cognito_apple_team_id" {
  description = "Cognito apple team id"
  type        = string
}

variable "cognito_facebook_attributes_url" {
  description = "Cognito facebook attributes url"
  type        = string
}

variable "cognito_facebook_authorize_url" {
  description = "Cognito facebook authorize url"
  type        = string
}

variable "cognito_facebook_client_id" {
  description = "Cognito facebook client id"
  type        = string
}

variable "cognito_facebook_client_secret" {
  description = "Cognito facebook client secret"
  type        = string
}

variable "cognito_google_attributes_url" {
  description = "Cognito google attributes url"
  type        = string
}

variable "cognito_google_authorize_url" {
  description = "Cognito google authorize url"
  type        = string
}

variable "cognito_google_client_id" {
  description = "Cognito google client id"
  type        = string 
}

variable "cognito_google_client_secret" {
  description = "Cognito google client secret"
  type        = string
}

variable "db_host" {
  description = "Database host"
  type        = string
}

variable "db_host_ro" {
  description = "Database host read only"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
}

variable "db_port" {
  description = "Database port"
  type        = string
}

variable "db_username" {
  description = "Database username"
  type        = string
}

variable "global_parameter_path" {
  description = "Global parameter path"
  type        = string
}

variable "lambda_subnet_ids" {
  description = "Lambda subnet ids"
  type        = string
}

variable "lambda_security_group_ids" {
  description = "Lambda security group ids"
  type        = string
}

variable "lambda_artifacts_bucket_name" {
  description = "Lambda artifacts bucket name"
  type        = string
}