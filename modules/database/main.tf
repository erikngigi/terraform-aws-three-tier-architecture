resource "aws_db_instance" "mysql" {
  identifier              = "${var.project_name}-mysql-rds"
  engine                  = var.rds_engine
  engine_version          = var.rds_engine_version
  instance_class          = var.rds_instance_class
  allocated_storage       = var.allocated_storage
  username                = var.rds_username
  password                = var.rds_password
  db_subnet_group_name    = var.mysql_rds_subnet_group
  vpc_security_group_ids  = [var.mysql_rds_security_group]
  skip_final_snapshot     = true
  publicly_accessible     = false
  deletion_protection     = false
  backup_retention_period = 7
  backup_window           = "03:00-04:00"

  tags = {
    Name = "${var.project_name}-mysql-rds"
  }
}

resource "aws_db_instance" "mysql_replica" {
  replicate_source_db    = aws_db_instance.mysql.arn
  identifier             = "${var.project_name}-mysql-rds-replica"
  instance_class         = var.rds_instance_class
  db_subnet_group_name   = var.mysql_rds_subnet_group
  vpc_security_group_ids = [var.mysql_rds_security_group]
  skip_final_snapshot    = true
  publicly_accessible    = false
  deletion_protection    = false
}
