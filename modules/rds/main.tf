
resource "aws_db_subnet_group" "this" {
  name       = "terra-db-subnet-group"
  subnet_ids = var.db_subnet_ids
  tags = {

    Name = "terra-db-subnet-group"

  }
}

resource "aws_db_instance" "this" {
  identifier           = "terra-mysql"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp3"
  username             = "admin"
  password             = "Password123"
  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [
    var.db_security_group_id
  ]
  publicly_accessible = false
  multi_az            = false
  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Name = "terra-mysql"
  }
}
