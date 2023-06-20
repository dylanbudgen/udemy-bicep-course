
# incremental mode
az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --mode Incremental \
    --template-file main.bicep

# complete mode
az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --mode Complete \
    --template-file main.bicep