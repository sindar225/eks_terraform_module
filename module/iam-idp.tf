# Description: This file creates the IAM role for the EKS cluster to use to authenticate with the OIDC provider.

resource "aws_iam_openid_connect_provider" "idp" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.cert.certificates[0].sha1_fingerprint]
  url             = data.tls_certificate.cert.url
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.idp.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.idp.arn]
      type        = "Federated"
    }
  }
}

# Create the IAM role for the EKS cluster to use to authenticate with the OIDC provider
resource "aws_iam_role" "cluster_sa_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = "iamr-${var.env}-${var.eks_cluster_name}-sa-role"
}

# Attach the Amazon EKS worker node IAM role policy to the role
resource "aws_iam_role_policy_attachment" "cni_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.cluster_sa_role.name
}
