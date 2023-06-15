
@description('Location for the resources')
param location string

@description('Tags for all resources')
param tags object = {}

@description('The name of the application insights resource')
param applicationInsightsName string

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  tags: tags
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

output applicationInsightsName string = applicationInsights.name
