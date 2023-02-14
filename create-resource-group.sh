#!/bin/bash


echo "Enter ResourceGroup Name, you want to create:"
read rgname

echo "Enter the location in which you want to create the ResourceGroup:"
read rglocation

az group list -o table | sed 's/\|/ /'|awk '{print $1}' | awk '/^Name|^-----|^Name/ {next}{for (i=1;i<=NF;i++){print $i}}' > rg-list.txt
az account list-locations -o table | sed 's/\|/ /'|awk '{print $3}' | awk '/^Name|^-----|^Name/ {next}{for (i=1;i<=NF;i++){print $i}}' > locations.txt

echo "====Checking ResourceGroup exists or not====="

        if grep -w -i $rgname rg-list.txt && grep -w -i $rglocation location.txt
        then

        echo "----ResourceGroup already exist----"

        rm rg-list.txt locations.txt

        else
        echo "----Creating ResourceGroup----"

        az group create --name $rgname --location $rglocation

        rm rg-list.txt locations.txt

        fi
