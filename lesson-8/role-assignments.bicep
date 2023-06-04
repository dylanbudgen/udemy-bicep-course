
@minLength(3)
@maxLength(24)
@description('Name of the storage account for role assignment')
param storageAccountName string

@description('ID of the AD group for role assignment')
param adGroupId string


resource storageBlobDataReader 'Microsoft.Authorization/roleDefinitions@2022-04-01' existing = {
  name: '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  name: storageAccountName
}

resource storageAccountRoleAssignments 'Microsoft.Authorization/roleAssignments@2022-04-01' =  {
  name: guid(storageAccount.name, storageBlobDataReader.id, adGroupId)
  scope: storageAccount
  properties: {
    roleDefinitionId: storageBlobDataReader.id
    principalId: adGroupId
  }
}
