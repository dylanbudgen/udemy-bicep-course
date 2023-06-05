
@description('Location for the resources')
param location string = 'westeurope'


// loading json files
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

// loading yaml files
var yml = loadYamlContent('example.yml')

// loading text files
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
