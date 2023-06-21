
var storageAccountName = 'stbicepcoursedev'

// scope functions

var resourceGroupId = resourceGroup().id
var resourceGroupName = resourceGroup().name
var subscriptionName = subscription().displayName

// resource functions

var storageAccountId = resourceId('Microsoft.Storage/storageAccounts@2022-09-01', storageAccountName)

var storageAccount = reference('Microsoft.Storage/storageAccounts@2022-09-01', storageAccountName)
var storageAccountKey = storageAccount.listKeys().keys[0]
var storageAccountPrincipalId = storageAccount.identity.principalId

var resource = reference('Microsoft.KeyVault', 'kvbicepcoursedev')
var secret = resource.getSecret('secretname')

// guid functions

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

// data types conversions

var boolean = bool('true')
var integer = int('200')
var stringg = string(2)

// string functions

var myFirstString = 'mystring${storageAccountName}'
var joinedString = join(array, '-')
var splitString = split(joinedString, '-')
var lowerCase = toLower('HELLO')
var upperCase = toUpper('hello')
var trimmed = trim(' hello ')
var substr = substring(trimmed, 0, 2)

// numeric functions

var numArray = [
  58
  521
  3
]

var minimum = min(numArray)
var maximum = max(numArray)

// loading json files

var nsgconfig = loadJsonContent('nsg-security-rules.json')

resource newNSG 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: 'example-nsg'
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: nsgconfig
      }
    ]
  }
}

// loading yaml files

var yml = loadYamlContent('example.yml')

// loading text file functions

var text = loadTextContent('nsg-security-rules.json')

// loading files as base64

var base64 = loadFileAsBase64('nsg-security-rules.json')

// date functions

param dateTime string = utcNow('u')
var addNineDays = dateTimeAdd(dateTime, '+P9D')

param convertedEpoch int = dateTimeToEpoch(dateTimeAdd(utcNow(), 'P1Y'))
var convertedDatetime = dateTimeFromEpoch(convertedEpoch)

// lambda functions

var storageAccounts = loadJsonContent('example.json').storageAccounts

output filteredStorageAccounts array = filter(storageAccounts, storageAccount => storageAccount.sku == 'Standard_GRS')

output storageAccountNames array = map(storageAccounts, storageAccount => storageAccount.name)

output storageAccountObject object = toObject(storageAccounts, storageAccount => storageAccount.name, storageAccount => storageAccount)
