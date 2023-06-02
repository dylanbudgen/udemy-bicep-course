az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --template-file main.bicep \
    --parameters @params.json

az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --template-file main.bicep \
    --parameters storageAccountName='stbicepcoursedev' storageAccountSku='Standard_LRS'