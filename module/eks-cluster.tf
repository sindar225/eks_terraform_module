# Description: This file contains the terraform configuration to create an EKS cluster.

resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-${var.env}-${var.eks_cluster_name}"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.eks_cluster_version

  vpc_config {
    subnet_ids = data.aws_subnets.subnets.ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_role-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cluster_role-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.nodegroup-AmazonEKS_CNI_Policy,
  ]
}
