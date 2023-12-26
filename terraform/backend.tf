terraform {
  backend "s3" {
    bucket  = "S3_BUCKET_NAME"
    key     = "us-east-1/eks-cluster/terraform.tfstate"
    region  = "us-east-1"
    profile = ""
  }
}
