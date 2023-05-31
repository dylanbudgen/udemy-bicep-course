

//lower camel case

@minLength(3)
@maxLength(11)
param location string = 'westeurope'

@description('Name of the storage account')
param storageAccountName string

@description('SKU for storage accounts')
param storageAccountSku string

@description('Name of the app service plan SKU')
param appServicePlanSku string

@description('Name of the function app')
param functionAppName string

@description('Name of the app service plan')
param appServicePlanName string

@description('Name of the application insights')
param applicationInsightsName string

@secure()
@description('Key for our useful API')
param apiKey string

var containerNames = [
  'container'
  'container2'
]

// TODO include a loop somewhere
// note about deployment names

module storageAccount 'modules/storage-account.bicep' = {
  name: storageAccountName
  params: {
    location: location
    tags: {}
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
    containerNames: containerNames
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

// TODO compare to modules
resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku
  }
  properties: {}
}

// list keys somewhere

resource functionApp 'Microsoft.Web/sites@2021-03-01' = {
  name: functionAppName
  location: location
  kind: 'functionapp'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      alwaysOn: true
      use32BitWorkerProcess: false
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: applicationInsights.properties.InstrumentationKey
        }
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: applicationInsights.properties.ConnectionString
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccountName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${storageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'ApiKey'
          value: apiKey
        }
      ]
      ftpsState: 'FtpsOnly'
      minTlsVersion: '1.2'
    }
    httpsOnly: true
  }
}

// outputs cannot have sensitive date, use existing
output functionAppName string = functionApp.name
