resource "aws_db_instance" "mysql" {
  identifier             = "${var.project_name}-mysql-rds"
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  instance_class         = var.rds_instance_class
  allocated_storage      = var.allocated_storage
  username               = var.rds_username
  password               = var.rds_password
  db_subnet_group_name   = var.mysql_rds_subnet_group
  vpc_security_group_ids = [var.mysql_rds_security_group]
  skip_final_snapshot    = true
  publicly_accessible    = false
  deletion_protection    = false

  tags = {
    Name = "${var.project_name}-mysql-rds"
  }
}
