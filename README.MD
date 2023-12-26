# Terraform EKS Module

This repository contains Terraform code for provisioning an Amazon Elastic Kubernetes Service (EKS) cluster.

## Prerequisites

Before you can use this Terraform module, make sure you have the following prerequisites installed:

- Terraform (version 1.5.7)
- kubectl (version 1.28.4)

## Usage

To use this Terraform module, follow these steps:

1. Clone this repository to your local machine.
2. Open `terraform` directory
3. Update the variables in the `variables.tf` file to match your desired configuration.
4. Initialize the Terraform working directory by running `terraform init`.
5. Review the planned changes by running `terraform plan`.
6. Apply the changes by running `terraform apply`.
7. Once the cluster is provisioned, you can access it using the `kubectl` command.

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
Since Amazon Cloud provides a sheer variety of services, I would suggest using AWS Secrets Store + secrets-store-csi-driver (secrets controller for k8s). This would allow to safely store secrets as well as using AWS native services without a need to use third-party software or self-managed solutions. I find this solution the most suitable in terms of operations support and safety.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## License

This repository is licensed under the [MIT License](LICENSE).
