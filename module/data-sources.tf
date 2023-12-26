# Description: This file contains the data sources for the module

# The certificate data source is used to get the OIDC issuer URL
data "tls_certificate" "cert" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "vpc-${var.env}-app-us-east-1"
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:Name"
    values = ["sn-${var.env}-eks-priv-a", "sn-${var.env}-eks-priv-b", "sn-${var.env}-eks-priv-c"]
  }
}
