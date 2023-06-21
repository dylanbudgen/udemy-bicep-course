# azure cli

# create resource group
az group create --location westeurope --name bicep-course

# deploy bicep template
az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --mode Complete \
    --template-file main.bicep