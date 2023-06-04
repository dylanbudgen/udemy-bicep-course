
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

var storageAccountKind = 'StorageV2'

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
  kind: storageAccountKind
  properties: storageAccountProperties
}

// resource group
var resourceGroupId = resourceGroup().id
var resourceGroupName = resourceGroup().name

// resource specific 
var storageAccountKey = storageAccount.listKeys().keys[0]
var storageAccountPrincipalId = storageAccount.identity.principalId

// guid generation
var hashedGuid = guid(resourceGroup().id, storageAccountName)

// array functions
var stringArray = [
  'value1'
  'value2'
]

var generatedArray = sys.array(resourceGroupId)

var joinedArray = concat(stringArray, generatedArray)
var joinedArray2 = union(stringArray, generatedArray) // duplicates ignored

var firstElement = first(stringArray)
var lastElement = last(stringArray)

var arrayContains = contains(stringArray, 'value1')
var indexOf = contains(stringArray, 'value1') //-1 if not found
var arrayLength = length(stringArray)
var isArrayEmpty = empty(stringArray)
// resource functions

// data types
var boolean = bool('true')
var integer = int('200')
var stringg = string(2)

// string functions
var joinedString = join(stringArray, '-')
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

// advanced?? 
// files

loadFileAsBase64(filePath)

loadJsonContent
// json??
param location string = resourceGroup().location

var nsgconfig = loadJsonContent('nsg-security-rules.json')

resource newNSG 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'example-nsg'
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: nsgconfig
      }
    ]
  }
}

resource exampleScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'exampleScript'
  location: resourceGroup().location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '/subscriptions/{sub-id}/resourcegroups/{rg-name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{id-name}': {}
    }
  }
  properties: {
    azPowerShellVersion: '8.3'
    scriptContent: loadTextContent('myscript.ps1')
    retentionInterval: 'P1D'
  }
}

// lambda functions

var dogs = [
  {
    name: 'Evie'
    age: 5
    interests: ['Ball', 'Frisbee']
  }
  {
    name: 'Casper'
    age: 3
    interests: ['Other dogs']
  }
  {
    name: 'Indy'
    age: 2
    interests: ['Butter']
  }
  {
    name: 'Kira'
    age: 8
    interests: ['Rubs']
  }
]

output oldDogs array = filter(dogs, dog => dog.age >=5)
var itemForLoop = [for item in range(0, 10): item]

output filteredLoop array = filter(itemForLoop, i => i > 5)
output isEven array = filter(range(0, 10), i => 0 == i % 2)

var dogs = [
  {
    name: 'Evie'
    age: 5
    interests: ['Ball', 'Frisbee']
  }
  {
    name: 'Casper'
    age: 3
    interests: ['Other dogs']
  }
  {
    name: 'Indy'
    age: 2
    interests: ['Butter']
  }
  {
    name: 'Kira'
    age: 8
    interests: ['Rubs']
  }
]

output dogNames array = map(dogs, dog => dog.name)
output sayHi array = map(dogs, dog => 'Hello ${dog.name}!')
output mapObject array = map(range(0, length(dogs)), i => {
  i: i
  dog: dogs[i].name
  greeting: 'Ahoy, ${dogs[i].name}!'
})

var dogs = [
  {
    name: 'Evie'
    age: 5
    interests: [ 'Ball', 'Frisbee' ]
  }
  {
    name: 'Casper'
    age: 3
    interests: [ 'Other dogs' ]
  }
  {
    name: 'Indy'
    age: 2
    interests: [ 'Butter' ]
  }
  {
    name: 'Kira'
    age: 8
    interests: [ 'Rubs' ]
  }
]

output dogsObject object = toObject(dogs, entry => entry.name)


// date functions
param baseTime string = utcNow('u')

var add3Years = dateTimeAdd(baseTime, 'P3Y')
var subtract9Days = dateTimeAdd(baseTime, '-P9D')
var add1Hour = dateTimeAdd(baseTime, 'PT1H')

output add3YearsOutput string = add3Years
output subtract9DaysOutput string = subtract9Days
output add1HourOutput string = add1Hour

// epoch time
param convertedEpoch int = dateTimeToEpoch(dateTimeAdd(utcNow(), 'P1Y'))

var convertedDatetime = dateTimeFromEpoch(convertedEpoch)

output epochValue int = convertedEpoch
output datetimeValue string = convertedDatetime
