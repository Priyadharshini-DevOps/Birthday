#############################################################
# DB Subnet Group
#############################################################

resource "aws_db_subnet_group" "birthday" {
  name = "${var.project_name}-db-subnet-group"

  subnet_ids = [
    aws_subnet.private1.id,
    aws_subnet.private2.id
  ]

  tags = {
    Name = "${var.project_name}-db-subnet-group"
  }
}

#############################################################
# Parameter Group
#############################################################

resource "aws_db_parameter_group" "mysql" {

  name   = "${var.project_name}-mysql-parameter-group"
  family = "mysql8.0"

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }

  tags = {
    Name = "${var.project_name}-mysql-parameter-group"
  }

}

#############################################################
# RDS MySQL Instance
#############################################################

resource "aws_db_instance" "birthday_db" {

  identifier = "${var.project_name}-mysql"

  engine         = "mysql"
  engine_version = "8.0"

  instance_class = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  port = 3306

  multi_az = false

  publicly_accessible = true

  db_subnet_group_name = aws_db_subnet_group.birthday.name

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  parameter_group_name = aws_db_parameter_group.mysql.name

  backup_retention_period = 7

  backup_window = "03:00-04:00"

  maintenance_window = "Sun:04:00-Sun:05:00"

  skip_final_snapshot = true

  deletion_protection = false

  auto_minor_version_upgrade = true

  apply_immediately = true

  tags = {

    Name = "${var.project_name}-mysql"

  }

}