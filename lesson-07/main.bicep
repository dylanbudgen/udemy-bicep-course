
@description('Location for the resources')
param location string = resourceGroup().location

@minLength(3)
@maxLength(23)
@description('The name of the storage account')
param storageAccountName string

@minLength(3)
@maxLength(24)
@description('The name of the audit storage account')
param auditStorageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string

module storageAccount 'modules/storage-account.bicep' = {
  name: storageAccountName
  params: {
    location: location
    storageAccountName: storageAccountName
    storageAccountSku: storageAccountSku
  }
}

module auditStorageAccount 'modules/storage-account.bicep' = {
  name: auditStorageAccountName
  params: {
    location: location
    storageAccountName: auditStorageAccountName
    storageAccountSku: storageAccountSku
  }
}

output storageAccountName string = storageAccount.outputs.storageAccountName
output storageAccountId string = storageAccount.outputs.storageAccountId

output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
