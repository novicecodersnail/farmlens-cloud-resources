param resouceGroupLocation string = 'westus2'
param resourceGroupName string = 'farmlensresourcegroup'
targetScope = 'subscription'


// Create a Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2018-05-01' = {
  name: resourceGroupName
  location: resouceGroupLocation
}

module resources 'appPlan.bicep' ={
  name: 'resourcesModule'
  scope: resourceGroup
  params:{
    areazone: resouceGroupLocation
  }
}
