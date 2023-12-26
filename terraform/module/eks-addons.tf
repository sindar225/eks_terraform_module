# Description: This file contains the terraform code to create the EKS addons.

# Reference: https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
resource "aws_eks_addon" "vpc-cni" {
  count = var.eks_cluster_addons["vpc-cni"] == true ? 1 : 0

  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "vpc-cni"

  service_account_role_arn = aws_iam_role.cluster_sa_role.arn

  depends_on = [
    aws_eks_cluster.eks_cluster,
  ]
}

# Reference: https://docs.aws.amazon.com/eks/latest/userguide/kube-proxy.html
resource "aws_eks_addon" "kube-proxy" {
  count = var.eks_cluster_addons["kube-proxy"] == true ? 1 : 0

  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "kube-proxy"

  depends_on = [
    aws_eks_cluster.eks_cluster,
  ]
}

# Reference: https://docs.aws.amazon.com/eks/latest/userguide/coredns.html
resource "aws_eks_addon" "coredns" {
  count = var.eks_cluster_addons["coredns"] == true ? 1 : 0

  cluster_name = aws_eks_cluster.eks_cluster.name
  addon_name   = "coredns"

  depends_on = [
    aws_eks_cluster.eks_cluster,
  ]
}
