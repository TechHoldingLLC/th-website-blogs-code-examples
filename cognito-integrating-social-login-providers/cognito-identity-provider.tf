locals {
  cognito_identity_provider_config = {
    "apple" = {
      provider_name = "SignInWithApple"
      provider_details = {
        authorize_scopes              = "email name"
        client_id                     = "cognito_apple_client_id"
        team_id                       = "cognito_apple_team_id"
        key_id                        = "cognito_apple_key_id"
        authorize_url                 = "cognito_apple_authorize_url"
        attributes_url_add_attributes = false
        oidc_issuer                   = "https://appleid.apple.com"
        token_url                     = "https://appleid.apple.com/auth/token"
        token_request_method          = "POST"
        private_key                   = "cognito_apple_private_key"
      }
      attribute_mapping = {
        email       = "email"
        username    = "sub"
        given_name  = "first_name"
        family_name = "last_name"
      }
    },
    "facebook" = {
      provider_name = "Facebook"
      provider_details = {
        authorize_scopes              = "public_profile, email"
        client_id                     = "cognito_facebook_client_id"
        client_secret                 = "cognito_facebook_client_secret"
        attributes_url                = "cognito_facebook_attributes_url"
        authorize_url                 = "cognito_facebook_authorize_url"
        attributes_url_add_attributes = true
        token_request_method          = "GET"
        token_url                     = "https://graph.facebook.com/v17.0/oauth/access_token"
      }
      attribute_mapping = {
        email       = "email"
        username    = "id"
        given_name  = "first_name"
        family_name = "last_name"
      }
    },
    "google" = {
      provider_name = "Google"
      provider_details = {
        authorize_scopes              = "profile email"
        client_id                     = "cognito_google_client_id"
        client_secret                 = "cognito_google_client_secret"
        attributes_url                = "cognito_google_attributes_url"
        authorize_url                 = "cognito_google_authorize_url"
        attributes_url_add_attributes = true
        oidc_issuer                   = "https://accounts.google.com"
        token_request_method          = "POST"
        token_url                     = "https://www.googleapis.com/oauth2/v4/token"
      }
      attribute_mapping = {
        email        = "email"
        username     = "sub"
        given_name   = "given_name"
        family_name  = "family_name"
        phone_number = "phoneNumbers"
        picture      = "picture"
        profile      = "identities"
      }
    }
  }
}

## Cognito Identity provider
resource "aws_cognito_identity_provider" "identity_provider" {
  # Create a var variable for map of IDP details as required and use for_each to iterate over it and create required number of aws_cognito_identity_provider resources.
  for_each = local.cognito_identity_provider_config

  user_pool_id      = aws_cognito_user_pool.user_pool.id
  provider_name     = each.value.provider_name
  provider_type     = each.value.provider_name
  provider_details  = each.value.provider_details
  attribute_mapping = each.value.attribute_mapping
}
