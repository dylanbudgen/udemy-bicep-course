
@minLength(3)
@maxLength(11)
param location string = 'westeurope'

@description('Shared tags for all resources')
param tags object = {}

@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@description('SKU for storage accounts')
param storageAccountSku string

@description('Name of the app service plan')
param appServicePlanName string

@description('Name of the app service plan SKU')
param appServicePlanSku string

@description('Name of the function app')
param functionAppName string

@description('Name of the application insights')
param applicationInsightsName string

@secure()
@description('Key for our useful API')
param apiKey string

var containerNames = [
  'data'
  'backups'
]

module storageAccount 'modules/storage-account.bicep' = {
  name: 'storage-${storageAccountName}'
  params: {
    location: location
    tags: tags
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
    containerNames: containerNames
    sftpEnabled: true
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Request_Source: 'rest'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: appServicePlanSku
  }
  properties: {}
}

module functionApp 'compute.bicep' = {
  name: 'compute-${functionAppName}'
  params: {
    location: location
    tags: tags
    apiKey: apiKey
    applicationInsightsName: applicationInsights.name
    appServicePlanName: appServicePlan.name
    functionAppName: functionAppName
    storageAccountName: storageAccount.outputs.storageAccountName
  }
}

output functionAppName string = functionApp.outputs.functionAppName
output functionAppId string = functionApp.outputs.functionAppId
