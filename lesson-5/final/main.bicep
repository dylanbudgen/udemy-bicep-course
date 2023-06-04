

@description('Location for the resources')
param location string = 'westeurope'

@minLength(3)
@maxLength(24)
@description('The name of the storage account')
param storageAccountName string

@description('Name of the SKU')
@allowed([
  'Standard_GRS'
  'Standard_LRS'
])
param storageAccountSku string

@description('Restrict storage account to only HTTPS traffic')
param supportsHttpsTrafficOnly bool = true

var storageAccountProperties = {
  minimumTlsVersion: 'TLS1_2'
  supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSku
  }
  kind: 'StorageV2'
  properties: storageAccountProperties
}


// resource group
var resourceGroupId = resourceGroup().id
var resourceGroupName = resourceGroup().name

// resource specific 
var storageAccountKey = storageAccount.listKeys().keys[0]
var dd = storageAccount.identity.principalId

// guid generation
var hashedGuid = guid(resourceGroup().id, storageAccountName)

// array functions
var array = [
  'value1'
  'value2'
]

var generatedArray = sys.array(resourceGroupId)

var joinedArray = concat(array, generatedArray)
var joinedArray2 = union(array, generatedArray) // duplicates ignored

var firstElement = first(array)
var lastElement = last(array)


var arrayContains = contains(array, 'value1')
var indexOf = contains(array, 'value1') //-1 if not found
var arrayLength = length(array)

var isArrayEmpty = empty(array)



// resource functions

// data types
var boolean = bool('true')
var integer = int('200')
var stringg = string(2)

// string functions
var joinedString = join(array, '-')
var splitString = split(joinedString, '-')
var lowerCase = toLower('HELLO')
var upperCase = toUpper('hello')
var trimmed = trim(' hello ')
var substr = substring(trimmed, 0, 2)

param greeting string = 'Hello'
param name string = 'User'
param numberToFormat int = 8175133

output formatTest string = format('{0}, {1}. Formatted number: {2:N0}', greeting, name, numberToFormat)

// numeric functions
var numArray = [
  58
  521
  3
]

var minimum = min(numArray)
var maximum = max(numArray)

// conditionals



var randomGuid2 = guid('stor')


// advanced?? 
// files

// json??


// lambda functions

// date functions
