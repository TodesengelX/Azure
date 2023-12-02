#get your subscription IDs
Get-AzSubscription 

#list storage accounts
Get-AzStorageAccount


#Deploy a template to an existing resource Group. The Template defines the parameters of the storage account
#If the deployment fails, use the verbose switch to get information about the resources being created. Use the debug switch to get more information for debugging.
$templateFile = "C:\Users\Todes\Josh Job\Azure Resume\Azure Storage Scripts\azuredeploystorage.json"
New-AzResourceGroupDeployment `
  -Name "AddStorage" `
  -ResourceGroupName "ThisIsATest"`
  -TemplateFile $templateFile `
  -verbose

  #set variables for the storage account
  $storageAccount = Get-AzStorageAccount -ResourceGroupName "ThisIsATest" -AccountName "johnwaynestorageaccount"
  $ctx = $storageAccount.Context


  #enable static website hosting on storage account
Enable-AzStorageStaticWebsite `
-Context $ctx `
-IndexDocument index.html `     #the index.html is whatever document you want
-ErrorDocument404Path 404.html  #whatever error page you want, change the 404.html


#upload files to the container
set-AzStorageblobcontent -File "C:\Users\Todes\Josh Job\Azure Resume\testupload.html" `
-Container `$web `
-Blob "index.html" `
-Properties @{ ContentType = "text/html; charset=utf-8";}`
-Context $ctx

#gather the URL of the static website
#$storageAccount = Get-AzStorageAccount -ResourceGroupName "<resource-group-name>" -Name "<storage-account-name>"
Write-Output $storageAccount.PrimaryEndpoints.Web