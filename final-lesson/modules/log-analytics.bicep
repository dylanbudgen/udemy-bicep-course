
param tags object

@description('Name of the log analytics workspace')
param logAnalyticsWorkspaceName string

@description('Number of days to retain data.')
param retentionInDays int = 30

@allowed([
  'Enabled'
  'Disabled'
])
@description('The network access type for accessing Log Analytics ingestion')
param publicNetworkAccessForIngestion string = 'Enabled'

@allowed([
  'Enabled'
  'Disabled'
])
@description('The network access type for accessing Log Analytics query')
param publicNetworkAccessForQuery string = 'Enabled'

@description('Location for the resources')
param location string

@description('Log analytics SKU')
@allowed([
  'Free'
  'LACluster'
  'PerGB2018'
  'PerNode'
  'Premium'
  'Standalone'
  'Standard'
])
param sku string = 'PerGB2018'

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  tags: tags
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
    publicNetworkAccessForIngestion: publicNetworkAccessForIngestion
    publicNetworkAccessForQuery: publicNetworkAccessForQuery
  }
}

output logAnalyticsWorkspaceName string = logAnalyticsWorkspace.name
output logAnalyticsWorkspaceResourceId string = logAnalyticsWorkspace.id
