module "network" {
  source       = "./modules/network"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

module "security" {
  source            = "./modules/security"
  project_name      = var.project_name
  ssh_pub_key       = var.ssh_pub_key
  ec2_ingress       = var.ec2_ingress
  ec2_egress        = var.ec2_egress
  mysql_rds_ingress = var.mysql_rds_ingress
  mysql_rds_egress  = var.mysql_rds_egress
  vpc_id            = module.network.vpc_id
}

module "instance" {
  source             = "./modules/instances"
  project_name       = var.project_name
  ami_name_pattern   = var.ami_name_pattern
  ami_virtualization = var.ami_virtualization
  ami_owner_id       = var.ami_owner_id
  ami_type           = var.ami_type
  ec2_sg             = module.security.ec2_sg
  ec2_ssh_key        = module.security.ec2_ssh_key
  public_subnet      = module.network.public_subnet
}

module "database" {
  source                   = "./modules/database"
  project_name             = var.project_name
  rds_engine               = var.rds_engine
  rds_engine_version       = var.rds_engine_version
  rds_instance_class       = var.rds_instance_class
  allocated_storage        = var.allocated_storage
  rds_username             = var.rds_username
  rds_password             = var.rds_password
  mysql_rds_security_group = module.security.mysql_rds_sg
  mysql_rds_subnet_group   = module.network.mysql_rds_subnet
}
