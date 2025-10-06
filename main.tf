module "network" {
  source            = "./modules/network"
  project_name      = var.project_name
  vpc_cidr          = var.vpc_cidr
  ec2_sg            = module.security.ec2_sg
  target_alb_port   = var.target_alb_port
  ec2_instance_id_1 = module.instance.ec2_instance_id_1
  ec2_instance_id_2 = module.instance.ec2_instance_id_2
}

module "security" {
  source                = "./modules/security"
  project_name          = var.project_name
  ssh_pub_key           = var.ssh_pub_key
  ec2_ingress           = var.ec2_ingress
  ec2_egress            = var.ec2_egress
  mysql_rds_ingress     = var.mysql_rds_ingress
  mysql_rds_egress      = var.mysql_rds_egress
  vpc_id                = module.network.vpc_id
  ec2_config_bucket_arn = module.storage.ec2_config_bucket_arn
  efs_ingress           = var.efs_ingress
  efs_egress            = var.efs_egress
}

module "instance" {
  source               = "./modules/instances"
  project_name         = var.project_name
  ami_name_pattern     = var.ami_name_pattern
  ami_virtualization   = var.ami_virtualization
  ami_owner_id         = var.ami_owner_id
  ami_type             = var.ami_type
  ec2_private_subnet_1 = module.network.ec2_private_subnet_1
  ec2_private_subnet_2 = module.network.ec2_private_subnet_2
  ec2_sg               = module.security.ec2_sg
  ec2_ssm_profile      = module.security.ec2_ssm_profile
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

module "storage" {
  source               = "./modules/storage"
  project_name         = var.project_name
  efs_private_subnet_1 = module.network.efs_private_subnet_1
  efs_private_subnet_2 = module.network.efs_private_subnet_2
  efs_security_group   = module.security.efs_sg
}
