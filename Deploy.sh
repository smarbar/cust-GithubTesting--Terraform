command=op

if ! [ -x "$(command -v op)" ]; then
	command="op.exe"
fi

# Set Subscription IDs
export TF_VAR_MANAGEMENT_SUBSCRIPTION_ID="$(${command} read "op://Personal/TDR Azure/Management Subscription")"
export TF_VAR_IDENTITY_SUBSCRIPTION_ID="$(${command} read "op://Personal/TDR Azure/Identity Subscription")"
export TF_VAR_CONNECTIVITY_SUBSCRIPTION_ID="$(${command} read "op://Personal/TDR Azure/Connectivity Subscription")"
export TF_VAR_PLATFORM1_SUBSCRIPTION_ID="$(${command} read "op://Personal/TDR Azure/Platform1 Subscription")"
# export TF_VAR_PLATFORM2_SUBSCRIPTION_ID="$(${command} read "op://Personal/TDR Azure/Platform2 Subscription")"
# export TF_VAR_APP1_SUBSCRIPTION_ID="$(${command} read "op://Personal/TDR Azure/App1 Subscription")"
# export TF_VAR_APP2_SUBSCRIPTION_ID="$(${command} read "op://Personal/TDR Azure/App2 Subscription")"

# Set Application Context
#export TF_VAR_{terraform var name}="{value}"
export TF_VAR_application_name="observability"
export TF_VAR_environment_name="dev"

# Set the backend
export BACKEND_RESOURCE_GROUP="tfstate"
export BACKEND_STORAGE_ACCOUNT="tfstate-storage-account"
export BACKEND_CONTAINER="tfstate"
export BACKEND_KEY=$TF_VAR_application_name-$TF_VAR_environment_name

# run terraform and set backend state config
terraform init \
	-backend-config="resource_group_name=${BACKEND_RESOURCE_GROUP}" \
  -backend-config="storage_account_name=${BACKEND_STORAGE_ACCOUNT}" \
  -backend-config="container_name=${BACKEND_CONTAINER}" \
  -backend-config="key=${BACKEND_KEY}"
  
terraform $* # will take all argument as part of the script run command

# Cleanup the local folder as now using remote state
rm -rf .terraform
