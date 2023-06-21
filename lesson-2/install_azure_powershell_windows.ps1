
# install powershell 7 
winget install --id Microsoft.Powershell --source winget

# set the powerShell execution policy to remote signed or less restrictive 
Get-ExecutionPolicy -List
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# install the Az module in Powershell terminal
Install-Module -Name Az -Repository PSGallery -Force

# install the bicep package
winget install -e --id Microsoft.Bicep