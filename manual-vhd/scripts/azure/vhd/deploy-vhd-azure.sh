rg=<your-resource-group>
location=<region>
sa=<storage>
container=<container-name>
disk=centos-disk
blob=mycustomiso.vhd
vhdurl=https://$sa.blob.core.windows.net/$container/$blob
name=<name-temp-vm>

# verifica se o resource group existe
az group show --name $rg &> /dev/null

echo "[ResourceGroup] Check if exists $rg"
# # no caso de erro
if [ $? -ne 0 ]; then
  # log informacional
  echo "[ResourceGroup] Create $rg"
  # cria o resource group
  az group create --name $rg --location $location
fi


echo "[Storage] Check if exists $sa"
az storage account check-name --name $sa | grep -i \"nameAvailable\":\ true &> /dev/null &> /dev/null

if [ $? -ne 1 ]; then
 echo "[Storage] Create $sa"
  # az create storage
  az storage account create --resource-group $rg --location $location --name $sa --kind Storage --sku Standard_LRS

  # az create storage container
  az storage container create --account-name $sa --name $container
fi

# az generate key
key=$(az storage account keys list --resource-group $rg --account-name $sa --query [0].value)

az storage blob upload --account-name $sa --account-key $key --container-name $container --type page --file $vhd --name $blob

read -p "Create VM Image? Press Enter to Yes or Ctrl+C to ESC"

echo "Create Disk ", $vhdurl
az disk create --resource-group $rg --name $disk --source $vhdurl --sku Standard_LRS

echo "Create temporary VM (after this run $ make-image.sh)"
az vm create --resource-group $rg --location $location --name $name --os-type linux --attach-os-disk $disk