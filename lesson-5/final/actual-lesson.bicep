

@description('Location of the resources')
param location string = 'westeurope'

@minLength(3)
@maxLength(24)
@description('Name of the storage account')
param storageAccountName string

@minLength(3)
@maxLength(24)
@description('Name of the audit storage account')
param auditStorageAccountName string

@allowed([
  'Standard_LRS'
  'Standard_GRS'
])
@description('Name of the storage account sku')
param storageAccountSku string


// string
var myFirstString = 'mystring${storageAccountName}'
var lowerCase = toLower(myFirstString)
var upperCase = toUpper(myFirstString)
var trimmed = trim(' spaces ')
var sub = substring(trimmed, 0, 2)


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

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: auditStorageAccountName
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

output storageAccountName string = storageAccount.name
output auditStorageAccountName string = storageAccount.name

output storageAccountId string = storageAccount.id
output auditStorageAccountId string = auditStorageAccount.id
