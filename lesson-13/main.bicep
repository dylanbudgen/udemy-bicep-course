@description('Location for the resources')
param location string = resourceGroup().location

type storageAccountSkuType = 'Standard_LRS' | 'Standard_GRS'

type storageAccountConfigType = {
  @minLength(3)
  @maxLength(24)
  name: string
  sku: storageAccountSkuType
}

param storageAccountConfig storageAccountConfigType


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


output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
