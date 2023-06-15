az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --template-file main.bicep

az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --mode Complete \
    --template-file main.bicep