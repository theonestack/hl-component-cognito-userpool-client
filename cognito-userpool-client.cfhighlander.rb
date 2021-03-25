CfhighlanderTemplate do

  Description "#{component_name} - #{component_version} - (#{template_name}@#{template_version})"
  Name 'cognito-userpool-client'

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true
    ComponentParam 'UserPoolId'
  end
    
end
