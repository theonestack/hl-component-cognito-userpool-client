CloudFormation do

  read_default_attributes = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo"
  ]

  write_default_attributes = [
    "address",
    "birthdate",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo"
  ]

  client_name = external_parameters.fetch(:client_name, '${EnvironmentName}')
  access_token = external_parameters.fetch(:access_token, {validity: 720, unit: 'minutes'})
  id_token = external_parameters.fetch(:id_token, {validity: 720, unit: 'minutes'})
  refresh_token = external_parameters.fetch(:refresh_token, {validity: 30, unit: 'days'})
  allowed_oauth_flows = external_parameters.fetch(:allowed_oauth_flows, ['code', 'implicit'])
  allowed_oauth_scopes = external_parameters.fetch(:allowed_oauth_scopes, ['email', 'openid', 'profile'])
  allowed_oauth_flows_user_pool_client = external_parameters.fetch(:allowed_oauth_flows_user_pool_client, true)
  analytics_configuration = external_parameters.fetch(:analytics_configuration, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  callback_urls = external_parameters.fetch(:callback_urls, [])
  default_redirect_url = external_parameters.fetch(:default_redirect_url, nil)
  explicit_auth_flows = external_parameters.fetch(:explicit_auth_flows, ['ALLOW_CUSTOM_AUTH', 'ALLOW_REFRESH_TOKEN_AUTH', 'ALLOW_USER_PASSWORD_AUTH', 'ALLOW_USER_SRP_AUTH'])
  generate_secret = external_parameters.fetch(:generate_secret, nil)
  logout_urls = external_parameters.fetch(:logout_urls, [])
  prevent_user_existence_errors = external_parameters.fetch(:prevent_user_existence_errors, 'LEGACY')
  read_attributes = external_parameters.fetch(:read_attributes, read_default_attributes)
  write_attributes = external_parameters.fetch(:write_attributes, write_default_attributes)
  custom_read_attributes = external_parameters.fetch(:custom_read_attributes, [])
  custom_write_attributes = external_parameters.fetch(:custom_write_attributes, [])
  supported_identity_providers = external_parameters.fetch(:supported_identity_providers, ['COGNITO'])

  read_attributes += custom_read_attributes
  write_attributes += custom_write_attributes

  Cognito_UserPoolClient(:UserPoolClient) do
    UserPoolId Ref(:UserPoolId)
    ClientName FnSub(client_name)
    AccessTokenValidity access_token[:validity]
    AllowedOAuthFlows allowed_oauth_flows
    AllowedOAuthScopes allowed_oauth_scopes
    AllowedOAuthFlowsUserPoolClient allowed_oauth_flows_user_pool_client
    AnalyticsConfiguration analytics_configuration unless analytics_configuration.empty?
    CallbackURLs callback_urls unless callback_urls.empty?
    DefaultRedirectURI default_redirect_url unless default_redirect_url.nil?
    ExplicitAuthFlows explicit_auth_flows
    GenerateSecret generate_secret unless generate_secret.nil?
    IdTokenValidity id_token[:validity]
    LogoutURLs logout_urls unless logout_urls.empty?
    PreventUserExistenceErrors prevent_user_existence_errors
    ReadAttributes read_attributes
    RefreshTokenValidity refresh_token[:validity]
    SupportedIdentityProviders supported_identity_providers
    TokenValidityUnits({
      AccessToken: access_token[:unit],
      IdToken: id_token[:unit],
      RefreshToken: refresh_token[:unit]
    })
    WriteAttributes write_attributes
  end

  Output(:UserPoolClient) {
    Value Ref(:UserPoolClient)
    Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-UserPoolClient")
  }

end