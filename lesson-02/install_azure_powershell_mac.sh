# install homebrew here https://brew.sh/

# install the powershell package
brew install --cask powershell

# install the Az module in Powershell terminal
Install-Module -Name Az -Repository PSGallery -Force

# install the bicep package
brew tap azure/bicep
brew install bicep