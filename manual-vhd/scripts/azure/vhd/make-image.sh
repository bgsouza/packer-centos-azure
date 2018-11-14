rg=<your-resource-group>
name=<name-temp-vm>
imagevm=mycustomiso-vm
imagevmname=mycustomisofinal-image

echo "Deallocate $name"
az vm deallocate -g $rg -n $name # az vm deallocate -g --resource-group -n --name

echo "Generalize $name"
az vm generalize -g $rg -n $name

echo "Image create $imagevmname from $name"
az image create -g $rg -n $imagevmname --source $name
