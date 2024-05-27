#!/bin/bash

#download helm install script
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3

#modify permissions and execute script
chmod 700 get_helm.sh
./get_helm.sh

#check helm version
echo "helm installed successfully"
helm version
