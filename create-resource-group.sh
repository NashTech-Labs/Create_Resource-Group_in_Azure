#!/bin/bash


echo "Enter ResourceGroup Name, you want to create:"
read rgname

echo "Enter the location in which you want to create the ResourceGroup:"
read rglocation

az group list -o table | sed 's/\|/ /'|awk '{print $1}' | awk '/^Name|^-----|^Name/ {next}{for (i=1;i<=NF;i++){print $i}}' > rg-list.txt
az account list-locations --query [].[name] -o table | awk '/^Column1|^-----|^Column1/ {next}{for (i=1;i<=NF;i++){print $i}}' > locations.txt
echo "====Checking ResourceGroup exists or not====="

        if grep -w -i $rgname rg-list.txt 
        then
        az group show --resource-group $rgname -otable | sed 's/\|/ /'|awk '{print $1}' | awk '/^Location|^-----|^Location/ {next}{for (i=1;i<=NF;i++){print $i}}' > match-location.txt

           if  grep -w -i $rglocation match-location.txt
            then

                echo "----ResourceGroup already exist----"
               rm rg-list.txt match-location.txt locations.txt
            else

                echo "----Creating ResourceGroup with the location----"

              az group create --name $rgname --location $rglocation

              rm rg-list.txt match-location.txt locations.txt

            fi

        else
        echo "----Creating ResourceGroup RG----"

       az group create --name $rgname --location $rglocation

       rm rg-list.txt match-location.txt locations.txt

        fi
