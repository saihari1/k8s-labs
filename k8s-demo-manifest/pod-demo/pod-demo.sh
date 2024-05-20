kubectl run firstpod –image=nginx

kubectl get po
kubectl get pod firstpod -o yaml

kubectl describe pod firstpod

kubectl exec -it firstpod – /bin/bash

kubectl create -f firstpod.yaml –dry-run=client

Kubectl create -f firstpod.yaml 

Kubectl get po
Kubectl describe po
Kubectl exec -it firstpod –container db – /bin/bash
Kubectl exec -it firstpod –container web – /bin/bash
Kubectl delete -f firstpod.yaml
