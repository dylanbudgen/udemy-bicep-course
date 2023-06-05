@description('Location for the resources')
param location string = 'westeurope'

param storageAccountConfig object


resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountConfig.name
  location: location
  sku: {
    name: storageAccountConfig.sku
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}


output storageAccountName string = storageAccount.name // storageAccount.name // explain how thats the deployment name
output storageAccountId string = storageAccount.id
