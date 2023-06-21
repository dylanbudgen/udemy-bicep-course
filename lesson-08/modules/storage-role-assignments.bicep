
@description('Names of the storage account for role assignments')
param storageAccountNames array

@description('ID of the AD group for role assignment')
param adGroupId string

@description('ID of the RBAC role definition')
param roleAssignmentId string

resource role 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: roleAssignmentId
}

resource storageAccounts 'Microsoft.Storage/storageAccounts@2022-09-01' existing = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
}]

// note - this module should assign one role assignment and the loop be handled in main.bicep
// this was for demostration purposes of indexed loops
resource storageAccountRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' =  [for i in range(0, length((storageAccountNames))): {
  name: guid(storageAccounts[i].name, role.id, adGroupId)
  scope: storageAccounts[i]
  properties: {
    roleDefinitionId: role.id
    principalId: adGroupId
  }
}]
