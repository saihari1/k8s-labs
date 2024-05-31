#!/bin/bash
# Install required packages
sudo apt update -y
sudo apt install -y unzip curl jq
# Download and install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
# Verify AWS CLI installation
aws --version
# Tag the public subnets for EKS
aws ec2 create-tags --resources subnet-0b532be25057083a5 --tags Key=kubernetes.io/cluster/B2B,Value=shared
aws ec2 create-tags --resources subnet-05826c870daa8606a --tags Key=kubernetes.io/role/elb,Value=1
# Make sure auto-assign IP settings is enabled in the AWS Console for your subnets
# Install eksctl
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version
# Install kubectl
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.3/2024-04-19/bin/linux/amd64/kubectl
chmod +x ./kubectl
mkdir -p $HOME/bin && cp ./kubectl $HOME/bin/kubectl && export PATH=$HOME/bin:$PATH
echo 'export PATH=$HOME/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
kubectl version --client
# Ensure AWS credentials and region are set correctly
aws configure
export AWS_REGION=ap-southeast-2
# Verify AWS Configuration
aws configure list
aws sts get-caller-identity
# Check VPC and Subnets
aws ec2 describe-vpcs --vpc-ids vpc-0625296b14616a368
aws ec2 describe-subnets --subnet-ids subnet-0b532be25057083a5
aws ec2 describe-subnets --subnet-ids subnet-05826c870daa8606a
# Deploy the cluster using the yaml file
eksctl create cluster -f B2B.yaml --verbose 4
# Update kubeconfig to use the new cluster
aws eks update-kubeconfig --region ap-southeast-2 --name B2B
# Verify nodes and clusters
kubectl get nodes
# Install Helm (on Amazon Linux2)
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version
# Cleanup resources (if needed)


