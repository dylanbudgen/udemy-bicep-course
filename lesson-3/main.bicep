
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stbicepcoursedev'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'stauditcoursedev'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}
