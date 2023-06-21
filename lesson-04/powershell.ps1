# powershell

# create resource group
New-AzResourceGroup -Location westeurope -Name bicep-course

# deploy bicep template
New-AzResourceGroupDeployment `
  -Name deployment `
  -SubscriptionName udemy-courses `
  -ResourceGroupName bicep-course `
  -TemplateFile main.bicep