#The running ALB controller requires access to AWS resources, necessitating integration with IAM (Identity and Access Management).
eksctl utils associate-iam-oidc-provider --cluster test-cluster --region=us-east-1 --approve

#create a iam policy
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document iam_policy.json

#Then create a role with the below command
eksctl create iamserviceaccount \
  --cluster=eks-cluster \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn=arn:aws:iam::801211930675:policy/AWSLoadBalancerControllerIAMPolicy \
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

#if you get the ingress, you can see the address
kubectl get ingress -n game-2048-1
