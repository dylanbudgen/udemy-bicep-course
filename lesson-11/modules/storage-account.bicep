

@description('Location for the resources')
param location string 

@description('Tags for all resources')
param tags object = {}

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
  'StorageV2'
])
param storageAccountKind string = 'StorageV2'

@description('Set storage account SFTP enabled')
param isSftpEnabled bool = false

@description('The names of containers for creation')
param containerNames array = []


resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: storageAccountSku
  }
  kind: storageAccountKind
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    isSftpEnabled: isSftpEnabled
    isHnsEnabled: isSftpEnabled ? true : false
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-02-01' = if(!empty(containerNames)) {
  name: 'default'
  parent: storageAccount
}

resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [ for containerName in containerNames : {
  name: containerName
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}]

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
