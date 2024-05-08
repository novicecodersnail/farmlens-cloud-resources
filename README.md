# Azure Resources Deployment with Bicep

This project automates the deployment of an Azure Storage Account, Blob Service, Blob Container, and an Azure Function using Bicep templates. The setup is ideal for managing Azure resources efficiently and securely.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli): Ensure Azure CLI is installed to deploy Bicep templates.
- An active Azure subscription.

## Architecture

The deployment includes:
- **Azure Resource Group**: A group to organize all resources.
- **Azure Storage Account**: Used for general storage purposes.
- **Blob Service**: Manages blob storage within the Storage Account.
- **Blob Container**: Stores blobs within the Blob Service.
- **Azure Function**: A serverless function to interact with the stored data.

## Parameters

- `storageAccName`: The name for the storage account (3-24 characters, lower case letters and numbers only).
- `containerName`: The name of the blob container (3-24 characters).
- `functionName`: The name for the Azure Function (3-24 characters).
- `areazone`: The Azure region for deploying resources (`westus2`).
- `resourceGroupName`: The name for the Resource Group.
- `resourceGroupLocation`: The location for the Resource Group (`westus2`).

## Deployment Steps

### 1. Login to Azure CLI

Log in to your Azure account via the Azure CLI:
az login

Deploy Bicep Template
Navigate to the directory containing your Bicep file. Begin by creating the Resource Group if it does not already exist:
az group create --name <resourceGroupName> --location <resourceGroupLocation>

Run the following command to start the deployment:
az deployment group create --resource-group <resourceGroupName> --template-file main.bicep --parameters storageAccName='farmlensstorageacc' containerName='farmlensimages' functionName='farmlensfunction' areazone='westus2'


