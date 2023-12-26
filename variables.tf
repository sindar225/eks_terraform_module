# The environment to deploy the EKS cluster into (abbreviation of the environment name, e.g. "x" for "x-dev")
variable "env" {
  default = "x"
}

# The name of the EKS cluster.
variable "eks_cluster_name" {
  default = "eks-cluster"
}

# The desired Kubernetes version for the EKS cluster.
variable "eks_cluster_version" {
  default = "1.27"
}

# A map of EKS cluster addons to enable.
variable "eks_cluster_addons" {
  default = {
    coredns    = true
    kube-proxy = true
    vpc-cni    = true
  }
}

# The desired number of worker nodes in the node group.
variable "desired_size" {
  default = 2
}