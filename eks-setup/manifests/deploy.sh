#download the iam policy
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.7.2/docs/install/iam_policy.json

#create a iam policy
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json

#The running ALB controller requires access to AWS resources, necessitating integration with IAM (Identity and Access Management).
eksctl utils associate-iam-oidc-provider --cluster eks-cluster --region=us-east-1 --approve

#Then create a role with the below command
eksctl create iamserviceaccount \
  --cluster=eks-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::<AWS-Accid#>:policy/AWSLoadBalancerControllerIAMPolicy \
  --region=us-east-1 \
  --override-existing-serviceaccounts \
  --approve 

helm repo add eks https://aws.github.io/eks-charts
helpm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=eks-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=us-east-1 \
  --set vpcId=vpc-09dadd9e423c04f91

# verify
kubectl get deployment -n kube-system aws-load-balancer-controller -w
kubectl describe deployment aws-load-balancer-controller
kubectl get pods -A

#deploy 2048 game
curl -o https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/examples/2048/2048_full.yaml
kubectl apply -f 2048_full.yaml

#if you get the ingress, you can see the address
kubectl describe svc -n game-2048
kubectl get ingress -n game-2048
kubectl describe ingress ingress-2048 -n game-2048
