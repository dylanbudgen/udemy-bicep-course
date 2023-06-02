

@description('Location for the resources')
param location string = 'westeurope'

// todo add max min
@description('The name of the storage account')
param storageAccountName string

@description('The name of the audit storage account')
param auditStorageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string

// explain how the name here is different
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


output storageAccountName string = storageAccount.outputs.storageAccountName // storageAccount.name // explain how thats the deployment name
output storageAccountId string = storageAccount.outputs.storageAccountId

output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName // storageAccount.name // explain how thats the deployment name
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId


