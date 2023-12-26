# Description: This file contains the configuration for the EKS Node Group.

resource "aws_eks_node_group" "node-group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "ng-${var.env}-${var.eks_cluster_name}"
  node_role_arn   = aws_iam_role.node_group_role.arn
  subnet_ids      = data.aws_subnets.subnets.ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.desired_size
    min_size     = var.desired_size
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.nodegroup-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.nodegroup-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.nodegroup-AmazonEC2ContainerRegistryReadOnly,
  ]
}