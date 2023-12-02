#Connet to Azure
Connect-AzAccount

#Create a Resource Group
$resourceGroup = "ThisIsATest"
$location = "Central US"
New-AzResourceGroup -Name $resourceGroup -Location $location

#Use this to find locations
Get-AzLocation | select Location

#get your subscription IDs
Get-AzSubscription 

#list storage accounts
Get-AzStorageAccount

#Deploy a template to an existing resource Group
#If the deployment fails, use the verbose switch to get information about the resources being created. Use the debug switch to get more information for debugging.
$templateFile = "C:\Users\Todes\Josh Job\Azure Resume\azuredeploystorage.json"
New-AzResourceGroupDeployment `
  -Name "AddStorage" `
  -ResourceGroupName "ThisIsATest"`
  -TemplateFile $templateFile `
  -verbose

  $storageAccount = Get-AzStorageAccount -ResourceGroupName "ThisIsATest" -AccountName "johnwaynestorageaccount"
  $ctx = $storageAccount.Context

#enable static website hosting on storage account
Enable-AzStorageStaticWebsite `
-Context $ctx `
-IndexDocument index.html `
-ErrorDocument404Path 404.html 

#upload files to the container
set-AzStorageblobcontent -File "C:\Users\Todes\Josh Job\Azure Resume\testupload.html" `
-Container `$web `
-Blob "index.html" `
-Properties @{ ContentType = "text/html; charset=utf-8";}`
-Context $ctx

#gather the URL of the static website
#$storageAccount = Get-AzStorageAccount -ResourceGroupName "<resource-group-name>" -Name "<storage-account-name>"
Write-Output $storageAccount.PrimaryEndpoints.Web