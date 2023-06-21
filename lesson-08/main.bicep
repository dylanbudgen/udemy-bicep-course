@description('Location for the resources')
param location string = resourceGroup().location

@minLength(3)
@maxLength(24)
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

@description('ID of the AD group for role assignment')
param adGroupId string

@description('Deploy the audit storage account')
param deployAuditStorageAccount bool = true

@description('Deploy the audit storage account containers')
param deployAuditStorageContainers bool = true


var storageBlobDataReaderId = '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'

var auditStorageContainers = [
  'audit'
  'logs'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

module auditStorageAccount 'modules/storage-account.bicep' = if (deployAuditStorageAccount) {
  name: auditStorageAccountName
  params: {
    location: location
    storageAccountName: auditStorageAccountName
    storageAccountSku: storageAccountSku
    containerNames: deployAuditStorageContainers ? auditStorageContainers : []
  }
}

var storageAccountNames = deployAuditStorageAccount ? [
  storageAccount.name
  auditStorageAccount.outputs.storageAccountName
] : [
  storageAccount.name
]

module roleAssignments 'modules/storage-role-assignments.bicep' = {
  name: 'storage-role-assignments'
  params: {
    adGroupId: adGroupId
    roleAssignmentId: storageBlobDataReaderId
    storageAccountNames: storageAccountNames
  }
}

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id

output auditStorageAccountName string = auditStorageAccount.outputs.storageAccountName
output auditStorageAccountId string = auditStorageAccount.outputs.storageAccountId
