# Terraform EKS Module

This repository contains Terraform code for provisioning an Amazon Elastic Kubernetes Service (EKS) cluster.

## Prerequisites

Before you can use this Terraform module, make sure you have the following prerequisites installed:

- Terraform (version 1.5.7)
- kubectl (version 1.28.4)

⚠️ NOTE: Since there is no remote backend configured for this module in this revision, deployment to all environment is supposed to be done on a single dedicated machine in order for terraform to keep track of the deployment states.

## Usage

To use this Terraform module, follow these steps:

1. Clone this repository to your local machine.
2. Open `terraform` directory
3. Create terraform workspaces for the environments (dev, stage, prod), e.g. `terraform workspace new dev`
4. Initialize the Terraform working directory by running `terraform init`.
5. Switch to the desired environment, e.g by running `terraform workspace select dev` 
5. Review the planned changes by running `terraform plan`.
6. Apply the changes by running `terraform apply`.
7. Once the cluster is provisioned, it should be added to the local context, e.g. `aws eks update-kubeconfig --region us-east-1 --name eks-x-eks-cluster --alias eks-x-eks-cluster`
8. Now it can be used by using the `kubectl` command.

NOTE: Please make sure there's proper AWS profile name is set in `backend.tf` and `provider.tf` files in order for terraform to proceed.

## Service deployment

To deploy k8s resources (application), follow these steps:
1. Switch k8s context to the newly deployed cluster 
2. Run `kubectl apply -f manifests/namespace.yaml` to deploy `app` namespace
3. Run `kubectl apply -f manifests/serviceaccount.yaml` to deploy `service account` resource
4. Run `kubectl apply -f manifests/pod.yaml` to deploy the application

More details about the application can be found here: https://github.com/sindar225/eks_terraform_module/blob/master/manifests/README.MD

## Further development
The deployment process can be further enhanced by introducing helm charts which will make deployment a lot easier, save time, will help to keep track of the changes, allow templating and more. 

### Secrets management 
There's multiple ways of implementing secrets management in AWS+EKS. Here we consider some of them.

#### Secrets-store-csi-driver 
Since Amazon Cloud provides a sheer variety of services, one of the preferrable options might be using AWS Secrets Store + secrets-store-csi-driver (secrets controller for k8s). 

**Pros**
- Use of AWS native services, e.g. AWS Secrets manager
- No need for self-managed or self-hosted solution
- Failover secrets supported
- Different ways of usage: as environment variable, as mounted volume or as k8s secret entity

**Cons**
- Slightly complicated initial setup and support
- More resources is required compared to the following option
- Troubleshooting might get complicated

#### Sealed Secrets
Another option would be to use Bitnami Sealed Secrets that offers a solution which is safe to store even inside a public repository. 

**Pros**
- Less complicated setup in comparison with the first option
- Secrets can be stored alongside the code / config
- K8s secrets are created automatically, no need for a real pod to consume them
- k8s secret is updated everytime a SeledSecret is updated
- Less resources is required for the controller

**Cons**
- Poor support from helm, might be a problem with complex charts

_Note: That option seems to be a pretty decent one provided that application deployment is coded in k8s manifests. Alternatibely if helm charts are used some additional work might be required to squeeze in the `encrypt` step_

#### CI/CD Tool secrets store
If CI/CD tools is used in the invironment (Jenkins, Github Actions etc), the secrets might be stored in those tools' credentials store.

**Pros**
- Secrets are removed from the code and stored within CI/CD tools

**Cons**
- CI/CD tool is a must
- If self-hosted solution, a way to saturate those secrets must be considered (which involves operational effort)

#### HashiCorp Vault / Doppler 
There's other solutions like HashiCorp Vault or Doppler, however I wouldn't consider them appripriate simply because they will put additional overhead for operational support and most probably add to costs, as free usage is tightly limited to the number of users or secrets. 

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.
