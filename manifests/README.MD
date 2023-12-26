# Sample application aws-cli 

This is a sample application that is intended to show the deployment process on EKS cluster. The application itself is a command-line utility `aws-cli` that is used to test permissions to s3 bucket. Upon deployment the application will be granted the permissions through a resource called `service account`.

# Application Deployment with kubectl

This repository contains Kubernetes manifests for deploying a containerized application using kubectl.

## Prerequisites

Before deploying the application, make sure you have the following prerequisites:

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/): Installed and configured to connect to your Kubernetes cluster.

⚠️ IMPORTANT: Please update <AWS_ACCOUNT_ID> and <ENV> in serviceaccount.yaml accordingly before deploying.

## Deployment

To deploy the application, follow these steps:

1. Open a terminal or command prompt and navigate to this directory.

2. Run the following commands to deploy the application:

    ```shell
    kubectl apply -f namespace.yaml
    kubectl apply -f serviceaccount.yaml
    kubectl apply -f pod.yaml
    ```

    NOTE: This is the demo version where developer has to deploy required k8s resources themselves. It will be fixed and automated in the future releases.

3. Wait for the deployment to complete. You can check the status of the pod using the following command:

    ```shell
    kubectl get pod
    ```

    The output will show the status of pods.

4. After the deployement has finished, you can test the permissions by running the following command:

    ```shell
    kubectl exec aws-cli-pod -n app -- aws s3 ls --region us-east-1
    ```

    The result will be a list of s3 bucket in the current AWS account.

> Note: Make sure to customize the pod manifests file (or make use of `deployments` resource) according to your application's requirements before deploying.

For more information on using kubectl and deploying applications to Kubernetes, refer to the [official Kubernetes documentation](https://kubernetes.io/docs/).
