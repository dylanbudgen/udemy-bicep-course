

@description('Location for the resources')
param location string = 'westeurope'

@description('The name of the storage account')
param storageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string

var stringExample = 'string-example'

var anotherStringExample = 'another-${stringExample}'

var array = [
  'value1'
  'value2'
]

var mixedArray = [
  'value1'
  2
]

var storageAccountConfig = {
  sku: 'Standar***'
  kind: 
}

var object = {
  name: 'Dylan'
  number: 07812312312
  postcode: 'SE00000'
}

var nestedObject = {
  value: {
    value: 1
  }
  value2: [
    'value'
  ]
}



output arrayValue string = array[0]




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

output storageAccountName string = storageAccount.name
output storageAccountId string = storageAccount.id
