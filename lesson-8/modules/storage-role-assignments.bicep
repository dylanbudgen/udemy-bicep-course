
// Test this module

// TODO make this a module for RBAC and give the role ID into it

@description('Names of the storage account for role assignments')
param storageAccountNames array

@description('ID of the AD group for role assignment')
param adGroupId string

@description('ID of the RBAC role definition')
param roleAssignmentId string

resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleAssignmentId
}

// var storageBlobDataReader2 = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1')

resource storageAccounts 'Microsoft.Storage/storageAccounts@2022-09-01' existing = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
}]

// use an object with account name and role mapping? 

// firstly try loop over the array of existing accounts, show them the error

// resource storageAccountRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' =  [for storageAccount in storageAccounts: {
//   name: storageAccount.name
//   scope: storageAccount
//   properties: {
//     roleDefinitionId: storageBlobDataReader.id
//     principalId: adGroupPrincipalId
//   }
// }]

resource storageAccountRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' =  [for i in range(0, length((storageAccountNames))): {
  name: guid(storageAccounts[i].name, role.id, adGroupId)
  scope: storageAccounts[i]
  properties: {
    roleDefinitionId: role.id
    principalId: adGroupId
  }
}]

// keyvault secrets?

