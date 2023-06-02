

@description('Name of the storage account for role assignments')
param storageAccountName string


resource adGroupPrincipalId string


var 

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: storageAccountName
}


resource storageAccountRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' =  [for item in list: {
  name: storageAccountName
  scope: ''
  properties: {
    roleDefinitionId: ''
    principalId: ''
  }
}]


// keyvault secrets?

