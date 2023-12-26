# Description: This module creates IAM role for pod identity

data "aws_iam_policy_document" "assume_role_pod_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.idp.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:app:app-service-account"]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.idp.url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.idp.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "pod_identity_role" {
  name               = "iamr-${var.env}-${var.eks_cluster_name}-pod-identity-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_pod_policy.json
}

resource "aws_iam_role_policy_attachment" "s3_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = aws_iam_role.pod_identity_role.name
}