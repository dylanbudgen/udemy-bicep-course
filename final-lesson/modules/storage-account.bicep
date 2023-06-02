
@description('Location for the resources')
param location string = resourceGroup().name

@description('Tags that our resources need')
param tags object

@description('The naming standard compliant name of the storage account')
param storageAccountName string

@description('SKU name')
@allowed([
  'Premium_LRS'
  'Premium_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_LRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Standard_ZRS'
])
param storageAccountSku string

@description('The type of storage account')
@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'StorageV2'
])
param kind string = 'StorageV2'

@description('Array containing the names of containers to create')
param containerNames array = []

@description('Array containing the names of tables to create')
param tableNames array = []

@description('Identity for the resource. https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?tabs=bicep#identity')
param identity object = {
  type: 'None'
}

@description('Required for storage accounts where kind = BlobStorage. The access tier used for billing.')
@allowed([
  'Cool'
  'Hot'
])
param accessTier string = 'Hot'

@description('Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD). The default value is null, which is equivalent to true.')
param allowSharedKeyAccess bool = true

@description('Enable SFTP access')
param sftpEnabled bool = false

@description('Network rule set. https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts?tabs=bicep#networkruleset')
param networkAcls object = {
  bypass: 'AzureServices'
  defaultAction: 'Allow'
}

@description('The properties of a storage accounts Blob service. https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts/blobservices?tabs=bicep#blobservicepropertiesproperties')
param blobServicesProperties object = {}

@description('The properties of a storage accounts table service.')
param tableServicesProperties object = {}


// storage account

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: storageAccountSku
  }
  kind: kind
  identity: identity
  properties: {
    accessTier:  accessTier
    allowBlobPublicAccess: false
    allowSharedKeyAccess: allowSharedKeyAccess
    networkAcls: networkAcls
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    isHnsEnabled: true
    isSftpEnabled: sftpEnabled
  }
}

// services

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2021-02-01' = {
  name: '${storageAccount.name}/default'
  properties: blobServicesProperties
}

resource tableServices 'Microsoft.Storage/storageAccounts/tableServices@2022-09-01' = {
  name: '${storageAccount.name}/default'
  properties: tableServicesProperties
}

// diagnostic settings



// containers
resource containers 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = [ for containerName in containerNames : {
  name: containerName
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}]

// tables
resource tables 'Microsoft.Storage/storageAccounts/tableServices/tables@2022-09-01' = [ for tableName in tableNames : {
  name: '${storageAccount.name}/default/${tableName}'
}]

output storageAccountName string = storageAccount.name
output storageAccountResourceId string = storageAccount.id
output storageAccountBlobEndpoint string = storageAccount.properties.primaryEndpoints.blob
output storageAccountTableEndpoint string = storageAccount.properties.primaryEndpoints.table
