




resource adGroupPrincipalId string


var 




resource storageAccount 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: name: guid(subscription().id, principalId, roleDefinitionResourceId)
  properties: {
    principalId: 
    roleDefinitionId: 
  }
}


// keyvault

