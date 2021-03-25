require 'yaml'

describe 'compiled component' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/default.test.yaml")).to be_truthy
    end      
  end
  
  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/default/cognito-userpool-client.compiled.yaml") }

  context 'Resource UserPoolClient' do
    let(:properties) { template["Resources"]["UserPoolClient"]["Properties"] }

    it 'has property UserPoolId' do
      expect(properties["UserPoolId"]).to eq({"Ref"=>"UserPoolId"})
    end

    it 'has property ClientName' do
      expect(properties["ClientName"]).to eq({"Fn::Sub" => "${EnvironmentName}"})
    end

    it 'has property AccessTokenValidity' do
      expect(properties["AccessTokenValidity"]).to eq(720)
    end

    it 'has property AllowedOAuthFlows' do
      expect(properties["AllowedOAuthFlows"]).to eq(["code", "implicit"])
    end

    it 'has property AllowedOAuthScopes' do
      expect(properties["AllowedOAuthScopes"]).to eq(["email", "openid", "profile"])
    end

    it 'has property AllowedOAuthFlowsUserPoolClient' do
      expect(properties["AllowedOAuthFlowsUserPoolClient"]).to eq(true)
    end

    it 'has property ExplicitAuthFlows' do
      expect(properties["ExplicitAuthFlows"]).to eq([
        "ALLOW_CUSTOM_AUTH",
        "ALLOW_REFRESH_TOKEN_AUTH",
        "ALLOW_USER_PASSWORD_AUTH",
        "ALLOW_USER_SRP_AUTH"
      ])
    end

    it 'has property IdTokenValidity' do
      expect(properties["IdTokenValidity"]).to eq(720)
    end

    it 'has property PreventUserExistenceErrors' do
      expect(properties["PreventUserExistenceErrors"]).to eq('LEGACY')
    end

    it 'has property ReadAttributes' do
      expect(properties["ReadAttributes"]).to eq([
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
      ])
    end

    it 'has property RefreshTokenValidity' do
      expect(properties["RefreshTokenValidity"]).to eq(30)
    end

    it 'has property SupportedIdentityProviders' do
      expect(properties["SupportedIdentityProviders"]).to eq(['COGNITO'])
    end

    it 'has property TokenValidityUnits' do
      expect(properties["TokenValidityUnits"]).to eq({
        "AccessToken" => "minutes",
        "IdToken" => "minutes",
        "RefreshToken" => "days",
      })
    end

    it 'has property WriteAttributes' do
      expect(properties["WriteAttributes"]).to eq([
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
      ])
    end

  end
end