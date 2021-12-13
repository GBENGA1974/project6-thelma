# PROJECT6 RDS 
# aws_db_instance

resource "aws_db_instance" "RDS-thelma" {
  allocated_storage    = 12
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "thelmadb"
  username             = "project6"
  password             = "Emmanuel1974"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.thelma-db-group.name
}


# db_subnet group

resource "aws_db_subnet_group" "thelma-db-group" {
  name       = "thelma-db1"
  subnet_ids = [aws_subnet.thelma-Priv1-SUB3.id, aws_subnet.thelma-Priv2-SUB4.id]

  tags = {
    Name = "My DB PRIV-subnet group"
  }
}

# SECURITY GROUP FOR DATABASE instance

resource "aws_security_group" "thelma-db-secgrp" {
  name              = "thelma-db_sec-group"
  description       = "Allow mysql inbound traffic"
  vpc_id            = aws_vpc.thelma-VPC.id

}

resource "aws_security_group_rule" "thelma-inbound" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.thelma-db-secgrp.id
}

resource "aws_security_group_rule" "thelma-outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.thelma-db-secgrp.id
}