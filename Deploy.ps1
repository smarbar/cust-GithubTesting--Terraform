# Set Subscription
$env:TF_VAR_MANAGEMENT_SUBSCRIPTION_ID=$(op read "op://Personal/TDR Azure/Management Subscription")
$env:TF_VAR_IDENTITY_SUBSCRIPTION_ID=$(op read "op://Personal/TDR Azure/Identity Subscription")
$env:TF_VAR_CONNECTIVITY_SUBSCRIPTION_ID=$(op read "op://Personal/TDR Azure/Connectivity Subscription")
$env:TF_VAR_PLATFORM1_SUBSCRIPTION_ID=$(op read "op://Personal/TDR Azure/Platform1 Subscription")
# $env:TF_VAR_PLATFORM2_SUBSCRIPTION_ID=$(op read "op://Personal/TDR Azure/Platform2 Subscription")
# $env:TF_VAR_APP1_SUBSCRIPTION_ID=$(op read "op://Personal/TDR Azure/App1 Subscription")
# $env:TF_VAR_APP2_SUBSCRIPTION_ID=$(op read "op://Personal/TDR Azure/App2 Subscription")


# Set Application Context
#export TF_VAR_{terraform var name}="{value}"
$env:TF_VAR_application_name="observability"
$env:TF_VAR_environment_name="dev"

# Set the backend
$env:BACKEND_RESOURCE_GROUP="tfstate"
$env:BACKEND_STORAGE_ACCOUNT="tfstate-storage-account"
$env:BACKEND_CONTAINER="tfstate"
$env:BACKEND_KEY="$env:TF_VAR_application_name-$env:TF_VAR_environment_name"

# # run terraform and set backend state config
# terraform init \
# 	-backend-config="resource_group_name=$env:BACKEND_RESOURCE_GROUP" \
#   -backend-config="storage_account_name=$env:BACKEND_STORAGE_ACCOUNT" \
#   -backend-config="container_name=$env:BACKEND_CONTAINER" \
#   -backend-config="key=$env:BACKEND_KEY"
  
# terraform $* # will take all argument as part of the script run command

# # Cleanup the local folder as now using remote state
# rm -rf .terraform
