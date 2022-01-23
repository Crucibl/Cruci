resource "aws_db_subnet_group" "calibrate_subnet_group" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
}

resource "aws_db_instance" "calibrate" {
  identifier              = "calibrate-db"
  name                    = var.rds_db_name
  username                = var.rds_username
  password                = var.rds_password
  port                    = "5432"
  engine                  = "postgres"
  engine_version          = "12.3"
  instance_class          = var.rds_instance_class
  allocated_storage       = "20"
  storage_encrypted       = false
  vpc_security_group_ids  = [aws_security_group.rds.id]
  db_subnet_group_name    = aws_db_subnet_group.calibrate_subnet_group.name
  multi_az                = false
  storage_type            = "gp2"
  publicly_accessible     = false
  backup_retention_period = 7
  skip_final_snapshot     = true
}

# Update the rds endpoint for the calibrate_app django settings
resource "null_resource" "rds_endpoint" {
  provisioner "local-exec" {
    working_dir = "../../calibrate_app/"
    interpreter = ["/usr/bin/bash"]
    command     = <<-EOT
    exec "sed -e s/RDS/${aws_db_instance.calibrate.name}/g ./Dockerfile.tpl > ./Dockerfile.tmp"
    exec "sed -i s/Password/$(aws_db_instance.calibrate.password)/g ./Dockerfile.tmp"
    exec "sed -i s/Username/$(aws_db_instance.calibrate.username)/g ./Dockerfile.tmp"
    exec "sed -i s/Hostname/$(aws_db_instance.calibrate.endpoint)/g ./Dockerfile.tmp"
    exec "sed -i s/Port/$(aws_db_instance.calibrate.port)/g ./Dockerfile.tmp"
    exec "mv ./Dockerfile.tmp ./Dockerfile"
    EOT
  }
  depend_on = [aws_db_instance.calibrate]
}
