module "eks_network" {
  source       = "./modules/network"
  cidr_block   = var.cidr_block
  project_name = var.project_name
  tags         = var.tags
}

module "eks_cluster" {
  source           = "./modules/cluster"
  project_name     = var.project_name
  tags             = var.tags
  public_subnet_1a = module.eks_network.subnet_pub_1a
  public_subnet_1b = module.eks_network.subnet_pub_1b
}

module "eks_managed_node_group" {
  source            = "./modules/managed-node-group"
  project_name      = var.project_name
  tags              = var.tags
  cluster_name      = module.eks_cluster.cluster_name
  subnet_private_1a = module.eks_network.subnet_priv_1a
  subnet_private_1b = module.eks_network.subnet_priv_1b
}

module "eks_add_ons" {
  source       = "./modules/add-ons"
  project_name = var.project_name
  tags         = var.tags
  oidc         = module.eks_cluster.oidc
  cluster_name = module.eks_cluster.cluster_name
}

module "eks_ec2" {
  source         = "./modules/ec2"
  project_name   = var.project_name
  tags           = var.tags
  vpc            = module.eks_network.vpc
  public_subnet  = module.eks_network.subnet_pub_1a
  private_subnet = module.eks_network.subnet_priv_1a
  cluster_sg     = module.eks_cluster.cluster_sg
}