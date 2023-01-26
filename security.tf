resource "aws_security_group" "wp_db_client_sg" {
  name        = "WP Database Client SG"
  description = "Used as source for WP Database SG"
  vpc_id      = aws_vpc.wordpress-workshop.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "WP Database Client SG"
    }
  )
}

resource "aws_security_group" "wp_db_sg" {
  name        = "WP Database SG"
  description = "Allows inbound traffic from application servers to RDS"
  vpc_id      = aws_vpc.wordpress-workshop.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.wp_db_client_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "WP Database SG"
    }
  )
}

resource "aws_security_group" "wp_efs_client_sg" {
  name        = "WP EFS Client SG"
  description = "Used as source for WP EFS SG"
  vpc_id      = aws_vpc.wordpress-workshop.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "WP EFS Client SG"
    }
  )
}

resource "aws_security_group" "wp_efs_sg" {
  name        = "WP EFS SG"
  description = "Allows inbound traffic from application servers to EFS"
  vpc_id      = aws_vpc.wordpress-workshop.id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.wp_efs_client_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "WP EFS SG"
    }
  )
}

resource "aws_security_group" "bastion_sg" {
  name        = "Bastion SG"
  description = "Bastion host SG"
  vpc_id      = aws_vpc.wordpress-workshop.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "Bastion SG"
    }
  )
}

resource "aws_security_group" "bastion_sg_inbound" {
  name        = "Bastion SG inbound"
  description = "Allows 22 from bastion"
  vpc_id      = aws_vpc.wordpress-workshop.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "Bastion SG inbound"
    }
  )
}

resource "aws_security_group" "alb_sg" {
  name        = "ALB SG"
  description = "Allows 80 to ALB"
  vpc_id      = aws_vpc.wordpress-workshop.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.common_tags,
    {
      Name = "ALB SG"
    }
  )
}