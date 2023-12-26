module "eks_cluster" {
 
  source = "./module"

  env                 = var.env
  eks_cluster_name    = var.eks_cluster_name
  eks_cluster_version = var.eks_cluster_version
  eks_cluster_addons  = var.eks_cluster_addons
  desired_size        = var.desired_size
}
