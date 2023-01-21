resource "aws_db_subnet_group" "aurora_wordpress" {
  subnet_ids = [aws_subnet.data_subnet_a.id, aws_subnet.data_subnet_b.id]

  tags = merge(
    var.common_tags,
    {
      Name = "Aurora-Wordpress"
    }
  )
}

resource "aws_rds_cluster" "db" {
  cluster_identifier = "wordpress-workshop"
  engine = "aurora"
  engine_version = "5.6.10a"
  db_subnet_group_name = aws_db_subnet_group.aurora_wordpress.name
  # availability_zones = ["us-east-1a", "us-east-1b"]
  master_username         = "wpadmin"
  master_password         = "qwertyui"
  # db_cluster_instance_class = "db.r5.large"
  vpc_security_group_ids = [aws_security_group.wp_db_sg.id]
  port = "3306"
  database_name = "wordpress"
  db_cluster_parameter_group_name = "default.aurora5.6"
  skip_final_snapshot = true

  tags = merge(
    var.common_tags,
    {
      Name = "Aurora-DB"
    }
  )
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  cluster_identifier = aws_rds_cluster.db.id
  instance_class     = "db.r5.large"
  engine             = aws_rds_cluster.db.engine
  engine_version     = aws_rds_cluster.db.engine_version
  db_subnet_group_name = aws_db_subnet_group.aurora_wordpress.name
  tags = merge(
    var.common_tags,
    {
      Name = "Aurora-Wordpress-instance-${count.index+1}"
    }
  )
}

