module "network" {
  source                    = "./modules/network"
  vpc_cidr_block            = var.vpc_cidr_block
  vpc_cidr_block_name       = var.vpc_cidr_block_name
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_subnet_cidrs      = var.private_subnet_cidrs
  public_subnet_cidrs_name  = var.public_subnet_cidrs_name
  private_subnet_cidrs_name = var.private_subnet_cidrs_name
  azs                       = var.azs
  igw_name                  = var.igw_name
  irt_name                  = var.irt_name
}

module "security" {
  source           = "./modules/security"
  ssh_pub_key      = var.ssh_pub_key
  ssh_pub_key_name = var.ssh_pub_key_name
  sg_name          = var.sg_name
  sg_description   = var.sg_description
  eg_rules         = var.eg_rules
  ig_rules         = var.ig_rules
  vpc_id           = module.network.vpc_id
}

module "instance" {
  source             = "./modules/instances"
  ami_name_pattern   = var.ami_name_pattern
  ami_virtualization = var.ami_virtualization
  ami_owner_id       = var.ami_owner_id
  ami_type           = var.ami_type
  ec2_name           = var.ec2_name
  pub_subnet_id      = module.network.public_subnet_id
  sg_id              = module.security.sg
  key_pair           = module.security.key_pair
}
