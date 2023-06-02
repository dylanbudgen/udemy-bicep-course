New-AzResourceGroupDeployment
   -Name deployment
   -ResourceGroupName bicep-course
   [-Mode <DeploymentMode>]
   [-DeploymentDebugLogLevel <String>]
   [-RollbackToLastDeployment]
   [-RollBackDeploymentName <String>]
   [-Tag <Hashtable>]
   [-WhatIfResultFormat <WhatIfResultFormat>]
   [-WhatIfExcludeChangeType <String[]>]
   [-Force]
   [-ProceedIfNoChange]
   [-AsJob]
   [-QueryString <String>]
   -TemplateFile <String>
   [-SkipTemplateParameterPrompt]
   [-Pre]
   [-DefaultProfile <IAzureContextContainer>]
   [-WhatIf]
   [-Confirm]
   [<CommonParameters>]


   az deployment group create \
    --subscription udemy-courses \
    --resource-group bicep-course \
    --name deployment \
    --template-file main.bicep \