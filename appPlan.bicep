@minLength(3)
@maxLength(24)
@description('Provide a name for the storage account. Use only lower case letters and numbers. The name must be unique across Azure.')
param storageAccName string = 'farmlensstorageacc'
@minLength(3)
@maxLength(24)
param containerName string = 'farmlensimages'
@minLength(3)
@maxLength(24)
param functionName string = 'farmlensfunction'
param areazone string = 'westus2'

// create azure storage account
resource appStorageAccount 'Microsoft.Storage/storageAccounts@2023-01-01'={
  name:storageAccName
  location: areazone

  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

// create blob service within storage account 
resource appBlobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01'={
  parent: appStorageAccount
  name: 'default'
}

// create blob container within blob service 
resource appBlobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01'={
  parent: appBlobService
  name: containerName
}

// create Azure Function 
resource appFunction 'Microsoft.Web/sites@2023-01-01'={
  
  name: functionName
  location: areazone
  kind: 'functionapp,linux'
  properties: {
    reserved: true
    siteConfig:{
      linuxFxVersion: 'python|3.10'
      appSettings: [
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storageAccName};EndpointSuffix=${environment().suffixes.storage};AccountKey=${appStorageAccount.listKeys().keys[0].value}'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~4'
        }
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'python'
        }
        {
          name: 'ROBOFLOW_API_KEY'
          value: 'B6ywICqHhzae76aUU5IK'
        }
        {
          name: 'ROBOFLOW_API_URL'
          value: 'http://detect.roboflow.com'
        }
        {
          name:'AUTH_VALUES'
          value:'CSUMBFarmlens2024'
        }
        {
          name: 'ROBOFLOW_WORKSPACE'
          value: 'strawberry-object-detection'
        }
        {
          name: 'ROBOFLOW_MODEL_VERSION'
          value: '14'
        }
        {
          name: 'AzureWebJobsFeatureFlags'
          value: 'EnableWorkerIndexing'
        }
      ]
    }
    httpsOnly: true
  }
}





