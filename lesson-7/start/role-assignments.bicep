
// Test this module

// TODO how do you validate array values?
@description('Names of the storage account for role assignments')
param storageAccountNames array

@description('Principal ID of the AD group for role assignment')
param adGroupPrincipalId string


resource storageBlobDataReader 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'
}

var storageBlobDataReader2 = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1')

// start without the existing list

resource storageAccounts 'Microsoft.Storage/storageAccounts@2022-09-01' existing = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
}]

// use an object with account name and role mapping? 

// firstly try loop over the array of existing accounts, show them the error


resource storageAccountRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: storageAccountName
  scope: storageAccount
  properties: {
    roleDefinitionId: storageBlobDataReader.id
    principalId: adGroupPrincipalId
  }
}]

