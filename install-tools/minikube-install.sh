#download minikube 
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

#install minikube
sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

#Start your cluster
minikube start —-force
