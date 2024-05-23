#tag the resources as below for all the 
kubernetes.io/cluster/<cluster-name>:shared
kubernetes.io/role/elb:1

# install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

#install aws cli from below location. kubectl requires min 2.x cli version
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
sudo yum remove awscli
aws --version
aws-cli/2.15.30 Python/3.11.6 Linux/5.10.205-195.807.amzn2.x86_64 botocore/2.4.5

# install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.3/2024-04-19/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
kubectl version --client

# deploy the cluster using the yaml file
eksctl create cluster -f eks-cluster.yaml

aws eks update-kubeconfig --region us-east-1 --name eks-cluster

# on Amazon Linux2 install helm as follows
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version

# to cleanup resources, run 
eksctl delete cluster --region=us-east-1 --name=eks-cluster



