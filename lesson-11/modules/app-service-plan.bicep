
@description('Location for the resources')
param location string

@description('Tags for all resources')
param tags object = {}

@description('The name of the app service plan resource')
param appServicePlanName string

@allowed([
  'S1'
  'B1'
])
param appServicePlanSku string = 'B1'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: appServicePlanName
  location: location
  tags: tags
  sku: {
    name: appServicePlanSku
  }
}

output appServicePlanName string = appServicePlan.name
output appServicePlanId string = appServicePlan.id
