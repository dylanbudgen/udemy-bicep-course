

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stbicepcoursedev'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stbauditicepcoursedev'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}


