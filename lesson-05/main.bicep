
@description('Location for the resources')
param location string = resourceGroup().location

@minLength(3)
@maxLength(24)
@description('The name of the storage account')
param storageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string

@description('Restrict storage account to only HTTPS traffic')
param supportsHttpsTrafficOnly bool = true

var storageAccountKind = 'StorageV2'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
  }
}

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
