

@description('Location for the resources')
param location string = '
westeurope'
@minLength(3)
@maxLength(24)
@description('The name of the storage account')
param storageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string = 'Standard_LRS'

@description('The type of storage account')
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'StorageV2'
])
param storageAccountKind string = 'StorageV2'


resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
